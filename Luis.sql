

use hotel
go

--• Inserte el tipo de servicio OCIO.

insert into tipo_servicio (nombreServicio) values ('Ocio')

select * from tipo_servicio
--• De de alta una reserva de la habitación 101 para el cliente 12345 para las noches del 2 al 4 de julio de 2009. El código de la reserva es autonumérico.

insert into reserva_habitac  ([FechaENTRADA]
           ,[FechaSALIDA]
           ,[IVA]
           ,[NumHABITACION]
           ,[CLIENTE])
values ('02-07-2009','04-07-2009',0.16,101,'12345')


--Actualizaciones
--• Actualice el teléfono del cliente 12345. Su nuevo número es 123456789.
select * from clientes where identificacion=12345

update clientes set telefono='123456789' where identificacion=12345

--• Actualice el precio de los servicios incrementándolos en un 2%.

update servicios set precio=precio*1.02

--Borrados
--• Borre la reserva de la habitación 101 realizada anteriormente.
delete from reserva_habitac where idreserva=8

delete from reserva_habitac where cliente=12345 and 
fechaentrada='02-07-2009' and numhabitacion=101

--• Borre los tipos de servicio que no tienen servicios definidos.
delete from tipo_servicio 
 where nombreServicio not in (select nombreservicio from servicios)

select * from tipo_Servicio

-- CONSULTAS
-- • Crea una vista que devuelva los clientes cuyo apellido incluya la sílaba “le” ordenados por su identificador.

select * from clientes where 
apellido1 like '%le%'
order by apellido1

-- • Crea una vista que devuelva los clientes, ordenados por su primer apellido, que tengan alguna observación anotada.
select * from clientes where observaciones is not null
order by apellido1


--• Crea una vista que devuelva los servicios cuyo precio supere los 5 € ordenados por su código de servicio.
SELECT * FROM DBO.servicios 
WHERE (precio>5)
order by idservicios

-- • Cree una consulta que devuelva las habitaciones reservadas para el día 24 de marzo de 2009.
select numhabitacion from reserva_habitac
where '24/03/2009' betwen fechaentrada and fechasalida

-- • Cree una consulta que devuelva los clientes procedentes de España y Francia.
select * from clientes where pais in ('España','Francia')


-- • Crea una vista que devuelva los clientes que han utilizado el servicio de comedor.

SELECT servicios.NombreSERVICIO, servicios.IVA, servicios.Fecha,
 clientes.Nombre, clientes.Apellido1, gastos.idSERVICIOS AS Expr1
FROM  servicios INNER JOIN
      gastos ON servicios.idSERVICIOS = gastos.idSERVICIOS INNER JOIN
      reserva_habitac ON gastos.idRESERVA = reserva_habitac.idRESERVA INNER JOIN
      clientes ON reserva_habitac.CLIENTE = clientes.Identificacion
WHERE (servicios.NombreSERVICIO = 'comedor')

SELECT servicios.NombreSERVICIO, servicios.IVA, servicios.Fecha,
 clientes.Nombre, clientes.Apellido1, gastos.idSERVICIOS AS Expr1
FROM  servicios ,
      gastos ,
      reserva_habitac ,
      clientes 
WHERE (servicios.NombreSERVICIO = 'comedor')
and
servicios.idSERVICIOS = gastos.idSERVICIOS and
gastos.idRESERVA = reserva_habitac.idRESERVA and
reserva_habitac.CLIENTE = clientes.Identificacion



--• Crea una vista que devuelva las características de cada habitación reservada.
	select t.*,h.numhabitacion
	from habitaciones h, tipo_habitacion t, reserva_habitac r
	where h.NumHABITACION = r.NumHABITACION and h.TIPO_HABITACION = t.categoria

-- • Cree una consulta que devuelva los precios de los distintos tipos de habitación por temporada.

SELECT     precio_habitacion.TIPO_HABITACION, precio_habitacion.Precio,
           temporada.FechaINICIO, temporada.FechaFINAL, temporada.Tipo
FROM         precio_habitacion INNER JOIN
             temporada ON precio_habitacion.TEMPORADA = temporada.TEMPORADA

--• Cree una consulta que devuelva todos los clientes, y de aquellos que han realizado
-- alguna reserva en marzo, indicar el nº de reserva.
select c.*,r.idreserva 
from clientes c left join reserva_habitac  r on c.identificacion=r.cliente
and  fechaentrada between '01-03-2009' and '30-03-2009'


--• Crea una vista con los servicios que nunca han sido contratados.
select distinct * from servicios
where not exists (select * from gastos
where gastos.idSERVICIOS=servicios.idSERVICIOS)

SELECT DISTINCT servicios.*
    FROM servicios where idservicios not in (
           select idservicios from 
                gastos   )


-- • Cree una consulta que devuelva los clientes con el mismo primer apellido.
select c.identificacion, c.apellido1, a.apellido1 
from clientes c, clientes a
where c.identificacion<>a.identificacion and c.apellido1=a.apellido1

select * from clientes
INSERT INTO  clientes  VALUES ('22233', 'ESPAÑA', 'Felipe', 'Iglesias', 'López', 'Avda Los Castros, 44', '942344444', 'Buen cliente');
delete from clientes where identificacion='22233'


--GROUP BY
--• Crea una vista que devuelva el nº de clientes por nacionalidad.
select  pais,COUNT( identificacion) AS NUMERO
FROM CLIENTES GROUP BY pais


--• Crea una vista que devuelva el nº de habitaciones por categoría de habitación.
select count(*) , tipo_habitacion,camas, exterior 
from habitaciones h, tipo_habitacion t
where  h.tipo_habitacion=t.categoria
group by tipo_habitacion,camas,exterior

--• Crea una vista que devuelva el nº de servicios que se ofrecen por tipo de servicio.

select tipo_servicio.nombreservicio,count(idservicios) as cantidad
	from tipo_servicio inner join servicios
	on tipo_servicio.nombreservicio=servicios.nombreservicio
	group by tipo_servicio.nombreservicio
    having count(*) >1

--• Cree una consulta que devuelva el gasto en servicios realizado por cada reserva.
SELECT gastos.idreserva, SUM(gastos.Cantidad * gastos.Precio) AS total
FROM  gastos
GROUP BI gastos.idreserva



