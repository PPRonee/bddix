--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select p.num_potion, p.lib_potion, P.formule, p.constituant_Principal from  potion p;
--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select nom_categ, nb_points  from categorie c  where nb_points =3;
--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select v.nom_village  from village v where v.nb_huttes >35;
--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select * from trophee t where t.date_prise between  '2052-05-01' and '2052-07-01';
--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select h.nom  from habitant h where h.nom like 'A%' and h.nom like'%r%';
--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select distinct  a.num_hab  from absorber a where a.num_potion =1 or a.num_potion =3 or a.num_potion =4 ;
--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select t.num_trophee, t.date_prise , t.code_cat , t.num_preneur  from trophee t ;
--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
 select distinct  h.nom  from habitant h 
inner join village v on h.num_village = v.num_village  where v.nom_village ='Aquilona';
--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select h.nom  from habitant h 
join trophee t on t.num_preneur = h.num_hab   
join categorie c on t.code_cat = c.code_cat 
where c.nom_categ ='Bouclier de Légat';
--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select p.lib_potion, p.formule, p.constituant_principal, h.nom  from potion p
join fabriquer f on f.num_potion = p.num_potion 
join habitant h on h.num_hab = f.num_hab 
where h.nom ='Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select distinct p.lib_potion from potion p 
join absorber a on a.num_potion  = p.num_potion 
join habitant h on a.num_hab = h.num_hab 
where h.nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct h.nom, f.num_potion , a.num_hab  from habitant h
join absorber a on a.num_hab = h.num_hab 
join fabriquer f  on f.num_potion = a.num_potion 
where f.num_hab = 3;
--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct h.nom from habitant h 
join absorber a on a.num_hab = h.num_hab 
join fabriquer f  on f.num_potion = a.num_potion
join habitant h2 on h2.num_hab = f.num_hab 
where h2.nom ='Amnésix';

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select * from habitant h
where h.num_qualite is null;
--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select * from habitant h 
join fabriquer f on f.num_hab  = h.num_hab 
join potion p on p.num_potion = f.num_potion 
where p.lib_potion  = 'Potion magique n°1' ;
--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select nom, age  from habitant h 
order by nom asc;
--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select r.nom_resserre, v.nom_village  from resserre r
join village v on v.num_village = r.num_village  ;
--***

--18. Nombre d'habitants du village numéro 5. (4)
select count(*)  from habitant h 
where h.num_village = 5;
--19. Nombre de points gagnés par Goudurix. (5)
select sum (c.nb_points  ) from categorie c
join trophee t on t.code_cat = c.code_cat
join habitant h on h.num_hab = t.num_preneur 
where h.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)
select date_prise  from trophee t 
limit 1;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum (quantite) from absorber a 
where num_potion ='2';

--22. Superficie la plus grande. (895)
select superficie  from resserre r
order by superficie  desc
limit 1; 
--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select distinct  nom_village, nb_huttes  from village v 
join habitant h on h.num_village = v.num_village ;
--24. Nombre de trophées par habitant (6 lignes)

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select p.nom_province, avg(h.age)  from habitant h  
join village v on v.num_village = h.num_village 
join province p on p.num_province =v.num_province 
group by p.nom_province ;
--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)
select h.nom , count(distinct  p.num_potion) as nb_potionDiferente from potion p
join absorber a on a.num_potion  =  p.num_potion 
join habitant h  on h.num_hab = a.num_hab 
group by h.nom ;
--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select nom ,quantite, lib_potion from habitant h 
join absorber a on a.num_hab = h.num_hab 
join potion p on p.num_potion = a.num_potion 
where p.num_potion = 4 
and  a.quantite >2;

--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select v.nom_village  from village v
join resserre r on r.num_village = v.num_village 
where nom_resserre is not null ;
--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select nom_village, nb_huttes  from village v 
order by nb_huttes desc
limit 1;
--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
select distinct  nom  from habitant h 
join trophee t on t.num_preneur = h.num_hab 
where t.num_preneur > 10;
