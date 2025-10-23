# ==========================================
# tip_usuarios.py
# CRUD MySQL para tabla tip_usuarios
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
    id_usuario = int(input("ID usuario: "))
    id_persona = int(input("ID persona: "))
    created_by = int(input("ID usuario que crea: "))
    sql = """INSERT INTO tip_usuarios(usuarios_idusuarios, personas_idpersonas, deleted, created_at, updated_at, created_by, updated_by)
             VALUES (%s, %s, 0, NOW(), NOW(), %s, %s)"""
    ejecutar_sql(sql, (id_usuario, id_persona, created_by, created_by))
    print("✅ Tipo de usuario insertado.")

def listar_activos():
    rows = ejecutar_sql("SELECT * FROM tip_usuarios WHERE deleted=0", fetch=True)
    print("=== TIPOS DE USUARIOS ACTIVOS ===")
    for r in rows: print(r)

def listar_todos():
    rows = ejecutar_sql("SELECT * FROM tip_usuarios", fetch=True)
    print("=== TODOS LOS TIPOS DE USUARIOS ===")
    for r in rows: print(r)

def borrado_logico():
    id_tu = int(input("ID tip_usuario a eliminar: "))
    ejecutar_sql("UPDATE tip_usuarios SET deleted=1 WHERE idtip_usuarios=%s", (id_tu,))
    print(f"✅ Tipo de usuario {id_tu} eliminado lógicamente.")

def restaurar():
    id_tu = int(input("ID tip_usuario a restaurar: "))
    ejecutar_sql("UPDATE tip_usuarios SET deleted=0 WHERE idtip_usuarios=%s", (id_tu,))
    print(f"✅ Tipo de usuario {id_tu} restaurado.")

# ---------------- MENÚ ----------------
def menu():
    while True:
        print("\n=== MENÚ TIP USUARIOS ===")
        print("1) Insertar tipo de usuario")
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
