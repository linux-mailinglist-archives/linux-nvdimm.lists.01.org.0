Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2702CC475
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Dec 2020 19:01:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3146100EBB6B;
	Wed,  2 Dec 2020 10:01:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=204.191.154.188; helo=ale.deltatee.com; envelope-from=logang@deltatee.com; receiver=<UNKNOWN> 
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 517E3100EC1CB
	for <linux-nvdimm@lists.01.org>; Wed,  2 Dec 2020 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:content-disposition;
	bh=PNgBCQ8XfFmn9D3DM+iYXdqG+oFaCFQKqsKGuaozXnM=; b=I/z1+NEbS5rhAEcJyNoJdYZjKX
	GF2BGYAtWOziMnVigqzE1eUHMglwIZi+OmM1AakjZs+Hsd+bzWcf+PlXB/NIrTjj2GlCUoWYRDZcR
	zPrHxLOH3/uzMbPUwi8F4aVw+xFx1S2W8X9T3V8IPnUoy56PN4haxXE8+yqphc/TCQmKcb8g8ZBDB
	dFrTJvFFcAG2SkWwRdgs6sezejN5wBuhZoRuXG/ncxXX65UP6Ef8E3zQkSlkTF4IEVKC8dcAdHVlK
	+xQADBoG7nV0lmFg7pnNxU24eHo65/Fy8AJIsfGoESJY8P6Q+68xlKurQ45l25yeVq2/CtZ28awXH
	iDej8pIw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <logang@deltatee.com>)
	id 1kkWRD-0003mr-EY; Wed, 02 Dec 2020 11:01:12 -0700
To: Christoph Hellwig <hch@lst.de>, Ralph Campbell <rcampbell@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de>
 <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
 <20201109091415.GC28918@lst.de>
 <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com>
 <20201202101426.GC7597@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7229bb21-7bf7-4989-e7cf-210834190693@deltatee.com>
Date: Wed, 2 Dec 2020 11:01:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202101426.GC7597@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dan.j.williams@intel.com, akpm@linux-foundation.org, shuah@kernel.org, bskeggs@redhat.com, yang.shi@linux.alibaba.com, kirill.shutemov@linux.intel.com, ziy@nvidia.com, bharata@linux.ibm.com, jgg@nvidia.com, apopple@nvidia.com, jhubbard@nvidia.com, jglisse@redhat.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, nouveau@lists.freedesktop.org, linux-mm@kvack.org, rcampbell@nvidia.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	MYRULES_FREE,NICE_REPLY_A autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private memory
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Message-ID-Hash: IZBV3OW3R25QBDCCUGB6ITZ4URJ7VCZY
X-Message-ID-Hash: IZBV3OW3R25QBDCCUGB6ITZ4URJ7VCZY
X-MailFrom: logang@deltatee.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, nouveau@lists.freedesktop.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Bharata B Rao <bharata@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Yang Shi <yang.shi@linux.alibaba.com>, Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IZBV3OW3R25QBDCCUGB6ITZ4URJ7VCZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020-12-02 3:14 a.m., Christoph Hellwig wrote:>>
MEMORY_DEVICE_PCI_P2PDMA:
>> Struct pages are created in pci_p2pdma_add_resource() and represent device
>> memory accessible by PCIe bar address space. Memory is allocated with
>> pci_alloc_p2pmem() based on a byte length but the gen_pool_alloc_owner()
>> call will allocate memory in a minimum of PAGE_SIZE units.
>> Reference counting is +1 per *allocation* on the pgmap->ref reference count.
>> Note that this is not +1 per page which is what put_page() expects. So
>> currently, a get_page()/put_page() works OK because the page reference count
>> only goes 1->2 and 2->1. If it went to zero, the pgmap->ref reference count
>> would be incorrect if the allocation size was greater than one page.
>>
>> I see pci_alloc_p2pmem() is called by nvme_alloc_sq_cmds() and
>> pci_p2pmem_alloc_sgl() to create a command queue and a struct scatterlist *.
>> Looks like sg_page(sg) returns the ZONE_DEVICE struct page of the scatterlist.
>> There are a huge number of places sg_page() is called so it is hard to tell
>> whether or not get_page()/put_page() is ever called on MEMORY_DEVICE_PCI_P2PDMA
>> pages.
> 
> Nothing should call get_page/put_page on them, as they are not treated
> as refcountable memory.  More importantly nothing is allowed to keep
> a reference longer than the time of the I/O.

Yes, right now this is safe, as Christoph notes there are no places
where these should be got/put.

But eventually we'll need to change how pci_alloc_p2pmem() works to take
references on the actual pages and allow freeing individual pages,
similar to what you suggest. This is one of the issues Jason pointed out
in my last RFC to try to pass these pages through GUP.

Logan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
