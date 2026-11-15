# ViveLocal

App móvil de descubrimiento de lugares y eventos locales (turismo + vida de barrio).

- **Mapa open source**: OpenStreetMap con `flutter_map` (sin Google Maps).
- **Navegación externa**: botón "Abrir en Google Maps" (ruta por
  `https://www.google.com/maps/dir/`, abre la app o la versión web).
- **Backend**: Firebase (Firestore, Storage, Auth, Analytics, Crashlytics, FCM).
- **Auth obligatoria**: onboarding, login obligatorio y rutas protegidas con
  GoRouter; logout con confirmación. Google, email/contraseña y biometría. Sin
  Facebook Login.
- **Offline**: Drift/SQLite para favoritos y reseñas (base creada).
- **i18n**: español, inglés y árabe (RTL).

## Stack

| Capa | Paquete |
|---|---|
| Estado | `flutter_riverpod` 3 + `riverpod_generator` |
| Navegación | `go_router` |
| Red | `dio` + `retrofit` |
| Backend | Firebase |
| Mapa | `flutter_map` + `latlong2` |
| Geolocalización | `geolocator` |
| Base local | `drift` + `drift_flutter` |
| i18n | `flutter_localizations` + `intl` (.arb) |
| Auth social | `google_sign_in` |
| Seguridad | `flutter_secure_storage`, `local_auth` |
| Multimedia | `camera`, `image_picker`, `video_player`, `permission_handler` |
| Notificaciones | `firebase_messaging`, `flutter_local_notifications` |
| Tests | `flutter_test`, `mockito`, `integration_test` |

## Arquitectura

Feature-first + Clean Architecture (`presentation → domain ← data`). El dominio no
depende de Flutter ni Firebase.

```
lib/
├── main.dart / app.dart
├── configs/            # env + bootstrap de Firebase
├── routes/             # GoRouter
├── core/               # database (Drift), network (Dio), l10n, theme, logging, location
├── features/
│   ├── auth/           # Google, email, biometría, JWT en secure storage
│   ├── onboarding/     # bienvenida (welcome)
│   ├── map/            # flutter_map, marcadores, Google Maps
│   ├── places/         # detalle + clima Open-Meteo
│   ├── favorites/      # Drift reactivo (Sprint 2)
│   ├── notifications/  # FCM (Sprint 2)
│   ├── publish/        # publicación de lugares (Sprint 2)
│   └── profile/        # perfil + idioma
└── shared/             # widgets y mensajes de error
```

## Estado Sprint 1

- [x] Firebase configurado con `flutterfire configure` (proyecto `vivelocal-dd59b`).
- [x] Firestore creado, reglas desplegadas (`firestore.rules`) y colección
      `lugares` con 6 sitios de Cochabamba.
- [x] SHA-1 de debug registrado en la app Android de Firebase.
- [x] Google Sign-In habilitado en Firebase (proveedor Google activo).
- [x] Onboarding de bienvenida (`/welcome`) y login obligatorio (`/login`).
- [x] Rutas protegidas con GoRouter: `/map`, `/map/place/:id` y `/profile`
      redirigen a `/welcome` sin sesión; con sesión se salta el onboarding.
- [x] Logout desde el mapa con diálogo de confirmación; regresa a `/login` y no
      permite volver al mapa.
- [x] Mapa centrado en Cochabamba (Plaza 14 de Septiembre) con OpenStreetMap y
      marcadores desde Firestore (demo local si Firebase falla).
- [x] Geolocalización: pide permiso al abrir y centra en la ubicación real si se
      concede; el botón "Mi ubicación" permite reintentar.
- [x] Creación de lugares desde el mapa (nombre + categoría + coordenadas
      actuales) persistida en la colección `lugares`.
- [x] Botón "Abrir en Google Maps" (ruta por coordenadas, con fallback web).
- [x] Clima Open-Meteo con Dio (sin API key).
- [x] CI de GitHub Actions (`flutter analyze` + `flutter test`).
- [x] i18n es/en/ar con soporte RTL.

### Sitios precargados en `lugares`

| Lugar | Categoría | Coordenadas |
|---|---|---|
| Plaza 14 de Septiembre | Plaza | -17.3938227, -66.1569255 |
| Cristo de la Concordia | Monumento | -17.3843089, -66.1349544 |
| Aeropuerto Internacional Jorge Wilstermann | Transporte | -17.4206674, -66.1767633 |
| Terminal de Buses de Cochabamba | Transporte | -17.4024571, -66.1580123 |
| Palacio Portales | Cultura | -17.3747965, -66.1530795 |
| Teleférico al Cristo (base) | Transporte | -17.3889881, -66.1421193 |

## Firebase Authentication

- Identity Platform/Auth ya está inicializado en la consola y el proveedor
  **Google** está activo.
- `android/app/google-services.json` incluye los OAuth clients y la app Android
  funciona con Google Sign-In.
- Para compilar iOS con Google Sign-In, volver a ejecutar FlutterFire para
  refrescar `GoogleService-Info.plist` con el `CLIENT_ID`:

  ```bash
  flutterfire configure -p vivelocal-dd59b --platforms=android,ios -y
  ```

- (Opcional) Probar "Abrir en Google Maps" en un dispositivo con Google Maps
  instalado para validar la app externa (sin la app usa la versión web).

SHA-1 registrado (debug):

```
31:C3:6A:78:B6:13:9E:05:0C:CB:C4:54:4D:A2:DD:78:57:AD:D0:54
```

## Clima Open-Meteo

El clima actual se obtiene de Open-Meteo (API open source y gratuita sin necesidad de API key ni registro).

## Comandos

```bash
export PATH="$PATH:$HOME/development/flutter/bin"

flutter pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --debug
```

## Tests

- URI de Google Maps y lanzamiento desde el botón.
- Redirecciones de autenticación (`resolveAuthRedirect`) y onboarding.
- Modelo de dominio `Place` y catálogo demo de Cochabamba.
- `CreatePlaceController` (éxito y error) y validación del formulario de creación.
- `AuthUser`.
- Repositorio de clima (mapeo DTO → dominio y API key ausente).
- Widgets: `WeatherPanel` (loading/error/data), `GoogleMapsButton` y
  `CreatePlaceSheet`.

## Notas

- La colección `lugares` permite lectura pública y creación desde la app (con
  validación de campos en las reglas). Actualizar/eliminar requiere autenticación
  y ser el creador del documento.
- Los archivos generados (`*.g.dart`, `app_localizations*.dart`) se regeneran con
  `build_runner` y `flutter gen-l10n`.
- Las API keys de Firebase en `firebase_options.dart` y `google-services.json` son
  identificadores públicos de cliente, no secretos.
- El JWT de Firebase se guarda solo en `flutter_secure_storage` y el interceptor de
  Dio lo envía únicamente a requests marcados con `extra['requiresAuth'] = true`.
