#!/bin/bash

echo "===================================================="
echo "RADIO HOLLAND - RHBOX"
echo "WELCOME! VPN CONFIGURATION"
echo "==================================================="

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "${DIR}"

echo
echo "-----------------------------------------------------"
echo "INSTALLING OPENVPN..."
echo "-----------------------------------------------------"
sudo apt-get update 
sudo apt-get install -y openvpn

echo                                                                                                                                                                                                                                 
echo "------------------------------------------------------"
echo "EXTRACTING ZIP FILES AND IMPORTING VPN CREDENTIALS..."
echo "------------------------------------------------------"


if ls ./VPNCredentials/*.zip 1> /dev/null 2>&1; then
        find ./VPNCredentials/*.zip -exec sh -c 'unzip -o -d "${1%.*}" "$1"' _ {} \;
        sudo rm ./VPNCredentials/*.zip                                                                                                                                                                                               

#CLIENT                                                                                                                                                                                                                              
if ls ./VPNCredentials/CLIENT*  1> /dev/null 2>&1; then
        cd VPNCredentials/CLIENT*                                                                                                                                                                                                    

    if [ -f *.ovpn ]
    then
            for file in *.ovpn; do
            sudo mv "$file" "$(basename "$file" .ovpn).conf"
        done
    else
        echo
    fi      
	cd ../..	
	
else                                                                                                                                                                                                                                 
        echo
fi                                                                                                                                                                                                                                   


#VCLIENT                                                                                                                                                                                                                             
if ls ./VPNCredentials/VCLIENT*  1> /dev/null 2>&1; then
        cd VPNCredentials/VCLIENT*

    if [ -f *.ovpn ]                                                                                                                                                                                                                 
    then                                                                                                                                                                                                                             
            for file in *.ovpn; do
            sudo mv "$file" "$(basename "$file" .ovpn).conf"
        done                                                                                                                                                                                                                         
    else
        echo                                                                                                                                                                                                                         
        fi                                                                                                                                                                                                                           
	cd ../..
	
else
        echo

fi


#VESSEL
if ls ./VPNCredentials/VESSEL*  1> /dev/null 2>&1; then
        cd VPNCredentials/VESSEL*

    if [ -f *.ovpn ]
    then
            for file in *.ovpn; do
            sudo mv "$file" "$(basename "$file" .ovpn).conf"
        done
    else
        echo
        fi
	cd ../..
	
else
        echo
fi  


#RHADMIN
if ls ./VPNCredentials/RHADMIN*  1> /dev/null 2>&1; then
        cd VPNCredentials/RHADMIN*

    if [ -f *.ovpn ]
    then
            for file in *.ovpn; do
            sudo mv "$file" "$(basename "$file" .ovpn).conf"
        done
    else
        echo
        fi
	cd ../..
	
else
        echo 
fi


#VRH
if ls ./VPNCredentials/VRH*  1> /dev/null 2>&1; then
        cd VPNCredentials/VRH*

    if [ -f *.ovpn ]
    then
            for file in *.ovpn; do
            sudo mv "$file" "$(basename "$file" .ovpn).conf"
        done
    else
        echo
        fi
	cd ../..

else
        echo 
fi



        #VESSEL
        for f in ./VPNCredentials/VESSEL*; do
                [ -e "$f" ] && sudo cp -R ./VPNCredentials/VESSEL*/* /etc/openvpn || echo 
                break
        done


        #CLIENT
        for g in ./VPNCredentials/CLIENT*; do
                [ -e "$g" ] && sudo cp -R ./VPNCredentials/CLIENT*/* /etc/openvpn || echo 
                break
        done

        #VCLIENT
        for h in ./VPNCredentials/VCLIENT*; do
                [ -e "$h" ] && sudo cp -R ./VPNCredentials/VCLIENT*/* /etc/openvpn || echo 
                break
        done

        #RHADMIN
        for k in ./VPNCredentials/RHADMIN*; do
                [ -e "$k" ] && sudo cp -R ./VPNCredentials/RHADMIN*/* /etc/openvpn || echo 
                break
        done
 
        #VRH
        for l in ./VPNCredentials/VRH*; do
        [ -e "$l" ] && sudo cp -R ./VPNCredentials/VRH*/* /etc/openvpn || echo 
                break
        done

                echo
                while true; do
                        read -p "Do you want to reboot your computer [y|n]?" yn
                        case $yn in
                        [Yy]* ) sudo reboot; break;;
                        [Nn]* ) exit;;
                * ) echo "Please answer [y]yes or [n]no.";;
                 esac
        done
        echo
        echo SETUP HAS INSTALLED SUCCESSFULLY!
        echo


else
        echo "No zip files exist"
        echo
fi