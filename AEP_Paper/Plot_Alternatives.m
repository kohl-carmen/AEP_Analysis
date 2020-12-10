%% Plot alternative AEP simulations for paper
% Based on ../Plot_Model.m (essentially the same)
% This plots the dipoles for Figure 

clear
set(gcf,'renderer','painters')
Partic=1:10;
Tone_side={'RE','LE'};
Hemi={'rig','lef'};
Categ={'contra','ipsi'};
modeldata_dir='C:\Users\ckohl\hnn_out\data\';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load MEG Data

%% import tiina's data
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
%% Plot base model (contra) (x3)

% this models dipoles for figure X
% two figures:
%   - left contralateral based on Ca
%   - left contralateral based on Gains
Alts={'Ca','Gain'};
ylims=[-60 30];
xlims=[0 250];
for alt = 1:length(Alts)
    % get model
    if alt==1
        param_name='R_Contra_to_L_Ca';
    elseif alt==2
        param_name='R_Contra_to_L_Gains';
    end
    dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
    sim_time=dpl(:,1);
    sim_trials=10;
    dpl_agg=dpl(:,2);%aggregate
    dpl_5=dpl(:,4);
    dpl_2=dpl(:,3);
    %plot
    figure
    clf
    subplot(2,3,[1,2,4,5])
    title(param_name)
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
        ylim(ylims)
        xlim(xlims)
        dpl_2_trials(:,sim)=temp(:,3);
        plot(sim_time,dpl_2_trials(:,sim),'Color',[.5 .5 .5],'Linewidth',1)
        subplot(2,3,[6])
        hold on
        ylim(ylims)
        xlim(xlims)
        dpl_5_trials(:,sim)=temp(:,4);
        plot(sim_time,dpl_5_trials(:,sim),'Color',[.5 .5 .5],'Linewidth',1)
    end

    subplot(2,3,[1,2,4,5])
    line(1)=plot(sim_time,dpl_agg,'k','Linewidth',2);
    %data
    line(2)=plot(data_time, Data.AVE.RE.lef.*-1,'b','Linewidth',2);
    legend(line,{'Contra Model','Contra Data'})
    ylim(ylims)
    xlim(xlims)
    subplot(2,3,[3])
    title('Dipole L2/3')
    hold on
    plot(sim_time,dpl_2,'Color','k','Linewidth',1)
    ylim(ylims)
    xlim(xlims)
    subplot(2,3,[6])
    title('Dipole L5')
    hold on
    plot(sim_time,dpl_5,'Color','k','Linewidth',1)
    ylim(ylims)
    xlim(xlims)
    
    %% save
    cd('C:\Users\ckohl\Desktop\')
    if alt==1
        print alt1 -depsc -painters
    else
        print alt2 -depsc -painters
    end

end
close all





