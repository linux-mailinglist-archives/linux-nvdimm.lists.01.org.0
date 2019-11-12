Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA207F8EED
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:49:39 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20182100DC41B;
	Tue, 12 Nov 2019 03:51:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3C5E100DC419
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:51:22 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBljoS141159;
	Tue, 12 Nov 2019 06:49:29 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7qdbrewx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:49:28 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBdt7S004064;
	Tue, 12 Nov 2019 11:49:13 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma04dal.us.ibm.com with ESMTP id 2w5n36dqeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:49:13 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBnCIC34406714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:49:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE936E04E;
	Tue, 12 Nov 2019 11:49:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B82C36E058;
	Tue, 12 Nov 2019 11:49:07 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:49:07 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 09/16] dax: Create a dax device_type
In-Reply-To: <157309904365.1582359.5451327195246651379.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309904365.1582359.5451327195246651379.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:19:04 +0530
Message-ID: <87o8xhs4b3.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120107
Message-ID-Hash: 2DTF2FFULBWMGCOZTFMQWZT7VQPVNW3Y
X-Message-ID-Hash: 2DTF2FFULBWMGCOZTFMQWZT7VQPVNW3Y
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2DTF2FFULBWMGCOZTFMQWZT7VQPVNW3Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Move the open coded release method and attribute groups to a 'struct
> device_type' instance.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 8fafbeab510a..f3e6e00ece40 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -373,6 +373,11 @@ static void dev_dax_release(struct device *dev)
>  	kfree(dev_dax);
>  }
>  
> +static const struct device_type dev_dax_type = {
> +	.release = dev_dax_release,
> +	.groups = dax_attribute_groups,
> +};
> +
>  static void unregister_dev_dax(void *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> @@ -430,8 +435,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
>  	else
>  		dev->class = dax_class;
>  	dev->parent = parent;
> -	dev->groups = dax_attribute_groups;
> -	dev->release = dev_dax_release;
> +	dev->type = &dev_dax_type;
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, id);
>  
>  	rc = device_add(dev);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
