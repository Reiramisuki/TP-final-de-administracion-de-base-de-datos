/* Trabajo Practico Final    ALUMNA: Elizabeth Belén Silva
1) Crear 2 o 3 párrafos de especificaciones a partir del cual un Analista deberá recolectar datos para poder diseñar una Base de Datos.

Casa de pasta.
En una casa de pasta ubicada en Hurlingham, buenos aires, donde preparan distintos productos 
gastronomicos.
Su menu gastronomico se encuentra compuesto por dos tipos : las comidas y las bebidas.Comidas como los 
sorrentinos y ravioles, se caracterizan por haber dos tipos de rellenos, que son verdura y ricota en el 
caso de los ravioles, mientras que los sorrentinos hay de relleno de jamon y queso o masa de verdura y relleno de verdura.

Posee un historial de pedidos de sus clientes,con la fecha correspondiente.Donde figura que compraron, el cliente 
con su informacion.Tambien registra el medio de pago utilizado: efectivo, transferencia, mercado pago, uala, tarjeta de debito 
y tarjeta de credito.Asi como los demas detalles de la compra(pedido).

La casa de pasta posee un registro de clientes, donde informa del nombre,apellido, domicilio y un contacto. Un cliente puede realizar una o 
varias compras, y en estas compras puede contener uno o varios elementos del menu gastronomico, de esta relacion surge la factura de pedidos(compra). 
Cada factura posee un detalle que describe lo comprado del menu y la cantidad.

2) Determinar las entidades relevantes al Sistema.

		Cliente, Factura(pedido), detalles del pedido y menú.


3) Determinar los atributos de cada entidad.
Cliente:					Factura:										Detalles del pedido:	Menú:
-ID cliente                 |-ID factura (numero)							|-ID factura			|-ID Menú
-Nombre y apellido			|-Letra (a,b,c)									|-ID Menú			    |-Tipo:	- Comidas
-Direccion y entre calles	|-Fecha											|-Descripción			|		- Bebidas
-Contacto					|-ID Cliente									|-Precio unitario		|-Descripción		
-Medio de pago favorito		|-Nombre Y apellido								|-Cantidad			    |-Precio
							|-Direccion y entre calles						|-Precio FINAL			|
							|-Contacto										|			            |
							|-Detalles de pedido							|						|
							|-Modo de pago:efectivo,transferencia,debito	|						|
							| 				credito,mercado pago y uala		|						|
							|-Forma de entrega: retira del local o			|						|
							|		desea envio a domicilio					|						|

4) Confeccionar el Diagrama de Entidad Relacion (DER), junto al Diccionario de Datos
	Diccionario de datos:
	-Entidades:
			Cliente=@ID_cliente+ Nombre y apellido + Direccion + Contacto + Medio de pago
		
			Factura=@ID_factura + fecha + Modo de pago + Forma de entrega
		
			Menú=@ID_menu + tipo +descripcion + precio 

	- Tipos de objeto Asociativo:	
			Detalles=@ID_factura + @ID_menu + Descripción + Precio unitario + cantidad + precio final

5) Realizar el Diagrama de Tablas e implementar en código SQL la Base de Datos
NOTA: lo q se encuentra comentado es para sql server 
*/
drop database if exists casa_de_pasta
create database casa_de_pasta
GO
use casa_de_pasta
GO
create table clientes( 
	id int  identity(1,1) primary key,
	nombre_apellido varchar(60) not null,
	direccion_entre_calles varchar(max) not null,
	contacto int not null
)
go
create table facturas(
	numero int identity(1,1) primary key,
	letra varchar (1)
		check(letra in ('a','b','c')),
	fecha date,
	id_cliente int null FOREIGN KEY REFERENCES clientes(id),
	nombre_apellido varchar(40) not null,
	direccion_entre_calles varchar(max) not null,
	contacto int not null,
	medio_pago varchar(29)
		check (medio_pago in ('efectivo','tarjeta_debito','tarjeta_credito','tranferencia_bancaria','mercado_pago','uala')),
	Forma_de_entrega varchar (35)
			check(Forma_de_entrega in ('retira del local','envio a domicilio')),
	total money
);
go
create table menus( 
   id int  identity(1,1) primary key,
	tipo varchar(29)
			check(tipo in ('comida','bebida')),
    descripcion varchar(max) not null ,
    precio money
); 
go
create table detalles( 
	numero_factura int foreign key references facturas(numero),
	letra varchar (1)
			check(letra in ('a','b','c')),
    id_menu int not null foreign key references menus(id),
    descripcion varchar(55) not null,
	precio_unitario money,
    cantidad int not null,
    precio_final money,
)
go
/*select * from menus;
select * from clientes; 
select * from facturas;
select * from detalles;*/

-- INSERTO DATOS PARA PROBAR BASE Y PUNTO 6 --
-- inserto detalles de las clientes 
    insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values ('Gabriela,Gonzalez','albania 2343,acassuso y delleva',34345345);
	insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values('Florencia,Silva','acassuso 4949,marques de aviles y alsina',37382839);
    insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values ('Jose,Stuar','felix fria 300, poeta risso y jose andon',29450678);
    insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values ('Maria,Martinez','adrian luna,felix fria y antonio olaguer',33332839);
	insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values('Rosana,Lopez','beethoven 8999,schubert y alejando malaespina',67678904);
    insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values('Margarita,Salones','adrian luna 838,perez galdos y alejandro malaespina',28555959);
    insert into clientes (nombre_apellido,direccion_entre_calles,contacto)values('Estela,Abate','coraceros 2545, wagner y bustamante',28344528);
go
-- Inserto detalles de menus
	insert into menus (tipo,descripcion,precio)  values('comida','plancha de 48 ravioles de verdura',150);
	insert into menus (tipo,descripcion,precio)  values('comida','plancha de 48 ravioles de ricota',150);
    insert into menus (tipo,descripcion,precio)  values('comida','caja de 96 ravioles de verdura',300);
    insert into menus (tipo,descripcion,precio)  values('comida','caja de 96 ravioles de ricota',300);
    insert into menus (tipo,descripcion,precio)  values('comida','caja de sorrentinos 14 de verdura',330);
    insert into menus (tipo,descripcion,precio)  values('comida','caja de sorrentinos 14 de JyQ',330);
    insert into menus (tipo,descripcion,precio)  values('comida','½kg de ñoquis',150);
    insert into menus (tipo,descripcion,precio)  values('comida','½kg de tallarines',150);
    insert into menus (tipo,descripcion,precio)  values('comida','1kg de tallarines',300);
    insert into menus (tipo,descripcion,precio)  values('comida','1kg de ñoquis',300);
    insert into menus (tipo,descripcion,precio)  values('comida','100gr de queso rallado',100);
    insert into menus (tipo,descripcion,precio)  values('comida','pan casero gigante',120);
    insert into menus (tipo,descripcion,precio)  values('comida','pasta frola grande de batata',350);
    insert into menus (tipo,descripcion,precio)  values('comida','pasta frola grande de membrillo ',350);
    insert into menus (tipo,descripcion,precio)  values('comida','pasta frola grande combinada ',350);
    insert into menus (tipo,descripcion,precio)  values('comida','pre-pizza',120);
	insert into menus (tipo,descripcion,precio)  values('comida','lata de tomate perita 400gr',80);
    insert into menus (tipo,descripcion,precio)  values('bebida','coca-cola 2.5lt no retornable',190);
    insert into menus (tipo,descripcion,precio)  values('bebida','coca-cola 2lt retornable',140);
    insert into menus (tipo,descripcion,precio)  values('bebida','7up 2lt retornable',180);
    insert into menus (tipo,descripcion,precio)  values('bebida','anana fizz 750ml',300);
     insert into menus (tipo,descripcion,precio)  values('bebida','jugo en polvo clith',30);
 go    
 -- inserto detalles de las facturas
	insert into facturas (letra,fecha,id_cliente,nombre_apellido,direccion_entre_calles,contacto,medio_pago,forma_de_entrega,total) 
			values ('a','2000/10/26',1,'Gabriela,Gonzalez','albania 2343,acassuso y delleva',34345345,'efectivo','retira del local',150);
	insert into facturas(letra,fecha,id_cliente,nombre_apellido,direccion_entre_calles,contacto,medio_pago,forma_de_entrega,total)
			values ('b','2002/02/15',2,'Florencia,Silva','acassuso 4949,marques de aviles y alsina',37382839,'efectivo','envio a domicilio',900);
	insert into facturas (letra,fecha,id_cliente,nombre_apellido,direccion_entre_calles,contacto,medio_pago,forma_de_entrega,total)
			values ('b','2000/03/20',3,'Jose,Stuar','felix fria 3000, poeta risso y jose andonegui',29450678,'Tarjeta_credito','envio a domicilio',700);
	insert into facturas (letra,fecha,id_cliente,nombre_apellido,direccion_entre_calles,contacto,medio_pago,forma_de_entrega,total)
			values ('b','2000/05/04',4,'Maria,Martinez','adrian luna,felix fria y antonio olaguer',33332839,'Tarjeta_credito','retira del local',1200);
	insert into facturas (letra,fecha,id_cliente,nombre_apellido,direccion_entre_calles,contacto,medio_pago,forma_de_entrega,total)
			values ('b','2001/12/24',5,'Rosana,Lopez','beethoven 8999,schubert y alejando malaespina',67678904,'Tarjeta_debito','envio a domicilio',660);
  go   
-- inserto detalles de las detalles  
	insert into detalles (numero_factura,letra,id_menu,descripcion,precio_unitario,cantidad,precio_final) values(1,'a',2,'plancha de 48 ravioles de verdura',150,1,150);
	insert into detalles (numero_factura,letra,id_menu,descripcion,precio_unitario,cantidad,precio_final) values(2,'b',4,'caja de 96 ravioles de ricota',300,3,900);
  	insert into detalles (numero_factura,letra,id_menu,descripcion,precio_unitario,cantidad,precio_final) values (3,'b',14,'pasta frola grande de membrillo ',350,2,700);
	insert into detalles (numero_factura,letra,id_menu,descripcion,precio_unitario,cantidad,precio_final) values(4,'b',9,'1kg de tallarines',300,4,1200);
	insert into detalles (numero_factura,letra,id_menu,descripcion,precio_unitario,cantidad,precio_final) values(5,'b',6,'caja de sorrentinos 14 de jamon y queso',330,2,660);

select * from clientes;
select * from menus;
select * from facturas;
select * from detalles;

-- 6) Crear al menos 2 consultas relacionadas para poder probar la Base de Datos.
-- descripcion de factura
select f.letra,f.numero,f.fecha,f.id_cliente,c.nombre_apellido,c.direccion_entre_calles,c.contacto,m.id,m.descripcion,dt.precio_unitario,dt.cantidad,f.total,f.medio_pago,f.total
 from detalles as dt
 inner join menus as m on dt.id_menu=m.id
 inner join facturas as f on dt.numero_factura=f.numero 
 inner join clientes as c on c.id=f.id_cliente;

-- compras realizadas entre '2000/10/26'  AND '2001/12/24'
 select f.letra,f.numero,f.fecha,f.id_cliente,f.nombre_apellido,f.medio_pago,f.total
 from detalles as dt
 inner join facturas as f on dt.numero_factura=f.numero
 where f.fecha BETWEEN '2000/10/26'  AND '2001/12/24';

--  cliente que mas gasto en una compra con lo mayor gastado
Select * from facturas 
where total= (select max(total)from facturas) ;

-- ultimo numero de factura
select count(*)n_factura from facturas;