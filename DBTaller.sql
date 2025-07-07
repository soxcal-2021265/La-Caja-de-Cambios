drop database if exists DB_Taller;
create database DB_Taller;
use DB_Taller;

-- empleado
create table Empleado(
	codigoEmpleado int not null auto_increment,
    nombreEmpleado varchar(250) not null,
    telefonoEmpleado char(8) not null unique,
    correoEmpleado varchar(250) not null unique,
    direccion varchar(250),
    puesto enum ("Recepcionista","Mecanico"),
    primary key PK_codigoEmpleado(codigoEmpleado)
);

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

-- ACCESORIOS
create table Accesorio(
	codigoAccesorio int not null auto_increment,
    nombreAccesorio varchar(250) not null,
    descripcionAccesorio varchar(250)not null,
    precioAccesorio double (10,2)not null,
    stockAccesorio int,
    estadoAccesorio enum("Disponibles","Agotados") not null,
    primary key PK_codigoAccesorio(codigoAccesorio)
);

-- Servicios / mantenimientos
create table Servicio(
	codigoServicio int not null auto_increment,
    nombreServicio varchar(250) not null,
    descripcionServicio varchar(250)not null,
    precioServicio double(10,2)not null,
    primary key PK_codigoServicio(codigoServicio)
);


-- ---------------------------------SP EMPLEADOS ------------------------------------

-- Agregar --
DELIMITER //
CREATE PROCEDURE sp_AgregarEmpleado(
    IN nEmpleado VARCHAR(250),
    IN tEmpleado CHAR(8),
    IN coEmpleado VARCHAR(250),
    IN dEmpleado VARCHAR(250), 
    IN pEmpleado ENUM('Recepcionista','Mecanico')
)
BEGIN
    INSERT INTO Empleado (nombreEmpleado, telefonoEmpleado, correoEmpleado, direccion, puesto)
    VALUES (nEmpleado, tEmpleado, coEmpleado, dEmpleado, pEmpleado);
END //
DELIMITER ;

CALL sp_AgregarEmpleado('Camila', '33727865', 'camila@gmail.com', 'Zona 8', 'Recepcionista');
CALL sp_AgregarEmpleado('Luis', '44928374', 'luis@gmail.com', 'Zona 1', 'Mecanico');
CALL sp_AgregarEmpleado('Andrea', '32018745', 'andrea@gmail.com', 'Zona 7', 'Recepcionista');
CALL sp_AgregarEmpleado('Carlos', '55429873', 'carlos@gmail.com', 'Zona 2', 'Mecanico');
CALL sp_AgregarEmpleado('Paola', '33098745', 'paola@gmail.com', 'Zona 5', 'Recepcionista');
CALL sp_AgregarEmpleado('Jorge', '44982736', 'jorge@gmail.com', 'Zona 4', 'Mecanico');
CALL sp_AgregarEmpleado('María', '30129873', 'maria@gmail.com', 'Zona 9', 'Recepcionista');
CALL sp_AgregarEmpleado('Pedro', '44990123', 'pedro@gmail.com', 'Zona 2', 'Mecanico');
CALL sp_AgregarEmpleado('Lucía', '33724567', 'lucia@gmail.com', 'Zona 6', 'Recepcionista');
CALL sp_AgregarEmpleado('José', '55890123', 'jose@gmail.com', 'Zona 10', 'Mecanico');
CALL sp_AgregarEmpleado('Mario', '66338542', 'mario@gmail.com', 'Zona 11', 'Mecanico');

-- Listar --
DELIMITER //
CREATE PROCEDURE sp_ListarEmpleado()
BEGIN
    SELECT  codigoEmpleado, nombreEmpleado, telefonoEmpleado, correoEmpleado, direccion, puesto FROM Empleado;
END //
DELIMITER ;

CALL sp_ListarEmpleado();

-- Eliminar --
DELIMITER //
CREATE PROCEDURE sp_EliminarEmpleado(IN cEmpleado INT)
BEGIN
	DELETE FROM Empleado WHERE codigoEmpleado = cEmpleado;
END //
DELIMITER ;
CALL sp_EliminarEmpleado(3);

-- Buscar --
DELIMITER //
CREATE PROCEDURE sp_BuscarEmpleado(IN cEmpleado INT)
BEGIN
    SELECT codigoEmpleado, nombreEmpleado, telefonoEmpleado, correoEmpleado, direccion, puesto FROM Empleado WHERE codigoEmpleado = cEmpleado;
END //
DELIMITER ;
CALL sp_BuscarEmpleado(5);

-- Editar --
DELIMITER //
CREATE PROCEDURE sp_EditarEmpleado(
	IN cEmpleado INT,
    IN nEmpleado VARCHAR(250),
    IN tEmpleado CHAR(8),
    IN coEmpleado VARCHAR(250),
    IN dEmpleado VARCHAR(250), 
    IN pEmpleado ENUM('Recepcionista','Mecanico')
)
BEGIN
    UPDATE Empleado
    SET nombreEmpleado= nEmpleado,
        telefonoEmpleado = tEmpleado,
        correoEmpleado = coEmpleado,
        direccion = dEmpleado,
        puesto = pEmpleado
    WHERE codigoEmpleado = cEmpleado;
END //
DELIMITER ;
CALL sp_EditarEmpleado(4, 'Robereto', '44998877', 'roberto@gmail.com', 'Zona 10', 'Mecanico');

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

-- PROCEDIMIENTOS DE ACCESORIOS
DELIMITER //
CREATE PROCEDURE sp_insertarAccesorio(
    IN p_nombre VARCHAR(250),
    IN p_descripcion VARCHAR(250),
    IN p_precio DOUBLE(10,2),
    IN p_stock INT,
    IN p_estado ENUM('Disponibles','Agotados')
)
BEGIN
    INSERT INTO Accesorio (nombreAccesorio, descripcionAccesorio, precioAccesorio, stockAccesorio, estadoAccesorio)
    VALUES (p_nombre, p_descripcion, p_precio, p_stock, p_estado);
END //
DELIMITER ;

CALL sp_insertarAccesorio ('Filtro de aceite', 'Filtro para motor 4 cilindros', 45.00, 10, 'Disponibles');
CALL sp_insertarAccesorio ('Aceite 10W-30', 'Aceite sintético 1L', 90.00, 15, 'Disponibles');
CALL sp_insertarAccesorio ('Batería 12V', 'Batería de auto estándar', 600.00, 3, 'Disponibles');
CALL sp_insertarAccesorio ('Pastillas de freno', 'Juego delantero para sedán', 150.00, 5, 'Disponibles');
CALL sp_insertarAccesorio ('Limpiaparabrisas', 'Juego de escobillas 20 pulgadas', 75.00, 8, 'Disponibles');
CALL sp_insertarAccesorio ('Fusible universal', 'Fusible de repuesto 10A', 5.00, 0, 'Agotados');
CALL sp_insertarAccesorio ('Anticongelante', 'Botella de refrigerante 1L', 65.00, 6, 'Disponibles');
CALL sp_insertarAccesorio ('Cargador USB', 'Cargador doble para auto', 40.00, 12, 'Disponibles');
CALL sp_insertarAccesorio ('Tapones de válvula', 'Juego de 4 tapones cromados', 20.00, 0, 'Agotados');
CALL sp_insertarAccesorio ('Alfombra de hule', 'Alfombra universal para auto', 130.00, 7, 'Disponibles');
CALL sp_insertarAccesorio ('Soporte para celular', 'Soporte magnético para auto', 60.00, 4, 'Disponibles');

DELIMITER //
CREATE PROCEDURE sp_listarAccesorios()
BEGIN
    SELECT 
        codigoAccesorio,
        nombreAccesorio,
        descripcionAccesorio,
        precioAccesorio,
        stockAccesorio,
        estadoAccesorio
    FROM Accesorio;
END //
DELIMITER ;

CALL sp_listarAccesorios();

DELIMITER //
CREATE PROCEDURE sp_buscarAccesorio(
    IN codigoAc int
)
BEGIN
    SELECT codigoAccesorio, nombreAccesorio, descripcionAccesorio, precioAccesorio, stockAccesorio, estadoAccesorio FROM Accesorio
    WHERE codigoAccesorio = codigoAc;
END //
DELIMITER ;
 
CALL sp_buscarAccesorio(1);

DELIMITER //
CREATE PROCEDURE sp_editarAccesorio(
    IN p_codigo INT,
    IN p_nombre VARCHAR(250),
    IN p_descripcion VARCHAR(250),
    IN p_precio DOUBLE(10,2),
    IN p_stock INT,
    IN p_estado ENUM('Disponibles','Agotados')
)
BEGIN
    UPDATE Accesorio
    SET nombreAccesorio = p_nombre, descripcionAccesorio = p_descripcion, precioAccesorio = p_precio, stockAccesorio = p_stock, estadoAccesorio = p_estado
    WHERE codigoAccesorio = p_codigo;
END //
DELIMITER ;

CALL sp_editarAccesorio(1, 'Filtro de aceite premium', 'Filtro reforzado', 55.00, 8, 'Disponibles');


DELIMITER //
CREATE PROCEDURE sp_eliminarAccesorio(IN p_codigo INT)
BEGIN
    DELETE FROM Accesorio WHERE codigoAccesorio = p_codigo;
END //
DELIMITER ;

CALL sp_eliminarAccesorio(5);

-- Procedimientos almacenados 
-- Procedimiento almacenado de Servicio
-- ----------- Agregar Servicio ------------------
delimiter //
create procedure sp_agregarservicio(
    in nservicio varchar(250),
    in dservicio varchar(250),
    in pservicio double
)
begin
    insert into servicio (nombreservicio, descripcionservicio, precioservicio)
    values (nservicio, dservicio, pservicio);
end //
delimiter ;
call sp_agregarservicio('alineación', 'alineación de ruedas', 150.00);
call sp_agregarservicio('balanceo', 'balanceo de llantas', 120.00);
call sp_agregarservicio('cambio de aceite', 'aceite sintético 10w-30', 200.00);
call sp_agregarservicio('lavado', 'lavado completo interior y exterior', 100.00);
call sp_agregarservicio('diagnóstico', 'escaneo completo del vehículo', 250.00);
call sp_agregarservicio('frenos', 'revisión y cambio de frenos', 300.00);
call sp_agregarservicio('suspensión', 'ajuste y revisión de suspensión', 400.00);
call sp_agregarservicio('pintura', 'pintura general de vehículo', 1200.00);
call sp_agregarservicio('revisión general', 'revisión de 30 puntos', 180.00);
call sp_agregarservicio('electricidad', 'revisión del sistema eléctrico', 350.00);

-- ----------- Listar Servicio ---------------------
delimiter //
create procedure sp_listarservicio()
begin
    select codigoservicio, nombreservicio, descripcionservicio, precioservicio from servicio;
end //
delimiter ;
call sp_listarservicio();

-- ------------ Eliminar Servicio ------------------
delimiter //
create procedure sp_eliminarservicio(in cservicio int)
begin
    delete from servicio where codigoservicio = cservicio;
end //
delimiter ;
-- call sp_eliminarservicio(3);

-- ---------------- Buscar Servicio ------------
delimiter //
create procedure sp_buscarservicio(in cservicio int)
begin
    select codigoservicio, nombreservicio, descripcionservicio, precioservicio 
    from servicio 
    where codigoservicio = cservicio;
end //
delimiter ;
call sp_buscarservicio(5);

-- -------------- Editar Servicio ---------------
delimiter //
create procedure sp_editarservicio(
    in cservicio int,
    in nservicio varchar(250),
    in dservicio varchar(250),
    in pservicio double
)
begin
    update servicio
    set nombreservicio = nservicio,
        descripcionservicio = dservicio,
        precioservicio = pservicio
    where codigoservicio = cservicio;
end //
delimiter ;
call sp_editarservicio(4, 'lavado premium', 'lavado con cera y desinfección interior', 180.00);