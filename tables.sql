CREATE DATABASE IF NOT EXISTS app CHARACTER SET="utf8mb4" COLLATE="utf8mb4_unicode_ci";

USE app;

CREATE TABLE IF NOT EXISTS usuario (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR (50)  NOT NULL,
    apellidos VARCHAR (70)  NOT NULL,
    foto_perfil VARCHAR(200),
    direccion VARCHAR (250) NOT NULL,
    ciudad VARCHAR (50) NOT NULL,
    telefono VARCHAR (9),
    email VARCHAR (30) NOT NULL,
    contrasena VARCHAR(12) NOT NULL,
    creation_date TIMESTAMP DEFAULT current_timestamp,
	update_date TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    peticion_libro1 VARCHAR(50),
    peticion_libro2 VARCHAR(50),
    peticion_libro3 VARCHAR(50),
    
    CONSTRAINT email_uq1 UNIQUE (email),
    CONSTRAINT contrasena_ck1 CHECK (length(contrasena) >=8)
);

CREATE TABLE IF NOT EXISTS libro (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    titulo VARCHAR (500)  NOT NULL,
    editorial VARCHAR(100),
    curso VARCHAR(20),
    año YEAR,
    precio FLOAT NOT NULL,
    creation_date TIMESTAMP DEFAULT current_timestamp,
	update_date TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    disponibilidad BOOLEAN DEFAULT TRUE,
    descripcion VARCHAR (500),
    CONSTRAINT libro_id_usuario_fk1
		FOREIGN KEY(id_usuario) REFERENCES usuario(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS images_libro (
	id VARCHAR(100) PRIMARY KEY,
    id_libro INTEGER NOT NULL,
    CONSTRAINT images_libro_id_libro_fk1
		FOREIGN KEY(id_libro) REFERENCES libro(id) ON DELETE RESTRICT
);


CREATE TABLE IF NOT EXISTS transacciones (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_usuario INTEGER,
    id_libro  INTEGER UNIQUE,
    valoracion ENUM('MAL','REGULAR','BIEN','MUY BIEN') NOT NULL,
    estado BOOLEAN DEFAULT false,
    creation_date TIMESTAMP DEFAULT current_timestamp,
	update_date TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    CONSTRAINT transacciones_id_usuario_fk1
		FOREIGN KEY(id_usuario) REFERENCES usuario(id) ON DELETE RESTRICT,
	CONSTRAINT transacciones_id_libro_fk1
		FOREIGN KEY(id_libro) REFERENCES libro(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS mensajes (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
	id_libro INTEGER,
    id_usuario INTEGER,
    mensaje VARCHAR(1000),
    creation_date TIMESTAMP DEFAULT current_timestamp,
    update_date TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    estado_visto BOOLEAN DEFAULT false,
    CONSTRAINT mensajes_id_libro_fk1
		FOREIGN KEY(id_libro) REFERENCES libro(id) ON DELETE RESTRICT,
	CONSTRAINT mensajes_id_usuario_fk1
		FOREIGN KEY(id_usuario) REFERENCES usuario(id) ON DELETE RESTRICT
);

show tables;
