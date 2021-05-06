# KIRO
##
###
#### Noms des variables

* Noms des struct avec une majuscule, par exemple : `Solution`.
* En argument d'une fonction : `sol` et `inst` pour une solution et une instance.
* En argument d'une fonction : `aff_train` pour un Affectation_train.
* Noms des attributs des struct `Instance` et `Solution` : comme dans le sujet et sinon voir définition de la struct.
* Au début de chaque fichier mettre un commentaire donnant le nom des fonctions principales (pas les fonctions intermédiaires)

#### Protocole
* Parseurs + fonction coût.
* Verbose à la fonction de coût.
* Temps d'exécution de la fonction coût : si trop long on s'attarde dessus / trouve des méthodes pour ne pas le recalculer
* Codes des heuristiques.
* Coder des moves.
* Vérifier que les moves conservent l'admissibilité, éventuellement modifier la manière dont on stocke les solutions.

##### Bien étudier
* Les différentes contributions au coût
* La forme de l'instance
