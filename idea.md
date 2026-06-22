


# Plan de Refactorización — Inversiones Elohim S.A.

# DM Hub

Actualmente estoy desarrollando una aplicacion simple de marketplace para un un cliente, que distribuye productos alimenticios al mayoreo y a clientes particulares, pero me di cuenta de que las mismas necesidades se repiten para otros clientes, entonces quiero refactorizar el proyecto.

Quiero hacer un tipo SaS (gratuito por ahora) que sea capaz de cubrir esta necesidades para estos clientes.

## Estado actual

## Diferenciadores

1. **Los reportes**

Van a estar especialmente enfocados a sus necesidades y espero poder agregar un personalizar en donde puedan hacer sus propias consultas sql y guardarlos como reportes propios.

2. **Self hosted**

Ademas de la versión SaS quiero definir una versión Self Hosted para que los usuarios puedan instalar esta aplicacion en su propio servidor para usarlo por su propia cuenta, sin estar atados a mi servicio en especifico

## A lo que quiero llegar

```markdown
¡Claro que sí! Aquí tienes toda la especificación técnica unificada y estructurada en formato Markdown para que puedas copiarla y pegarla directamente en tus notas o en un archivo `.md` de tu repositorio.

---

# Especificación Técnica de Refactorización: DM Hub

## 1. Metadatos del Proyecto

* **Nombre del Proyecto:** DM Hub
* **Modelo de Negocio:** SaaS (Gratuito inicialmente) / Versión Self-Hosted (Para servidores propios).
* **Enfoque de Mercado:** Distribución de productos alimenticios al mayoreo y clientes particulares (Ecosistema Multi-tienda).
* **Estrategia para el MVP:** Optimizar el tiempo de desarrollo limitando la flexibilidad visual compleja (como editores *drag-and-drop*) a cambio de una arquitectura basada en datos e interruptores fijos.

---

## 2. Arquitectura de Permisos y Roles Globales

* **SuperAdmin:** Control total del ecosistema, gestión de suscripciones/instancias y asignación de permisos globales.
* **Admin:** Permisos de edición orientados exclusivamente a la tienda asignada y sus sucursales.
* **Usuario:** Rol operativo de consulta de información general, visualización de métricas y descarga de reportes en formato CSV/Excel.

---

## 3. Desglose Detallado de Vistas y Pantallas

### 3.1. Landing Page

* **Propósito:** Atraer a nuevos usuarios, explicar la propuesta de valor del HUB multi-tienda y permitir el acceso o registro de administradores de negocios.
* **Descripción Funcional:** Presenta el núcleo del negocio: *"Conecta a distribuidores, minoristas e inventario en un solo lugar"*. Permite la navegación básica a secciones informativas (`About`, `Solutions`, `Documentation`) y los accesos principales (`Log in`, `Sign in`). Facilita que el administrador de la cuenta invite a otros usuarios como colaboradores de su tienda mediante un set de permisos personalizables.
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta un llamado a la acción (CTA) claro y visible en la sección principal (*Hero Section*) como "Comenzar Gratis" o "Desplegar Instancia".
* Falta un selector o apartado visible que guíe al usuario si desea optar por el modelo SaaS en la nube o descargar la versión Self-Hosted.
* No se muestra visualmente cómo se gestiona el set de permisos personalizables por el SuperAdmin antes de enviar las invitaciones.



### 3.2. Dashboard (Inicio)

* **Propósito:** Ofrecer una vista general, consolidada e informativa del estado de la tienda activa sin permitir modificaciones directas en esta sección.
* **Descripción Funcional:** Muestra información relevante condensada de clientes, productos, pagos, pedidos y sucursales. Incluye un buscador global superior para localizar elementos rápidamente. Muestra la URL pública de la tienda en línea y un selector multi-tenant (*Scope*) en la esquina superior derecha que permite crear una nueva tienda o alternar entre tiendas existentes (ej. cambiar de una tienda de alimentos a una de tornillos).
* **Características Especiales:** Sección de lectura pura. Está pensado para integrar notificaciones automáticas y consejos de analítica comercial generados mediante Inteligencia Artificial (IA).
* **Oportunidades de Mejora / Elementos Faltantes:**
* El área de la interfaz dedicada a la IA y notificaciones está descrita en texto pero carece de estructura visual (falta maquetar tarjetas, métricas clave o gráficos de tendencias).
* El flujo para "Crear tienda" está dentro del dropdown de perfil/usuario; podría requerir un asistente (*Wizard*) dedicado para no saturar ese selector.
* Falta un indicador visual claro del estado del servidor o de sincronización, vital para usuarios en la modalidad Self-Hosted.



### 3.3. Sucursales

* **Propósito:** Administrar la infraestructura física o puntos de distribución de la tienda seleccionada.
* **Descripción Funcional:** Permite al usuario con permisos de edición crear sucursales específicas ingresando datos detallados: nombre, dirección general (ej. "Zona 16"), dirección específica, descripción y aspectos logísticos adicionales (como si cuenta con parqueo público o no). Permite listar las sucursales existentes y modificar sus campos en tiempo real.
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta incluir estados de operación para las sucursales (ej. Activa, Inactiva, En Remodelación).
* Falta un mapa interactivo embebido o geolocalización por coordenadas para validar las direcciones específicas de distribución.
* No hay un botón explícito expuesto para la acción de "Crear Sucursal" o "Guardar Cambios" en el wireframe actual.



### 3.4. Reservaciones

* **Propósito:** Moderar y dar seguimiento a los apartados de productos realizados por los clientes desde la tienda online.
* **Descripción Funcional:** Muestra una lista interactiva de las reservas creadas por los usuarios en la vista de cliente. El administrador puede auditar el flujo de trabajo de cada una, marcándolas con estados operativos como "entregadas", "cancelarlas" o "eliminarlas".
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta definir un sistema de alertas o tiempos de expiración para las reservaciones (ej. *"Expira en 2 horas si no se procesa el pago"*).
* El diseño no contempla filtros avanzados por estado de la reserva, fecha, cliente o sucursal de retiro.
* Falta la integración visual con el inventario: mostrar si el producto reservado está retenido o ya fue rebajado del stock global.



### 3.5. Pagos

* **Propósito:** Gestionar la pasarela de pagos, verificar transacciones y configurar las credenciales financieras de la tienda.
* **Descripción Funcional:** Permite visualizar el origen de los pagos realizados desde la vista de cliente a través de la integración nativa con Stripe. El administrador tiene la potestad de marcar manualmente los pagos como "entregados" y configurar de forma independiente sus propias llaves de API de Stripe (esencial para el esquema SaaS descentralizado y Self-Hosted).
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta una sección para gestionar devoluciones, disputas o reembolsos directos a Stripe.
* No se visualiza un historial de transacciones con filtros por ID de cargo, método de pago (tarjeta, transferencia) o estados de validación bancaria.
* Se requiere un indicador visual de seguridad que confirme si las llaves de la API están correctamente encriptadas y conectadas (Modo Sandbox vs. Modo Producción).



### 3.6. Clientes

* **Propósito:** Centralizar el control de datos, historial y perfiles de los compradores de la tienda.
* **Descripción Funcional:** Proporciona una interfaz de visualización completa de los datos de contacto y facturación de los clientes directos y minoristas. Permite realizar operaciones CRUD completas (Crear, Leer, Actualizar, Borrar) sobre estos registros.
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta segmentación de clientes (clasificación explícita entre clientes minoristas, mayoristas, recurrentes o corporativos).
* No hay un enlace directo desde el cliente hacia su historial de pedidos, reservaciones o saldo pendiente.
* Falta una opción para importar/exportar la base de datos de clientes de manera masiva mediante formatos abiertos.



### 3.7. Productos e Inventario

* **Propósito:** Controlar el catálogo de artículos al por mayor y menor, su distribución física y la consistencia del stock.
* **Descripción Funcional:** Permite realizar el CRUD tradicional de productos. Incorpora la funcionalidad de carga masiva de inventario mediante archivos estructurados en formatos `.xlsx` y `.csv` (alineados a la documentación del sistema). Los productos pueden ser asignados a sucursales específicas o agruparlos mediante criterios logísticos independientes a las categorías estándar. Cualquier modificación debe impactar directamente el inventario global.
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta la interfaz de feedback para la carga masiva (pantalla que muestre errores de validación en las filas específicas del archivo Excel/CSV).
* No se visualiza el control de variantes del producto (como tamaños, presentaciones de empaque mayorista vs minorista, unidades de medida).
* Falta un sistema de alertas visuales para productos con stock bajo o próximo a agotarse en sucursales críticas.



### 3.8. Reportes (Diferenciador Principal)

* **Propósito:** Ofrecer análisis avanzado de datos mediante reportes especializados por entidad y consultas directas personalizadas para retener a usuarios técnicos y administradores de servidores.
* **Descripción Funcional:** Permite al usuario navegar entre diferentes categorías de reportes predefinidos mediante pestañas: *Productos, Empleados, Stock Crítico, Demanda y Métodos de Pago*. Su función principal es ofrecer una lectura rápida de métricas clave por entidad y permitir la descarga directa de estos informes consolidados en formatos estructurados `.xlsx` y `.csv`.
* **Oportunidades de Mejora / Elementos Faltantes:**
* El wireframe repite por error el texto descriptivo de la pantalla de usuarios en su contenedor principal; se debe limpiar ese bloque de texto en el desarrollo final.
* Falta integrar visualmente la consola para ingresar consultas SQL personalizadas y el botón de guardado para reportes propios (Diferenciador 1).
* Se necesitan filtros temporales globales (ej. "Este mes", "Últimos 7 días") para que las métricas de las pestañas tengan coherencia cronológica.



### 3.9. Usuarios

* **Propósito:** Administrar el personal del negocio, auditar accesos y asignar roles de trabajo dentro de la tienda activa.
* **Descripción Funcional:** Presenta un panel de control con tarjetas de métricas que resumen el estado del equipo: Total Usuarios, Administradores, Empleados y Activos. Incluye un botón para invitar o crear un "Nuevo Usuario", una barra de búsqueda avanzada por nombre/email y filtros por roles o estado. Abajo despliega una tabla con columnas detalladas de Email, Teléfono, Rol, Estado y Última Actividad.
* **Oportunidades de Mejora / Elementos Faltantes:**
* La tabla actual se corta visualmente en la parte inferior del contenedor del wireframe; requiere paginación o scroll infinito explícito.
* Falta el botón de acción rápida por fila (tres puntos o engranaje) para editar permisos específicos, suspender temporalmente a un usuario o restablecer contraseñas.
* No queda claro visualmente si al crear un usuario se le asigna a una sucursal específica o si tiene acceso global a todas las sucursales de la tienda.



### 3.10. Tienda Online (Editor de Plantillas)

* **Propósito:** Permitir al comerciante personalizar la estética y el orden de los elementos visuales de su e-commerce de cara al cliente final.
* **Descripción Funcional:** Consiste en un editor de bloques lateral simplificado (inspirado en Shopify pero adaptado a un alcance ágil y acotado por el tiempo de desarrollo). El menú izquierdo organiza de forma jerárquica las secciones de la página de inicio: Encabezado, Barra de Anuncios, Plantilla (Hero Banner con botones) y Footer. Cada sección permite "Agregar bloque" o modificar textos internos (ej. *"¡Compra nuestras últimas novedades!"*), reflejando los cambios en una vista previa interactiva en tiempo real a la derecha.
* **Oportunidades de Mejora / Elementos Faltantes:**
* Falta un selector de dispositivo en la barra superior del editor para validar cómo se ve la tienda online en teléfonos móviles frente a computadoras de escritorio (Responsividad).
* Falta un botón claro de "Salir" o "Regresar al Dashboard" para que el usuario no se sienta atrapado en el modo de edición de la plantilla.



---

## 4. Consejos de Arquitectura Estratégica para el Desarrollo del MVP

> ### 🧠 Arquitectura del Editor de Tienda Online
> 
> 
> Para mantener el proyecto viable dentro de tus límites de tiempo y evitar la complejidad extrema de un editor *drag-and-drop* visual libre, implementa un **enfoque basado en esquemas JSON estrictos**:
> 1. El frontend de la tienda del cliente renderiza componentes en un orden específico basado en un objeto JSON guardado en la base de datos de la tienda.
> 2. El editor lateral izquierdo no mueve elementos físicamente; simplemente modifica las propiedades de ese JSON (ej. cambia el string del texto, el path de la imagen o activa/desactiva un booleano para ocultar una sección).
> 3. Limita las opciones a un catálogo fijo de 5 bloques pre-maquetados: `Hero Banner`, `Colección Destacada`, `Grid de Productos`, `Texto Libre` y `Footer`. Esto te ahorrará semanas de lógica de frontend.
> 
> 

> ### 🛠️ Preparación para Entornos Self-Hosted
> 
> 
> Dado que planeas ofrecer una versión que los usuarios puedan instalar en sus propios servidores:
> * **Descentralización de Credenciales:** Asegúrate de que las llaves de Stripe, credenciales de correo (SMTP) y tokens de IA se guarden en variables de entorno (`.env`) o en una tabla de configuraciones global por tienda en la base de datos local, asegurando que ninguna instancia dependa de un servidor central controlado por ti.
> * **Consola SQL de Reportes:** Para la ejecución de queries personalizados en los reportes, implementa una capa de middleware de base de datos que limite las consultas estrictamente a operaciones de lectura (`SELECT`). Bloquea cualquier intento de ejecutar comandos `DROP`, `DELETE`, `UPDATE` o `INSERT` para evitar que un usuario rompa accidentalmente su propia base de datos o escale privilegios.
> 
>
```

## Estado Actual

### Stack Tecnológico

| Capa | Tecnología | Versión |
|---|---|---|
| Backend | .NET / ASP.NET Core | net10.0 |
| Frontend | Next.js (App Router) | 16.2.1 |
| UI | React | 19.2.4 |
| Lenguaje FE | TypeScript | 5.x (strict) |
| Estilos | Tailwind CSS | 4.2.2 |
| Base de datos | PostgreSQL | 16 Alpine |
| ORM | Entity Framework Core | 10.0.5 |
| Pagos | Stripe (Stripe.net + @stripe/react-stripe-js) | 51.1.0 / 6.3.0 |
| Gráficos | Recharts | 2.15.4 |
| Estado global FE | Zustand | 5.0.12 |
| Data fetching FE | SWR + custom hooks | 2.4.1 |
| Autenticación | JWT Bearer + refresh via token revocation | — |
| Hashing | PBKDF2 (SHA-256, 100K iteraciones) | — |
| Documentación API | Swagger (Swashbuckle) + Bruno | — |
| Tests | xUnit + Moq + EF Core InMemory + Mvc.Testing | — |
| Contenedores | Docker + Docker Compose | multi-stage |
| Gestor paquetes FE | pnpm | — |

### Arquitectura — Backend (Clean Architecture)

4 capas con dependencia estricta unidireccional:

```
Domain ← Application ← Infrastructure ← API
```

- **ElohimShop.Domain** — 14 entidades puras (Usuario, Producto, Carrito, Reservacion, Venta, etc.). Sin dependencias externas. Entidades con fábricas estáticas y setters privados.
- **ElohimShop.Application** — DTOs, interfaces de servicio, casos de uso. Depende solo de Domain.
- **ElohimShop.Infrastructure** — Implementaciones concretas: EF Core DbContext, configuraciones Fluent API (snake_case), servicios de autenticación, pagos Stripe, seeders (SuperAdminSeeder, DemoDataSeeder). Depende de Domain + Application.
- **ElohimShop.API** — 11 controladores, DI wiring, JWT config, CORS, middleware Swagger. Entry point de la aplicación.

### Arquitectura — Frontend (Next.js App Router)

Estructura basada en grupos de rutas:

```
app/
  (auth)/       → login, register, recuperar contraseña (GuestAuthGate)
  (admin)/      → dashboard, productos, ventas, usuarios, reportes (AdminRoute)
  (transaccion)/ → carrito → método pago → resumen compra
  catalogo/     → listado + detalle de productos
  carrito/      → confirmación, éxito pago, éxito reserva
  perfil/, reservas/, transferencia_bancaria/, etc.
```

Patrón de capas frontend:
- `app/` → páginas (componen UI desde feature components)
- `components/features/` → componentes de negocio por dominio (auth, carrito, catalogo, admin, etc.)
- `components/ui/` → primitivas reutilizables (button, card, modal, table, chart)
- `hooks/` → custom hooks para data fetching con estados loading/error/empty
- `stores/` → estado global con Zustand (auth, carrito, UI, método pago)
- `lib/api/` → capa HTTP centralizada (todas las llamadas al backend)
- `types/` → interfaces TypeScript compartidas

### Base de Datos — Esquema PostgreSQL

14 tablas en esquema público:

**Usuarios y seguridad:**
- `Usuario` — base con `correo` (UNIQUE), `tipo_usuario` (cliente|administrador), `estado`, `stripe_customer_id`
- `ClientePerfil` — extensión para clientes (`tipo_cliente`, `direccion`)
- `AdministradorPerfil` — extensión para admins (`rol`: cajero|administrador)
- `TokenRevocado` — revocación de JWT (`jti` UNIQUE)

**Catálogo:**
- `Marca`, `Categoria` — clasificaciones
- `Producto` — `codigo_producto` UNIQUE, CHECK precio>0, stock>=0

**Transaccional:**
- `Carrito` — uno por cliente (`cliente_id` UNIQUE)
- `ArticuloCarrito` — items del carrito, UNIQUE(carrito_id, producto_id)
- `Reservacion` — órdenes con `codigo_reservacion` UNIQUE, `stripe_payment_intent_id`, estado
- `DetalleReservacion` — líneas de reserva, subtotal GENERATED ALWAYS AS STORED
- `Venta` — ventas realizadas, 1:1 con Reservacion
- `MetodoPago` — métodos guardados (tarjetas Stripe, alias, últimos dígitos, expiración)

**Comunicación:**
- `Consulta` — consultas cliente ↔ administrador

Convenciones: PascalCase con comillas (alineado a EF Core), TIMESTAMPTZ, PKs VARCHAR(255) (GUIDs como string), CHECK constraints en dominio, índices en FKs.

### Contenerización

`docker-compose.yml` define 4 servicios:

| Servicio | Imagen | Puerto expuesto | Detalles |
|---|---|---|---|
| `db` | postgres:16-alpine | 5433:5432 | Healthcheck con pg_isready, volumen persistente `elohim_postgres_data`, init SQL desde `db/elohim_db.sql` |
| `backend` | Build local (multi-stage SDK 10.0) | 5000:5000 | Entrypoint con espera a DB + validación de esquema; aplica SQL si falta; depende de `db: healthy` |
| `frontend` | Build local (node:22-alpine multi-stage) | 3000:3000 | Next standalone output; depende de backend |
| `adminer` | adminer:latest | 8080:8080 | Interfaz gráfica de administración de BD |

Dockerfile backend: 2 etapas (build SDK 10.0 + final SDK 10.0 con psql client). Incluye `entrypoint.sh` que: espera DB, verifica tabla Usuario, aplica schema SQL, ejecuta dotnet.

Dockerfile frontend: 3 etapas (deps → builder → runner). Build arg `NEXT_PUBLIC_API_URL` y `BACKEND_API_URL`. Output `standalone` optimizado.

### Estado del Proyecto

- **Completo y funcional:** Flujo completo de compra (catálogo → carrito → reserva/pago Stripe → confirmación), panel admin (CRUD productos, gestión usuarios, ventas), autenticación con JWT, reportes con gráficos.
- **Problemas identificados:**
  - Schema DB gestionado por SQL plano (`elohim_db.sql`) + EF Migrations como fuente secundaria, creando posible deriva entre ambos
  - Contenedor final del backend usa imagen `sdk:10.0` (no `aspnet:10.0`), añadiendo peso innecesario (~1.5 GB vs ~200 MB)
  - Frontend Dockerfile copia `pnpm-workspace.yaml` sin verificar su existencia real en el contexto adecuado
  - No hay CI/CD pipeline definido (sin GitHub Actions ni similar)
  - Algunas rutas del frontend no están agrupadas consistentemente (ej. `/carrito` fuera de `(transaccion)`)
  - Endpoints API documentados en Swagger pero sin versioneado explícito de API
  - Tests unitarios limitados (solo 4 carpetas de tests: Auth, Carrito, Reservacion, Usuario)
  - Variables de entorno duplicadas entre `backend/.env.example` y `docker-compose.yml`
  - Sin manejo de secretos para producción (Stripe keys, JWT keys en config)
  - Seed data condicional (`SEED_DATA` / `SEED_DEMO_DATA`) con lógica duplicada


## REFACTORIZACIÓN

# 🚀 Documento de Arquitectura y Especificación Técnica: DM Hub
**Versión:** 2.0 (SaaS Multi-Tenant / Self-Hosted)
**Stack Base:** .NET 10 (Clean Architecture) ➔ Next.js 16 (App Router) ➔ PostgreSQL ➔ Better Auth ➔ Cloudinary

---

## 🏛️ 1. Pilares de la Nueva Arquitectura

### A. Aislamiento Multi-Tenant (SaaS) y Portabilidad (Self-Hosted)
* **SaaS Centralizado:** Se utiliza una estrategia de **Base de Datos Única con Aislamiento Lógico**. Todas las tablas operativas de negocio incluyen una clave foránea `tienda_id`. El `DbContext` de Entity Framework Core aplica un *Global Query Filter* automático para interceptar cualquier consulta y restringirla al tenant activo.
* **Self-Hosted:** El código se mantiene idéntico. En entornos auto-alojados, el sistema operará con un único registro en la tabla `Tienda`. El aislamiento lógico garantiza que, si el cliente expande su infraestructura local a múltiples sucursales o marcas en el futuro, el software ya estará listo.

### B. Descentralización de Credenciales y Terceros
* **Imágenes y Documentos (Cloudinary):** El backend de .NET ya no procesa ni almacena archivos binarios en el disco local ni en volúmenes Docker rígidos. Todo se delega a Cloudinary mediante URLs eficientes y firmas seguras temporales, facilitando despliegues *stateless* e instantáneos.
* **Pasarela de Pagos (Stripe Colectivo/Individual):** Las claves API de Stripe no están quemadas en las variables de entorno globales. Se leen dinámicamente desde la base de datos de acuerdo al `tienda_id` en ejecución, permitiendo que cada inquilino reciba el dinero en su propia cuenta bancaria.

### C. Autenticación Unificada (Better Auth)
* La responsabilidad de la firma, hashing, tokens de refresco, sesiones activas y flujos OAuth se delega por completo a **Better Auth** en el ecosistema de Next.js. 
* El backend de .NET se desacopla de los formularios de login directos y pasa a actuar estrictamente como un **Resource Server (API Protegida)** que lee, valida y autoriza las peticiones interceptando la sesión o el token propagado desde la capa Frontend.

---

## 🗄️ 2. Modelo de Datos Renovado (PostgreSQL)

El esquema unifica las tablas requeridas nativamente por Better Auth con la estructura de control multi-sucursal y los discriminadores multi-tenant indispensables para el negocio de alimentos.

```sql
-- ============================================================
-- DM HUB — ESQUEMA GLOBAL POSTGRESQL (MULTI-TENANT V2)
-- ============================================================

-- ------------------------------------------------------------
-- INFRAESTRUCTURA OPERATIVA (TENANCY & CONTROL)
-- ------------------------------------------------------------

CREATE TABLE "Tienda" (
    id                    VARCHAR(255) PRIMARY KEY,
    nombre                VARCHAR(100) NOT NULL,
    slug                  VARCHAR(100) NOT NULL UNIQUE, -- Ej: 'elohim-alimentos'
    estado                VARCHAR(20)  NOT NULL DEFAULT 'activo', -- 'activo', 'suspendido'
    configuracion_visual  JSONB        NOT NULL DEFAULT '{}', -- Árbol JSON para el editor estilo Shopify
    fecha_creacion        TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);
CREATE INDEX ix_tienda_slug ON "Tienda" (slug);

CREATE TABLE "Sucursal" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    nombre         VARCHAR(100) NOT NULL,
    direccion      TEXT,
    telefono       VARCHAR(30),
    fecha_creacion TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);
CREATE INDEX ix_sucursal_tienda_id ON "Sucursal" (tienda_id);

-- ------------------------------------------------------------
-- TABLAS NATIVAS BETTER AUTH (EXTENDIDAS PARA MULTI-TENANCY)
-- ------------------------------------------------------------

CREATE TABLE "user" (
    id                  VARCHAR(255) PRIMARY KEY,
    name                VARCHAR(255) NOT NULL,
    email               VARCHAR(255) NOT NULL,
    "emailVerified"     BOOLEAN     NOT NULL DEFAULT FALSE,
    image               VARCHAR(500), -- Almacena la URL directa de Cloudinary
    "createdAt"         TIMESTAMPTZ  NOT NULL,
    "updatedAt"         TIMESTAMPTZ  NOT NULL,
    
    -- Atributos extendidos de Negocio y Rol Multi-tenant
    tienda_id           VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    tipo_usuario        VARCHAR(30)  NOT NULL, -- 'cliente' | 'staff'
    rol_staff           VARCHAR(30)  DEFAULT NULL, -- 'administrador', 'cajero', 'logistica'
    telefono            VARCHAR(30),
    stripe_customer_id  VARCHAR(255),
    
    CONSTRAINT uq_email_per_tienda UNIQUE (email, tienda_id)
);
CREATE INDEX ix_user_tienda_id ON "user" (tienda_id);

CREATE TABLE "session" (
    id             VARCHAR(255) PRIMARY KEY,
    "expiresAt"    TIMESTAMPTZ  NOT NULL,
    token          VARCHAR(255) NOT NULL UNIQUE,
    "createdAt"    TIMESTAMPTZ  NOT NULL,
    "updatedAt"    TIMESTAMPTZ  NOT NULL,
    "userId"       VARCHAR(255) NOT NULL REFERENCES "user" (id) ON DELETE CASCADE,
    "ipAddress"    VARCHAR(50),
    "userAgent"    TEXT
);

CREATE TABLE "account" (
    id                    VARCHAR(255) PRIMARY KEY,
    "accountId"           VARCHAR(255) NOT NULL,
    "providerId"          VARCHAR(255) NOT NULL,
    "userId"              VARCHAR(255) NOT NULL REFERENCES "user" (id) ON DELETE CASCADE,
    "accessToken"         TEXT,
    "refreshToken"        TEXT,
    "idToken"             TEXT,
    "accessTokenExpiresAt" TIMESTAMPTZ,
    "refreshTokenExpiresAt" TIMESTAMPTZ,
    "scope"               TEXT,
    "password"            TEXT, -- Hasheado nativamente por Better Auth
    "createdAt"           TIMESTAMPTZ  NOT NULL,
    "updatedAt"           TIMESTAMPTZ  NOT NULL
);

CREATE TABLE "verification" (
    id           VARCHAR(255) PRIMARY KEY,
    identifier   VARCHAR(255) NOT NULL,
    value        VARCHAR(255) NOT NULL,
    "expiresAt"  TIMESTAMPTZ  NOT NULL,
    "createdAt"  TIMESTAMPTZ,
    "updatedAt"  TIMESTAMPTZ
);

-- ------------------------------------------------------------
-- ENTIDADES DE CATÁLOGO E INVENTARIOS
-- ------------------------------------------------------------

CREATE TABLE "Categoria" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    nombre         VARCHAR(100) NOT NULL,
    descripcion    TEXT,
    imagen_url     VARCHAR(500), -- Cloudinary
    slug           VARCHAR(100) NOT NULL,
    CONSTRAINT uq_categoria_slug_tienda UNIQUE (slug, tienda_id)
);

CREATE TABLE "Producto" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    categoria_id   VARCHAR(255) REFERENCES "Categoria" (id) ON DELETE SET NULL,
    nombre         VARCHAR(150) NOT NULL,
    descripcion    TEXT,
    sku            VARCHAR(100),
    precio_mayoreo NUMERIC      NOT NULL CHECK (precio_mayoreo >= 0),
    precio_detalle NUMERIC      NOT NULL CHECK (precio_detalle >= 0),
    imagen_url     VARCHAR(500), -- Cloudinary
    publicado      BOOLEAN      NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);
CREATE INDEX ix_producto_tienda_id ON "Producto" (tienda_id);

CREATE TABLE "Inventario" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    sucursal_id    VARCHAR(255) NOT NULL REFERENCES "Sucursal" (id) ON DELETE CASCADE,
    producto_id    VARCHAR(255) NOT NULL REFERENCES "Producto" (id) ON DELETE CASCADE,
    stock          INT          NOT NULL DEFAULT 0 CHECK (stock >= 0),
    CONSTRAINT uq_sucursal_producto UNIQUE (sucursal_id, producto_id)
);

-- ------------------------------------------------------------
-- FLUJO TRANSACCIONAL Y CHECKOUT
-- ------------------------------------------------------------

CREATE TABLE "CarritoElemento" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    usuario_id     VARCHAR(255) NOT NULL REFERENCES "user" (id) ON DELETE CASCADE,
    producto_id    VARCHAR(255) NOT NULL REFERENCES "Producto" (id) ON DELETE CASCADE,
    cantidad       INT          NOT NULL CHECK (cantidad > 0),
    fecha_adicion  TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE "Reservacion" (
    id               VARCHAR(255) PRIMARY KEY,
    tienda_id        VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    sucursal_id      VARCHAR(255) NOT NULL REFERENCES "Sucursal" (id) ON DELETE RESTRICT,
    usuario_id       VARCHAR(255) NOT NULL REFERENCES "user" (id) ON DELETE RESTRICT,
    monto_total      NUMERIC      NOT NULL,
    estado_pago      VARCHAR(30)  NOT NULL DEFAULT 'pendiente', -- 'pendiente', 'pagado', 'fallido'
    estado_despacho  VARCHAR(30)  NOT NULL DEFAULT 'procesando', -- 'procesando', 'en_ruta', 'entregado'
    stripe_intent_id VARCHAR(255),
    fecha_reserva    TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE "DetalleReservacion" (
    id             VARCHAR(255) PRIMARY KEY,
    reservacion_id VARCHAR(255) NOT NULL REFERENCES "Reservacion" (id) ON DELETE CASCADE,
    producto_id    VARCHAR(255) NOT NULL REFERENCES "Producto" (id) ON DELETE RESTRICT,
    cantidad       INT          NOT NULL CHECK (cantidad > 0),
    precio_cobrado NUMERIC      NOT NULL, -- Captura precio exacto cobrado (mayoreo o detalle)
    subtotal       NUMERIC      NOT NULL GENERATED ALWAYS AS (cantidad * precio_cobrado) STORED
);

-- ------------------------------------------------------------
-- COMPONENTES DIFERENCIADORES
-- ------------------------------------------------------------

CREATE TABLE "ReportePersonalizado" (
    id             VARCHAR(255) PRIMARY KEY,
    tienda_id      VARCHAR(255) NOT NULL REFERENCES "Tienda" (id) ON DELETE CASCADE,
    nombre         VARCHAR(150) NOT NULL,
    descripcion    TEXT,
    query_sql      TEXT         NOT NULL, -- Query SELECT pura, sanitizada en .NET
    creado_por     VARCHAR(255) REFERENCES "user" (id) ON DELETE SET NULL,
    fecha_creacion TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE TABLE "CredencialesIntegracion" (
    tienda_id             VARCHAR(255) PRIMARY KEY REFERENCES "Tienda" (id) ON DELETE CASCADE,
    stripe_secret_key     TEXT, -- Encriptación simétrica AES-256 en Backend
    stripe_public_key     TEXT,
    cloudinary_cloud_name VARCHAR(100),
    cloudinary_api_key    VARCHAR(100),
    cloudinary_api_secret TEXT  -- Encriptación simétrica AES-256 en Backend
);

```

---

## 🛣️ 3. Catálogo de Endpoints REST (Backend .NET 10)

Todos los endpoints operativos de negocio exigen de forma obligatoria el header HTTP `X-Tenant-ID` o, en su defecto, deducen la información del contexto de claims de sesión inyectado por el middleware.

### 🏢 A. Gestión de Tiendas e Infraestructura SaaS

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `POST` | `/api/v1/tiendas` | Público | Registra un nuevo Inquilino (Onboarding del SaaS). Inicializa los esquemas mínimos. |
| `GET` | `/api/v1/tiendas/valida-slug/{slug}` | Público | Comprueba la disponibilidad de un subdominio/slug comercial. |
| `PUT` | `/api/v1/tiendas/configuracion-visual` | Staff (Admin) | Guarda el JSON de bloques dinámicos para el constructor web estilo Shopify. |
| `POST` | `/api/v1/tiendas/integraciones` | Staff (Admin) | Almacena y cifra llaves de API individuales (Stripe/Cloudinary). |

### 🖼️ B. Archivos Multimedia (Cloudinary Middleware)

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `GET` | `/api/v1/media/cloudinary-signature` | Staff | Genera un token y firma de autenticación (*Presigned URL*) para que el frontend suba el archivo directamente a Cloudinary sin penalizar al backend. |
| `DELETE` | `/api/v1/media` | Staff | Remueve físicamente un asset de Cloudinary utilizando su identificador único (`public_id`). |

### 📦 C. Catálogo de Productos e Inventarios

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `GET` | `/api/v1/productos` | Público | Retorna catálogo paginado y filtrado de la tienda activa. |
| `GET` | `/api/v1/productos/{id}` | Público | Detalle extendido de un artículo con desglose por sucursales. |
| `POST` | `/api/v1/productos` | Staff (Admin) | Almacena un producto físico (recibe la URL de Cloudinary ya resuelta). |
| `PUT` | `/api/v1/productos/{id}` | Staff (Admin) | Modificación y edición de parámetros de un producto. |
| `DELETE` | `/api/v1/productos/{id}` | Staff (Admin) | Eliminación del registro. |
| `GET` | `/api/v1/inventarios/sucursal/{sucursalId}` | Staff | Estado del stock consolidado de una sucursal específica. |
| `PUT` | `/api/v1/inventarios/ajuste` | Staff (Cajero) | Registro de mermas, entradas manuales de inventario o auditorías físicas. |

### 🛒 D. Carrito de Compras Transaccional

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `GET` | `/api/v1/carrito` | Cliente Auth | Obtiene todos los artículos reservados temporalmente por el cliente. |
| `POST` | `/api/v1/carrito/articulos` | Cliente Auth | Inserta un producto al carrito o incrementa sus unidades. |
| `PUT` | `/api/v1/carrito/articulos/{id}` | Cliente Auth | Reajusta la cantidad exacta de un artículo en el carrito. |
| `DELETE` | `/api/v1/carrito/articulos/{id}` | Cliente Auth | Vacía o remueve un artículo específico del carrito. |

### 💳 E. Órdenes, Reservas y Pasarela Stripe

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `POST` | `/api/v1/checkout/crear-intento` | Cliente Auth | Extrae las llaves dinámicas de Stripe de la tienda, calcula precios por tipo de cliente (mayorista/detalle) y genera el `clientSecret` del `PaymentIntent`. |
| `POST` | `/api/v1/reservaciones` | Cliente Auth | Consolida formalmente el pedido una vez el frontend confirma la aprobación bancaria. |
| `GET` | `/api/v1/reservaciones/mis-compras` | Cliente Auth | Historial de transacciones y estados del cliente final. |
| `GET` | `/api/v1/reservaciones/control-staff` | Staff | Consola de pedidos entrantes agrupados por sucursal para despacho. |
| `PATCH` | `/api/v1/reservaciones/{id}/estado` | Staff (Logística) | Transición de flujo operativo (`procesando` ➔ `en_ruta` ➔ `entregado`). |

### 📊 F. Consola SQL Segura para Reportes

| Método | Endpoint | Acceso | Descripción |
| --- | --- | --- | --- |
| `POST` | `/api/v1/reportes/ejecutar-raw` | Staff (Admin) | Evalúa una cadena SQL raw. **Filtra a través del motor estricto Regex/Parser de mutación y ejecuta en un contexto Read-Only de base de datos.** |
| `POST` | `/api/v1/reportes/guardar` | Staff (Admin) | Guarda la cadena SQL validada para su ejecución recurrente en el Dashboard. |
| `GET` | `/api/v1/reportes` | Staff | Lista las plantillas de reportes disponibles creadas por el comercio. |
| `GET` | `/api/v1/reportes/{id}/correr` | Staff | Invoca la query pre-almacenada y extrae el dataset crudo en JSON. |

---

## 🎨 4. Mecánica del Editor Visual Dinámico (Estilo Shopify)

Para evitar la complejidad e inestabilidad de motores pesados de arrastrar y soltar, la personalización visual se gestiona enteramente mediante **Estructuras de Datos Planas (JSONB)**.

```
       PANEL DE CONTROL NEXT.JS (ADMIN)                 VISTA PREVIA DE LA TIENDA (IFRAME)
+--------------------------------------------+    +--------------------------------------------+
|  [Secciones]                               |    |                                            |
|  - Barra Anuncio  --> [Editar Campos]      |    |  (Barra de Anuncios Renderizada)            |
|  - Hero Banner    --> (Inputs / Colores)  |--->|                                            |
|  - Productos                               |    |  [ Hero Banner Dinámico ]                  |
|                                            |    |  "Distribución de Alimentos al Mayoreo"   |
|   (Zustand State cambia al escribir)       |    |                                            |
+--------------------------------------------+    +--------------------------------------------+
                      |                                                 ^
                      +------------------ postMessage ------------------+

```

### Protocolo de Renderizado y Sincronización en Tiempo Real

1. **Edición:** El panel de administración (`(admin)/tienda/editor`) levanta la configuración JSONB desde .NET y la deposita en un Store de **Zustand**. La pantalla pinta a la izquierda los formularios reactivos y a la derecha un tag `<iframe>` apuntando a la ruta pública de la tienda del cliente.
2. **Sincronización:** Cada interacción del usuario (un cambio de color o una letra modificada en el banner) dispara un evento en Zustand que envía un mensaje nativo a través del navegador:
`iframeRef.current.contentWindow.postMessage(updatedJson, '*')`.
3. **Recepción:** La vista pública dentro del iframe posee un listener global (`window.addEventListener('message')`). Al recibir el payload, actualiza su variable de estado local en React, provocando un re-renderizado instantáneo y fluido sin refrescar la página.

---

## 🛠️ 5. Plan de Acción Secuencial (Backlog de Tareas Específicas)

### 🧱 Fase 1: Saneamiento de Deuda Técnica y Contenedores (Inmediato)

* **[ ] Tarea 1.1: Consolidación de Fuente de Verdad del Esquema**
* *Acción:* Remueve por completo el archivo `elohim_db.sql` del script de inicio del contenedor Docker. Traspasa toda lógica de base de datos a archivos de configuración de Fluent API dentro del proyecto `ElohimShop.Infrastructure`.
* *Acción:* Añade en el punto de entrada de la aplicación API (`Program.cs`) el comando secuencial `context.Database.Migrate()` en entornos de desarrollo/staging para automatizar las actualizaciones del esquema PostgreSQL.


* **[ ] Tarea 1.2: Reducción drástica de peso en Imagen Docker del Backend**
* *Acción:* Modifica el `Dockerfile` del backend para implementar una construcción real multi-etapa (*multi-stage*). Usa `mcr.microsoft.com/dotnet/sdk:10.0` únicamente para operaciones de restauración, compilación y publicación (`dotnet publish`). La fase final de ejecución en producción debe heredar estrictamente de la imagen ligera de runtime `mcr.microsoft.com/dotnet/aspnet:10.0`. (Objetivo: Bajar de ~1.5 GB a menos de 250 MB).


* **[ ] Tarea 1.3: Corrección del Entorno Frontend en Docker**
* *Acción:* Remueve la referencia huérfana de copia de `pnpm-workspace.yaml` del Dockerfile del frontend para evitar fallos de contexto y asegurar un build exitoso en modo `standalone` con Next.js.



### 🏢 Fase 2: Inyección Multi-Tenant en Capa de Datos (.NET 10)

* **[ ] Tarea 2.1: Implementación de Entidad Inquilino**
* *Acción:* Crea las clases de dominio `Tienda` y `Sucursal`. Modifica el resto de entidades del catálogo (`Producto`, `Categoria`, `Usuario`, `Reservacion`) para incluir la propiedad `public string TiendaId { get; set; }` configurando relaciones de llave foránea explícitas.


* **[ ] Tarea 2.2: Configuración del Inyector e Interceptor de Inquilino**
* *Acción:* Escribe un servicio scoped denominado `TenantProvider` encargado de exponer el método `GetTenantId()`. Este componente leerá directamente el header `X-Tenant-ID` de la petición HTTP actual a través de `IHttpContextAccessor`.


* **[ ] Tarea 2.3: Configuración de Filtros de Consulta Globales en EF Core**
* *Acción:* En la clase `ElohimShopDbContext`, sobrescribe el método `OnModelCreating` e introduce dinámicamente un `HasQueryFilter` en cada mapeo de entidad que requiera aislamiento lógico, garantizando que ninguna consulta SQL exponga datos cruzados accidentalmente:
`builder.Entity<Producto>().HasQueryFilter(p => p.TiendaId == _tenantProvider.GetTenantId());`



### 🔐 Fase 3: Integración de Autenticación Better Auth y Almacenamiento

* **[ ] Tarea 3.1: Migración de Modelos Better Auth a .NET**
* *Acción:* Declara en C# las estructuras idénticas de entidades para `User`, `Session`, `Account` y `Verification` respetando fielmente el nombre exacto de tablas y columnas (usando camelCase o comillas en Fluent API) requeridas por Better Auth para que el SDK de TypeScript pueda interactuar directamente sobre la misma base de datos PostgreSQL.


* **[ ] Tarea 3.2: Middleware de Validación de Sesión en Backend**
* *Acción:* Escribe un Middleware personalizado en .NET 10 que intercepte los tokens o cookies de sesión generados por Better Auth. El middleware consultará la validez de la sesión en la base de datos y, si es correcta, inyectará los claims del usuario y su rol en el contexto de ejecución de ASP.NET (`HttpContext.User`).


* **[ ] Tarea 3.3: Integración de Mecanismo de Firmas Cloudinary**
* *Acción:* Desarrolla un servicio `CloudinaryService` en el backend que extraiga las llaves de acceso cifradas de la tienda desde la tabla `CredencialesIntegracion`. Implementa el endpoint `/api/v1/media/cloudinary-signature` que compute firmas SHA-256 válidas basadas en timestamps para que el frontend suba imágenes directamente, recibiendo en .NET únicamente strings de URLs públicas.



### 📊 Fase 4: Desarrollo de Bloques Diferenciadores y Frontend

* **[ ] Tarea 4.1: Construcción de Capa Segura de Ejecución SQL**
* *Acción:* Crea un repositorio específico en .NET que utilice ADO.NET o Dapper. Configura su cadena de conexión apuntando a un rol de PostgreSQL que posea exclusivamente privilegios de consulta `SELECT` (Read-Only). Antes de enviar el string a la BD, añade una validación estricta que bloquee comandos destructivos o de modificación (`DROP`, `DELETE`, `UPDATE`, `INSERT`, `ALTER`).


* **[ ] Tarea 4.2: Programación de Componentes Primitivos de Tienda en Next.js**
* *Acción:* Codifica el catálogo de bloques reactivos reutilizables en Tailwind (`HeroBanner.tsx`, `AnnouncementBar.tsx`, `ProductGrid.tsx`, `Footer.tsx`). Configura sus propiedades visuales (textos, fuentes, colores de fondo) para que se alimenten dinámicamente de un objeto de configuración recibido por parámetro.


* **[ ] Tarea 4.3: Implementación de la Comunicación con el Iframe del Editor**
* *Acción:* En la vista del constructor visual del panel de administración, configura un hook de efecto sincronizado con el Store de Zustand que emita el JSON actualizado hacia el elemento iframe. En la contraparte de la tienda pública, activa el receptor de mensajes globales del navegador (`window.addEventListener('message')`) para inyectar los datos en tiempo real al esquema de componentes estáticos.