#!/bin/bash
##################################################################################
##Firefox Security Kit
###Description:
#This script automatically transform Firefox Browser to a penetration testing suite. The script mainly focuses on downloading the required addons for web-application penetration testing.
###Version:
#v0.2
###Author:
#Mazin Ahmed <mazin AT mazinahmed DOT net>
###################################################################################
logo() { 
echo '    ______ _              ____                _____                           _  __            ______               __ __ __  _  __ '
echo '   / ____/(_)_____ ___   / __/____   _  __   / ___/ ___   _____ __  __ _____ (_)/ /_ __  __   /_  __/____   ____   / // //_/ (_)/ /_'
echo '  / /_   / // ___// _ \ / /_ / __ \ | |/_/   \__ \ / _ \ / ___// / / // ___// // __// / / /    / /  / __ \ / __ \ / // ,<   / // __/'
echo ' / __/  / // /   /  __// __// /_/ /_>  <    ___/ //  __// /__ / /_/ // /   / // /_ / /_/ /    / /  / /_/ // /_/ // // /| | / // /_  '
echo '/_/    /_//_/    \___//_/   \____//_/|_|   /____/ \___/ \___/ \__,_//_/   /_/ \__/ \__, /    /_/   \____/ \____//_//_/ |_|/_/ \__/  '
echo '                                                                                  /____/                                            '
echo "  _               __  __           _            _    _                        _  "
echo " | |__  _   _ _  |  \/  | __ _ ___(_)_ __      / \  | |__  _ __ ___   ___  __| | "
echo " | '_ \| | | (_) | |\/| |/ _\` |_  / | '_ \    / _ \ | '_ \| '_ \` _ \ / _ \/ _\` | "
echo " | |_) | |_| |_  | |  | | (_| |/ /| | | | |  / ___ \| | | | | | | | |  __/ (_| | "
echo " |_.__/ \__, (_) |_|  |_|\__,_/___|_|_| |_| /_/   \_\_| |_|_| |_| |_|\___|\__,_| "
echo "        |___/                                                                    "
echo "v0.1"
echo "\t\t\t\t\twww.mazinahmed.net"
echo "\t\t\t\t\ttwitter.com/mazen160"
echo "\t\t\t\t\tae.linkedin.com/pub/mazin-ahmed/86/795/629"
echo "\n\n"
}

logo

welcome() {
echo "\n\n"
echo "Usage:\n\t bash $0 run\n\n"
echo '[%%] Available Addons:'	
echo '# Cookie Export/Import
# Cookie Manager 
# Copy as Plain Text
# Crypto Fox
# CSRF-Finder
# FireBug
# Fireforce
# FlagFox
# Foxy Proxy
# HackBar
# Live HTTP Headers
# Multi Fox
# PassiveRecon
# Right-Click XSS
# Tamper Data
# User Agent Switcher
# Wappalyzer
# Web Developer
'
echo '[%%] Additions Features:'
echo '# Downloading Burp Suite Certificate'
echo '# Downloading a large user-agent list for User-Agent Swithcer'
echo "\n\n"
echo "[$] legal disclaimer: Usage of Firefox Security Toolkit for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program"

}

if [[ $1 != 'run' ]];then
	welcome
	exit
fi

burp_cert() {
	echo "[@] Please Enter Your Burp Suite Port (Leave Empty For Default Port 8080): \c"; read -r burp_port
	if [[ $burp_port == "" ]]; then
		burp_port="8080"
	fi;
	wget "http://127.0.0.1:$burp_port/cert" -q -O "$scriptpath/cacert.der" ; if [ -s "$scriptpath/cacert.der" ] ; then echo "[*] Burp Suite certificate has been downloaded, and can be found at [$scriptpath/cacert.der]."; else echo "[!]Error: Firefox Security Toolkit was not able to download Burp Suite certificate, you need to do this task manually." ; fi
}

addonDownUrl() {
	curl -s $1 | grep -Eo '(http|https)://.*\.xpi'
}
	
##Checking whether Firefox is installed.
if ! [ -f /usr/bin/firefox ] && ! [ -d /Applications/Firefox.app ]; then
echo "[*] Firefox does not seem to be installed.\n[*]Quitting..."
exit
fi


echo "[#] Press [Enter] to start. \c"; read -r

##Creating a tmp directory.
scriptpath=$(mktemp -d)
echo "[*] Created a tmp directory at [$scriptpath]."

##Inserting the "Installation is Finished page" into $scriptpath
echo '<!DOCTYPE HTML><html><center><head><h1>Installation is Finished</h1></head><body><p><h2>You can close Firefox.</h2><h3><i>Firefox Security Toolkit</i></h3></p></body></center></html>' > "$scriptpath/.installation_finished.html"


##Ask about whether the user would like to download Burpsuite Certificate.
echo "[@] Would you like to download Burp Suite Certificate? (Note: Burp Suite should be running in your machine) [y/n] \c"; read -r burp_cert_answer
	if [[ $burp_cert_answer == 'y' ]];then
		burp_cert
	fi
	
####Downloading packages.
echo "[*] Downloading Addons."

#Copy as Plain Text
wget `addonDownUrl "https://addons.mozilla.org/en-GB/firefox/addon/copy-plain-text-2/"` -q -O "$scriptpath/copy_as_plain_text.xpi"

#Web Developer
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/web-developer/"` -q -O "$scriptpath/web_developer.xpi"

#Tamper Data
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/tamper-data/"` -q -O "$scriptpath/tamper_data.xpi"

#User Agent Switcher
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/user-agent-switcher/"` -q -O "$scriptpath/user_agent_switcher.xpi"

#Right-Click XSS
wget `addonDownUrl "https://addons.mozilla.org/en-us/firefox/addon/rightclickxss/"` -q -O "$scriptpath/right_click_xss.xpi"

#Foxy Proxy
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/contribute/roadblock/"` -q -O "$scriptpath/foxy_proxy.xpi"

#HackBar
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/hackbar/"` -q -O "$scriptpath/hackbar.xpi"

#Wappalyzer
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/wappalyzer/"` -q -O "$scriptpath/wappalyzer.xpi"

#PassiveRecon
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/passiverecon/"` -q -O "$scriptpath/passiverecon.xpi"

#Cookie Manager+
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/cookies-manager-plus/"` -q -O "$scriptpath/cookiemanager+.xpi"

#Cookie Export/Import
wget `addonDownUrl "https://addons.mozilla.org/en-us/firefox/addon/cookies-exportimport/"` -q -O "$scriptpath/cookie_export_import.xpi"

#FlagFox
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/flagfox/"` -q -O "$scriptpath/flagfox.xpi"

#Fireforce
wget `addonDownUrl "https://addons.mozilla.org/en-us/firefox/addon/fireforce/"` -q -O "$scriptpath/fireforce.xpi"

#CSRF-Finder
wget `addonDownUrl "https://addons.mozilla.org/en-Us/firefox/addon/csrf-finder/"` -q -O "$scriptpath/csrf_finder.xpi"

#Multi Fox
wget `addonDownUrl "https://addons.mozilla.org/en-us/firefox/addon/multifox/"` -q -O "$scriptpath/multifox.xpi"

#FireBug
wget `addonDownUrl "https://addons.mozilla.org/en-us/firefox/addon/firebug/"` -q -O "$scriptpath/firebug.xpi"

#Live HTTP Headers
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/live-http-headers/"` -q -O "$scriptpath/live_http_headers.xpi"

#Crypto Fox
wget `addonDownUrl "https://addons.mozilla.org/en-US/firefox/addon/cryptofox/"` -q -O "$scriptpath/crypto_fox.xpi" 

###Ask about whether to download user-agent list for User-Agent Switcher addon
echo "[@]Would you like to download user-agent list for User-Agent Switcher Addon? [y/n] \c"; read -r useragent_list_answer
if [[ $useragent_list_answer == 'y' ]];then
	wget 'http://techpatterns.com/downloads/firefox/useragentswitcher.xml' -q -O "$scriptpath/useragentswitcher.xml" ; echo -e "[*]Additional User-Agnets has been downloaded for Default User-Agent Addon, you can import it manually. It can be found at: [$scriptpath/useragentswitcher.xml]."
fi


####Messages.
echo "[*] Downloading addons has been finished.\n"
echo "[**] Press [Enter] to install the addons. (WARNING: this will exit firefox immediatly, so make sure you backup your info before proceeding) \c"; read -r
echo "[*] Running Firefox to install the addons.\n"
##Installing The Addons. The process needs to be semi-manually due to Mozilla Firefox security policies.
#Stopping Firefox is it's running.
killall firefox &> /dev/null
#Running it again.
if [ -f /usr/bin/firefox ]; then
	/usr/bin/firefox "$scriptpath/"*.xpi "$scriptpath/.installation_finished.html" &> /dev/null
elif [ -d /Applications/Firefox.app ]; then
	/Applications/Firefox.app/Contents/MacOS/firefox-bin "$scriptpath/"*.xpi "$scriptpath/.installation_finished.html" &> /dev/null
fi
####

##In case you need to delete the tmp directory, uncomment the following line.
#rm -rf "$scriptpath"; echo  "[*]Deleted the tmp directory."
echo "[**] Firefox Security Toolkit is finished\n"
echo "Have a nice day! - Mazin Ahmed"
########################################################################
