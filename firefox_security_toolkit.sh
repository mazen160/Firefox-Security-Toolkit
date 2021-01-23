#!/bin/bash
################################################################################
## Firefox Security Toolkit
## Description:
# This script automatically transform Firefox Browser to a penetration testing suite.
# The script mainly focuses on downloading the required add-ons for web-application penetration testing.
## Version:
# v0.7
## Homepage:
# https://github.com/mazen160/Firefox-Security-Toolkit
## Author:
# Mazin Ahmed <mazin AT mazinahmed DOT net>
################################################################################


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
echo "v0.7"
echo "www.mazinahmed.net"
echo "twitter.com/mazen160"
}

logo

welcome() {
echo -e "\n\n"
echo -e "Usage:\n\t"
echo -e "bash $0 run"
echo -e "\n"
echo -e '[%%] Available Add-ons:'
echo '* Copy PlainText
* CSRF spotter
* Disable WebRTC
* Easy XSS
* Flagfox
* FoxyProxy Standard
* Google Dork Builder
* HackBar Quantum
* HackBar V2
* HackTools
* HTTP Header Live
* iMacros for Firefox
* JSONView
* KNOXSS Community Edition
* Resurrect Pages
* Shodan.io
* show-my-ip
* User-Agent Switcher and Manager
* Wappalyzer
* Web Developer
* XML Viewer Plus
'

echo '[%%] Additions & Features:'
echo '* Downloading Burp Suite certificate'
echo '* Downloading a large user-agent list for User-Agent Switcher'
echo -e "\n\n"
echo "[$] Legal Disclaimer: Usage of Firefox Security Toolkit for attacking targets without prior mutual consent is illegal. It is the end user's responsibility to obey all applicable local, state and federal laws. Developers assume no liability and are not responsible for any misuse or damage caused by this program"
}

if [[ $1 != 'run' ]];then
  welcome
  exit 0
else
  echo -en "\n\n[#] Click [Enter] to start. "; read -r
fi

if [[ -z $FIREFOXPATH ]]; then
  if [[ ! -z $(which firefox) ]]; then
    FIREFOXPATH=$(which firefox)
  elif [[ "$(uname)" == "Darwin" ]];then
    FIREFOXPATH="/Applications/Firefox.app/Contents/MacOS/firefox-bin"
  else
    FIREFOXPATH='/usr/bin/firefox'
  fi
fi


# checking whether Firefox is installed.
if [[ ! -f "$FIREFOXPATH" ]]; then
  echo -e "[*] Firefox does not seem to be installed.\n[*]Quitting..."
  exit 1
fi

echo "[*] Firefox path: $FIREFOXPATH"

# creating a tmp directory.
scriptpath=$(mktemp -d)
echo -e "[*] Created a tmp directory at [$scriptpath]."

# inserting a "Installation is Finished" page into $scriptpath.
echo '<!DOCTYPE HTML><html><center><head><h1>Installation is Finished</h1></head><body><p><h2>You can close Firefox.</h2><h3><i>Firefox Security Toolkit</i></h3></p></body></center></html>' > "$scriptpath/.installation_finished.html"

# checks whether the user would like to download Burp Suite certificate.
echo -n "[@] Would you like to download Burp Suite certificate? [y/n]. (Note: Burp Suite should be running in your machine): "; read -r burp_cert_answer
  burp_cert_answer=$(echo -n "$burp_cert_answer" | tr '[:upper:]' '[:lower:]')
  if [[ ( $burp_cert_answer == 'y' ) || ( $burp_cert_answer == 'yes' ) ]];then
    echo -n "[@] Enter Burp Suite proxy listener's port (Default: 8080): "; read -r burp_port
    if [[ $burp_port == '' ]]; then
      burp_port='8080'
    fi
    wget "http://127.0.0.1:$burp_port/cert" -o /dev/null -O "$scriptpath/cacert.der"
    if [ -s "$scriptpath/cacert.der" ];then
      echo -e "[*] Burp Suite certificate has been downloaded, and can be found at [$scriptpath/cacert.der]."
    else
      echo "[!]Error: Firefox Security Toolkit was not able to download Burp Suite certificate, you need to do this task manually."
    fi
  fi

# downloading packages.
echo -e "[*] Downloading Add-ons."

# Copy PlainText
wget "https://addons.mozilla.org/firefox/downloads/file/3420581/copy_plaintext-1.10-fx.xpi" -o /dev/null -O "$scriptpath/copy_plaintext-1.10-fx.xpi"

# CSRF spotter
wget "https://addons.mozilla.org/firefox/downloads/file/2209785/csrf_spotter-1.0-fx.xpi" -o /dev/null -O "$scriptpath/csrf_spotter-1.0-fx.xpi"

# Easy XSS
wget "https://addons.mozilla.org/firefox/downloads/file/1158849/easy_xss-1.0-fx.xpi" -o /dev/null -O "$scriptpath/easy_xss-1.0-fx.xpi"

# Flagfox
wget "https://addons.mozilla.org/firefox/downloads/file/3538268/flagfox-6.1.25-fx.xpi" -o /dev/null -O "$scriptpath/flagfox-6.1.25-fx.xpi"

# FoxyProxy Standard
wget "https://addons.mozilla.org/firefox/downloads/file/3476518/foxyproxy_standard-7.4.3-an+fx.xpi" -o /dev/null -O "$scriptpath/foxyproxy_standard-7.4.3-an+fx.xpi"

# Google Dork Builder
wget "https://addons.mozilla.org/firefox/downloads/file/3453468/google_dork_builder-0.6-fx.xpi" -o /dev/null -O "$scriptpath/google_dork_builder-0.6-fx.xpi"

# HackBar V2
wget "https://addons.mozilla.org/firefox/downloads/file/3450934/hackbar_v2-2.4.1-fx.xpi" -o /dev/null -O "$scriptpath/hackbar_v2-2.4.1-fx.xpi"

# HackBar Quantum
wget "https://addons.mozilla.org/firefox/downloads/file/934299/hackbar_quantum-1.6-an+fx.xpi" -o /dev/null -O "$scriptpath/hackbar_quantum-1.6-an+fx.xpi"

# Disable WebRTC
wget "https://addons.mozilla.org/firefox/downloads/file/3048824/disable_webrtc-1.0.21-an+fx.xpi" -o /dev/null -O "$scriptpath/disable_webrtc-1.0.21-an+fx.xpi"

# HTTP Header Live
wget "https://addons.mozilla.org/firefox/downloads/file/3384326/http_header_live-0.6.5.2-fx.xpi" -o /dev/null -O "$scriptpath/http_header_live-0.6.5.2-fx.xpi"

# iMacros for Firefox
wget "https://addons.mozilla.org/firefox/downloads/file/1010019/imacros_for_firefox-10.0.2.1450-an+fx-linux.xpi" -o /dev/null -O "$scriptpath/imacros_for_firefox-10.0.2.1450-an+fx-linux.xpi"

# JSONView
wget "https://addons.mozilla.org/firefox/downloads/file/1713269/jsonview-2.1.0-fx.xpi" -o /dev/null -O "$scriptpath/jsonview-2.1.0-fx.xpi"

# KNOXSS Community Edition
wget "https://addons.mozilla.org/firefox/downloads/file/3378216/knoxss_community_edition-0.2.0-fx.xpi" -o /dev/null -O "$scriptpath/knoxss_community_edition-0.2.0-fx.xpi"

# Resurrect Pages
wget "https://addons.mozilla.org/firefox/downloads/file/926958/resurrect_pages-7-an+fx.xpi" -o /dev/null -O "$scriptpath/resurrect_pages-7-an+fx.xpi"

# Shodan.io
wget "https://addons.mozilla.org/firefox/downloads/file/788781/shodanio-0.3.2-an+fx.xpi" -o /dev/null -O "$scriptpath/shodanio-0.3.2-an+fx.xpi"

# show-my-ip
wget "https://addons.mozilla.org/firefox/downloads/file/3458407/show_my_ip-1.5-fx.xpi" -o /dev/null -O "$scriptpath/show_my_ip-1.5-fx.xpi"

# User-Agent Switcher and Manager
wget "https://addons.mozilla.org/firefox/downloads/file/3527040/user_agent_switcher_and_manager-0.3.5-an+fx.xpi" -o /dev/null -O "$scriptpath/user_agent_switcher_and_manager-0.3.5-an+fx.xpi"

# Wappalyzer
wget "https://addons.mozilla.org/firefox/downloads/file/3539068/wappalyzer-5.9.30-fx.xpi" -o /dev/null -O "$scriptpath/wappalyzer-5.9.30-fx.xpi"

# Web Developer
wget "https://addons.mozilla.org/firefox/downloads/file/3484096/web_developer-2.0.5-an+fx.xpi" -o /dev/null -O "$scriptpath/web_developer-2.0.5-an+fx.xpi"

# XML Viewer Plus
wget "https://addons.mozilla.org/firefox/downloads/file/3032172/xml_viewer_plus-1.2.6-an+fx.xpi" -o /dev/null -O "$scriptpath/xml_viewer_plus-1.2.6-an+fx.xpi"

# HackTools
wget "https://addons.mozilla.org/firefox/downloads/file/3707062/hacktools-0.3.2-fx.xpi" -o /dev/null -O "$scriptpath/hacktools-0.3.2-fx.xpi"


# checks whether to download user-agent list for User-Agent Switcher add-on.
echo -n "[@] Would you like to download user-agent list for User-Agent Switcher add-on? [y/n]: "; read -r useragent_list_answer
  useragent_list_answer=$(echo -n "$useragent_list_answer" | tr '[:upper:]' '[:lower:]')
  if [[ ( $useragent_list_answer == 'y' ) || ( $useragent_list_answer == 'yes' ) ]]; then
    wget 'https://techpatterns.com/downloads/firefox/useragentswitcher.xml' -o /dev/null -O "$scriptpath/useragentswitcher.xml"
    echo -e "[*]Additional user-agents has been downloaded for \"User-Agent Switcher\" add-on, you can import it manually. It can be found at: [$scriptpath/useragentswitcher.xml]."
  fi

# messages.
echo -e "[*] Downloading add-ons completed.\n";
echo -en "[@@] Click [Enter] to run Firefox to perform the task. (Note: Firefox will be restarted) "; read -r
echo -e "[*] Running Firefox to install the add-ons.\n"
echo -e "Click confirm on the prompt, and close Firefox, until all addons are installed"
# installing the add-ons.
# the process needs to be semi-manually due to Mozilla Firefox security policies.

# stopping Firefox if it's running.
killall firefox &> /dev/null
# installing
# "$FIREFOXPATH" "$scriptpath/"*.xpi "$scriptpath/.installation_finished.html" &> /dev/null
for extension in $(find $scriptpath -type f -name "*.xpi"); do
  echo "- $extension"
  "$FIREFOXPATH" --new-tab "$extension"
done
"FIREFOXPATH" "$scriptpath/.installation_finished.html"

####

# in case you need to delete the tmp directory, uncomment the following line.
#rm -rf "$scriptpath"; echo -e "[*]Deleted the tmp directory."
echo -e "[**] Firefox Security Toolkit is finished\n"
echo -e "Have a nice day! - Mazin Ahmed"

# END #
