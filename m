Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E5DA417
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 05:05:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 824F110FCDE5E;
	Wed, 16 Oct 2019 20:08:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 036C510FCDE5C
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 20:08:05 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H331JP069182;
	Wed, 16 Oct 2019 23:05:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vpd0gccnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2019 23:05:05 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9H31vWm002546;
	Thu, 17 Oct 2019 03:05:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma04wdc.us.ibm.com with ESMTP id 2vk6f7hwt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2019 03:05:03 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H353EC58065242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2019 03:05:03 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24B9B7805C;
	Thu, 17 Oct 2019 03:05:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C687805F;
	Thu, 17 Oct 2019 03:05:01 +0000 (GMT)
Received: from [9.199.35.94] (unknown [9.199.35.94])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 17 Oct 2019 03:05:01 +0000 (GMT)
Subject: Re: [PATCH] Consider namespace with size as active namespace
To: "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
References: <20190807043915.30239-1-aneesh.kumar@linux.ibm.com>
 <73abe6519435d3c0cfab32633c969b5efe16c0e4.camel@intel.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <269a4c1c-f1c5-6b18-3482-a9640d0a816b@linux.ibm.com>
Date: Thu, 17 Oct 2019 08:35:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <73abe6519435d3c0cfab32633c969b5efe16c0e4.camel@intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170021
Message-ID-Hash: WOR2RLXIAVGLBMFDZ5GOLDUNYOYH7HIU
X-Message-ID-Hash: WOR2RLXIAVGLBMFDZ5GOLDUNYOYH7HIU
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WOR2RLXIAVGLBMFDZ5GOLDUNYOYH7HIU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/17/19 4:01 AM, Verma, Vishal L wrote:
> On Wed, 2019-08-07 at 10:09 +0530, Aneesh Kumar K.V wrote:
>> This enables us to mark a namespace as disabled due to pfn_sb
>> mismatch. We have pending kernel patches at that will mark the
>> namespace disabled when the PAGE_SIZE or struct page size didn't
>> match with the value stored in pfn_sb.
>>
>> We need to make sure we don't use this disabled namespace as seed namespace
>> for new namespace creation.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   ndctl/namespace.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
>> index 58a9e3c53474..1f212a2b3a9b 100644
>> --- a/ndctl/namespace.c
>> +++ b/ndctl/namespace.c
>> @@ -455,7 +455,8 @@ static int is_namespace_active(struct ndctl_namespace *ndns)
>>   	return ndns && (ndctl_namespace_is_enabled(ndns)
>>   		|| ndctl_namespace_get_pfn(ndns)
>>   		|| ndctl_namespace_get_dax(ndns)
>> -		|| ndctl_namespace_get_btt(ndns));
>> +		|| ndctl_namespace_get_btt(ndns)
>> +		|| ndctl_namespace_get_size(ndns));
>>   }
>>   
>>   /*
> 
> Hi Aneesh,
> 
> I was going through pending ndctl patches and found this - this seems to
> break some of the unit tests. Also, have the relevant kernel patches
> been posted?

Yes. The required changes in kernel got merged as part of

commit 1c97afa714098aab2ca588cc654f8ff67dd46dcb
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Thu Sep 5 21:15:58 2019 +0530

     libnvdimm/pmem: Advance namespace seed for specific probe errors


> 
> The failing unit tests are sector-mode.sh and dax.sh
> 

I will see if i can run them on ppc64. We still had issues in getting 
ndctl check to be running on ppc64.

-aneesh


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
