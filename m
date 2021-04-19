Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1E3639F1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 06:05:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4C1F100EBB6A;
	Sun, 18 Apr 2021 21:05:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7F98100EBB62
	for <linux-nvdimm@lists.01.org>; Sun, 18 Apr 2021 21:05:04 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4FNtVv4RKdz9vHq; Mon, 19 Apr 2021 14:04:39 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210404163148.321346-1-vaibhav@linux.ibm.com>
References: <20210404163148.321346-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/mm: Add cond_resched() while removing hpte mappings
Message-Id: <161880478898.1398509.10526534460384650101.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:48 +1000
MIME-Version: 1.0
Message-ID-Hash: PRWA67HN5Z4YDYJ4NCGUZ5YH4FPOHT37
X-Message-ID-Hash: PRWA67HN5Z4YDYJ4NCGUZ5YH4FPOHT37
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PRWA67HN5Z4YDYJ4NCGUZ5YH4FPOHT37/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 4 Apr 2021 22:01:48 +0530, Vaibhav Jain wrote:
> While removing large number of mappings from hash page tables for
> large memory systems as soft-lockup is reported because of the time
> spent inside htap_remove_mapping() like one below:
> 
>  watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
>  <snip>
>  NIP plpar_hcall+0x38/0x58
>  LR  pSeries_lpar_hpte_invalidate+0x68/0xb0
>  Call Trace:
>   0x1fffffffffff000 (unreliable)
>   pSeries_lpar_hpte_removebolted+0x9c/0x230
>   hash__remove_section_mapping+0xec/0x1c0
>   remove_section_mapping+0x28/0x3c
>   arch_remove_memory+0xfc/0x150
>   devm_memremap_pages_release+0x180/0x2f0
>   devm_action_release+0x30/0x50
>   release_nodes+0x28c/0x300
>   device_release_driver_internal+0x16c/0x280
>   unbind_store+0x124/0x170
>   drv_attr_store+0x44/0x60
>   sysfs_kf_write+0x64/0x90
>   kernfs_fop_write+0x1b0/0x290
>   __vfs_write+0x3c/0x70
>   vfs_write+0xd4/0x270
>   ksys_write+0xdc/0x130
>   system_call+0x5c/0x70
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Add cond_resched() while removing hpte mappings
      https://git.kernel.org/powerpc/c/a5d6a3e73acbd619dd5b7b831762b755f9e2db80

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
