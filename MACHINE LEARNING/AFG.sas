
/* TP Analyse discriminante gaussienne */

/* Importation des données sous SAS */
data cranes;
	infile 'C:\Users\My SAS Files\cranes.txt' firstobs=2;
	input type num lcb lms lbm lp lm lam;
run;

/* Analyse descriptive de la base de données */
proc means data=cranessort;
run;


/* Analyse discriminante 
   METHOD=normal pour indiquer que l'on souhaite utiliser un modèle de mélange Gaussien
   POOL=yes pour indiquer que l'on souhaite faire l'hypothèse de variances égales dans les deux groupes
   LIST est une option permettant d'afficher la liste de tous les individus de la table et leur classement par la méthode
   CROSSVALIDATE permet d'indiquer que l'on souhaite évaluer les performances en terme de taux d'erruer à l'aide de la méthode par validation croisée
*/
proc discrim data=cranes outstat=cranes_stat method=normal pool=yes list crossvalidate;
	class type; /* on indique la variable contenant l'information sur l'appartenance à la classe */
	priors prop; /* pour indique que l'on souhaite des probabilités a priori d'appartenance aux classes qui soient proportionnelles à la proportion empirique */
	id num; /* optionnel, permet d'identifier les individus par leur numéro si besoin (par défaut sinon, ils seront identifiés par leur numéro de ligne) */
	var lcb lms lbm lp lm lam; /* liste des variables que l'on souhaite utiliser pours construire notre analyse : on va donc supposer que l'on a un vecteur de R^6 qui suit une loi Gaussienne multivariée */
run;

/* Même chose, mais cette fois avec l'option POOL=no pour des variances différentes dans chaque groupe */
proc discrim data=cranes outstat=cranes_stat method=normal pool=no list crossvalidate;
	class type;
	priors prop;
	id num;
	var lcb lms lbm lp lm lam;
run;
