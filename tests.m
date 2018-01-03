% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% oÃ¹ num_ref est le nombre d'objets de rÃ©fÃ©rence (le nombre d'images requÃªtes) 
% et 19 est le nombre d'images Ã  retrouver pour chaque requÃªte

function [recall, precision] = tests()
  
    img_dbq_path = './dbq/';
    img_dbq_list = glob([img_dbq_path, '*.gif']);
    img_dbq = cell(1);
    label_dbq = cell(1);
    
    nbteta =10;

    for im = 1:1 %numel(img_dbq_list);       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        label_dbq{im} = get_label(img_dbq_list{im});
        [row, col] = find(img_dbq{im});
        baryx = round(mean(col));
        baryy = round(mean(row));
        
        img = img_dbq{im};
        figure, imshow(img); hold on;
        
        %On stocke nbteta valeurs de teta entre 0 et 2pi avec le même écart 
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
            %On récupère la distance entre le barycentre et le point
            pointy(1,i) = pdist([baryx, baryy; tmpx, tmpy],'euclidean');
            plot(tmpx, tmpy, "g+");
        end
        
        TF = fft(pointy);
        figure();plot(TF);
        figure();plot(pointy);
        
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