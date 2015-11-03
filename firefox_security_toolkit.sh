#!/bin/bash
##################################################################################
##Firefox Security Kit
###Description:
#This script automatically transform Firefox Browser to a penetration testing suite. The script mainly focuses on downloading the required addons for web-application penetration testing.
###Version:
#v0.1
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
echo -e "  _               __  __           _            _    _                        _  "
echo -e " | |__  _   _ _  |  \/  | __ _ ___(_)_ __      / \  | |__  _ __ ___   ___  __| | "
echo -e " | '_ \| | | (_) | |\/| |/ _\` |_  / | '_ \    / _ \ | '_ \| '_ \` _ \ / _ \/ _\` | "
echo -e " | |_) | |_| |_  | |  | | (_| |/ /| | | | |  / ___ \| | | | | | | | |  __/ (_| | "
echo -e " |_.__/ \__, (_) |_|  |_|\__,_/___|_|_| |_| /_/   \_\_| |_|_| |_| |_|\___|\__,_| "
echo -e "        |___/                                                                    "
echo -e "v0.1"
echo -e "\t\t\t\t\twww.mazinahmed.net"
echo -e "\t\t\t\t\ttwitter.com/mazen160"
echo -e "\t\t\t\t\tae.linkedin.com/pub/mazin-ahmed/86/795/629"
echo -e "\n\n"
}

logo

welcome() {
echo -e "\n\n"
echo -e "Usage:\n\t bash $0 run\n\n"
echo -e '[%%]Available Addons:'	
echo '#Copy as Plain Text
#Web Developer
#Tamper Data
#User Agent Switcher
#Right-Click XSS
#Foxy Proxy
#HackBar
#Wappalyzer
#PassiveRecon
#Cookie Manager+
#Cookie Export/Import
#FlagFox
#Fireforce
#CSRF-Finder
#Multi Fox
#FireBug
#Live HTTP Headers
#Crypto Fox
'
echo -e '[%%]Additions Features:'
echo -e '#Downloading Burp Suite Certificate'
echo -e '#Downloading a large user-agent list for User-Agent Swithcer'
echo -e "\n\n"
echo "[$] legal disclaimer: Usage of Firefox Security Toolkit for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program"

}

if [[ $1 != 'run' ]];then
	welcome
	exit
fi

burp_cert() {
	wget 'http://127.0.0.1:8080/cert' -o /dev/null -O "$scriptpath/cacert.der" ; if [ -s "$scriptpath/cacert.der" ] ; then echo -e "[*] Burp Suite certificate has been downloaded, and can be found at [$scriptpath/cacert.der]."; else echo "[!]Error: Firefox Security Toolkit was not able to download Burp Suite certificate, you need to do this task manually." ; fi
}
	
##Checking whether Firefox is installed.
if ! [ -f /usr/bin/firefox ]; then
echo -e "[*]Firefox does not seem to be installed.\n[*]Quitting..."
exit
fi

scriptpath=$(mktemp -d)

echo -en "[#]Click [Enter] to start. "; read -r
echo -e "[*]Created a tmp directory at [$scriptpath]."

##Inserting the "Installation is Finished page" into $scriptpath
echo '<!DOCTYPE HTML><html><center><head><h1>Installation is Finished</h1></head><body><p><h2>You can close Firefox.</h2><h3><i>Firefox Security Toolkit</i></h3></p></body></center></html>' > $scriptpath/.installation_finished.html


##Ask about whether the user would like to download Burpsuite Certificate.
echo -n "[@]Would you like to download Burp Suite Certificate? [y/n]. Note that Burp Suite should be running in your machine. "; read -r burp_cert_answer
	if [[ $burp_cert_answer == 'y' ]];then
		burp_cert
	fi
	
####Downloading packages.
echo -e "[*]Downloading Addons."

#Copy as Plain Text
wget "https://addons.mozilla.org/firefox/downloads/latest/copy-as-plain-text/addon-344925-latest.xpi" -o /dev/null -O "$scriptpath/copy_as_plain_text.xpi"

#Web Developer
wget "https://addons.mozilla.org/firefox/downloads/latest/web-developer/addon-60-latest.xpi" -o /dev/null -O "$scriptpath/web_developer.xpi"

#Tamper Data
wget "https://addons.mozilla.org/firefox/downloads/latest/tamper-data/addon-966-latest.xpi" -o /dev/null -O "$scriptpath/tamper_data.xpi"

#User Agent Switcher
wget "https://addons.mozilla.org/firefox/downloads/latest/user-agent-switcher/addon-59-latest.xpi" -o /dev/null -O "$scriptpath/user_agent_switcher.xpi"

#Right-Click XSS
wget "https://addons.mozilla.org/firefox/downloads/file/215802/rightclickxss-0.2.1-fx.xpi" -o /dev/null -O "$scriptpath/right_click_xss.xpi"

#Foxy Proxy
wget "https://addons.mozilla.org/firefox/downloads/file/319162/foxyproxy_standard-4.5.5-sm+tb+fx.xpi" -o /dev/null -O "$scriptpath/foxy_proxy.xpi"

#HackBar
wget "https://addons.mozilla.org/firefox/downloads/latest/3899/addon-3899-latest.xpi" -o /dev/null -O "$scriptpath/hackbar.xpi"

#Wappalyzer
wget "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/addon-10229-latest.xpi" -o /dev/null -O "$scriptpath/wappalyzer.xpi"

#PassiveRecon
wget "https://addons.mozilla.org/firefox/downloads/latest/6196/addon-6196-latest.xpi" -o /dev/null -O "$scriptpath/passiverecon.xpi"

#Cookie Manager+
wget "https://addons.mozilla.org/firefox/downloads/latest/92079/addon-92079-latest.xpi" -o /dev/null -O "$scriptpath/cookiemanager+.xpi"

#Cookie Export/Import
wget "https://addons.mozilla.org/firefox/downloads/latest/344927/addon-344927-latest.xpi" -o /dev/null -O "$scriptpath/cookie_export_import.xpi"

#FlagFox
wget "https://addons.mozilla.org/firefox/downloads/latest/5791/addon-5791-latest.xpi" -o /dev/null -O "$scriptpath/flagfox.xpi"

#Fireforce
wget "https://addons.mozilla.org/firefox/downloads/file/204186/fireforce-2.2-fx.xpi" -o /dev/null -O "$scriptpath/fireforce.xpi"

#CSRF-Finder
wget "https://addons.mozilla.org/firefox/downloads/file/224182/csrf_finder-1.2-fx.xpi" -o /dev/null -O "$scriptpath/csrf_finder.xpi"

#Multi Fox
wget "https://addons.mozilla.org/firefox/downloads/latest/200283/addon-200283-latest.xpi" -o /dev/null -O "$scriptpath/multifox.xpi"

#FireBug
wget "https://addons.mozilla.org/firefox/downloads/latest/1843/addon-1843-latest.xpi" -o /dev/null -O "$scriptpath/firebug.xpi"

#Live HTTP Headers
wget "https://addons.mozilla.org/firefox/downloads/file/345004/live_http_headers_fixed_by_danyialshahid-0.17.1-signed-sm+fx.xpi" -o /dev/null -O "$scriptpath/live_http_headers.xpi"

#Crypto Fox
wget "https://addons.mozilla.org/firefox/downloads/file/140447/cryptofox-2.2-fx.xpi" -o /dev/null  -O "$scriptpath/crypto_fox.xpi" 

###Ask about whether to download user-agent list for User-Agent Switcher addon
echo -n "[@]Would you like to download user-agent list for User-Agent Switcher Addon? [y/n]"; read -r useragent_list_answer
 if [[ $useragent_list_answer == 'y' ]];then
	wget 'http://techpatterns.com/downloads/firefox/useragentswitcher.xml' -o /dev/null -O "$scriptpath/useragentswitcher.xml" ; echo -e "[*]Additional User-Agnets has been downloaded for Default User-Agent Addon, you can import it manually. It can be found at: [$scriptpath/useragentswitcher.xml]."
	fi


####Messages.
echo -e "[*]Downloading addons has been finished.\n";
echo -en "[**]Click [Enter] to run Firefox to finish the task. "; read -r
echo -e "[*]Running Firefox to install the addons.\n"
##Installing The Addons. The process needs to be semi-manually due to Mozilla Firefox security policies.
#Stopping Firefox is it's running.
killall firefox &> /dev/null
#Running it again.
/usr/bin/firefox "$scriptpath/"*.xpi "$scriptpath/.installation_finished.html" &> /dev/null
####

##In case you need to delete the tmp directory, uncomment the following line.
#rm -rf $scriptpath; echo -e "[*]Deleted the tmp directory."
echo -e "[**]Firefox Security Toolkit is finished\n"
echo -e "Have a nice day! - Mazin Ahmed"
########################################################################
