% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête

function [recall, precision] = tests()
  
    img_dbq_path = './dbq/';
    img_dbq_list = glob([img_dbq_path, '*.gif']);
    img_dbq = cell(1);
    label_dbq = cell(1);
    
    nbteta = 30;

    for im = 1:1 %numel(img_dbq_list);       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        label_dbq{im} = get_label(img_dbq_list{im});
        [row, col] = find(img_dbq{im});
        baryx = round(mean(col));
        baryy = round(mean(row));
        
        img = img_dbq{im};
        figure, imshow(img); hold on;
        
        teta = linspace(0, 2*pi, nbteta);
        
        for i=1:nbteta
            decalx = round(cos(teta(1,i)*2*pi));
            decaly = round(sin(teta(1,i)*2*pi));
            tmpx = baryx;
            tmpy = baryy;
            while((tmpx < size(img,2)) && (tmpy < size(img,1)) && (img(tmpy,tmpx) == 1))
                tmpx = tmpx + decalx;  
                tmpy = tmpy + decaly;
            end
            plot(round(tmpx), round(tmpy), "g+");
        end
                
        %for i=1:400;
        %    while ((img(tmpy,tmpx) == 1) && (tmpx < size(img,2)) && (tmpy < size(img,1)));
        %        tmpx = tmpx + cos(teta(i));
        %        tmpy = tmpy + sin(teta(i));
        %        hold on;
        %        plot(tmpx, tmpy, 'r+');
        %    end
            %plot(tmpy, tmpx, '+g');

        %end
        
        %clf;imshow(img_dbq{im});

        disp(label_dbq{im}); 
        drawnow();
    end
    
end