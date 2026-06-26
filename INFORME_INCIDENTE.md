FASE 1 y 2: Identificación y Evaluación de Subsistemas
El servidor web experimentó una denegación de servicio debido a un ataque híbrido.
1. capturar paquetes con sudo tcpdump -i ens33 -n port 80, notarás que las IP cambian constantemente (Spoofing). ¿Por qué un simple bloqueo por IP ( iptables -A INPUT -s IP -j DROP) es inútil aquí?
-	Por que el ataque viene de distan ips, y bloquear uno por una es inutil y una perdida de tiempo y recursos.
2.	Contexto Histórico: Históricamente, usaríamos TCP Wrappers (/etc/hosts.allow) para controlar accesos. ¿Por qué en un ataque DDoS moderno preferimos mitigar a nivel de Kernel (Firewall/iptables) en lugar de usar TCP Wrappers?
- Por que permite descartar los paquetes maliciosos en la capa de red antes de q lleguen a las capas superiores y consuman recursos

  FASE 3 y 4: Contención y Verificación Crítica
  Se implementó el script de contención integral `defensa.sh`en la capa 4 e inspección profunda de cadenas para bloquear solicitudes concurrentes al archivo `db.sql` (Capa 7).

  FASE 5 y 6: Validación y Prevención
 1. Verificación: Revisa nuevamente nload e iostat. ¿El tráfico de salida (TX) y el uso de disco (%util) cayeron a niveles normales? Si no, regresa a la Fase 2 (Rediagnosticar)
  - -Comprobamos que los niveles disminuyeron, el comando nload nos muestra que el trafico de salida es de 8.96 kbit/s, comparado con los 42.37 kbit/s detectados en las fase de diagnostico, como también se estabilizaron las lecturas del disco.
 2.	Prevención: ¿Cómo convertirías tu script de defensa en un servicio o tarea programada (cron) que se active solo si el tráfico supera un umbral de peligro?
  - Se crearía un script que midiera los paquetes por segundo y para inspencionar el trafico  de manera continua de usura tareas programadas (crontab -e), agregando una directiva para q se ejecute cada minuto.

    Imagenes adjunatadas en el archivo pdf.
   
