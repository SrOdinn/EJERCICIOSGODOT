# Organización

Player lee el teclado y mueve el personaje. Al pulsar espacio emite interact_requested.

Main recibe esa señal y escribe Interacción recibida. También inicia RoundTimer y detiene Player al terminar la ronda.

RoundTimer espera 30 segundos y emite timeout una sola vez.

En el tutorial, el botón emite pressed y Sprite2D activa o detiene su movimiento. Su Timer emite timeout cada segundo y cambia la visibilidad del icono.

Las conexiones del botón, de Player y de RoundTimer están guardadas en las escenas. La conexión del temporizador del parpadeo está en _ready() del script del icono, como en los apuntes.

Este repositorio se ha creado para reunir los ejercicios del T2.2. No contiene el historial de las entregas anteriores. Como no había una escena del T2.1 en este repositorio, se ha preparado una base sencilla de movimiento en _process().
