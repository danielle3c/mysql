# ==========================================
# personas.py
# CRUD MySQL para tabla personas
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
    nombre_tipo = input("Nombre tipo: ")
    descripcion = input("Descripción: ")
    nivel_acceso = int(input("Nivel de acceso: "))
    created_by = int(input("ID usuario que crea: "))
    sql = """INSERT INTO personas(nombre_tipo, descripcion, nivel_de_acceso, deleted, created_at, updated_at, created_by, updated_by)
             VALUES (%s, %s, %s, 0, NOW(), NOW(), %s, %s)"""
    ejecutar_sql(sql, (nombre_tipo, descripcion, nivel_acceso, created_by, created_by))
    print("✅ Persona insertada.")

def listar_activos():
    rows = ejecutar_sql("SELECT * FROM personas WHERE deleted=0", fetch=True)
    print("=== PERSONAS ACTIVAS ===")
    for r in rows: print(r)

def listar_todos():
    rows = ejecutar_sql("SELECT * FROM personas", fetch=True)
    print("=== TODAS LAS PERSONAS ===")
    for r in rows: print(r)

def borrado_logico():
    id_p = int(input("ID persona a eliminar: "))
    ejecutar_sql("UPDATE personas SET deleted=1 WHERE idpersonas=%s", (id_p,))
    print(f"✅ Persona {id_p} eliminada lógicamente.")

def restaurar():
    id_p = int(input("ID persona a restaurar: "))
    ejecutar_sql("UPDATE personas SET deleted=0 WHERE idpersonas=%s", (id_p,))
    print(f"✅ Persona {id_p} restaurada.")

# ---------------- MENÚ ----------------
def menu():
    while True:
        print("\n=== MENÚ PERSONAS ===")
        print("1) Insertar persona")
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
