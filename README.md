# 📚 Sistema de Gestión e Historial de Biblioteca (PostgreSQL)

Proyecto de diseño, implementación y auditoría de una base de datos relacional en **PostgreSQL** para la gestión de préstamos, devoluciones y trazabilidad de lectores y libros.

---

## 🛠️ Tecnologías Utilizadas

* **Motor de BD:** PostgreSQL 10+
* **Lenguaje Procedural:** PL/pgSQL
* **Herramientas:** pgAdmin / DBeaver

---

## 🗂️ Modelo de Datos & Arquitectura

El esquema contempla una relación M:N (muchos a muchos) entre `lectores` y `libros` gestionada mediante la tabla intermedia `libros_lectores`, además de un sistema de trazabilidad automática mediante `devolucion_log`.

### Entidades Principales
* `lectores`: Registro de usuarios y datos de contacto/nacimiento.
* `libros`: Catálogo de obras, autores, editoriales e ISBN.
* `libros_lectores`: Tabla asociativa que gestiona los préstamos activos.
* `devolucion_log`: Tabla de auditoría para registro histórico de devoluciones.

---

## ⚙️ Características Técnicas Destacadas

### 1. Auditoría Automática con Triggers
Implementación de un `TRIGGER` tipo `BEFORE DELETE` en la tabla asociativa de préstamos para almacenar automáticamente la auditoría de devoluciones con fecha/hora (`timestamp`):

```sql
CREATE TABLE devolucion_log (
    id_lectores INTEGER NOT NULL,
    id_libros INTEGER NOT NULL,
    fecha TIMESTAMP
);

CREATE OR REPLACE FUNCTION funcion_tr_delete() RETURNS TRIGGER AS $$
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
```

---

### 2. Automatización de Devoluciones (Stored Procedure)
Lógica encapsulada en PL/pgSQL para procesar la devolución de ejemplares mediante identificadores de lector y libro:

```sql
CREATE OR REPLACE FUNCTION devolverLibro(idLector INT, idLibro INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM libros_lectores 
    WHERE libros_lectores.id_lectores = idLector
      AND libros_lectores.id_libros = idLibro;
END;
$$ LANGUAGE plpgsql;
```

---

### 3. Vistas para Consultas Frecuentes
Uso de `INNER JOIN` para unificar el catálogo y consultar datos consolidados de préstamos activos:

```sql
CREATE VIEW libros_prestados AS 
SELECT 
    l.nombre_lector, 
    l.apellido, 
    b.nombre_libro,
    b.nombre_de_la_editorial, 
    b.ISBN_del_libro 
FROM libros_lectores ll
INNER JOIN lectores l ON ll.id_lectores = l.id
INNER JOIN libros b ON ll.id_libros = b.id;
```
