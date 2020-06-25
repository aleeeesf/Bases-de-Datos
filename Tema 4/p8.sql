11. Listado de artículos que se han vendido tanto en enero como en febrero

select * from articulos 
where art_num in (
    select vnt_art 
    from ventas 
    where vnt_fch between '2020-01-01' and '2020-01-31') 
and art_num in (
    select vnt_art 
    from ventas 
    where vnt_fch between '2020-02-01' and '2020-02-29');
   
+---------+------------+----------+---------+--------+--------+---------+
| ART_NUM | ART_NOM    | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+------------+----------+---------+--------+--------+---------+
|       3 | calendario |      100 | blanco  |      1 |      4 |       4 |
+---------+------------+----------+---------+--------+--------+---------+

12. Listado de tiendas que han vendido en febrero menos las tiendas que han vendido en
enero. Ordenado por código de tienda.

select * 
from tiendas
where tda_num in (
    select vnt_tda 
    from ventas 
    where vnt_fch between '2020-01-01' and '2020-01-31') 
and tda_num not in (
    select vnt_art 
    from ventas 
    where vnt_fch between '2020-02-01' and '2020-02-29');
+---------+---------------+----------------+
| TDA_NUM | TDA_POB       | TDA_GER        |
+---------+---------------+----------------+
|       7 | Valencia      | Petit, Joan    |
|       2 | Madrid-centro | Martinez, Juan |
+---------+---------------+----------------+

13. Listado de proveedores que una aquellos que han vendido algún producto en enero
junto con aquellos de los que se ha vendido algún producto en febrero.

select * 
from proveedores join articulos on prv_num = art_prv
where art_num in (
    select vnt_tda 
    from ventas 
    where vnt_fch between '2020-01-01' and '2020-01-31') 
and art_num in (
    select vnt_art 
    from ventas 
    where vnt_fch between '2020-02-01' and '2020-02-29');

/*     CUALQUIERA DE LAS DOS MANERAS VALE   */

select * 
from proveedores join articulos on prv_num = art_prv
where art_num in (
    select vnt_tda 
    from ventas 
    where vnt_fch between '2020-01-01' and '2020-01-31') 
union
select * 
from proveedores join articulos on prv_num = art_prv
where art_num in(
    select vnt_art 
    from ventas 
    where vnt_fch between '2020-02-01' and '2020-02-29');

+---------+------------------+---------+-------------+----------+---------+--------+--------+---------+
| PRV_NUM | PRV_NOM          | ART_NUM | ART_NOM     | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+------------------+---------+-------------+----------+---------+--------+--------+---------+
|       1 | catio electronic |       2 | calculadora |      150 | negro   |     10 |     20 |       1 |
|       4 | sanjita          |       3 | calendario  |      100 | blanco  |      1 |      4 |       4 |
|       5 | electrolamp      |       7 | lampara     |      550 | verde   |     25 |     37 |       5 |
+---------+------------------+---------+-------------+----------+---------+--------+--------+---------+

14. Listado de que muestre la cantidad de artículos comprada por cada cliente. La cantidad
de artículos es la suma de los vnt_can de las ventas a cada cliente. Si un cliente no ha
comprado ningún artículo también deberá aparecer en el listado. En este caso, deberá
aparecer un 0 en la cantidad comprada.



15. Listado que muestre las ventas de los artículos junto con que clientes lo compraron. Si
un artículo no ha sido comprado, también deberá aparecer en el listado.

select ART_NUM, ART_NOM from articulos left outer join ventas on art_num = vnt_art left outer join clientes on vnt_clt = clt_num;
+---------+-------------------+----------+---------+--------+--------+---------+---------+---------+---------+----------+------------+---------+-----------+-----------+----------+-----------+
| ART_NUM | ART_NOM           | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV | VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    | CLT_NUM | CLT_APELL | CLT_NOM   | CLT_PAIS | CLT_POB   |
+---------+-------------------+----------+---------+--------+--------+---------+---------+---------+---------+----------+------------+---------+-----------+-----------+----------+-----------+
|       1 | impresora         |      150 | rojo    |    400 |    580 |       4 |       4 |      11 |       1 |        8 | 2019-12-22 |       4 | Dupreit   | Michel    | f        | Lyon      |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       8 |      11 |       2 |        1 | 2019-10-25 |       8 | Courbon   | Gerad     | f        | Marsella  |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       1 |       2 |       2 |        1 | 2019-11-09 |       1 | Borras    | Margarita | e        | Madrid    |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |      10 |       4 |       2 |     NULL | 2020-03-03 |      10 | Roca      | Pau       | e        | Gerona    |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       5 |       3 |       2 |        2 | 2020-04-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       5 |       4 |       2 |        2 | 2020-04-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       5 |       3 |       2 |        2 | 2020-04-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       5 |       4 |       2 |        2 | 2020-04-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |       5 |       3 |       2 |        2 | 2020-04-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       6 |      12 |       3 |        2 | 2019-10-30 |       6 | Souris    | Marcel    | f        | París     |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |      13 |       1 |       3 |        1 | 2019-11-05 |      13 | Cortes    | Diego     | e        | Madrid    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       1 |       2 |       3 |        3 | 2020-01-20 |       1 | Borras    | Margarita | e        | Madrid    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       7 |       8 |       3 |        1 | 2020-02-03 |       7 | Goméz     | Pablo     | e        | Pamplona  |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       4 |       5 |       3 |        6 | 2020-02-04 |       4 | Dupreit   | Michel    | f        | Lyon      |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |      10 |      11 |       3 |        1 | 2020-02-06 |      10 | Roca      | Pau       | e        | Gerona    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       6 |       7 |       3 |        1 | 2020-02-11 |       6 | Souris    | Marcel    | f        | París     |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       3 |       4 |       3 |        2 | 2020-02-16 |       3 | Dupont    | Jean      | f        | París     |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       9 |      10 |       3 |        1 | 2020-02-21 |       9 | Roman     | Consuelo  | e        | Jaen      |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       2 |       3 |       3 |        4 | 2020-02-22 |       2 | Perez     | Miguel    | e        | Madrid    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       8 |       9 |       3 |        1 | 2020-02-29 |       8 | Courbon   | Gerad     | f        | Marsella  |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       5 |       6 |       3 |        3 | 2020-02-29 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |      19 |       7 |       3 |        1 | 2020-03-03 |      19 | Bigote    | Jose Mari | p        | Oporto    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |      17 |       4 |       3 |       10 | 2020-03-03 |      17 | Ubrique   | Jesus     | e        | Pamplona  |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |      18 |       1 |       3 |        1 | 2020-03-03 |      18 | Mazapato  | Sophie    | e        | Madrid    |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |       3 |      13 |       3 |     NULL | 2020-03-03 |       3 | Dupont    | Jean      | f        | París     |
|       4 | lampara           |      550 | rojo    |     20 |     33 |       5 |       5 |       4 |       4 |        1 | 2019-10-15 |       5 | Llopis    | Antoni    | e        | Barcelona |
|       4 | lampara           |      550 | rojo    |     20 |     33 |       5 |      13 |       1 |       4 |        1 | 2019-11-02 |      13 | Cortes    | Diego     | e        | Madrid    |
|       5 | lampara           |      550 | blanco  |     20 |     34 |       5 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|       6 | lampara           |      550 | azul    |     25 |     36 |       5 |       3 |       7 |       6 |        1 | 2020-01-11 |       3 | Dupont    | Jean      | f        | París     |
|       7 | lampara           |      550 | verde   |     25 |     37 |       5 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|       8 | pesacartas 1-500  |     NULL | NULL    |      1 |      4 |       3 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|       9 | pesacartas 1-1000 |     NULL | NULL    |      2 |      9 |       3 |       3 |       7 |       9 |        2 | 2020-01-11 |       3 | Dupont    | Jean      | f        | París     |
|      10 | boligrafo         |       20 | rojo    |    0.5 |      1 |       2 |       7 |       3 |      10 |        1 | 2019-10-15 |       7 | Goméz     | Pablo     | e        | Pamplona  |
|      10 | boligrafo         |       20 | rojo    |    0.5 |      1 |       2 |       4 |      11 |      10 |        7 | 2019-12-22 |       4 | Dupreit   | Michel    | f        | Lyon      |
|      11 | boligrafo         |       20 | azul    |    0.5 |      1 |       2 |       7 |       3 |      11 |        2 | 2019-10-15 |       7 | Goméz     | Pablo     | e        | Pamplona  |
|      12 | boligrafo lujo    |       20 | rojo    |    0.6 |      3 |       2 |       1 |       2 |      12 |        1 | 2019-12-02 |       1 | Borras    | Margarita | e        | Madrid    |
|      13 | boligrafo lujo    |       20 | verde   |   1.99 |   3.99 |       2 |       1 |       2 |      13 |       10 | 2019-12-12 |       1 | Borras    | Margarita | e        | Madrid    |
|      14 | boligrafo vulgar  |       20 | azul    |   1.99 |   4.99 |       2 |       7 |       3 |      14 |        3 | 2019-10-16 |       7 | Goméz     | Pablo     | e        | Pamplona  |
|      15 | boligrafo lujo    |       20 | negro   |   1.99 |   4.99 |       2 |       6 |      12 |      15 |        2 | 2019-11-02 |       6 | Souris    | Marcel    | f        | París     |
|      16 | papel             |     5000 | rosa    |      3 |      6 |       2 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      17 | grapadora         |     1000 | verde   |     12 |   15.6 |       3 |      22 |      10 |      17 |        1 | 2019-10-06 |      22 | Alonso    | Fernando  | e        | Gijón     |
|      17 | grapadora         |     1000 | verde   |     12 |   15.6 |       3 |      26 |       4 |      17 |        2 | 2020-03-02 |      26 | Peralta   | Leo       | a        | Rosario   |
|      18 | impresora         |      200 | morado  |    390 |    540 |       3 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      19 | calendario        |      110 | negro   |    0.6 |    2.5 |       4 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      20 | manta             |     NULL | malva   |     15 |     25 |      10 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      21 | balón             |     NULL | blanco  |     10 |     25 |      10 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      69 | papel             |     NULL | rosa    |   3.15 |   5.25 |    NULL |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|      99 | papel             |      800 | morado  |   3.18 |   5.98 |       1 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|     101 | Ordenador         |        5 | azul    |    500 |    650 |       3 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
|     102 | Ordenador         |        5 | malva   |    500 |    650 |       3 |    NULL |    NULL |    NULL |     NULL | NULL       |    NULL | NULL      | NULL      | NULL     | NULL      |
+---------+-------------------+----------+---------+--------+--------+---------+---------+---------+---------+----------+------------+---------+-----------+-----------+----------+-----------+


16. Listado de ventas de las tiendas que han vendido más que alguna de las tiendas de
Madrid. El listado debe mostrar para cada tienda la siguiente información:
Población, Gerente, Número de ventas realizada, media de cantidad vendida en cada
venta. Las tiendas de Madrid no deberán aparecer en el listado.

select tda_pob, tda_ger, count(vnt_tda) 
from tiendas join ventas on tda_num = vnt_tda 
where tda_pob not like 'Madrid%' 
group by tda_num 
having count(vnt_tda) > ANY (
    select count(vnt_tda) 
    from ventas, tiendas 
    where tda_num = vnt_tda and tda_pob like 'Madrid%' 
    group by tda_num);
+-----------+------------------------+----------------+
| tda_pob   | tda_ger                | count(vnt_tda) |
+-----------+------------------------+----------------+
| Pamplona  | Dominguez, Julian      |              7 |
| Barcelona | Parraquet, Juan Carlos |              7 |
| Valencia  | Petit, Joan            |              4 |
| Lyon      | Madoux, Jean           |              4 |
+-----------+------------------------+----------------+


17. Listado de clientes de Madrid que han comprado algún producto del proveedor
‘electrolamp’.

select * 
from ventas join clientes on clt_num = vnt_clt 
where clt_pob = 'Madrid' and vnt_art in (
    select art_num 
    from articulos join proveedores 
    where prv_num = art_prv and prv_nom = 'electrolamp');
+---------+---------+---------+----------+------------+---------+-----------+---------+----------+---------+
| VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    | CLT_NUM | CLT_APELL | CLT_NOM | CLT_PAIS | CLT_POB |
+---------+---------+---------+----------+------------+---------+-----------+---------+----------+---------+
|      13 |       1 |       4 |        1 | 2019-11-02 |      13 | Cortes    | Diego   | e        | Madrid  |
+---------+---------+---------+----------+------------+---------+-----------+---------+----------+---------+

18. Listado de tiendas en las que han comprado clientes cuya población no sea ni Madrid ni
Barcelona. El listado deberá mostrar la cantidad de ventas realizada por cada tienda.

select * 
from tiendas join ventas on vnt_tda = tda_num 
where vnt_clt not in (
    select clt_num 
    from clientes 
    where clt_pob not in ('Madrid', 'Barcelona')) 
group by tda_num;
+---------+---------------+------------------------+---------+---------+---------+----------+------------+
| TDA_NUM | TDA_POB       | TDA_GER                | VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    |
+---------+---------------+------------------------+---------+---------+---------+----------+------------+
|       1 | Madrid-batan  | Contesfosques, Jordi   |      13 |       1 |       4 |        1 | 2019-11-02 |
|       2 | Madrid-centro | Martinez, Juan         |       1 |       2 |       2 |        1 | 2019-11-09 |
|       3 | Pamplona      | Dominguez, Julian      |       2 |       3 |       3 |        4 | 2020-02-22 |
|       4 | Barcelona     | Parraquet, Juan Carlos |       5 |       4 |       4 |        1 | 2019-10-15 |
|       6 | Jaen          | Marin, Raquel          |       5 |       6 |       3 |        3 | 2020-02-29 |
+---------+---------------+------------------------+---------+---------+---------+----------+------------+

19. Listado de artículos vendidos en la campaña de navidad 2019-20. La campaña de
navidad va del 6 de diciembre al 6 de enero. Interesa conocer la cantidad vendida de
cada artículo y cuál fue la última fecha de compra del mismo.

select art_nom, sum(vnt_cant), max(vnt_fch) 
from articulos join ventas on art_num = vnt_art 
where vnt_fch between '2019-12-06' and '2020-01-06' 
group by art_num;
+----------------+---------------+--------------+
| art_nom        | sum(vnt_cant) | max(vnt_fch) |
+----------------+---------------+--------------+
| impresora      |             8 | 2019-12-22   |
| boligrafo      |             7 | 2019-12-22   |
| boligrafo lujo |            10 | 2019-12-12   |
+----------------+---------------+--------------+



20. Obtener el número, nombre y apellido de los clientes, así como el número de veces que
ha comprado algún objeto y el total en euros que se ha gastado. Si un cliente no ha
realizado ninguna compra debe aparecer también en la tabla indicado que se ha
gastado 0 €. Lo que un cliente se ha gastado en una venta es el producto de la columna
art_pv con la columna vnt_cant (precio de venta por la cantidad comprada).

select clt_nom, clt_apell, art_num, art_nom, count(art_num) 'ventas' , ifnull(round(vnt_cant*art_pv,2),0) 'total gastado' 
from clientes left outer join ventas on clt_num = vnt_clt left outer join articulos on vnt_art = art_num 
group by clt_num, art_num;
+-----------+-------------+---------+-------------------+--------+---------------+
| clt_nom   | clt_apell   | art_num | art_nom           | ventas | total gastado |
+-----------+-------------+---------+-------------------+--------+---------------+
| Margarita | Borras      |       2 | calculadora       |      1 |         20.00 |
| Margarita | Borras      |       3 | calendario        |      1 |         12.00 |
| Margarita | Borras      |      12 | boligrafo lujo    |      1 |          3.00 |
| Margarita | Borras      |      13 | boligrafo lujo    |      1 |         39.90 |
| Miguel    | Perez       |       3 | calendario        |      1 |         16.00 |
| Jean      | Dupont      |       3 | calendario        |      2 |          8.00 |
| Jean      | Dupont      |       6 | lampara           |      1 |         36.00 |
| Jean      | Dupont      |       9 | pesacartas 1-1000 |      1 |         18.00 |
| Michel    | Dupreit     |       1 | impresora         |      1 |       4640.00 |
| Michel    | Dupreit     |       3 | calendario        |      1 |         24.00 |
| Michel    | Dupreit     |      10 | boligrafo         |      1 |          7.00 |
| Antoni    | Llopis      |       2 | calculadora       |      5 |         40.00 |
| Antoni    | Llopis      |       3 | calendario        |      1 |         12.00 |
| Antoni    | Llopis      |       4 | lampara           |      1 |         33.00 |
| Marcel    | Souris      |       3 | calendario        |      2 |          8.00 |
| Marcel    | Souris      |      15 | boligrafo lujo    |      1 |          9.98 |
| Pablo     | Goméz       |       3 | calendario        |      1 |          4.00 |
| Pablo     | Goméz       |      10 | boligrafo         |      1 |          1.00 |
| Pablo     | Goméz       |      11 | boligrafo         |      1 |          2.00 |
| Pablo     | Goméz       |      14 | boligrafo vulgar  |      1 |         14.97 |
| Gerad     | Courbon     |       2 | calculadora       |      1 |         20.00 |
| Gerad     | Courbon     |       3 | calendario        |      1 |          4.00 |
| Consuelo  | Roman       |       3 | calendario        |      1 |          4.00 |
| Pau       | Roca        |       2 | calculadora       |      1 |          0.00 |
| Pau       | Roca        |       3 | calendario        |      1 |          4.00 |
| Jorge     | Mancha      |    NULL | NULL              |      0 |          0.00 |
| Pablo     | Curro       |    NULL | NULL              |      0 |          0.00 |
| Diego     | Cortes      |       3 | calendario        |      1 |          4.00 |
| Diego     | Cortes      |       4 | lampara           |      1 |         33.00 |
| Joaquin   | Fernandez   |    NULL | NULL              |      0 |          0.00 |
| Jacinto   | Duran       |    NULL | NULL              |      0 |          0.00 |
| Pedro     | Minguin     |    NULL | NULL              |      0 |          0.00 |
| Jesus     | Ubrique     |       3 | calendario        |      1 |         40.00 |
| Sophie    | Mazapato    |       3 | calendario        |      1 |          4.00 |
| Jose Mari | Bigote      |       3 | calendario        |      1 |          4.00 |
| Romualdo  | Dalima      |    NULL | NULL              |      0 |          0.00 |
| Paco      | Clavel rojo |    NULL | NULL              |      0 |          0.00 |
| Fernando  | Alonso      |      17 | grapadora         |      1 |         15.60 |
| Pedrito   | Rodriguez   |    NULL | NULL              |      0 |          0.00 |
| Mar       | Florero     |    NULL | NULL              |      0 |          0.00 |
| Mar       | Florero     |    NULL | NULL              |      0 |          0.00 |
| Leo       | Peralta     |      17 | grapadora         |      1 |         31.20 |
| Pablo     | Santos      |    NULL | NULL              |      0 |          0.00 |
+-----------+-------------+---------+-------------------+--------+---------------+

