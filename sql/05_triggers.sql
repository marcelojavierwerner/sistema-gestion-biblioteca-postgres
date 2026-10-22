-- Auditoría de devoluciones
CREATE TABLE IF NOT EXISTS devolucion_log (
    id_lectores INT NOT NULL,
    id_libros INT NOT NULL,
    fecha TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION funcion_tr_delete() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO devolucion_log(id_lectores, id_libros, fecha)
    VALUES (OLD.id_lectores, OLD.id_libros, NOW());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete 
BEFORE DELETE ON libros_lectores
FOR EACH ROW
EXECUTE PROCEDURE funcion_tr_delete();
