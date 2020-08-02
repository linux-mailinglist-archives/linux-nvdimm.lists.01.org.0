Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5D235726
	for <lists+linux-nvdimm@lfdr.de>; Sun,  2 Aug 2020 15:35:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFF1612A0D0A3;
	Sun,  2 Aug 2020 06:35:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=michael@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 682B0126B7AC1
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 06:35:16 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
	id 4BKMTB0P16z9sTp; Sun,  2 Aug 2020 23:35:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
In-Reply-To: <20200731064153.182203-1-vaibhav@linux.ibm.com>
References: <20200731064153.182203-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v4 0/2] powerpc/papr_scm: add support for reporting NVDIMM 'life_used_percentage' metric
Message-Id: <159637524118.42190.10318141751963824378.b4-ty@ellerman.id.au>
Date: Sun,  2 Aug 2020 23:35:09 +1000 (AEST)
Message-ID-Hash: FIICYKLPI4B5NWWLYELP2QIJSSZDBUDR
X-Message-ID-Hash: FIICYKLPI4B5NWWLYELP2QIJSSZDBUDR
X-MailFrom: michael@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FIICYKLPI4B5NWWLYELP2QIJSSZDBUDR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2020 12:11:51 +0530, Vaibhav Jain wrote:
> Changes since v3[1]:
> 
> * Fixed a rebase issue pointed out by Aneesh in first patch in the series.
> 
> [1] https://lore.kernel.org/linux-nvdimm/20200730121303.134230-1-vaibhav@linux.ibm.com

Applied to powerpc/next.

[1/2] powerpc/papr_scm: Fetch nvdimm performance stats from PHYP
      https://git.kernel.org/powerpc/c/2d02bf835e5731de632c8a13567905fa7c0da01c
[2/2] powerpc/papr_scm: Add support for fetching nvdimm 'fuel-gauge' metric
      https://git.kernel.org/powerpc/c/af0870c4e75655b1931d0a5ffde2f448a2794362

cheers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
