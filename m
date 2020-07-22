Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B5228D62
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jul 2020 03:15:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6134812460434;
	Tue, 21 Jul 2020 18:15:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3186912460431;
	Tue, 21 Jul 2020 18:15:24 -0700 (PDT)
IronPort-SDR: gTSXy7Rd3ofkN2vVPk+b3nXFTXhivrLmsla5G1ztCg/V7fQBeKCsF8P7AO8qtpJtYQuIEqcuxJ
 vmBodLnbZmcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="150234135"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="gz'50?scan'50,208,50";a="150234135"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 18:15:23 -0700
IronPort-SDR: jz+Gx1UaF7hMNR64NMQT8snhUZIqXk5atk0U/y4HrxmF/uIoO7gSzWM8ycvM50kuVurXmSKCC8
 emmYAegO00+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800";
   d="gz'50?scan'50,208,50";a="488282013"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2020 18:15:19 -0700
Date: Wed, 22 Jul 2020 09:27:30 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
Message-ID: <20200722012730.GA8345@xsang-OptiPlex-9020>
MIME-Version: 1.0
In-Reply-To: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: BHEU526TUP5QU3BXFZOI77YH4Y5OICCX
X-Message-ID-Hash: BHEU526TUP5QU3BXFZOI77YH4Y5OICCX
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: kbuild-all@lists.01.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BHEU526TUP5QU3BXFZOI77YH4Y5OICCX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 48778464bb7d346b47157d21ffde2af6b2d39110]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/ACPI-NVDIMM-Runtime-Firmware-Activation/20200721-062902
base:    48778464bb7d346b47157d21ffde2af6b2d39110
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago
config: x86_64-randconfig-s021-20200719 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/bluetooth/btusb.c:2245:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2254:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2255:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2256:25: sparse: sparse: cast to restricted __le16
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/cpufreq/cpufreq.c:471:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head @@
   drivers/cpufreq/cpufreq.c:471:17: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:471:17: sparse:     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head
   drivers/cpufreq/cpufreq.c:471:65: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *next @@
   drivers/cpufreq/cpufreq.c:471:65: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:471:65: sparse:     got struct notifier_block [noderef] __rcu *next
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/internal.h:43:42: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:1627:56: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:1629:56: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:455:17: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:455:25: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:469:47: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3347:65: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3823:47: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:3965:65: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:5527:54: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/core.c:5528:54: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/internal.h:43:42: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/of_regulator.c:18:43: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:193:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:196:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:199:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:202:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:203:22: sparse: sparse: restricted suspend_state_t degrades to integer
   drivers/regulator/of_regulator.c:252:26: sparse: sparse: restricted suspend_state_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/regulator/da9063-regulator.c:514:17: sparse: sparse: Initializer entry defined twice
   drivers/regulator/da9063-regulator.c:515:18: sparse:   also defined here
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/tty/sysrq.c:148:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/base/firmware_loader/main.c:266:9: sparse: sparse: context imbalance in 'free_fw_priv' - wrong count at exit
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   init/do_mounts.c:408:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const [noderef] __user * @@     got char * @@
   init/do_mounts.c:408:30: sparse:     expected char const [noderef] __user *
   init/do_mounts.c:408:30: sparse:     got char *
   init/do_mounts.c:412:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char * @@
   init/do_mounts.c:412:20: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.c:412:20: sparse:     got char *
   init/do_mounts.c:685:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected char const [noderef] __user * @@     got char * @@
   init/do_mounts.c:685:23: sparse:     expected char const [noderef] __user *
   init/do_mounts.c:685:23: sparse:     got char *
   init/do_mounts.c:686:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char * @@
   init/do_mounts.c:686:21: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.c:686:21: sparse:     got char *
   init/do_mounts.h:19:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *pathname @@     got char *name @@
   init/do_mounts.h:19:21: sparse:     expected char const [noderef] __user *pathname
   init/do_mounts.h:19:21: sparse:     got char *name
   init/do_mounts.h:20:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const [noderef] __user *filename @@     got char *name @@
   init/do_mounts.h:20:27: sparse:     expected char const [noderef] __user *filename
   init/do_mounts.h:20:27: sparse:     got char *name
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/umh.c:74:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/umh.c:74:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/umh.c:74:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/umh.c:76:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/umh.c:76:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/umh.c:76:33: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sys.c:1878:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *[assigned] file @@
   kernel/sys.c:1878:19: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/sys.c:1878:19: sparse:     got struct file *[assigned] file
   kernel/sys.c:1878:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *old_exe @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/sys.c:1878:17: sparse:     expected struct file *old_exe
   kernel/sys.c:1878:17: sparse:     got struct file [noderef] __rcu *[assigned] __ret
   kernel/sys.c:2240:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int [noderef] __user **tid_addr @@
   kernel/sys.c:2240:16: sparse:     expected void const volatile [noderef] __user *
   kernel/sys.c:2240:16: sparse:     got int [noderef] __user **tid_addr
   kernel/sys.c:1049:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1049:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1049:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/core.c:256:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:256:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:256:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:512:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:512:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:512:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1432:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1432:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:1432:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1432:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1432:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:1432:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3650:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3650:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:3650:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4083:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:4083:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:4083:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:4506:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4506:17: sparse:    struct task_struct *
   kernel/sched/core.c:4506:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:4705:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4705:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:4705:22: sparse:    struct task_struct *
   kernel/sched/core.c:8011:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8011:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:8011:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:256:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1415:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1416:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1419:40: sparse: sparse: dereference of noderef expression
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1809:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1809:9: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/cputime.c:316:17: sparse: sparse: context imbalance in 'thread_group_cputime' - different lock contexts for basic block
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/fair.c:881:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:881:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:881:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:5386:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:5386:38: sparse:    struct task_struct *
   kernel/sched/fair.c:5401:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:5401:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:5401:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:6880:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:6880:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:6880:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7131:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7131:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7131:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:10692:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10692:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10825:30: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:10825:30: sparse:    struct task_struct *
   kernel/sched/fair.c:5330:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/sched.h:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1803:9: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/rt.c:912:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:912:70: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:912:70: sparse:    struct task_struct *
   kernel/sched/rt.c:529:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:529:54: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:529:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:998:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:998:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:998:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1424:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1424:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1424:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2300:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2300:46: sparse:    struct task_struct *
   kernel/sched/rt.c:2320:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2320:22: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/deadline.c:1721:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1721:42: sparse:     expected struct sched_dl_entity *b
   kernel/sched/deadline.c:1721:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1054:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1054:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1054:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1183:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1183:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1183:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2385:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2385:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2404:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2404:46: sparse:    struct task_struct *
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:693:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:693:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:693:37: sparse:     got struct spinlock [noderef] __rcu *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/debug.c:435:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/debug.c:435:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/debug.c:435:22: sparse:    struct task_struct *
   kernel/sched/debug.c:643:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:643:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:643:9: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/debug.c:643:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/debug.c:643:9: sparse:     expected struct task_struct *tsk
   kernel/sched/debug.c:643:9: sparse:     got struct task_struct [noderef] __rcu *curr
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   kernel/sched/psi.c:1205:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/psi.c:1205:9: sparse:    void [noderef] __rcu *
   kernel/sched/psi.c:1205:9: sparse:    void *
   kernel/sched/psi.c:734:30: sparse: sparse: dereference of noderef expression
   kernel/sched/sched.h:1657:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:1657:25: sparse:    struct task_struct *
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   include/linux/gfp.h:325:27: sparse: sparse: restricted gfp_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/ata/libata-scsi.c:1784:13: sparse: sparse: context imbalance in 'ata_scsi_rbuf_get' - wrong count at exit
   drivers/ata/libata-scsi.c:1814:31: sparse: sparse: context imbalance in 'ata_scsi_rbuf_fill' - unexpected unlock
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/pci/pci-driver.c:494:42: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/pci/pci-driver.c:494:61: sparse: sparse: restricted pci_power_t degrades to integer
--
>> include/linux/suspend.h:470:15: sparse: sparse: 'hibernate_quiet_exec()' has implicit return type
   drivers/acpi/bus.c:37:20: sparse: sparse: symbol 'acpi_root' was not declared. Should it be static?

# https://github.com/0day-ci/linux/commit/d55d8fef1e62acab40273b953e45a9d58f7e73c9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d55d8fef1e62acab40273b953e45a9d58f7e73c9
vim +470 include/linux/suspend.h

d55d8fef1e62ac Dan Williams  2020-07-20  469  
d55d8fef1e62ac Dan Williams  2020-07-20 @470  static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
d55d8fef1e62ac Dan Williams  2020-07-20  471  	return -ENOTSUPP;
d55d8fef1e62ac Dan Williams  2020-07-20  472  }
fce2b111fae915 Cornelia Huck 2009-06-10  473  #endif /* CONFIG_HIBERNATION */
fce2b111fae915 Cornelia Huck 2009-06-10  474  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
