# Pruebas del T2.3

Comprobaciones realizadas el 03/11/2026 en Windows con Godot 4.5.1, sin ventana gráfica. Se conserva el registro previo de T2.2 al final; sus resultados proceden del historial y no se atribuyen a esta revisión.

## Ejecución reproducible

Importar primero los recursos y ejecutar la prueba:

```text
godot --headless --path . --editor --import --quit
godot --headless --path . --script res://tests/test_main.gd
```

Resultado: 13 comprobaciones correctas, Fallos: 0, salida 0.

| Acción automática | Esperado y resultado real |
| --- | --- |
| Instanciar Main | score = 0 y Puntos: 0. |
| Inspeccionar RoundTimer | 30 segundos, one_shot activo, autostart desactivado. |
| Inspeccionar Target al iniciar | x entre 96 y 720; misma altura que Player. |
| Emitir interact_requested a 300 píxeles | No suma. |
| Emitir a 30 píxeles con radio 1 | No suma; fallo de configuración reproducido. |
| Repetir con radio 48 | Suma uno y muestra Puntos: 1. |
| Inspeccionar objetivo tras acierto | Dentro de límites y a la altura de Player. |
| Interactuar exactamente a 48 píxeles | Suma uno. |
| Interactuar a 48,1 píxeles | No suma. |
| Esperar timeout real, abreviado a 0,05 s en la prueba | playing pasa a false; se desactivan movimiento y entrada. |
| Leer etiqueta final | Fin: 2 puntos. |
| Emitir señal después del final | No cambian puntos, objetivo ni resultado. |
| Crear otra instancia de Main | Cero puntos y jugador activo. |

La prueba emite señales por código; no equivale a pulsar teclas físicamente. El tiempo abreviado solo se cambia en memoria en tests/test_main.gd. La escena entregada conserva 30 segundos. También se arrancó Main sin ventana durante dos fotogramas, sin errores de script.

## Fallo depurado: radio demasiado pequeño

Acción: colocar Player en (100, 270), Target en (130, 270), configurar interaction_radius a 1 y emitir interact_requested. Se esperaba poder puntuar a una distancia visualmente cercana. Resultado real: score permanece en 0. La señal sí llega; la distancia entre centros es 30 y la condición 30 <= 1 es falsa.

Corrección: restaurar interaction_radius a 48. Repetición con las mismas posiciones: score pasa a 1, la etiqueta cambia y Target recibe una posición dentro de los límites. No fue un fallo de conexión. Esta inspección se realizó mediante la prueba automática, sin usar puntos de ruptura ni el árbol Remoto del editor.

## Comprobación manual pendiente

Abrir project.godot en Godot 4 y pulsar F5. Comprobar WASD, espacio cerca y lejos, legibilidad del objetivo y etiqueta, esperar los 30 segundos e intentar moverse y puntuar después. Reiniciar con F8 y F5. Para el tutorial anterior, abrir tutorial/signals.tscn y pulsar F6. No se ha realizado esta prueba interactiva ni una exportación de escritorio en esta revisión.

El entorno mostró un aviso de lectura del almacén de certificados. La primera importación también encontró restricciones para guardar preferencias del editor; se activó el modo autocontenido del motor descargado. No se observaron errores de los scripts del proyecto en la ejecución final. Durante el desarrollo de la prueba se corrigió la liberación de Main mientras se emitía timeout, esperando al siguiente fotograma antes de liberarlo.

## Mecánica del ejemplo

El jugador se acerca y pulsa espacio. Main comprueba ronda activa y distancia; cambia score y responde con texto y recolocación del objetivo. Se conservan el movimiento previo y las conexiones de T2.2. El anexo de giro no se añade porque el PDF lo excluye de la entrega. No se ha encontrado una fecha límite concreta en el enunciado revisado.

---

Registro previo conservado:

# Pruebas del T2.2

Comprobaciones automáticas ejecutadas en Godot 4.7.2 el 25/10/2026, sin ventana gráfica.

| Prueba | Resultado |
| --- | --- |
| Abrir e importar el proyecto | Correcto, sin errores de scripts. |
| Ejecutar la escena del tutorial | El icono cambia de posición. |
| Emitir pressed del botón | El icono deja de moverse. |
| Esperar un segundo con el movimiento detenido | El icono sigue alternando su visibilidad. |
| Volver a emitir pressed | El movimiento se activa de nuevo. |
| Mover Player antes del final | Cambia su posición. |
| Simular espacio antes del final | Emite una interacción y Main muestra Interacción recibida. |
| Mantener espacio y generar repetición del teclado | No se repite la interacción. |
| Probar RoundTimer con 5 segundos | Detiene el movimiento y la entrada; muestra Fin de la ronda. |
| Repetir con 30 segundos | Se obtiene el mismo resultado al terminar los 30 segundos. |
| Mover o interactuar después del final | No cambia la posición ni se emiten nuevas interacciones. |
| Volver a crear Main | El jugador vuelve a responder y empieza otra ronda. |

La escena entregada tiene wait_time a 30, one_shot activado y autostart desactivado. Main inicia el temporizador en _ready().

Queda pendiente la comprobación manual con una ventana: abrir tutorial/signals.tscn y pulsar F6 para hacer clic en el botón; después pulsar F5 para probar Main con W, A, S, D y espacio. Los mensajes se ven en el panel Salida.
