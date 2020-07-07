Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D552162F0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 02:23:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 456CD1107E168;
	Mon,  6 Jul 2020 17:23:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC658110122B2
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 17:23:34 -0700 (PDT)
IronPort-SDR: Ojrc0KnaUWoUyrgtv8P6Nb2+31/fwh7NZcmVdMDPZlXw8I9GnYWSLtNPYHecMVgfbl1HMiK15+
 zz8YcAn+Zu5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="147530233"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="147530233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:23:34 -0700
IronPort-SDR: 95vkV2BlzuBukNCHuQAgKx50KXPbFW+U7v1o2y4XF8rmhQH3Dd3Oic1fCsYj+T/yviasdyrz0x
 EfwYOzj0x+cg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="483316089"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:23:33 -0700
Subject: [PATCH v7 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Date: Mon, 06 Jul 2020 17:07:18 -0700
Message-ID: <159408043801.2272533.17485467640602344900.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 3OMOBKI3C6C2FJRYB55Q2HH2CUJVWCFT
X-Message-ID-Hash: 3OMOBKI3C6C2FJRYB55Q2HH2CUJVWCFT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3OMOBKI3C6C2FJRYB55Q2HH2CUJVWCFT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v6 [1]:
- Collected Tony's Reviewed-by.

- Rebased on v5.8-rc3 to address a conflict with commit e3a9e681adb7
  ("x86/entry: Fixup bad_iret vs noinstr") No other functional changes,
  and no other comments since v5. At this point I think I'll go ahead
  with pushing to -next to get it some soak time for a potential v5.9
  merge and catch any other conflicts that might arise in the meantime. Of
  course, I'll immediately drop it from -next if x86.tip picks it up or
  naks it. As it stands, nothing queued in x86.tip/master conflicts with
  these.

[1]: http://lore.kernel.org/r/159244031857.1107636.5054974045023236143.stgit@dwillia2-desk3.amr.corp.intel.com

---

The primary motivation to go touch memcpy_mcsafe() is that the existing
benefit of doing slow and careful copies is obviated on newer CPUs. That
fact solves the problem of needing to detect machine-check recovery
capability. Now the old "mcsafe_key" opt-in to careful copying can be made
an opt-out from the default fast copy implementation.

The discussion with Linus further made clear that this facility had
already lost its x86-machine-check specificity starting with commit
2c89130a56a ("x86/asm/memcpy_mcsafe: Add write-protection-fault
handling"). The new changes to not require a "careful copy" further
de-emphasizes the role that x86-MCA plays in the implementation to just
one more source of recoverable trap during the operation.

With the above realizations the name "mcsafe" is no longer accurate and
copy_safe() is proposed as its replacement. x86 grows a copy_safe_fast()
implementation as a default implementation that is independent of
detecting the presence of x86-MCA.

---

Dan Williams (2):
      x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user,kernel}()
      x86/copy_mc: Introduce copy_mc_generic()


 arch/powerpc/Kconfig                               |    2 
 arch/powerpc/include/asm/string.h                  |    2 
 arch/powerpc/include/asm/uaccess.h                 |   40 +++--
 arch/powerpc/lib/Makefile                          |    2 
 arch/powerpc/lib/copy_mc_64.S                      |    4 
 arch/x86/Kconfig                                   |    2 
 arch/x86/Kconfig.debug                             |    2 
 arch/x86/include/asm/copy_mc_test.h                |   75 +++++++++
 arch/x86/include/asm/mcsafe_test.h                 |   75 ---------
 arch/x86/include/asm/string_64.h                   |   32 ----
 arch/x86/include/asm/uaccess.h                     |   21 +++
 arch/x86/include/asm/uaccess_64.h                  |   20 --
 arch/x86/kernel/cpu/mce/core.c                     |    8 -
 arch/x86/kernel/quirks.c                           |    9 -
 arch/x86/lib/Makefile                              |    1 
 arch/x86/lib/copy_mc.c                             |   64 ++++++++
 arch/x86/lib/copy_mc_64.S                          |  165 ++++++++++++++++++++
 arch/x86/lib/memcpy_64.S                           |  115 --------------
 arch/x86/lib/usercopy_64.c                         |   21 ---
 drivers/md/dm-writecache.c                         |   15 +-
 drivers/nvdimm/claim.c                             |    2 
 drivers/nvdimm/pmem.c                              |    6 -
 include/linux/string.h                             |    9 -
 include/linux/uaccess.h                            |    9 +
 include/linux/uio.h                                |   10 +
 lib/Kconfig                                        |    7 +
 lib/iov_iter.c                                     |   43 +++--
 tools/arch/x86/include/asm/mcsafe_test.h           |   13 --
 tools/arch/x86/lib/memcpy_64.S                     |  115 --------------
 tools/objtool/check.c                              |    5 -
 tools/perf/bench/Build                             |    1 
 tools/perf/bench/mem-memcpy-x86-64-lib.c           |   24 ---
 tools/testing/nvdimm/test/nfit.c                   |   48 +++---
 .../testing/selftests/powerpc/copyloops/.gitignore |    2 
 tools/testing/selftests/powerpc/copyloops/Makefile |    6 -
 .../selftests/powerpc/copyloops/copy_mc_64.S       |    1 
 .../selftests/powerpc/copyloops/memcpy_mcsafe_64.S |    1 
 37 files changed, 451 insertions(+), 526 deletions(-)
 rename arch/powerpc/lib/{memcpy_mcsafe_64.S => copy_mc_64.S} (98%)
 create mode 100644 arch/x86/include/asm/copy_mc_test.h
 delete mode 100644 arch/x86/include/asm/mcsafe_test.h
 create mode 100644 arch/x86/lib/copy_mc.c
 create mode 100644 arch/x86/lib/copy_mc_64.S
 delete mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 delete mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c
 create mode 120000 tools/testing/selftests/powerpc/copyloops/copy_mc_64.S
 delete mode 120000 tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
