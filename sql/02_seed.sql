-- Poblado inicial de datos
INSERT INTO lectores (nombre, apellido, email, fecha_nacimiento) VALUES
('Juan Alberto', 'Cortéz', 'juancortez@gmail.com', '1983-06-20'),
('Antonia', 'de los Ríos', 'antoniarios_23@yahoo.com', '1978-11-24'),
('Nicolás', 'Martin', 'nico_martin23@gmail.com', '1986-07-11'),
('Néstor', 'Casco', 'nestor_casco2331@hotmail.com', '1981-02-11'),
('Lisa', 'Pérez', 'lisperez@hotmail.com', '1994-08-11'),
('Ana Rosa', 'Estagnolli', 'anros@abcdatos.com', '1974-10-15'),
('Milagros', 'Pastoruti', 'mili_2231@gmail.com', '2001-01-22'),
('Pedro', 'Alonso', 'alonso.pedro@impermeabilizantesrosario.com', '1983-09-05'),
('Arturo Ezequiel', 'Ramírez', 'artu.rama@outlook.com', '1998-03-29'),
('Juan Ignacio', 'Altarez', 'juanaltarez.223@yahoo.com', '1975-08-24');

INSERT INTO libros (nombre_libro, editorial, autor, isbn) VALUES
('Cementerio de animales', 'Ediciones de Mente', 'Stephen King', 4568874),
('En el nombre de la rosa', 'Editorial España', 'Umberto Eco', 44558877),
('Cien años de soledad', 'Sudamericana', 'Gabriel García Márquez', 7788845),
('El diario de Ellen Rimbauer', 'Editorial Maine', 'Stephen King', 45699874),
('La hojarasca', 'Sudamericana', 'Gabriel García Márquez', 7787898),
('El amor en los tiempos del cólera', 'Sudamericana', 'Gabriel García Márquez', 2564111),
('La casa de los espíritus', 'Ediciones Chile', 'Isabel Allende', 5544781),
('Paula', 'Ediciones Chile', 'Isabel Allende', 22545447),
('La tregua', 'Alfa', 'Mario Benedetti', 2225412),
('Gracias por el fuego', 'Alfa', 'Mario Benedetti', 88541254);

-- Préstamos iniciales
INSERT INTO libros_lectores (id_lectores, id_libros) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 2), (3, 3), (3, 4), (3, 5), (3, 6),
(4, 2), (4, 4), (4, 5), (4, 3), (4, 6),
(5, 7), (5, 8), (5, 2),
(6, 4), (6, 5), (6, 6),
(7, 3), (7, 4), (7, 5),
(8, 3), (8, 4),
(9, 7), (9, 8);
