# 🚀 mPos Global Inc - Flutter Technical Test

Aplicación desarrollada en **Flutter** como prueba técnica, enfocada en consumo de API, arquitectura limpia y experiencia de usuario fluida.

---

## ✨ Características

* 🔍 Búsqueda de personajes en tiempo real (con debounce)
* ♾️ Paginación infinita (infinite scroll)
* ⚡ Navegación optimizada sin bloqueos
* 🧠 Manejo de estado con **Bloc**
* 🎯 Arquitectura desacoplada y escalable
* 🎨 UI moderna con animaciones (Hero + Slivers)

---

## 🧱 Arquitectura del proyecto

El proyecto sigue una estructura basada en separación de responsabilidades:

```plaintext
lib/
├── data/
│   ├── datasources/        # Consumo de API (remote/local)
│   ├── models/             # Modelos (DTOs)
│   └── repositories/       # Implementación de repositorios
│
├── domain/
│   └── entities/           # Entidades del negocio
│
├── presentation/
│   ├── bloc/               # Gestión de estado (Bloc)
│   ├── pages/              # Pantallas principales
│   └── widgets/            # Componentes reutilizables

---

## ⚙️ Tecnologías utilizadas

* 💙 Flutter
* 🧠 flutter_bloc
* 🌐 HTTP (consumo de API REST)
* 🧭 go_router (navegación)
* 🎨 Material Design

---

## 🚀 Optimización de rendimiento

Uno de los enfoques principales fue mejorar la experiencia del usuario:

* Se evita bloquear la UI mientras se cargan datos
* Se muestra información parcial inmediatamente al navegar
* Se actualiza la vista progresivamente con datos completos
* Se reduce el tiempo percibido de carga

---


## 🧪 Cómo ejecutar el proyecto

```bash
# Clonar repositorio
git clone https://github.com/TU_USUARIO/TU_REPO.git

# Entrar al proyecto
cd TU_REPO

# Instalar dependencias
flutter pub get

# Ejecutar app
flutter run
```

---

## 🧠 Decisiones técnicas

* Uso de **Bloc** para mantener una arquitectura escalable
* Implementación de **debounce** en búsqueda para evitar múltiples llamadas
* Manejo de estados para UX fluida (loading, loaded, error)
* Uso de **Hero animations** para mejorar la transición entre pantallas

---


## 👨‍💻 Autor

Desarrollado por **Julio**
Flutter Developer 🚀

---

## ⭐ Nota final

Este proyecto no solo cumple con los requerimientos técnicos, sino que también prioriza una experiencia de usuario fluida y una arquitectura mantenible, simulando un entorno de desarrollo real.

---
