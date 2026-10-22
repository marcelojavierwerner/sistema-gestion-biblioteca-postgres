-- Vista consolidada de préstamos
CREATE OR REPLACE VIEW libros_prestados AS 
SELECT 
    l.nombre AS nombre_lector, 
    l.apellido, 
    b.nombre_libro,
    b.editorial AS nombre_de_la_editorial, 
    b.isbn AS isbn_del_libro 
FROM libros_lectores ll
INNER JOIN lectores l ON ll.id_lectores = l.id
INNER JOIN libros b ON ll.id_libros = b.id;
