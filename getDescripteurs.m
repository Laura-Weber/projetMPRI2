function [listDes] = getDescripteurs(nbteta, nbvaleur, img_dbq_list)
    %Preallocation de la memoire
    img_dbq = cell(1);
    listDes = zeros(numel(img_dbq_list), nbvaleur);
    
    for im = 1:numel(img_dbq_list)       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        
        %Etape 1 : On calcule le barycentre
        [row, col] = find(img_dbq{im});
        baryx = round(mean(col));
        baryy = round(mean(row));
        
        img = img_dbq{im};
        %figure, imshow(img); hold on;
        
        %On stocke nbteta valeurs de teta entre 0 et 2pi avec le même écart 
        teta = linspace(0, 2*pi, nbteta);
        
        %Preallocation de la memoire
        pointy = zeros(1, nbteta);
        
        %Etape 2 : On calcule les points de contours
        for i=1:nbteta
            decalx = round(cos(teta(1,i)*2*pi));
            decaly = round(sin(teta(1,i)*2*pi));
            tmpx = baryx;
            tmpy = baryy;
            while((tmpx < size(img,2)) && (tmpy < size(img,1)) && (tmpx > 1) && (tmpy > 1))
                tmpx = tmpx + decalx;  
                tmpy = tmpy + decaly;
            end
            while(img(tmpy,tmpx) == 0)
                tmpx = tmpx - decalx;  
                tmpy = tmpy - decaly;
            end
            %On récupère la distance entre le barycentre et le point
            pointy(1,i) = pdist([baryx, baryy; tmpx, tmpy],'euclidean');
            %plot(tmpx, tmpy, "g+");
        end

        %Etape 3-4 : On calcule la TF et on normalise
        TF = abs(real(fft(pointy))/pointy(1));

        %Etape 5 : On fait le lissage
        TF = TF(1,1:nbvaleur);
        %figure();plot(TF);
        
        %Ici, TF est donc devenu le descripteur de l'image.
        listDes(im, :) = TF(1,:);
    end
end