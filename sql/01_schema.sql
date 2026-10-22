-- Creación de la base de datos y tablas principales
CREATE TABLE lectores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

CREATE TABLE libros (
    id SERIAL PRIMARY KEY,
    nombre_libro VARCHAR(100) NOT NULL,
    editorial VARCHAR(50) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    isbn BIGINT UNIQUE NOT NULL
);

CREATE TABLE libros_lectores (
    id_lectores INT REFERENCES lectores(id) ON DELETE CASCADE,
    id_libros INT REFERENCES libros(id) ON DELETE CASCADE,
    PRIMARY KEY (id_lectores, id_libros)
);
