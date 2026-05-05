#  Requerimientos Funcionales - Casos de Uso

##  Actor Principal: Usuario

### CU-01: Registrarse / Iniciar sesión
**Descripción:** Permite al usuario crear una cuenta o acceder al sistema.  
**Incluye:** 
- Validación de credenciales
- Acceso a perfil.

---

### CU-02: Explorar Productos
**Descripción:** El usuario navega por el catálogo de bebidas y alimentos.  
**Incluye:**
- Ver productos
- Filtrar por categoría
- Buscar productos

---

### CU-03: Ver Detalle de Producto
**Descripción:** El usuario visualiza información detallada de un producto.  
**Incluye:**
- Nombre
- Descripción
- Precio
- Imagen

---

### CU-04: Personalizar Producto
**Descripción:** El usuario configura un producto antes de agregarlo al carrito.  
**Incluye:**
- Tamaño
- Azúcar
- Tipo de leche
- Extras

---

### CU-05: Gestionar Carrito
**Descripción:** El usuario administra los productos seleccionados.  
**Incluye:**
- Agregar producto
- Editar producto
- Eliminar producto
- Ver subtotal

---

### CU-06: Realizar Pedido
**Descripción:** El usuario confirma su pedido.  
**Incluye:**
- Revisar resumen
- Confirmar pedido

---

### CU-07: Realizar Pago
**Descripción:** El usuario paga el pedido.  
**Incluye:**
- Seleccionar método de pago
- Confirmar pago

---

### CU-08: Consultar Estado del Pedido
**Descripción:** El usuario visualiza el estado del pedido en tiempo real.  
**Estados:**
- Recibido
- En preparación
- Listo

---

### CU-09: Ver Historial de Pedidos
**Descripción:** El usuario revisa pedidos anteriores.

---

### CU-10: Recibir Notificaciones
**Actor secundario:** Sistema  
**Descripción:** El sistema envía notificaciones al usuario sobre el estado de su pedido o promociones.

---
---
--- 

### CU-11: Gestionar Favoritos
**Descripción:** El usuario puede marcar productos como favoritos para acceder rápidamente.
**Incluye:**
- Agregar producto a favoritos  
- Eliminar producto de favoritos  
- Visualizar lista de favoritos  

---

### CU-12: Calificar Producto
**Descripción:** El usuario puede dejar una reseña y calificación de un producto.
**Incluye:**
- Puntuar producto  
- Escribir comentario  

---

### CU-13: Consultar Promociones
**Descripción:** El usuario puede visualizar promociones activas disponibles en la cafetería.
**Incluye:**
- Ver descuentos  
- Visualizar fechas de vigencia  

---

### CU-14: Seleccionar Cafetería
**Descripción:** El usuario puede elegir la cafetería desde la cual realizará su pedido.

---

### CU-15: Ver Disponibilidad de Productos
**Descripción:** El usuario puede verificar si un producto está disponible antes de realizar un pedido (stock).

---
---

## Actor: Administrador / Cafetería

### CU-16: Gestionar Productos
**Descripción:** Permite administrar los productos disponibles en la cafetería.
**Incluye:**
- Crear producto  
- Editar producto  
- Activar o desactivar disponibilidad  

---

### CU-17: Actualizar Estado de Pedido
**Descripción:** Permite actualizar el estado del pedido en el sistema.
**Estados:**
- Pendiente  
- En preparación  
- Listo  
- Entregado  

---

### CU-19: Gestionar Promociones
**Descripción:** Permite crear y administrar promociones.
**Incluye:**
- Crear promoción  
- Editar promoción  
- Activar o desactivar promoción  
