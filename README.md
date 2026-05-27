# Carlos_Morales_examen_bdd

# Examen Final - Sistema de Vuelos

Hola, aquí explico los pasos que seguí para completar la Parte 3 del examen, detallando cómo cambié el código para agregar el destino y cómo pensé el diseño de los pasajeros.

---

## Parte 3: Mantenimiento y Extensibilidad (Modificación de Requisitos)

En esta parte el examen pedía agregar el campo 'destino' a los vuelos. Tuvimos que cambiar todo desde la base de datos hasta el código en Java.

### 1. Cambio en la Base de Datos
Primero abrí el pgAdmin, le di clic derecho a la base de datos `vuelos_db` y abrí el Query Tool. Ejecuté este comando para crear la nueva columna en la tabla:

```sql
ALTER TABLE vuelos ADD COLUMN destino VARCHAR(100);

Luego fui a Eclipse y modifique los siguientes archivos:

En la Entidad (Vuelo.java): Agregué la variable privada para el destino abajo de los otros campos y creé a mano sus métodos Get y Set para poder usarlos:

@Column(name = "destino", length = 100)
private String destino;

public String getDestino() {
    return destino;
}

public void setDestino(String destino) {
    this.destino = destino;
}


En el Servicio (VueloService.java): Modifiqué el método actualizar para que cuando se actualice un vuelo, también agarre el nuevo destino que viene de Postman y lo guarde en la base de datos. Le aumenté esta línea:

vuelo.setDestino(vueloDetalles.getDestino());

Prueba en Postman
Para probar que funcione reinicié el servidor en Eclipse. Fui a Postman y mandé un POST con este JSON (usando un código nuevo para que no dé error de llave duplicada):

{
  "codigo": "IB-502",
  "precioBoleto": 850.00,
  "asientosDisponibles": 120,
  "destino": "Madrid"
}

En la respuesta me devolvió el estado 201 Created y ya salió el campo "destino": "Madrid". También probé el PUT para actualizar y funcionó bien.
