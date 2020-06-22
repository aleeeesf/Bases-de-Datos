11. Listado de artículos cuyo peso es superior a alguno de los artículos de color morado.

select * 
from articulos 
where art_peso > ANY 
    (select art_peso 
    from articulos 
    where art_col = 'morado');
+---------+-----------+----------+---------+--------+--------+---------+
| ART_NUM | ART_NOM   | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+-----------+----------+---------+--------+--------+---------+
|       4 | lampara   |      550 | rojo    |     20 |     33 |       5 |
|       5 | lampara   |      550 | blanco  |     20 |     34 |       5 |
|       6 | lampara   |      550 | azul    |     25 |     36 |       5 |
|       7 | lampara   |      550 | verde   |     25 |     37 |       5 |
|      16 | papel     |     5000 | rosa    |      3 |      6 |       2 |
|      17 | grapadora |     1000 | verde   |     12 |   15.6 |       3 |
|      99 | papel     |      800 | morado  |   3.18 |   5.98 |       1 |
+---------+-----------+----------+---------+--------+--------+---------+

12. Muestre todas las columnas de la tienda que ha realizado más ventas.

select * from tiendas 
where tda_num in (
    select vnt_tda 
    from ventas 
    group by vnt_tda 
    having count(*)>= ALL (
        select count(*) 
        from ventas 
        group by vnt_tda));
+---------+-----------+------------------------+
| TDA_NUM | TDA_POB   | TDA_GER                |
+---------+-----------+------------------------+
|       3 | Pamplona  | Dominguez, Julian      |
|       4 | Barcelona | Parraquet, Juan Carlos |
+---------+-----------+------------------------+

13. Listado de clientes que sean de la misma ciudad y país que el cliente número 24.

select * 
from clientes 
where (clt_pais, clt_pob) = (
    select clt_pais, clt_pob 
    from clientes 
    where clt_num = 24);
+---------+-----------+-----------+----------+---------+
| CLT_NUM | CLT_APELL | CLT_NOM   | CLT_PAIS | CLT_POB |
+---------+-----------+-----------+----------+---------+
|       1 | Borras    | Margarita | e        | Madrid  |
|       2 | Perez     | Miguel    | e        | Madrid  |
|      13 | Cortes    | Diego     | e        | Madrid  |
|      18 | Mazapato  | Sophie    | e        | Madrid  |
|      24 | Florero   | Mar       | e        | Madrid  |
+---------+-----------+-----------+----------+---------+

14. Listado de la tabla ventas que muestre la última venta de cada artículo. La última venta
es la fecha más alta (vnt_fch) en que se ha vendido cada artículo (vnt_art). El listado
deberá ordenarse por código de artículo de manera ascendente.


15. Listado de tiendas para los que existe alguna venta (o que han vendido algún producto).

select * 
from tiendas 
where exists (
    select * 
    from ventas 
    where tda_num = vnt_tda);
+---------+---------------+------------------------+
| TDA_NUM | TDA_POB       | TDA_GER                |
+---------+---------------+------------------------+
|       1 | Madrid-batan  | Contesfosques, Jordi   |
|       2 | Madrid-centro | Martinez, Juan         |
|       3 | Pamplona      | Dominguez, Julian      |
|       4 | Barcelona     | Parraquet, Juan Carlos |
|       5 | Trujillo      | Mendez, Pedro          |
|       6 | Jaen          | Marin, Raquel          |
|       7 | Valencia      | Petit, Joan            |
|       8 | Requena       | Marcos, Pilar          |
|       9 | Palencia      | Castroviejo, Lozano    |
|      10 | Gerona        | Gomez, Gabriel         |
|      11 | Lyon          | Madoux, Jean           |
|      12 | París         | Fouet, Paul            |
|      13 | Jerez         | Peralta, Leo           |
+---------+---------------+------------------------+


16. Listado de artículos para los que no existe ninguna compra de un cliente de Madrid.

select * 
from articulos 
where art_num in (
    select vnt_art 
    from ventas 
    where vnt_clt not in (
        select clt_num 
        from clientes 
        where clt_pob = 'Madrid')
    );
+---------+-------------------+----------+---------+--------+--------+---------+
| ART_NUM | ART_NOM           | ART_PESO | ART_COL | ART_PC | ART_PV | ART_PRV |
+---------+-------------------+----------+---------+--------+--------+---------+
|       1 | impresora         |      150 | rojo    |    400 |    580 |       4 |
|       2 | calculadora       |      150 | negro   |     10 |     20 |       1 |
|       3 | calendario        |      100 | blanco  |      1 |      4 |       4 |
|       4 | lampara           |      550 | rojo    |     20 |     33 |       5 |
|       6 | lampara           |      550 | azul    |     25 |     36 |       5 |
|       9 | pesacartas 1-1000 |     NULL | NULL    |      2 |      9 |       3 |
|      10 | boligrafo         |       20 | rojo    |    0.5 |      1 |       2 |
|      11 | boligrafo         |       20 | azul    |    0.5 |      1 |       2 |
|      14 | boligrafo vulgar  |       20 | azul    |   1.99 |   4.99 |       2 |
|      15 | boligrafo lujo    |       20 | negro   |   1.99 |   4.99 |       2 |
|      17 | grapadora         |     1000 | verde   |     12 |   15.6 |       3 |
+---------+-------------------+----------+---------+--------+--------+---------+



17. Listado de clientes de Madrid o Barcelona que por lo menos no han hecho dos compras.
select * 
from clientes 
where clt_pob = 'Madrid' or clt_pob = 'Barcelona' and clt_num in (
    select vnt_clt 
    from ventas 
    group by vnt_clt 
    having count(*)<2);
+---------+-----------+-----------+----------+---------+
| CLT_NUM | CLT_APELL | CLT_NOM   | CLT_PAIS | CLT_POB |
+---------+-----------+-----------+----------+---------+
|       1 | Borras    | Margarita | e        | Madrid  |
|       2 | Perez     | Miguel    | e        | Madrid  |
|      13 | Cortes    | Diego     | e        | Madrid  |
|      14 | Fernandez | Joaquin   | c        | Madrid  |
|      18 | Mazapato  | Sophie    | e        | Madrid  |
|      24 | Florero   | Mar       | e        | Madrid  |
+---------+-----------+-----------+----------+---------+


18. Listado de proveedores que proveen algún artículo.

select * 
from proveedores 
where prv_num in (
    select art_prv 
    from articulos 
    where art_prv = prv_num);
+---------+------------------------+
| PRV_NUM | PRV_NOM                |
+---------+------------------------+
|       1 | catio electronic       |
|       2 | estilografica reunidas |
|       3 | mecanica de precision  |
|       4 | sanjita                |
|       5 | electrolamp            |
|      10 | Sara hogar             |
+---------+------------------------+


select * 
from proveedores 
where exists (
    select * 
    from articulos 
    where art_prv = prv_num);
+---------+------------------------+
| PRV_NUM | PRV_NOM                |
+---------+------------------------+
|       1 | catio electronic       |
|       2 | estilografica reunidas |
|       3 | mecanica de precision  |
|       4 | sanjita                |
|       5 | electrolamp            |
|      10 | Sara hogar             |
+---------+------------------------+


19. Listado de tiendas que no han vendido ningún bolígrafo.

select * 
from tiendas 
where tda_num not in (
    select vnt_tda 
    from ventas 
    where vnt_art in (
        select art_num 
        from articulos 
        where art_nom like 'boligrafo%'));
+---------+--------------+--------------------------+
| TDA_NUM | TDA_POB      | TDA_GER                  |
+---------+--------------+--------------------------+
|       1 | Madrid-batan | Contesfosques, Jordi     |
|       4 | Barcelona    | Parraquet, Juan Carlos   |
|       5 | Trujillo     | Mendez, Pedro            |
|       6 | Jaen         | Marin, Raquel            |
|       7 | Valencia     | Petit, Joan              |
|       8 | Requena      | Marcos, Pilar            |
|       9 | Palencia     | Castroviejo, Lozano      |
|      10 | Gerona       | Gomez, Gabriel           |
|      13 | Jerez        | Peralta, Leo             |
|      14 | Palencia     | Lopez, Maria             |
|      15 | Barcelona    | Lopez, Maria             |
|      16 | París        | Missaquette, Juan Carlos |
+---------+--------------+--------------------------+

20. Listado de clientes de España que han comprado más cantidad de artículos que el
cliente número 17.


select * 
from clientes 
where clt_pais = 'e' and clt_num in (
    select vnt_clt 
    from ventas 
    group by vnt_clt 
    having sum(vnt_cant) > (
        select sum(vnt_cant) 
        from ventas 
        where vnt_clt = 17
    ) 
);

+---------+-----------+-----------+----------+-----------+
| CLT_NUM | CLT_APELL | CLT_NOM   | CLT_PAIS | CLT_POB   |
+---------+-----------+-----------+----------+-----------+
|       1 | Borras    | Margarita | e        | Madrid    |
|       5 | Llopis    | Antoni    | e        | Barcelona |
+---------+-----------+-----------+----------+-----------+


