import mysql.connector

DB_CONFIG = {
    "host": "localhost",   # cambiar "danielle" por "localhost"
    "user": "root",
    "password": "12345",
    "database": "mydb",
    "port": 3306
}

# Probar conexión
try:
    cnx = mysql.connector.connect(**DB_CONFIG)
    if cnx.is_connected():
        print("✅ Conexión exitosa a MySQL")
        cnx.close()
except mysql.connector.Error as e:
    print("❌ Error de conexión:", e)
