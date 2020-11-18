Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6506B2B798B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 09:54:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA14D100EBBCB;
	Wed, 18 Nov 2020 00:54:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD341100EC1D7
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 00:54:34 -0800 (PST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cbc773fBYzLqK8;
	Wed, 18 Nov 2020 16:54:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.144) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Nov 2020
 16:54:25 +0800
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in
 nfit_handle_mce()
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown
	<lenb@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-acpi
	<linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9b8310ed-e93f-e708-eefa-520701e6d044@huawei.com>
Date: Wed, 18 Nov 2020 16:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201118084117.1937-1-thunder.leizhen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.144]
X-CFilter-Loop: Reflected
Message-ID-Hash: 3LH6URQ3APCYGIPJUTYSSP3IWALGNKWF
X-Message-ID-Hash: 3LH6URQ3APCYGIPJUTYSSP3IWALGNKWF
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3LH6URQ3APCYGIPJUTYSSP3IWALGNKWF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2020/11/18 16:41, Zhen Lei wrote:
> The badrange to be reported should always cover mce->addr.
Maybe I should change this description to:
Make sure the badrange to be reported can always cover mce->addr.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/acpi/nfit/mce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
> index ee8d9973f60b..053e719c7bea 100644
> --- a/drivers/acpi/nfit/mce.c
> +++ b/drivers/acpi/nfit/mce.c
> @@ -63,7 +63,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>  
>  		/* If this fails due to an -ENOMEM, there is little we can do */
>  		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
> -				ALIGN(mce->addr, L1_CACHE_BYTES),
> +				ALIGN_DOWN(mce->addr, L1_CACHE_BYTES),
>  				L1_CACHE_BYTES);
>  		nvdimm_region_notify(nfit_spa->nd_region,
>  				NVDIMM_REVALIDATE_POISON);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
