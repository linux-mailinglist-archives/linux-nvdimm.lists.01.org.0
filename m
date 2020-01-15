Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D547713CAF1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 18:27:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5DD110097DC7;
	Wed, 15 Jan 2020 09:30:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44D4510097DC6
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 09:30:27 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FHR6hv045412
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:27:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbvgmadj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:27:07 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Wed, 15 Jan 2020 17:27:05 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 15 Jan 2020 17:27:03 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FHQD9Z50004224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2020 17:26:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5164752052;
	Wed, 15 Jan 2020 17:27:02 +0000 (GMT)
Received: from [9.85.72.166] (unknown [9.85.72.166])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 721CD52059;
	Wed, 15 Jan 2020 17:27:01 +0000 (GMT)
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain
 values
To: Jeff Moyer <jmoyer@redhat.com>
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
 <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 15 Jan 2020 22:57:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011517-0012-0000-0000-0000037DA037
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011517-0013-0000-0000-000021B9D18B
Message-Id: <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150133
Message-ID-Hash: XUF44GSOHMA36FL7NFP4USOSPZ4OCS5W
X-Message-ID-Hash: XUF44GSOHMA36FL7NFP4USOSPZ4OCS5W
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XUF44GSOHMA36FL7NFP4USOSPZ4OCS5W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/15/20 10:25 PM, Jeff Moyer wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> Currently, kernel shows the below values
>> 	"persistence_domain":"cpu_cache"
>> 	"persistence_domain":"memory_controller"
>> 	"persistence_domain":"unknown"
>>
>> This patch updates the meaning of these values such that
>>
>> "cpu_cache" indicates no extra instructions is needed to ensure the persistence
>> of data in the pmem media on power failure.
>>
>> "memory_controller" indicates platform provided instructions need to be issued
>> as per documented sequence to make sure data flushed is guaranteed to be on pmem
>> media in case of system power loss.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
>>   include/linux/libnvdimm.h                 | 6 +++---
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>> index c2ef320ba1bf..26a5ef263758 100644
>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>> @@ -360,8 +360,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>   
>>   	if (p->is_volatile)
>>   		p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
>> -	else
>> +	else {
>> +		/*
>> +		 * We need to flush things correctly to guarantee persistance
>> +		 */
>> +		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>>   		p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
>> +	}
>>   	if (!p->region) {
>>   		dev_err(dev, "Error registering region %pR from %pOF\n",
>>   				ndr_desc.res, p->dn);
> 
> Would you also update of_pmem to indicate the persistence domain,
> please?
> 

sure.


>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index f2a33f2e3ba8..9126737377e1 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -52,9 +52,9 @@ enum {
>>   	 */
>>   	ND_REGION_PERSIST_CACHE = 1,
>>   	/*
>> -	 * Platform provides mechanisms to automatically flush outstanding
>> -	 * write data from memory controler to pmem on system power loss.
>> -	 * (ADR)
>> +	 * Platform provides instructions to flush data such that on completion
>> +	 * of the instructions, data flushed is guaranteed to be on pmem even
>> +	 * in case of a system power loss.
> 
> I find the prior description easier to understand.


I was trying to avoid the term 'automatically, 'memory controler' and 
ADR. Can I update the above as

/*
  * Platform provides mechanisms to flush outstanding write data
  * to pmem on system power loss.
  */


-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
