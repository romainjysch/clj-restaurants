DROP TABLE IF EXISTS RESTAURANTS;
DROP TABLE IF EXISTS TYPES_GASTRONOMIQUES;
DROP TABLE IF EXISTS VILLES;
DROP TABLE IF EXISTS COMMENTAIRES;
DROP TABLE IF EXISTS LIKES;
DROP TABLE IF EXISTS NOTES;
DROP TABLE IF EXISTS CRITERES_EVALUATION;

CREATE TABLE TYPES_GASTRONOMIQUES (
    numero INT AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    PRIMARY KEY (numero)
);

CREATE TABLE VILLES (
    numero INT AUTO_INCREMENT NOT NULL,
    code_postal VARCHAR(100) NOT NULL,
    nom_ville VARCHAR(100) NOT NULL,
    PRIMARY KEY (numero)
);

CREATE TABLE RESTAURANTS (
    numero INT AUTO_INCREMENT NOT NULL,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    description TEXT,
    site_web VARCHAR(100),
    fk_type INT NOT NULL,
    fk_ville INT NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (fk_type) REFERENCES TYPES_GASTRONOMIQUES(numero),
    FOREIGN KEY (fk_ville) REFERENCES VILLES(numero)
);

CREATE TABLE COMMENTAIRES (
    numero INT AUTO_INCREMENT NOT NULL,
    date_eval DATE NOT NULL,
    commentaire TEXT NOT NULL,
    nom_utilisateur VARCHAR(100) NOT NULL,
    fk_rest INT,
    PRIMARY KEY (numero),
    FOREIGN KEY (fk_rest) REFERENCES RESTAURANTS(numero)
);

CREATE TABLE LIKES (
    numero INT AUTO_INCREMENT NOT NULL,
    appreciation CHAR(1) NOT NULL,
    date_eval DATE NOT NULL,
    adresse_ip VARCHAR(100) NOT NULL,
    fk_rest INT NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (fk_rest) REFERENCES RESTAURANTS(numero)
);

CREATE TABLE NOTES (
    numero INT AUTO_INCREMENT NOT NULL,
    note INT NOT NULL,
    fk_comm INT NOT NULL,
    fk_crit INT NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (fk_comm) REFERENCES COMMENTAIRES(numero),
    FOREIGN KEY (fk_crit) REFERENCES CRITERES_EVALUATION(numero)
);

CREATE TABLE CRITERES_EVALUATION (
    numero INT AUTO_INCREMENT NOT NULL,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    PRIMARY KEY (numero)
);

--

INSERT INTO TYPES_GASTRONOMIQUES(libelle, description) VALUES
    ('Cuisine suisse', 'Cuisine classique et plats typiquement suisses'),
    ('Restaurant gastronomique', 'Restaurant gastronomique de haut standing'),
    ('Pizzeria', 'Pizzas et autres spécialités italiennes');

INSERT INTO CRITERES_EVALUATION(nom, description) VALUES
    ('Service', 'Qualité du service'),
    ('Cuisine', 'Qualité de la nourriture'),
    ('Cadre', 'L''ambiance et la décoration sont-elles bonnes ?');

INSERT INTO VILLES(code_postal, nom_ville) VALUES
    ('2000', 'Neuchâtel');

INSERT INTO RESTAURANTS(nom, adresse, description, site_web, fk_type, fk_ville) VALUES
    ('Fleur-de-Lys', 'Rue du Bassin 10', 'Pizzeria au centre de Neuchâtel', 'http://www.pizzeria-neuchatel.ch', 3, 1),
    ('La Maison du Prussien', 'Rue des Tunnels 11', 'Restaurant gastronomique renommé de Neuchâtel', 'www.hotel-prussien.ch', 2, 1);

INSERT INTO COMMENTAIRES(date_eval, commentaire, nom_utilisateur, fk_rest) VALUES
    (CURRENT_DATE, 'Génial !', 'Toto', 1),
    (CURRENT_DATE, 'Très bon', 'Titi', 1),
    (CURRENT_DATE, 'Un régal !', 'Dupont', 2),
    (CURRENT_DATE, 'Rien à dire, le top !', 'Dupasquier', 2);

INSERT INTO NOTES(note, fk_comm, fk_crit) VALUES
    (4, 1, 1), (5, 1, 2), (4, 1, 3), (4, 2, 1), (4, 2, 2), (4, 2, 3),
    (5, 3, 1), (5, 3, 2), (5, 3, 3), (5, 4, 1), (5, 4, 2), (5, 4, 3);

INSERT INTO LIKES(appreciation, date_eval, adresse_ip, fk_rest) VALUES
    ('T', CURRENT_DATE, '1.2.3.4', 1),
    ('T', CURRENT_DATE, '1.2.3.5', 1),
    ('F', CURRENT_DATE, '1.2.3.6', 1),
    ('T', CURRENT_DATE, '1.2.3.7', 2),
    ('T', CURRENT_DATE, '1.2.3.8', 2),
    ('T', CURRENT_DATE, '1.2.3.9', 2);
