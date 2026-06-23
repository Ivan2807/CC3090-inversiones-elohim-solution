# DM Hub - Distributors Marketplace Hub

Plataforma unificada multi-tenant (multi-inquilino) diseñada para digitalizar y gestionar operaciones comerciales de tiendas de distribución y logística, integrando un constructor visual de páginas web (Storefront), control de inventarios físicos por sucursal, pasarela de pagos integrada y reportes avanzados.

---

## 🛠️ Stack Tecnológico

[![Next.js](https://img.shields.io/badge/Next.js-16.2-black?style=for-the-badge&logo=nextdotjs)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-19.0-blue?style=for-the-badge&logo=react)](https://react.dev/)
[![Zustand](https://img.shields.io/badge/Zustand-5.0-orange?style=for-the-badge)](https://zustand-demo.pmnd.rs/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.0-38B2AC?style=for-the-badge&logo=tailwindcss)](https://tailwindcss.com/)
[![Better-Auth](https://img.shields.io/badge/Better--Auth-1.6-red?style=for-the-badge)](https://better-auth.com/)
<br>
[![ASP.NET Core](https://img.shields.io/badge/.NET_Core_8.0-API-512BD4?style=for-the-badge&logo=dotnet)](https://dotnet.microsoft.com/)
[![EF Core](https://img.shields.io/badge/EF_Core-8.0-512BD4?style=for-the-badge)](https://learn.microsoft.com/ef/core/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16.0-336791?style=for-the-badge&logo=postgresql)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker)](https://www.docker.com/)

---

## 📐 Arquitectura del Sistema

El siguiente diagrama detalla la arquitectura física y lógica del DMV Hub, ilustrando el flujo de peticiones desde el cliente hasta la base de datos y los servicios externos:

```mermaid
graph TD
    Client[Cliente / Navegador] -->|HTTP/HTTPS| Frontend[Frontend: Next.js Port 3000]
    Client -->|API Requests| Backend[Backend C# API: ASP.NET Core Port 5000]
    
    subgraph Frontend Services
        Frontend -->|Zustand Local Storage| Store[Sesión Cliente/Staff]
        Frontend -->|Stripe SDK| StripeService[Stripe Elements]
    end

    subgraph Backend Pipeline
        Backend -->|CORS| BCors[CORS Policy]
        BCors -->|Resolve Tenant| BResolver[TenantResolverMiddleware]
        BResolver -->|Parse Session| BAuth[BetterAuthSessionMiddleware]
        BAuth -->|Controllers| BControllers[API Controllers]
    end

    subgraph Database Layer
        BControllers -->|PlatformDbContext| DB[(PostgreSQL Port 5433)]
        BControllers -->|ElohimShopDbContext| DB_Legacy[(Legacy DB)]
        Frontend -->|Better-Auth Client| DB
    end

    subgraph External APIs
        BControllers -->|Carga Multimedia| Cloudinary[Cloudinary API]
        BControllers -->|Notificaciones OTP| SMTP[SMTP Server]
        BControllers -->|Intenciones & Webhooks| StripeAPI[Stripe API]
    end
```

---

## 📂 Directorio de Documentación

Hemos reestructurado la documentación para mantenerla al día con el código refacturado. A continuación se presentan los enlaces a las guías detalladas de cada componente:

### Backend 🖥️
* 🗄️ **[DATABASE.md](backend/docs/DATABASE.md)**: Detalle del esquema PostgreSQL, los DbContexts (`PlatformDbContext` y `ElohimShopDbContext`), triggers automáticos para deducción de stock e inicializadores de semillas (seeders).
* 🔌 **[API.md](backend/docs/API.md)**: Listado completo de endpoints por controlador, estructuras de entrada (payloads), parámetros de consulta (query) y códigos de respuesta.
* 🌐 **[NETWORK.md](backend/docs/NETWORK.md)**: Flujo de red en C#, configuración de políticas de orígenes permitidos (CORS) y análisis del funcionamiento de los middlewares personalizados de detección de inquilinos (`TenantResolver`) y validación de sesiones (`BetterAuthSession`).

### Frontend 🎨
* 🔐 **[AUTHENTICATION.md](frontend/docs/AUTHENTICATION.md)**: Gestión de sesiones cliente/staff persistentes con Zustand y su integración directa mediante la tabla `session` de la base de datos.
* 🛣️ **[ROUTES.md](frontend/docs/ROUTES.md)**: Mapa de rutas, control de acceso basado en roles y protección mediante puertas de enlace reactivas (`ClientProtectedRoute` y `GuestAuthGate`).
* 🎨 **[STORE_BUILDER.md](frontend/docs/STORE_BUILDER.md)**: Estructura del constructor visual de páginas web, el esquema JSONB de configuración y el previsualizador responsivo.
* ⚙️ **[CONFIG_PAGE.md](frontend/docs/CONFIG_PAGE.md)**: Guía para configurar integraciones y credenciales de Stripe, Cloudinary y SMTP directamente desde el Portal.

---

## 🚀 Guía de Inicio Rápido (Docker)

El proyecto está dockerizado para poder ejecutarse en cualquier entorno local con Docker y Docker Compose instalado.

### 1. Clonar el repositorio con submódulos
```bash
git clone --recurse-submodules https://github.com/angc-labs/CC3090-inversiones-elohim-solution.git
cd CC3090-inversiones-elohim-solution
```

### 2. Configurar variables de entorno
Crea los archivos `.env` a partir de las plantillas provistas:
```bash
cp .env.example .env
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```
*(Asegúrate de rellenar las llaves de Stripe y Cloudinary en los archivos correspondientes si requieres probar las pasarelas).*

### 3. Levantar la aplicación
```bash
docker compose up -d --build
```

El orquestador levantará tres contenedores principales:
* **Base de datos (db)**: Servidor PostgreSQL levantado en el puerto host `5433`.
* **API Backend (backend)**: Servidor de ASP.NET Core ejecutándose en el puerto `5000`.
* **Aplicación Frontend (frontend)**: Aplicación Next.js expuesta en el puerto `3000`.

### 4. Accesos útiles
* **Portal del Cliente / Administrador**: [http://localhost:3000](http://localhost:3000)
* **Documentación interactiva Swagger**: [http://localhost:5000/swagger](http://localhost:5000/swagger)
* **Cuenta Super Admin por Defecto**: `superadmin@dmhub.gt` / `SuperAdmin123!`
* **Cuentas Demo de Prueba** *(si `SEED_DATA=true`)*: `carlos.demo@dmhub.gt` / `Demo123!` o `cliente.demo@dmhub.gt` / `Demo123!`