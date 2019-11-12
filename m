Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67EF8EA4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:33:50 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8497A100DC408;
	Tue, 12 Nov 2019 03:35:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4285E100DC405
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:35:32 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBXJ3L029822;
	Tue, 12 Nov 2019 06:33:34 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7tfku83b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:33:33 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBUVDV003471;
	Tue, 12 Nov 2019 11:30:59 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma01wdc.us.ibm.com with ESMTP id 2w5n36e475-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:30:59 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBUsBW46793008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:30:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803E3C605B;
	Tue, 12 Nov 2019 11:30:54 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F633C6057;
	Tue, 12 Nov 2019 11:30:50 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:30:49 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 03/16] libnvdimm: Move nd_device_attribute_group to device_type
In-Reply-To: <157309901138.1582359.12909354140826530394.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309901138.1582359.12909354140826530394.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:00:46 +0530
Message-ID: <878soltjq1.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120105
Message-ID-Hash: FOY4L5YUVUKDLENKYCBCETFMBGI4RFQU
X-Message-ID-Hash: FOY4L5YUVUKDLENKYCBCETFMBGI4RFQU
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FOY4L5YUVUKDLENKYCBCETFMBGI4RFQU/>
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
> nd_device_attribute_group and put the responsibility on the core rather
> than leaf implementations to define this attribute.
>
> For regions this creates a new nd_region_attribute_groups[] added to the
> per-region device-type instances.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |    2 --
>  drivers/acpi/nfit/core.c                  |    2 --
>  drivers/nvdimm/bus.c                      |    3 +--
>  drivers/nvdimm/dimm_devs.c                |    8 +++++++-
>  drivers/nvdimm/e820.c                     |    1 -
>  drivers/nvdimm/nd.h                       |    1 +
>  drivers/nvdimm/of_pmem.c                  |    1 -
>  drivers/nvdimm/region_devs.c              |   18 +++++++++++++-----
>  include/linux/libnvdimm.h                 |    1 -
>  9 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 61883291defc..04726f8fd189 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -286,7 +286,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  
>  static const struct attribute_group *region_attr_groups[] = {
>  	&nd_region_attribute_group,
> -	&nd_device_attribute_group,
>  	&nd_mapping_attribute_group,
>  	&nd_numa_attribute_group,
>  	NULL,
> @@ -299,7 +298,6 @@ static const struct attribute_group *bus_attr_groups[] = {
>  
>  static const struct attribute_group *papr_scm_dimm_groups[] = {
>  	&nvdimm_attribute_group,
> -	&nd_device_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14e68f202f81..dec7c2b08672 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1699,7 +1699,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
>  
>  static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
>  	&nvdimm_attribute_group,
> -	&nd_device_attribute_group,
>  	&acpi_nfit_dimm_attribute_group,
>  	NULL,
>  };
> @@ -2199,7 +2198,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
>  static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
>  	&nd_region_attribute_group,
>  	&nd_mapping_attribute_group,
> -	&nd_device_attribute_group,
>  	&nd_numa_attribute_group,
>  	&acpi_nfit_region_attribute_group,
>  	NULL,
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index d47412dcdf38..eb422527dd57 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -669,10 +669,9 @@ static struct attribute *nd_device_attributes[] = {
>  /*
>   * nd_device_attribute_group - generic attributes for all devices on an nd bus
>   */
> -struct attribute_group nd_device_attribute_group = {
> +const struct attribute_group nd_device_attribute_group = {
>  	.attrs = nd_device_attributes,
>  };
> -EXPORT_SYMBOL_GPL(nd_device_attribute_group);
>  
>  static ssize_t numa_node_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 196aa44c4936..278867c68682 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -202,9 +202,15 @@ static void nvdimm_release(struct device *dev)
>  	kfree(nvdimm);
>  }
>  
> -static struct device_type nvdimm_device_type = {
> +static const struct attribute_group *nvdimm_attribute_groups[] = {
> +	&nd_device_attribute_group,
> +	NULL,
> +};
> +
> +static const struct device_type nvdimm_device_type = {
>  	.name = "nvdimm",
>  	.release = nvdimm_release,
> +	.groups = nvdimm_attribute_groups,
>  };
>  
>  bool is_nvdimm(struct device *dev)
> diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
> index 87f72f725e4f..adde2864c6a4 100644
> --- a/drivers/nvdimm/e820.c
> +++ b/drivers/nvdimm/e820.c
> @@ -15,7 +15,6 @@ static const struct attribute_group *e820_pmem_attribute_groups[] = {
>  
>  static const struct attribute_group *e820_pmem_region_attribute_groups[] = {
>  	&nd_region_attribute_group,
> -	&nd_device_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 5c8b077b3237..3f509bb6b5c0 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -298,6 +298,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
>  		struct nd_namespace_common *ndns);
>  int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig);
>  extern const struct attribute_group *nd_pfn_attribute_groups[];
> +extern const struct attribute_group nd_device_attribute_group;
>  #else
>  static inline int nd_pfn_probe(struct device *dev,
>  		struct nd_namespace_common *ndns)
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 97187d6c0bdb..41348fa6b74c 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -11,7 +11,6 @@
>  
>  static const struct attribute_group *region_attr_groups[] = {
>  	&nd_region_attribute_group,
> -	&nd_device_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index e89f2eb3678c..710b5111eaa8 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -763,19 +763,27 @@ struct attribute_group nd_region_attribute_group = {
>  };
>  EXPORT_SYMBOL_GPL(nd_region_attribute_group);
>  
> -static struct device_type nd_blk_device_type = {
> +static const struct attribute_group *nd_region_attribute_groups[] = {
> +	&nd_device_attribute_group,
> +	NULL,
> +};
> +
> +static const struct device_type nd_blk_device_type = {
>  	.name = "nd_blk",
>  	.release = nd_region_release,
> +	.groups = nd_region_attribute_groups,
>  };
>  
> -static struct device_type nd_pmem_device_type = {
> +static const struct device_type nd_pmem_device_type = {
>  	.name = "nd_pmem",
>  	.release = nd_region_release,
> +	.groups = nd_region_attribute_groups,
>  };
>  
> -static struct device_type nd_volatile_device_type = {
> +static const struct device_type nd_volatile_device_type = {
>  	.name = "nd_volatile",
>  	.release = nd_region_release,
> +	.groups = nd_region_attribute_groups,
>  };
>  
>  bool is_nd_pmem(struct device *dev)
> @@ -931,8 +939,8 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
>  EXPORT_SYMBOL(nd_region_release_lane);
>  
>  static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
> -		struct nd_region_desc *ndr_desc, struct device_type *dev_type,
> -		const char *caller)
> +		struct nd_region_desc *ndr_desc,
> +		const struct device_type *dev_type, const char *caller)
>  {
>  	struct nd_region *nd_region;
>  	struct device *dev;
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index b6eddf912568..d7dbf42498af 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -67,7 +67,6 @@ enum {
>  
>  extern struct attribute_group nvdimm_bus_attribute_group;
>  extern struct attribute_group nvdimm_attribute_group;
> -extern struct attribute_group nd_device_attribute_group;
>  extern struct attribute_group nd_numa_attribute_group;
>  extern struct attribute_group nd_region_attribute_group;
>  extern struct attribute_group nd_mapping_attribute_group;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
