Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B81BF318
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 10:41:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E618A111ADBD1;
	Thu, 30 Apr 2020 01:40:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05716111ADBD0
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 01:39:59 -0700 (PDT)
IronPort-SDR: 5PP1BFqYOKvdezvAbVukdDGEN3m/K5TD0CXynv/oUMAKJcdy1xcS3YEOf71neh50NHTnRl4kTx
 WrD5HJ6EC3eA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 01:41:08 -0700
IronPort-SDR: +SbNMsauFiB5ELoBy32LzdT63RXPMNZtx+Zg3uwJQnCzI6godX+TRUBLmo9Zb6Ea60gLXsF8zn
 QsPVZw6I4O/Q==
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400";
   d="scan'208";a="405330939"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 01:41:07 -0700
Subject: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Thu, 30 Apr 2020 01:24:58 -0700
Message-ID: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GWOAVBKP2XZT6HXA7TQ6MNPKBEWL7MWG
X-Message-ID-Hash: GWOAVBKP2XZT6HXA7TQ6MNPKBEWL7MWG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GWOAVBKP2XZT6HXA7TQ6MNPKBEWL7MWG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1:
- Rename memcpy_mcsafe() to copy_safe() since the x86-machine-check
  specifics have already been de-emphasized in a previous commit and are
  further de-emphasized by these changes. (Linus)

- Move copy_safe() out-of-line since it no longer reverts to plain
  memcpy (Linus)

- Move copy_safe() to its own stand-alone compilation unit where it no
  longer entangles with arch/x86/lib/memcpy_64.S. This also allows perf
  to stop tracking ongoing updates to that file due to copy_safe()
  updates. (Linus)

- Move the PowerPC implementation over to the new name.

[1]: http://lore.kernel.org/r/158654083112.1572482.8944305411228188871.stgit@dwillia2-desk3.amr.corp.intel.com

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
      copy_safe: Rename memcpy_mcsafe() to copy_safe()
      x86/copy_safe: Introduce copy_safe_fast()


 arch/powerpc/Kconfig                               |    2 
 arch/powerpc/include/asm/string.h                  |    2 
 arch/powerpc/include/asm/uaccess.h                 |    4 
 arch/powerpc/lib/Makefile                          |    2 
 arch/powerpc/lib/copy_safe.S                       |    4 
 arch/x86/Kconfig                                   |    2 
 arch/x86/Kconfig.debug                             |    2 
 arch/x86/include/asm/copy_safe.h                   |   18 ++
 arch/x86/include/asm/copy_safe_test.h              |   75 +++++++++
 arch/x86/include/asm/mcsafe_test.h                 |   75 ---------
 arch/x86/include/asm/string_64.h                   |   32 ----
 arch/x86/include/asm/uaccess_64.h                  |   21 ---
 arch/x86/kernel/cpu/mce/core.c                     |    9 -
 arch/x86/kernel/quirks.c                           |   10 -
 arch/x86/lib/Makefile                              |    1 
 arch/x86/lib/copy_safe.c                           |   66 ++++++++
 arch/x86/lib/copy_safe_64.S                        |  163 ++++++++++++++++++++
 arch/x86/lib/memcpy_64.S                           |  115 --------------
 arch/x86/lib/usercopy_64.c                         |   21 ---
 drivers/md/dm-writecache.c                         |   12 +
 drivers/nvdimm/claim.c                             |    2 
 drivers/nvdimm/pmem.c                              |    6 -
 include/linux/string.h                             |   17 +-
 include/linux/uio.h                                |   10 +
 lib/Kconfig                                        |    2 
 lib/iov_iter.c                                     |   36 ++--
 tools/arch/x86/include/asm/copy_safe_test.h        |   13 ++
 tools/arch/x86/include/asm/mcsafe_test.h           |   13 --
 tools/arch/x86/lib/memcpy_64.S                     |  115 --------------
 tools/objtool/check.c                              |    5 -
 tools/perf/bench/Build                             |    1 
 tools/perf/bench/mem-memcpy-x86-64-lib.c           |   24 ---
 tools/testing/nvdimm/test/nfit.c                   |   49 +++---
 .../testing/selftests/powerpc/copyloops/.gitignore |    2 
 tools/testing/selftests/powerpc/copyloops/Makefile |    6 -
 .../selftests/powerpc/copyloops/copy_safe.S        |    0 
 36 files changed, 429 insertions(+), 508 deletions(-)
 rename arch/powerpc/lib/{memcpy_mcsafe_64.S => copy_safe.S} (98%)
 create mode 100644 arch/x86/include/asm/copy_safe.h
 create mode 100644 arch/x86/include/asm/copy_safe_test.h
 delete mode 100644 arch/x86/include/asm/mcsafe_test.h
 create mode 100644 arch/x86/lib/copy_safe.c
 create mode 100644 arch/x86/lib/copy_safe_64.S
 create mode 100644 tools/arch/x86/include/asm/copy_safe_test.h
 delete mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
 delete mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c
 rename tools/testing/selftests/powerpc/copyloops/{memcpy_mcsafe_64.S => copy_safe.S} (100%)

base-commit: b8dcd632c06b8706d22934f9bf9bf16a42b1ecc7
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
