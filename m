Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E42222F8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 14:55:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 473D011BDEE28;
	Thu, 16 Jul 2020 05:55:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0471A11BDEE28
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 05:55:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4B6vPN72sbz9sT6; Thu, 16 Jul 2020 22:55:35 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200701072235.223558-1-aneesh.kumar@linux.ibm.com>
References: <20200701072235.223558-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v7 0/7] Support new pmem flush and sync instructions for POWER
Message-Id: <159490400978.3805857.6795731746331049712.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:55:35 +1000 (AEST)
Message-ID-Hash: GTBIK4YRJAHVO4VN6V7ZQVCY3EXZSOCE
X-Message-ID-Hash: GTBIK4YRJAHVO4VN6V7ZQVCY3EXZSOCE
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: msuchanek@suse.de, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GTBIK4YRJAHVO4VN6V7ZQVCY3EXZSOCE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 1 Jul 2020 12:52:28 +0530, Aneesh Kumar K.V wrote:
> This patch series enables the usage os new pmem flush and sync instructions on POWER
> architecture. POWER10 introduces two new variants of dcbf instructions (dcbstps and dcbfps)
> that can be used to write modified locations back to persistent storage. Additionally,
> POWER10 also introduce phwsync and plwsync which can be used to establish order of these
> writes to persistent storage.
> 
> This series exposes these instructions to the rest of the kernel. The existing
> dcbf and hwsync instructions in P8 and P9 are adequate to enable appropriate
> synchronization with OpenCAPI-hosted persistent storage. Hence the new instructions
> are added as a variant of the old ones that old hardware won't differentiate.
> 
> [...]

Applied to powerpc/next.

[1/7] powerpc/pmem: Restrict papr_scm to P8 and above.
      https://git.kernel.org/powerpc/c/c83040192f3763b243ece26073d61a895b4a230f
[2/7] powerpc/pmem: Add new instructions for persistent storage and sync
      https://git.kernel.org/powerpc/c/32db09d992ddc7d145595cff49cccfe14e018266
[3/7] powerpc/pmem: Add flush routines using new pmem store and sync instruction
      https://git.kernel.org/powerpc/c/d358042793183a57094dac45a44116e1165ac593
[4/7] libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier
      https://git.kernel.org/powerpc/c/3e79f082ebfc130360bcee23e4dd74729dcafdf4
[5/7] powerpc/pmem: Update ppc64 to use the new barrier instruction.
      https://git.kernel.org/powerpc/c/76e6c73f33d4e1cc4de4f25c0bf66d59e42113c4
[6/7] powerpc/pmem: Avoid the barrier in flush routines
      https://git.kernel.org/powerpc/c/436499ab868f1a9e497cfdbf641affe8a122c571
[7/7] powerpc/pmem: Initialize pmem device on newer hardware
      https://git.kernel.org/powerpc/c/8c26ab72663b4affc31e47cdf77d61d0172d1033

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
