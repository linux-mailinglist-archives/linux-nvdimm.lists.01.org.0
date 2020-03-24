Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F2191A28
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 20:41:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AAA9210FC38AD;
	Tue, 24 Mar 2020 12:42:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 465A310FC36CB
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 12:42:11 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OJdNPh042081;
	Tue, 24 Mar 2020 19:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BZzap9FVuyDYIypnbSWDj1Vek14C/oGZFl+aBV8YV2Q=;
 b=EKQoR2ZPqaOILHUEkRj/JaEZDYHr+onN99cpAwXTtuS4GtKgCyZVEiClwQCa2AD1w5AA
 /CGSaJYsyhAIreyRQ4FHpZJhK0N6RUgVmIGS4F7QFs0GWLKshYVp2zMUkJboYJ48z118
 IFyiR5MSp/Fp2yTXXbXloliSvGjWTIE5jJMQKqqr5D5LhxwVXr0mQAl3YJJaC8BIioIr
 3S87gnJzvzIx1CQ0kvYYWbuDopqVh1ljChzuxfWCoe7vE+hERQdhbsixxWnpIPdyMMle
 ID5+DAhRcw6LEJ4OKDd3Z+0bTDa/6GbyrVvcJ9KVSaSmWPCfO+aqaTSV2EIhbDZwtzWf Jg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2ywabr6bp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 19:41:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OJaYgH002660;
	Tue, 24 Mar 2020 19:41:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2yymbu70s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 19:41:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02OJf0C8004475;
	Tue, 24 Mar 2020 19:41:00 GMT
Received: from [10.175.222.8] (/10.175.222.8)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 24 Mar 2020 12:41:00 -0700
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 4/6] ACPI: HMAT: Refactor hmat_register_target_device
 to hmem_register_device
To: Dan Williams <dan.j.williams@intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489356692.1457606.1858427908360761594.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <f964eb62-5bc9-7e85-5c44-9027a6c08d4c@oracle.com>
Date: Tue, 24 Mar 2020 19:40:56 +0000
MIME-Version: 1.0
In-Reply-To: <158489356692.1457606.1858427908360761594.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240096
Message-ID-Hash: O5UK5V2QTSDZ2AEHQ32Y547TA2GPQC7W
X-Message-ID-Hash: O5UK5V2QTSDZ2AEHQ32Y547TA2GPQC7W
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O5UK5V2QTSDZ2AEHQ32Y547TA2GPQC7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 3/22/20 4:12 PM, Dan Williams wrote:
> In preparation for exposing "Soft Reserved" memory ranges without an
> HMAT, move the hmem device registration to its own compilation unit and
> make the implementation generic.
> 
> The generic implementation drops usage acpi_map_pxm_to_online_node()
> that was translating ACPI proximity domain values and instead relies on
> numa_map_to_online_node() to determine the numa node for the device.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
>  drivers/dax/Kconfig       |    4 +++
>  drivers/dax/Makefile      |    3 +-
>  drivers/dax/hmem.c        |   56 -------------------------------------
>  drivers/dax/hmem/Makefile |    5 +++
>  drivers/dax/hmem/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dax/hmem/hmem.c   |   56 +++++++++++++++++++++++++++++++++++++
>  include/linux/dax.h       |    8 +++++
>  8 files changed, 144 insertions(+), 120 deletions(-)
>  delete mode 100644 drivers/dax/hmem.c
>  create mode 100644 drivers/dax/hmem/Makefile
>  create mode 100644 drivers/dax/hmem/device.c
>  create mode 100644 drivers/dax/hmem/hmem.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index a12e36a12618..134bcb40b2af 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -24,6 +24,7 @@
>  #include <linux/mutex.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
> +#include <linux/dax.h>
>  
>  static u8 hmat_revision;
>  static int hmat_disable __initdata;
> @@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
>  	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
>  }
>  
> -static void hmat_register_target_device(struct memory_target *target,
          ^^^^ int ?

> -		struct resource *r)
> -{
> -	/* define a clean / non-busy resource for the platform device */
> -	struct resource res = {
> -		.start = r->start,
> -		.end = r->end,
> -		.flags = IORESOURCE_MEM,
> -	};
> -	struct platform_device *pdev;
> -	struct memregion_info info;
> -	int rc, id;
> -
> -	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> -			IORES_DESC_SOFT_RESERVED);
> -	if (rc != REGION_INTERSECTS)
> -		return;
		^ return -ENXIO;

> -
> -	id = memregion_alloc(GFP_KERNEL);
> -	if (id < 0) {
> -		pr_err("memregion allocation failure for %pr\n", &res);
> -		return;
		^ return -ENOMEM;

> -	}
> -
> -	pdev = platform_device_alloc("hmem", id);
> -	if (!pdev) {

		rc = -ENOMEM;

> -		pr_err("hmem device allocation failure for %pr\n", &res);
> -		goto out_pdev;
> -	}
> -
> -	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> -	info = (struct memregion_info) {
> -		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
> -	};
> -	rc = platform_device_add_data(pdev, &info, sizeof(info));
> -	if (rc < 0) {
> -		pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> -		goto out_pdev;
> -	}
> -
> -	rc = platform_device_add_resources(pdev, &res, 1);
> -	if (rc < 0) {
> -		pr_err("hmem resource allocation failure for %pr\n", &res);
> -		goto out_resource;
> -	}
> -
> -	rc = platform_device_add(pdev);
> -	if (rc < 0) {
> -		dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> -		goto out_resource;
> -	}
> -
> -	return;
	^^^^^^ return 0;
> -
> -out_resource:
> -	put_device(&pdev->dev);
> -out_pdev:
> -	memregion_free(id);

	return rc;

> -}
> -
>  static void hmat_register_target_devices(struct memory_target *target)
>  {
>  	struct resource *res;
> @@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
>  	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>  		return;
>  
> -	for (res = target->memregions.child; res; res = res->sibling)
> -		hmat_register_target_device(target, res);
> +	for (res = target->memregions.child; res; res = res->sibling) {
> +		int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
> +
> +		hmem_register_device(target_nid, res);
> +	}
>  }
>  

If it makes sense to propagate error to hmem_register_device (as noted above),
then here perhaps a pr_err() if hmem registration fails mainly for reporting
purposes?

Regardless of the error nits, looks good overall. So, for what is worth:

  Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
