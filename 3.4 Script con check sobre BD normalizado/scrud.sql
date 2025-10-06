-- 1. Verificar todas las tablas creadas en la base de datos
SHOW TABLES;

-- 2. Consultar la estructura de las tablas principales
DESCRIBE instituciones;
DESCRIBE usuarios;
DESCRIBE materias;
DESCRIBE alumnos;

-- 3. Consultas básicas para ver registros (si existen)
SELECT * FROM instituciones;
SELECT * FROM usuarios;
SELECT * FROM materias;
SELECT * FROM personas;
SELECT * FROM tip_usuarios;
SELECT * FROM credeciales;
SELECT * FROM alumnos;
SELECT * FROM calificaciones;
SELECT * FROM actividades;
SELECT * FROM historial_rendimientos;
SELECT * FROM profesores_materias;
SELECT * FROM cursos_capacitaciones;
SELECT * FROM redes_sociales;
SELECT * FROM publicaciones_redes_sociales;

-- 4. Consultas mostrando solo registros activos (deleted = 0)
SELECT * FROM instituciones WHERE deleted = 0;
SELECT * FROM usuarios WHERE deleted = 0;
SELECT * FROM materias WHERE deleted = 0;
SELECT * FROM alumnos WHERE deleted = 0;

-- 5. Consultas para validar relaciones entre tablas
-- Relación usuarios - instituciones
SELECT u.idusuarios, u.nombre_completo, u.email, i.nombre_institucion 
FROM usuarios u 
INNER JOIN instituciones i ON u.instituciones_idinstituciones = i.idinstituciones 
WHERE u.deleted = 0;

-- Relación alumnos - usuarios - instituciones
SELECT a.idalumnos, u.nombre_completo, i.nombre_institucion, a.fecha_ingreso, a.condicion
FROM alumnos a
INNER JOIN usuarios u ON a.usuarios_idusuarios = u.idusuarios
INNER JOIN instituciones i ON a.instituciones_idinstituciones = i.idinstituciones
WHERE a.deleted = 0;

-- Relación materias - instituciones
SELECT m.idmaterias, m.nombre_materias, i.nombre_institucion
FROM materias m
INNER JOIN instituciones i ON m.instituciones_idinstituciones = i.idinstituciones
WHERE m.deleted = 0;

-- 6. Consultas para verificar tipos de usuarios
SELECT tu.idtip_usuarios, u.nombre_completo, p.nombre_tipo, p.nivel_de_acceso
FROM tip_usuarios tu
INNER JOIN usuarios u ON tu.usuarios_idusuarios = u.idusuarios
INNER JOIN personas p ON tu.personas_idpersonas = p.idpersonas
WHERE tu.deleted = 0;

-- 7. Consultas para actividades y calificaciones
SELECT a.idactividades, a.nombre_actividad, m.nombre_materias, u.nombre_completo, c.calificacion
FROM actividades a
INNER JOIN materias m ON a.materias_idmaterias = m.idmaterias
INNER JOIN usuarios u ON a.usuarios_idusuarios = u.idusuarios
INNER JOIN calificaciones c ON a.calificaciones_idcalificaciones = c.idcalificaciones
WHERE a.deleted = 0;

-- 8. Consulta para profesores y las materias que imparten
SELECT pm.idprofesores_materias, u.nombre_completo as profesor, m.nombre_materias as materia
FROM profesores_materias pm
INNER JOIN usuarios u ON pm.usuarios_idusuarios = u.idusuarios
INNER JOIN materias m ON pm.materias_idmaterias = m.idmaterias
WHERE pm.deleted = 0;

-- 9. Consulta para cursos de capacitación
SELECT cc.idcursos_capacitaciones, cc.titulo_curso, u.nombre_completo as instructor, cc.durante_horas
FROM cursos_capacitaciones cc
INNER JOIN usuarios u ON cc.usuarios_idusuarios = u.idusuarios
WHERE cc.deleted = 0;

-- 10. Consulta para verificar integridad referencial
-- Contar registros por tabla para entender el volumen de datos
SELECT 
    'instituciones' as tabla, COUNT(*) as total, SUM(deleted) as eliminados 
FROM instituciones
UNION ALL
SELECT 
    'usuarios' as tabla, COUNT(*) as total, SUM(deleted) as eliminados 
FROM usuarios
UNION ALL
SELECT 
    'alumnos' as tabla, COUNT(*) as total, SUM(deleted) as eliminados 
FROM alumnos
UNION ALL
SELECT 
    'materias' as tabla, COUNT(*) as total, SUM(deleted) as eliminados 
FROM materias;



-- 11. Consulta para historial de rendimiento de alumnos
SELECT hr.idhistorial_rendimientos, u.nombre_completo, hr.promedio_general, hr.periodo, hr.ano, hr.tendencia
FROM historial_rendimientos hr
INNER JOIN alumnos a ON hr.alumnos_idalumnos = a.idalumnos
INNER JOIN usuarios u ON a.usuarios_idusuarios = u.idusuarios
WHERE hr.deleted = 0;




-- Insertar datos en la tabla instituciones
INSERT INTO instituciones (nombre_institucion, direccion, telefono, email, created_at, updated_at, created_by, updated_by, deleted) VALUES
('Colegio Nacional Primero', 'Av. Principal 123', '555-1001', 'info@colegio1.edu', NOW(), NOW(), 1, 1, 0),
('Instituto Técnico Segundo', 'Calle Secundaria 456', '555-1002', 'contacto@instituto2.edu', NOW(), NOW(), 1, 1, 0),
('Escuela Superior Tercera', 'Boulevard Central 789', '555-1003', 'admin@escuela3.edu', NOW(), NOW(), 1, 1, 0);

-- Insertar datos en la tabla personas (tipos de usuarios)
INSERT INTO personas (nombre_tipo, descripcion, nivel_de_acceso, created_at, updated_at, created_by, updated_by, deleted) VALUES
('Administrador', 'Usuario con acceso total', 1, NOW(), NOW(), 1, 1, 0),
('Profesor', 'Usuario que imparte clases', 2, NOW(), NOW(), 1, 1, 0),
('Estudiante', 'Usuario que recibe educación', 3, NOW(), NOW(), 1, 1, 0),
('Coordinador', 'Usuario que coordina áreas', 2, NOW(), NOW(), 1, 1, 0);

-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (nombre_completo, email, fecha_nac, created_at, updated_at, created_by, updated_by, deleted, instituciones_idinstituciones) VALUES
('María González López', 'maria.gonzalez@email.com', '1985-03-15', NOW(), NOW(), 1, 1, 0, 1),
('Carlos Rodríguez Pérez', 'carlos.rodriguez@email.com', '1978-07-22', NOW(), NOW(), 1, 1, 0, 1),
('Ana Martínez Silva', 'ana.martinez@email.com', '1999-11-05', NOW(), NOW(), 1, 1, 0, 1),
('Pedro Sánchez Díaz', 'pedro.sanchez@email.com', '2000-02-28', NOW(), NOW(), 1, 1, 0, 1),
('Laura Fernández Cruz', 'laura.fernandez@email.com', '1982-09-10', NOW(), NOW(), 1, 1, 0, 2),
('Javier Ramírez Ortiz', 'javier.ramirez@email.com', '2001-06-18', NOW(), NOW(), 1, 1, 0, 2),
('Sofía Torres Reyes', 'sofia.torres@email.com', '1998-12-03', NOW(), NOW(), 1, 1, 0, 3);

-- Insertar datos en la tabla credenciales
INSERT INTO credeciales (user, password, created_at, updated_at, created_by, updated_by, deleted, usuarios_idusuarios) VALUES
('maria.gonzalez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 1),
('carlos.rodriguez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 2),
('ana.martinez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 3),
('pedro.sanchez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 4),
('laura.fernandez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 5),
('javier.ramirez', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 6),
('sofia.torres', '$2y$10$rQdS5P8JxU6zWqE9vM8nNe', NOW(), NOW(), 1, 1, 0, 7);

-- Insertar datos en la tabla tip_usuarios
INSERT INTO tip_usuarios (personas_idpersonas, usuarios_idusuarios, created_at, updated_at, created_by, updated_by, deleted) VALUES
(1, 1, NOW(), NOW(), 1, 1, 0),  -- María como Administrador
(2, 2, NOW(), NOW(), 1, 1, 0),  -- Carlos como Profesor
(2, 5, NOW(), NOW(), 1, 1, 0),  -- Laura como Profesor
(3, 3, NOW(), NOW(), 1, 1, 0),  -- Ana como Estudiante
(3, 4, NOW(), NOW(), 1, 1, 0),  -- Pedro como Estudiante
(3, 6, NOW(), NOW(), 1, 1, 0),  -- Javier como Estudiante
(3, 7, NOW(), NOW(), 1, 1, 0),  -- Sofía como Estudiante
(4, 1, NOW(), NOW(), 1, 1, 0);  -- María también como Coordinador

-- Insertar datos en la tabla materias
INSERT INTO materias (nombre_materias, descripcion, created_at, updated_at, created_by, updated_by, deleted, instituciones_idinstituciones) VALUES
('Matemáticas', 'Álgebra, cálculo y geometría', NOW(), NOW(), 1, 1, 0, 1),
('Ciencias Naturales', 'Biología, química y física', NOW(), NOW(), 1, 1, 0, 1),
('Historia', 'Historia universal y nacional', NOW(), NOW(), 1, 1, 0, 1),
('Programación', 'Fundamentos de programación', NOW(), NOW(), 1, 1, 0, 2),
('Bases de Datos', 'Diseño y gestión de bases de datos', NOW(), NOW(), 1, 1, 0, 2),
('Literatura', 'Análisis literario y composición', NOW(), NOW(), 1, 1, 0, 3);

-- Insertar datos en la tabla alumnos
INSERT INTO alumnos (fecha_ingreso, condicion, observaciones, created_at, updated_at, created_by, updated_by, deleted, instituciones_idinstituciones, usuarios_idusuarios) VALUES
('2023-01-15', 1, 'Alumno regular', NOW(), NOW(), 1, 1, 0, 1, 3),
('2023-01-20', 1, 'Buen rendimiento', NOW(), NOW(), 1, 1, 0, 1, 4),
('2023-02-10', 1, 'Esfuerzo constante', NOW(), NOW(), 1, 1, 0, 2, 6),
('2023-02-15', 0, 'Baja temporal', NOW(), NOW(), 1, 1, 0, 3, 7);

-- Insertar datos en la tabla calificaciones
INSERT INTO calificaciones (calificacion, created_at, updated_at, created_by, updated_by, deleted, alumnos_idalumnos) VALUES
(8.5, NOW(), NOW(), 1, 1, 0, 1),
(9.0, NOW(), NOW(), 1, 1, 0, 1),
(7.5, NOW(), NOW(), 1, 1, 0, 2),
(8.0, NOW(), NOW(), 1, 1, 0, 2),
(9.5, NOW(), NOW(), 1, 1, 0, 3),
(8.8, NOW(), NOW(), 1, 1, 0, 3),
(6.5, NOW(), NOW(), 1, 1, 0, 4);

-- Insertar datos en la tabla actividades
INSERT INTO actividades (nombre_actividad, descripcion, tipo_actividad, created_at, updated_at, created_by, updated_by, deleted, materias_idmaterias, usuarios_idusuarios, calificaciones_idcalificaciones) VALUES
('Examen Parcial Matemáticas', 'Evaluación de unidades 1-3', 'Examen', NOW(), NOW(), 1, 1, 0, 1, 2, 1),
('Proyecto Ciencias', 'Investigación sobre ecosistemas', 'Proyecto', NOW(), NOW(), 1, 1, 0, 2, 2, 2),
('Ensayo Histórico', 'Análisis de la revolución industrial', 'Ensayo', NOW(), NOW(), 1, 1, 0, 3, 5, 3),
('Programa Básico', 'Desarrollo de calculadora simple', 'Práctica', NOW(), NOW(), 1, 1, 0, 4, 5, 4);

-- Insertar datos en la tabla historial_rendimientos
INSERT INTO historial_rendimientos (promedio_general, periodo, ano, tendencia, created_at, updated_at, created_by, updated_by, deleted, alumnos_idalumnos) VALUES
(8.7, 'Primer Semestre', 2023, 'Mejorando', NOW(), NOW(), 1, 1, 0, 1),
(7.8, 'Primer Semestre', 2023, 'Estable', NOW(), NOW(), 1, 1, 0, 2),
(9.1, 'Primer Semestre', 2023, 'Excelente', NOW(), NOW(), 1, 1, 0, 3),
(6.8, 'Primer Semestre', 2023, 'Necesita mejorar', NOW(), NOW(), 1, 1, 0, 4);

-- Insertar datos en la tabla profesores_materias
INSERT INTO profesores_materias (created_at, updated_at, created_by, updated_by, deleted, usuarios_idusuarios, materias_idmaterias) VALUES
(NOW(), NOW(), 1, 1, 0, 2, 1),  -- Carlos enseña Matemáticas
(NOW(), NOW(), 1, 1, 0, 2, 2),  -- Carlos enseña Ciencias Naturales
(NOW(), NOW(), 1, 1, 0, 5, 3),  -- Laura enseña Historia
(NOW(), NOW(), 1, 1, 0, 5, 4),  -- Laura enseña Programación
(NOW(), NOW(), 1, 1, 0, 5, 5);  -- Laura enseña Bases de Datos

-- Insertar datos en la tabla cursos_capacitaciones
INSERT INTO cursos_capacitaciones (titulo_curso, descripcion, durante_horas, tipo_contenido, url_contenido, fecha_publicacion, created_at, updated_at, created_by, updated_by, deleted, usuarios_idusuarios) VALUES
('Introducción a la Pedagogía', 'Fundamentos de la enseñanza moderna', 20, 'Video', 'https://platform.com/cursos/pedagogia', '2023-03-01', NOW(), NOW(), 1, 1, 0, 1),
('Tecnología en el Aula', 'Uso de herramientas digitales educativas', 15, 'Mixto', 'https://platform.com/cursos/tecnologia', '2023-03-15', NOW(), NOW(), 1, 1, 0, 2),
('Evaluación por Competencias', 'Métodos de evaluación moderna', 25, 'Documento', 'https://platform.com/cursos/evaluacion', '2023-04-01', NOW(), NOW(), 1, 1, 0, 5);
