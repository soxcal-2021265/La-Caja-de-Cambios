drop database if exists DB_Taller;
create database DB_Taller;
use DB_Taller;

-- CLIENTE/USUARIO
create table Cliente(
	codigoCliente int not null auto_increment,
    nombreCliente varchar(250) not null,
    telefonoCliente char(8)not null unique,
    correoCliente varchar(250) not null unique,
    direccion varchar(250),
    primary key PK_codigoCliente(codigoCliente)
);
-- AUTO
create table Auto(
	codigoAuto int not null auto_increment,
    codigoCliente int not null,    
    placa varchar(7) not null,    
    marca varchar(250),
    modelo varchar(250),
    color varchar(250),
    primary key PK_codigoAuto (codigoAuto),
    constraint FK_Auto_Cliente foreign key (codigoCliente)
		references Cliente (codigoCliente)
);

-- PROCEDIMIENTOS ALMACENADOS
-- CLIENTE

delimiter //
create procedure sp_ListarCliente()
begin
	select codigoCliente, nombreCliente, telefonoCliente, correoCliente, direccion from Cliente;
end //
delimiter ;
call sp_ListarCliente();

delimiter //
create procedure sp_AgregarCliente(
	in nCliente varchar(250),
    in tCliente char(8),
    in cCliente varchar(250),
    in dCliente varchar(250)
    )
begin
	insert into Cliente(nombreCliente, telefonoCliente, correoCliente, direccion)
    values (nCliente, tCliente, cCliente, dCliente);
end //
delimiter ;
call sp_AgregarCliente('Ana López','12345678','ana.lopez@gmail.com','Zona 1');
call sp_AgregarCliente('Carlos Méndez','23456789','carlos.m@gmail.com','Zona 2');
call sp_AgregarCliente('Lucía Torres','34567890','lucia.t@gmail.com','Zona 3');
call sp_AgregarCliente('Mario Ruiz','45678901','mario.r@gmail.com','Zona 4');
call sp_AgregarCliente('Sandra Díaz','56789012','sandra.d@gmail.com','Zona 5');
call sp_AgregarCliente('José Ramírez','67890123','jose.r@gmail.com','Zona 6');
call sp_AgregarCliente('Paola Soto','78901234','paola.s@gmail.com','Zona 7');
call sp_AgregarCliente('Luis Castillo','89012345','luis.c@gmail.com','Zona 8');
call sp_AgregarCliente('Diana Pérez','90123456','diana.p@gmail.com','Zona 9');
call sp_AgregarCliente('Héctor Gómez','10234567','hector.g@gmail.com','Zona 10');
call sp_AgregarCliente('Andrea Cruz','11234567','andrea.c@gmail.com','Zona 11');

delimiter //
create procedure sp_EliminarCliente(in cCliente int)
begin
	delete from Cliente where codigoCliente = cCliente;
end //
delimiter ;
-- call sp_EliminarCliente(6);

delimiter //
create procedure sp_ModificarCliente(
	in cCliente int, 
    in nCliente varchar(250),
    in tCliente char(8),
    in coCliente varchar(250),
    in dCliente varchar(250)
)
begin
	update Cliente
    set nombreCliente = nCliente,
		telefonoCliente = tCliente,
        correoCliente = coCliente,
        direccion = dCliente
	where codigoCliente = cCliente;
end //
delimiter ;
-- call sp_ModificarCliente(1, 'Andre', 12123123, 'asdasd@gmail.com', 'zona 1');

delimiter //
create procedure sp_BuscarCliente(in cCliente int)
begin
	select codigoCliente, nombreCliente, telefonoCliente, correoCliente, direccion from Cliente
    where codigoCliente = cCliente;
end //
delimiter ;
-- call sp_BuscarCliente(1);


-- AUTO
delimiter //
create procedure sp_ListarAuto()
begin
	select codigoAuto, codigoCliente, placa, marca, modelo, color from Auto;
end //
delimiter ;
call sp_ListarAuto();

delimiter //
create procedure sp_AgregarAuto(
	in cCliente int,
    in pAuto varchar(7), 
    in mAuto varchar(250), 
    in moAuto varchar(250), 
    in cAuto varchar(250)
)
begin
	insert into Auto(codigoCliente, placa, marca, modelo, color)
    values(cCliente, pAuto, mAuto, moAuto, cAuto);
end //
delimiter ;
call sp_AgregarAuto(1,'P123AAA','Toyota','Corolla','Blanco');
call sp_AgregarAuto(2,'P234BBB','Honda','Civic','Negro');
call sp_AgregarAuto(3,'P345CCC','Mazda','3','Rojo');
call sp_AgregarAuto(4,'P456DDD','Hyundai','Elantra','Azul');
call sp_AgregarAuto(5,'P567EEE','Kia','Rio','Gris');
call sp_AgregarAuto(6,'P678FFF','Nissan','Versa','Plateado');
call sp_AgregarAuto(7,'P789GGG','Chevrolet','Aveo','Verde');
call sp_AgregarAuto(8,'P890HHH','Ford','Fiesta','Negro');
call sp_AgregarAuto(9,'P901III','Volkswagen','Jetta','Blanco');
call sp_AgregarAuto(10,'P012JJJ','Subaru','Impreza','Azul');
call sp_AgregarAuto(11,'P123KKK','Suzuki','Swift','Rosado');

delimiter //
create procedure sp_EliminarAuto(in cAuto int)
begin
	delete from Auto where codigoAuto = cAuto;
end //
delimiter ;
-- call sp_EliminarAuto(2);

delimiter //
create procedure sp_ModificarAuto(
	in cAuto int,
    in cCliente int,
    in pAuto varchar(7), 
    in mAuto varchar(250),
    in moAuto varchar(250),
    in coAuto varchar(250)
)
begin
	update Auto
    set codigoCliente = cCliente, 
        placa = pAuto,
        marca = mAuto,
        modelo = moAuto, 
        color = coAuto
	where codigoAuto = cAuto;
end //
delimiter ;
-- call sp_ModificarAuto (1, 1, 'P123IOP', 'Supra', 'mk', 'negrito');

delimiter //
create procedure sp_BuscarAuto(in cAuto int)
begin	
	select codigoCliente, placa, marca, modelo, color from Auto
    where codigoAuto = cAuto;
end //
delimiter ;
call sp_BuscarAuto(1);