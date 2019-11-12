Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B4F8ED8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:46:01 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79E9D100DC409;
	Tue, 12 Nov 2019 03:47:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED9C6100DC408
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:47:44 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBelmr106829;
	Tue, 12 Nov 2019 06:45:48 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7shnx22v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:45:48 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xACBeqhW106999;
	Tue, 12 Nov 2019 06:45:47 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7shnx227-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:45:47 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBipeO017293;
	Tue, 12 Nov 2019 11:45:50 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma01wdc.us.ibm.com with ESMTP id 2w5n36e759-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:45:50 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBjjvQ53412308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:45:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7B5112063;
	Tue, 12 Nov 2019 11:45:44 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFF2D112062;
	Tue, 12 Nov 2019 11:45:39 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:45:39 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 05/16] libnvdimm: Move nd_region_attribute_group to device_type
In-Reply-To: <157309902169.1582359.16828508538444551337.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309902169.1582359.16828508538444551337.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:15:36 +0530
Message-ID: <87zhh1s4gv.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120106
Message-ID-Hash: DBQVDMPBW4LFCPUVC3CQNS6BMSGALHQP
X-Message-ID-Hash: DBQVDMPBW4LFCPUVC3CQNS6BMSGALHQP
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DBQVDMPBW4LFCPUVC3CQNS6BMSGALHQP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> A 'struct device_type' instance can carry default attributes for the
> device. Use this facility to remove the export of
> nd_region_attribute_group and put the responsibility on the core rather
> than leaf implementations to define this attribute.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |    1 -
>  drivers/acpi/nfit/core.c                  |    1 -
>  drivers/nvdimm/e820.c                     |    6 ------
>  drivers/nvdimm/of_pmem.c                  |    6 ------
>  drivers/nvdimm/region_devs.c              |    4 ++--
>  include/linux/libnvdimm.h                 |    1 -
>  6 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 6ffda03a6349..6428834d7cd5 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -285,7 +285,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  }
>  
>  static const struct attribute_group *region_attr_groups[] = {
> -	&nd_region_attribute_group,
>  	&nd_mapping_attribute_group,
>  	NULL,
>  };
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index b3213faf37b5..99e20b8b6ea0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2196,7 +2196,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
>  };
>  
>  static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
> -	&nd_region_attribute_group,
>  	&nd_mapping_attribute_group,
>  	&acpi_nfit_region_attribute_group,
>  	NULL,
> diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
> index adde2864c6a4..9a971a59dec7 100644
> --- a/drivers/nvdimm/e820.c
> +++ b/drivers/nvdimm/e820.c
> @@ -13,11 +13,6 @@ static const struct attribute_group *e820_pmem_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static const struct attribute_group *e820_pmem_region_attribute_groups[] = {
> -	&nd_region_attribute_group,
> -	NULL,
> -};
> -
>  static int e820_pmem_remove(struct platform_device *pdev)
>  {
>  	struct nvdimm_bus *nvdimm_bus = platform_get_drvdata(pdev);
> @@ -45,7 +40,6 @@ static int e820_register_one(struct resource *res, void *data)
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>  	ndr_desc.res = res;
> -	ndr_desc.attr_groups = e820_pmem_region_attribute_groups;
>  	ndr_desc.numa_node = e820_range_to_nid(res->start);
>  	ndr_desc.target_node = ndr_desc.numa_node;
>  	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 41348fa6b74c..c0b5ac36df9d 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -9,11 +9,6 @@
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
>  
> -static const struct attribute_group *region_attr_groups[] = {
> -	&nd_region_attribute_group,
> -	NULL,
> -};
> -
>  static const struct attribute_group *bus_attr_groups[] = {
>  	&nvdimm_bus_attribute_group,
>  	NULL,
> @@ -65,7 +60,6 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  		 * structures so passing a stack pointer is fine.
>  		 */
>  		memset(&ndr_desc, 0, sizeof(ndr_desc));
> -		ndr_desc.attr_groups = region_attr_groups;
>  		ndr_desc.numa_node = dev_to_node(&pdev->dev);
>  		ndr_desc.target_node = ndr_desc.numa_node;
>  		ndr_desc.res = &pdev->resource[i];
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index e4281f806adc..f97166583294 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -757,14 +757,14 @@ struct attribute_group nd_mapping_attribute_group = {
>  };
>  EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
>  
> -struct attribute_group nd_region_attribute_group = {
> +static const struct attribute_group nd_region_attribute_group = {
>  	.attrs = nd_region_attributes,
>  	.is_visible = region_visible,
>  };
> -EXPORT_SYMBOL_GPL(nd_region_attribute_group);
>  
>  static const struct attribute_group *nd_region_attribute_groups[] = {
>  	&nd_device_attribute_group,
> +	&nd_region_attribute_group,
>  	&nd_numa_attribute_group,
>  	NULL,
>  };
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index e9a4e25fc708..312248d334c7 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -67,7 +67,6 @@ enum {
>  
>  extern struct attribute_group nvdimm_bus_attribute_group;
>  extern struct attribute_group nvdimm_attribute_group;
> -extern struct attribute_group nd_region_attribute_group;
>  extern struct attribute_group nd_mapping_attribute_group;
>  
>  struct nvdimm;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
