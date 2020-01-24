Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E677147905
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jan 2020 08:34:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C9221007B8F4;
	Thu, 23 Jan 2020 23:37:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EBE810097E00
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jan 2020 23:37:27 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O7Rs9x102794
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 02:34:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xqmjt45mj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 02:34:08 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Fri, 24 Jan 2020 07:34:06 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 24 Jan 2020 07:34:04 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00O7Y4N150069578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2020 07:34:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E44CFA4055;
	Fri, 24 Jan 2020 07:34:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF76A4040;
	Fri, 24 Jan 2020 07:34:02 +0000 (GMT)
Received: from [9.204.201.20] (unknown [9.204.201.20])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2020 07:34:02 +0000 (GMT)
Subject: Re: [PATCH v4 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: Dan Williams <dan.j.williams@intel.com>
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
 <20200120140749.69549-2-aneesh.kumar@linux.ibm.com>
 <CAPcyv4jcZhQcKr=0OGWc1aZb0OQ1ws2edd-LZMR-EJ_Z2174Sg@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 24 Jan 2020 13:04:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jcZhQcKr=0OGWc1aZb0OQ1ws2edd-LZMR-EJ_Z2174Sg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20012407-0028-0000-0000-000003D3F0D9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012407-0029-0000-0000-000024982E7B
Message-Id: <5fd11235-5f26-b10a-140f-ef24214c85b1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_01:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=869
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001240061
Message-ID-Hash: VK7B5GGRWEQPHF37R2MDLCD7OAJ2WB7G
X-Message-ID-Hash: VK7B5GGRWEQPHF37R2MDLCD7OAJ2WB7G
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VK7B5GGRWEQPHF37R2MDLCD7OAJ2WB7G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 1/24/20 11:27 AM, Dan Williams wrote:
> On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
>

....

>>
>> +unsigned long arch_namespace_map_size(void)
>> +{
>> +       return PAGE_SIZE;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
>> +
>> +
>>   static void __cpa_flush_all(void *arg)
>>   {
>>          unsigned long cache = (unsigned long)arg;
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index 9df091bd30ba..a3476dbd2656 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -284,4 +284,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
>>   }
>>   #endif
>>
>> +unsigned long arch_namespace_map_size(void);
> 
> This property is more generic than the nvdimm namespace mapping size,
> it's more the fundamental remap granularity that the architecture
> supports. So I would expect this to be defined in core header files.
> Something like:
> 
> diff --git a/include/linux/io.h b/include/linux/io.h
> index a59834bc0a11..58b3b2091dbb 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -155,6 +155,13 @@ enum {
>   void *memremap(resource_size_t offset, size_t size, unsigned long flags);
>   void memunmap(void *addr);
> 
> +#ifndef memremap_min_align
> +static inline unsigned int memremap_min_align(void)
> +{
> +       return PAGE_SIZE;
> +}
> +#endif
> +


Should that be memremap_pages_min_align()?

>   /*
>    * On x86 PAT systems we have memory tracking that keeps track of
>    * the allowed mappings on memory ranges. This tracking works for
> 
> ...and then have a definition is asm/io.h like this:
> 
> unsigned int memremap_min_align(void);
> #define memremap_min_align memremap_min_align
> 
> That way only architectures that want to opt out of the default need
> to define something in their local header.
> 

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
