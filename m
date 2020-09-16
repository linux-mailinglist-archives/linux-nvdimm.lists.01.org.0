Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8B26C2FB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 14:53:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2720144BD5A2;
	Wed, 16 Sep 2020 05:53:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=47.88.44.36; helo=out4436.biz.mail.alibaba.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com [47.88.44.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EB9D6144BD5A1
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 05:53:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U97eAyT_1600260776;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97eAyT_1600260776)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 20:52:56 +0800
Date: Wed, 16 Sep 2020 20:52:56 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 8/8] hv_balloon: try to merge system ram resources
Message-ID: <20200916125256.GB48127@L-31X9LVDL-1304.local>
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-9-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911103459.10306-9-david@redhat.com>
Message-ID-Hash: YVTJATOMBSEWWCY2R4ZY25UH3HTGO2PU
X-Message-ID-Hash: YVTJATOMBSEWWCY2R4ZY25UH3HTGO2PU
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Wei Liu <wei.liu@kernel.org>, Michal Hocko <mhocko@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YVTJATOMBSEWWCY2R4ZY25UH3HTGO2PU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:34:59PM +0200, David Hildenbrand wrote:
>Let's try to merge system ram resources we add, to minimize the number
>of resources in /proc/iomem. We don't care about the boundaries of
>individual chunks we added.
>
>Reviewed-by: Wei Liu <wei.liu@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Wei Liu <wei.liu@kernel.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/hv/hv_balloon.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>index 3c0d52e244520..b64d2efbefe71 100644
>--- a/drivers/hv/hv_balloon.c
>+++ b/drivers/hv/hv_balloon.c
>@@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
> 
> 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
> 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
>-				(HA_CHUNK << PAGE_SHIFT), MHP_NONE);
>+				(HA_CHUNK << PAGE_SHIFT), MEMHP_MERGE_RESOURCE);
> 
> 		if (ret) {
> 			pr_err("hot_add memory failed error is %d\n", ret);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
