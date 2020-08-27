Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ABC253DD4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 08:35:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D1FD1252DA94;
	Wed, 26 Aug 2020 23:35:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40F381252CC93
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 23:35:22 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 73AE2A05E37D5DB2E6B2;
	Thu, 27 Aug 2020 14:35:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:35:15 +0800
Subject: Re: [PATCH v3 0/7] bugfix and optimize for drivers/nvdimm
To: Oliver O'Halloran <oohall@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, Markus
 Elfring <Markus.Elfring@web.de>, linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <90d93e2e-1124-22ee-81fb-83ffebc3129c@huawei.com>
Date: Thu, 27 Aug 2020 14:35:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200820021641.3188-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: NGMETAL2EZ2GA6NCGBHOSHCBAWTFVAHH
X-Message-ID-Hash: NGMETAL2EZ2GA6NCGBHOSHCBAWTFVAHH
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NGMETAL2EZ2GA6NCGBHOSHCBAWTFVAHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi all:
  Any comment? I want to merge patches 1 and 2 into one, then send
other patches separately.

On 2020/8/20 10:16, Zhen Lei wrote:
> v2 --> v3:
> 1. Fix spelling error of patch 1 subject: memmory --> memory
> 2. Add "Reviewed-by: Oliver O'Halloran <oohall@gmail.com>" into patch 1
> 3. Rewrite patch descriptions of Patch 1, 3, 4
> 4. Add 3 new trivial patches 5-7, I just found that yesterday.
> 5. Unify all "subsystem" names to "libnvdimm:"
> 
> v1 --> v2:
> 1. Add Fixes for Patch 1-2
> 2. Slightly change the subject and description of Patch 1
> 3. Add a new trivial Patch 4, I just found that yesterday.
> 
> v1:
> I found a memleak when I learned the drivers/nvdimm code today. And I also
> added a sanity check for priv->bus_desc.provider_name, because strdup()
> maybe failed. Patch 3 is a trivial source code optimization.
> 
> 
> Zhen Lei (7):
>   libnvdimm: fix memory leaks in of_pmem.c
>   libnvdimm: add sanity check for provider_name in
>     of_pmem_region_probe()
>   libnvdimm: simplify walk_to_nvdimm_bus()
>   libnvdimm: reduce an unnecessary if branch in nd_region_create()
>   libnvdimm: reduce an unnecessary if branch in nd_region_activate()
>   libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush) close to its
>     function
>   libnvdimm: slightly simplify available_slots_show()
> 
>  drivers/nvdimm/bus.c         |  7 +++----
>  drivers/nvdimm/dimm_devs.c   |  5 ++---
>  drivers/nvdimm/of_pmem.c     |  7 +++++++
>  drivers/nvdimm/region_devs.c | 13 ++++---------
>  4 files changed, 16 insertions(+), 16 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
