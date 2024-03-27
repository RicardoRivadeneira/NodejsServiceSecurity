#!/bin/sh

echo "Limpiando reglas..."
iptables -F INPUT
iptables -F FORWARD
iptables -F OUTPUT

echo "Limpiando cadenas..."
iptables -X

echo "Reiniciando contadores de paquetes y bytes..."
iptables -Z

echo "Limpiando la tabla NAT..."
iptables -t nat -F

echo "Aplicando politica restrictiva (DROP)..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

echo "Permitiendo operaciones locales para servicios internos del sistema..."
iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT

echo "Permitiendo trafico en el puerto 3000..."
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT

echo "Limitando el numero de conexiones TCP entrantes ..."
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j DROP

echo "Limitando las peticiones de ping ..."
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 1/s --limit-burst 5 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

iptables -A OUTPUT -j ACCEPT

echo "Log y DROP para cualquier otro trafico entrante"
iptables -A INPUT -j LOG --log-prefix "DROP: "
iptables -A INPUT -j DROP
