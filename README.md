# hiwifi-ss 改良版 V1.1.1

本人软件小白，所有功能基于原作者开发基础上完成，所以如果对于稳定性有任何疑问，请参考原作者: [qiwihui/hiwifi-ss]

极路由+shadowsocks配置, 适应新版极路由，支持的极路由版本理论上和源程序一致

## 重要提醒

此脚本需要root权限，目前可以通过某神秘网站解锁，具体步骤自行百度
使用前最好先刷不死uboot并备份EEPROM和固件（请自行百度），因为极路由系统内存很小，所以如果出现not enough room 报错请不要慌，可以尝试刷一个原版固件再重新运行一键脚本

## 主要更新

1. 原项目使用大陆白名单模式(基于CHINAIP)和全局模式，本版本增加黑名单模式（使用自定义列表+GFWList）
2. 改进SS连接成功的判断方式,更加稳定可靠
3. GFWList更新按钮的同时更新CHINAIP白名单
4. 增加了插件更新按钮和新版本检测 （感谢PengDavin大大的脚本）

### 安装方法

1. 因为 raw.githubusercontent.com域名已经被dns污染，所以建议修改极路由的hosts解决：

    ```bash
   sudo vi /etc/hosts
    ```
   
   编辑 hosts 文件，新增下列一行内容

    ```bash
   199.232.68.133 raw.githubusercontent.com
    ```

   保存即可

2. 使用项目根目录下的 `shadow.sh` 脚本进行安装, 建议使用以下一键命令:

    ```bash
    cd /tmp && curl -k -o shadow.sh https://raw.githubusercontent.com/scmiori/hiwifi-ss/master/shadow.sh && sh shadow.sh && rm shadow.sh
    ```

3. 重启路由器



