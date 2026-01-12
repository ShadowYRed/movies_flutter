# Movies Flutter App

Aplicación móvil desarrollada en Flutter que muestra un listado de películas consumidas desde una API pública.
Incluye scroll infinito, búsqueda, vista de detalle, animaciones y gestión de estado.
Dentro de la carpeta APK podran encontrar la APK para instalarla en un dispositivo Android.

## Requisitos

- Flutter SDK 3.x o superior
- Dart 3.x
- Android SDK
- Dispositivo físico Android o emulador

Versiones usadas en el desarrollo:

- Flutter: estable
- Node.js: 21.7.1
- npm: 10.5.0

## Instalación

Clonar el repositorio:

git clone <url-del-repositorio>
cd movies_flutter

Instalar dependencias:

flutter pub get

## Ejecución

Conectar un dispositivo físico Android o iniciar un emulador.

Ejecutar la aplicación:

flutter run

## Funcionalidades

- Listado de películas desde una API pública
- Scroll infinito (carga progresiva de 5 elementos)
- Búsqueda por coincidencia en todos los campos
- Tarjetas con animación 3D
- Vista de detalle con información completa
- Navegación entre pantallas
- Gestión de estado usando Provider
- Diseño en modo oscuro

## Estructura del proyecto

lib/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
└── main.dart

## Generación de APK

Para generar el APK en modo release:

flutter build apk --release

El archivo generado quedará en:

build/app/outputs/flutter-apk/app-release.apk
