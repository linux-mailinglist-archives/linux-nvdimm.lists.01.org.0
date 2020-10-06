Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1C28446D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 05:58:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A9A8154B3BC2;
	Mon,  5 Oct 2020 20:58:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E237154B1F5E
	for <linux-nvdimm@lists.01.org>; Mon,  5 Oct 2020 20:58:48 -0700 (PDT)
IronPort-SDR: EpWY8DxaNeHOywR6QRMSgVPjIWj/LD68xQ6d6ZGAABxBvRzCkQCTZiiuSl1G8Ak60/PrgL7XZ/
 a2+tk9mEpmlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163577751"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400";
   d="scan'208";a="163577751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 20:58:42 -0700
IronPort-SDR: cKWN0VRgTwU820TpT6TxhC135MCOp8TbkJe/wvY9/BRBwxNybA41vDUyBD3kI1Z/aZaZ2bD/vf
 +Tl2UqQUlDJA==
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400";
   d="scan'208";a="341825674"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 20:58:39 -0700
Subject: [PATCH v10 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user,
 kernel}
From: Dan Williams <dan.j.williams@intel.com>
To: bp@alien8.de
Date: Mon, 05 Oct 2020 20:40:10 -0700
Message-ID: <160195561059.2163339.8787400120285484198.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: SCQPJCDF3BY4AHRY7E635Q5HZWUPSRXM
X-Message-ID-Hash: SCQPJCDF3BY4AHRY7E635Q5HZWUPSRXM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 0day robot <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SCQPJCDF3BY4AHRY7E635Q5HZWUPSRXM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v9 [1]:

- (Boris) Compile out the copy_mc_fragile() infrastructure in the
  CONFIG_X86_MCE=n case.

  This had several knock-on effects. The proposed x86: copy_mc_generic()
  was internally checking for X86_FEATURE_ERMS and falling back to
  copy_mc_fragile(), however that fallback is not possible in the
  CONFIG_X86_MCE=n case when copy_mc_fragile() is compiled out. Instead,
  copy_mc_to_user() is rewritten similar to copy_user_generic() that walks
  through several fallback implementations copy_mc_fragile ->
  copy_mc_enhanced_fast_string (new) -> copy_user_generic (no #MC
  recovery).

[1]: http://lore.kernel.org/r/160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com

---

Hi Boris,

I gave this some soak time over the weekend for the robots to chew on
for regressions. No reports, and the updates pass my testing. Please
consider including this in your updates for v5.10, and thanks for
offering to pick this up.

---

The motivations to go rework memcpy_mcsafe() are that the benefit of
doing slow and careful copies is obviated on newer CPUs, and that the
current opt-in list of cpus to instrument recovery is broken relative to
those cpus.  There is no need to keep an opt-in list up to date on an
ongoing basis if pmem/dax operations are instrumented for recovery by
default. With recovery enabled by default the old "mcsafe_key" opt-in to
careful copying can be made a "fragile" opt-out. Where the "fragile"
list takes steps to not consume poison across cachelines.

The discussion with Linus made clear that the current "_mcsafe" suffix
was imprecise to a fault. The operations that are needed by pmem/dax are
to copy from a source address that might throw #MC to a destination that
may write-fault, if it is a user page. So copy_to_user_mcsafe() becomes
copy_mc_to_user() to indicate the separate precautions taken on source
and destination. copy_mc_to_kernel() is introduced as a non-SMAP version
that does not expect write-faults on the destination, but is still
prepared to abort with an error code upon taking #MC.

---

Dan Williams (2):
      x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user,kernel}()
      x86/copy_mc: Introduce copy_mc_enhanced_fast_string()


 arch/powerpc/Kconfig                               |    2 
 arch/powerpc/include/asm/string.h                  |    2 
 arch/powerpc/include/asm/uaccess.h                 |   40 +++--
 arch/powerpc/lib/Makefile                          |    2 
 arch/powerpc/lib/copy_mc_64.S                      |    4 
 arch/x86/Kconfig                                   |    2 
 arch/x86/Kconfig.debug                             |    2 
 arch/x86/include/asm/copy_mc_test.h                |   75 +++++++++
 arch/x86/include/asm/mce.h                         |    9 +
 arch/x86/include/asm/mcsafe_test.h                 |   75 ---------
 arch/x86/include/asm/string_64.h                   |   32 ----
 arch/x86/include/asm/uaccess.h                     |    9 +
 arch/x86/include/asm/uaccess_64.h                  |   20 --
 arch/x86/kernel/cpu/mce/core.c                     |    8 -
 arch/x86/kernel/quirks.c                           |   10 -
 arch/x86/lib/Makefile                              |    1 
 arch/x86/lib/copy_mc.c                             |   96 ++++++++++++
 arch/x86/lib/copy_mc_64.S                          |  163 ++++++++++++++++++++
 arch/x86/lib/memcpy_64.S                           |  115 --------------
 arch/x86/lib/usercopy_64.c                         |   21 ---
 drivers/md/dm-writecache.c                         |   15 +-
 drivers/nvdimm/claim.c                             |    2 
 drivers/nvdimm/pmem.c                              |    6 -
 include/linux/string.h                             |    9 -
 include/linux/uaccess.h                            |   13 ++
 include/linux/uio.h                                |   10 +
 lib/Kconfig                                        |    7 +
 lib/iov_iter.c                                     |   48 +++---
 tools/arch/x86/include/asm/mcsafe_test.h           |   13 --
 tools/arch/x86/lib/memcpy_64.S                     |  115 --------------
 tools/objtool/check.c                              |    5 -
 tools/perf/bench/Build                             |    1 
 tools/perf/bench/mem-memcpy-x86-64-lib.c           |   24 ---
 tools/testing/nvdimm/test/nfit.c                   |   49 +++---
 .../testing/selftests/powerpc/copyloops/.gitignore |    2 
 tools/testing/selftests/powerpc/copyloops/Makefile |    6 -
 .../selftests/powerpc/copyloops/copy_mc_64.S       |    1 
 .../selftests/powerpc/copyloops/memcpy_mcsafe_64.S |    1 
 38 files changed, 484 insertions(+), 531 deletions(-)
 rename arch/powerpc/lib/{memcpy_mcsafe_64.S => copy_mc_64.S} (98%)
 create mode 100644 arch/x86/include/asm/copy_mc_test.h
 delete mode 100644 arch/x86/include/asm/mcsafe_test.h
 create mode 100644 arch/x86/lib/copy_mc.c
 create mode 100644 arch/x86/lib/copy_mc_64.S
 delete mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 delete mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c
 create mode 120000 tools/testing/selftests/powerpc/copyloops/copy_mc_64.S
 delete mode 120000 tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S

base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
