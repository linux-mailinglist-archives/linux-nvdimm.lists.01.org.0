Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3125191A29
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 20:41:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C620B10FC38B1;
	Tue, 24 Mar 2020 12:42:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C55BB10FC38B0
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 12:42:18 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OJeRMV026868;
	Tue, 24 Mar 2020 19:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SKMZ5uOK7rxqU52BlZO7Pxf90rzulk8LlemNxxJfU/U=;
 b=FfGbH6iy6YrP2iWlPBe7K/fdmbLJN0Q6DyZO7UhGNGoAFaRsQPSkZvQfcBJM4KpQc6uM
 bJqUwmAXgHnphm5hAf1MeLtiaHv8hsNnF3/WjY3xEC74BrO2T1UG1UIZGRa7OLudumGP
 Ao6pHe1jwIIGYKH8ynDIrHYcxGOkY9lwCwP/uLRKGv46nTInSYvF7FcDyjKx97FqhkhP
 YON4nrKul168SVxRVU5tFhjcutf4LNG45D++ch3m7PsWwettdYQJB3hjD1hiPV1tCV5n
 PWZjl+JrwWcM6GuM/NqiQ6oOp/UkSpqB1aauSIT3/VQFThqq7W244i8xGsR68W/FatXc hw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2yx8ac3a45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 19:41:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OJaM8T002084;
	Tue, 24 Mar 2020 19:41:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2yymbu70xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 19:41:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02OJf7QG024103;
	Tue, 24 Mar 2020 19:41:07 GMT
Received: from [10.175.222.8] (/10.175.222.8)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 24 Mar 2020 12:41:07 -0700
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each soft-reserved
 range
To: Dan Williams <dan.j.williams@intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <e9d36833-6606-da13-9dda-47abc1928273@oracle.com>
Date: Tue, 24 Mar 2020 19:41:02 +0000
MIME-Version: 1.0
In-Reply-To: <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=5
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=5 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240096
Message-ID-Hash: XXT5GT3ACYFOULNT6PWH3JUPOG5AN5RI
X-Message-ID-Hash: XXT5GT3ACYFOULNT6PWH3JUPOG5AN5RI
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XXT5GT3ACYFOULNT6PWH3JUPOG5AN5RI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/22/20 4:12 PM, Dan Williams wrote:
> The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> "soft reserved" memory as an "hmem" device")' only registered ranges to
> the hmem driver for each soft-reservation that also appeared in the
> HMAT. While this is meant to encourage platform firmware to "do the
> right thing" and publish an HMAT, the corollary is that platforms that
> fail to publish an accurate HMAT will strand memory from Linux usage.
> Additionally, the "efi_fake_mem" kernel command line option enabling
> will strand memory by default without an HMAT.
> 
> Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> to be published as raw resource ranges for the hmem driver to consume.
> 
> Include a module parameter to disable either this fallback behavior, or
> the hmat enabling from creating hmem devices. The module parameter
> requires the hmem device enabling to have unique name in the module
> namespace: "device_hmem".
> 
> Rather than mark this x86-only, include an interim phys_to_target_node()
> implementation for arm64.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/arm64/mm/numa.c      |   13 +++++++++++++
>  drivers/dax/Kconfig       |    1 +
>  drivers/dax/hmem/Makefile |    3 ++-
>  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 

[...]

> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index 99bc15a8b031..f9c5fa8b1880 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -4,6 +4,9 @@
>  #include <linux/module.h>
>  #include <linux/mm.h>
>  
> +static bool nohmem;
> +module_param_named(disable, nohmem, bool, 0444);
> +
>  void hmem_register_device(int target_nid, struct resource *r)
>  {
>  	/* define a clean / non-busy resource for the platform device */
> @@ -16,6 +19,9 @@ void hmem_register_device(int target_nid, struct resource *r)
>  	struct memregion_info info;
>  	int rc, id;
>  
> +	if (nohmem)
> +		return;
> +
>  	rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
>  			IORES_DESC_SOFT_RESERVED);
>  	if (rc != REGION_INTERSECTS)
> @@ -62,3 +68,30 @@ void hmem_register_device(int target_nid, struct resource *r)
>  out_pdev:
>  	memregion_free(id);
>  }
> +
> +static __init int hmem_register_one(struct resource *res, void *data)
> +{
> +	/*
> +	 * If the resource is not a top-level resource it was already
> +	 * assigned to a device by the HMAT parsing.
> +	 */
> +	if (res->parent != &iomem_resource)
> +		return 0;
> +
> +	hmem_register_device(phys_to_target_node(res->start), res);
> +
> +	return 0;

Should we add an error returning value to hmem_register_device() perhaps this
ought to be reflected in hmem_register_one().

> +}
> +
> +static __init int hmem_init(void)
> +{
> +	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> +			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> +	return 0;
> +}
> +

(...) and then perhaps here returning in the initcall if any of the resources
failed hmem registration?

> +/*
> + * As this is a fallback for address ranges unclaimed by the ACPI HMAT
> + * parsing it must be at an initcall level greater than hmat_init().
> + */
> +late_initcall(hmem_init);

Regardless of the nit (which ties in to patch 4), looks good. So, FWIW:

  Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

For the hmem changes.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
