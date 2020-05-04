Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A41C33FE
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 10:05:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FC1F1161C32A;
	Mon,  4 May 2020 01:04:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9DB61007AC98
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 01:04:06 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04482mas011995
	for <linux-nvdimm@lists.01.org>; Mon, 4 May 2020 04:05:42 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30s45sax4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 04:05:41 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044858Zb021351
	for <linux-nvdimm@lists.01.org>; Mon, 4 May 2020 08:05:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma01fra.de.ibm.com with ESMTP id 30s0g59r28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 08:05:39 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04485alW58917006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2020 08:05:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70D6611C05B;
	Mon,  4 May 2020 08:05:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B6C711C058;
	Mon,  4 May 2020 08:05:34 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.222])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon,  4 May 2020 08:05:33 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 04 May 2020 13:35:31 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH v2 1/6] libndctl: Refactor out add_dimm() to handle NFIT specific init
In-Reply-To: <87ftcm20gm.fsf@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com> <20200420075556.272174-2-vaibhav@linux.ibm.com> <87ftcm20gm.fsf@linux.ibm.com>
Date: Mon, 04 May 2020 13:35:31 +0530
Message-ID: <87imhcdt10.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_04:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=22 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040069
Message-ID-Hash: TQXFMIQGQGTMA42LEJSQN3KNSQKZOBGH
X-Message-ID-Hash: TQXFMIQGQGTMA42LEJSQN3KNSQKZOBGH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TQXFMIQGQGTMA42LEJSQN3KNSQKZOBGH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Aneesh,

Thanks for looking into this patch.

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
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
>> v1..v2:
>> * None
>> ---
>>  ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++------------------
>>  1 file changed, 112 insertions(+), 81 deletions(-)
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
>> -		return NULL;
>> -
>> -	sprintf(path, "%s/nfit/formats", dimm_base);
>> -	if (sysfs_read_attr(ctx, path, buf) < 0)
>> -		formats = 1;
>> -	else
>
> ....
>> +	rc = 0;
>> + err_read:
>> +
>> +	free(path);
>> +	return rc;
>> +}
>> +
>> +static void *add_dimm(void *parent, int id, const char *dimm_base)
>> +{
>> +	int formats, i, rc = -ENODEV;
>> +	struct ndctl_dimm *dimm = NULL;
>> +	char buf[SYSFS_ATTR_SIZE];
>> +	struct ndctl_bus *bus = parent;
>> +	struct ndctl_ctx *ctx = bus->ctx;
>> +	char *path = calloc(1, strlen(dimm_base) + 100);
>> +
>> +	if (!path)
>> +		return NULL;
>> +
>> +	sprintf(path, "%s/nfit/formats", dimm_base);
>
> Witht that abstraction this should be part of add_nfit_dimm?

This part is needed to calculate the size of 'struct ndctl_dimm' to be
allocated which is based on number of nfit formats reported in
sysfs.

>
>> +	if (sysfs_read_attr(ctx, path, buf) < 0)
>> +		formats = 1;
>> +	else
>> +		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
>> +
>> +	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
>> +	if (!dimm)
>> +		goto err_dimm;
>> +	dimm->bus = bus;
>> +	dimm->id = id;
>> +
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
