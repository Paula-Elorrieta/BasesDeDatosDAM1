CREATE USER jone IDENTIFIED BY '1234',
ane@localhost IDENTIFIED BY '5678';

use mysql;

desc user;

select * 
from user;

create user santi@localhost identified by '4321'
with 
max_queries_per_hour 100 
max_user_connections 10;

-- Cambiar valores de un usuario
alter user santi@localhost
with max_user_connections 15;

-- Cambiar contraseña
set password for
santi@localhost = '5678';

-- Cambiar nombre
rename user 
santi@localhost to santiago@localhost;

-- Borrar usuario
drop user santiago@localhost;

-- Asignarle TODOS permisos a un usuario
GRANT ALL PRIVILEGES ON *.* TO jone 
WITH GRANT OPTION;

create user paula identified by '1234';
grant all privileges on db_enpresa.* to paula;

