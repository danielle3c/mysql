
DELIMITER //

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: instituciones
-- ==========================================
CREATE PROCEDURE sp_instituciones_insertar(
    IN p_nombre_institucion VARCHAR(45),
    IN p_direccion VARCHAR(45),
    IN p_telefono VARCHAR(45),
    IN p_email VARCHAR(45),
    IN p_created_by INT
)
BEGIN
    INSERT INTO instituciones(nombre_institucion, direccion, telefono, email, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_institucion, p_direccion, p_telefono, p_email, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_instituciones_borrado_logico(IN p_id INT)
BEGIN
    UPDATE instituciones SET deleted = 1 WHERE idinstituciones = p_id;
END//

CREATE PROCEDURE sp_instituciones_listar_activos()
BEGIN
    SELECT * FROM instituciones WHERE deleted = 0;
END//

CREATE PROCEDURE sp_instituciones_listar_todo()
BEGIN
    SELECT * FROM instituciones;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: personas
-- ==========================================
CREATE PROCEDURE sp_personas_insertar(
    IN p_nombre_tipo VARCHAR(45),
    IN p_descripcion VARCHAR(45),
    IN p_nivel_de_acceso INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO personas(nombre_tipo, descripcion, nivel_de_acceso, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_tipo, p_descripcion, p_nivel_de_acceso, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_personas_borrado_logico(IN p_id INT)
BEGIN
    UPDATE personas SET deleted = 1 WHERE idpersonas = p_id;
END//

CREATE PROCEDURE sp_personas_listar_activos()
BEGIN
    SELECT * FROM personas WHERE deleted = 0;
END//

CREATE PROCEDURE sp_personas_listar_todo()
BEGIN
    SELECT * FROM personas;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: usuarios
-- ==========================================
CREATE PROCEDURE sp_usuarios_insertar(
    IN p_nombre_completo VARCHAR(45),
    IN p_email VARCHAR(45),
    IN p_fecha_nac DATE,
    IN p_instituciones_idinstituciones INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO usuarios(nombre_completo, email, fecha_nac, instituciones_idinstituciones, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_completo, p_email, p_fecha_nac, p_instituciones_idinstituciones, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_usuarios_borrado_logico(IN p_id INT)
BEGIN
    UPDATE usuarios SET deleted = 1 WHERE idusuarios = p_id;
END//

CREATE PROCEDURE sp_usuarios_listar_activos()
BEGIN
    SELECT * FROM usuarios WHERE deleted = 0;
END//

CREATE PROCEDURE sp_usuarios_listar_todo()
BEGIN
    SELECT * FROM usuarios;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: tip_usuarios
-- ==========================================
CREATE PROCEDURE sp_tip_usuarios_insertar(
    IN p_usuarios_idusuarios INT,
    IN p_personas_idpersonas INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO tip_usuarios(usuarios_idusuarios, personas_idpersonas, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_usuarios_idusuarios, p_personas_idpersonas, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_tip_usuarios_borrado_logico(IN p_id INT)
BEGIN
    UPDATE tip_usuarios SET deleted = 1 WHERE idtip_usuarios = p_id;
END//

CREATE PROCEDURE sp_tip_usuarios_listar_activos()
BEGIN
    SELECT * FROM tip_usuarios WHERE deleted = 0;
END//

CREATE PROCEDURE sp_tip_usuarios_listar_todo()
BEGIN
    SELECT * FROM tip_usuarios;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: materias
-- ==========================================
CREATE PROCEDURE sp_materias_insertar(
    IN p_nombre_materias VARCHAR(45),
    IN p_descripcion VARCHAR(45),
    IN p_instituciones_idinstituciones INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO materias(nombre_materias, descripcion, instituciones_idinstituciones, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_materias, p_descripcion, p_instituciones_idinstituciones, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_materias_borrado_logico(IN p_id INT)
BEGIN
    UPDATE materias SET deleted = 1 WHERE idmaterias = p_id;
END//

CREATE PROCEDURE sp_materias_listar_activos()
BEGIN
    SELECT * FROM materias WHERE deleted = 0;
END//

CREATE PROCEDURE sp_materias_listar_todo()
BEGIN
    SELECT * FROM materias;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: alumnos
-- ==========================================
CREATE PROCEDURE sp_alumnos_insertar(
    IN p_fecha_ingreso DATE,
    IN p_condicion TINYINT,
    IN p_observaciones VARCHAR(45),
    IN p_instituciones_idinstituciones INT,
    IN p_usuarios_idusuarios INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO alumnos(fecha_ingreso, condicion, observaciones, instituciones_idinstituciones, usuarios_idusuarios, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_fecha_ingreso, p_condicion, p_observaciones, p_instituciones_idinstituciones, p_usuarios_idusuarios, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_alumnos_borrado_logico(IN p_id INT)
BEGIN
    UPDATE alumnos SET deleted = 1 WHERE idalumnos = p_id;
END//

CREATE PROCEDURE sp_alumnos_listar_activos()
BEGIN
    SELECT * FROM alumnos WHERE deleted = 0;
END//

CREATE PROCEDURE sp_alumnos_listar_todo()
BEGIN
    SELECT * FROM alumnos;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: calificaciones
-- ==========================================
CREATE PROCEDURE sp_calificaciones_insertar(
    IN p_calificacion DECIMAL(3,1),
    IN p_alumnos_idalumnos INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO calificaciones(calificacion, alumnos_idalumnos, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_calificacion, p_alumnos_idalumnos, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_calificaciones_borrado_logico(IN p_id INT)
BEGIN
    UPDATE calificaciones SET deleted = 1 WHERE idcalificaciones = p_id;
END//

CREATE PROCEDURE sp_calificaciones_listar_activos()
BEGIN
    SELECT * FROM calificaciones WHERE deleted = 0;
END//

CREATE PROCEDURE sp_calificaciones_listar_todo()
BEGIN
    SELECT * FROM calificaciones;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: actividades
-- ==========================================
CREATE PROCEDURE sp_actividades_insertar(
    IN p_nombre_actividad VARCHAR(45),
    IN p_descripcion VARCHAR(45),
    IN p_tipo_actividad VARCHAR(45),
    IN p_materias_idmaterias INT,
    IN p_usuarios_idusuarios INT,
    IN p_calificaciones_idcalificaciones INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO actividades(nombre_actividad, descripcion, tipo_actividad, materias_idmaterias, usuarios_idusuarios, calificaciones_idcalificaciones, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_actividad, p_descripcion, p_tipo_actividad, p_materias_idmaterias, p_usuarios_idusuarios, p_calificaciones_idcalificaciones, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_actividades_borrado_logico(IN p_id INT)
BEGIN
    UPDATE actividades SET deleted = 1 WHERE idactividades = p_id;
END//

CREATE PROCEDURE sp_actividades_listar_activos()
BEGIN
    SELECT * FROM actividades WHERE deleted = 0;
END//

CREATE PROCEDURE sp_actividades_listar_todo()
BEGIN
    SELECT * FROM actividades;
END//







DELIMITER //

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: historial_rendimientos
-- ==========================================
CREATE PROCEDURE sp_historial_rendimientos_insertar(
    IN p_promedio_general DECIMAL(3,1),
    IN p_periodo VARCHAR(45),
    IN p_ano INT,
    IN p_tendencia VARCHAR(45),
    IN p_alumnos_idalumnos INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO historial_rendimientos(promedio_general, periodo, ano, tendencia, alumnos_idalumnos, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_promedio_general, p_periodo, p_ano, p_tendencia, p_alumnos_idalumnos, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_historial_rendimientos_borrado_logico(IN p_id INT)
BEGIN
    UPDATE historial_rendimientos SET deleted = 1 WHERE idhistorial_rendimientos = p_id;
END//

CREATE PROCEDURE sp_historial_rendimientos_listar_activos()
BEGIN
    SELECT * FROM historial_rendimientos WHERE deleted = 0;
END//

CREATE PROCEDURE sp_historial_rendimientos_listar_todo()
BEGIN
    SELECT * FROM historial_rendimientos;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: profesores_materias
-- ==========================================
CREATE PROCEDURE sp_profesores_materias_insertar(
    IN p_usuarios_idusuarios INT,
    IN p_materias_idmaterias INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO profesores_materias(usuarios_idusuarios, materias_idmaterias, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_usuarios_idusuarios, p_materias_idmaterias, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_profesores_materias_borrado_logico(IN p_id INT)
BEGIN
    UPDATE profesores_materias SET deleted = 1 WHERE idprofesores_materias = p_id;
END//

CREATE PROCEDURE sp_profesores_materias_listar_activos()
BEGIN
    SELECT * FROM profesores_materias WHERE deleted = 0;
END//

CREATE PROCEDURE sp_profesores_materias_listar_todo()
BEGIN
    SELECT * FROM profesores_materias;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: cursos_capacitaciones
-- ==========================================
CREATE PROCEDURE sp_cursos_capacitaciones_insertar(
    IN p_titulo_curso VARCHAR(45),
    IN p_descripcion VARCHAR(45),
    IN p_durante_horas INT,
    IN p_tipo_contenido VARCHAR(45),
    IN p_url_contenido VARCHAR(450),
    IN p_fecha_publicacion DATETIME,
    IN p_usuarios_idusuarios INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO cursos_capacitaciones(titulo_curso, descripcion, durante_horas, tipo_contenido, url_contenido, fecha_publicacion, usuarios_idusuarios, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_titulo_curso, p_descripcion, p_durante_horas, p_tipo_contenido, p_url_contenido, p_fecha_publicacion, p_usuarios_idusuarios, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_cursos_capacitaciones_borrado_logico(IN p_id INT)
BEGIN
    UPDATE cursos_capacitaciones SET deleted = 1 WHERE idcursos_capacitaciones = p_id;
END//

CREATE PROCEDURE sp_cursos_capacitaciones_listar_activos()
BEGIN
    SELECT * FROM cursos_capacitaciones WHERE deleted = 0;
END//

CREATE PROCEDURE sp_cursos_capacitaciones_listar_todo()
BEGIN
    SELECT * FROM cursos_capacitaciones;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: redes_sociales
-- ==========================================
CREATE PROCEDURE sp_redes_sociales_insertar(
    IN p_nombre_red VARCHAR(45),
    IN p_url_api VARCHAR(45),
    IN p_credenciales VARCHAR(45),
    IN p_activa TINYINT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO redes_sociales(nombre_red, url_api, credenciales, activa, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_nombre_red, p_url_api, p_credenciales, p_activa, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_redes_sociales_borrado_logico(IN p_id INT)
BEGIN
    UPDATE redes_sociales SET deleted = 1 WHERE idredes_sociales = p_id;
END//

CREATE PROCEDURE sp_redes_sociales_listar_activos()
BEGIN
    SELECT * FROM redes_sociales WHERE deleted = 0;
END//

CREATE PROCEDURE sp_redes_sociales_listar_todo()
BEGIN
    SELECT * FROM redes_sociales;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: publicaciones_redes_sociales
-- ==========================================
CREATE PROCEDURE sp_publicaciones_redes_sociales_insertar(
    IN p_contenido VARCHAR(45),
    IN p_fecha_program DATETIME,
    IN p_fecha_pub DATETIME,
    IN p_estado VARCHAR(45),
    IN p_cursos_capacitaciones_idcursos_capacitaciones INT,
    IN p_redes_sociales_idredes_sociales INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO publicaciones_redes_sociales(contenido, fecha_program, fecha_pub, estado, cursos_capacitaciones_idcursos_capacitaciones, redes_sociales_idredes_sociales, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_contenido, p_fecha_program, p_fecha_pub, p_estado, p_cursos_capacitaciones_idcursos_capacitaciones, p_redes_sociales_idredes_sociales, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_publicaciones_redes_sociales_borrado_logico(IN p_id INT)
BEGIN
    UPDATE publicaciones_redes_sociales SET deleted = 1 WHERE idpublicaciones_redes_sociales = p_id;
END//

CREATE PROCEDURE sp_publicaciones_redes_sociales_listar_activos()
BEGIN
    SELECT * FROM publicaciones_redes_sociales WHERE deleted = 0;
END//

CREATE PROCEDURE sp_publicaciones_redes_sociales_listar_todo()
BEGIN
    SELECT * FROM publicaciones_redes_sociales;
END//

-- ==========================================
-- PROCEDIMIENTOS PARA TABLA: credeciales
-- ==========================================
CREATE PROCEDURE sp_credeciales_insertar(
    IN p_user VARCHAR(45),
    IN p_password VARCHAR(255),
    IN p_usuarios_idusuarios INT,
    IN p_created_by INT
)
BEGIN
    INSERT INTO credeciales(user, password, usuarios_idusuarios, created_by, updated_by, deleted, created_at, updated_at)
    VALUES(p_user, p_password, p_usuarios_idusuarios, p_created_by, p_created_by, 0, NOW(), NOW());
END//

CREATE PROCEDURE sp_credeciales_borrado_logico(IN p_id INT)
BEGIN
    UPDATE credeciales SET deleted = 1 WHERE idcredeciales = p_id;
END//

CREATE PROCEDURE sp_credeciales_listar_activos()
BEGIN
    SELECT * FROM credeciales WHERE deleted = 0;
END//

CREATE PROCEDURE sp_credeciales_listar_todo()
BEGIN
    SELECT * FROM credeciales;
END//

DELIMITER ;