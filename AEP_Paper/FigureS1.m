% Kohl C, Parviainen, T & Jones, SR: Neural Mechanisms Underlying 
% Human Auditory Evoked Responses Revealed by Human Neocortical Neurosolver

%% Plot Model & Data
% Plot models and data associated contralateral AEFs (left/right)
% (Manuscript Figure 3 b & e)

% Written by Carmen Kohl, 2020.
% github.com/kohl-carmen/MIP-TMS

% clear
% dir = fileparts(which('plot_fig3.m'));
% cd(dir)
Model = {'R_Contra','p_p_p_opt10','d_d_d_opt10'};
model=1
% cd = 'C:\Users\ckohl\hnn_out\data\',Model{model},

% Conditions
Hemi = {'L', 'R',}; %left/right hemisphere
Tone = {'Contra'}; %contra/ipsilateral tone presentation
hemi =2;
% Figure Settings
colours = {[109 187 228], [41 47 123]; [224 80 45], [37 79 39]};
ylims = [-70 30];
xlims = [0 250];
sim_trials = 10;
subidx = [1 3; 6 8];

% Figure
figure

for model=1:length(Model)
    subplot(1,3,model)
    %% plot individual trials
    for trial = 1:sim_trials

        % load simulation
        trial_simulation = load(strcat('C:\Users\ckohl\hnn_out\data\',Model{model},...
                                '\dpl_',num2str(trial-1),'.txt'));
        simulation_time = trial_simulation(:,1); %time
        trial_simulation_agg = trial_simulation(:,2);%aggregate dipole


        % plot aggregate dipoles
        hold on
        plot(simulation_time, trial_simulation_agg,...
             'Color', [colours{1,2}, 127]./255)

    end
    %% plot average    
    % load MEG data 
    data = load(strcat('C:\Users\ckohl\Desktop\Current\AEP\Paper\git-HNN-AEP\MEG_Data\',Hemi{hemi},'_Contra.txt'));
    data_time = data(:,1); %time
    data = data(:,2); %AEF

    % load simulation
    simulation = load(strcat('C:\Users\ckohl\hnn_out\data\',Model{model},...
                             '\dpl.txt'));
    simulation_time = simulation(:,1);%time
    simulation_agg = simulation(:,2);%aggregate dipole


    %plot data and aggregate dipoles
    l1(1) = plot(data_time, data ,'Color',...
                 colours{1,1}./255,'Linewidth',3);
    l1(2) = plot(simulation_time, simulation_agg,'Color',...
                 colours{1,2}./255,'Linewidth',3);
    xlabel('Time (ms)')
    ylabel('Amplitude (nAm)')
    ylim(ylims)
    xlim(xlims)
    title(Model{model})
    legend(l1, 'Data','Model')
end


print 's2' -depsc -painters

