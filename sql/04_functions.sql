-- Función para consultar cantidad prestada de un libro
CREATE OR REPLACE FUNCTION cantidad_libros_prestados(id_libro INT) 
RETURNS BIGINT AS $$
    SELECT COUNT(id_libros) FROM libros_lectores WHERE id_libros = $1;
$$ LANGUAGE SQL;

-- Procedimiento para devolución de libros
CREATE OR REPLACE FUNCTION devolver_libro(id_lector INT, id_libro INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM libros_lectores 
    WHERE id_lectores = id_lector 
      AND id_libros = id_libro;
END;
$$ LANGUAGE plpgsql;
