Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66691F8EEA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:49:30 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CD85100DC415;
	Tue, 12 Nov 2019 03:51:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33DD3100DC409
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:51:14 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBlpWp054386;
	Tue, 12 Nov 2019 06:48:18 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7td945h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:48:17 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBhXXR020744;
	Tue, 12 Nov 2019 11:48:16 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma01dal.us.ibm.com with ESMTP id 2w5n36dswa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:48:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBmFwq55378382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:48:15 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7438AE060;
	Tue, 12 Nov 2019 11:48:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9352AE05F;
	Tue, 12 Nov 2019 11:48:11 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:48:11 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 07/16] libnvdimm: Move nvdimm_attribute_group to device_type
In-Reply-To: <157309903201.1582359.10966209746585062329.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309903201.1582359.10966209746585062329.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:18:08 +0530
Message-ID: <87tv79s4cn.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120107
Message-ID-Hash: XYXYYSKPGG2CTZUYJKO7JOWXBUVWI76S
X-Message-ID-Hash: XYXYYSKPGG2CTZUYJKO7JOWXBUVWI76S
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XYXYYSKPGG2CTZUYJKO7JOWXBUVWI76S/>
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
> nvdimm_attribute_group and put the responsibility on the core rather
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
>  arch/powerpc/platforms/pseries/papr_scm.c |    9 ++-----
>  drivers/acpi/nfit/core.c                  |    1 -
>  drivers/nvdimm/dimm_devs.c                |   36 +++++++++++++++--------------
>  include/linux/libnvdimm.h                 |    1 -
>  4 files changed, 20 insertions(+), 27 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0405fb769336..8354737ac340 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -289,11 +289,6 @@ static const struct attribute_group *bus_attr_groups[] = {
>  	NULL,
>  };
>  
> -static const struct attribute_group *papr_scm_dimm_groups[] = {
> -	&nvdimm_attribute_group,
> -	NULL,
> -};
> -
>  static inline int papr_scm_node(int node)
>  {
>  	int min_dist = INT_MAX, dist;
> @@ -339,8 +334,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	dimm_flags = 0;
>  	set_bit(NDD_ALIASING, &dimm_flags);
>  
> -	p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_groups,
> -				dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
> +	p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
> +				  PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>  	if (!p->nvdimm) {
>  		dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
>  		goto err;
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 69c406ecc3a6..84fc1f865802 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1698,7 +1698,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
>  };
>  
>  static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
> -	&nvdimm_attribute_group,
>  	&acpi_nfit_dimm_attribute_group,
>  	NULL,
>  };
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 278867c68682..94ea6dba6b4f 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -202,22 +202,6 @@ static void nvdimm_release(struct device *dev)
>  	kfree(nvdimm);
>  }
>  
> -static const struct attribute_group *nvdimm_attribute_groups[] = {
> -	&nd_device_attribute_group,
> -	NULL,
> -};
> -
> -static const struct device_type nvdimm_device_type = {
> -	.name = "nvdimm",
> -	.release = nvdimm_release,
> -	.groups = nvdimm_attribute_groups,
> -};
> -
> -bool is_nvdimm(struct device *dev)
> -{
> -	return dev->type == &nvdimm_device_type;
> -}
> -
>  struct nvdimm *to_nvdimm(struct device *dev)
>  {
>  	struct nvdimm *nvdimm = container_of(dev, struct nvdimm, dev);
> @@ -456,11 +440,27 @@ static umode_t nvdimm_visible(struct kobject *kobj, struct attribute *a, int n)
>  	return 0;
>  }
>  
> -struct attribute_group nvdimm_attribute_group = {
> +static const struct attribute_group nvdimm_attribute_group = {
>  	.attrs = nvdimm_attributes,
>  	.is_visible = nvdimm_visible,
>  };
> -EXPORT_SYMBOL_GPL(nvdimm_attribute_group);
> +
> +static const struct attribute_group *nvdimm_attribute_groups[] = {
> +	&nd_device_attribute_group,
> +	&nvdimm_attribute_group,
> +	NULL,
> +};
> +
> +static const struct device_type nvdimm_device_type = {
> +	.name = "nvdimm",
> +	.release = nvdimm_release,
> +	.groups = nvdimm_attribute_groups,
> +};
> +
> +bool is_nvdimm(struct device *dev)
> +{
> +	return dev->type == &nvdimm_device_type;
> +}
>  
>  struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
>  		void *provider_data, const struct attribute_group **groups,
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index eb597d1cb891..3644af97bcb4 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -66,7 +66,6 @@ enum {
>  };
>  
>  extern struct attribute_group nvdimm_bus_attribute_group;
> -extern struct attribute_group nvdimm_attribute_group;
>  
>  struct nvdimm;
>  struct nvdimm_bus_descriptor;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
