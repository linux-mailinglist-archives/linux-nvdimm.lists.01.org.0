Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B5360880
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 13:48:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD502100F2263;
	Thu, 15 Apr 2021 04:48:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4349E100EB34D
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 04:48:21 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FBXNb1014060;
	Thu, 15 Apr 2021 07:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=nhDo38sLs1O5ShCsvwF3ShXi2pGmqVt3AKbjKnDc2+g=;
 b=CCBDA+ZecJ2C0n0U79lNoiHnrQVxClu99j9UdzLbq1IbdgC9budR4BEYvjL9BMUl8XHZ
 ph0ehTLCMn1zsHefhGKHlQoSlxuZOnB27mn7V7rUN5ciZb/g6L98Q/3BMNHh3b9gERVY
 huH9f+0HTFahYM4Bawq9AmRfqWsoyv0yX47rxsbN1foTTS1yS+E/p9pZk4HK5d1sCPaN
 Vi2eHaFkhsGBXUqNpziMtdckFnzzX0luwoMqYyfKSaTSU+n5uzWJAVYpWtV8CqeqFO77
 lbR00qaalVkN/eUHWH3zt+VPWMEKVlFaCkV3OvHcJyJDY64BO0ZxSky9qXqkf/olGDDe /Q==
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37x46xr908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Apr 2021 07:48:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FBlSoj024330;
	Thu, 15 Apr 2021 11:48:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 37u3n8bupg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Apr 2021 11:48:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FBmEcp27787652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Apr 2021 11:48:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 456A3A4051;
	Thu, 15 Apr 2021 11:48:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E92C0A404D;
	Thu, 15 Apr 2021 11:48:11 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.63.240])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 15 Apr 2021 11:48:11 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 15 Apr 2021 17:18:11 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats
 inaccessible
In-Reply-To: <20210414212417.GC1904484@iweiny-DESK2.sc.intel.com>
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
 <20210414153625.GB1904484@iweiny-DESK2.sc.intel.com>
 <87lf9kkfaj.fsf@vajain21.in.ibm.com>
 <20210414212417.GC1904484@iweiny-DESK2.sc.intel.com>
Date: Thu, 15 Apr 2021 17:18:11 +0530
Message-ID: <87h7k7lqf8.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TBxIlHlNE0-7ksVEhjqEBERNMT24RdsE
X-Proofpoint-ORIG-GUID: TBxIlHlNE0-7ksVEhjqEBERNMT24RdsE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150077
Message-ID-Hash: MMW5VQAVIQOUEB5L5WU2MRKQWZZYCD7T
X-Message-ID-Hash: MMW5VQAVIQOUEB5L5WU2MRKQWZZYCD7T
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MMW5VQAVIQOUEB5L5WU2MRKQWZZYCD7T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Wed, Apr 14, 2021 at 09:51:40PM +0530, Vaibhav Jain wrote:
>> Thanks for looking into this patch Ira,
>> 
>> Ira Weiny <ira.weiny@intel.com> writes:
>> 
>> > On Wed, Apr 14, 2021 at 06:10:26PM +0530, Vaibhav Jain wrote:
>> >> Currently drc_pmem_qeury_stats() generates a dev_err in case
>> >> "Enable Performance Information Collection" feature is disabled from
>> >> HMC. The error is of the form below:
>> >> 
>> >> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
>> >> 	 performance stats, Err:-10
>> >> 
>> >> This error message confuses users as it implies a possible problem
>> >> with the nvdimm even though its due to a disabled feature.
>> >> 
>> >> So we fix this by explicitly handling the H_AUTHORITY error from the
>> >> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
>> >> error, saying that "Performance stats in-accessible".
>> >> 
>> >> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
>> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> >> ---
>> >>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >> 
>> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> >> index 835163f54244..9216424f8be3 100644
>> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> >> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>> >>  		dev_err(&p->pdev->dev,
>> >>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
>> >>  		return -ENOENT;
>> >> +	} else if (rc == H_AUTHORITY) {
>> >> +		dev_warn(&p->pdev->dev, "Performance stats in-accessible");
>> >> +		return -EPERM;
>> >
>> > Is this because of a disabled feature or because of permissions?
>> 
>> Its because of a disabled feature that revokes permission for a guest to
>> retrieve performance statistics.
>> 
>> The feature is called "Enable Performance Information Collection" and
>> once disabled the hcall H_SCM_PERFORMANCE_STATS returns an error
>> H_AUTHORITY indicating that the guest doesn't have permission to retrieve
>> performance statistics.
>
> In that case would it be appropriate to have the error message indicate a
> permission issue?
>
> Something like 'permission denied'?

Yes, Something like "Permission denied while accessing performance
stats" might be more clear and intuitive.

Will update the warn message in v2.

>
> Ira
>

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
