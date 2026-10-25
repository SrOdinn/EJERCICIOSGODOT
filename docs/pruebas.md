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
