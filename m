Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160926DA23
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 13:28:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BC4E13D293F0;
	Thu, 17 Sep 2020 04:27:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F84114E914BD
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 04:27:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4BsZSm0v03z9sVh; Thu, 17 Sep 2020 21:27:36 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>
In-Reply-To: <20200912081451.66225-1-vaibhav@linux.ibm.com>
References: <20200912081451.66225-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Fix warning triggered by perf_stats_show()
Message-Id: <160034201769.3339803.11310136880935913841.b4-ty@ellerman.id.au>
Date: Thu, 17 Sep 2020 21:27:36 +1000 (AEST)
Message-ID-Hash: 2U3A3NJIAJLSA2VWYRFVWWWVDRSLZDY7
X-Message-ID-Hash: 2U3A3NJIAJLSA2VWYRFVWWWVDRSLZDY7
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2U3A3NJIAJLSA2VWYRFVWWWVDRSLZDY7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2020 13:44:51 +0530, Vaibhav Jain wrote:
> A warning is reported by the kernel in case perf_stats_show() returns
> an error code. The warning is of the form below:
> 
>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>  	  Failed to query performance stats, Err:-10
>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Fix warning triggered by perf_stats_show()
      https://git.kernel.org/powerpc/c/ca78ef2f08ccfa29b711d644964cdf9d7ace15e5

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
