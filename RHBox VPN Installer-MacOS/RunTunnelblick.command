#!/bin/bash                                                                                                                                                                                                                                        


echo "===================================================="
echo "RADIO HOLLAND - RHBOX"
echo "WELCOME! VPN CONFIGURATION"
echo "==================================================="

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )                                                                                                                                                                                              
cd "${DIR}"                                                                                                                                                                                                                                        

echo                                                                                                                                                                                                                                               
echo "----------------------------------------------------"                                                                                                                                                                                        
echo "INSTALLING TUNNELBLICK APPLICATION..."                                                                                                                                                                                                       
echo "----------------------------------------------------"                                                                                                                                                                                        

hdiutil attach ./Application/Tunnelblick_3.8.0_build_5370.dmg                                                                                                                                                                                      
cp -R /Volumes/Tunnelblick/Tunnelblick.app /Applications                                                                                                                                                                                           
hdiutil detach /Volumes/Tunnelblick                                                                                                                                                                                                                

echo
echo "----------------------------------------------------"                                                                                                                                                                                        
echo "EXTRACTING ZIP FILES..."                                                                                                                                                                                                                     
echo "----------------------------------------------------"                                                                                                                                                                                        
find ./VPNCredentials/*.zip -exec sh -c 'unzip -o -d "${1%.*}" "$1"' _ {} \;                                                                                                                                                                       
echo

echo "----------------------------------------------------"                                                                                                                                                                                        
echo "LAUNCHING THE TUNNELBLICK..."                                                                                                                                                                                                                
echo "**Please confirm and provide your password**"                                                                                                                                                                              
echo "----------------------------------------------------"                                                                                                                                                                                        
osascript -e "tell application \"Tunnelblick\" to activate"                                                                                                                                                                                        

echo                                                                                                                                                                                                                                               
read -n 1 -r -s -p "Press any key to continue..."                                                                                                                                                                                                  
echo                                                                                                                                                                                                                                               

echo                                                                                                                                                                                                                                               
echo "----------------------------------------------------"                                                                                                                                                                                        
echo "IMPORTING VPN CREDENTIALS AND GRANTING PERMISSION..."                                                                                                                                                                                        
echo "**Please confirm and provide your password**"           
echo "----------------------------------------------------"                                                                                                                                                                                        

#Client                                                                                                                                                                                                                                            
for f in ./VPNCredentials/CLIENT*; do                                                                                                                                                                                                              
   [ -e "$f" ] && open -g ./VPNCredentials/CLIENT*/*.ovpn || echo ""                                                                                                                                                                               
   break                                                                                                                                                                                                                                           
done                                                                                                                                                                                                                                               

#VCLIENT                                                                                                                                                                                                                                           
for g in ./VPNCredentials/VCLIENT*; do                                                                                                                                                                                                             
   [ -e "$g" ] && open -g ./VPNCredentials/VCLIENT*/*.ovpn || echo ""                                                                                                                                                                              
   break                                                                                                                                                                                                                                           
done                                                                                                                                                                                                                                               

#RHADMIN                                                                                                                                                                                                                                           
for h in ./VPNCredentials/RHADMIN*; do                                                                                                                                                                                                             
   [ -e "$h" ] && open -g ./VPNCredentials/RHADMIN*/*.ovpn || echo ""                                                                                                                                                                              
   break                                                                                                                                                                                                                                           
done                                                                                                                                                                                                                                               

#VRH                                                                                                                                                                                                                                               
for j in ./VPNCredentials/VRH*; do                                                                                                                                                                                                                 
   [ -e "$j" ] && open -g ./VPNCredentials/VRH*/*.ovpn || echo ""                                                                                                                                                                                  
   break                                                                                                                                                                                                                                           
done

echo
read -n 1 -r -s -p "Press any key to continue..."
echo


echo
echo "----------------------------------------------------"
echo "CONNECTING..."
echo "----------------------------------------------------"

if ls ./VPNCredentials/CLIENT* 1> /dev/null 2>&1; then
 export fspec=./VPNCredentials/CLIENT*
 clientname=`basename $fspec`
 echo $clientname
 osascript ./tunnelblick-cmdline-vpn-connect/tunnelblick_connect.scpt $clientname
else
 echo ""
fi


if ls ./VPNCredentials/VCLIENT* 1> /dev/null 2>&1; then
  export fspec=./VPNCredentials/VCLIENT*
  vclientname=`basename $fspec`
  echo $vclientname
  osascript ./tunnelblick-cmdline-vpn-connect/tunnelblick_connect.scpt $vclientname
else
  echo ""
fi


if ls ./VPNCredentials/RHADMIN* 1> /dev/null 2>&1; then
   export fspec=./VPNCredentials/RHADMIN*
   rhadminname=`basename $fspec`
   echo $rhadminname
   osascript ./tunnelblick-cmdline-vpn-connect/tunnelblick_connect.scpt $rhadminname
else
  echo ""
fi


if ls ./VPNCredentials/VRH* 1> /dev/null 2>&1; then
  export fspec=./VPNCredentials/VRH*
  vrhname=`basename $fspec`
  echo $vrhname
  osascript ./tunnelblick-cmdline-vpn-connect/tunnelblick_connect.scpt $vrhname
else
  echo ""
fi

echo
echo "----------------------------------------------------"
echo "OPENING URL: http://rhbox.io"
echo "----------------------------------------------------"
open http://rhbox.io
echo
echo SETUP HAS INSTALLED SUCCESSFULLY!
echo


