Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17710363446
	for <lists+linux-nvdimm@lfdr.de>; Sun, 18 Apr 2021 09:59:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24E40100EF27E;
	Sun, 18 Apr 2021 00:59:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B1AC6100EF25B
	for <linux-nvdimm@lists.01.org>; Sun, 18 Apr 2021 00:58:56 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13I7YDqT121739;
	Sun, 18 Apr 2021 03:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ULaC95HYjCDtIig+69jp0n4CTfNHbL+8hAecd284Ipw=;
 b=HW+r8U+3DyprtpAdNGDLyfshuM6puZ3FdPlVJYdSobpw0dZKVbQ/4w8D4FLd7WtAHsLo
 PCt9UCFjMm370AKrW/NPdLJaPymYoERph1+5SY93DeMC/Hz226ZBo/7BVRiX0nhg+G4L
 nf5y1QdBKNeg8HLML2oVS4J94FypyyYej1aSFZR8FyKBfdh6ofVwO7oW5Q0PQp8m06f4
 lRUfdHKd6kw2c2EiVe92yAcwz0xtgwsgokgvHHdeZ6ii8t1mguit8F5HFUmXjSWqkwaA
 SvrbV56eMRVBXGVrgGqUuMTNAblKMiiwyb4Fncx2y2E3lxSoylqyHzGbTkjDN0C2Fv4t TQ==
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0b-001b2d01.pphosted.com with ESMTP id 380crakkcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Apr 2021 03:58:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13I7uXae010621;
	Sun, 18 Apr 2021 07:58:51 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma02dal.us.ibm.com with ESMTP id 37yqa9k8wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Apr 2021 07:58:51 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13I7woRW15860200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Apr 2021 07:58:50 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50317124055;
	Sun, 18 Apr 2021 07:58:50 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44067124053;
	Sun, 18 Apr 2021 07:58:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.108])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Sun, 18 Apr 2021 07:58:47 +0000 (GMT)
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats
 inaccessible
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Ira Weiny <ira.weiny@intel.com>
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
 <20210414153625.GB1904484@iweiny-DESK2.sc.intel.com>
 <87lf9kkfaj.fsf@vajain21.in.ibm.com>
 <20210414212417.GC1904484@iweiny-DESK2.sc.intel.com>
 <87h7k7lqf8.fsf@vajain21.in.ibm.com>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <50e2df73-ae82-89da-a780-5dcf07328d96@linux.ibm.com>
Date: Sun, 18 Apr 2021 13:28:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87h7k7lqf8.fsf@vajain21.in.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vtromN3D3YzRZv2cxxJN6j5OZt-BmHnf
X-Proofpoint-ORIG-GUID: vtromN3D3YzRZv2cxxJN6j5OZt-BmHnf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_16:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104180053
Message-ID-Hash: 62VR2DHSTGFQQWIJXAXAOBQHYP5X2CII
X-Message-ID-Hash: 62VR2DHSTGFQQWIJXAXAOBQHYP5X2CII
X-MailFrom: kjain@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/62VR2DHSTGFQQWIJXAXAOBQHYP5X2CII/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 4/15/21 5:18 PM, Vaibhav Jain wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
>> On Wed, Apr 14, 2021 at 09:51:40PM +0530, Vaibhav Jain wrote:
>>> Thanks for looking into this patch Ira,
>>>
>>> Ira Weiny <ira.weiny@intel.com> writes:
>>>
>>>> On Wed, Apr 14, 2021 at 06:10:26PM +0530, Vaibhav Jain wrote:
>>>>> Currently drc_pmem_qeury_stats() generates a dev_err in case
>>>>> "Enable Performance Information Collection" feature is disabled from
>>>>> HMC. The error is of the form below:
>>>>>
>>>>> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
>>>>> 	 performance stats, Err:-10
>>>>>
>>>>> This error message confuses users as it implies a possible problem
>>>>> with the nvdimm even though its due to a disabled feature.
>>>>>
>>>>> So we fix this by explicitly handling the H_AUTHORITY error from the
>>>>> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
>>>>> error, saying that "Performance stats in-accessible".
>>>>>
>>>>> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
>>>>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>>>>> ---
>>>>>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>>>>> index 835163f54244..9216424f8be3 100644
>>>>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>>>>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>>>>> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>>>>>  		dev_err(&p->pdev->dev,
>>>>>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
>>>>>  		return -ENOENT;
>>>>> +	} else if (rc == H_AUTHORITY) {
>>>>> +		dev_warn(&p->pdev->dev, "Performance stats in-accessible");
>>>>> +		return -EPERM;
>>>>
>>>> Is this because of a disabled feature or because of permissions?
>>>
>>> Its because of a disabled feature that revokes permission for a guest to
>>> retrieve performance statistics.
>>>
>>> The feature is called "Enable Performance Information Collection" and
>>> once disabled the hcall H_SCM_PERFORMANCE_STATS returns an error
>>> H_AUTHORITY indicating that the guest doesn't have permission to retrieve
>>> performance statistics.
>>
>> In that case would it be appropriate to have the error message indicate a
>> permission issue?
>>
>> Something like 'permission denied'?
> 
> Yes, Something like "Permission denied while accessing performance
> stats" might be more clear and intuitive.

Hi Vaibhav,
   Thanks for the patch. I agree with Ira and above warning message with "Permission denied" looks more clear.
With that change, patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Will update the warn message in v2.
> 
>>
>> Ira
>>
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
