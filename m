Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109F3639EF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 06:04:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCDDC100EBBC4;
	Sun, 18 Apr 2021 21:04:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D030100EC1EE
	for <linux-nvdimm@lists.01.org>; Sun, 18 Apr 2021 21:04:51 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4FNtVn0vzJz9vGd; Mon, 19 Apr 2021 14:04:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, ellerman@au1.ibm.com, linux-nvdimm@lists.01.org, sbhat@linux.vnet.ibm.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, kvm-ppc@vger.kernel.org, aneesh.kumar@linux.ibm.com
In-Reply-To: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
References: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
Subject: Re: [PATCH v3] powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall
Message-Id: <161880478871.1398509.15555293343691434743.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:48 +1000
MIME-Version: 1.0
Message-ID-Hash: KZXOSJLJHHQ6KLX4RAJ2DGWONTOOSFRR
X-Message-ID-Hash: KZXOSJLJHHQ6KLX4RAJ2DGWONTOOSFRR
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: vaibhav@linux.ibm.com, linux-doc@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KZXOSJLJHHQ6KLX4RAJ2DGWONTOOSFRR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 29 Mar 2021 13:36:43 -0400, Shivaprasad G Bhat wrote:
> Add support for ND_REGION_ASYNC capability if the device tree
> indicates 'ibm,hcall-flush-required' property in the NVDIMM node.
> Flush is done by issuing H_SCM_FLUSH hcall to the hypervisor.
> 
> If the flush request failed, the hypervisor is expected to
> to reflect the problem in the subsequent nvdimm H_SCM_HEALTH call.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall
      https://git.kernel.org/powerpc/c/75b7c05ebf902632f7f540c3eb0a8945c2d74aab

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
