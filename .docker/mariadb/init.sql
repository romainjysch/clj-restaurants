create database restaurants;
use restaurants;

--

create table restaurants (
    numero int auto_increment not null,
    nom varchar(100) not null,
    adresse varchar(100) not null,
    description varchar(2000),
    site_web varchar(100),
    fk_type int not null,
    fk_vill int not null,
    primary key (numero)
);

create table types_gastronomiques (
    numero int auto_increment not null,
    libelle varchar(100) not null unique,
    description varchar(2000) not null,
    primary key (numero)
);

create table villes (
    numero int auto_increment not null,
    code_postal varchar(100) not null,
    nom_ville varchar(100) not null,
    primary key (numero)
);

create table commentaires (
    numero int auto_increment not null,
    date_eval date not null,
    commentaire varchar(2000) not null,
    nom_utilisateur varchar(100) not null,
    fk_rest int,
    primary key (numero)
);

create table likes (
    numero int auto_increment not null,
    appreciation char(1) not null,
    date_eval date not null,
    adresse_ip varchar(100) not null,
    fk_rest int not null,
    primary key (numero)
);

create table notes (
    numero int auto_increment not null,
    note decimal(3,0) not null,
    fk_comm int not null,
    fk_crit int not null,
    primary key (numero)
);

create table criteres_evaluation (
    numero int auto_increment not null,
    nom varchar(100) not null unique,
    description varchar(512),
    primary key (numero)
);

--

alter table restaurants add constraint fk_rest_type foreign key (fk_type) references types_gastronomiques (numero);
alter table restaurants add constraint fk_rest_vill foreign key (fk_vill) references villes (numero);
alter table commentaires add constraint fk_comm_rest foreign key (fk_rest) references restaurants (numero);
alter table notes add constraint fk_note_comm foreign key (fk_comm) references commentaires (numero);
alter table notes add constraint fk_note_crit foreign key (fk_crit) references criteres_evaluation (numero);
alter table likes add constraint fk_like_rest foreign key (fk_rest) references restaurants (numero);

--

insert into types_gastronomiques(libelle, description) values ('cuisine suisse', 'cuisine classique et plats typiquement suisses');
insert into types_gastronomiques(libelle, description) values ('restaurant gastronomique', 'restaurant gastronomique de haut standing');
insert into types_gastronomiques(libelle, description) values ('pizzeria', 'pizzas et autres spécialités italiennes');

insert into criteres_evaluation(nom, description) values ('service', 'qualité du service');
insert into criteres_evaluation(nom, description) values ('cuisine', 'qualité de la nourriture');
insert into criteres_evaluation(nom, description) values ('cadre', 'l''ambiance et la décoration sont-elles bonnes ?');

insert into villes(code_postal, nom_ville) values ('2000', 'neuchâtel');

insert into restaurants(nom, adresse, description, site_web, fk_type, fk_vill) values ('fleur-de-lys', 'rue du bassin 10', 'pizzeria au centre de neuchâtel', 'http://www.pizzeria-neuchatel.ch', 3, 1);
insert into restaurants(nom, adresse, description, site_web, fk_type, fk_vill) values ('la maison du prussien', 'rue des tunnels 11', 'restaurant gastronomique renommé de neuchâtel', 'www.hotel-prussien.ch', 2, 1);

insert into commentaires(date_eval, commentaire, nom_utilisateur, fk_rest) values (curdate(), 'génial !', 'toto', 1);
insert into commentaires(date_eval, commentaire, nom_utilisateur, fk_rest) values (curdate(), 'très bon', 'titi', 1);
insert into commentaires(date_eval, commentaire, nom_utilisateur, fk_rest) values (curdate(), 'un régal !', 'dupont', 2);
insert into commentaires(date_eval, commentaire, nom_utilisateur, fk_rest) values (curdate(), 'rien à dire, le top !', 'dupasquier', 2);

insert into notes(note, fk_comm, fk_crit) values (4, 1, 1);
insert into notes(note, fk_comm, fk_crit) values (5, 1, 2);
insert into notes(note, fk_comm, fk_crit) values (4, 1, 3);
insert into notes(note, fk_comm, fk_crit) values (4, 2, 1);
insert into notes(note, fk_comm, fk_crit) values (4, 2, 2);
insert into notes(note, fk_comm, fk_crit) values (4, 2, 3);
insert into notes(note, fk_comm, fk_crit) values (5, 3, 1);
insert into notes(note, fk_comm, fk_crit) values (5, 3, 2);
insert into notes(note, fk_comm, fk_crit) values (5, 3, 3);
insert into notes(note, fk_comm, fk_crit) values (5, 4, 1);
insert into notes(note, fk_comm, fk_crit) values (5, 4, 2);
insert into notes(note, fk_comm, fk_crit) values (5, 4, 3);

insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('t', curdate(), '1.2.3.4', 1);
insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('t', curdate(), '1.2.3.5', 1);
insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('f', curdate(), '1.2.3.6', 1);
insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('t', curdate(), '1.2.3.7', 2);
insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('t', curdate(), '1.2.3.8', 2);
insert into likes(appreciation, date_eval, adresse_ip, fk_rest) values ('t', curdate(), '1.2.3.9', 2);

commit;
