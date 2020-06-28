1.Listado de empleados de las oficinas que no son del país USA.

select * 
from empleados 
where empleados.oficinaId in (
    select OficinaId 
    from oficinas 
    where pais != 'USA');

+------------+-----------+---------+-----------+---------------------------------+-----------+-------------+----------------------+
| empleadoId | apellido  | nombre  | extension | email                           | oficinaId | responsable | puesto               |
+------------+-----------+---------+-----------+---------------------------------+-----------+-------------+----------------------+
|       1102 | Bondur    | Gerard  | x5408     | gbondur@classicmodelcars.com    | 4         |        1056 | Sale Manager (EMEA)  |
|       1337 | Bondur    | Loui    | x6493     | lbondur@classicmodelcars.com    | 4         |        1102 | Sales Rep            |
|       1370 | Hernandez | Gerard  | x2028     | ghernande@classicmodelcars.com  | 4         |        1102 | Sales Rep            |
|       1401 | Castillo  | Pamela  | x2759     | pcastillo@classicmodelcars.com  | 4         |        1102 | Sales Rep            |
|       1702 | Gerard    | Martin  | x2312     | mgerard@classicmodelcars.com    | 4         |        1102 | Sales Rep            |
|       1621 | Nishi     | Mami    | x101      | mnishi@classicmodelcars.com     | 5         |        1056 | Sales Rep            |
|       1625 | Kato      | Yoshimi | x102      | ykato@classicmodelcars.com      | 5         |        1621 | Sales Rep            |
|       1088 | Patterson | William | x4871     | wpatterson@classicmodelcars.com | 6         |        1056 | Sales Manager (APAC) |
|       1611 | Fixter    | Andy    | x101      | afixter@classicmodelcars.com    | 6         |        1088 | Sales Rep            |
|       1612 | Marsh     | Peter   | x102      | pmarsh@classicmodelcars.com     | 6         |        1088 | Sales Rep            |
|       1619 | King      | Tom     | x103      | tking@classicmodelcars.com      | 6         |        1088 | Sales Rep            |
|       1501 | Bott      | Larry   | x2311     | lbott@classicmodelcars.com      | 7         |        1102 | Sales Rep            |
|       1504 | Jones     | Barry   | x102      | bjones@classicmodelcars.com     | 7         |        1102 | Sales Rep            |
+------------+-----------+---------+-----------+---------------------------------+-----------+-------------+----------------------+

2.Listado de clientes que no ha realizado ningún pedido.

select clienteNombre 
from clientes c 
where clienteId not in (select clienteId from pedidos);
where not exists (select clienteId from pedidos p where p.clienteId = c.clienteId);
+--------------------------------+
| clienteNombre                  |
+--------------------------------+
| Havel & Zbyszek Co             |
| American Souvenirs Inc         |
| Porto Imports Co.              |
| Asian Shopping Network, Co     |
| Natürlich Autos                |
| ANG Resellers                  |
| Messner Shopping Network       |
| Franken Gifts, Co              |
| BG&E Collectables              |
| Schuyler Imports               |
| Der Hund Imports               |
| Cramer Spezialitäten, Ltd      |
| Asian Treasures, Inc.          |
| SAR Distributors, Co           |
| Kommission Auto                |
| Lisboa Souveniers, Inc         |
| Precious Collectables          |
| Stuttgart Collectable Exchange |
| Feuer Online Stores, Inc       |
| Warburg Exchange               |
| Anton Designs, Ltd.            |
| Mit Vergnügen & Co.            |
| Kremlin Collectables, Co.      |
| Raanan Stores, Inc             |
+--------------------------------+

3.Listado que muestre la cantidad de artículos que hay de cada categoría.
select categoriaId,sum(stock) 
from productos 
group by categoriaId;
+----------------------+-------+
| categoriaId          | stock |
+----------------------+-------+
| Aviones              |  5330 |
| Barcos               |  4259 |
| Camiones y Autobuses |  1579 |
| Coches clásicos      |  7305 |
| Coches Vintage       |  8693 |
| Motociletas          |  7933 |
| Trenes               |  6450 |
+----------------------+-------+

4.Listado que devuelva los empleados responsables de cada oficina.

select nombre, oficinaId
from empleados 
where empleados.oficinaId in (
    select OficinaId 
    from oficinas); 

5.Listado que devuelva la cantidad de productos comprados por los clientes de cada país.

select pais, count(pedidos.pedidoId) 'Cantidad de pedidos'
from clientes, pedidos, pedidodetalles 
where pedidodetalles.pedidoId = pedidos.pedidoId and pedidos.clienteId = clientes.clienteId 
group by clientes.pais;
+-------------+---------------------+
| pais        | Cantidad de pedidos |
+-------------+---------------------+
| Australia   |                 185 |
| Austria     |                  55 |
| Belgium     |                  33 |
| Canada      |                  70 |
| Denmark     |                  63 |
| Finland     |                  92 |
| France      |                 314 |
| Germany     |                  62 |
| Hong Kong   |                  16 |
| Ireland     |                  16 |
| Italy       |                 121 |
| Japan       |                  52 |
| New Zealand |                 149 |
| Norway      |                  85 |
| Philippines |                  26 |
| Singapore   |                  79 |
| Spain       |                 342 |
| Sweden      |                  57 |
| Switzerland |                  31 |
| UK          |                 144 |
| USA         |                1004 |
+-------------+---------------------+

6.Listado de productos más vendidos de cada categoría. De cada producto se desea saber su código id, nombre y categoría, además del total de ventas.

select p.productoId, p.productoNombre, p.categoriaId, sum(pd.cantidadPedida)
from productos p, pedidodetalles pd
where p.productoId = pd.productoId and pd.cantidadPedida = (
    select max(pd_.cantidadPedida)
    from pedidodetalles pd_ join productos p_ on p_.productoId = pd_.productoId
    where p_.categoriaId = p.categoriaId
    )
group by p.categoriaId;
+------------+---------------------------------------+----------------------+------------------------+
| productoId | productoNombre                        | categoriaId          | sum(pd.cantidadPedida) |
+------------+---------------------------------------+----------------------+------------------------+
| S700_2466  | America West Airlines B757-200        | Aviones              |                     85 |
| S700_2047  | HMS Bounty                            | Barcos               |                     55 |
| S24_2300   | 1962 Volkswagen Microbus              | Camiones y Autobuses |                     70 |
| S12_4675   | 1969 Dodge Charger                    | Coches clásicos      |                     97 |
| S18_1749   | 1917 Grand Touring Sedan              | Coches Vintage       |                     76 |
| S10_1678   | 1969 Harley Davidson Ultimate Chopper | Motociletas          |                    198 |
| S50_1514   | 1962 City of Detroit Streetcar        | Trenes               |                     51 |
+------------+---------------------------------------+----------------------+------------------------+


7. Clientes que hayan pedido la mayor cantidad de un producto de cada categoria

select distinct(c.clienteId), c.clienteNombre, pr.productoNombre, pr.categoriaId
from clientes c, pedidos p, pedidodetalles pd, productos pr
where c.clienteId = p.clienteId and p.pedidoId = pd.pedidoId and pd.productoId = pr.productoId and pd.cantidadpedida =
    (
    select max(pd_.cantidadPedida)
    from pedidodetalles pd_ join productos p_ on p_.productoId = pd_.productoId
    where p_.categoriaId = pr.categoriaId
    )
group by pr.categoriaId;

+-----------+---------------------------+---------------------------------------+----------------------+
| clienteId | clienteNombre             | productoNombre                        | categoriaId          |
+-----------+---------------------------+---------------------------------------+----------------------+
|       328 | Tekni Collectables Inc.   | America West Airlines B757-200        | Aviones              |
|       398 | Tokyo Collectables, Ltd   | HMS Bounty                            | Barcos               |
|       141 | Euro+ Shopping Channel    | 1962 Volkswagen Microbus              | Camiones y Autobuses |
|       209 | Mini Caravy               | 1969 Dodge Charger                    | Coches clásicos      |
|       450 | The Sharp Gifts Warehouse | 1917 Grand Touring Sedan              | Coches Vintage       |
|       141 | Euro+ Shopping Channel    | 1969 Harley Davidson Ultimate Chopper | Motociletas          |
|       175 | Gift Depot Inc.           | 1962 City of Detroit Streetcar        | Trenes               |
+-----------+---------------------------+---------------------------------------+----------------------+

8. Listado de oficinas que tengan clientes de francia(France)

select distinct(o.oficinaId), o.ciudad
from oficinas o 
where o.oficinaId in (
    select e.oficinaId
    from empleados e join clientes c on c.empleadoNumero = e.empleadoId
    where c.pais = 'France'
);

+-----------+--------+
| oficinaId | ciudad |
+-----------+--------+
| 4         | Paris  |
+-----------+--------+

9. Listado de clientes de españa que hayan pedido aviones o motocicletas

select distinct(c.clienteId), c.clienteNombre
from clientes c, pedidos p, pedidodetalles pd
where c.clienteId = p.clienteId and p.pedidoId = pd.pedidoId and c.pais = 'Spain' and pd.productoId in (

    select p_.productoId
    from productos p_
    where p_.categoriaId = 'Aviones' or p_.categoriaId = 'Motocicletas'
)
group by clienteId;

+-----------+------------------------+
| clienteId | clienteNombre          |
+-----------+------------------------+
|       141 | Euro+ Shopping Channel |
|       216 | Enaco Distributors     |
+-----------+------------------------+

/* O poner distict o poner group by*/














