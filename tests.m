% recall et precision sont des matrices  de tailles identiques num_ref X 19 
% où num_ref est le nombre d'objets de référence (le nombre d'images requêtes) 
% et 19 est le nombre d'images à retrouver pour chaque requête

function [recall, precision] = tests()

    %Param�rtres de l'application
    %nbteta : 1er param, c'est le delta des points de contours
    nbteta =10;
    %nbvaleur : 2eme param, nb de valeur pour le lissage, < nbteta par
    %construction
    nbvaleur = 5;

    %On r�cup�re les descripteurs sous forme d'une matrice, 
    %une ligne = un descripteur
    list = getDescripteurs(nbteta, nbvaleur);
end