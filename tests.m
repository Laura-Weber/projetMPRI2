% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête

function [recall, precision] = tests()
    %Param�tres de l'application
    %nbteta : 1er param, c'est le delta des points de contours
    nbteta = 20;
    %nbvaleur : 2eme param, nb de valeur pour le lissage, < nbteta par
    %construction
    nbvaleur = 2;
 
    %label_dbq = cell(1);
    %label_dbq{im} = get_label(img_dbq_list{im});
    
    %Etape 6 : Comparaison des descripteurs de db et dbq
    img_dbq_list = glob(['./dbq/', '*.gif']);
    img_db_list = glob(['./db/', '*.gif']);
    listbase = getDescripteurs(nbteta, nbvaleur, img_db_list);
    for im = 1:numel(img_dbq_list)
        %Preallocation de la memoire
        %tab = zeros(numel(img_db_list));
        %On r�cup�re le descripteur sous forme d'une matrice, 
        %une ligne = un descripteur
        query = getDescripteurs(nbteta, nbvaleur, img_dbq_list(im));
        for base = 1:numel(img_db_list)
            tmp = listbase(base,:);
            %Pas de preallocation de tab sinon bug 
            tab(base) = norm(query - tmp);
        end
        dbqlabel = get_label(img_dbq_list{im});
        nbjuste = 0;
        for index = 1:19
            [minimum, i] = min(tab);
            tab(i) = 100;
            dblabel = get_label(img_db_list{i});
            if strcmp(dbqlabel, dblabel) == 1
                nbjuste = nbjuste + 1;
            end
            recall(index) = index;
            precision(index) = nbjuste / index * 100;
        end
        figure();plot(recall, precision);
    end 
end