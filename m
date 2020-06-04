Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D50D1EED8E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 23:55:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91CFD100A302C;
	Thu,  4 Jun 2020 14:50:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A09A2100F2277
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 14:50:11 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 054L2c9e049153;
	Thu, 4 Jun 2020 17:55:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31euh9u0p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 17:55:16 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054LlfG1045736;
	Thu, 4 Jun 2020 17:55:16 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31euh9u0n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 17:55:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054Lomlw015786;
	Thu, 4 Jun 2020 21:55:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03ams.nl.ibm.com with ESMTP id 31bf482t7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2020 21:55:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 054LtBKj41812080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2020 21:55:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB51A4064;
	Thu,  4 Jun 2020 21:55:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5362A4054;
	Thu,  4 Jun 2020 21:55:07 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.212])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2020 21:55:07 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 05 Jun 2020 03:25:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Williams\, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for PAPR_PDSM_HEALTH
In-Reply-To: <BN6PR11MB41326FB69B35A259A3A6FA61C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com> <20200529220600.225320-7-vaibhav@linux.ibm.com> <BN6PR11MB41326FB69B35A259A3A6FA61C6890@BN6PR11MB4132.namprd11.prod.outlook.com>
Date: Fri, 05 Jun 2020 03:25:06 +0530
Message-ID: <875zc6h4xx.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_13:2020-06-04,2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=2 priorityscore=1501 spamscore=0 clxscore=1015
 cotscore=-2147483648 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040150
Message-ID-Hash: I4WGRPUQRKPSHQTFXG3QVYO3IAY6IHBH
X-Message-ID-Hash: I4WGRPUQRKPSHQTFXG3QVYO3IAY6IHBH
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4WGRPUQRKPSHQTFXG3QVYO3IAY6IHBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Williams, Dan J" <dan.j.williams@intel.com> writes:

>> -----Original Message-----
>> From: Vaibhav Jain <vaibhav@linux.ibm.com>
>> Sent: Friday, May 29, 2020 3:06 PM
>> To: linux-nvdimm@lists.01.org
>> Cc: Vaibhav Jain <vaibhav@linux.ibm.com>; Williams, Dan J
>> <dan.j.williams@intel.com>; Verma, Vishal L <vishal.l.verma@intel.com>;
>> Aneesh Kumar K . V <aneesh.kumar@linux.ibm.com>; Jeff Moyer
>> <jmoyer@redhat.com>; Oliver O'Halloran <oohall@gmail.com>; Santosh
>> Sivaraj <santosh@fossix.org>; Weiny, Ira <ira.weiny@intel.com>
>> Subject: [ndctl PATCH v5 6/6] libndctl,papr_scm: Implement support for
>> PAPR_PDSM_HEALTH
>> 
>> Add support for reporting DIMM health and shutdown state by issuing
>> PAPR_PDSM_HEALTH request to papr_scm module. It returns an instance of
>> 'struct nd_papr_pdsm_health' as defined in 'papr_pdsm.h'. The patch
>> provides support for dimm-ops 'new_smart', 'smart_get_health' &
>> 'smart_get_shutdown_state' as newly introduced functions
>> papr_new_smart_health(), papr_smart_get_health() &
>> papr_smart_get_shutdown_state() respectively. These callbacks should
>> enable ndctl to report DIMM health.
>> 
>> Also a new member 'struct dimm_priv.health' is introduced which holds the
>> current health status of the dimm. This member is set inside newly added
>> function 'update_dimm_health_v1()' which parses the v1 payload returned
>> by the kernel after servicing PAPR_PDSM_HEALTH. The function will also
>> update dimm-flags viz 'struct ndctl_dimm.flags.f_*'
>> based on the flags set in the returned payload.
>> 
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> 
>> v4..v5:
>> * Updated patch description to reflect updated names of struct and
>>   defines that have the term 'scm' removed.
>> 
>> v3..v4:
>> * None
>> 
>> v2..v3:
>> * None
>> 
>> v1..v2:
>> * Squashed patch to report nvdimm bad shutdown state with this patch.
>> * Switched to new structs/enums as defined in papr_scm_pdsm.h
>> ---
>>  ndctl/lib/papr.c | 90
>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 87 insertions(+), 3 deletions(-)
>> 
>> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c index
>> 1b7870beb631..cb7ff9e0d5bd 100644
>> --- a/ndctl/lib/papr.c
>> +++ b/ndctl/lib/papr.c
>> @@ -42,7 +42,9 @@
>> 
>>  /* Per dimm data. Holds per-dimm data parsed from the cmd_pkgs */  struct
>> dimm_priv {
>> -	/* Empty for now */
>> +
>> +	/* Cache the dimm health status */
>> +	struct nd_papr_pdsm_health health;
>
[.]
> I don't understand this. The kernel is caching this, why does libndctl
> need to cache it?

Was caching it here as the returned nvdimm health payload from kernel
might be of different version than what was requested and reconstituting
'struct nd_papr_pdsm_health' from 'struct ndctl_cmd' in each dimm-ops
callback would have be costly. 

However with payload versioning scheme not used any more this caching
wont be needed anymore.

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
