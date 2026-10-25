# Ejercicios Godot T2.2

Ejercicios de señales y temporizadores hechos con Godot 4.
Para abrirlo, importar el archivo project.godot desde Godot.
Pulsar F5 para ejecutar Main: W, A, S y D mueven al personaje.
Espacio envía una interacción y aparece Interacción recibida en Salida.
A los 30 segundos termina la ronda y el jugador deja de responder.
Detener con F8 y volver a pulsar F5 para empezar otra ronda.

## Tutorial del botón y el temporizador

Abrir tutorial/signals.tscn y pulsar F6.
El botón activa o detiene el movimiento del icono.
El icono aparece y desaparece cada segundo, incluso con el movimiento detenido.

## Archivos

- main.tscn y main.gd: escena principal y final de la ronda.
- player/: escena reutilizable y movimiento del jugador.
- tutorial/: ejemplo del icono, botón y parpadeo.
- assets/: imágenes usadas en las escenas.
- docs/pruebas.md: resultados de las pruebas y comprobación manual pendiente.
- docs/organizacion.md: función de cada nodo y script.
- CREDITS.md: origen de los ejemplos y del icono.

Repositorio nuevo para estos ejercicios. No incluye los commits de las prácticas anteriores de la asignatura.
