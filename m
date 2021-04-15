Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3152D360871
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 13:43:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B401100EB34D;
	Thu, 15 Apr 2021 04:43:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DDFD8100EB330
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 04:43:52 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FBYGUV066917;
	Thu, 15 Apr 2021 07:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=iJ7JfO5XxFZ1N4E09oPPf+Z09702teorkZzT7+YZ9Mo=;
 b=ZmQRKg0nzVhpvKLiEn6uoiq7nkAPNcdwH1aaJBVDvd2AH5H1iFUSxIq9nq5QG3Q29wko
 DGYI+PbaDAcXFtfYYKmWdwUCS73BTqoywu2+11wt4gbS92+56u0cCw+vMw5lyn2p7SIB
 FHHtkaVSRXgfMVcHzLEipTi3AktGjPdJR9vi/pw2YmICznvzjkwEVXKeRqh4s9yRRDnC
 gYopijDKj+Gy4GUMdUcnPP4Dmj7av2Wo39Z7W9ofM3O1AcUi60RDGcWJPITk3629GWWp
 r+xlzIw622+nHzvd3oKRPkhIVEBW0unoXRDbfzlLP8h9mbSBgYeBoUX1J3p/shKjfG95 vA==
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37xbqk5h49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Apr 2021 07:43:49 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13FBgojb020753;
	Thu, 15 Apr 2021 11:43:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 37u3n8a2q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Apr 2021 11:43:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13FBhjG920775168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Apr 2021 11:43:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8B74203F;
	Thu, 15 Apr 2021 11:43:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DAB742042;
	Thu, 15 Apr 2021 11:43:42 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.63.240])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 15 Apr 2021 11:43:42 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 15 Apr 2021 17:13:41 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats
 inaccessible
In-Reply-To: <CAPcyv4iU3cmjRsDevDJmJc72xo-QffUu3SGCwvRh5bitG-facw@mail.gmail.com>
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
 <CAPcyv4iU3cmjRsDevDJmJc72xo-QffUu3SGCwvRh5bitG-facw@mail.gmail.com>
Date: Thu, 15 Apr 2021 17:13:41 +0530
Message-ID: <87k0p3lqmq.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iQBgl5K8NCzoTIPBHw0bbDpRO78xDHOG
X-Proofpoint-ORIG-GUID: iQBgl5K8NCzoTIPBHw0bbDpRO78xDHOG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_04:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150077
Message-ID-Hash: FCJS77LOXYKSECU6CGPK3EZKC7AMO5Z6
X-Message-ID-Hash: FCJS77LOXYKSECU6CGPK3EZKC7AMO5Z6
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FCJS77LOXYKSECU6CGPK3EZKC7AMO5Z6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for looking into this Dan,

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Apr 14, 2021 at 5:40 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> Currently drc_pmem_qeury_stats() generates a dev_err in case
>> "Enable Performance Information Collection" feature is disabled from
>> HMC. The error is of the form below:
>>
>> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
>>          performance stats, Err:-10
>>
>> This error message confuses users as it implies a possible problem
>> with the nvdimm even though its due to a disabled feature.
>>
>> So we fix this by explicitly handling the H_AUTHORITY error from the
>> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
>> error, saying that "Performance stats in-accessible".
>>
>> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index 835163f54244..9216424f8be3 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>>                 dev_err(&p->pdev->dev,
>>                         "Unknown performance stats, Err:0x%016lX\n", ret[0]);
>>                 return -ENOENT;
>> +       } else if (rc == H_AUTHORITY) {
>> +               dev_warn(&p->pdev->dev, "Performance stats in-accessible");
>> +               return -EPERM;
>
> So userspace can spam the kernel log? Why is kernel log message needed
> at all? EPERM told the caller what happened.
Currently this error message is only reported during probe of the
nvdimm. So userspace cannot directly spam kernel log.

The callsite for this function in papr_scm_nvdimm_init() doesnt handle
specific error codes. Instead in case of an error it only reports that
"Dimm performance stats are unavailable". The log message just
preceeding that mentions the real cause of failure. Thats why just
returning -EPERM wont be usefui.

Alternatively I can update papr_scm_nvdimm_init() to report the error
code returned from drc_pmem_query_stats().

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
