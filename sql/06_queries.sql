-- Consultas de análisis de datos

-- 1. Frecuencia de préstamo por libro (ordenado de mayor a menor)
SELECT b.nombre_libro, COUNT(ll.id_libros) AS cantidad_prestamos
FROM libros b
LEFT JOIN libros_lectores ll ON b.id = ll.id_libros
GROUP BY b.id, b.nombre_libro
ORDER BY cantidad_prestamos DESC;

-- 2. Cantidad de libros prestados por lector
SELECT l.nombre, l.apellido, COUNT(ll.id_libros) AS total_prestados
FROM lectores l
LEFT JOIN libros_lectores ll ON l.id = ll.id_lectores
GROUP BY l.id, l.nombre, l.apellido
ORDER BY total_prestados DESC;

-- 3. Métricas de edad de lectores
SELECT 
    ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))), 1) AS promedio_edad,
    MAX(EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))) AS edad_maxima,
    MIN(EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_nacimiento))) AS edad_minima
FROM lectores;

-- 4. Consulta sobre vista para un lector específico
SELECT * FROM libros_prestados 
WHERE nombre_lector = 'Pedro' AND apellido = 'Alonso';
