Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF508F8EF4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 12:51:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83FE7100DC41C;
	Tue, 12 Nov 2019 03:53:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 772D4100DC418
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 03:53:06 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBlmeE066031;
	Tue, 12 Nov 2019 06:50:13 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w7td0v0mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 06:50:12 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBhKKq016153;
	Tue, 12 Nov 2019 11:50:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma01wdc.us.ibm.com with ESMTP id 2w5n36e805-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2019 11:50:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBoAYs50200876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2019 11:50:10 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BA096A051;
	Tue, 12 Nov 2019 11:50:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B9E6A047;
	Tue, 12 Nov 2019 11:50:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2019 11:50:05 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 12/16] dax: Add numa_node to the default device-dax attributes
In-Reply-To: <157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Tue, 12 Nov 2019 17:20:03 +0530
Message-ID: <87imnps49g.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120107
Message-ID-Hash: YZX4V53EDID6677AMB2FNZCXRJCBG7VE
X-Message-ID-Hash: YZX4V53EDID6677AMB2FNZCXRJCBG7VE
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YZX4V53EDID6677AMB2FNZCXRJCBG7VE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> It is confusing that device-dax instances publish a 'target_node'
> attribute, but not a 'numa_node'. The 'numa_node' information is
> available elsewhere in the sysfs device hierarchy, but it is not obvious
> and not reliable from one device-dax instance-type (e.g. child devices
> of nvdimm namespaces) to the next (e.g. 'hmem' devices defined by EFI
> Specific Purpose Memory and the ACPI HMAT).
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index ce6d648d7670..0879b9663eb7 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -322,6 +322,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> +static ssize_t numa_node_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev_to_node(dev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -329,6 +336,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  
>  	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
>  		return 0;
> +	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
> +		return 0;
>  	return a->mode;
>  }
>  
> @@ -337,6 +346,7 @@ static struct attribute *dev_dax_attributes[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_target_node.attr,
>  	&dev_attr_resource.attr,
> +	&dev_attr_numa_node.attr,
>  	NULL,
>  };
>  
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
