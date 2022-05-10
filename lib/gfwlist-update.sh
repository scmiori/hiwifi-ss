#!/bin/sh

SUCCESS=0
logFile='/var/log/gfwlist-update.log'
logTime=`date "+%Y-%m-%d %H:%M:%S"`

if [ ! -f ${logFile} ]; then
    touch ${logFile}
fi

doDownload(){
    cd /etc/gw-shadowsocks/
    curl -k -s -o gfwlist2dnsmasq.sh 'https://raw.githubusercontent.com/cokebar/gfwlist2dnsmasq/master/gfwlist2dnsmasq.sh'
    if [ $? != 0 ]; then
        echo -e "[ERROR] gfwlist2dnsmasq.sh download failed." >> ${logFile}
        exit 1
    fi
}

doUpdate(){
    cd /etc/gw-shadowsocks
    if [ -f "/etc/gw-shadowsocks/gw-shadowsocks.dnslist" ]; then
        mv gw-shadowsocks.dnslist gw-shadowsocks.dnslist_bk
        rm -rf gw-shadowsocks.dnslist
    fi
    if [ -f "/etc/gw-shadowsocks/gw-shadowsocks.ipset.dnslist" ]; then
        mv gw-shadowsocks.ipset.dnslist gw-shadowsocks.ipset.dnslist_bk
        rm -rf gw-shadowsocks.ipset.dnslist
    fi
    # Todo Check if the previous list if the same as the new one
    doGenerate
}

doGenerate(){
    # Add china_ip_list from github to exsiting china.conf
    curl -k -s -o /etc/salist/china.conf 'https://raw.githubusercontent.com/17mon/china_ip_list/master/china_ip_list.txt'
	if [ $? != 0 ]; then
        echo -e "[ERROR] China ip list download failed." >> ${logFile}
        exit 1
	fi
	cat /etc/gw-shadowsocks/addr_list.conf | grep -v '^#' > /etc/gw-shadowsocks/addr_list_tmp.conf
	chmod +x /etc/gw-shadowsocks/gfwlist2dnsmasq.sh
    /etc/gw-shadowsocks/gfwlist2dnsmasq.sh -p 53535 -s gfwlist -i --extra-domain-file addr_list_tmp.conf -o gw-shadowsocks.ipset.dnslist>/dev/null 2>&1
   if [ $? != 0 ]; then
        echo -e "[ERROR] ${logTime} gw-shadowsocks.ipset.dnslist update failed." >> ${logFile}
    else
        echo -e "[INFO] ${logTime} gw-shadowsocks.ipset.dnslist update successfully." >> ${logFile}
        SUCCESS=1
    fi
    /etc/gw-shadowsocks/gfwlist2dnsmasq.sh -p 53535 -i --extra-domain-file addr_list_tmp.conf -o gw-shadowsocks.dnslist>/dev/null 2>&1
    if [ $? != 0 ]; then
        echo -e "[ERROR] ${logTime} gw-shadowsocks.dnslist update failed." >> ${logFile}
    else
        echo -e "[INFO] ${logTime} gw-shadowsocks.dnslist update successfully." >> ${logFile}
        SUCCESS=1
    fi
}

if [ -f "/etc/gw-shadowsocks/gfwlist2dnsmasq.sh" ]; then
    cd /etc/gw-shadowsocks
    mv gfwlist2dnsmasq.sh gfwlist2dnsmasq.sh_bk
    doDownload
    doUpdate
else
    doDownload
    doUpdate
fi

if [ ${SUCCESS} -eq "1" ]; then
    echo -n "success"
else
    echo -n "failed"
fi

