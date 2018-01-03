% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% oÃ¹ num_ref est le nombre d'objets de rÃ©fÃ©rence (le nombre d'images requÃªtes) 
% et 19 est le nombre d'images Ã  retrouver pour chaque requÃªte

function [recall, precision] = tests()
  
    img_dbq_path = './dbq/';
    img_dbq_list = glob([img_dbq_path, '*.gif']);
    img_dbq = cell(1);
    label_dbq = cell(1);
    
    %Paramèrtres de l'application
    %nbteta : 1er param, c'est le delta des points de contours
    nbteta =10;
    %nbvaleur : 2eme param, nb de valeur pour le lissage
    nbvaleur = 10;

    for im = 1:1 %numel(img_dbq_list);       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        label_dbq{im} = get_label(img_dbq_list{im});
        
        %Etape 1 : On calcule le barycentre
        [row, col] = find(img_dbq{im});
        baryx = round(mean(col));
        baryy = round(mean(row));
        
        img = img_dbq{im};
        %figure, imshow(img); hold on;
        
        %On stocke nbteta valeurs de teta entre 0 et 2pi avec le même écart 
        teta = linspace(0, 2*pi, nbteta);
        
        %Etape 2 : On calcule les points de contours
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
            %plot(tmpx, tmpy, "g+");
        end
        
        %Etape 3-4 : On calcule la TF et on normalise
        TF = fft(pointy)/fft(pointy(1));
        figure();plot(real(TF));
        %figure();plot(pointy);
        
        %Etape 5 : On fait le lissage
        
        %disp(label_dbq{im}); 
        drawnow();
    end
    
end