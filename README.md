# CC3090-inversiones-elohim-solution

> Directory description
>
> * `scrum`: documentation related to the project management process.
> * `avances-1`: PDF document with progress on the project's Design Thinking phase.
> * `corte-1`: PDF document containing the complete Design Thinking process of the project.
> * `avances-2`: PDF document with progress from the project's ideation phase.


## Clone

```bash
git clone --recurse-submodules https://github.com/angc-labs/CC3090-inversiones-elohim-solution.git
```

## Ejecutar (Docker)

```bash
docker compose up -d --build
```

- Frontend: http://localhost:3000  
- API / Swagger: http://localhost:5000/swagger  

Documentación:

- [backend/docs/endpoints.md](backend/docs/endpoints.md) — endpoints, Swagger, seeds (`SEED_DATA` en `backend/.env`)  
- [backend/README.md](backend/README.md) — backend, PostgreSQL, Docker  
- [backend/.env.example](backend/.env.example) — variables de entorno del API  
- [frontend/docs/RUTAS.md](frontend/docs/RUTAS.md) — rutas protegidas y panel admin  
- [frontend/README.md](frontend/README.md) — desarrollo del frontend  