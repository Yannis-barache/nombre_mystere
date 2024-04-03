INSERT INTO JOUEUR(pseudo) 
VALUES
    ('Abdwu'),
    ('YN');

INSERT INTO DIFFICULTE(nomDifficulte, rangeMin, rangeMax, nbVirgules)
VALUES
    ('Facile', 0, 10, 0),
    ('Moyen', 0, 100, 0),
    ('Itermediaire', -100, 100, 0),
    ('Difficile', 0, 15, 1);

INSERT INTO SCORE(essai, idJoueur, idDifficulte)
VALUES
    (3, 1, 1);
    