Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EC210259
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 05:09:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6798111C7C54;
	Tue, 30 Jun 2020 20:09:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39AEC11022291
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 20:09:17 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06133MeD089383;
	Tue, 30 Jun 2020 23:09:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32083f0dc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 23:09:12 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061340tk091798;
	Tue, 30 Jun 2020 23:09:12 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32083f0db3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 23:09:11 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06134gCO020898;
	Wed, 1 Jul 2020 03:09:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma01fra.de.ibm.com with ESMTP id 31wyyatm5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 03:09:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0613972p41746660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2020 03:09:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14FC2A4057;
	Wed,  1 Jul 2020 03:09:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22851A4053;
	Wed,  1 Jul 2020 03:09:05 +0000 (GMT)
Received: from [9.79.220.179] (unknown [9.79.220.179])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2020 03:09:04 +0000 (GMT)
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: Dan Williams <dan.j.williams@intel.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
 <20200629160940.GU21462@kitsune.suse.cz> <87lfk5hahc.fsf@linux.ibm.com>
 <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
 <20200630085413.GW21462@kitsune.suse.cz>
 <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
 <CAPcyv4gHHjifQcLMdVgo9CyixHxe6OkCYdQ7Jfu2YB7tBqpDNg@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <4a7bf5c8-a5c7-4292-c7ad-89bcefd7b22d@linux.ibm.com>
Date: Wed, 1 Jul 2020 08:39:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gHHjifQcLMdVgo9CyixHxe6OkCYdQ7Jfu2YB7tBqpDNg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_01:2020-07-01,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=897 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010019
Message-ID-Hash: Q5PMYO67RHMYALOBWYY2UDKPUWF6UOUO
X-Message-ID-Hash: Q5PMYO67RHMYALOBWYY2UDKPUWF6UOUO
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q5PMYO67RHMYALOBWYY2UDKPUWF6UOUO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 7/1/20 1:15 AM, Dan Williams wrote:
> On Tue, Jun 30, 2020 at 2:21 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> [..]
>>>> The bio argument isn't for range based flushing, it is for flush
>>>> operations that need to complete asynchronously.
>>> How does the block layer determine that the pmem device needs
>>> asynchronous fushing?
>>>
>>
>>          set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>>
>> and dax_synchronous(dev)
> 
> Yes, but I think it is overkill to have an indirect function call just
> for a single instruction.
> 
> How about something like this instead, to share a common pmem_wmb()
> across x86 and powerpc.
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 20ff30c2ab93..b14009060c83 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1180,6 +1180,13 @@ int nvdimm_flush(struct nd_region *nd_region,
> struct bio *bio)
>   {
>          int rc = 0;
> 
> +       /*
> +        * pmem_wmb() is needed to 'sfence' all previous writes such
> +        * that they are architecturally visible for the platform buffer
> +        * flush.
> +        */
> +       pmem_wmb();
> +
>          if (!nd_region->flush)
>                  rc = generic_nvdimm_flush(nd_region);
>          else {
> @@ -1206,17 +1213,14 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
>          idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));
> 
>          /*
> -        * The first wmb() is needed to 'sfence' all previous writes
> -        * such that they are architecturally visible for the platform
> -        * buffer flush.  Note that we've already arranged for pmem
> -        * writes to avoid the cache via memcpy_flushcache().  The final
> -        * wmb() ensures ordering for the NVDIMM flush write.
> +        * Note that we've already arranged for pmem writes to avoid the
> +        * cache via memcpy_flushcache().  The final wmb() ensures
> +        * ordering for the NVDIMM flush write.
>           */
> -       wmb();


The series already convert this to pmem_wmb().

>          for (i = 0; i < nd_region->ndr_mappings; i++)
>                  if (ndrd_get_flush_wpq(ndrd, i, 0))
>                          writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> -       wmb();
> +       pmem_wmb();


Should this be pmem_wmb()? This is ordering the above writeq() right?

> 
>          return 0;
>   }
> 

This still results in two pmem_wmb() on platforms that doesn't have 
flush_wpq. I was trying to avoid that by adding a nd_region->flush call 
back.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
