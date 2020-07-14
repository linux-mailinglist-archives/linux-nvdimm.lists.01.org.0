Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204F21E8FE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jul 2020 09:04:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E06410056AF9;
	Tue, 14 Jul 2020 00:04:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0843910056AF5
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jul 2020 00:03:58 -0700 (PDT)
IronPort-SDR: b7v0W31mBTez32sMBaxu4s8id+P68cTKF2QLagVNudUt+dbIuX98Nv9GE04ybALksKCbaY8fz6
 RQlmUW3dk+1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136970569"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="136970569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:03:58 -0700
IronPort-SDR: tM25IeT0oQgBH5uG3/kK2J0KSx7XiyneX5daRv7CSqmQsPrqx31C4FcIseGNA7K/Pmx2qph+pY
 1rGgJw6HtyFw==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800";
   d="scan'208";a="459583331"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:03:57 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 00/15] PKS: Add Protection Keys Supervisor (PKS) support
Date: Tue, 14 Jul 2020 00:02:05 -0700
Message-Id: <20200714070220.3500839-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Message-ID-Hash: WLQUEZ5UEKPRQWZZOIDLR5A5OBOLWHI7
X-Message-ID-Hash: WLQUEZ5UEKPRQWZZOIDLR5A5OBOLWHI7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WLQUEZ5UEKPRQWZZOIDLR5A5OBOLWHI7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

This RFC series has been reviewed by Dave Hansen.

This patch set introduces a new page protection mechanism for supervisor pages,
Protection Key Supervisor (PKS) and an initial user of them, persistent memory,
PMEM.

PKS enables protections on 'domains' of supervisor pages to limit supervisor
mode access to those pages beyond the normal paging protections.  They work in
a similar fashion to user space pkeys.  Like User page pkeys (PKU), supervisor
pkeys are checked in addition to normal paging protections and Access or Writes
can be disabled via a MSR update without TLB flushes when permissions change.
A page mapping is assigned to a domain by setting a pkey in the page table
entry.

Unlike User pkeys no new instructions are added; rather WRMSR/RDMSR are used to
update the PKRS register.

XSAVE is not supported for the PKRS MSR.  To reduce software complexity the
implementation saves/restores the MSR across context switches but not during
irqs.  This is a compromise which results is a hardening of unwanted access
without absolute restriction.

For consistent behavior with current paging protections, pkey 0 is reserved and
configured to allow full access via the pkey mechanism, thus preserving the
default paging protections on mappings with the default pkey value of 0.

Other keys, (1-15) are allocated by an allocator which prepares us for key
contention from day one.  Kernel users should be prepared for the allocator to
fail either because of key exhaustion or due to PKS not being supported on the
arch and/or CPU instance.

Protecting against stray writes is particularly important for PMEM because,
unlike writes to anonymous memory, writes to PMEM persists across a reboot.
Thus data corruption could result in permanent loss of data.

The following attributes of PKS makes it perfect as a mechanism to protect PMEM
from stray access within the kernel:

   1) Fast switching of permissions
   2) Prevents access without page table manipulations
   3) Works on a per thread basis
   4) No TLB flushes required

The second half of this series thus uses the PKS mechanism to protect PMEM from
stray access.


Implementation details
----------------------

Modifications of task struct in patches:
	(x86/pks: Preserve the PKRS MSR on context switch)
	(memremap: Add zone device access protection)

Because pkey access is per-thread 2 modifications are made to the task struct.
The first is a saved copy of the MSR during context switches.  The second
reference counts access to the device domain to correctly handle kmap nesting
properly.


Maintain PKS setting in a re-entrant manner in patch:
	(memremap: Add zone device access protection)

Using local_irq_save() seems to be the safest and fastest way to maintain kmap
as re-entrant.  But there may be a better way.  spin_lock_irq() and atomic
counters were considered.  But atomic counters do not properly protect the pkey
update and spin_lock_irq() is unnecessary as the pkey protections are thread
local.  Suggestions are welcome.


The use of kmap in patch:
	(kmap: Add stray write protection for device pages)

To keep general access to PMEM pages general, we piggy back on the kmap()
interface as there are many places in the kernel who do not have, nor should be
required to have, a priori knowledge that a page is PMEM.  The modifications to
the kmap code is careful to quickly determine which pages don't require special
handling to reduce overhead for non PMEM pages.



Breakdown of patches
--------------------

Implement PKS within x86 arch:

	x86/pkeys: Create pkeys_internal.h
	x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
	x86/pks: Enable Protection Keys Supervisor (PKS)
	x86/pks: Preserve the PKRS MSR on context switch
	x86/pks: Add PKS kernel API
	x86/pks: Add a debugfs file for allocated PKS keys
	Documentation/pkeys: Update documentation for kernel pkeys
	x86/pks: Add PKS Test code

pre-req bug fixes for dax:

	fs/dax: Remove unused size parameter
	drivers/dax: Expand lock scope to cover the use of addresses

Add stray write protection to PMEM:

	memremap: Add zone device access protection
	kmap: Add stray write protection for device pages
	dax: Stray write protection for dax_direct_access()
	nvdimm/pmem: Stray write protection for pmem->virt_addr
	[dax|pmem]: Enable stray write protection

Fenghua Yu (4):
  x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
  x86/pks: Enable Protection Keys Supervisor (PKS)
  x86/pks: Add PKS kernel API
  x86/pks: Add a debugfs file for allocated PKS keys

Ira Weiny (11):
  x86/pkeys: Create pkeys_internal.h
  x86/pks: Preserve the PKRS MSR on context switch
  Documentation/pkeys: Update documentation for kernel pkeys
  x86/pks: Add PKS Test code
  fs/dax: Remove unused size parameter
  drivers/dax: Expand lock scope to cover the use of addresses
  memremap: Add zone device access protection
  kmap: Add stray write protection for device pages
  dax: Stray write protection for dax_direct_access()
  nvdimm/pmem: Stray write protection for pmem->virt_addr
  [dax|pmem]: Enable stray write protection

 Documentation/core-api/protection-keys.rst  |  81 +++-
 arch/x86/Kconfig                            |   1 +
 arch/x86/include/asm/cpufeatures.h          |   1 +
 arch/x86/include/asm/msr-index.h            |   1 +
 arch/x86/include/asm/pgtable.h              |  13 +-
 arch/x86/include/asm/pgtable_types.h        |   4 +
 arch/x86/include/asm/pkeys.h                |  43 ++
 arch/x86/include/asm/pkeys_internal.h       |  35 ++
 arch/x86/include/asm/processor.h            |  13 +
 arch/x86/include/uapi/asm/processor-flags.h |   2 +
 arch/x86/kernel/cpu/common.c                |  17 +
 arch/x86/kernel/fpu/xstate.c                |  17 +-
 arch/x86/kernel/process.c                   |  35 ++
 arch/x86/mm/fault.c                         |  16 +-
 arch/x86/mm/pkeys.c                         | 174 +++++++-
 drivers/dax/device.c                        |   2 +
 drivers/dax/super.c                         |   5 +-
 drivers/nvdimm/pmem.c                       |   6 +
 fs/dax.c                                    |  13 +-
 include/linux/highmem.h                     |  32 +-
 include/linux/memremap.h                    |   1 +
 include/linux/mm.h                          |  33 ++
 include/linux/pkeys.h                       |  18 +
 include/linux/sched.h                       |   3 +
 init/init_task.c                            |   3 +
 kernel/fork.c                               |   3 +
 lib/Kconfig.debug                           |  12 +
 lib/Makefile                                |   3 +
 lib/pks/Makefile                            |   3 +
 lib/pks/pks_test.c                          | 452 ++++++++++++++++++++
 mm/Kconfig                                  |  15 +
 mm/memremap.c                               | 111 +++++
 tools/testing/selftests/x86/Makefile        |   3 +-
 tools/testing/selftests/x86/test_pks.c      |  65 +++
 34 files changed, 1175 insertions(+), 61 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_internal.h
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
