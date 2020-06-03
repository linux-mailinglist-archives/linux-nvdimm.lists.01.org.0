Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2431ECA32
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 09:10:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C27321011760A;
	Wed,  3 Jun 2020 00:05:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7340210112D6F
	for <linux-nvdimm@lists.01.org>; Wed,  3 Jun 2020 00:05:55 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05374rW1070838;
	Wed, 3 Jun 2020 03:10:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31c5414wc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 03:10:47 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0536Xix2071529;
	Wed, 3 Jun 2020 03:10:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31c5414wb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 03:10:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05375YuW003339;
	Wed, 3 Jun 2020 07:10:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 31bf47b1ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2020 07:10:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0537Af9U64553362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2020 07:10:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06631A404D;
	Wed,  3 Jun 2020 07:10:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D355BA4040;
	Wed,  3 Jun 2020 07:10:37 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.88.183])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2020 07:10:37 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 03 Jun 2020 12:40:36 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v5 1/6] libndctl: Refactor out add_dimm() to handle NFIT specific init
In-Reply-To: <51bb265a8f9e50214e9412cca57ae6dc7e16178b.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com> <20200529220600.225320-2-vaibhav@linux.ibm.com> <51bb265a8f9e50214e9412cca57ae6dc7e16178b.camel@intel.com>
Date: Wed, 03 Jun 2020 12:40:36 +0530
Message-ID: <87367cipzn.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_03:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=5 malwarescore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030051
Message-ID-Hash: 5PLJ5C2NMCINYUTO4CJH4TTWJUS6ZRR2
X-Message-ID-Hash: 5PLJ5C2NMCINYUTO4CJH4TTWJUS6ZRR2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5PLJ5C2NMCINYUTO4CJH4TTWJUS6ZRR2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vishal,

Thanks for reviewing this patch. My responses below:

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Sat, 2020-05-30 at 03:35 +0530, Vaibhav Jain wrote:
>> Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence
>> this patch refactors this functionality into two functions namely
>> add_dimm() and add_nfit_dimm(). Function add_dimm() performs
>> allocation and common 'struct ndctl_dimm' initialization and depending
>> on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
>> the probe is completed based on the value of 'ndctl_dimm.cmd_family'
>> appropriate dimm-ops are assigned to the dimm.
>> 
>> In case dimm-bus is of unknown type or doesn't support NFIT the
>> initialization still continues, with no dimm-ops assigned to the
>> 'struct ndctl_dimm' there-by limiting the functionality available.
>> 
>> This patch shouldn't introduce any behavioral change.
>> 
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> 
>> v4..v5:
>> * None
>> 
>> v3..v4:
>> * None
>> 
>> v2..v3:
>> * None
>> 
>> v1..v2:
>> * None
>> ---
>>  ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++-----------------
>> -
>>  1 file changed, 112 insertions(+), 81 deletions(-)
>
> Hi Vaibhav,
>
> This mostly looks good, one minor nit below.
>
>> 
>> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
>> index ee737cbbfe3e..d76dbf7e17de 100644
>> --- a/ndctl/lib/libndctl.c
>> +++ b/ndctl/lib/libndctl.c
>> @@ -1441,82 +1441,15 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>>  
>> -static void *add_dimm(void *parent, int id, const char *dimm_base)
>> +static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>>  {
>> -	int formats, i;
>> -	struct ndctl_dimm *dimm;
>> +	int i, rc = -1;
>>  	char buf[SYSFS_ATTR_SIZE];
>> -	struct ndctl_bus *bus = parent;
>> -	struct ndctl_ctx *ctx = bus->ctx;
>> +	struct ndctl_ctx *ctx = dimm->bus->ctx;
>>  	char *path = calloc(1, strlen(dimm_base) + 100);
>>  
>>  	if (!path)
>
> <snip>
>
>> +		return -1;
>
> You should generally avoid returning a plain '-1'. This really wants to
> return an -ENOMEM.
If calloc fails, variable 'errno' will already be set to ENOMEM. Hence
didn't explicitly return -ENOMEM. But fair suggestion will update
this in v6.

>>  
>>  	/*
>>  	 * 'unique_id' may not be available on older kernels, so don't
>> @@ -1582,24 +1515,15 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>>  	sprintf(path, "%s/nfit/family", dimm_base);
>>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>>  		dimm->cmd_family = strtoul(buf, NULL, 0);
>> -	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
>> -		dimm->ops = intel_dimm_ops;
>> -	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
>> -		dimm->ops = hpe1_dimm_ops;
>> -	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
>> -		dimm->ops = msft_dimm_ops;
>> -	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
>> -		dimm->ops = hyperv_dimm_ops;
>>  
>>  	sprintf(path, "%s/nfit/dsm_mask", dimm_base);
>>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>>  		dimm->nfit_dsm_mask = strtoul(buf, NULL, 0);
>>  
>> -	dimm->formats = formats;
>>  	sprintf(path, "%s/nfit/format", dimm_base);
>>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>>  		dimm->format[0] = strtoul(buf, NULL, 0);
>> -	for (i = 1; i < formats; i++) {
>> +	for (i = 1; i < dimm->formats; i++) {
>>  		sprintf(path, "%s/nfit/format%d", dimm_base, i);
>>  		if (sysfs_read_attr(ctx, path, buf) == 0)
>>  			dimm->format[i] = strtoul(buf, NULL, 0);
>> @@ -1610,7 +1534,114 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>
> <snip>
>
>>   out:
>> +	if (rc) {
>> +		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
>
> Returning -1 being awkward is especially true when it might end up
> getting printed as part of an error message like this. Indeed, you    
> shouldn't even print 'rc' as a number, which then needs to get looked up
> - use strerror to turn it into a string.
>
> Additionally, "dimm:<number>" is pretty nonstandard in ndctl, we
> normally use the 'devname' for error messages. How about something
> like:
>
> 	err(ctx, "%s: probe failed: %s\n", ndctl_dimm_get_devname(dimm),
> 		strerror(-rc));
>
Fair suggestion. Will update this in v6. 
>> +		goto err_read;
>> +	}
>> +
>>  	list_add(&bus->dimms, &dimm->list);
>>  	free(path);
>>  

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
