Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F736EBCE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 16:03:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CFC1100EBBC4;
	Thu, 29 Apr 2021 07:03:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D411B100ED4A4
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 07:02:58 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4FWHJZ0GBWz9tk3; Fri, 30 Apr 2021 00:02:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210329113103.476760-1-vaibhav@linux.ibm.com>
References: <20210329113103.476760-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Mark nvdimm as unarmed if needed during probe
Message-Id: <161970488717.4033873.11862743130806736936.b4-ty@ellerman.id.au>
Date: Fri, 30 Apr 2021 00:01:27 +1000
MIME-Version: 1.0
Message-ID-Hash: M3PXS4DIJUS766N34MMGA6MO5JSVQO75
X-Message-ID-Hash: M3PXS4DIJUS766N34MMGA6MO5JSVQO75
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M3PXS4DIJUS766N34MMGA6MO5JSVQO75/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 29 Mar 2021 17:01:03 +0530, Vaibhav Jain wrote:
> In case an nvdimm is found to be unarmed during probe then set its
> NDD_UNARMED flag before nvdimm_create(). This would enforce a
> read-only access to the ndimm region. Presently even if an nvdimm is
> unarmed its not marked as read-only on ppc64 guests.
> 
> The patch updates papr_scm_nvdimm_init() to force query of nvdimm
> health via __drc_pmem_query_health() and if nvdimm is found to be
> unarmed then set the nvdimm flag ND_UNARMED for nvdimm_create().

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Mark nvdimm as unarmed if needed during probe
      https://git.kernel.org/powerpc/c/adb68c38d8d49a3d60805479c558649bb2182473

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
