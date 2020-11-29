%% Plot AEP simulations for paper


clear
set(gcf,'renderer','painters')
Partic=1:10;
Tone_side={'RE','LE'};
Hemi={'rig','lef'};
Categ={'contra','ipsi'};
modeldata_dir='C:\Users\ckohl\hnn_out\data\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% import tiina data
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

data_time=linspace(-201.000005, 793.699980,207);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD MODEL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Model=struct();
for hemi=1:length(Hemi)
    for tone_side=1:length(Tone_side)
        if hemi==1 %R
            if tone_side==1 %R
                param_name='best_new_aep_r_contra_scale_to_ipsi_plus5';
            else %L
                param_name='best_new_aep_r_contra';
            end
        else %L
            if tone_side==1 %R
                param_name='best_aep_l_contra2_smallvalues';
            else %L
                param_name='best_aep_l_contra2_smallvalues_scale_to_ipsi_plus5';
            end
        end
        %mean
        dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
        sim_time=dpl(:,1);
        sim_trials=10;
        dpl_agg=dpl(:,2);%aggregate
        Model.('AVE').(Tone_side{tone_side}).(Hemi{hemi})=dpl(:,2);
        %trials
        dpl_agg_trials=nan(length(sim_time),sim_trials);
        for sim=1:sim_trials
            temp=load(strcat(modeldata_dir,'\',param_name,'\dpl_',num2str(sim-1),'.txt'));
            dpl_agg_trials(:,sim)=temp(:,2);
            Model.(strcat('S',num2str(sim))).(Tone_side{tone_side}).(Hemi{hemi})=temp(:,2);
            % %spikes
            % spk=load(strcat(modeldata_dir,'\',param_name,'\spk.txt'));%this is across trials, not useful
            % %pick example trial
            % spk=load(strcat(modeldata_dir,'\',param_name,'\spk_0.txt'));
        end
    end
end
model_time=sim_time;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot base model (contra)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R =0; %if false, lef themi
ylims=[-60 20];
xlims=[0 250];
if R
    param_name='best_new_aep_r_contra';
else
    param_name='best_aep_l_contra2_smallvalues';
end
dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
sim_time=dpl(:,1);
sim_trials=10;
dpl_agg=dpl(:,2);%aggregate
dpl_5=dpl(:,4);
dpl_2=dpl(:,3);
figure
clf
subplot(2,3,[1,2,4,5])
hold on
plot(sim_time,dpl_agg,'k','Linewidth',2)
dpl_2_trials=[];
dpl_5_trials=[];
for sim=1:sim_trials
    subplot(2,3,[1,2,4,5])
    temp=load(strcat(modeldata_dir,'\',param_name,'\dpl_',num2str(sim-1),'.txt'));
    dpl_agg_trials(:,sim)=temp(:,2);
    plot(sim_time,dpl_agg_trials(:,sim),'Color',[.5 .5 .5],'Linewidth',1)
    
    subplot(2,3,[3])
    hold on
    dpl_2_trials(:,sim)=temp(:,3);
    plot(sim_time,dpl_2_trials(:,sim),'Color',[.5 .5 .5],'Linewidth',1)
    subplot(2,3,[6])
    hold on
    dpl_5_trials(:,sim)=temp(:,4);
    plot(sim_time,dpl_5_trials(:,sim),'Color',[.5 .5 .5],'Linewidth',1)
end
subplot(2,3,[1,2,4,5])
plot(sim_time,dpl_agg,'k','Linewidth',2)
%data
if R
    plot(data_time, Data.AVE.LE.rig.*-1,'b','Linewidth',2)
else
    plot(data_time, Data.AVE.RE.lef.*-1,'b','Linewidth',2)
end
ylim(ylims)
xlim(xlims)
subplot(2,3,[3])
hold on
plot(sim_time,dpl_2,'Color','k','Linewidth',1)
ylim(ylims)
xlim(xlims)
subplot(2,3,[6])
hold on
plot(sim_time,dpl_5,'Color','k','Linewidth',1)
ylim(ylims)
xlim(xlims)

cd('C:\Users\ckohl\Desktop\')
print 'temp' -depsc -painters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot model and/or data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% yrange=[-20 60];
SE=0; %plot standard error or not
MOD=1; %plot model or not
DAT=1; %plot data or not
figure
clf
hold on
Categ={'contra','ipsi'};
%plot first 4
model_colours={[.625 0 0],[0 0 .625]};
data_colours={[229 115 115]./255, [66 165 245]./255}
for hemi=1:length(Hemi)
    if hemi==1
        subplot(1,2,2)
    else
        subplot(1,2,1)
    end
    hold on
    count=0;
    line=[];
    for tone_categ=1:length(Categ)
        count=count+1;
        if hemi==1%right hemi
            if tone_categ==1;%contra
                tone_side=2;%left tone
            else%ipsi
                tone_side=1;%right
            end
        else%left hemi
             if tone_categ==1;%contra
                tone_side=1;
            else%ipsi
                tone_side=2;
             end
        end
            
       
        if hemi==1
            linestyle='-';
        else
            linestyle='-';
        end
        
        if count==1
            ylabel('Amplitude (nAm)');
        end
        xlabel('Time (ms)');
        hold on
        title(strcat('Hemi: ', Hemi{hemi}(1)));
        data_oi=[];
        for partic=1:length(Partic)
            data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
            model=Model.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
%             plot(time,data)
            data_oi(partic,:)=data.*-1;
            model_oi(partic,:)=model;
        end
        set(gca, 'YDir','normal');
        if DAT
            line(count)=plot(data_time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}).*-1,'Color',data_colours{tone_categ},'Linestyle',linestyle,'Linewidth',6);
        end
        if MOD
            line2(count)=plot(model_time,Model.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'Color',model_colours{tone_categ},'Linestyle',linestyle,'Linewidth',2);
        end
            if SE
                %make standard error for data
                if DAT
                    SE_upper=[];
                    SE_lower=[];
                    for i=1:length(data_time)
                        se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
                        SE_upper(i)=mean(data_oi(:,i))+se;
                        SE_lower(i)=mean(data_oi(:,i))-se;
                    end
                    tempx=[data_time,fliplr(data_time)];
                    tempy=[SE_upper,fliplr(SE_lower)];
                    A=fill(tempx,tempy,'k');
                    A.EdgeColor='none';
                    A.FaceColor=data_colours{tone_categ};
                    A.FaceAlpha=.2;
                    pause(.1)
                end
                %make standard error for model
                if MOD 
                    SE_upper=[];
                    SE_lower=[];
                    for i=1:length(model_time)
                        se=std(model_oi(:,i))./sqrt(length(model_oi(:,i)));
                        SE_upper(i)=mean(model_oi(:,i))+se;
                        SE_lower(i)=mean(model_oi(:,i))-se;
                    end
                    set(gca, 'YDir','normal');
                    tempx=[model_time',fliplr(model_time')];
                    tempy=[SE_upper,fliplr(SE_lower)];
                    A=fill(tempx,tempy,'k');
                    A.EdgeColor='none';
                    A.FaceColor=model_colours{tone_categ};
                    A.FaceAlpha=.2;
                    pause(.1)
                end
            end
        ylim([-60 20])
        xlim([0 250])
    end
end


cd('C:\Users\ckohl\Desktop\')
print 'c_to_i' -depsc -painters















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Contra-to-Ipsi Step Figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yrange=[-20 60];
R =0; %if false, lef themi
ylims=[-60 20];
xlims=[0 250];
figure
clf
Steps={'Contra','Step', 'Ipsi'};
Hemi={'R','L'}
data_colours={[]./255,[]./255,[]./255;[]./255,[]./255,[]./255}
for hemi=1:length(Hemi)
    %get data
    if hemi==1 %R
        data_contra=Data.AVE.(strcat(Hemi{hemi},'E')).lef;
        data_ipsi=Data.AVE.(strcat(Hemi{hemi},'E')).rig;
    else %L
        data_contra=Data.AVE.(strcat(Hemi{hemi},'E')).rig;
        data_ipsi=Data.AVE.(strcat(Hemi{hemi},'E')).lef;
    end   
    for step=1:length(Steps)
        subplot(length(Hemi),length(Steps),hemi*step)
        hold on   
        %plot data
        plot(data,time, data_contra,'Color',[226 113 113]./255,'Linewidth',9)
        plot(data,time, data_ipsi,'Color',[109 187 228]./255,'Linewidth',9)
        
        %load model
        param_name=strcat(Hemi{hemi},'_',Steps{step});
        dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
        sim_time=dpl(:,1);
        dpl_agg=dpl(:,2);%aggregate
        %plot model
        plot(sim_time,dpl_agg,'k','Linewidth',2)
    end
end
        
dp




cd('C:\Users\ckohl\Desktop\')
print 'temp' -depsc -painters





















% %% PLOT
% 
% yrange=[-20 60];
% figure
% clf
% Categ={'contra','ipsi'};
% %plot first 4
% colours={[.625 0 0],[0 0 .625]};
% for hemi=1:length(Hemi)
%     subplot(1,2,hemi)
%     count=0;
%     line=[];
%     for tone_categ=1:length(Categ)
%         count=count+1;
%         colour=colours{tone_categ};%[0 .312 .625];
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
%             linestyle='--';
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
%         xlim([0 250])
%         %latency lines
%         for peak=1:length(Peaks)
%             plot([mean(latencies.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi})),mean(latencies.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi}))], yrange,'Color',[colour(1:3),0.4],'Linestyle',linestyle,'Linewidth',2);
%         end
%     end
%     legend(line,Categ)
% end
% 



