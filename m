Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7E2899A0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 22:18:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED2FA159A284F;
	Fri,  9 Oct 2020 13:18:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DA4D159A284F
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 13:18:25 -0700 (PDT)
IronPort-SDR: f/cmFqGaPeLmW8E5HkWZVCGRTg8TMrrR7YpzMvZKxDPXdn0CcpsyKuoxa9V1YCOfNAcoXXBz5e
 54RUND6E/SWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="145399978"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="145399978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:18:25 -0700
IronPort-SDR: EPIUO6Sq8Ni44u09CTNBCky6tlBQ3tCFyV5bqnAJ9cDrxp+dSvLhEAuIf8hRZbdCSG1SROpCwp
 0Z4ffgAZVLlQ==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="354973816"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:18:24 -0700
Date: Fri, 9 Oct 2020 13:18:24 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V3 0/9] PKS: Add Protection Keys Supervisor (PKS)
 support RFC v3
Message-ID: <20201009201824.GW2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: M5BVLUOIOWRWM5JWH2OEAZJN2UPVX5NK
X-Message-ID-Hash: M5BVLUOIOWRWM5JWH2OEAZJN2UPVX5NK
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M5BVLUOIOWRWM5JWH2OEAZJN2UPVX5NK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 12:42:49PM -0700, 'Ira Weiny' wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> This RFC series has been reviewed by Dave Hansen.
> 
> Introduce a new page protection mechanism for supervisor pages, Protection Key
> Supervisor (PKS).
> 
> 2 use cases for PKS are being developed, trusted keys and PMEM.

RFC patch sets for these use cases have also been posted:

PMEM:
https://lore.kernel.org/lkml/20201009195033.3208459-1-ira.weiny@intel.com/

Trusted Keys:
https://lore.kernel.org/lkml/20201009201410.3209180-1-ira.weiny@intel.com/

Ira

> Trusted keys
> is a newer use case which is still being explored.  PMEM was submitted as part
> of the RFC (v2) series[1].  However, since then it was found that some callers
> of kmap() require a global implementation of PKS.  Specifically some users of
> kmap() expect mappings to be available to all kernel threads.  While global use
> of PKS is rare it needs to be included for correctness.  Unfortunately the
> kmap() updates required a large patch series to make the needed changes at the
> various kmap() call sites so that patch set has been split out.  Because the
> global PKS feature is only required for that use case it will be deferred to
> that set as well.[2]  This patch set is being submitted as a precursor to both
> of the use cases.
> 
> For an overview of the entire PKS ecosystem, a git tree including this series
> and the 2 use cases can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/pks-rfc-v3
> 
> 
> PKS enables protections on 'domains' of supervisor pages to limit supervisor
> mode access to those pages beyond the normal paging protections.  PKS works in
> a similar fashion to user space pkeys, PKU.  As with PKU, supervisor pkeys are
> checked in addition to normal paging protections and Access or Writes can be
> disabled via a MSR update without TLB flushes when permissions change.  Also
> like PKU, a page mapping is assigned to a domain by setting pkey bits in the
> page table entry for that mapping.
> 
> Access is controlled through a PKRS register which is updated via WRMSR/RDMSR.
> 
> XSAVE is not supported for the PKRS MSR.  Therefore the implementation
> saves/restores the MSR across context switches and during exceptions.  Nested
> exceptions are supported by each exception getting a new PKS state.
> 
> For consistent behavior with current paging protections, pkey 0 is reserved and
> configured to allow full access via the pkey mechanism, thus preserving the
> default paging protections on mappings with the default pkey value of 0.
> 
> Other keys, (1-15) are allocated by an allocator which prepares us for key
> contention from day one.  Kernel users should be prepared for the allocator to
> fail either because of key exhaustion or due to PKS not being supported on the
> arch and/or CPU instance.
> 
> The following are key attributes of PKS.
> 
>    1) Fast switching of permissions
> 	1a) Prevents access without page table manipulations
> 	1b) No TLB flushes required
>    2) Works on a per thread basis
> 
> PKS is available with 4 and 5 level paging.  Like PKRU it consumes 4 bits from
> the PTE to store the pkey within the entry.
> 
> 
> [1] https://lore.kernel.org/lkml/20200717072056.73134-1-ira.weiny@intel.com/
> [2] https://github.com/weiny2/linux-kernel/commit/f10abb0f0d7b4e14f03fc8890313a5830cde1e49
> 	and a testing patch
>     https://github.com/weiny2/linux-kernel/commit/2a8e0fc7654a7c69b243d628f63b01ff26a5a797
> 
> 
> Fenghua Yu (3):
>   x86/fpu: Refactor arch_set_user_pkey_access() for PKS support
>   x86/pks: Enable Protection Keys Supervisor (PKS)
>   x86/pks: Add PKS kernel API
> 
> Ira Weiny (6):
>   x86/pkeys: Create pkeys_common.h
>   x86/pks: Preserve the PKRS MSR on context switch
>   x86/entry: Pass irqentry_state_t by reference
>   x86/entry: Preserve PKRS MSR across exceptions
>   x86/fault: Report the PKRS state on fault
>   x86/pks: Add PKS test code
> 
>  Documentation/core-api/protection-keys.rst  | 102 ++-
>  arch/x86/Kconfig                            |   1 +
>  arch/x86/entry/common.c                     |  57 +-
>  arch/x86/include/asm/cpufeatures.h          |   1 +
>  arch/x86/include/asm/idtentry.h             |  29 +-
>  arch/x86/include/asm/msr-index.h            |   1 +
>  arch/x86/include/asm/pgtable.h              |  13 +-
>  arch/x86/include/asm/pgtable_types.h        |  12 +
>  arch/x86/include/asm/pkeys.h                |  15 +
>  arch/x86/include/asm/pkeys_common.h         |  36 +
>  arch/x86/include/asm/processor.h            |  13 +
>  arch/x86/include/uapi/asm/processor-flags.h |   2 +
>  arch/x86/kernel/cpu/common.c                |  17 +
>  arch/x86/kernel/cpu/mce/core.c              |   4 +
>  arch/x86/kernel/fpu/xstate.c                |  22 +-
>  arch/x86/kernel/kvm.c                       |   4 +-
>  arch/x86/kernel/nmi.c                       |   7 +-
>  arch/x86/kernel/process.c                   |  21 +
>  arch/x86/kernel/traps.c                     |  21 +-
>  arch/x86/mm/fault.c                         |  86 ++-
>  arch/x86/mm/pkeys.c                         | 188 +++++-
>  include/linux/entry-common.h                |  19 +-
>  include/linux/pgtable.h                     |   4 +
>  include/linux/pkeys.h                       |  23 +-
>  kernel/entry/common.c                       |  28 +-
>  lib/Kconfig.debug                           |  12 +
>  lib/Makefile                                |   3 +
>  lib/pks/Makefile                            |   3 +
>  lib/pks/pks_test.c                          | 690 ++++++++++++++++++++
>  mm/Kconfig                                  |   2 +
>  tools/testing/selftests/x86/Makefile        |   3 +-
>  tools/testing/selftests/x86/test_pks.c      |  65 ++
>  32 files changed, 1376 insertions(+), 128 deletions(-)
>  create mode 100644 arch/x86/include/asm/pkeys_common.h
>  create mode 100644 lib/pks/Makefile
>  create mode 100644 lib/pks/pks_test.c
>  create mode 100644 tools/testing/selftests/x86/test_pks.c
> 
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
