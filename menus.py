import mysql.connector

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "12341",
    "database": "mydb"
}

def conectar():
    return mysql.connector.connect(**DB_CONFIG)

# --- Insertar institución ---
def sp_insertar(nombre, direccion, telefono, email):
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        args = [nombre, direccion, telefono, email, 0]  # último es OUT
        cur.callproc("sp_insertar_institucion", args)
        cnx.commit()
        print(f"✅ Institución insertada con ID {args[4]}")
    except mysql.connector.Error as e:
        print("❌ Error al insertar:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# --- Listar instituciones activas ---
def sp_listar():
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_listar_instituciones_activas")
        for result in cur.stored_results():
            for row in result.fetchall():
                print(f"ID:{row[0]} | Nombre:{row[1]} | Dirección:{row[2]} | Tel:{row[3]} | Email:{row[4]}")
    except mysql.connector.Error as e:
        print("❌ Error al listar:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# --- Borrado lógico ---
def sp_borrar(id_):
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_borrado_logico_institucion", [id_])
        cnx.commit()
        print(f"✅ Institución ID {id_} borrada lógicamente")
    except mysql.connector.Error as e:
        print("❌ Error al borrar:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# --- Restaurar institución ---
def sp_restaurar(id_):
    cnx = cur = None
    try:
        cnx = conectar()
        cur = cnx.cursor()
        cur.callproc("sp_restaurar_institucion", [id_])
        cnx.commit()
        print(f"✅ Institución ID {id_} restaurada")
    except mysql.connector.Error as e:
        print("❌ Error al restaurar:", e)
    finally:
        if cur: cur.close()
        if cnx and cnx.is_connected(): cnx.close()

# --- Menú principal ---
def menu():
    while True:
        print("\n--- MENÚ INSTITUCIONES ---")
        print("1) Insertar institución")
        print("2) Listar instituciones activas")
        print("3) Borrar institución")
        print("4) Restaurar institución")
        print("0) Salir")
        opcion = input("Opción: ").strip()

        if opcion == "1":
            nombre = input("Nombre: ")
            direccion = input("Dirección: ")
            telefono = input("Teléfono: ")
            email = input("Email: ")
            sp_insertar(nombre, direccion, telefono, email)
        elif opcion == "2":
            sp_listar()
        elif opcion == "3":
            id_ = int(input("ID a borrar: "))
            sp_borrar(id_)
        elif opcion == "4":
            id_ = int(input("ID a restaurar: "))
            sp_restaurar(id_)
        elif opcion == "0":
            print("👋 Saliendo...")
            break
        else:
            print("❌ Opción inválida")

if __name__ == "__main__":
    menu()
