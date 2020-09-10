Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80C264665
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 14:55:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B02CE13DB5420;
	Thu, 10 Sep 2020 05:55:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AA7B137E5AEC
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 05:55:38 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4BnJlV2s56z9sTt; Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>
In-Reply-To: <20200907110540.21349-1-vaibhav@linux.ibm.com>
References: <20200907110540.21349-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
Message-Id: <159974250773.1017939.2467058218314439278.b4-ty@ellerman.id.au>
Date: Thu, 10 Sep 2020 22:55:34 +1000 (AEST)
Message-ID-Hash: DPZOQQZ7CMJRFXHC3VFE4QZCQEJPNKLG
X-Message-ID-Hash: DPZOQQZ7CMJRFXHC3VFE4QZCQEJPNKLG
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPZOQQZ7CMJRFXHC3VFE4QZCQEJPNKLG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2020 16:35:40 +0530, Vaibhav Jain wrote:
> The newly introduced 'perf_stats' attribute uses the default access
> mode of 0444 letting non-root users access performance stats of an
> nvdimm and potentially force the kernel into issuing large number of
> expensive HCALLs. Since the information exposed by this attribute
> cannot be cached hence its better to ward of access to this attribute
> from users who don't need to access these performance statistics.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
      https://git.kernel.org/powerpc/c/0460534b532e5518c657c7d6492b9337d975eaa3

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
