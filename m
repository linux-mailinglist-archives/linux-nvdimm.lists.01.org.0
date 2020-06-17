Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942DA1FD271
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jun 2020 18:41:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D1F510FC4477;
	Wed, 17 Jun 2020 09:41:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0EBF61007A82A
	for <linux-nvdimm@lists.01.org>; Wed, 17 Jun 2020 09:41:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGbmjK129792;
	Wed, 17 Jun 2020 12:41:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31qnk72rp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 12:41:44 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HGc31t130248;
	Wed, 17 Jun 2020 12:41:43 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31qnk72rn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 12:41:43 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HGa2mm025559;
	Wed, 17 Jun 2020 16:41:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma01fra.de.ibm.com with ESMTP id 31q6chrj72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 16:41:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HGfdjf64618608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2020 16:41:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3129BAE055;
	Wed, 17 Jun 2020 16:41:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E93EAE053;
	Wed, 17 Jun 2020 16:41:35 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.49.232])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 17 Jun 2020 16:41:35 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 17 Jun 2020 22:11:34 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v6 1/5] libndctl: Refactor out add_dimm() to handle NFIT specific init
In-Reply-To: <77ef7c2fcbb084d7261e9e2595c57a03bc234ef7.camel@intel.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com> <20200616053029.84731-2-vaibhav@linux.ibm.com> <77ef7c2fcbb084d7261e9e2595c57a03bc234ef7.camel@intel.com>
Date: Wed, 17 Jun 2020 22:11:34 +0530
Message-ID: <878sglprup.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=5 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 cotscore=-2147483648
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170127
Message-ID-Hash: 2O2Y62YMNTPQ45EVWR73QDURE5KPWIS7
X-Message-ID-Hash: 2O2Y62YMNTPQ45EVWR73QDURE5KPWIS7
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2O2Y62YMNTPQ45EVWR73QDURE5KPWIS7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vishal,

Thanks for reviewing this patch. I will be addressing your review
comments in v7 of this patch series.

~ Vaibhav

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Tue, 2020-06-16 at 11:00 +0530, Vaibhav Jain wrote:
>> Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence
>
> "...probes NVDIMMs for platforms that support the ACPI NFIT"
>
> The NFIT is a platform firmware thing, not directly related to the DIMMs
> themselves.
>
>> this patch refactors this functionality into two functions namely
>
> s/Hence this patch refactors/Refactor/
>
>> add_dimm() and add_nfit_dimm(). Function add_dimm() performs
>> allocation and common 'struct ndctl_dimm' initialization and depending
>> on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
>> the probe is completed based on the value of 'ndctl_dimm.cmd_family'
>> appropriate dimm-ops are assigned to the dimm.
>> 
>> In case dimm-bus is of unknown type or doesn't support NFIT the
>> initialization still continues, with no dimm-ops assigned to the
>> 'struct ndctl_dimm' there-by limiting the functionality available.
>
> No need to hyphenate 'thereby'
>
>> 
>> This patch shouldn't introduce any behavioral change.
>> 
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> 
>> v5..v6:
>> * Changed a return code for add_nfit_dimm() in case a allocation
>>   failed. [ Vishal ]
>> * Updated an error message in error path of add_dimm() [ Vishal ]
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
>>  ndctl/lib/libndctl.c | 196 +++++++++++++++++++++++++------------------
>>  1 file changed, 115 insertions(+), 81 deletions(-)
>> 
> [..]
>
>> +
>> +	/* Assign dimm-ops based on command family */
>> +	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
>> +		dimm->ops = intel_dimm_ops;
>> +	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
>> +		dimm->ops = hpe1_dimm_ops;
>> +	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
>> +		dimm->ops = msft_dimm_ops;
>> +	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
>> +		dimm->ops = hyperv_dimm_ops;
>>   out:
>> +	if (rc) {
>> +		/* Ensure dimm_uninit() is not called during free_dimm() */
>> +		dimm->ops = NULL;
>
> I think the above assignment and comment are now stale..
>
>> +		err(ctx, "%s: probe failed: %s\n", ndctl_dimm_get_devname(dimm),
>> +		    strerror(-rc));
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
