# ==========================================
# materias.py
# CRUD MySQL para tabla materias
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
    nombre = input("Nombre materia: ")
    descripcion = input("Descripción: ")
    id_inst = int(input("ID institución: "))
    created_by = int(input("ID usuario que crea: "))
    sql = """INSERT INTO materias(nombre_materias,descripcion,instituciones_idinstituciones,deleted,created_at,updated_at,created_by,updated_by)
             VALUES (%s,%s,%s,0,NOW(),NOW(),%s,%s)"""
    ejecutar_sql(sql, (nombre, descripcion, id_inst, created_by, created_by))
    print("✅ Materia insertada.")

def listar_activos():
    rows = ejecutar_sql("SELECT * FROM materias WHERE deleted=0", fetch=True)
    print("=== MATERIAS ACTIVAS ===")
    for r in rows: print(r)

def listar_todos():
    rows = ejecutar_sql("SELECT * FROM materias", fetch=True)
    print("=== TODAS LAS MATERIAS ===")
    for r in rows: print(r)

def borrado_logico():
    id_m = int(input("ID materia a eliminar: "))
    ejecutar_sql("UPDATE materias SET deleted=1 WHERE idmaterias=%s", (id_m,))
    print(f"✅ Materia {id_m} eliminada lógicamente.")

def restaurar():
    id_m = int(input("ID materia a restaurar: "))
    ejecutar_sql("UPDATE materias SET deleted=0 WHERE idmaterias=%s", (id_m,))
    print(f"✅ Materia {id_m} restaurada.")

# ---------------- MENÚ ----------------
def menu():
    while True:
        print("\n=== MENÚ MATERIAS ===")
        print("1) Insertar materia")
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
