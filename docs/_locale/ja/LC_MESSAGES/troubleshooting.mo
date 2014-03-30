Þ          t      Ì              ©   ª    T  ²   Z          ¤    )  R   6          (  `  8  á     ë   {	    g
  Ê   ÿ  ò   Ê  å   ½    £     &     »  !   ¼                                       
       	              **Make sure Fabric is really the problem.** If your problem is in the behavior or output of a remote command, try recreating it without Fabric involved: **Make sure you're on the latest version.** If you're not on the most recent version, your problem may have been solved already! Upgrading is always the best first step. **Try older versions.** If you're already *on* the latest Fabric, try rolling back a few minor versions (e.g. if on 1.7, try Fabric 1.5 or 1.6) and see if the problem goes away. This will help the devs narrow down when the problem first arose in the commit log. **Try switching up your Paramiko.** Fabric relies heavily on the Paramiko library for its SSH functionality, so try applying the above two steps to your Paramiko install as well. Execute the command (both the normal version, and the 'unwrapped' version seen via ``--show=debug``) from your local workstation using ``ssh``, e.g.:: Fabric versions sometimes have different Paramiko dependencies - so to try older Paramikos you may need to downgrade Fabric as well. Run Fabric with ``--show=debug`` and look for the ``run:`` or ``sudo:`` line about the command in question. Try running that exact command, including any ``/bin/bash`` wrapper, remotely and see what happens. This may find problems related to the bash or sudo wrappers. Stuck? Having a problem? Here are the steps to try before you submit a bug report. The ``-t`` flag matches Fabric's default behavior of enabling a PTY remotely. This helps identify apps that behave poorly when run in a non-shell-spawned PTY. Troubleshooting Project-Id-Version: Fabric 1.8
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2013-12-29 17:11+0900
PO-Revision-Date: 2014-03-24 19:05+0900
Last-Translator: JOTAKI, Taisuke <tekapo@gmail.com>
Language-Team: LANGUAGE <LL@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ja
X-Generator: Poedit 1.6.4
 **ééããªãFabricãåé¡ãªã®ããç¢ºèªããã** ãããã®åé¡ããªã¢ã¼ãã³ãã³ãã®æååãåºååã«ããå ´åãFabricç¡ãã§ããã®åé¡ãçºçãããè©¦ãã¦ã¿ã¦ãã ãã: **ææ°çãä½¿ç¨ããã** ããææ°çãä½¿ãã§ã¯ãªãã®ãªããããããããããªãã®åé¡ã¯ãã§ã«è§£æ±ºæ¸ã¿ããããã¾ãã! ã¢ããã°ã¬ã¼ãã¯ãã¤ãæè¯ã§æåã®ã¹ãããã§ãã **å¤ããã¼ã¸ã§ã³ãè©¦ãã** ãã§ã«ææ°çã®Fabricã *ä½¿ç¨* ãã¦ããã®ãªããå°ãåã®ãã¤ãã¼ãã¼ã¸ã§ã³(ä¾ãã°ã1.7ãä½¿ã£ã¦ããã®ãªã1.5ã1.6)ãè©¦ãã¦ããã®åé¡ãçºçãããã©ããè©¦ãã¦ã¿ã¦ãã ãããããã«ããããã®åé¡ãã³ãããã­ã°ã«æåã«ç¾ããææãéçºèãçµãè¾¼ãã®ã«å½¹ç«ã¡ã¾ãã **Paramiko ã®åãæ¿ããè©¦ãã** Fabricã¯SSHã®æ©è½ã§Paramikoã«å¤§ããä¾å­ãã¦ããã®ã§ãä¸ã®2ã¤ã®ã¹ãããã«Paramikoã®ã¤ã³ã¹ãã¼ã«ãè©¦ãã¦ã¿ã¦ãã ããã ã­ã¼ã«ã«ã®ã¯ã¼ã¯ã¹ãã¼ã·ã§ã³ããsshãä½¿ã£ã¦ãã®ã³ãã³ã(éå¸¸ãã¼ã¸ã§ã³ã¨ ``--show=debug`` ã§åç§ã§ãã 'ã©ããã¼ããã¦ããªã' ãã¼ã¸ã§ã³ã®ä¸¡æ¹)ãå®è¡ãã¦ãã ãããä¾ãã°:: Fabricã¯ãã¼ã¸ã§ã³ã«ãã£ã¦ã¯Paramikoã¸ã®ä¾å­ãéããã¨ãããã¾ãããããã£ã¦ãFabricããã¦ã³ã°ã¬ã¼ãããå ´åãå¤ããã¼ã¸ã§ã³ã®Paramikoãå¿è¦ã«ãªãããããã¾ããã Fabricã ``--show=debug`` ä»ãã§å®è¡ããåé¡ã«ãªã£ã¦ããã³ãã³ãã§ ``run:`` ãããã¯ ``sudo:`` ã®è¡ãæ¢ãã¾ãããªã¢ã¼ãã§ ``/bin/bash`` ã®ãã¹ã¦ã®ã©ããã¼ãå«ãæ­£ç¢ºãªã³ãã³ããè©¦ãã¦ãä½ãèµ·ãããç¢ºèªãã¦ãã ãããããã«ãããbashãsudoã©ããã¼ã«é¢é£ããåé¡ãã©ãããåããã¾ãã è¡ãè©°ã¾ã£ã¦ãã¾ãã¾ããã? åé¡ãããã¾ãã? ãã°ãå ±åããåã«è©¦ãã¦ãããããã¹ããããæãã¾ãã ``-t`` ãã©ã°ã¯ããªã¢ã¼ãã§PTYãæå¹ã«ããFabricã®ããã©ã«ãã®æåã¨åãåä½ããã¾ããéã·ã§ã«çæã®PTYã§ã®åä½æã«ä¸å®å¨ã«ä½åãã¦ããã¢ããªã±ã¼ã·ã§ã³ãç¹å®ããã®ã«å½¹ç«ã¡ã¾ãã ãã©ãã«ã·ã¥ã¼ãã£ã³ã° 