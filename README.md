````md
# FIGURITAS_APP ⚽

Aplicación móvil desarrollada en Flutter para gestionar y controlar una colección de figuritas de un álbum mundial no oficial.

La aplicación permite marcar figuritas obtenidas, visualizar estadísticas del progreso, desbloquear premios y sincronizar la información en la nube mediante Firebase.

---

# 📱 Características

- Álbum de 387 figuritas
- Contador automático de progreso
- Sistema de premios desbloqueables
- Estadísticas avanzadas
- Inicio de sesión con Google
- Sincronización en la nube con Firebase
- Guardado automático del progreso
- Modo oscuro y modo claro
- Diseño responsive
- Navegación moderna
- Perfil de usuario

---

# 🏆 Sistema de Premios

| Rango | Premio |
|---|---|
| 1 - 27 | Medias de fútbol |
| 28 - 54 | Camiseta |
| 55 - 90 | Balón |
| 91 - 117 | Celular |
| 118 - 153 | Premio sorpresa |
| 154 - 180 | Reloj |
| 181 - 216 | Billetera |
| 217 - 252 | Ajedrez |
| 253 - 279 | Dominó |
| 280 - 315 | Muñeco |
| 316 - 342 | Bicicleta |
| 343 - 387 | Parlante |

---

# 🚀 Tecnologías Utilizadas

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Riverpod
- Shared Preferences

---

# 📂 Estructura del Proyecto

```bash
lib/
│
├── core/
├── models/
├── providers/
├── screens/
├── services/
├── widgets/
└── main.dart
````

---

# 🔐 Autenticación

La aplicación utiliza autenticación con Google mediante Firebase Authentication.

---

# ☁️ Base de Datos

Se utiliza Cloud Firestore para almacenar y sincronizar el progreso de cada usuario.

---

# 📦 Instalación

## Clonar repositorio

```bash
git clone https://github.com/TU_USUARIO/figuritas_app.git
```

---

## Entrar al proyecto

```bash
cd figuritas_app
```

---

## Instalar dependencias

```bash
flutter pub get
```

---

## Ejecutar proyecto

```bash
flutter run
```

---

# 🔥 Configuración Firebase

El proyecto requiere:

* Firebase Authentication
* Cloud Firestore
* Archivo `google-services.json`

---

# 📱 Generar APK Release

```bash
flutter build apk --release
```

APK generado en:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

---

# 📦 Generar App Bundle (.aab)

```bash
flutter build appbundle --release
```

Archivo generado en:

```bash
build/app/outputs/bundle/release/app-release.aab
```

---

# 🌙 Funcionalidades

* Cambio de tema oscuro/claro
* Responsive móvil
* Paginación de figuritas
* Estadísticas dinámicas
* Progreso por usuario
* Sincronización online

---

# ⚠️ Aviso

Esta aplicación NO es oficial y no está afiliada a FIFA, Panini o entidades relacionadas con el Mundial.

---

# 👨‍💻 Desarrollador

Cristian Solano

Proyecto desarrollado con Flutter y Firebase.

```
```
