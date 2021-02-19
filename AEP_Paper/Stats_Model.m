%% Plot AEPs (empirical) for paper
% Based on ../AEP_Model_Stats_narrow.m
% Same as Stats_AEP.m but for model, rather than data
% - loads models 
% - 2 x 2 ANOVA (Tone(contra/ipsi) x Hemi (left/right))
%   - Slope (pre and post N1)
%   - N1 amplitude and latency
%   - reports output in cmd
% plotting available but commented out

clear
modeldata_dir='C:\Users\ckohl\hnn_out\data\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load models
% put it into Data structure just like data in AEP_statistics.m
Partic=1:10;
Tone_side={'RE','LE'};
Hemi={'rig','lef'};
Categ={'contra','ipsi'};
Data=struct();
for hemi=1:length(Hemi)
    for tone_side=1:length(Tone_side)
        if hemi==1 %R
            if tone_side==1 %R
                param_name='R_Ipsi';
            else %L
                param_name='R_Contra';
            end
        else %L
            if tone_side==1 %R
                param_name='L_Contra';
            else %L
                param_name='L_Ipsi';
            end
        end

        %mean
        dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
        sim_time=dpl(:,1);
        sim_time=resample(sim_time,1000,1000/0.025);
        sim_trials=10;
        dpl_agg=dpl(:,2);%aggregate
        dpl_agg=resample(dpl_agg,1000,1000/0.025);
        Data.('AVE').(Tone_side{tone_side}).(Hemi{hemi})=dpl_agg(1:end-1,:);
        %trials
        dpl_agg_trials=nan(length(sim_time),sim_trials);
        for sim=1:sim_trials
            temp=load(strcat(modeldata_dir,'\',param_name,'\dpl_',num2str(sim-1),'.txt'));
            %downsample
            temp=resample(temp,1000,1000/0.025);
            sim_time=temp(1:end-1,1);
            dpl_agg_trials(:,sim)=temp(:,2);
            Data.(strcat('S',num2str(sim))).(Tone_side{tone_side}).(Hemi{hemi})=temp(1:end-1,2);
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOVA: N1 Slopes (pre and post)

for test=1:2 %pre and post
    Test={'Slope_Pre_Peak','Slope_Post_Peak'};

    Partic=1:10;
    Tone_side={'RE','LE'};
    Hemi={'rig','lef'};
    Categ={'contra','ipsi'};
    time=sim_time;

    %for ANOVA   
    within1=categorical([1 1 0 0])';
    within2=categorical([1 0 1 0])';
    within=table(within1,within2,'variablenames',{'Tone','Hemi'});

    %loop through time
    Main1_p=[];
    Main2_p=[];
    Interact_p=[];
    Main1_F=[];
    Main2_F=[];
    Interact_F=[];
    if test==1
        slope_window_pre=[70:90] ;
        [temp,slope_window_ind(1)]=min(abs(time-slope_window_pre(1)));
        [temp,slope_window_ind(2)]=min(abs(time-slope_window_pre(end)));

    elseif test==2
        slope_window_post=[110:130];
        [temp,slope_window_ind(1)]=min(abs(time-slope_window_post(1)));
        [temp,slope_window_ind(2)]=min(abs(time-slope_window_post(end)));
    end

    data=[];
    count=0;
    for tone_categ=1:length(Categ)
        for hemi=1:length(Hemi)
            if hemi==1%right hemi
                if tone_categ==1%contra
                    tone_side=2;%left tone
                else%ipsi
                    tone_side=1;%right
                end
            else%left hemi
                 if tone_categ==1%contra
                    tone_side=1;
                else%ipsi
                    tone_side=2;
                 end
            end
            count=count+1;       
            for partic=1:length(Partic)
                dataoi=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi})(slope_window_ind(1):slope_window_ind(2));
                P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi,1);
                data(partic,count)=P(1);
            end
        end
    end
    keep_test_data=data;
    tab=array2table(data,'variablenames',{'Contra_hr' 'Contra_hl' 'Ipsi_hr' 'Ipsi_hl'});
    rm=fitrm(tab,'Contra_hr-Ipsi_hl ~1','WithinDesign',within);
    ranovatbl = ranova(rm,'withinmodel','Tone*Hemi');
    ranovatbl = ranova(rm,'withinmodel','Tone*Hemi');
    %     a(t,:)=[time(t),table2array(ranovatbl(5,5))];
    %effect size
    ranovatbl=table2array(ranovatbl);
    %effect size(partial eta squared= SSeffect/(SSeffect+SSerror))
    eta_tone = ranovatbl(3,1)/(ranovatbl(3,1) + ranovatbl(4,1));
    eta_hemi =  ranovatbl(5,1)/(ranovatbl(5,1) + ranovatbl(6,1));
    eta_int =  ranovatbl(7,1)/(ranovatbl(7,1) + ranovatbl(8,1));

    % print results:
    fprintf('%s:\n',Test{test})
    tabbi=table2array(tab);
    fprintf('Descriptives: Mean(SD)\n')
    fprintf('Left Hemi Contra:\t %2.2f (%2.2f)\n',mean(tabbi(:,2)),std(tabbi(:,2)))
    fprintf('Left Hemi Ipsi:\t\t %2.2f (%2.2f)\n',mean(tabbi(:,4)),std(tabbi(:,4)))
    fprintf('Right Hemi Contra:\t %2.2f (%2.2f)\n',mean(tabbi(:,1)),std(tabbi(:,1)))
    fprintf('Right Hemi Ipsi:\t %2.2f (%2.2f)\n',mean(tabbi(:,3)),std(tabbi(:,3))) 
    fprintf('ANOVA\n')
    fprintf('Tone:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n',ranovatbl(3,2),ranovatbl(4,2),ranovatbl(3,4),ranovatbl(3,5),eta_tone)
    fprintf('Hemi:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n',ranovatbl(5,2),ranovatbl(6,2),ranovatbl(5,4),ranovatbl(5,5),eta_hemi)
    fprintf('Inter:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n\n',ranovatbl(7,2),ranovatbl(8,2),ranovatbl(7,4),ranovatbl(7,5),eta_int)
    cd('C:\Users\ckohl\Desktop\Current\AEP\')
    save( strcat(Test{test},'_HNN'),'tab')

end

%% plotting not in loop
% Main1_p=(ranovatbl(3,5));
% Main2_p=(ranovatbl(5,5));
% Interact_p=(ranovatbl(7,5));
% Main1_F=(ranovatbl(3,4));
% Main2_F=(ranovatbl(5,4));
% Interact_F=(ranovatbl(7,4));
% 
% 
% %% PLOT
% 
% yrange=[-60 60];
% figure
% clf
% Categ={'contra','ipsi'};
% %plot first 4
% 
% for hemi=1:length(Hemi)
%     subplot(3,2,hemi)
%     count=0;
%     line=[];
%     for tone_categ=1:length(Categ)
%         count=count+1;
%         if tone_categ==1
%             colour='k';%[.625 0 0];
%         else
%             colour='r';%[0 .312 .625];
%         end
% 
%         if hemi==1%right hemi
%             if tone_categ==1;%contra
%                 tone_side=2;%left tone
%             else%ipsi
%                 tone_side=1;%right
%             end
%         else%left hemi
%              if tone_categ==1;%contra
%                 tone_side=1;
%             else%ipsi
%                 tone_side=2;
%              end
%         end
%             
%        
%         if hemi==1
%             linestyle='-';
%         else
%             linestyle=':';
%         end
%         
%         set(gca, 'YDir','reverse');
%         if count==1
%             ylabel('Amplitude (nAm)');
%         end
%         xlabel('Time (ms)');
%         hold on
%         title(strcat('Hemi: ', Hemi{hemi}(1)));
%         data_oi=[];
%         for partic=1:length(Partic)
%             data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
% %             plot(time,data)
%             data_oi(partic,:)=data;
%         end
%         line(count)=plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi})(1:end,:),'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%             %make standard error
%             SE_upper=[];
%             SE_lower=[];
%             for i=1:length(time)
%                 se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%                 SE_upper(i)=mean(data_oi(:,i))+se;
%                 SE_lower(i)=mean(data_oi(:,i))-se;
%             end
%             tempx=[time',fliplr(time')];
%             tempy=[SE_upper,fliplr(SE_lower)];
%             A=fill(tempx,tempy,'k');
%             A.EdgeColor='none';
%             A.FaceColor=colour;
%             A.FaceAlpha=.2;
%             pause(.1)
%         ylim(yrange)
%         xlim([0 250])
%     end
%     legend(line,Categ)
% end
% 
% 
% %plot big one withinteraction
% subplot(3,2,[5 6])
% hold on
% 
% 
% line=[];
% count=0;
% for tone_categ=1:length(Categ)
%     if tone_categ==1
%         colour='k';%[.625 0 0];
%     else
%         colour='r';%[0 .312 .625];
%     end
%     for hemi=1:length(Hemi)
% 
%         if hemi==1%right hemi
%             if tone_categ==1;%contra
%                 tone_side=2;%left tone
%             else%ipsi
%                 tone_side=1;%right
%             end
%         else%left hemi
%              if tone_categ==1;%contra
%                 tone_side=1;
%             else%ipsi
%                 tone_side=2;
%              end
%         end
%          
%         if hemi==1
%             linestyle='-';
%         else
%             linestyle=':';
%         end
%         count=count+1;
%         set(gca, 'YDir','reverse')
%         ylabel('Amplitude (nAm)')
%         xlabel('Time (ms)')
%         hold on
%         if Interact_p>.05
%             title('Interaction')
%         else
%             title(strcat('Tone Effect* - p = ',num2str(Interact_p)))
%         end        
%         data_oi=[];
%         for partic=1:length(Partic)
%             data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
% %             plot(time,data)
%             data_oi(partic,:)=data;
%         end
%         line(count)=plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%         dataoi=Data.AVE.(Tone_side{tone_side}).(Hemi{hemi});
%         if test==2
%             plot([mean(keep_test_data(:,count)),mean(keep_test_data(:,count))], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%         elseif test==3 | test==4
%             P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%             plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%         end
%             %make standard error
%             SE_upper=[];
%             SE_lower=[];
%             for i=1:length(time)
%                 se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%                 SE_upper(i)=mean(data_oi(:,i))+se;
%                 SE_lower(i)=mean(data_oi(:,i))-se;
%             end
%             tempx=[time',fliplr(time')];
%             tempy=[SE_upper,fliplr(SE_lower)];
%             A=fill(tempx,tempy,'k');
%             A.EdgeColor='none';
%             A.FaceColor=colour;
%             A.FaceAlpha=.2;
%             pause(.1)
%         ylim(yrange)
%         xlim([0 200])
%     end
% end
% set(gca, 'YDir','reverse')
% legend(line,{'Contra-hr' 'Contra-hl' 'Ipsi-hr' 'Ipsi-hl'})
% 
% 
% % plot main effects
% subplot(3,2,3)
% hold on
% if Main1_p>.05
%     title('Tone Effect');
% else
%     title(strcat('Tone Effect* - p = ',num2str(Main1_p)))
% end
% line=[];
% count=0;
% for tone_categ=1:length(Categ)
%     if tone_categ==1
%         colour='k';%[.625 0 0];
%     else
%         colour='r';%[0 .312 .625];
%     end
% 
%     count=count+1;
%     set(gca, 'YDir','reverse')
%     ylabel('Amplitude (nAm)')
%     hold on
%     data_oi=[];
%     for partic=1:length(Partic)
%         if tone_categ==1
%             data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{2});
%             data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{1});
%         else
%             data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{1});
%             data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{2});
%         end
% %             plot(time,data)
%         data_oi(partic,:)=mean([data1,data2],2);
%     end
%     if tone_categ==1
%         data_temp1=Data.AVE.(Tone_side{1}).(Hemi{2});
%         data_temp2=Data.AVE.(Tone_side{2}).(Hemi{1});
%     else
%         data_temp1=Data.AVE.(Tone_side{1}).(Hemi{1});
%         data_temp2=Data.AVE.(Tone_side{2}).(Hemi{2});
%     end
%     dataoi=mean([data_temp1,data_temp2],2);
%     line(count)=plot(time,dataoi,'Color',colour,'Linestyle','--','Linewidth',2);
%     if test==2
%         if tone_categ==1
%             temp=[1 2];
%         else
%             temp=[3,4];
%         end
%             plot([mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] ),mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] )], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     elseif test==3 | test==4
%         P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%         plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%     end
%     
%     %make standard error
%         SE_upper=[];
%         SE_lower=[];
%         for i=1:length(time)
%             se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%             SE_upper(i)=mean(data_oi(:,i))+se;
%             SE_lower(i)=mean(data_oi(:,i))-se;
%         end
%         tempx=[time',fliplr(time')];
%         tempy=[SE_upper,fliplr(SE_lower)];
%         A=fill(tempx,tempy,'k');
%         A.EdgeColor='none';
%         A.FaceColor=colour;
%         A.FaceAlpha=.2;
%         pause(.1)
%     ylim(yrange)
%     xlim([0 200])
% end
% % plot(time,Main1_abs*55,'ko')
% legend(line, Categ)
% 
% 
% subplot(3,2,4)
% hold on
% %effect
% 
% if Main2_p>.05
%     title('Hemi Effect');
% else
%     title(strcat('Hemi Effect* - p = ',num2str(Main2_p)))
% end
% line=[];
% count=0;
% for hemi=1:length(Hemi)
%     colour=[.2 .2 .2];
%     if hemi==1
%         linestyle='-';
%     else
%         linestyle=':';
%     end
%     count=count+1;
%     set(gca, 'YDir','reverse')
%     ylabel('Amplitude (nAm)')
%     hold on
% 
%     data_oi=[];
%     for partic=1:length(Partic)
%         data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{hemi});
%         data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{hemi});
% %             plot(time,data)
%         data_oi(partic,:)=mean([data1,data2],2);
%     end
%     data_temp1=Data.AVE.(Tone_side{1}).(Hemi{hemi});
%     data_temp2=Data.AVE.(Tone_side{2}).(Hemi{hemi});
%     dataoi=mean([data_temp1,data_temp2],2);
%     line(count)=plot(time,dataoi,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     if test==2
%         if hemi==1
%             temp=[1 3];
%         else
%             temp=[2,4];
%         end
%             plot([mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] ),mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] )], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     elseif test==3 | test==4
%         P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%         plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%     end
%         %make standard error
%         SE_upper=[];
%         SE_lower=[];
%         for i=1:length(time)
%             se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%             SE_upper(i)=mean(data_oi(:,i))+se;
%             SE_lower(i)=mean(data_oi(:,i))-se;
%         end
%         tempx=[time',fliplr(time')];
%         tempy=[SE_upper,fliplr(SE_lower)];
%         A=fill(tempx,tempy,'k');
%         A.EdgeColor='none';
%         A.FaceColor=colour;
%         A.FaceAlpha=.2;
%         pause(.1)
%     ylim(yrange)
%     xlim([0 200])
% end
% legend(line,{'Hemi r', 'Hemi l'})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOVA: N1 amplitude and latency

for test=1:2%am and lat
    Test={'Amp','Lat'};
    Peaks={'P1','N1','P2'};
    peak=2;

    Peak_avg=0; %if true, take avg of window around peak
    avg_window=10;

    Partic=1:10;
    Tone_side={'RE','LE'};
    Hemi={'rig','lef'};
    Categ={'contra','ipsi'};
    % time=linspace(-201.000005, 793.699980,207);
    peak_windows=[35 75;80 120; 130 210];

    %for ANOVA   
    within1=categorical([1 1 0 0])';
    within2=categorical([1 0 1 0])';
    within=table(within1,within2,'variablenames',{'Tone','Hemi'});

    %loop through time
    Main1_p=[];
    Main2_p=[];
    Interact_p=[];
    Main1_F=[];
    Main2_F=[];

    data=[];
    count=0;
    for tone_categ=1:length(Categ)
        for hemi=1:length(Hemi)
            if hemi==1%right hemi
                if tone_categ==1%contra
                    tone_side=2;%left tone
                else%ipsi
                    tone_side=1;%right
                end
            else%left hemi
                 if tone_categ==1%contra
                    tone_side=1;
                else%ipsi
                    tone_side=2;
                 end
            end
            count=count+1;       
            for partic=1:length(Partic)
                    % detect peak: P1
                    dataoi=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
                    timeoi=time>peak_windows(peak,1) & time<=peak_windows(peak,2);
                    if peak==2
                        [peak_amp,peak_i]=min(dataoi(timeoi));
                        if Peak_avg
                            peak_amp=mean(dataoi(peak_i+max(find(timeoi==1))-1-avg_window:peak_i+max(find(timeoi==1))-1+avg_window));
                        end
                    else
                        [peak_amp,peak_i]=min(dataoi(timeoi));
                    end
                    peak_lat=time(timeoi);
                    peak_lat=peak_lat(peak_i);
    %                 %plot
    %                 figure
    %                 plot(time,dataoi,'k')
    %                 hold on
    %                 plot(time(timeoi),dataoi(timeoi),'k','Linewidth',2)
    %                 plot(peak_lat,peak_amp,'ro','Linewidth',2)
                    if test==1%amp
                        data(partic,count)=peak_amp;
                    else
                        data(partic,count)=peak_lat;
                    end
            end
        end
    end
    keep_test_data=data;
    tab=array2table(data,'variablenames',{'Contra_hr' 'Contra_hl' 'Ipsi_hr' 'Ipsi_hl'});
    rm=fitrm(tab,'Contra_hr-Ipsi_hl ~1','WithinDesign',within);
    ranovatbl = ranova(rm,'withinmodel','Tone*Hemi');
    %     a(t,:)=[time(t),table2array(ranovatbl(5,5))];
    ranovatbl=table2array(ranovatbl);
    %effect size(partial eta squared= SSeffect/(SSeffect+SSerror))
    eta_tone = ranovatbl(3,1)/(ranovatbl(3,1) + ranovatbl(4,1));
    eta_hemi =  ranovatbl(5,1)/(ranovatbl(5,1) + ranovatbl(6,1));
    eta_int =  ranovatbl(7,1)/(ranovatbl(7,1) + ranovatbl(8,1));

      % print results:
    fprintf('%s %s:\n',Peaks{peak}, Test{test})
    tabbi=table2array(tab);
    fprintf('Descriptives: Mean(SD)\n')
    fprintf('Left Hemi Contra:\t %2.2f (%2.2f)\n',mean(tabbi(:,2)),std(tabbi(:,2)))
    fprintf('Left Hemi Ipsi:\t\t %2.2f (%2.2f)\n',mean(tabbi(:,4)),std(tabbi(:,4)))
    fprintf('Right Hemi Contra:\t %2.2f (%2.2f)\n',mean(tabbi(:,1)),std(tabbi(:,1)))
    fprintf('Right Hemi Ipsi:\t %2.2f (%2.2f)\n',mean(tabbi(:,3)),std(tabbi(:,3))) 
    fprintf('ANOVA\n')
    fprintf('Tone:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n',ranovatbl(3,2),ranovatbl(4,2),ranovatbl(3,4),ranovatbl(3,5),eta_tone)
    fprintf('Hemi:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n',ranovatbl(5,2),ranovatbl(6,2),ranovatbl(5,4),ranovatbl(5,5),eta_hemi)
    fprintf('Inter:\tF(%d,%d) = %5.2f p = %5.3f, n = %2.2f\n\n',ranovatbl(7,2),ranovatbl(8,2),ranovatbl(7,4),ranovatbl(7,5),eta_int)
    cd('C:\Users\ckohl\Desktop\Current\AEP\')
    save( strcat(Peaks{peak}, Test{test},'_HNN'),'tab')
end


%% plotting not in loop
% Main1_p=(ranovatbl(3,5));
% Main2_p=(ranovatbl(5,5));
% Interact_p=(ranovatbl(7,5));
% Main1_F=(ranovatbl(3,4));
% Main2_F=(ranovatbl(5,4));
% Interact_F=(ranovatbl(7,4));

% 
% 
% %% PLOT
% 
% yrange=[-60 60];
% figure
% clf
% Categ={'contra','ipsi'};
% %plot first 4
% 
% for hemi=1:length(Hemi)
%     subplot(3,2,hemi)
%     count=0;
%     line=[];
%     for tone_categ=1:length(Categ)
%         count=count+1;
%         if tone_categ==1
%             colour='k';%[.625 0 0];
%         else
%             colour='r';%[0 .312 .625];
%         end
% 
%         if hemi==1%right hemi
%             if tone_categ==1;%contra
%                 tone_side=2;%left tone
%             else%ipsi
%                 tone_side=1;%right
%             end
%         else%left hemi
%              if tone_categ==1;%contra
%                 tone_side=1;
%             else%ipsi
%                 tone_side=2;
%              end
%         end
%             
%        
%         if hemi==1
%             linestyle='-';
%         else
%             linestyle=':';
%         end
%         
%         set(gca, 'YDir','reverse');
%         if count==1
%             ylabel('Amplitude (nAm)');
%         end
%         xlabel('Time (ms)');
%         hold on
%         title(strcat('Hemi: ', Hemi{hemi}(1)));
%         data_oi=[];
%         for partic=1:length(Partic)
%             data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
% %             plot(time,data)
%             data_oi(partic,:)=data;
%         end
%         line(count)=plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%             %make standard error
%             SE_upper=[];
%             SE_lower=[];
%             for i=1:length(time)
%                 se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%                 SE_upper(i)=mean(data_oi(:,i))+se;
%                 SE_lower(i)=mean(data_oi(:,i))-se;
%             end
%             tempx=[time',fliplr(time')];
%             tempy=[SE_upper,fliplr(SE_lower)];
%             A=fill(tempx,tempy,'k');
%             A.EdgeColor='none';
%             A.FaceColor=colour;
%             A.FaceAlpha=.2;
%             pause(.1)
%         ylim(yrange)
%         xlim([0 200])
%     end
%     legend(line,Categ)
% end
% 
% 
% %plot big one withinteraction
% subplot(3,2,[5 6])
% hold on
% 
% 
% line=[];
% count=0;
% for tone_categ=1:length(Categ)
%     if tone_categ==1
%         colour='k';%[.625 0 0];
%     else
%         colour='r';%[0 .312 .625];
%     end
%     for hemi=1:length(Hemi)
% 
%         if hemi==1%right hemi
%             if tone_categ==1;%contra
%                 tone_side=2;%left tone
%             else%ipsi
%                 tone_side=1;%right
%             end
%         else%left hemi
%              if tone_categ==1;%contra
%                 tone_side=1;
%             else%ipsi
%                 tone_side=2;
%              end
%         end
%          
%         if hemi==1
%             linestyle='-';
%         else
%             linestyle=':';
%         end
%         count=count+1;
%         set(gca, 'YDir','reverse')
%         ylabel('Amplitude (nAm)')
%         xlabel('Time (ms)')
%         hold on
%         if Interact_p>.05
%             title('Interaction')
%         else
%             title(strcat('Tone Effect* - p = ',num2str(Interact_p)))
%         end        
%         data_oi=[];
%         for partic=1:length(Partic)
%             data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
% %             plot(time,data)
%             data_oi(partic,:)=data;
%         end
%         line(count)=plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%         dataoi=Data.AVE.(Tone_side{tone_side}).(Hemi{hemi});
%         if test==2
%             plot([mean(keep_test_data(:,count)),mean(keep_test_data(:,count))], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%         elseif test==3 | test==4
%             P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%             plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%         end
%             %make standard error
%             SE_upper=[];
%             SE_lower=[];
%             for i=1:length(time)
%                 se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%                 SE_upper(i)=mean(data_oi(:,i))+se;
%                 SE_lower(i)=mean(data_oi(:,i))-se;
%             end
%             tempx=[time',fliplr(time')];
%             tempy=[SE_upper,fliplr(SE_lower)];
%             A=fill(tempx,tempy,'k');
%             A.EdgeColor='none';
%             A.FaceColor=colour;
%             A.FaceAlpha=.2;
%             pause(.1)
%         ylim(yrange)
%         xlim([0 200])
%     end
% end
% set(gca, 'YDir','reverse')
% legend(line,{'Contra-hr' 'Contra-hl' 'Ipsi-hr' 'Ipsi-hl'})
% 
% 
% % plot main effects
% subplot(3,2,3)
% hold on
% if Main1_p>.05
%     title('Tone Effect');
% else
%     title(strcat('Tone Effect* - p = ',num2str(Main1_p)))
% end
% line=[];
% count=0;
% for tone_categ=1:length(Categ)
%     if tone_categ==1
%         colour='k';%[.625 0 0];
%     else
%         colour='r';%[0 .312 .625];
%     end
% 
%     count=count+1;
%     set(gca, 'YDir','reverse')
%     ylabel('Amplitude (nAm)')
%     hold on
%     data_oi=[];
%     for partic=1:length(Partic)
%         if tone_categ==1
%             data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{2});
%             data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{1});
%         else
%             data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{1});
%             data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{2});
%         end
% %             plot(time,data)
%         data_oi(partic,:)=mean([data1,data2],2);
%     end
%     if tone_categ==1
%         data_temp1=Data.AVE.(Tone_side{1}).(Hemi{2});
%         data_temp2=Data.AVE.(Tone_side{2}).(Hemi{1});
%     else
%         data_temp1=Data.AVE.(Tone_side{1}).(Hemi{1});
%         data_temp2=Data.AVE.(Tone_side{2}).(Hemi{2});
%     end
%     dataoi=mean([data_temp1,data_temp2],2);
%     line(count)=plot(time,dataoi,'Color',colour,'Linestyle','--','Linewidth',2);
%     if test==2
%         if tone_categ==1
%             temp=[1 2];
%         else
%             temp=[3,4];
%         end
%             plot([mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] ),mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] )], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     elseif test==3 | test==4
%         P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%         plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%     end
%     
%     %make standard error
%         SE_upper=[];
%         SE_lower=[];
%         for i=1:length(time)
%             se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%             SE_upper(i)=mean(data_oi(:,i))+se;
%             SE_lower(i)=mean(data_oi(:,i))-se;
%         end
%         tempx=[time',fliplr(time')];
%         tempy=[SE_upper,fliplr(SE_lower)];
%         A=fill(tempx,tempy,'k');
%         A.EdgeColor='none';
%         A.FaceColor=colour;
%         A.FaceAlpha=.2;
%         pause(.1)
%     ylim(yrange)
%     xlim([0 200])
% end
% % plot(time,Main1_abs*55,'ko')
% legend(line, Categ)
% 
% 
% subplot(3,2,4)
% hold on
% %effect
% 
% if Main2_p>.05
%     title('Hemi Effect');
% else
%     title(strcat('Hemi Effect* - p = ',num2str(Main2_p)))
% end
% line=[];
% count=0;
% for hemi=1:length(Hemi)
%     colour=[.2 .2 .2];
%     if hemi==1
%         linestyle='-';
%     else
%         linestyle=':';
%     end
%     count=count+1;
%     set(gca, 'YDir','reverse')
%     ylabel('Amplitude (nAm)')
%     hold on
% 
%     data_oi=[];
%     for partic=1:length(Partic)
%         data1=Data.(strcat('S',num2str(partic))).(Tone_side{1}).(Hemi{hemi});
%         data2=Data.(strcat('S',num2str(partic))).(Tone_side{2}).(Hemi{hemi});
% %             plot(time,data)
%         data_oi(partic,:)=mean([data1,data2],2);
%     end
%     data_temp1=Data.AVE.(Tone_side{1}).(Hemi{hemi});
%     data_temp2=Data.AVE.(Tone_side{2}).(Hemi{hemi});
%     dataoi=mean([data_temp1,data_temp2],2);
%     line(count)=plot(time,dataoi,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     if test==2
%         if hemi==1
%             temp=[1 3];
%         else
%             temp=[2,4];
%         end
%             plot([mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] ),mean([keep_test_data(:,temp(1));keep_test_data(:,temp(2))] )], yrange,'Color',colour,'Linestyle',linestyle,'Linewidth',2);
%     elseif test==3 | test==4
%         P=polyfit(time(slope_window_ind(1):slope_window_ind(2))',dataoi(slope_window_ind(1):slope_window_ind(2)),1);
%         plot(time(slope_window_ind(1):slope_window_ind(2)), polyval(P,time(slope_window_ind(1):slope_window_ind(2))),'Color',colour,'Linewidth',5);
%     end
%         %make standard error
%         SE_upper=[];
%         SE_lower=[];
%         for i=1:length(time)
%             se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
%             SE_upper(i)=mean(data_oi(:,i))+se;
%             SE_lower(i)=mean(data_oi(:,i))-se;
%         end
%         tempx=[time',fliplr(time')];
%         tempy=[SE_upper,fliplr(SE_lower)];
%         A=fill(tempx,tempy,'k');
%         A.EdgeColor='none';
%         A.FaceColor=colour;
%         A.FaceAlpha=.2;
%         pause(.1)
%     ylim(yrange)
%     xlim([0 200])
% end
% legend(line,{'Hemi r', 'Hemi l'})




