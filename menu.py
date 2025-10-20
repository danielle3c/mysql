import mysql.connector

# ============================================
# FUNCIÓN DE CONEXIÓN A LA BASE DE DATOS
# ============================================
def conectar():
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            user="root",
            password="12341",
            database="mydb"
        )
        return conexion
    except mysql.connector.Error as e:
        print("❌ Error de conexión:", e)
        return None


# ============================================
# FUNCIONES COMUNES DE BASE DE DATOS
# ============================================
def ejecutar_sp(nombre_sp, parametros=None, fetch=False):
    """
    Ejecuta un procedimiento almacenado (SP)
    nombre_sp: nombre del procedimiento
    parametros: lista o tupla de parámetros
    fetch: si True, devuelve resultados
    """
    cnx = conectar()
    if cnx is None:
        return None
    cur = cnx.cursor()
    try:
        cur.callproc(nombre_sp, parametros or [])
        resultados = []
        for result in cur.stored_results():
            resultados = result.fetchall()
        cnx.commit()
        if fetch:
            return resultados
    except mysql.connector.Error as e:
        print(f"❌ Error ejecutando {nombre_sp}:", e)
        cnx.rollback()
    finally:
        cur.close()
        cnx.close()


# ============================================
# CRUD: INSTITUCIONES
# ============================================
def menu_instituciones():
    while True:
        print("\n🏫 --- MENÚ INSTITUCIONES ---")
        print("1) Insertar institución")
        print("2) Listar instituciones activas")
        print("3) Borrado lógico")
        print("4) Restaurar institución")
        print("0) Volver al menú principal")
        op = input("👉 Opción: ")

        if op == "1":
            nombre = input("Nombre institución: ")
            ejecutar_sp("sp_insertar_institucion", [nombre])
            print("✅ Institución insertada.")
        elif op == "2":
            data = ejecutar_sp("sp_listar_instituciones_activas", fetch=True)
            for fila in data:
                print(f"ID:{fila[0]} | Nombre:{fila[1]}")
        elif op == "3":
            id_ = int(input("ID a borrar: "))
            ejecutar_sp("sp_borrado_logico_institucion", [id_])
            print("🗑️ Institución marcada como eliminada.")
        elif op == "4":
            id_ = int(input("ID a restaurar: "))
            ejecutar_sp("sp_restaurar_institucion", [id_])
            print("♻️ Institución restaurada.")
        elif op == "0":
            break
        else:
            print("❌ Opción inválida.")


# ============================================
# CRUD: SUCURSALES
# ============================================
def menu_sucursales():
    while True:
        print("\n🏢 --- MENÚ SUCURSALES ---")
        print("1) Insertar sucursal")
        print("2) Listar sucursales activas")
        print("3) Borrado lógico")
        print("4) Restaurar sucursal")
        print("0) Volver al menú principal")
        op = input("👉 Opción: ")

        if op == "1":
            nombre = input("Nombre sucursal: ")
            id_inst = int(input("ID institución: "))
            ejecutar_sp("sp_insertar_sucursal", [nombre, id_inst])
            print("✅ Sucursal insertada.")
        elif op == "2":
            data = ejecutar_sp("sp_listar_sucursales_activas", fetch=True)
            for fila in data:
                print(f"ID:{fila[0]} | Nombre:{fila[1]} | ID Institución:{fila[2]}")
        elif op == "3":
            id_ = int(input("ID a borrar: "))
            ejecutar_sp("sp_borrado_logico_sucursal", [id_])
            print("🗑️ Sucursal marcada como eliminada.")
        elif op == "4":
            id_ = int(input("ID a restaurar: "))
            ejecutar_sp("sp_restaurar_sucursal", [id_])
            print("♻️ Sucursal restaurada.")
        elif op == "0":
            break
        else:
            print("❌ Opción inválida.")


# ============================================
# CRUD: DEPARTAMENTOS
# ============================================
def menu_departamentos():
    while True:
        print("\n🏬 --- MENÚ DEPARTAMENTOS ---")
        print("1) Insertar departamento")
        print("2) Listar departamentos activos")
        print("3) Borrado lógico")
        print("4) Restaurar departamento")
        print("0) Volver al menú principal")
        op = input("👉 Opción: ")

        if op == "1":
            nombre = input("Nombre departamento: ")
            id_suc = int(input("ID sucursal: "))
            ejecutar_sp("sp_insertar_departamento", [nombre, id_suc])
            print("✅ Departamento insertado.")
        elif op == "2":
            data = ejecutar_sp("sp_listar_departamentos_activos", fetch=True)
            for fila in data:
                print(f"ID:{fila[0]} | Nombre:{fila[1]} | ID Sucursal:{fila[2]}")
        elif op == "3":
            id_ = int(input("ID a borrar: "))
            ejecutar_sp("sp_borrado_logico_departamento", [id_])
            print("🗑️ Departamento marcado como eliminado.")
        elif op == "4":
            id_ = int(input("ID a restaurar: "))
            ejecutar_sp("sp_restaurar_departamento", [id_])
            print("♻️ Departamento restaurado.")
        elif op == "0":
            break
        else:
            print("❌ Opción inválida.")


# ============================================
# CRUD: CARGOS
# ============================================
def menu_cargos():
    while True:
        print("\n💼 --- MENÚ CARGOS ---")
        print("1) Insertar cargo")
        print("2) Listar cargos activos")
        print("3) Borrado lógico")
        print("4) Restaurar cargo")
        print("0) Volver al menú principal")
        op = input("👉 Opción: ")

        if op == "1":
            nombre = input("Nombre cargo: ")
            id_depto = int(input("ID departamento: "))
            ejecutar_sp("sp_insertar_cargo", [nombre, id_depto])
            print("✅ Cargo insertado.")
        elif op == "2":
            data = ejecutar_sp("sp_listar_cargos_activos", fetch=True)
            for fila in data:
                print(f"ID:{fila[0]} | Cargo:{fila[1]} | ID Depto:{fila[2]}")
        elif op == "3":
            id_ = int(input("ID a borrar: "))
            ejecutar_sp("sp_borrado_logico_cargo", [id_])
            print("🗑️ Cargo eliminado.")
        elif op == "4":
            id_ = int(input("ID a restaurar: "))
            ejecutar_sp("sp_restaurar_cargo", [id_])
            print("♻️ Cargo restaurado.")
        elif op == "0":
            break
        else:
            print("❌ Opción inválida.")


# ============================================
# CRUD: EMPLEADOS
# ============================================
def menu_empleados():
    while True:
        print("\n👨‍💼 --- MENÚ EMPLEADOS ---")
        print("1) Insertar empleado")
        print("2) Listar empleados activos")
        print("3) Borrado lógico")
        print("4) Restaurar empleado")
        print("0) Volver al menú principal")
        op = input("👉 Opción: ")

        if op == "1":
            nombre = input("Nombre: ")
            cargo = input("Cargo: ")
            sueldo = float(input("Sueldo: "))
            ejecutar_sp("sp_insertar_empleado", [nombre, cargo, sueldo])
            print("✅ Empleado insertado.")
        elif op == "2":
            data = ejecutar_sp("sp_listar_empleados_activos", fetch=True)
            for fila in data:
                print(f"ID:{fila[0]} | {fila[1]} | Cargo:{fila[2]} | Sueldo:${fila[3]}")
        elif op == "3":
            id_ = int(input("ID a borrar: "))
            ejecutar_sp("sp_borrado_logico_empleado", [id_])
            print("🗑️ Empleado eliminado.")
        elif op == "4":
            id_ = int(input("ID a restaurar: "))
            ejecutar_sp("sp_restaurar_empleado", [id_])
            print("♻️ Empleado restaurado.")
        elif op == "0":
            break
        else:
            print("❌ Opción inválida.")


# ============================================
# MENÚ PRINCIPAL
# ============================================
def menu_principal():
    while True:
        print("\n📚 --- MENÚ PRINCIPAL ---")
        print("1) Instituciones")
        print("2) Sucursales")
        print("3) Departamentos")
        print("4) Cargos")
        print("5) Empleados")
        print("0) Salir")
        op = input("👉 Opción: ")

        if op == "1": menu_instituciones()
        elif op == "2": menu_sucursales()
        elif op == "3": menu_departamentos()
        elif op == "4": menu_cargos()
        elif op == "5": menu_empleados()
        elif op == "0":
            print("👋 Saliendo del sistema...")
            break
        else:
            print("❌ Opción no válida.")


# ============================================
# EJECUCIÓN PRINCIPAL
# ============================================
if __name__ == "__main__":
    menu_principal()
