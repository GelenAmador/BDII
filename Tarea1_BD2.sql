use BD2

create table Hotel (
	codigo_Hotel Varchar(6) not null primary key,
	nombre varchar(60) not null,
	dirección Varchar(60)
)

create table Cliente(
	DNI varchar(8) not null primary key,
	nombre varchar(60) not null,
	telefono varchar(12) not null,
	codigo_Boleto Varchar(6) not null
)

create table Boleto (
	codigo_Boleto Varchar(6) not null primary key,
	no_vuelo integer not null, 
	fecha date not null,
	destino Varchar(60) not null
)

create table Aerolinia(
	codigo_Aerolinia Varchar(6) not null primary key,
	descuento NVarchar(5) not null,
	codigo_Boleto Varchar(6) not null
) 


create table reserva(
	codigo_Hotel Varchar(6) not null,
	DNI varchar(8) not null,
	fechain Date not null,
	fechaOut Date not null,
	catidad_Personas Integer default 0
);


alter table reserva add constraint pk_reserva
primary key (codigo_Hotel,DNI)

alter table Cliente add constraint fk_boleto_cliente
foreign key (codigo_Boleto) references Boleto(codigo_Boleto)

alter table Aerolinia add constraint fk_boleto_aerolinia
foreign key (codigo_Boleto) references Boleto(codigo_Boleto)

alter table Reserva add constraint fk_hotel_cliente
foreign key (codigo_Hotel) references Hotel(codigo_Hotel)

alter table Reserva add constraint fk_cliente_reser
foreign key (DNI) references Cliente(DNI)

alter table Boleto add constraint ck_destino
check (destino in ('México','Guatemala','Panamá'))

alter table Aerolinia add constraint ck_descuento
check (descuento >= '10')


insert Boleto values(
	'123456', 1 , '13/4/23', 'México'
)

--Este no da por la restricción:
insert Boleto values(
	'123456', 1 , '13/4/23', 'Mexico'
)

insert Aerolinia values(
	'123456', '9', '342'
)

--Este no da por la restricción:
insert Aerolinia values(
	'123456', '5', '342'
)
