Þ            )   ü         "  ¡     Ä  $   I  o   n  R   Þ    1     8     Ø  Ð   Ù  +   ª  @   Ö  D   	  J   \	  =   §	  B   å	  
   (
  É   3
  G   ý
  J   E  H        Ù     l  m   ñ  ë   _  ¸   K  9     #   >  »   b  @       _  V  ì  ¬   C  9   ð     *  w   Â  j  :  ö   ¥  J    P  ç  4   8  u   m  {   ã     _  L   ö  `   C     ¤  ë   ·  G   £     ë     s  °   û  º   ¬  p   g   *  Ø   í   "  A   ñ"  #   3#  È   W#  @    $                        
                                                                                                             	    A role is simply defined as a key in `env` whose value is a list of one or more host connection strings. For example, the following will ensure that, barring an override on the command line, ``my_func`` will be executed against the hosts listed in the ``webserver`` and ``dbserver`` roles:: Added the ``alias``, ``aliases``, ``task_class`` and ``default`` keyword arguments. See :ref:`task-decorator-arguments` for details. Added the ``name`` keyword argument. Allow a single, iterable argument (``@hosts(iterable)``) to be used instead of requiring ``@hosts(*iterable)``. Allow a single, iterable argument to be used (same as `~fabric.decorators.hosts`). Allows you to wrap an entire function as if it was called inside a block with the ``settings`` context manager. This may be useful if you know you want a given setting applied to an entire function body, or wish to retrofit old code without indenting everything. Any function wrapped with this decorator will silently fail to execute the 2nd, 3rd, ..., Nth time it is called, and will return the value of the original run. As with `~fabric.decorators.hosts`, `~fabric.decorators.roles` may be invoked with either an argument list or a single, iterable argument. Similarly, this decorator uses the same mechanism as `~fabric.decorators.hosts` and simply sets ``<function>.roles``. By keeping internal state, this decorator allows you to mark a function such that it will only run once per Python interpreter session, which in typical use means "once per invocation of the ``fab`` program". Convenience decorators for use in fabfiles. Decorator declaring the wrapped function to be a new-style task. Decorator defining a list of role names, used to look up host lists. Decorator defining which host or hosts to execute the wrapped function on. Decorator equivalent of ``fabric.context_managers.settings``. Decorator preventing wrapped function from running more than once. Decorators For example, the following will ensure that, barring an override on the command line, ``my_func`` will be run on ``host1``, ``host2`` and ``host3``, and with specific users on ``host1`` and ``host3``:: For example, to turn aborts into warnings for an entire task function:: Forces the wrapped function to always run sequentially, never in parallel. Forces the wrapped function to run in parallel, instead of sequentially. May be invoked as a simple, argument-less decorator (i.e. ``@task``) or with arguments customizing its behavior (e.g. ``@task(alias='myalias')``). Note that this decorator actually just sets the function's ``.hosts`` attribute, which is then read prior to executing the function. Please see the :ref:`new-style task <task-decorator>` documentation for details on how to use this decorator. This decorator takes precedence over the global value of :ref:`env.parallel <env-parallel>`. However, if a task is decorated with both `~fabric.decorators.serial` *and* `~fabric.decorators.parallel`, `~fabric.decorators.parallel` wins. This decorator takes precedence over the global value of :ref:`env.parallel <env-parallel>`. It also takes precedence over `~fabric.decorators.serial` if a task is decorated with both. ``runs_once`` does not work with parallel task execution. `~fabric.context_managers.settings` `~fabric.decorators.hosts` may be invoked with either an argument list (``@hosts('host1')``, ``@hosts('host1', 'host2')``) or a single, iterable argument (``@hosts(['host1', 'host2'])``). `~fabric.docs.unwrap_tasks`, `~fabric.tasks.WrappedCallableTask` Project-Id-Version: Fabric 1.8
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2014-02-15 23:24+0900
PO-Revision-Date: 2014-09-27 12:34+0900
Last-Translator: JOTAKI, Taisuke <tekapo@gmail.com>
Language-Team: Fabric ja <tekapo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.6.9
Plural-Forms: nplurals=1; plural=0;
Language: ja
 ã­ã¼ã«ã¯ãä¸ã¤ãããã¯è¤æ°ã®ãã¹ãæ¥ç¶æå­åãå¤ã¨ãã `env` ã®ã­ã¼ã¨ãã¦åç´ã«å®ç¾©ããã¾ããä¾ãã°æ¬¡ã®ä¾ã¯ãã³ãã³ãã©ã¤ã³ã«å¯¾ããä¸æ¸ããé²ãã``my_func`` ã ``webserver`` ã¨ ``dbserver`` ã®ã­ã¼ã«ã«ãªã¹ãããã¦ãããã¹ãã«å¯¾ãã¦å®è¡ããã¾ãã ``alias``ã``aliases``ã``task_class``ã``default`` ã®ã­ã¼ã¯ã¼ãå¼ãæ°ãè¿½å ãã¾ãããè©³ç´°ã¯ :ref:`task-decorator-arguments` ããè¦§ãã ããã ``name`` ã­ã¼ã¯ã¼ãå¼ãæ°ãè¿½å ãã¾ããã ``@hosts(*iterable)`` ãå¿è¦ã¨ããä»£ããã«ç¹°ãè¿ãã®å¼ãæ° (``@hosts(iterable)``) ã¨ãã¦å©ç¨ã§ããããã«ãªãã¾ããã åä¸ã®ç¹°ãè¿ãã®å¼ãæ°(`~fabric.decorators.hosts` ã¨åãããã«)ãä½¿ããããã«ãªãã¾ããã ã¾ãã§ ``settings`` ã³ã³ãã­ã¹ãããã¼ã¸ã£ã¼ãä¼´ã£ã¦ã²ã¨ã¤ã®ãã­ãã¯åã§å¼ã³åºãããããã«é¢æ°å¨ä½ãã©ãããã¾ããããã¯ãé¢æ°ããã£å¨ä½ã«ä¸ããããã»ããã£ã³ã°ãé©ç¨ããããã¨ããããã¹ã¦ãã¤ã³ãã³ããããã«å¤ãã³ã¼ããå¤æ´ãããã¨ãã«ä¾¿å©ã§ãã ãã®ãã³ã¬ã¼ã¿ã¼ã§ã©ãããããã©ããªé¢æ°ã§ããããã2åãã3åããnåç®ã«å¼ã³åºããã¦å¼ã³åºãããã¨ãã«ä½ãããã«å®è¡ã«å¤±æããæåã®ãªãªã¸ãã«ã®å®è¡ã®å¤ãè¿ãã¾ãã `~fabric.decorators.hosts` ã¨åãããã« `~fabric.decorators.roles` ã¯å¼ãæ°ãªã¹ããããã¯åä¸ã®ç¹°ãè¿ãã®å¼ãæ°ãåã£ã¦å®è¡ã§ãã¾ããåãããã«ããã®ãã³ã¬ã¼ã¿ã¼ã¯ `~fabric.decorators.hosts` ã¨åãä»çµã¿ãä½¿ããåç´ã« ``<function>.roles`` ãã»ãããã¾ãã åé¨ã®ç¶æãä¿æãããã¨ã«ãã£ã¦ããã®ãã³ã¬ã¼ã¿ã¼ã¯é¢æ°ã«å°ãã¤ããä¸ã¤ã®Pythonç¹°ãè¿ãã»ãã·ã§ã³ã«ã¤ãä¸åº¦ã ãããå®è¡ã§ããªãããã«ãã¾ããå¸åçãªä½¿ç¨æ³ã¨ãã¦ã¯ã¤ã¾ãã"ãã® ``fab`` ãã­ã°ã©ã ã®å®è¡ã«ã¤ãä¸å" ã¨ãããã¨ã§ãã fabfileã§ä½¿ãããä¾¿å©ãªãã³ã¬ã¼ã¿ã¼ã ã©ãããããé¢æ°ãæ°ããã¹ã¿ã¤ã«ã®ã¿ã¹ã¯ã§ãããã¨ãå®£è¨ãããã³ã¬ã¼ã¿ã¼ã§ãã ãã¹ããªã¹ããåç§ããããã«å©ç¨ãããã­ã¼ã«åã®ãªã¹ããå®ç¾©ãããã³ã¬ã¼ã¿ã¼ã§ãã ã©ãããããé¢æ°ãã²ã¨ã¤ãããã¯è¤æ°ã®ã©ã®ãã¹ãã«å¯¾ãã¦å®è¡ããã®ããå®ç¾©ãã¦ãããã³ã¬ã¼ã¿ã¼ã§ãã ``fabric.context_managers.settings`` ã¨åç­ã®ãã³ã¬ã¼ã¿ã¼ã§ãã ã©ãããããé¢æ°ãè¤æ°åå®è¡ãããªãããã«ãããã³ã¬ã¼ã¿ã¼ã§ãã ãã³ã¬ã¼ã¿ã¼ ä¾ãã°ãä»¥ä¸ã¯ã³ãã³ãã©ã¤ã³ã¸ã®ä¸æ¸ããé²ãã¾ãã``my_func`` ã¯ ``host1``ã``host2``ã``host3`` ã«å¯¾ãã¦ãããã¦ ``host1``ã¨``host3`` ã«å¯¾ãã¦ã¯ã¦ã¼ã¶ã¼ãæå®ãã¦å®è¡ããã¾ãã ä¾ãã°ãã¿ã¹ã¯é¢æ°å¨ä½ã§åæ­¢ãè­¦åã«å¤æ´ãã¾ã:: ããã§ã©ãããããé¢æ°ãå¸¸ã«é çªã«å®è¡ããããããæ±ºãã¦ä¸¦åã«ã¯å®è¡ãããªãããã«ãã¾ãã ããã§ã©ãããããé¢æ°ãå¸¸ã«ä¸¦åã«å®è¡ããããããæ±ºãã¦é çªã«ã¯å®è¡ãããªãããã«ãã¾ãã åç´ãªå¼æ°ãªãã®ãã³ã¬ã¼ã¿ã¼ã¨ãã¦ããããã¯æåãã«ã¹ã¿ãã¤ãºããå¼ãæ° (e.g. ``@task(alias='myalias')``) ãä¼´ã£ã¦å®è¡ããã¾ãã ãã®ãã³ã¬ã¼ã¿ã¼ã¯å®éã«ã¯åã«ãã®é¢æ°ã® ``.hosts`` å±æ§ãã»ããããã ãã§ãããã®ããããã®é¢æ°ã®å®è¡ã«åç«ã£ã¦èª­ã¿è¾¼ã¾ãã¾ãã ãã®ãã³ã¬ã¼ã¿ã¼ã®å©ç¨æ³ã®è©³ç´°ã¯ :ref:`new-style task <task-decorator>` ããè¦§ãã ããã ãã®ãã³ã¬ã¼ã¿ã¼ã¯ :ref:`env.parallel <env-parallel>` ã®ã°ã­ã¼ãã«å¤ãããåªåãã¾ããã¨ã¯è¨ãã`~fabric.decorators.serial` ã¨ `~fabric.decorators.parallel` ã® *ä¸¡æ¹* ã®ãã³ã¬ã¼ã¿ã¼ãæã¤ã¿ã¹ã¯ã§ã¯ `~fabric.decorators.parallel` ãåªåãã¾ãã ãã®ãã³ã¬ã¼ã¿ã¼ã¯ :ref:`env.parallel <env-parallel>` ã®ã°ã­ã¼ãã«å¤ãããåªåãã¾ããã¾ãã`~fabric.decorators.serial` ã¨ä¸¡æ¹ãæã¤ã¿ã¹ã¯ã§ã¯ `~fabric.decorators.serial` ãããåªåãã¾ãã ``runs_once`` ã¯ä¸¦åã¿ã¹ã¯å®è¡ã§ã¯åä½ãã¾ããã `~fabric.context_managers.settings` `~fabric.decorators.hosts` ã¯å¼ãæ°ãªã¹ã(``@hosts('host1')``, ``@hosts('host1', 'host2')``)ãããã¯ç¹°ãè¿ãã®å¼ãæ°(``@hosts(['host1', 'host2'])``)ãåã£ã¦å®è¡ã§ãã¾ãã `~fabric.docs.unwrap_tasks`, `~fabric.tasks.WrappedCallableTask` 