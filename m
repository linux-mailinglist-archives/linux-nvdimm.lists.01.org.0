Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5E10DFD0
	for <lists+linux-nvdimm@lfdr.de>; Sun,  1 Dec 2019 00:13:21 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C57510113516;
	Sat, 30 Nov 2019 15:16:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD4B91011330D
	for <linux-nvdimm@lists.01.org>; Sat, 30 Nov 2019 15:16:40 -0800 (PST)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B334F20725;
	Sat, 30 Nov 2019 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155597;
	bh=KjTRgnnKv5nRR0iakt1HRuFDQSVpEM0jTzxlSBvTBzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOymBJ9AgRdskRjuRDNogI8A5WERX5ISlUGpJ0YX3tGkEGLb4lLM0tzyxrNkaUyyn
	 1yoKizlJnBu35IG52Q95jfxG1uEg68cySzFVH2nHBTG2h5S2nduj2ROZRCGCePkW2v
	 bYpxF7H978SAcf2TJrm1Tzx2ftDTpzM1ZxWblJPc=
Date: Sat, 30 Nov 2019 15:13:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at
 first pfn from a region
Message-Id: <20191130151317.26c69ef711dba28ff642cca3@linux-foundation.org>
In-Reply-To: <8736glowyh.fsf@linux.ibm.com>
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
	<20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
	<8736glowyh.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: S52KFH5CCWEFRNNZTVKADTHM2WGH6255
X-Message-ID-Hash: S52KFH5CCWEFRNNZTVKADTHM2WGH6255
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S52KFH5CCWEFRNNZTVKADTHM2WGH6255/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 25 Sep 2019 09:21:02 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Tue, 17 Sep 2019 21:01:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >
> >> vmem_altmap_offset() adjust the section aligned base_pfn offset.
> >> So we need to make sure we account for the same when computing base_pfn.
> >> 
> >> ie, for altmap_valid case, our pfn_first should be:
> >> 
> >> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
> >
> > What are the user-visible runtime effects of this change?
> 
> This was found by code inspection. If the pmem region is not correctly
> section aligned we can skip pfns while iterating device pfn using 
> 	for_each_device_pfn(pfn, pgmap)
> 
> 
> I still would want Dan to ack the change though.
> 

Dan?


From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: mm/pgmap: use correct alignment when looking at first pfn from a region

vmem_altmap_offset() adjusts the section aligned base_pfn offset.  So we
need to make sure we account for the same when computing base_pfn.

ie, for altmap_valid case, our pfn_first should be:

pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);

This was found by code inspection. If the pmem region is not correctly
section aligned we can skip pfns while iterating device pfn using 

	for_each_device_pfn(pfn, pgmap)

[akpm@linux-foundation.org: coding style fixes]
Link: http://lkml.kernel.org/r/20190917153129.12905-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memremap.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/mm/memremap.c~mm-pgmap-use-correct-alignment-when-looking-at-first-pfn-from-a-region
+++ a/mm/memremap.c
@@ -55,8 +55,16 @@ static void pgmap_array_delete(struct re
 
 static unsigned long pfn_first(struct dev_pagemap *pgmap)
 {
-	return PHYS_PFN(pgmap->res.start) +
-		vmem_altmap_offset(pgmap_altmap(pgmap));
+	const struct resource *res = &pgmap->res;
+	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
+	unsigned long pfn;
+
+	if (altmap)
+		pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+	else
+		pfn = PHYS_PFN(res->start);
+
+	return pfn;
 }
 
 static unsigned long pfn_end(struct dev_pagemap *pgmap)
_
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
