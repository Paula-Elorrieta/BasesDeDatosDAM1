create or replace view ArticulosBaratos
as
select DesArt as "Descripcion articulo", PVPArt as Precio
from articulo
where PVPArt <= 0.5;

create or replace view ArticulosBaratos (Descripcion, Precio)
as
select DesArt, PVPArt 
from articulo
where PVPArt <= 0.5;

select * 
from ArticulosBaratos;

DROP view ArticulosPedidos;

create or replace view ArticulosPedidos (CodigoArticulo, Descripcion, NumPedidos, Unidades) as
select a.CodArt, a.DesArt, count(refped), sum(CantArt)
FROM articulo a join lineapedido l using (CodArt)
				join pedido p using (refped)
group by CodArt, DesArt
having count(refped) > 1;