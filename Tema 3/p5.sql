1. Listado de artículos que pesan menos que el artículo número 2, ordenados de manera ascendente por peso:

select art_num, art_peso 
from articulos 
where art_peso < (
    select art_peso 
    from articulos
    where art_num = 2) 
order by art_peso asc;
+---------+----------+
| art_num | art_peso |
+---------+----------+
|     101 |        5 |
|     102 |        5 |
|      10 |       20 |
|      11 |       20 |
|      12 |       20 |
|      13 |       20 |
|      14 |       20 |
|      15 |       20 |
|       3 |      100 |
|      19 |      110 |
+---------+----------+

2. Listado de proveedores (que muestre código y nombre) que proveen algún artículo.
select prv_num, prv_nom from proveedores
where prv_num in (
    select art_prv from articulos
);
+---------+------------------------+
| prv_num | prv_nom                |
+---------+------------------------+
|       1 | catio electronic       |
|       2 | estilografica reunidas |
|       3 | mecanica de precision  |
|       4 | sanjita                |
|       5 | electrolamp            |
|      10 | Sara hogar             |
+---------+------------------------+


3. Listado de ventas que muestre las fechas en que se han vendido impresoras o de las ventas realizadas a los clientes de Madrid.
select * from ventas 
where vnt_art in 
    (select art_num from articulos 
    where art_nom = 'impresora') 
or vnt_clt in 
    (select clt_num from clientes 
    where clt_pob = 'Madrid');

+---------+---------+---------+----------+------------+
| VNT_CLT | VNT_TDA | VNT_ART | VNT_CANT | VNT_FCH    |
+---------+---------+---------+----------+------------+
|      13 |       1 |       4 |        1 | 2019-11-02 |
|      13 |       1 |       3 |        1 | 2019-11-05 |
|       1 |       2 |       2 |        1 | 2019-11-09 |
|       1 |       2 |      12 |        1 | 2019-12-02 |
|       1 |       2 |      13 |       10 | 2019-12-12 |
|       4 |      11 |       1 |        8 | 2019-12-22 |
|       1 |       2 |       3 |        3 | 2020-01-20 |
|       2 |       3 |       3 |        4 | 2020-02-22 |
|      18 |       1 |       3 |        1 | 2020-03-03 |
+---------+---------+---------+----------+------------+


4. Listado de clientes que sean de España y que residan en la misma ciudad que los que se llaman de nombre Pablo, ordenados por su número de cliente. Aquellos que se llaman ‘Pablo’ no deben aparecer en el listado. El listado deberá ordenarse por clt_num.

select clt_nom from clientes where clt_pob in (select clt_pob from clientes where clt_nom = 'Pablo') and clt_nom != 'Pablo';
+---------+
| clt_nom |
+---------+
| Antoni  |
| Gerad   |
| Jacinto |
| Pedro   |
| Jesus   |
| Mar     |
+---------+


5. Listado de tiendas que muestre aquellas que han vendido algún artículo de color azul.

select * from tiendas 
where tda_num in 
    (select vnt_tda from ventas 
    where vnt_art in 
        (select art_num from articulos
        where art_col = 'Azul'));
+---------+----------+-------------------+
| TDA_NUM | TDA_POB  | TDA_GER           |
+---------+----------+-------------------+
|       3 | Pamplona | Dominguez, Julian |
|       7 | Valencia | Petit, Joan       |
+---------+----------+-------------------+


6. Listado de artículos cuyo precio de venta es superior al precio de venta de todos los artículos de color blanco.

select * from articulos where art_pv > ALL(select art_pv from articulos where art_col = 'Blanco');
+---------+-----------+----------+---------+--------+--------+---------+
| ART_NUM | ART_NOM   | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+-----------+----------+---------+--------+--------+---------+
|       1 | impresora |      150 | rojo    |    400 |    580 |       4 |
|       6 | lampara   |      550 | azul    |     25 |     36 |       5 |
|       7 | lampara   |      550 | verde   |     25 |     37 |       5 |
|      18 | impresora |      200 | morado  |    390 |    540 |       3 |
|     101 | Ordenador |        5 | azul    |    500 |    650 |       3 |
|     102 | Ordenador |        5 | malva   |    500 |    650 |       3 |
+---------+-----------+----------+---------+--------+--------+---------+


7. Listado de clientes que hayan comprado más 3 veces. Un cliente ha comprado más de 3 veces si su código (vnt_clt) aparece en más de 3 filas en la columna vnt_clt de la tabla ventas.
select * from clientes where 



8. Listado tiendas (código y nombre) en las que han comprado los clientes de Madrid.
select * from tiendas 
where tda_num in 
    (select vnt_tda from ventas 
    where vnt_clt in 
        (select clt_num from clientes 
        where clt_pob = 'Madrid') );
+---------+---------------+----------------------+
| TDA_NUM | TDA_POB       | TDA_GER              |
+---------+---------------+----------------------+
|       1 | Madrid-batan  | Contesfosques, Jordi |
|       2 | Madrid-centro | Martinez, Juan       |
|       3 | Pamplona      | Dominguez, Julian    |
+---------+---------------+----------------------+


9. Listado de artículos cuyo precio de compra (art_pc) sea superior al precio de venta del artículo más barato de color malva.

select * from articulos where art_pc > ANY(select art_pv from articulos where art_col = 'Malva');
+---------+-----------+----------+---------+--------+--------+---------+
| ART_NUM | ART_NOM   | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+-----------+----------+---------+--------+--------+---------+
|       1 | impresora |      150 | rojo    |    400 |    580 |       4 |
|      18 | impresora |      200 | morado  |    390 |    540 |       3 |
|     101 | Ordenador |        5 | azul    |    500 |    650 |       3 |
|     102 | Ordenador |        5 | malva   |    500 |    650 |       3 |
+---------+-----------+----------+---------+--------+--------+---------+


10. Listado de que muestre el proveedor que provee el artículo que más veces se ha vendido.
select * 
from proveedores 
where prv_num in 
    (select art_prv 
    from articulos 
    where art_num = 
        (select vnt_art 
        from ventas
        group by vnt_art 
        having sum(vnt_cant) >= ALL 
            (select vnt_cant 
            from ventas 
            group by vnt_art));


select * from proveedores where prv_num in (select art_prv from articulos where art_num = (select vnt_art from ventas group by vnt_art having sum(vnt_cant) >= ALL (select vnt_cant from ventas group by vnt_art) group by vnt_art));




