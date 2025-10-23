# ==========================================
# publicaciones_redes_sociales.py
# CRUD MySQL para tabla publicaciones_redes_sociales
# ==========================================

import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "tu_password",
    "database": "mydb"
}

def conectar():
    return mysql.connector.connect(**DB_CONFIG)

def ejecutar_sql(sql, params=None, fetch=False):
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.execute(sql, params or ())
        if fetch:
            return cur.fetchall()
        cnx.commit()
        return True
    except mysql.connector.Error as e:
        print("❌ Error:", e)
        if cnx and cnx.is_connected():
            try: cnx.rollback()
            except: pass
        return None
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# ---------------- FUNCIONES CRUD ----------------
def insertar():
    contenido = input("Contenido: ")
    fecha_prog = input("Fecha programada (YYYY-MM-DD HH:MM:SS): ")
    fecha_pub = input("Fecha publicación (YYYY-MM-DD HH:MM:SS): ")
    estado = input("Estado: ")
    id_curso = int(input("ID curso o capacitación: "))
    id_red = int(input("ID red social: "))
    created_by = int(input("ID usuario que crea: "))

    sql = """INSERT INTO publicaciones_redes_sociales(contenido, fecha_program, fecha_pub, estado,
             cursos_capacitaciones_idcursos_capacitaciones, redes_sociales_idredes_sociales,
             deleted, created_at, updated_at, created_by, updated_by)
             VALUES (%s, %s, %s, %s, %s, %s, 0, NOW(), NOW(), %s, %s)"""
    ejecutar_sql(sql, (contenido, fecha_prog, fecha_pub, estado, id_curso, id_red, created_by, created_by))
    print("✅ Publicación insertada.")

def listar_activos():
    rows = ejecutar_sql("SELECT * FROM publicaciones_redes_sociales WHERE deleted=0", fetch=True)
    print("=== PUBLICACIONES ACTIVAS ===")
    for r in rows: print(r)

def listar_todos():
    rows = ejecutar_sql("SELECT * FROM publicaciones_redes_sociales", fetch=True)
    print("=== TODAS LAS PUBLICACIONES ===")
    for r in rows: print(r)

def borrado_logico():
    id_p = int(input("ID publicación a eliminar: "))
    ejecutar_sql("UPDATE publicaciones_redes_sociales SET deleted=1 WHERE idpublicaciones_redes_sociales=%s", (id_p,))
    print(f"✅ Publicación {id_p} eliminada lógicamente.")

def restaurar():
    id_p = int(input("ID publicación a restaurar: "))
    ejecutar_sql("UPDATE publicaciones_redes_sociales SET deleted=0 WHERE idpublicaciones_redes_sociales=%s", (id_p,))
    print(f"✅ Publicación {id_p} restaurada.")

# ---------------- MENÚ ----------------
def menu():
    while True:
        print("\n=== MENÚ PUBLICACIONES REDES SOCIALES ===")
        print("1) Insertar publicación")
        print("2) Listar activos")
        print("3) Listar todos")
        print("4) Borrado lógico")
        print("5) Restaurar")
        print("0) Salir")

        opcion = input("Selecciona una opción: ").strip()
        if opcion == "1": insertar()
        elif opcion == "2": listar_activos()
        elif opcion == "3": listar_todos()
        elif opcion == "4": borrado_logico()
        elif opcion == "5": restaurar()
        elif opcion == "0":
            print("Saliendo...")
            break
        else:
            print("❌ Opción inválida")

if __name__ == "__main__":
    menu()
