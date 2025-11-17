import sys
def add_write(nom_fichier):
    try:
        with open(nom_fichier, 'r') as fichier:
            lignes = fichier.readlines()

        for i, ligne in enumerate(lignes):
            if "MODULE" in ligne:
                lignes.insert(i + 1, "!$ACDC singlecolumn \n")
                break
        with open(nom_fichier, 'w') as fichier:
            fichier.writelines(lignes)
        print("Modification effectuée avec succès.")
    except Exception as e:
        print(f"Une erreur est survenue : {e}")
nom_fichier = sys.argv[1]
add_write(nom_fichier)
