% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête

function [recall, precision] = tests()
    %img_db_path = './db/';
    %img_db_list = glob([img_db_path, '*.gif']);
    %img_db = cell(1);
    %label_db = cell(1);
    %fd_db = cell(1);
    %figure();
    %for im = 1:numel(img_db_list);
        %img_db{im} = logical(imread(img_db_list{im}));
        %label_db{im} = get_label(img_db_list{im});
        %clf;imshow(img_db{im});
        %disp(label_db{im}); 
        %drawnow();
    %end
    
    img_dbq_path = './dbq/';
    img_dbq_list = glob([img_dbq_path, '*.gif']);
    img_dbq = cell(1);
    label_dbq = cell(1);
    fd_dbq = cell(1);

    figure();

    for im = 1:1 %numel(img_dbq_list);       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        label_dbq{im} = get_label(img_dbq_list{im});
        hold on;
        clf;imshow(img_dbq{im});
        [row, col] = find(img_dbq{im});
        moyx = round(mean(col));
        moyy = round(mean(row));
        %disp(moyx); disp(moyy);
        
        tmpx = moyx;
        tmpy = moyy;
        
        img = img_dbq{im};

        %teta = linspace(0, 2*pi, 400);
        
        for i=1:180;
            decalx = cos(i*2*pi)/180;
            decaly = sin(i*2*pi)/180;
            while ((img(tmpx,tmpy) == 1) || (tmpx < size(img,2)) || (tmpy < size(img,1)));
                tmpx = tmpx + round(decalx)
                tmpy = tmpy + round(decaly)
                hold on;
                plot(round(tmpx), round(tmpy), 'r+');
            end
            hold on;
            plot(round(tmpy), round(tmpx), 'g+');

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