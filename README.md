## Entorno de Desarrollo

El proyecto ULima Café ha sido desarrollado utilizando un entorno moderno orientado al desarrollo de aplicaciones móviles.

###   Herramientas utilizadas
- **Figma**
  Herramienta de diseño utilizada para la creación de los mockups de la aplicación.

- **GitHub**
  Plataforma de control de versiones para gestionar el código fuente del proyecto.


## Requerimientos No Funcionales

- **Disponibilidad:** El sistema debe estar disponible 24/7 para los estudiantes.
- **Rendimiento:** El tiempo de carga de la app no debe superar los 3 segundos.
- **Seguridad:** Autenticación mediante código universitario.
- **Usabilidad:** Interfaz intuitiva basada en los mockups diseñados en Figma.
- **Escalabilidad:** El sistema debe soportar múltiples usuarios concurrentes.
- **Compatibilidad:** Disponible para dispositivos Android.
- **Mantenibilidad:** Código estructurado y versionado con GitHub.

##  Diagrama de Despliegue

El sistema ULima Café está compuesto por:

- **Cliente móvil (App)**
- **Servidor Backend (API REST)**
- **Base de datos (MySQL / Firebase)**
- **Servicios externos (Pagos QR, Notificaciones)**


## Casos de Uso del Sistema


### CU-01: Explorar y buscar productos

**Actor:** Usuario  
**Descripción:**  
El usuario ingresa a la sección de inicio y visualiza el catálogo de bebidas disponibles. Puede navegar por categorías o usar un buscador para encontrar un producto específico.  

**Funcionalidades:**
- Visualización de productos
- Filtros por categoría
- Búsqueda por nombre

**Salida del sistema:**
- Nombre del producto
- Descripción
- Precio base
- Imagen

---

### CU-02: Personalizar producto

**Actor:** Usuario  
**Descripción:**  
Al seleccionar un producto, el usuario accede a una pantalla de personalización donde puede elegir diferentes opciones.

**Opciones disponibles:**
- Tamaño (pequeño, mediano, grande)
- Nivel de azúcar
- Tipo de leche (entera, descremada, vegetal)
- Toppings adicionales

**Comportamiento del sistema:**
- Actualización del precio en tiempo real según selección

---

### CU-03: Gestionar carrito de compras

**Actor:** Usuario  
**Descripción:**  
El usuario puede administrar los productos agregados al carrito.

**Funcionalidades:**
- Agregar productos
- Modificar cantidad
- Editar personalización
- Eliminar productos

**Salida del sistema:**
- Subtotal actualizado
- Resumen detallado de cada producto

---

### CU-04: Realizar pedido y pago

**Actor:** Usuario  
**Descripción:**  
El usuario revisa el pedido y realiza el pago.

**Métodos de pago:**
- Efectivo
- Tarjeta
- Billetera digital (Yape, Plin, etc.)

**Flujo:**
1. Revisar resumen
2. Seleccionar método de pago
3. Confirmar pago

**Salida del sistema:**
- Registro del pedido
- Código de seguimiento

---

### CU-05: Consultar historial de pedidos

**Actor:** Usuario  
**Descripción:**  
Permite visualizar pedidos anteriores y actuales.

**Información mostrada:**
- Productos
- Personalización
- Total pagado
- Fecha
- Estado (en preparación, listo, entregado)

---

### CU-06: Registrarse e iniciar sesión

**Actor:** Usuario  
**Descripción:**  
Permite crear una cuenta o acceder al sistema.

**Datos requeridos:**
- Correo institucional
- Nombre
- Código universitario

**Beneficios:**
- Historial de pedidos
- Guardado de preferencias
- Acceso desde cualquier dispositivo

- Ver menú
- Filtrar productos
- Ver detalle de producto
- Agregar al carrito
- Realizar pedido
- Seleccionar método de pago
- Pagar con QR
- Ver historial de pedidos
