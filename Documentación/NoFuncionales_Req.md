#  Requisitos No Funcionales

| ID | Nombre | Descripción | Criterio de Aceptación | Prioridad | Fuente |
|----|--------|------------|------------------------|----------|--------|
| RNF-01 | Disponibilidad | El sistema debe estar disponible 24/7 para los usuarios. | Disponibilidad ≥ 99% mensual. | Alta | Negocio |
| RNF-02 | Rendimiento | La aplicación debe responder rápidamente a las acciones del usuario. | Carga ≤ 3s. Acciones ≤ 2s. | Alta | Usuario |
| RNF-03 | Seguridad | El sistema debe proteger la información del usuario. | Login obligatorio y contraseñas encriptadas. | Alta | Técnico |
| RNF-04 | Usabilidad | La interfaz debe ser intuitiva y fácil de usar. | Pedido completado ≤ 3 min sin ayuda. | Alta | Usuario |
| RNF-05 | Escalabilidad | El sistema debe soportar múltiples usuarios concurrentes. | ≥ 100 usuarios sin degradación. | Media | Técnico |
| RNF-06 | Compatibilidad | La app debe funcionar en dispositivos Android. | Android 8.0+ en distintos tamaños. | Alta | Técnico |
| RNF-07 | Mantenibilidad | El sistema debe ser fácil de modificar. | Código modular y versionado en GitHub. | Media | Técnico |
| RNF-08 | Notificaciones | Informar el estado del pedido en tiempo real. | Retraso ≤ 5 segundos. | Media | Usuario |
| RNF-09 | Persistencia de Datos | Evitar pérdida de información. | Datos guardados correctamente ante fallos. | Alta | Negocio |
| RNF-10 | Disponibilidad de Datos | Acceso inmediato a pedidos e historial. | Datos visibles inmediatamente tras registro. | Media | Usuario |
