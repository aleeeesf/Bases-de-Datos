1.Listado de empleados de las oficinas que no son del país USA.

select * 
from empleados 
where empleados.oficinaId not in (
    select OficinaId 
    from oficinas 
    where pais != 'USA');
+------------+-----------+----------+-----------+---------------------------------+
| empleadoId | apellido  | nombre   | extension | email                           | 
+------------+-----------+----------+-----------+---------------------------------+
|       1002 | Murphy    | Diane    | x5800     | dmurphy@classicmodelcars.com    |
|       1056 | Patterson | Mary     | x4611     | mpatterso@classicmodelcars.com  | 
|       1076 | Firrelli  | Jeff     | x9273     | jfirrelli@classicmodelcars.com  | 
|       1143 | Bow       | Anthony  | x5428     | abow@classicmodelcars.com       | 
|       1165 | Jennings  | Leslie   | x3291     | ljennings@classicmodelcars.com  | 
|       1166 | Thompson  | Leslie   | x4065     | lthompson@classicmodelcars.com  |
|       1188 | Firrelli  | Julie    | x2173     | jfirrelli@classicmodelcars.com  |  
|       1216 | Patterson | Steve    | x4334     | spatterson@classicmodelcars.com |   
|       1286 | Tseng     | Foon Yue | x2248     | ftseng@classicmodelcars.com     |
|       1323 | Vanauf    | George   | x4102     | gvanauf@classicmodelcars.com    | 
+------------+-----------+----------+-----------+---------------------------------+

2.Listado de clientes que no ha realizado ningún pedido.

select clienteNombre 
from clientes 
where clienteId not in (select clienteId from pedidos);
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
select categoriaId,stock 
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

select productos.productoId, productoNombre, categoriaId, count(pedidodetalles.pedidoId) 
from productos, pedidodetalles 
where productos.productoId = pedidodetalles.productoId 
group by productos.categoriaId;
+------------+---------------------------------------+----------------------+--------------------------------+
| productoId | productoNombre                        | categoriaId          | count(pedidodetalles.pedidoId) |
+------------+---------------------------------------+----------------------+--------------------------------+
| S18_1662   | 1980s Black Hawk Helicopter           | Aviones              |                            336 |
| S18_3029   | 1999 Yamaha Speed Boat                | Barcos               |                            245 |
| S12_1666   | 1958 Setra Bus                        | Camiones y Autobuses |                            308 |
| S10_1949   | 1952 Alpine Renault 1300              | Coches clásicos      |                           1010 |
| S18_1342   | 1937 Lincoln Berline                  | Coches Vintage       |                            657 |
| S10_1678   | 1969 Harley Davidson Ultimate Chopper | Motociletas          |                            359 |
| S18_3259   | Collectable Wooden Train              | Trenes               |                             81 |
+------------+---------------------------------------+----------------------+--------------------------------+








