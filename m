Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC741ECD04
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 11:57:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 42BF8100AA7BA;
	Wed,  3 Jun 2020 02:52:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 37570100AA7B9
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 02:52:21 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0539WJvD138135;
	Wed, 3 Jun 2020 05:57:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31dj9pgx1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 05:57:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0539qhCJ061537;
	Wed, 3 Jun 2020 05:57:15 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31dj9pgx0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 05:57:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0539uEjn014701;
	Wed, 3 Jun 2020 09:57:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03ams.nl.ibm.com with ESMTP id 31bf47ys1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 09:57:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0539vA3b66126126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2020 09:57:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AED95A404D;
	Wed,  3 Jun 2020 09:57:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D701CA405D;
	Wed,  3 Jun 2020 09:57:06 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.79.176.103])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2020 09:57:06 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 03 Jun 2020 15:27:05 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v5 2/6] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
In-Reply-To: <2960499ffc4f5f3f3ab305eaba84c2bca15b45ae.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com> <20200529220600.225320-3-vaibhav@linux.ibm.com> <2960499ffc4f5f3f3ab305eaba84c2bca15b45ae.camel@intel.com>
Date: Wed, 03 Jun 2020 15:27:05 +0530
Message-ID: <87zh9kh3pq.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_06:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030071
Message-ID-Hash: NCW7P2KMQ2ZP77QSSKRIC7GOXW2QXV4T
X-Message-ID-Hash: NCW7P2KMQ2ZP77QSSKRIC7GOXW2QXV4T
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NCW7P2KMQ2ZP77QSSKRIC7GOXW2QXV4T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Sat, 2020-05-30 at 03:35 +0530, Vaibhav Jain wrote:
>
>> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
>> index d76dbf7e17de..a52c2e208fbe 100644
>> --- a/ndctl/lib/libndctl.c
>> +++ b/ndctl/lib/libndctl.c
>> @@ -799,6 +799,28 @@ static void parse_nfit_mem_flags(struct ndctl_dimm *dimm, char *flags)
>>  				ndctl_dimm_get_devname(dimm), flags);
>>  }
>>  
>> +static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
>> +{
>> +	char *start, *end;
>> +
>> +	start = flags;
>> +	while ((end = strchr(start, ' '))) {
>> +		*end = '\0';
>> +		if (strcmp(start, "not_armed") == 0)
>> +			dimm->flags.f_arm = 1;
>> +		else if (strcmp(start, "flush_fail") == 0)
>> +			dimm->flags.f_flush = 1;
>> +		else if (strcmp(start, "restore_fail") == 0)
>> +			dimm->flags.f_restore = 1;
>> +		else if (strcmp(start, "smart_notify") == 0)
>> +			dimm->flags.f_smart = 1;
>> +		start = end + 1;
>> +	}
>> +	if (end != start)
>> +		dbg(ndctl_dimm_get_ctx(dimm), "%s: %s\n",
>> +				ndctl_dimm_get_devname(dimm), flags);
>
> I think this would be more readable if ctx was obtained and saved in a
> 'ctx' variable at the start. Also, it might be better if 'flags' was
> included in the string - something like "%s flags: %s\n"
Sure will get this updated in v6. This function definition was derived
from parse_dimm_flags() hence looks this way.

>
>> +}
>> +
>>  static void parse_dimm_flags(struct ndctl_dimm *dimm, char *flags)
>>  {
>>  	char *start, *end;
>> @@ -856,6 +878,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
>>  		bus->revision = strtoul(buf, NULL, 0);
>>  	}
>>  
>> +	sprintf(path, "%s/device/of_node/compatible", ctl_base);
>> +	if (sysfs_read_attr(ctx, path, buf) < 0)
>> +		bus->has_of_node = 0;
>> +	else
>> +		bus->has_of_node = 1;
>> +
>>  	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
>>  	if (sysfs_read_attr(ctx, path, buf) < 0)
>>  		bus->nfit_dsm_mask = 0;
>> @@ -964,6 +992,10 @@ NDCTL_EXPORT int ndctl_bus_has_nfit(struct ndctl_bus *bus)
>>  	return bus->has_nfit;
>>  }
>>  
>> +NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
>> +{
>> +	return bus->has_of_node;
>> +}
>
> New libndctl APIs need to update the 'symbol script' -
> ndctl/lib/libndctl.sym. Create a new 'section' at the bottom, and add
> all new symbols to that section. The new section would be 'LIBNDCTL_24'
> (Everything going into a given release gets a new section in that file,
> so any subsequent patches - throughout the release cycle - that add new
> APIs can add them to this new section).
Sure and thanks for pointing this out. Will add this symbol to the library
version script in v6

>
>>  /**
>>   * ndctl_bus_get_major - nd bus character device major number
>>   * @bus: ndctl_bus instance returned from ndctl_bus_get_{first|next}
>> @@ -1441,6 +1473,47 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>>  
>> +static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>> +{
>> +	int rc = -ENODEV;
>> +	char buf[SYSFS_ATTR_SIZE];
>> +	struct ndctl_ctx *ctx = dimm->bus->ctx;
>> +	char *path = calloc(1, strlen(dimm_base) + 100);
>> +
>> +	dbg(ctx, "Probing of_pmem dimm %d at %s\n", dimm->id, dimm_base);
>> +
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	sprintf(path, "%s/../of_node/compatible", dimm_base);
>> +	if (sysfs_read_attr(ctx, path, buf) < 0)
>> +		goto out;
>
> Two things here:
> 1. Why not use the new ndctl_bus_has_of_node helper here? and
> 2. This looks redundant. add_papr_dimm() is only called if
> ndctl_bus_has_of_node() during add_dimm.
Presently we have two different nvdimm implementations:

* papr-scm: handled by arch/powerpc/platforms/pseries/papr_scm kernel module.
* nvdimm-n: handled by drivers/nvdimm/of_pmem kernel module.

Both nvdimms are exposed to the kernel via device tree nodes but different
'compatible' properties. This patchset only adds support for 'papr-scm'
compatible nvdimms.

'ndctl_bus_has_of_node()' simply indicates if the nvdimm has an
open-firmware compatible devicetree node associated with it and doesnt
necessarily indicate if its papr-scm compliant.

Hence validating the 'compatible' attribute value is necessary here.
Please see a more detailed info below regarding the 'compatible' sysfs
attribute.

>
>> +
>> +
>
> Nit: double newline here
Sure. Will fix this in v6
>
>> +	dbg(ctx, "Compatible of_pmem dimm %d at %s\n", dimm->id, buf);
>> +	/* construct path to the papr compatible dimm flags file */
>> +	sprintf(path, "%s/papr/flags", dimm_base);
>> +
>> +	if (strcmp(buf, "ibm,pmemory") == 0 &&
>> +	    sysfs_read_attr(ctx, path, buf) == 0) {
>> +
>> +		dbg(ctx, "Found papr dimm %d at %s\n", dimm->id, buf);
>
> Throughout the series - it would be better to print messages such as:
>
> 	"%s: adding papr dimm with flags: %s\n", devname, buf
>
> This would result in the canonical dimm names - nmem1, nmem2 and so on
> being used instead of "dimm 1" which can be confusing just from a
> convention standpoint.
>
> Similarly for the print a few lines above this:
>
> 	"%s: of_pmem compatible dimm: %s\n", devname, buf
>
Sure will address this in v6.

> (In this case, what does the 'compatible' sysfs attrubute contain? Is it
> useful to print here? - I havent't looked, just asking).

For papr-scm compatible nvdimms:
# cat /sys/class/nd/ndctl0/device/of_node/compatible
ibm,pmemory

This devicetree property is usually in format "<manufacturer>,<model>" that
tells the which kernel module to bind to the device. The papr_scm
kernel module indicates support for such device value in its device
match table ( https://git.io/JfPzF ) so that kernel can call its
probe-function.

Dumping this value here will be useful in debugging probe failures of nvdimms
that are exposed via open-firmware devicetree nodes but are not
necessarily papr_scm specification compliant.

>
>> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
>> new file mode 100644
>> index 000000000000..5ddf2755a950
>> --- /dev/null
>> +++ b/ndctl/lib/papr.c
>> @@ -0,0 +1,32 @@
>> +/*
>> + * Copyright (C) 2020 IBM Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU Lesser General Public License,
>> + * version 2.1, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT ANY
>> + * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
>> + * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
>> + * more details.
>> + */
>
> Prefer SPDX license header instead fo the long form text for new files.
>
Sure will address this in v6.

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
