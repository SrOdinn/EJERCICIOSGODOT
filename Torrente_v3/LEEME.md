# Torrente: La Última Ronda

Abre `project.godot` con Godot 4 y pulsa F6 en main.tscn o F5 para jugar.
Comprobado con Godot 4.7.2.

## Cómo jugar

- WASD o flechas para moverse. R o el botón final para reiniciar.
- Cada partida dura 60 segundos.
- Hay una sola cerveza. Se recoge automáticamente al acercarse y reaparece en otro punto aleatorio.
- Cada cerveza suma un punto y 2 segundos de turbo. El tiempo se acumula; la velocidad siempre es como máximo ×2.
- La jarra es un 75 % más grande que antes y tiene fondo oscuro, aro y flecha turquesa.

## Organización

- `scripts/main.gd`: partida, puntuación, aparición de la jarra y pantalla.
- `scripts/player.gd`: movimiento, animaciones y turbo.
- `scripts/penultima.gd`: marcador y recogida por cercanía, comprobando que no haya una pared entre ambos.
- `scripts/map.gd`: lista de posiciones válidas guardada en la escena.
- `scenes/casino.tscn`: imagen del casino, colisiones y 907 posiciones posibles para la jarra.
- `assets/colisiones.png`: máscara proporcionada como referencia para esas colisiones.

Se han quitado los otros tres escenarios, sus imágenes, los diseños anteriores,
la selección aleatoria de mapas, la recogida con Espacio, las doce jarras,
el dibujo de muebles añadidos, los parches de suelo y la generación de colisiones
y recorridos durante la partida. Las colisiones ya están guardadas en la escena.
No se incluyen herramientas de construcción ni pruebas en el proyecto del juego.

## Colisiones y posiciones

Se usa la máscara suministrada, con negro sólido y blanco transitable.
Sus formas se convierten a rectángulos unidos sobre una rejilla de 2 píxeles,
redondeando hacia el obstáculo. No se han vuelto a interpretar los muebles
de la imagen artística. Por tanto, se conservan las simplificaciones y los pasos
abiertos que pediste, aunque algún dibujo del escenario ocupe ese espacio.
La entrada inferior tiene un límite exterior para no salir de la pantalla.

Las 907 posiciones de aparición pertenecen al recorrido conectado con la entrada.
Se ha dejado margen para los pies del personaje y para mostrar la jarra.
La nueva posición está al menos a 160 píxeles del jugador.
Los pequeños huecos aislados de la máscara no se usan para colocar cervezas.

Puedes editar las colisiones desde Casino > Walls en la escena.
Cambiar el PNG de la máscara no modifica automáticamente las colisiones ni los
puntos de aparición: si cambias el recorrido, también hay que revisar estos datos.

Las colisiones estan hechas con chatGPT y yo las he editado para mejorar la jugabilidad.

## Comprobaciones realizadas

Importación y ejecución en Godot, 907 posiciones sin colisión para los pies,
100 recogidas consecutivas sin pulsar teclas, una única jarra reutilizada,
turbo acumulable de 2 segundos, vuelta a velocidad normal, final de partida,
reinicio y desplazamiento contra la fuente con turbo sin atravesarla.
También se ha revisado una captura de la partida.

Mapa actualizado: decoración familiar, pasos laterales despejados y entrada marcada con dos paredes. Las colisiones y los puntos de aparición se han recalculado con la máscara nueva.
