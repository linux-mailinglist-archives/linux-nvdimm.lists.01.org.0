Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288A26A180
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 11:06:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85EA013D9A803;
	Tue, 15 Sep 2020 02:06:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1635F13D9A801
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 02:06:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U90pcMF_1600160772;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U90pcMF_1600160772)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 17:06:12 +0800
Date: Tue, 15 Sep 2020 17:06:12 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/7] kernel/resource: make
 release_mem_region_adjustable() never fail
Message-ID: <20200915090612.GA6936@L-31X9LVDL-1304.local>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-2-david@redhat.com>
 <20200915021012.GC2007@L-31X9LVDL-1304.local>
 <927904b1-1909-f11f-483e-8012bda8ad0c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <927904b1-1909-f11f-483e-8012bda8ad0c@redhat.com>
Message-ID-Hash: 5BOE6CLHPXUUDLSZKW6466EOED3ZYVG3
X-Message-ID-Hash: 5BOE6CLHPXUUDLSZKW6466EOED3ZYVG3
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5BOE6CLHPXUUDLSZKW6466EOED3ZYVG3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 15, 2020 at 09:35:30AM +0200, David Hildenbrand wrote:
>
>>> static int __ref try_remove_memory(int nid, u64 start, u64 size)
>>> {
>>> 	int rc = 0;
>>> @@ -1777,7 +1757,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>>> 		memblock_remove(start, size);
>>> 	}
>>>
>>> -	__release_memory_resource(start, size);
>>> +	release_mem_region_adjustable(&iomem_resource, start, size);
>>>
>> 
>> Seems the only user of release_mem_region_adjustable() is here, can we move
>> iomem_resource into the function body? Actually, we don't iterate the resource
>> tree from any level. We always start from the root.
>
>You mean, making iomem_resource implicit? I can spot that something
>similar was done for
>
>#define devm_release_mem_region(dev, start, n) \
>	__devm_release_region(dev, &iomem_resource, (start), (n))
>

What I prefer is remove iomem_resource from the parameter list. Just use is in
the function body.

For the example you listed, __release_region() would have varies of *parent*,
which looks reasonable to keep it here.

>I'll send an addon patch for that, ok? - thanks.
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
