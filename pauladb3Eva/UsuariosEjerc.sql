CREATE ROLE RolGizaBaliabideak;

GRANT create, alter, drop, select 
on db_enpresa.*
to RolGizaBaliabideak;

grant insert, update(postua, idBurua, soldata, komisioa, saila)
on db_empresa.langilea
to  RolGizaBaliabideak;

show grants for RolGizaBaliabideak;

create user GB1 identified by '12345', 
GB2 identified by '12345'
default role RolGizaBaliabideak
password expire interval 30 day;

use mysql;

select *
from user;

show grants for GB2;

create user adminPedidos
identified by "1111";

grant all privileges on pedidos.* to adminPedidos with grant option;

select user();

create user consulPedidos;

grant select, drop, create, alter, create view, index on peddios.* to consulPedidos;

show grants for consulPedidos;

create user procpedidos@localhost identified by "pako"
with max_queries_per_hour 30
	max_user_connections 4;
    
create user modpedidos;

grant select, delete, insert, update(DesArt, PVPArt);