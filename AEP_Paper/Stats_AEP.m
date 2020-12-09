%% Plot AEPs (empirical) for paper
% Based on ../AEP_Stats_narrow.m
% - loads Tiina's MEG data 
% - 2 x 2 ANOVA (Tone(contra/ipsi) x Hemi (left/right))
%   - Slope (pre and post N1)
%   - N1 amplitude and latency
% plotting available but commented out

clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load data

opts = spreadsheetImportOptions("NumVariables", 44);
% Specify sheet and range
opts.Sheet = "Sheet3";
opts.DataRange = "A4:AR210";
% Specify column names and types
opts.VariableNames = ["S1_LE_lef", "S2_LE_lef", "S3_LE_lef", "S4_LE_lef", "S5_LE_lef", "S6_LE_lef", "S7_LE_lef", "S8_LE_lef", "S9_LE_lef", "S10_LE_lef", "AVE_LE_lef", "S1_LE_rig", "S2_LE_rig", "S3_LE_rig", "S4_LE_rig", "S5_LE_rig", "S6_LE_rig", "S7_LE_rig", "S8_LE_rig", "S9_LE_rig", "S10_LE_rig", "AVE_LE_rig", "S1_RE_lef", "S2_RE_lef", "S3_RE_lef", "S4_RE_lef", "S5_RE_lef", "S6_RE_lef", "S7_RE_lef", "S8_RE_lef", "S9_RE_lef", "S10_RE_lef", "AVE_RE_lef", "S1_RE_rig", "S2_RE_rig", "S3_RE_rig", "S4_RE_rig", "S5_RE_rig", "S6_RE_rig", "S7_RE_rig", "S8_RE_rig", "S9_RE_rig", "S10_RE_rig", "AVE_RE_rig"];
opts.SelectedVariableNames = ["S1_LE_lef", "S2_LE_lef", "S3_LE_lef", "S4_LE_lef", "S5_LE_lef", "S6_LE_lef", "S7_LE_lef", "S8_LE_lef", "S9_LE_lef", "S10_LE_lef", "AVE_LE_lef", "S1_LE_rig", "S2_LE_rig", "S3_LE_rig", "S4_LE_rig", "S5_LE_rig", "S6_LE_rig", "S7_LE_rig", "S8_LE_rig", "S9_LE_rig", "S10_LE_rig", "AVE_LE_rig", "S1_RE_lef", "S2_RE_lef", "S3_RE_lef", "S4_RE_lef", "S5_RE_lef", "S6_RE_lef", "S7_RE_lef", "S8_RE_lef", "S9_RE_lef", "S10_RE_lef", "AVE_RE_lef", "S1_RE_rig", "S2_RE_rig", "S3_RE_rig", "S4_RE_rig", "S5_RE_rig", "S6_RE_rig", "S7_RE_rig", "S8_RE_rig", "S9_RE_rig", "S10_RE_rig", "AVE_RE_rig"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
% Import the data
tbl = readtable("C:\Users\ckohl\Desktop\Current\AEP\Data\Tiina New Data\alternate_auditory_toCarmen_edited_for_import.xls", opts, "UseExcel", false);

%% Convert to output type
Data.S1.LE.lef = tbl.S1_LE_lef;
Data.S2.LE.lef = tbl.S2_LE_lef;
Data.S3.LE.lef = tbl.S3_LE_lef;
Data.S4.LE.lef = tbl.S4_LE_lef;
Data.S5.LE.lef = tbl.S5_LE_lef;
Data.S6.LE.lef = tbl.S6_LE_lef;
Data.S7.LE.lef = tbl.S7_LE_lef;
Data.S8.LE.lef = tbl.S8_LE_lef;
Data.S9.LE.lef = tbl.S9_LE_lef;
Data.S10.LE.lef = tbl.S10_LE_lef;
Data.AVE.LE.lef = tbl.AVE_LE_lef;
Data.S1.LE.rig = tbl.S1_LE_rig;
Data.S2.LE.rig = tbl.S2_LE_rig;
Data.S3.LE.rig = tbl.S3_LE_rig;
Data.S4.LE.rig = tbl.S4_LE_rig;
Data.S5.LE.rig = tbl.S5_LE_rig;
Data.S6.LE.rig = tbl.S6_LE_rig;
Data.S7.LE.rig = tbl.S7_LE_rig;
Data.S8.LE.rig = tbl.S8_LE_rig;
Data.S9.LE.rig = tbl.S9_LE_rig;
Data.S10.LE.rig = tbl.S10_LE_rig;
Data.AVE.LE.rig = tbl.AVE_LE_rig;
Data.S1.RE.lef = tbl.S1_RE_lef;
Data.S2.RE.lef = tbl.S2_RE_lef;
Data.S3.RE.lef = tbl.S3_RE_lef;
Data.S4.RE.lef = tbl.S4_RE_lef;
Data.S5.RE.lef = tbl.S5_RE_lef;
Data.S6.RE.lef = tbl.S6_RE_lef;
Data.S7.RE.lef = tbl.S7_RE_lef;
Data.S8.RE.lef = tbl.S8_RE_lef;
Data.S9.RE.lef = tbl.S9_RE_lef;
Data.S10.RE.lef = tbl.S10_RE_lef;
Data.AVE.RE.lef = tbl.AVE_RE_lef;
Data.S1.RE.rig = tbl.S1_RE_rig;
Data.S2.RE.rig = tbl.S2_RE_rig;
Data.S3.RE.rig = tbl.S3_RE_rig;
Data.S4.RE.rig = tbl.S4_RE_rig;
Data.S5.RE.rig = tbl.S5_RE_rig;
Data.S6.RE.rig = tbl.S6_RE_rig;
Data.S7.RE.rig = tbl.S7_RE_rig;
Data.S8.RE.rig = tbl.S8_RE_rig;
Data.S9.RE.rig = tbl.S9_RE_rig;
Data.S10.RE.rig = tbl.S10_RE_rig;
Data.AVE.RE.rig = tbl.AVE_RE_rig;
clear opts tbl



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOVA: N1 Slopes (pre and post)

for test =1:2 % pre and post
    Test={'Slope_Pre_Peak','Slope_Post_Peak'};

    Partic=1:10;
    Tone_side={'RE','LE'};
    Hemi={'rig','lef'};
    Categ={'contra','ipsi'};
    time=linspace(-201.000005, 793.699980,207);

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
end

%% plotting not in test loop
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
% yrange=[-20 60];
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
%             tempx=[time,fliplr(time)];
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
%             tempx=[time,fliplr(time)];
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
%         tempx=[time,fliplr(time)];
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
%         tempx=[time,fliplr(time)];
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
% 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANOVA: Each peak amplitude and latency
% for paper: only N1 peak and latency

for test=1:2 % amp and lat
    Test={'Amp','Lat'};


    Peaks={'P1','N1','P2'};
    peak=2;

    Peak_avg=0; %if true, take avg of window around peak
    avg_window=10;

    Partic=1:10;
    Tone_side={'RE','LE'};
    Hemi={'rig','lef'};
    Categ={'contra','ipsi'};
    time=linspace(-201.000005, 793.699980,207);
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
                    dataoi=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi}).*(-1);
                    timeoi=time>peak_windows(peak,1) & time<=peak_windows(peak,2);
                    if peak==2
                        [peak_amp,peak_i]=min(dataoi(timeoi));
                        if Peak_avg
                            peak_amp=mean(dataoi(peak_i+min(find(timeoi==1))-1-avg_window:peak_i+min(find(timeoi==1))-1+avg_window));
                        end
                    else
                        [peak_amp,peak_i]=max(dataoi(timeoi));
                    end
                    peak_lat=time(timeoi);
                    peak_lat=peak_lat(peak_i);
                    %plot
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
    %effect size
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
end

%% plotting not in loop
% Main1_p=(ranovatbl(3,5));
% Main2_p=(ranovatbl(5,5));
% Interact_p=(ranovatbl(7,5));
% Main1_F=(ranovatbl(3,4));
% Main2_F=(ranovatbl(5,4));
% Interact_F=(ranovatbl(7,4));

% %% PLOT
% 
% yrange=[-20 60];
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
%             tempx=[time,fliplr(time)];
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
%             tempx=[time,fliplr(time)];
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
%         tempx=[time,fliplr(time)];
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
%         tempx=[time,fliplr(time)];
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
% 
% 
% 
