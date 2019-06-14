Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B47664512D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 03:23:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24D0121296B20;
	Thu, 13 Jun 2019 18:23:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=linux-nvdimm@lists.01.org 
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 89DB121959CB2
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 18:23:08 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d02f6fc0000>; Thu, 13 Jun 2019 18:23:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Jun 2019 18:23:08 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 18:23:08 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 01:23:04 +0000
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To: Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
Date: Thu, 13 Jun 2019 18:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1560475388; bh=NWiGQvc0UaQg06vGlx/KBoyQY7FTb90HKZp/7cWu1+4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=CCd8e2OpQNYk9MLkQj2SISKb1f8rHEt8owfBUnfdQ/EbQaEHFbssnQujsTCvu1hg/
 mR8Y3/sQ0FeoXBKw8x7EwSNeP0JirtlvLprjUK1BAmudORUfLC87dyxEeAk19INas5
 NI29MBs4mO8FUO+2r1avdCcLUMWD+OBag9RCJIoLc2O2dHRfWViTRDAYcfn3m6Wrf6
 udfy6sC0OFEAlHI5edqKIVUfELxR84G7Dkf+roQu6aKqp3E13WZ1IqDdG/Lffgeh/e
 nogIq4wl7uO95KxuzvD0ijZERk5Gr6SxTkWBIiWMnMYA0zmWut5Pf3opqWtrNeceNW
 Ua0w/eL4F+pAQ==
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Ralph Campbell <rcampbell@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 6/13/19 5:43 PM, Ira Weiny wrote:
> On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
>> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
>>>
...
>> Hum, so the only thing this config does is short circuit here:
>>
>> static inline bool is_device_public_page(const struct page *page)
>> {
>>         return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
>>                 IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
>>                 is_zone_device_page(page) &&
>>                 page->pgmap->type == MEMORY_DEVICE_PUBLIC;
>> }
>>
>> Which is called all over the place.. 
> 
> <sigh>  yes but the earlier patch:
> 
> [PATCH 03/22] mm: remove hmm_devmem_add_resource
> 
> Removes the only place type is set to MEMORY_DEVICE_PUBLIC.
> 
> So I think it is ok.  Frankly I was wondering if we should remove the public
> type altogether but conceptually it seems ok.  But I don't see any users of it
> so...  should we get rid of it in the code rather than turning the config off?
> 
> Ira

That seems reasonable. I recall that the hope was for those IBM Power 9
systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
memory, and so the memory really is visible to the CPU. And the IBM team
was thinking of taking advantage of it. But I haven't seen anything on
that front for a while.

So maybe it will get re-added as part of a future patchset to use that
kind of memory, but yes, we should not hesitate to clean house at this
point, and delete unused code.


thanks,
-- 
John Hubbard
NVIDIA

> 
>>
>> So, yes, we really don't want any distro or something to turn this on
>> until it has a use.
>>
>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>>
>> Jason
>> _______________________________________________
>> Linux-nvdimm mailing list
>> Linux-nvdimm@lists.01.org
>> https://lists.01.org/mailman/listinfo/linux-nvdimm
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
