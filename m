Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78EF8E99
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:29:41 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CE8E100DC40B;
	Tue, 12 Nov 2019 03:31:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DCBF8100DC408
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:31:24 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBIuUQ056105;
	Tue, 12 Nov 2019 06:29:29 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w7t1wc9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:29:28 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBQ4u8001356;
	Tue, 12 Nov 2019 11:29:27 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by ppma01dal.us.ibm.com with ESMTP id 2w5n36dn5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:29:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBTQYN50790786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:29:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6A6B205F;
	Tue, 12 Nov 2019 11:29:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57EECB2068;
	Tue, 12 Nov 2019 11:29:23 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:29:22 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 02/16] libnvdimm: Move region attribute group definition
In-Reply-To: <157309900624.1582359.6929998072035982264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309900624.1582359.6929998072035982264.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 16:59:19 +0530
Message-ID: <87blthtjsg.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120105
Message-ID-Hash: Y3WBDBHXGFMS5EBIK3XHZVNO3SATTVFQ
X-Message-ID-Hash: Y3WBDBHXGFMS5EBIK3XHZVNO3SATTVFQ
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y3WBDBHXGFMS5EBIK3XHZVNO3SATTVFQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> In preparation for moving region attributes from device attribute groups
> to the region device-type, reorder the declaration so that it can be
> referenced by the device-type definition without forward declarations.
> No functional changes are intended to result from this change.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/region_devs.c |  208 +++++++++++++++++++++---------------------
>  1 file changed, 104 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef423ba1a711..e89f2eb3678c 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -140,36 +140,6 @@ static void nd_region_release(struct device *dev)
>  		kfree(nd_region);
>  }
>  
> -static struct device_type nd_blk_device_type = {
> -	.name = "nd_blk",
> -	.release = nd_region_release,
> -};
> -
> -static struct device_type nd_pmem_device_type = {
> -	.name = "nd_pmem",
> -	.release = nd_region_release,
> -};
> -
> -static struct device_type nd_volatile_device_type = {
> -	.name = "nd_volatile",
> -	.release = nd_region_release,
> -};
> -
> -bool is_nd_pmem(struct device *dev)
> -{
> -	return dev ? dev->type == &nd_pmem_device_type : false;
> -}
> -
> -bool is_nd_blk(struct device *dev)
> -{
> -	return dev ? dev->type == &nd_blk_device_type : false;
> -}
> -
> -bool is_nd_volatile(struct device *dev)
> -{
> -	return dev ? dev->type == &nd_volatile_device_type : false;
> -}
> -
>  struct nd_region *to_nd_region(struct device *dev)
>  {
>  	struct nd_region *nd_region = container_of(dev, struct nd_region, dev);
> @@ -674,80 +644,6 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
>  	return 0;
>  }
>  
> -struct attribute_group nd_region_attribute_group = {
> -	.attrs = nd_region_attributes,
> -	.is_visible = region_visible,
> -};
> -EXPORT_SYMBOL_GPL(nd_region_attribute_group);
> -
> -u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
> -		struct nd_namespace_index *nsindex)
> -{
> -	struct nd_interleave_set *nd_set = nd_region->nd_set;
> -
> -	if (!nd_set)
> -		return 0;
> -
> -	if (nsindex && __le16_to_cpu(nsindex->major) == 1
> -			&& __le16_to_cpu(nsindex->minor) == 1)
> -		return nd_set->cookie1;
> -	return nd_set->cookie2;
> -}
> -
> -u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
> -{
> -	struct nd_interleave_set *nd_set = nd_region->nd_set;
> -
> -	if (nd_set)
> -		return nd_set->altcookie;
> -	return 0;
> -}
> -
> -void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
> -{
> -	struct nd_label_ent *label_ent, *e;
> -
> -	lockdep_assert_held(&nd_mapping->lock);
> -	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
> -		list_del(&label_ent->list);
> -		kfree(label_ent);
> -	}
> -}
> -
> -/*
> - * When a namespace is activated create new seeds for the next
> - * namespace, or namespace-personality to be configured.
> - */
> -void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
> -{
> -	nvdimm_bus_lock(dev);
> -	if (nd_region->ns_seed == dev) {
> -		nd_region_create_ns_seed(nd_region);
> -	} else if (is_nd_btt(dev)) {
> -		struct nd_btt *nd_btt = to_nd_btt(dev);
> -
> -		if (nd_region->btt_seed == dev)
> -			nd_region_create_btt_seed(nd_region);
> -		if (nd_region->ns_seed == &nd_btt->ndns->dev)
> -			nd_region_create_ns_seed(nd_region);
> -	} else if (is_nd_pfn(dev)) {
> -		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
> -
> -		if (nd_region->pfn_seed == dev)
> -			nd_region_create_pfn_seed(nd_region);
> -		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
> -			nd_region_create_ns_seed(nd_region);
> -	} else if (is_nd_dax(dev)) {
> -		struct nd_dax *nd_dax = to_nd_dax(dev);
> -
> -		if (nd_region->dax_seed == dev)
> -			nd_region_create_dax_seed(nd_region);
> -		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
> -			nd_region_create_ns_seed(nd_region);
> -	}
> -	nvdimm_bus_unlock(dev);
> -}
> -
>  static ssize_t mappingN(struct device *dev, char *buf, int n)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev);
> @@ -861,6 +757,110 @@ struct attribute_group nd_mapping_attribute_group = {
>  };
>  EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
>  
> +struct attribute_group nd_region_attribute_group = {
> +	.attrs = nd_region_attributes,
> +	.is_visible = region_visible,
> +};
> +EXPORT_SYMBOL_GPL(nd_region_attribute_group);
> +
> +static struct device_type nd_blk_device_type = {
> +	.name = "nd_blk",
> +	.release = nd_region_release,
> +};
> +
> +static struct device_type nd_pmem_device_type = {
> +	.name = "nd_pmem",
> +	.release = nd_region_release,
> +};
> +
> +static struct device_type nd_volatile_device_type = {
> +	.name = "nd_volatile",
> +	.release = nd_region_release,
> +};
> +
> +bool is_nd_pmem(struct device *dev)
> +{
> +	return dev ? dev->type == &nd_pmem_device_type : false;
> +}
> +
> +bool is_nd_blk(struct device *dev)
> +{
> +	return dev ? dev->type == &nd_blk_device_type : false;
> +}
> +
> +bool is_nd_volatile(struct device *dev)
> +{
> +	return dev ? dev->type == &nd_volatile_device_type : false;
> +}
> +
> +u64 nd_region_interleave_set_cookie(struct nd_region *nd_region,
> +		struct nd_namespace_index *nsindex)
> +{
> +	struct nd_interleave_set *nd_set = nd_region->nd_set;
> +
> +	if (!nd_set)
> +		return 0;
> +
> +	if (nsindex && __le16_to_cpu(nsindex->major) == 1
> +			&& __le16_to_cpu(nsindex->minor) == 1)
> +		return nd_set->cookie1;
> +	return nd_set->cookie2;
> +}
> +
> +u64 nd_region_interleave_set_altcookie(struct nd_region *nd_region)
> +{
> +	struct nd_interleave_set *nd_set = nd_region->nd_set;
> +
> +	if (nd_set)
> +		return nd_set->altcookie;
> +	return 0;
> +}
> +
> +void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
> +{
> +	struct nd_label_ent *label_ent, *e;
> +
> +	lockdep_assert_held(&nd_mapping->lock);
> +	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
> +		list_del(&label_ent->list);
> +		kfree(label_ent);
> +	}
> +}
> +
> +/*
> + * When a namespace is activated create new seeds for the next
> + * namespace, or namespace-personality to be configured.
> + */
> +void nd_region_advance_seeds(struct nd_region *nd_region, struct device *dev)
> +{
> +	nvdimm_bus_lock(dev);
> +	if (nd_region->ns_seed == dev) {
> +		nd_region_create_ns_seed(nd_region);
> +	} else if (is_nd_btt(dev)) {
> +		struct nd_btt *nd_btt = to_nd_btt(dev);
> +
> +		if (nd_region->btt_seed == dev)
> +			nd_region_create_btt_seed(nd_region);
> +		if (nd_region->ns_seed == &nd_btt->ndns->dev)
> +			nd_region_create_ns_seed(nd_region);
> +	} else if (is_nd_pfn(dev)) {
> +		struct nd_pfn *nd_pfn = to_nd_pfn(dev);
> +
> +		if (nd_region->pfn_seed == dev)
> +			nd_region_create_pfn_seed(nd_region);
> +		if (nd_region->ns_seed == &nd_pfn->ndns->dev)
> +			nd_region_create_ns_seed(nd_region);
> +	} else if (is_nd_dax(dev)) {
> +		struct nd_dax *nd_dax = to_nd_dax(dev);
> +
> +		if (nd_region->dax_seed == dev)
> +			nd_region_create_dax_seed(nd_region);
> +		if (nd_region->ns_seed == &nd_dax->nd_pfn.ndns->dev)
> +			nd_region_create_ns_seed(nd_region);
> +	}
> +	nvdimm_bus_unlock(dev);
> +}
> +
>  int nd_blk_region_init(struct nd_region *nd_region)
>  {
>  	struct device *dev = &nd_region->dev;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
