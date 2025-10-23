# ==========================================
# historial_rendimientos.py
# CRUD MySQL para tabla historial_rendimientos
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
    promedio = float(input("Promedio general (ej: 6.5): "))
    periodo = input("Periodo (ej: Semestre 1): ")
    ano = int(input("Año (ej: 2025): "))
    tendencia = input("Tendencia: ")
    id_alumno = int(input("ID alumno: "))
    created_by = int(input("ID usuario que crea: "))
    sql = """INSERT INTO historial_rendimientos(promedio_general, periodo, ano, tendencia, alumnos_idalumnos,
             deleted, created_at, updated_at, created_by, updated_by)
             VALUES (%s, %s, %s, %s, %s, 0, NOW(), NOW(), %s, %s)"""
    ejecutar_sql(sql, (promedio, periodo, ano, tendencia, id_alumno, created_by, created_by))
    print("✅ Historial de rendimiento insertado.")

def listar_activos():
    rows = ejecutar_sql("SELECT * FROM historial_rendimientos WHERE deleted=0", fetch=True)
    print("=== HISTORIAL DE RENDIMIENTOS ACTIVOS ===")
    for r in rows: print(r)

def listar_todos():
    rows = ejecutar_sql("SELECT * FROM historial_rendimientos", fetch=True)
    print("=== TODOS LOS HISTORIALES DE RENDIMIENTOS ===")
    for r in rows: print(r)

def borrado_logico():
    id_h = int(input("ID historial a eliminar: "))
    ejecutar_sql("UPDATE historial_rendimientos SET deleted=1 WHERE idhistorial_rendimientos=%s", (id_h,))
    print(f"✅ Historial {id_h} eliminado lógicamente.")

def restaurar():
    id_h = int(input("ID historial a restaurar: "))
    ejecutar_sql("UPDATE historial_rendimientos SET deleted=0 WHERE idhistorial_rendimientos=%s", (id_h,))
    print(f"✅ Historial {id_h} restaurado.")

# ---------------- MENÚ ----------------
def menu():
    while True:
        print("\n=== MENÚ HISTORIAL DE RENDIMIENTOS ===")
        print("1) Insertar historial")
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
