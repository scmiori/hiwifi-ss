# hiwifi-ss 改良版

本人软件小白，所有功能基于原作者开发基础上完成，所以如果对于稳定性有任何疑问，请直接回到原作者处: [qiwihui/hiwifi-ss]

极路由+shadow配置, 适应新版极路由，支持的极路由版本理论上和源程序一致

## 主要更新

1. 现在项目使用的是大陆白名单模式(Config)， 现在改为大陆白名单模式(Config)+黑名单(Bklist)
2. 改进连接成功的判断方式
3. 更新gwflist按钮的同时更新Chinalist白名单及黑名单

### 安装方法

1. 因为 raw.githubusercontent.com域名已经被dns污染，所以建议修改hosts解决：
sudo vi /etc/hosts
编辑 hosts 文件，新增下列一行内容

199.232.68.133 raw.githubusercontent.com

保存即可

2. 使用项目根目录下的 `shadow.sh` 脚本进行安装, 建议使用以下一键命令:

    ```bash
    cd /tmp && curl -k -o shadow.sh https://raw.githubusercontent.com/scmiori/hiwifi-ss/master/shadow.sh && sh shadow.sh && rm shadow.sh
    ```

3. 重启路由器



