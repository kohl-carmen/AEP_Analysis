%% AEF paper: get spikes/s per population
% avg nr of spikes per second per pop

% model set up
Model = {'R_Contra','R_Ipsi','L_Contra','L_Ipsi','R_Contra_to_L_Ca',...
        'R_Contra_to_L_Gains','L_Contra_Reduced_Model',...
        'Alternative_Proximalx3','Alternative_Distalx3'};
pop_id_lower = [1, 36, 136,171];%cell ids
pop_id_upper = [35, 135,170,270];
pop_labels ={'LII/III Basket','LII/III Pyramidal','LV Basket',...
             'LV Pyramidal'};
% import set up
opts = delimitedTextImportOptions("NumVariables", 2);
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["VarName1", "VarName2"];
opts.VariableTypes = ["double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
for model = 1:length(Model)
    for trial = 1:10
        %get data
        s = readtable(strcat('C:\Users\ckohl\hnn_out\data\',Model{model},...
                      '\spk_',num2str(trial-1),'.txt'), opts);
        s = table2array(s);  
        % delete iput spikes
        s(s(:,2)>=270,:)=[];    
        %count all spikes in a given trial and given pop
        spk_count = [];
        for cell = 1:pop_id_upper(end)
            spk_count(cell) = sum(s(:,2)==cell);
        end
        % sort spike counts into populations, average over cells in pop and
        % multiply by 4 to get spikes/s
        for pop = 1:length(pop_labels)
            all_spikes(pop,trial) = mean(spk_count(...
                                    pop_id_lower(pop):pop_id_upper(pop)))*4;
        end
    end
    %print
    fprintf('-- Model: %s --\n',Model{model})
    for pop = 1:length(pop_labels)
        fprintf('%s:\t %2.2f spikes/s\n',...
                pop_labels{pop},mean(all_spikes(pop,:)))
    end

end

