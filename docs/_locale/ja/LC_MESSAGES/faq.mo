Þ    2      ¬  C   <      H  ¦   I  ´   ð  	  ¥  u  ¯  /  %  +  U	  ¸   
  Ï   :      
  ;   +  $   g  4     n   Á  G   0  b  x  É   Û    ¥  ]   ¼         3     9  ?   P  [     $  ì  Û     ¡   í  ~          +   (  Â   T  º     ±  Ò  2     A  ·  M   ù  °   G  F  ø     ?  Y   Ã  ó     ê     ¥   ü  a   ¢   P  !  	  U"  L   _#  4   ¬#  V   á#  K   8$  Ä  $  è   I&  Ä   2'  _  ÷'  ý  W)  V  U+  b  ¬,  ¹   .  J  É.     0  R   -0  (   0  H   ©0  a   ò0  W   T1  °  ¬1  ä   ]3  a  B4  q   ¤5  &   6  X  =6     7  6   ¶7  }   í7  =  k8  ·   ©9  Ä   a:     &;  .   Å;  @   ô;  ý   5<  í   3=  ð  !>  @   @  Y  S@  ]   ­A  û   B  r  C     zD  t   E  C  vE  ý   ºF  ¡   ¸G  j   ZH  ®  ÅH    tJ  m   K  I   ÷K  e   AL  P   §L            +   /   "                         '   )      #         !         %   
              	          0   2       *                       .                          ,   &      $                 -          1                (              A relatively safe baseline is to call ``/bin/sh``, which may call the original ``sh`` binary, or (on some systems) ``csh``, and give it the ``-c`` argument, like so:: A simple workaround is to make use of shell logic operations such as ``&&``, which link multiple expressions together (provided the left hand side executed without error) like so:: Because Fabric also doesn't bother asking the remote end for a tty by default (as it's not usually necessary) programs fired within your startup files, which expect a tty to be present, will complain -- and thus, stderr output about "stdin is not a tty" or similar. Because Fabric executes a shell on the remote end for each invocation of ``run`` or ``sudo`` (:ref:`see also <one-shell-per-command>`), backgrounding a process via the shell will not work as expected. Backgrounded processes may still prevent the calling shell from exiting until they stop running, and this in turn prevents Fabric from continuing on with its own execution. Currently, no, it's not -- the present version of Fabric relies heavily on shared state in order to keep the codebase simple. However, there are definite plans to update its internals so that Fabric may be either threaded or otherwise parallelized so your tasks can run on multiple servers concurrently. Due to a bug of sorts in our SSH layer, it's not currently possible for Fabric to always accurately detect the type of authentication needed. We have to try and guess whether we're being asked for a private key passphrase or a remote server password, and in some cases our guess ends up being wrong. Fabric provides a convenient shortcut for this specific use case, in fact: `~fabric.context_managers.cd`. There is also `~fabric.context_managers.prefix` for arbitrary prefix commands. Find and remove or comment out the offending program call. If the program was not added by you on purpose and is simply a legacy of the operating system, this may be safe to do, and is the simplest approach. Frequently Asked Questions (FAQ) How can I run something after my task is done on all hosts? How do I dynamically set host lists? How do I use ``su`` to run commands as another user? However, this requires that the command in question makes no assumptions about your current working directory! I'm sometimes incorrectly asked for a passphrase instead of a password. If that were a shell script, the second `~fabric.operations.run` call would have executed with a current working directory of ``/path/to/application/`` -- but because both commands are run in their own distinct session over SSH, it actually tries to execute ``$HOME/update.sh`` instead (since your remote home directory is the default working directory). If you have no need for interactive behavior and run into this problem frequently, you may want to deactivate pty allocation globally by setting :ref:`env.always_use_pty <always-use-pty>` to ``False``. If your target system cannot use ``sudo`` for some reason, you can still use ``su``, but you need to invoke it in a non-interactive fashion by telling it to run a specific command instead of opening a shell. Typically this is the ``-c`` flag, e.g. ``su otheruser -c "command"``. In the case of running commands as a user distinct from the login user, you have two options: Init scripts don't work! Init-style start/stop/restart scripts (e.g. ``/etc/init.d/apache2 start``) sometimes don't like Fabric's allocation of a pseudo-tty, which is active by default. In almost all cases, explicitly calling the command in question with ``pty=False`` works correctly:: Is Fabric thread-safe? My (``cd``/``workon``/``export``/etc) calls don't seem to work! My remote system doesn't have ``bash`` installed by default, do I need to install ``bash``? Or leverage a process manager such as ``supervisord``, ``upstart`` or ``systemd`` - such tools let you define what it means to "run" one of your background processes, then issue init-script-like start/stop/restart/status commands. They offer many advantages over classic init scripts as well. Override ``env.shell`` to remove the ``-l`` flag. This should tell Bash not to load your startup files. If you don't depend on the contents of your startup files (such as aliases or whatnot) this may be a good solution. Pass ``pty=True`` to `run` or `sudo`, which will force allocation of a pseudo-tty on the remote end, and hopefully cause the offending program to be less cranky. Run the program under ``nohup`` or similar "in-shell" tools - note that this approach has seen limited success for most users. See :ref:`dynamic-hosts`. See :ref:`leveraging-execute-return-value`. The ``-l`` argument specifies a login shell and is not absolutely required, merely convenient in many situations. Some shells lack the option entirely and it may be safely omitted in such cases. The key to fixing this is to ensure that your process' standard pipes are all disassociated from the calling shell, which may be done in a number of ways (listed in order of robustness): The most common such situation is where you, the local user, appear to have an SSH keychain agent running, but the remote server is not able to honor your SSH key, e.g. you haven't yet transferred the public key over or are using an incorrect username. In this situation, Fabric will prompt you with "Please enter passphrase for private key", but the text you enter is actually being sent to the remote end's password authentication. There are multiple ways to deal with this problem: These are some of the most commonly encountered problems or frequently asked questions which we receive from users. They aren't intended as a substitute for reading the rest of the documentation, especially the :ref:`usage docs <usage-docs>`, so please make sure you check those out if your question is not answered here. This has been shown to work on FreeBSD and may work on other systems as well. This is a special case of :ref:`one-shell-per-command`. As that FAQ explains, commands like ``su`` which are 'stateful' do not work well in Fabric, so workarounds must be used. This message is typically generated by programs such as ``biff`` or ``mesg`` lurking within your remote user's ``.profile`` or ``.bashrc`` files (or any other such files, including system-wide ones.) Fabric's default mode of operation involves executing the Bash shell in "login mode", which causes these files to be executed. To run multiple commands in the same ``su -c`` "wrapper", you could e.g. write a wrapper function around `~fabric.operations.run`:: Unfortunately, it means that code like the following doesn't behave as you might assume:: Use ``tmux``, ``screen`` or ``dtach`` to fully detach the process from the running shell; these tools have the benefit of allowing you to reattach to the process later on if needed (though they are more ad-hoc than ``supervisord``-like tools). Use `~fabric.operations.sudo` with its ``user=`` kwarg, e.g. ``sudo("command", user="otheruser")``. If you want to factor the ``user`` part out of a bunch of commands, use `~fabric.context_managers.settings` to set ``env.sudo_user``:: Use a pre-existing daemonization technique if one exists for the program at hand -- for example, calling an init script instead of directly invoking a server binary. We hope to address this in future releases by modifying a fork of the aforementioned SSH library. While Fabric can be used for many shell-script-like tasks, there's a slightly unintuitive catch: each `~fabric.operations.run` or `~fabric.operations.sudo` call has its own distinct shell session. This is required in order for Fabric to reliably figure out, after your command has run, what its standard out/error and return codes were. While Fabric is written with ``bash`` in mind, it's not an absolute requirement.  Simply change :ref:`env.shell <shell>` to call your desired shell, and include an argument similar to ``bash``'s ``-c`` argument, which allows us to build shell commands of the form:: Why can't I run programs in the background with ``&``? It makes Fabric hang. Why do I sometimes see ``err: stdin: is not a tty``? You might also get away with an absolute path and skip directory changing altogether:: where ``/bin/bash -l -c`` is the default value of :ref:`env.shell <shell>`. Project-Id-Version: fabric docs 1_8_2
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2014-02-15 23:41+0900
PO-Revision-Date: 2014-06-27 22:24+0900
Last-Translator: JOTAKI, Taisuke <tekapo@gmail.com>
Language-Team: Japanese (http://www.transifex.com/projects/p/fabric-docs-1_8_2/language/ja/)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Language: ja
Plural-Forms: nplurals=1; plural=0;
X-Generator: Poedit 1.6.5
 æ¯è¼çå®å¨ãªæ¹æ³ã¯ããªãªã¸ãã«ã® ``sh`` ãã¤ããªã¼ã(ããã¤ãã®ã·ã¹ãã ã§ã¯) ``csh`` ãå¼ã¶  ``/bin/sh`` ãä½¿ããã¨ã§ããããã¦ ``-c`` ãªãã·ã§ã³ãä½¿ãã¾ãããã®ããã«:: ç°¡åãªã¯ã¼ã¯ã¢ã©ã¦ã³ãã¯ ``&&`` ã®ãããªå¶å¾¡æ¼ç®å­ãä½¿ããã¨ã§ããè¤æ°ã®å½ä»¤ãä¸åº¦ã«æ¸ãã¾ãã(ã¨ã©ã¼ããªããã°å·¦ããé ã«) ãã®ããã«:: Fabric ã¯ããã©ã«ãã§ã¯ãªã¢ã¼ãå´ã® tty ãæã¡ã¾ããã(éå¸¸ã¯å¿è¦ãªããã)ã¹ã¿ã¼ãã¢ãããã¡ã¤ã«ã«ãããã­ã°ã©ã ã¯ tty ããããã®ã ã¨æå¾ãã¦ããããå®è¡ãããã¨æå¥ãè¨ãã¾ã -- ãã®ããã«ãã¦ "stdin is not a tty" ã®ãããªæ¨æºã¨ã©ã¼åºåãç¾ãã¾ãã Fabric ã¯ãªã¢ã¼ãå´ã§ ``run`` ã ``sudo`` (:ref:`see also <one-shell-per-command>`) ã®å¼ã³åºãã§ããããã·ã§ã«ãèµ·åãã¾ãã``run`` or ``sudo`` (:ref:`see also <one-shell-per-command>`)ãã·ã§ã«ãéãã¦ã®ããã¯ã°ã©ã³ããã­ã»ã¹ã¯æå¾éãã«åãã¾ãããããã¯ã°ã©ã³ããã­ã»ã¹ãçµäºããã¾ã§å¼ã³åºãããã·ã§ã«ããæããããªãããããã¾ãããããã§ã¯ Fabric ãé çªã«å®è¡ãããã¨ãã§ãã¾ããã ç¾æç¹ã§ã¯ Noã-- ç¾å¨ã®ãã¼ã¸ã§ã³ã® Fabric ã¯ã³ã¼ããã¼ã¹ãã·ã³ãã«ã«ããããã«æ¿ããå±æç¶æ(shared state)ã«ä¾å­ãã¦ãã¾ãããããåæã«è¤æ°ã®ãµã¼ãã¼ã§ã¿ã¹ã¯ãå®è¡ããããã« Fabric ãã¹ã¬ããåããããã¯ä¸¦è¡å¦çããæç¢ºãªè¨ç»ãããã¾ãã SSH ã¬ã¤ã¤ã¼ã®ãã°ã®ããä»ç¾å¨ Fabric ã¯å¸¸ã«å¿è¦ãªèªè¨¼ã®ã¿ã¤ããæ­£ç¢ºã«æ¤åºã§ãã¾ããããã©ã¤ãã¼ãã­ã¼ã®ãã¹ãã¬ã¼ãºããªã¢ã¼ããµã¼ãã¼ã®ãã¹ã¯ã¼ãã®ã©ã¡ããå¿è¦ãæ¨æ¸¬ããªããã°ãªãã¾ãããããã¦ããã¤ãã®ã±ã¼ã¹ã§ã¯ãã®æ¨æ¸¬ãééã£ã¦ãã¾ãã Fabric ã«ã¯ãã®ç¹å¥ãªã±ã¼ã¹ã«ä¾¿å©ãªã·ã§ã¼ãã«ãããããã¾ã: `~fabric.context_managers.cd`. `~fabric.context_managers.prefix` ãä½¿ããã¨ãã§ãã¾ãã ä½è¨ãªãã­ã°ã©ã ã®å¼ã³åºããè¦ã¤ãã¦åé¤ãããã¯ã³ã¡ã³ãã¢ã¦ãããããã®ãã­ã°ã©ã ãããªããæå³çã«è¿½å ãããã®ã§ã¯ãªãåã«ãªãã¬ã¼ãã£ã³ã°ã·ã¹ãã ã®éºç£ã ã¨ããã¨ãã®æ¹æ³ã§ãã¾ãããã¾ããæãã·ã³ãã«ãªã¢ãã­ã¼ãã§ãã ããããè³ªå (FAQ) ãã¹ã¦ã®ãã¹ãã§ã¿ã¹ã¯ãå®è¡ããå¾ã«ä½ããå®è¡ããã«ã¯? åçãã¹ããªã¹ããä½¿ãã«ã¯? å¥ã®ã¦ã¼ã¶ã¼ã§ã³ãã³ããå®è¡ãã ``su`` ã®ä½¿ãæ¹ã¯? ããããã®æ¹æ³ã§ã¯ã³ãã³ããç¾å¨ã®ä½æ¥­ãã£ã¬ã¯ããªã§å®è¡ããã¾ã! æãééã£ã¦ãã¹ã¯ã¼ãã®ä»£ããã«ãã¹ãã¬ã¼ãºãèããã¾ãã ãããããã·ã§ã«ã¹ã¯ãªãããªãäºçªç®ã® `~fabric.operations.run` ã¯ ``/path/to/application/`` ãä½æ¥­ãã£ã¬ã¯ããªã¨ãã¦å®è¡ãããã§ãããã-- ãããä¸¡æ¹ã®ã³ãã³ãã¯ SSH ãéãã¦å¥ã®ã»ãã·ã§ã³ã§å®è¡ããã¾ãã ``$HOME/update.sh`` ãå®è¡ãããã¨ãã¾ãã(ãªã¢ã¼ãã®ãã¼ã ãã£ã¬ã¯ããªã¼ãããã©ã«ãã®ä½æ¥­ãã£ã¬ã¯ããªã¼ã§ã) å¯¾è©±å¼ã®æä½ãå¿è¦ãªããã®åé¡ãåº¦ãèµ·ãããªãã°ã­ã¼ãã«è¨­å®ã :ref:`env.always_use_pty <always-use-pty>` ãã ``False`` ã«å¤ãã¦ pty ã®å²ãå½ã¦ãç¡å¹ã«ãã¦ãããã§ãããã ããä½ããã®çç±ã§ã¿ã¼ã²ããã·ã¹ãã ã§ ``sudo`` ãä½¿ããªãã®ãªã ``su`` ãä½¿ãæ¹æ³ãããã¾ããããã«ã¯ã·ã§ã«ãéããã«ç¹å®ã®ã³ãã³ããå®è¡ããããã«éå¯¾è©±å½¢å¼ã§å¼ã³åºãå¿è¦ãããã¾ããä¸è¬çã« ``-c`` ãã©ã°ãä½¿ãã¾ããä¾ãã° ``su otheruser -c "command"`` ã­ã°ã¤ã³ã¦ã¼ã¶ã¼ã¨å¥ã®ã¦ã¼ãµã¼ã§ã³ãã³ããå®è¡ããã«ã¯2ã¤ã®é¸æè¢ãããã¾ã: Initã¹ã¯ãªãããåãã¾ãã! Initå½¢å¼ã® start/stop/restart ã¹ã¯ãªãã(ä¾ãã° ``/etc/init.d/apache2 start``)ã Fabric ã® pseudo-tty ã®å²ãå½ã¦ã§ãã¾ãåããªããã¨ãããã¾ããããã¯ããã©ã«ãã§ active ã§ããã»ã¨ãã©ã®å ´åãç¹ã«ãã®ãããªã³ãã³ãã®å¼ã³åºãã§ã¯ ``pty=False`` ã§æ­£ããåä½ãã¾ã:: Fabricã¯ã¹ã¬ããã»ã¼ã? (``cd``/``workon``/``export``/etc) ãåãã¾ãã! ãªã¢ã¼ãã·ã¹ãã ã«ããã©ã«ãã§ ``bash`` ãããã¾ããã``bash`` ãã¤ã³ã¹ãã¼ã«ãã¹ãã§ãã? ``supervisord`` ã ``systemd`` ã®ãããªãã­ã»ã¹ããã¼ã¸ã£ã¼ãä½¿ãã - such tools let you define what it means to "run" one of your background processes, then issue init-script-like start/stop/restart/status commands. ããã¯å¤å¸çãª init ã¹ã¯ãªããããå¤ãã®å©ç¹ãããã¾ãã ``env.shell`` ãã ``-l`` ãåãå»ããããã§ Bash ãã¹ã¿ã¼ãã¢ãããã¡ã¤ã«(ã¨ã¤ãªã¢ã¹ãªã©)ãã­ã¼ããã¾ããããããè¯ãæ¹æ³ã§ãããã ``pty=True`` ã `run` ã `sudo` ã«æ¸¡ããããã§ãªã¢ã¼ãå´ã« pseudo-tty ã®å²ãå½ã¦ãå¼·å¶ãã¾ãããã¾ãããã°åé¡ã®ãããã­ã°ã©ã ã®æ©å«ãç´ãã¾ãã ãã­ã°ã©ã ã ``nohup``ã§èµ°ããããä¼¼ããããª "in-shell" ãã¼ã«ãä½¿ã - æ³¨æ ãããæå¹ãªã¦ã¼ã¶ã¼ã¯å°ãªãããã§ãã `dynamic-hosts` ãåç§ãã¦ãã ããã `leveraging-execute-return-value` ãåç§ãã¦ãã ããã ``-l`` ã¯ã­ã°ã¤ã³ã·ã§ã«ãæå®ãã¦ãã¾ããå¤ãã®ç¶æ³ã§ä¾¿å©ã§ããå¿ãããå¿è¦ã§ã¯ããã¾ãããããã¤ãã®ã·ã§ã«ã«ã¯ãã®ãªãã·ã§ã³ãããã¾ãããããã®å ´åã¯ç¡è¦ãããã§ãããã ãããè§£æ±ºããéµã¯å¼ã³åºããã·ã§ã«ãããã¹ã¦ã®ãã­ã»ã¹ã®æ¨æºãã¤ããåé¢ããã¦ãããã¨ãç¢ºå®ã«ãããã¨ã§ããæ¹æ³ã¯ããã¤ãããã¾ãã(ç¢ºå®(robustness)ãªé ã«ãªã¹ã): æãããããç¶æ³ã¯ãããªãã¯ã­ã¼ã«ã«ã¦ã¼ã¶ã¼ã¨ãã¦ç¢ºãã« SSH ã­ã¼ãã§ã¤ã³ã¨ã¼ã¸ã§ã³ããå®è¡ãã¦ãããããããªã¢ã¼ããµã¼ãã¼ã¯ããªãã® SSH ã­ã¼ãåãåã£ã¦ããªããä¾ãã°ãããªãã¯ã­ã¼ãéã£ã¦ããªãã¨ãééã£ãã¦ã¼ã¶ã¼åãä½¿ã£ã¦ããã Fabric ã¯ "Please enter passphrase for private key" ã¨è¡¨ç¤ºãã¾ããå®éã«ã¯å¥åããªã¢ã¼ãå´ã«ãã¹ã¯ã¼ãããã¦éãã¾ãã ãã®åé¡ã«å¯¾å¦ããã«ã¯æ§ããªæ¹æ³ãããã¾ã: ããã«ã¯æãããé­éããããã¤ãã®åé¡ã¨ã¦ã¼ã¶ã¼ããæãã«ç¹°ãè¿ãå¯ããããè³ªåãããã¾ããããã¯ä»ã®ãã­ã¥ã¡ã³ãã®æ¿ããã«ãªããã®ã§ã¯ããã¾ãããç¹ã« :ref:`usage docs <usage-docs>`, ããã§ããã«ç¡ãè³ªåã¯ã¾ããã­ã¥ã¡ã³ããèª¿ã¹ã¦ãã ããã ããã¯ FreeBSD ã§åä½ãã¾ããåæ§ã«ä»ã®ã·ã¹ãã ã§ãåãã§ãããã ããã¯ :ref:`one-shell-per-command` ã®ç¹æ®ãªã±ã¼ã¹ã§ããFAQã§èª¬æããããã« ``su`` ã®ãããªã³ãã³ãã¯ 'stateful' ã§ããFabric ã§ãã¾ãåãã¾ãããããã§ã¯ã¼ã¯ã¢ã©ã¦ã³ã(åé¿ç­)ãä½¿ãã¾ãã ãããã®ã¡ãã»ã¼ã¸ã¯éå¸¸ãªã¢ã¼ãã¦ã¼ã¶ã¼ã® ``.profile`` ã ``.bashrc`` ãã¡ã¤ã«(ãããã¯ã·ã¹ãã å¨ä½ãå«ããã®ãããªãã¡ã¤ã«) ã«æ½ãã§ãã ``biff`` ã ``mesg`` ã§åºããã¾ãã Fabric ã®ããã©ã«ãã§ã¯ Bashã·ã§ã«ããããã®ãã¡ã¤ã«ãå®è¡ãã "ã­ã°ã¤ã³ã¢ã¼ã" ã§èµ·åãã¾ãã ``su -c`` "ã©ããã¼" ã§æ§ããªã³ãã³ããå®è¡ããã«ã¯ `~fabric.operations.run` ã®ã©ããã¼é¢æ°ãæ¸ãã¾ã:: æ®å¿µã§ããä»¥ä¸ã®ãããªã³ã¼ãã¯ããªãã®æå¾éãã®åä½ãããªããã¨ãæå³ãã¾ã:: èµ°ã£ã¦ããã·ã§ã«ããå®å¨ã«ãã­ã»ã¹ãåããã«ã¯ ``tmux`` ã ``screen`` ã ``dtach`` ãä½¿ã; ãããã®ãã¼ã«ã¯å¿è¦ãªãå¾ã§ãã­ã»ã¹ããªã¢ã¿ããã§ããã®ã§ä¾¿å©ã§ãã(ããã ``supervisord`` ã®ãããªãã¼ã«ã«æ¯ã¹ã¦ããã«å ´å½ããç(ad-hoc)ã§ã)ã `~fabric.operations.sudo` ã kwarg ``user=`` ã§ä½¿ããä¾ãã°ã``sudo("command", user="otheruser")``ããã ``user`` é¨åãã³ãã³ãã¨å¥ã«ãããã®ãªã `~fabric.context_managers.settings` ã§ ``env.sudo_user`` ãè¨­å®ãã¾ã:: æ¢å­ã®ãã¼ã¢ã³åãããã¯ããã¯ãä½¿ãã  -- ä¾ãã°ç´æ¥ãµã¼ãã¼ã®ãã¤ããªã¼ãå¼ã°ãã« init ã¹ã¯ãªãããå¼ã³ã¾ãã å°æ¥ã®ãªãªã¼ã¹ã§åè¿°ã® SSHã©ã¤ãã©ãªã® fork ãå¤æ´ãã¦å¯¾å¦ããã¤ããã§ãã Fabric ã¯å¤ãã®ã·ã§ã«ã¹ã¯ãªããã®ãããªã¿ã¹ã¯ãä½¿ãã¾ãããããã«ã¯ãããã«ããè½ã¨ãç©´ãããã¾ã: ããããã® `~fabric.operations.run` ã `~fabric.operations.sudo` ã®å¼ã³åºãã¯å¥ã®ã·ã§ã«ã»ãã·ã§ã³ã§è¡ãã¾ããããã¯ã³ãã³ããå®è¡ãããå¾ã« Fabric ããã®æ¨æºå¥åºåã¨ãªã¿ã¼ã³ã³ã¼ããç¢ºå®ã«çè§£ããããã«å¿è¦ã§ãã Fabric ã¯ ``bash`` ãå¿µé ­ã«æ¸ããã¦ãã¾ãããçµ¶å¯¾å¿è¦ã§ã¯ããã¾ãããåã« :ref:`env.shell <shell>` ãå¥½ããªã·ã§ã«ã«å¤ãã¾ããããã¦ ``bash`` ã® ``-c`` å¼æ°ã®ãããªã·ã§ã«ã³ãã³ããæ§ç¯ã§ããå¼æ°ãä½¿ãã¾ã:: ``&`` ã§ãã­ã°ã©ã ãããã¯ã°ã©ã¦ã³ãã§å®è¡ã§ãã¾ãããFabric ããã³ã°ãã¾ãã ãªãæã ``err: stdin: is not a tty`` ãè¡¨ç¤ºãããã®ã§ãã? çµ¶å¯¾ãã¹ãä½¿ããã¨ã§ãã£ã¬ã¯ããªã¼ç§»åãã¹ã­ãããããã¨ãã§ãã¾ã::  ``/bin/bash -l -c`` ã¯ :ref:`env.shell <shell>` ã®ããã©ã«ãå¤ã§ãã 