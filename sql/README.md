# 📚 Sistema de Gestión e Historial de Biblioteca (PostgreSQL)

Este proyecto implementa el diseño, modelado, automatización y auditoría de un sistema de gestión de préstamos para una biblioteca utilizando **PostgreSQL** y **PL/pgSQL**.

---

## 🚀 Características del Proyecto

- **Modelado Relacional M:N:** Estructura normalizada para gestionar lectores, catálogo de libros y la relación de préstamos activos.
- **Automatización Procedural (PL/pgSQL):** Uso de funciones para agilizar la devolución de ejemplares y la consulta de métricas.
- **Auditoría Automática mediante Triggers:** Registro histórico automático con *timestamp* de cada devolución efectuada.
- **Vistas Analíticas y Consultas de Agregación:** Abstracción de datos complejos mediante vistas y consultas de agregación para el cálculo de estadísticas (promedios de edad, rankings de préstamos, etc.).

---

## 🛠️ Tecnologías Utilizadas

- **Motor de Base de Datos:** PostgreSQL 10+
- **Lenguaje Procedural:** PL/pgSQL
- **Herramienta de Administración:** pgAdmin / DBeaver

---

## 📂 Estructura del Repositorio

```text
sistema-gestion-biblioteca-postgres/
│
├── sql/
│   ├── 01_schema.sql          # Creación de tablas e integridad referencial
│   ├── 02_seed.sql            # Inserción de datos iniciales
│   ├── 03_views.sql           # Vistas reutilizables
│   ├── 04_functions.sql       # Funciones y procedimientos almacenados (PL/pgSQL)
│   ├── 05_triggers.sql        # Sistema de auditoría y triggers
│   └── 06_queries.sql         # Consultas analíticas y reportes
│
└── README.md                  # Documentación del proyecto
```

---

## 🗄️ Esquema de la Base de Datos

### Tablas Principales
* `lectores`: Almacena la información de los usuarios registrados (nombre, apellido, email, fecha de nacimiento).
* `libros`: Catálogo de ejemplares (título, editorial, autor, ISBN).
* `libros_lectores`: Tabla asociativa (clave primaria compuesta) que representa los préstamos activos.
* `devolucion_log`: Tabla de auditoría que registra los préstamos finalizados con fecha y hora.

---

## 🔍 Código Destacado

### 1. Trigger de Auditoría de Devoluciones
Cada vez que se elimina un registro de la tabla `libros_lectores` (representando una devolución), un `TRIGGER` tipo `BEFORE DELETE` guarda los datos en la tabla `devolucion_log`:

```sql
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
```

### 2. Procedimiento Almacenado de Devolución
Lógica encapsulada en PL/pgSQL para realizar la devolución de un libro:

```sql
CREATE OR REPLACE FUNCTION devolver_libro(id_lector INT, id_libro INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM libros_lectores 
    WHERE id_lectores = id_lector 
      AND id_libros = id_libro;
END;
$$ LANGUAGE plpgsql;
```

---

## 💻 Instrucciones de Ejecución

Para desplegar la base de datos localmente:

1. Clonar este repositorio:
   ```bash
   git clone https://github.com/MARCELOJAVIERWERNER/sistema-gestion-biblioteca-postgres.git
   ```
2. Conectarse al servidor PostgreSQL desde pgAdmin o CLI (`psql`).
3. Ejecutar los scripts en la carpeta `sql/` siguiendo el orden numérico:
   - `01_schema.sql`
   - `02_seed.sql`
   - `03_views.sql`
   - `04_functions.sql`
   - `05_triggers.sql`
