1. Listado de artículos cuyo precio sea superior a 10 euros junto con el proveedor que lo
proporciona. El listado debe mostrar: nombre del artículo, color del artículo, precio de
compra y nombre del proveedor. El listado se debe ordenar alfabéticamente por nombre del artículo.

select art_nom, art_col, art_pc, prv_nom 
from proveedores, articulos 
where prv_num = art_prv and art_pv > 10 
order by art_nom;
+-------------+---------+--------+-----------------------+
| art_nom     | art_col | art_pc | prv_nom               |
+-------------+---------+--------+-----------------------+
| balón       | blanco  |     10 | Sara hogar            |
| calculadora | negro   |     10 | catio electronic      |
| grapadora   | verde   |     12 | mecanica de precision |
| impresora   | rojo    |    400 | sanjita               |
| impresora   | morado  |    390 | mecanica de precision |
| lampara     | rojo    |     20 | electrolamp           |
| lampara     | blanco  |     20 | electrolamp           |
| lampara     | azul    |     25 | electrolamp           |
| lampara     | verde   |     25 | electrolamp           |
| manta       | malva   |     15 | Sara hogar            |
| Ordenador   | azul    |    500 | mecanica de precision |
| Ordenador   | malva   |    500 | mecanica de precision |
+-------------+---------+--------+-----------------------+

2. Listado de tiendas junto con las ventas que han hecho en febrero de 2020. El listado
debe mostrar todas columnas de la tabla tiendas con la fecha de cada venta. El listado
deberá ordenarse por fecha de venta de manera descendente y por nombre de gerente
de la tienda alfabéticamente cuando la fecha coincida.

select * from ventas, tiendas 
where tda_num = vnt_tda and vnt_fch between "2020-02-01" and "2020-02-29" 
order by vnt_fch desc, tda_ger asc;
+---------+---------+---------+----------+------------+---------+-----------+------------------------+
| VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    | TDA_NUM | TDA_POB   | TDA_GER                |
+---------+---------+---------+----------+------------+---------+-----------+------------------------+
|       8 |       9 |       3 |        1 | 2020-02-29 |       9 | Palencia  | Castroviejo, Lozano    |
|       5 |       6 |       3 |        3 | 2020-02-29 |       6 | Jaen      | Marin, Raquel          |
|       2 |       3 |       3 |        4 | 2020-02-22 |       3 | Pamplona  | Dominguez, Julian      |
|       9 |      10 |       3 |        1 | 2020-02-21 |      10 | Gerona    | Gomez, Gabriel         |
|       3 |       4 |       3 |        2 | 2020-02-16 |       4 | Barcelona | Parraquet, Juan Carlos |
|       6 |       7 |       3 |        1 | 2020-02-11 |       7 | Valencia  | Petit, Joan            |
|      10 |      11 |       3 |        1 | 2020-02-06 |      11 | Lyon      | Madoux, Jean           |
|       4 |       5 |       3 |        6 | 2020-02-04 |       5 | Trujillo  | Mendez, Pedro          |
|       7 |       8 |       3 |        1 | 2020-02-03 |       8 | Requena   | Marcos, Pilar          |
+---------+---------+---------+----------+------------+---------+-----------+------------------------+

3. Listado de clientes que son de la misma población que el cliente número 5. El listado
deberá mostrar todas las columnas de la tabla clientes y no deberá listar el registro para
el cliente número 5.

select * 
from clientes c1, clientes c2 
where c2.clt_num = 5 and c1.clt_pob = c2.clt_pob;
+---------+-----------+---------+----------+-----------+---------+-----------+---------+----------+-----------+
| CLT_NUM | CLT_APELL | CLT_NOM | CLT_PAIS | CLT_POB   | CLT_NUM | CLT_APELL | CLT_NOM | CLT_PAIS | CLT_POB   |
+---------+-----------+---------+----------+-----------+---------+-----------+---------+----------+-----------+
|       5 | Llopis    | Antoni  | e        | Barcelona |       5 | Llopis    | Antoni  | e        | Barcelona |
|      12 | Curro     | Pablo   | e        | Barcelona |       5 | Llopis    | Antoni  | e        | Barcelona |
|      25 | Florero   | Mar     | e        | Barcelona |       5 | Llopis    | Antoni  | e        | Barcelona |
+---------+-----------+---------+----------+-----------+---------+-----------+---------+----------+-----------+

4. Listado de artículos de color azul, rosa o verde junto con su peso. El listado debe
mostrar el número, nombre, color, obtenidos de la tabla artículos y el peso, obtenido a
partir de la clasificación de la tabla pesos. Por ejemplo, si un artículo pesa 10, su peso
será leve ya que está comprendido entre el peso_min (1) y el peso_max(100).
-----------------------------------------
art_num  art_nom     art_col     peso_nom
-----------------------------------------
  6     lampara       azul        medio
-----------------------------------------
  7     lampara       verde       medio
-----------------------------------------
  11    boligrafo     azul        leve
------------------------------------------
Listado de ejemplo que se espera


select art_num, art_nom, art_col, peso_nom 
from articulos, pesos 
where art_col in ("rosa","verde","azul") and art_peso between peso_min and peso_max;
+---------+------------------+---------+----------+
| art_num | art_nom          | art_col | peso_nom |
+---------+------------------+---------+----------+
|       6 | lampara          | azul    | medio    |
|       7 | lampara          | verde   | medio    |
|      11 | boligrafo        | azul    | leve     |
|      13 | boligrafo lujo   | verde   | leve     |
|      14 | boligrafo vulgar | azul    | leve     |
|      16 | papel            | rosa    | pesado   |
|      17 | grapadora        | verde   | medio    |
|     101 | Ordenador        | azul    | leve     |
+---------+------------------+---------+----------+


5. Listado que muestre las ventas que los clientes de Barcelona han hecho en las tiendas
que no son de Barcelona. El listado deberá mostrar el nombre, apellidos y población del
cliente, la población de la tienda y la fecha de las ventas.

select clt_nom, clt_apell, clt_pob, tda_pob, vnt_fch 
from ventas, clientes, tiendas 
where clt_num = vnt_clt and vnt_tda = tda_num and clt_pob = 'barcelona' and tda_pob != 'barcelona';
+---------+-----------+-----------+----------+------------+
| clt_nom | clt_apell | clt_pob   | tda_pob  | vnt_fch    |
+---------+-----------+-----------+----------+------------+
| Antoni  | Llopis    | Barcelona | Jaen     | 2020-02-29 |
| Antoni  | Llopis    | Barcelona | Pamplona | 2020-04-29 |
| Antoni  | Llopis    | Barcelona | Pamplona | 2020-04-29 |
| Antoni  | Llopis    | Barcelona | Pamplona | 2020-04-29 |
+---------+-----------+-----------+----------+------------+


6. Listado que muestre aquellos clientes que han realizado más de 2 compras y esté
ordenado de mayor a menor ventas realizadas. El listado deberá mostrar el número,
apellido y nombre del cliente, así como la cantidad de compras realizada

select * from clientes, ventas 
where clt_num = vnt_clt 
group by clt_num 
having count(vnt_clt)>2;
+---------+-----------+-----------+----------+-----------+---------+---------+---------+----------+------------+
| CLT_NUM | CLT_APELL | CLT_NOM   | CLT_PAIS | CLT_POB   | VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    |
+---------+-----------+-----------+----------+-----------+---------+---------+---------+----------+------------+
|       1 | Borras    | Margarita | e        | Madrid    |       1 |       2 |       2 |        1 | 2019-11-09 |
|       3 | Dupont    | Jean      | f        | París     |       3 |       7 |       6 |        1 | 2020-01-11 |
|       4 | Dupreit   | Michel    | f        | Lyon      |       4 |      11 |       1 |        8 | 2019-12-22 |
|       5 | Llopis    | Antoni    | e        | Barcelona |       5 |       4 |       4 |        1 | 2019-10-15 |
|       6 | Souris    | Marcel    | f        | París     |       6 |      12 |       3 |        2 | 2019-10-30 |
|       7 | Goméz     | Pablo     | e        | Pamplona  |       7 |       3 |      10 |        1 | 2019-10-15 |
+---------+-----------+-----------+----------+-----------+---------+---------+---------+----------+------------+


7. Listado de tiendas junto con la cantidad de clientes distintos que han comprado en
dichas tiendas. El listado deberá mostrar dos columnas: población de la tienda
(tda_pob) y cantidad de clientes distintos (el código de los clientes en las ventas se
indica en la columna vnt_clt). El listado deberá ordenarse por la segunda columna de
manera descendente.

select tda_pob, count(DISTINCT vnt_clt) 
from clientes, ventas, tiendas 
where clt_num = vnt_clt and tda_num = vnt_tda 
group by tda_num 
order by count(distinct vnt_clt) desc;
+---------------+-------------------------+
| tda_pob       | count(DISTINCT vnt_clt) |
+---------------+-------------------------+
| Barcelona     |                       5 |
| Valencia      |                       3 |
| Lyon          |                       3 |
| Pamplona      |                       3 |
| Madrid-batan  |                       2 |
| Gerona        |                       2 |
| Requena       |                       1 |
| Trujillo      |                       1 |
| Madrid-centro |                       1 |
| París         |                       1 |
| Palencia      |                       1 |
| Jaen          |                       1 |
| Jerez         |                       1 |
+---------------+-------------------------+


8. Listado de ventas que muestre para cada color la cantidad de artículos vendidos de ese
color y la cantidad de artículos diferentes. Ordene la consulta por la segunda y tercera
columna de manera descendente.

select art_col,count(vnt_art) 'articulos vendidos',count(distinct art_nom) 'articulos distintos' 
from ventas, articulos 
where art_num = vnt_art 
group by art_col 
order by count(vnt_art) desc, count(DISTINCT art_nom) desc;
+---------+--------------------+---------------------+
| art_col | articulos vendidos | articulos distintos |
+---------+--------------------+---------------------+
| blanco  |                 16 |                   1 |
| negro   |                  9 |                   2 |
| rojo    |                  6 |                   4 |
| azul    |                  3 |                   3 |
| verde   |                  3 |                   2 |
| NULL    |                  1 |                   1 |
+---------+--------------------+---------------------+

9. Listado de artículos vendidos por cada proveedor. El listado mostrará dos columnas: el
nombre del proveedor y la cantidad de ventas de los artículos de cada proveedor.

select prv_nom, count(vnt_art) 
from ventas, proveedores, articulos 
where art_num = vnt_art and prv_num = art_prv 
group by art_prv;
+------------------------+----------------+
| prv_nom                | count(vnt_art) |
+------------------------+----------------+
| catio electronic       |              8 |
| estilografica reunidas |              7 |
| mecanica de precision  |              3 |
| sanjita                |             17 |
| electrolamp            |              3 |
+------------------------+----------------+

10. Listado que muestre la siguiente información de las ventas. Las columnas deben
mostrar la información y cabeceras tal y como se muestran en el siguiente ejemplo.
Ordene el resultado por fecha de manera ascendente.

    Cliente         Tienda      Artículo    Cantidad    Fecha
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Fernando Alonso     Gerona      grapadora       1       2019-10-06
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Antoni Llopis       Barcelona   lampara         1       2019-10-15
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Pablo Gómez         Pamplona    boligrafo       1       2019-10-15
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        ...             ...         ...         ...         ...
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

select concat(clt_nom,' ', clt_apell) 'Cliente', tda_pob 'Tienda',art_nom 'Articulo', vnt_cant 'Cantidad', vnt_fch 'Fecha'
from clientes, ventas, tiendas, articulos
where tda_num = vnt_art and vnt_clt = clt_num and art_num = vnt_art;
+------------------+---------------+-------------------+----------+------------+
| Cliente          | Tienda        | Articulo          | Cantidad | Fecha      |
+------------------+---------------+-------------------+----------+------------+
| Michel Dupreit   | Madrid-batan  | impresora         |        8 | 2019-12-22 |
| Gerad Courbon    | Madrid-centro | calculadora       |        1 | 2019-10-25 |
| Margarita Borras | Madrid-centro | calculadora       |        1 | 2019-11-09 |
| Pau Roca         | Madrid-centro | calculadora       |     NULL | 2020-03-03 |
| Antoni Llopis    | Madrid-centro | calculadora       |        2 | 2020-04-29 |
| Antoni Llopis    | Madrid-centro | calculadora       |        2 | 2020-04-29 |
| Antoni Llopis    | Madrid-centro | calculadora       |        2 | 2020-04-29 |
| Antoni Llopis    | Madrid-centro | calculadora       |        2 | 2020-04-29 |
| Antoni Llopis    | Madrid-centro | calculadora       |        2 | 2020-04-29 |
| Marcel Souris    | Pamplona      | calendario        |        2 | 2019-10-30 |
| Diego Cortes     | Pamplona      | calendario        |        1 | 2019-11-05 |
| Margarita Borras | Pamplona      | calendario        |        3 | 2020-01-20 |
| Pablo Goméz      | Pamplona      | calendario        |        1 | 2020-02-03 |
| Michel Dupreit   | Pamplona      | calendario        |        6 | 2020-02-04 |
| Pau Roca         | Pamplona      | calendario        |        1 | 2020-02-06 |
| Marcel Souris    | Pamplona      | calendario        |        1 | 2020-02-11 |
| Jean Dupont      | Pamplona      | calendario        |        2 | 2020-02-16 |
| Consuelo Roman   | Pamplona      | calendario        |        1 | 2020-02-21 |
| Miguel Perez     | Pamplona      | calendario        |        4 | 2020-02-22 |
| Gerad Courbon    | Pamplona      | calendario        |        1 | 2020-02-29 |
| Antoni Llopis    | Pamplona      | calendario        |        3 | 2020-02-29 |
| Jose Mari Bigote | Pamplona      | calendario        |        1 | 2020-03-03 |
| Jesus Ubrique    | Pamplona      | calendario        |       10 | 2020-03-03 |
| Sophie Mazapato  | Pamplona      | calendario        |        1 | 2020-03-03 |
| Jean Dupont      | Pamplona      | calendario        |     NULL | 2020-03-03 |
| Antoni Llopis    | Barcelona     | lampara           |        1 | 2019-10-15 |
| Diego Cortes     | Barcelona     | lampara           |        1 | 2019-11-02 |
| Jean Dupont      | Jaen          | lampara           |        1 | 2020-01-11 |
| Jean Dupont      | Palencia      | pesacartas 1-1000 |        2 | 2020-01-11 |
| Pablo Goméz      | Gerona        | boligrafo         |        1 | 2019-10-15 |
| Michel Dupreit   | Gerona        | boligrafo         |        7 | 2019-12-22 |
| Pablo Goméz      | Lyon          | boligrafo         |        2 | 2019-10-15 |
| Margarita Borras | París         | boligrafo lujo    |        1 | 2019-12-02 |
| Margarita Borras | Jerez         | boligrafo lujo    |       10 | 2019-12-12 |
| Pablo Goméz      | Palencia      | boligrafo vulgar  |        3 | 2019-10-16 |
| Marcel Souris    | Barcelona     | boligrafo lujo    |        2 | 2019-11-02 |
+------------------+---------------+-------------------+----------+------------+


