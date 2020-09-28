Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01827B50D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 21:13:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD9E313B3467B;
	Mon, 28 Sep 2020 12:13:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=boris.ostrovsky@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BEA9F13AA0757
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 12:13:03 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SJ90B3005177;
	Mon, 28 Sep 2020 19:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wL+FSbzPDyTOZYHdyTb21RdbTIUYUYpk4JKjFqxA86c=;
 b=jnhx7F4QDGM1NbmcFShUQeKxzQtv/FzNCBRIsBkwEQLErIqyQUey6TgIGFgKX7uHgxiW
 F9ni7U2s7HEgZXKtynTlY11+yJOzYADgZMp68Zihx4UrjNBV+2yr5UVpOQQPi7JEoSVv
 8FdlqPxaraU8lm2MrDyrL8VXC9W9L/bnM0kgFxIxTlvcIMfhLygVSErP/gGWHXBsLIY2
 2Hhok61N4fxmajmXTKNsRx6QuD+4ZGMQyO9HYLggNt+u6KG6uE/7XbDJRy3msKXdCMVH
 LV8sRdBZ7/vP7dW8wzdiKpkwHsgZN/Lt2pMcJyaJQSgiv5MP89H0idklvHh5b/IBP0fP SQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 33sx9mxt5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2020 19:12:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SJAOOe011172;
	Mon, 28 Sep 2020 19:12:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 33tfhwnf26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2020 19:12:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08SJCbl6008284;
	Mon, 28 Sep 2020 19:12:37 GMT
Received: from [10.74.86.78] (/10.74.86.78)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 28 Sep 2020 12:12:36 -0700
Subject: Re: [PATCH v5 10/17] mm/memremap_pages: convert to 'struct range'
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106115761.30709.13539840236873663620.stgit@dwillia2-desk3.amr.corp.intel.com>
From: boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <6186fa28-d123-12db-6171-a75cb6e615a5@oracle.com>
Date: Mon, 28 Sep 2020 15:12:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <160106115761.30709.13539840236873663620.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280146
Message-ID-Hash: 7W4AQGTJZR7ZF22YTMKPQVUO7XJRQIYR
X-Message-ID-Hash: 7W4AQGTJZR7ZF22YTMKPQVUO7XJRQIYR
X-MailFrom: boris.ostrovsky@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7W4AQGTJZR7ZF22YTMKPQVUO7XJRQIYR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 9/25/20 3:12 PM, Dan Williams wrote:
>  
> diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
> index 3b98dc921426..091b8669eca3 100644
> --- a/drivers/xen/unpopulated-alloc.c
> +++ b/drivers/xen/unpopulated-alloc.c
> @@ -18,27 +18,37 @@ static unsigned int list_count;
>  static int fill_list(unsigned int nr_pages)
>  {
>  	struct dev_pagemap *pgmap;
> +	struct resource *res;
>  	void *vaddr;
>  	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
> -	int ret;
> +	int ret = -ENOMEM;
> +
> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
>  
>  	pgmap = kzalloc(sizeof(*pgmap), GFP_KERNEL);
>  	if (!pgmap)
> -		return -ENOMEM;
> +		goto err_pgmap;
>  
>  	pgmap->type = MEMORY_DEVICE_GENERIC;


Can you move these last 5 lines ...


> -	pgmap->res.name = "Xen scratch";
> -	pgmap->res.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	res->name = "Xen scratch";
> +	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>  
> -	ret = allocate_resource(&iomem_resource, &pgmap->res,
> +	ret = allocate_resource(&iomem_resource, res,
>  				alloc_pages * PAGE_SIZE, 0, -1,
>  				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
>  	if (ret < 0) {
>  		pr_err("Cannot allocate new IOMEM resource\n");
> -		kfree(pgmap);
> -		return ret;
> +		goto err_resource;
>  	}
>  


... here, so that we deal with pgmap in the same place? The diff will be slightly larger but the code will read better I think.


-boris


> +	pgmap->range = (struct range) {
> +		.start = res->start,
> +		.end = res->end,
> +	};
> +	pgmap->owner = res;
> +
>  #ifdef CONFIG_XEN_HAVE_PVMMU
>          /*
>           * memremap will build page tables for the new memory so
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
