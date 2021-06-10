
clear
set(gcf,'renderer','painters')
Tests = {'N1Amp','N1LAt','Slope_Pre_Peak','Slope_Post_Peak'};
SP = [2 1 3 4];
Hemi = {'hl','hr'};
Tone = {'Contra','Ipsi'};
colours = {[109 187 228], [226 113 113]; [41 47 123], [126 20 22]};
figure;
clf
hold on
for test = 1:length(Tests)
    xs=[];
    subplot(2,2,SP(test))
    hold on
    title(Tests{test})
    xlim([0 11])
    if SP(test)==4
        ylim([0.5 2])
    elseif SP(test)==3
        ylim([-2.5, -0.5])
    elseif SP(test)==2
        ylim([-65 -25])
    elseif SP(test)==1
        ylim([90 110])
    end
    cd('C:\Users\ckohl\Desktop\Current\AEP\')
    data = load(Tests{test});
    tab = data.tab;
    data_tabbi = table2array(tab);

    data = load(strcat(Tests{test},'_HNN'));
    tab = data.tab;
    hnn_tabbi = table2array(tab);
    column = 0;
    tab_order = {'Contra_hr','Contra_hl','Ipsi_hr','Ipsi_hl'};
    for hemi=1:length(Hemi)   
        for tone = 1:length(Tone)
            x=tone;      
            if hemi==2
                x = x+6;
            end
            if x == 2 | x==8
                x = x-.3;
            elseif x==3 | x==9
                x= x+.3;
            end
            column=0;
            for i=1:length(tab_order)
                if tab_order{i}(end) == Hemi{hemi}(end)
                	if tab_order{i}(1) == Tone{tone}(1)
                        column=i;
                    end
                end
            end
           
            
            %% plot means    
            %data
            y = mean(data_tabbi(:,column));
            xerr = data_tabbi(:,column);
            error = std(xerr)/sqrt(length(xerr));          
            err=errorbar(x,y,error);
            err.LineWidth = 2;
            err.Color = colours{1,tone}./255;
            set([err.Line err.Bar], 'ColorType', 'truecoloralpha', 'ColorData', [err.Line.ColorData(1:3); 255*.5])      
            p = scatter(x,y); 
            p.MarkerFaceColor = colours{1,tone}./255;     
            p.MarkerEdgeColor = colours{1,tone}./255;     
            p.MarkerFaceAlpha = .5;
            p.MarkerEdgeAlpha = .5;
            xs=[xs,x];
            
            %model
            y = mean(hnn_tabbi(:,column));
            xerr = hnn_tabbi(:,column);
            error = std(xerr)/sqrt(length(xerr));
            x = x + 2;
            p = plot(x,y);
            err=errorbar(x,y,error);
            err.LineWidth = 2;
            err.Color = colours{2,tone}./255;
            p.Color = colours{2,tone}./255;        
            p.Marker = 'o';
            p.MarkerFaceColor = colours{2,tone}./255; 
%             ylim(Ybreaks{test})
            
            
            xs=[xs,x];
        end
         
    end
    xticks([sort(xs)])
end


cd('C:\Users\ckohl\Desktop')
print 'Tab10' -depsc -painters













