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
    for im = 1:numel(img_dbq_list);       
        img_dbq{im} = logical(imread(img_dbq_list{im}));   
        label_dbq{im} = get_label(img_dbq_list{im});
        
        [row, col] = find(img_dbq{im});
        moyx = round(mean(col));
        moyy = round(mean(row));
        disp(moyx); disp(moyy);
        
        tmpx = moyx;
        tmpy = moyy;
        
        img = img_dbq{im};

        for delta=0: pi/6: 2*pi;
            while ((img(tmpy,tmpx) == 1) & (tmpx < size(img,2)) & (tmpy < size(img,1)));
                tmpx = tmpx + cos(delta);
                tmpy = tmpy + sin(delta);
            end
            disp(delta);
            disp(tmpx);
            disp(tmpy);
        end
          
        
        clf;imshow(img_dbq{im});
        disp(label_dbq{im}); 
        drawnow();
    end
    
end