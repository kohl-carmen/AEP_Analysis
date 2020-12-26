%% Did not use this in the paper

% Plot Alternative Hypo simulations for paper
% Based on ../Plot_AEP_Model.m
% This plots the dipoles for Figure 4

% alternative models are:
% - explain difference between R and L by applying contra-ipsi
%   manipulation (i.e. scale and latency)
% - explain difference between contra and ipis by applying R and L
%   manipulation (i.e. proximal latency and distal strength - reduced model
%   only)

% 2 x 2 plot
%  actual model of left               actual model of ipsi
%       (contra)                              (right)
%
%  alternative model of left          alternative model of ipsi
%       (contra)                              (right)

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
%% Plot alternative hypos 

ylims=[-60 20];
xlims=[0 250];
figure 
clf
for alternative_hypo = 1:2
    %% first, plot original model
    subplot(2,2,alternative_hypo)
    hold on
    if alternative_hypo==1
        % contra left data
        plot(data_time, Data.AVE.RE.lef.*-1,'Color',[226 113 113]./255,'Linewidth',3);
        % contra left model
        dpl=load(strcat(modeldata_dir,'\L_Contra\dpl.txt'));
        sim_time=dpl(:,1);
        dpl_agg=dpl(:,2);
        plot(sim_time,dpl_agg,'Color',[126 20 22]./255,'Linewidth',2)
        title('L Contra Original')
    else
        % right contra data
        plot(data_time, Data.AVE.RE.rig.*-1,'Color',[109 187 228]./255,'Linewidth',3);
        % right ipsi model
        dpl=load(strcat(modeldata_dir,'\R_Ipsi\dpl.txt'));
        sim_time=dpl(:,1);
        dpl_agg=dpl(:,2);
        plot(sim_time,dpl_agg,'Color',[41 47 123]./255,'Linewidth',2)
        title('R Ipsi Original')
    end
    ylim(ylims)
    xlim(xlims)
    legend('Data','Model')
    
    
    %% second, plot alterantive model
    subplot(2,2, alternative_hypo+2)
    hold on
    %get model
    if alternative_hypo==1
        % contra left data
        plot(data_time, Data.AVE.RE.lef.*-1,'Color',[226 113 113]./255,'Linewidth',3);
        % alt model
        param_name='R_Contra_to_L_applying_ipsi';
        dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
        sim_time=dpl(:,1);
        dpl_agg=dpl(:,2);%aggregate
        %plot
        plot(sim_time,dpl_agg,'Color',[126 20 22]./255,'Linewidth',2,'Linestyle','--')
        title('L Contra Alternative')
    else
        % right contra data
        plot(data_time, Data.AVE.RE.rig.*-1,'Color',[109 187 228]./255,'Linewidth',3);
        param_name='R_Contra_to_Ipsi_applying_L';
        dpl=load(strcat(modeldata_dir,'\',param_name,'\dpl.txt'));
        sim_time=dpl(:,1);
        dpl_agg=dpl(:,2);%aggregate
        %plot
        plot(sim_time,dpl_agg,'Color',[41 47 123]./255,'Linewidth',2,'Linestyle','--')
        title('R Ipsi Alternative')
    end
    legend('Data','Model')
    ylim(ylims)
    xlim(xlims)
    
    %% save
    cd('C:\Users\ckohl\Desktop\')
    print 'Figure5_Raw' -depsc -painters
end
