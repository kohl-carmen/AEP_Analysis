%% Plot AEPs (empirical) for paper
% Based on ../Plot_AEP.m
% this creates Figure 1
% - loads Tiina's MEG data and plots the AEP for right/left contra/ipsi
% - plot includes standard error
% - puts eps file on Desktop


clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load MEG
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


set(gcf,'renderer','painters')

Partic=1:10;
Tone_side={'RE','LE'};
Hemi={'rig','lef'};
Categ={'contra','ipsi'};
Peaks={'P1','N1','P2'};
time=linspace(-201.000005, 793.699980,207);
peak_windows=[35 75;80 120; 130 210];


% get peak latencies
amplitudes=[];
latencies=[];
count=0;
for peak=1:length(Peaks)
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
                    % detect peak
                    dataoi=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi}).*(-1);
                    timeoi=time>peak_windows(peak,1) & time<=peak_windows(peak,2);
                    if peak==2
                        [peak_amp,peak_i]=min(dataoi(timeoi));
                    else
                        [peak_amp,peak_i]=max(dataoi(timeoi));
                    end
                    peak_lat=time(timeoi);
                    peak_lat=peak_lat(peak_i);
                    latencies.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi})(partic)=peak_lat;
                    amplitudes.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi})(partic)=peak_amp;
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot
yrange=[-20 60];
figure
clf
Categ={'contra','ipsi'};
colours={[226 113 113]./255,[109 187 228]./255};
linestyle='-';
for hemi=1:length(Hemi)
    subplot(1,2,hemi)
    count=0;
    line=[];
    for tone_categ=1:length(Categ)
        count=count+1;
        colour=colours{tone_categ};%[0 .312 .625];
        if hemi==1%right hemi
            if tone_categ==1;%contra
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
                 
        set(gca, 'YDir','reverse');
        if count==1
            ylabel('Amplitude (nAm)');
        end
        xlabel('Time (ms)');
        hold on
        title(strcat('Hemi: ', Hemi{hemi}(1)));
        data_oi=[];
        for partic=1:length(Partic)
            data=Data.(strcat('S',num2str(partic))).(Tone_side{tone_side}).(Hemi{hemi});
%             plot(time,data)
            data_oi(partic,:)=data;
        end
        line(count)=plot(time,Data.AVE.(Tone_side{tone_side}).(Hemi{hemi}),'Color',colour,'Linestyle',linestyle,'Linewidth',2);
            %make standard error
            SE_upper=[];
            SE_lower=[];
            for i=1:length(time)
                se=std(data_oi(:,i))./sqrt(length(data_oi(:,i)));
                SE_upper(i)=mean(data_oi(:,i))+se;
                SE_lower(i)=mean(data_oi(:,i))-se;
            end
            tempx=[time,fliplr(time)];
            tempy=[SE_upper,fliplr(SE_lower)];
            A=fill(tempx,tempy,'k');
            A.EdgeColor='none';
            A.FaceColor=colour;
            A.FaceAlpha=.2;
            pause(.1)
        ylim(yrange)
        xlim([0 250])
        %latency lines
        for peak=1:length(Peaks)
            plot([mean(latencies.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi})),mean(latencies.(Peaks{peak}).(Categ{tone_categ}).(Hemi{hemi}))], yrange,'Color',[colour(1:3),0.4],'Linestyle',linestyle,'Linewidth',2);
        end
    end
    legend(line,Categ)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Save
cd('C:\Users\ckohl\Desktop\')
print 'Figure_1_Raw' -depsc -painters



