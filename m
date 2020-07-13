Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0921DD0C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:36:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01CC6110ACB64;
	Mon, 13 Jul 2020 09:36:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=rcampbell@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A1CFA110ACB61
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:36:30 -0700 (PDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5f0c8d810000>; Mon, 13 Jul 2020 09:36:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 09:36:30 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 09:36:30 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 16:36:17 +0000
Subject: Re: [PATCH v2 19/22] mm/memremap_pages: Convert to 'struct range'
To: Dan Williams <dan.j.williams@intel.com>, <linux-nvdimm@lists.01.org>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <52e00a67-b686-8554-8b92-a172ba9f34b6@nvidia.com>
Date: Mon, 13 Jul 2020 09:36:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <159457126779.754248.3575056680831729751.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1594658177; bh=pEu43f6TYC38teVwUvS5veiq+jHDv/8kh2CbYzLWE6U=;
	h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=fNpeW/b9FMcDuL8oBoNL4fjzJoqpiaHBjJ5dsdIG5lrR+4Y/gb8oxeR9pNqs5p58E
	 jg/E8fTCGVG/pvYTlGNYMJ4np0poYz626qjoxbOuxMSk67Oh9xeDZjp9Dlx+JvN/yI
	 anmR/T+xHKXScxT+q/iQrtkW+yLeCbIRALu8t1RHIL23PtB5Gt3fPRk3mkNbf55HbY
	 rurMSczEzdbFa7CP+/s/hv3jIlWgQnc/l3MXL6dU1kdaK+Pru79j771P+5fyYyqL5O
	 XSYWgz3RPaAQhvk7/olB0odRYdNQkhmC2b55QRVX3q2JPs4J6+AQSE73bzRJ26O6Q9
	 P7158pxFYmDSQ==
Message-ID-Hash: U6V7CHXI52L7YA7MQV5X32SCW4LIY4BO
X-Message-ID-Hash: U6V7CHXI52L7YA7MQV5X32SCW4LIY4BO
X-MailFrom: rcampbell@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@mellanox.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U6V7CHXI52L7YA7MQV5X32SCW4LIY4BO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit


On 7/12/20 9:27 AM, Dan Williams wrote:
> The 'struct resource' in 'struct dev_pagemap' is only used for holding
> resource span information. The other fields, 'name', 'flags', 'desc',
> 'parent', 'sibling', and 'child' are all unused wasted space.
> 
> This is in preparation for introducing a multi-range extension of
> devm_memremap_pages().
> 
> The bulk of this change is unwinding all the places internal to
> libnvdimm that used 'struct resource' unnecessarily.
> 
> P2PDMA had a minor usage of the flags field, but only to report failures
> with "%pR". That is replaced with an open coded print of the range.
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   arch/powerpc/kvm/book3s_hv_uvmem.c     |   13 +++--
>   drivers/dax/bus.c                      |   10 ++--
>   drivers/dax/bus.h                      |    2 -
>   drivers/dax/dax-private.h              |    5 --
>   drivers/dax/device.c                   |    3 -
>   drivers/dax/hmem/hmem.c                |    5 ++
>   drivers/dax/pmem/core.c                |   12 ++---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c |    3 +
>   drivers/nvdimm/badrange.c              |   26 +++++------
>   drivers/nvdimm/claim.c                 |   13 +++--
>   drivers/nvdimm/nd.h                    |    3 +
>   drivers/nvdimm/pfn_devs.c              |   12 ++---
>   drivers/nvdimm/pmem.c                  |   26 ++++++-----
>   drivers/nvdimm/region.c                |   21 +++++----
>   drivers/pci/p2pdma.c                   |   11 ++---
>   include/linux/memremap.h               |    5 +-
>   include/linux/range.h                  |    6 ++
>   mm/memremap.c                          |   77 ++++++++++++++++----------------
>   tools/testing/nvdimm/test/iomap.c      |    2 -
>   19 files changed, 135 insertions(+), 120 deletions(-)

I think you are missing a call to memremap_pages() in lib/test_hmm.c
and a call to release_mem_region() that need to be converted too.
Try setting CONFIG_TEST_HMM=m.

Also, what about the call to release_mem_region() in
drivers/gpu/drm/nouveau/nouveau_dmem.c? Doesn't that need a small change too?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
