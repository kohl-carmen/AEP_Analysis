clear
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
tbl = readtable("C:\Users\ckohl\Documents\AEP\Tiina New Data\alternate_auditory_toCarmen_edited_for_import.xls", opts, "UseExcel", false);

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

%% setup
Partic=1:10;
Tone_side={'RE','LE'};
Hemi={'rig','lef'};
time=linspace(-201.000005, 793.699980,207)

%plot data as is
figure
count=0;
for tone_side=1:length(Tone_side)
    for hemi=1:length(Hemi)
        count=count+1;
        subplot(2,2,count)
        if count==1 | count==3
            ylabel('Amplitude (nAm)')
        end
        if count==3 | count==4
            xlabel('Time (ms)')
        end
        hold on
        title(strcat('Tone: ',Tone_side{tone_side}(1),' - Hemi: ', Hemi{hemi}(1)))
        data_oi=[];
        for partic=1:length(Partic)
            data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
            plot(time,data)
            data_oi(partic,:)=data;
        end
        plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'k','Linewidth',2)
        if any(mean(data_oi)' ~= Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}))
            plot(mean(data_oi),'k','Linewidth',2)
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For fancier plotting and stats: analyse_tiinas_data








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% get ready for hnn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sample to 600Hz
%crop time
% switch yaxis
original_sampling_rate=205;%???? roughly, I guess: she said steps are every 4.9ms, so 1000/4.9=204.0816 Hz, but to get the samples she said, it's actually every 4.8286ms, which would be 207.0976Hz
new_sampling_rate=600;
time_oi=[0 250];
time=resample(time,new_sampling_rate,original_sampling_rate);
new_index=[find(abs(time-time_oi(1))==min(abs(time-time_oi(1)))),find(abs(time-time_oi(2))==min(abs(time-time_oi(2))))];
time=time(new_index(1):new_index(2));        
for tone_side=1:length(Tone_side)
    for hemi=1:length(Hemi)
        data=Data.AVE.(Tone_side{tone_side}).(Hemi{hemi});
        %resample
        data=resample(data,new_sampling_rate,original_sampling_rate);
        %crop time
        data=data(new_index(1):new_index(2));
        %flip y
        data=data.*-1;
        %save
        figure
        plot(time,data)
        hnn_mat=[time',data];
        cd('C:\Users\ckohl\Documents\SourcePlay\NewTiina\')
        save(strcat('Adult_Tone-',Tone_side{tone_side}(1),' Hemi-',Hemi{hemi}(1),'.txt'),'hnn_mat','-ascii')
    end
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    