Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6EA374EC3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 07:02:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DD5A100EAB41;
	Wed,  5 May 2021 22:02:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B2D3100EB325
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 22:02:30 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1464XZh0118924;
	Thu, 6 May 2021 01:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=kMC+kTWManNLXQk0SS/NpjEvVgHzOwjrxPYZg9H04cI=;
 b=O2/9Ya6rvk+0INr/8rY7quB5egugzzorE1fKntucjTYks6M9x38007D2eyGzQrlb4eja
 YhGVCOnaYrfbk5t83f+p2L1mgo0br3Pg2OhYO9/Fs7FAMgWfj0wWAeC/ZePkyEjBtY23
 V1zkWKvf77GXKKq11RGCIQt8JWcbf7t8+HljQuwXvTfTd8/xn8ffaqAE03ekG+71f3ET
 sE3RiD2U3ZedwT91PA0QNClGfo9mAe3uOTcqungNeph5Q/KPRdo/u3lC6zxgbixcz+ZV
 2F68zAli2V4/zfcZRX+w7umFZTk8gqfaA1nDaoS8FzNyWD27GzbjSr8VTiIJEonKY2Si qg==
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38c9g2rj4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 May 2021 01:02:26 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1464uaAC005867;
	Thu, 6 May 2021 05:02:25 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma03dal.us.ibm.com with ESMTP id 38bee8kmr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 May 2021 05:02:25 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14652Ov324772888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 May 2021 05:02:24 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4B557805F;
	Thu,  6 May 2021 05:02:24 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 085E37805C;
	Thu,  6 May 2021 05:02:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.1.95])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  6 May 2021 05:02:22 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH] powerpc/papr_scm: Make 'perf_stats' invisible if
 perf-stats unavailable
In-Reply-To: <20210505191708.51939-1-vaibhav@linux.ibm.com>
References: <20210505191708.51939-1-vaibhav@linux.ibm.com>
Date: Thu, 06 May 2021 10:32:20 +0530
Message-ID: <8735v078v7.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: reMn7QqHn7w2TzhK30QVKjX71KFFZ7Ba
X-Proofpoint-GUID: reMn7QqHn7w2TzhK30QVKjX71KFFZ7Ba
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_03:2021-05-05,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060029
Message-ID-Hash: TDGA5D2NZVAQGOIEMH7Z2XJPG6WIEMNI
X-Message-ID-Hash: TDGA5D2NZVAQGOIEMH7Z2XJPG6WIEMNI
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TDGA5D2NZVAQGOIEMH7Z2XJPG6WIEMNI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> In case performance stats for an nvdimm are not available, reading the
> 'perf_stats' sysfs file returns an -ENOENT error. A better approach is
> to make the 'perf_stats' file entirely invisible to indicate that
> performance stats for an nvdimm are unavailable.
>
> So this patch updates 'papr_nd_attribute_group' to add a 'is_visible'
> callback implemented as newly introduced 'papr_nd_attribute_visible()'
> that returns an appropriate mode in case performance stats aren't
> supported in a given nvdimm.
>
> Also the initialization of 'papr_scm_priv.stat_buffer_len' is moved
> from papr_scm_nvdimm_init() to papr_scm_probe() so that it value is
> available when 'papr_nd_attribute_visible()' is called during nvdimm
> initialization.
>
> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 37 ++++++++++++++++-------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 12f1513f0fca..90f0af8fefe8 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -907,6 +907,20 @@ static ssize_t flags_show(struct device *dev,
>  }
>  DEVICE_ATTR_RO(flags);
>  
> +umode_t papr_nd_attribute_visible(struct kobject *kobj, struct attribute *attr,
> +				  int n)
> +{
> +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +	struct nvdimm *nvdimm = to_nvdimm(dev);
> +	struct papr_scm_priv *p = nvdimm_provider_data(nvdimm);
> +
> +	/* For if perf-stats not available remove perf_stats sysfs */
> +	if (attr == &dev_attr_perf_stats.attr && p->stat_buffer_len == 0)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  /* papr_scm specific dimm attributes */
>  static struct attribute *papr_nd_attributes[] = {
>  	&dev_attr_flags.attr,
> @@ -916,6 +930,7 @@ static struct attribute *papr_nd_attributes[] = {
>  
>  static struct attribute_group papr_nd_attribute_group = {
>  	.name = "papr",
> +	.is_visible = papr_nd_attribute_visible,
>  	.attrs = papr_nd_attributes,
>  };
>  
> @@ -931,7 +946,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	struct nd_region_desc ndr_desc;
>  	unsigned long dimm_flags;
>  	int target_nid, online_nid;
> -	ssize_t stat_size;
>  
>  	p->bus_desc.ndctl = papr_scm_ndctl;
>  	p->bus_desc.module = THIS_MODULE;
> @@ -1016,16 +1030,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	list_add_tail(&p->region_list, &papr_nd_regions);
>  	mutex_unlock(&papr_ndr_lock);
>  
> -	/* Try retriving the stat buffer and see if its supported */
> -	stat_size = drc_pmem_query_stats(p, NULL, 0);
> -	if (stat_size > 0) {
> -		p->stat_buffer_len = stat_size;
> -		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
> -			p->stat_buffer_len);
> -	} else {
> -		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
> -	}
> -
>  	return 0;
>  
>  err:	nvdimm_bus_unregister(p->bus);
> @@ -1102,6 +1106,7 @@ static int papr_scm_probe(struct platform_device *pdev)
>  	u64 blocks, block_size;
>  	struct papr_scm_priv *p;
>  	const char *uuid_str;
> +	ssize_t stat_size;
>  	u64 uuid[2];
>  	int rc;
>  
> @@ -1179,6 +1184,16 @@ static int papr_scm_probe(struct platform_device *pdev)
>  	p->res.name  = pdev->name;
>  	p->res.flags = IORESOURCE_MEM;
>  
> +	/* Try retriving the stat buffer and see if its supported */
> +	stat_size = drc_pmem_query_stats(p, NULL, 0);
> +	if (stat_size > 0) {
> +		p->stat_buffer_len = stat_size;
> +		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
> +			p->stat_buffer_len);
> +	} else {
> +		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
> +	}

With this patch https://lore.kernel.org/linuxppc-dev/20210505191606.51666-1-vaibhav@linux.ibm.com
We are adding details of whyy performance stat query hcall failed. Do we
need to print again here?  Are we being more verbose here?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
