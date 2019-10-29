Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45742E7F3C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 05:35:10 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBD2A100EA52B;
	Mon, 28 Oct 2019 21:35:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BD7C100EA529
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 21:35:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9T3IRRO098805;
	Tue, 29 Oct 2019 00:35:00 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vxbdsw1xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2019 00:35:00 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
	by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9T4Ylqc011496;
	Tue, 29 Oct 2019 04:35:00 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma05wdc.us.ibm.com with ESMTP id 2vvds6r57e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2019 04:34:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9T4YvRX59310470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2019 04:34:57 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E20D6A051;
	Tue, 29 Oct 2019 04:34:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A91A36A04F;
	Tue, 29 Oct 2019 04:34:55 +0000 (GMT)
Received: from [9.204.200.92] (unknown [9.204.200.92])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 29 Oct 2019 04:34:55 +0000 (GMT)
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: Ira Weiny <ira.weiny@intel.com>
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <20191028212142.GB9826@iweiny-DESK2.sc.intel.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <cfb6cd96-3f81-7ee8-150f-69924d446540@linux.ibm.com>
Date: Tue, 29 Oct 2019 10:04:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028212142.GB9826@iweiny-DESK2.sc.intel.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290027
Message-ID-Hash: V4UYUNWWGGB7CVEIECAHCF6FFGEUYYBF
X-Message-ID-Hash: V4UYUNWWGGB7CVEIECAHCF6FFGEUYYBF
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: mpe@ellerman.id.au, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V4UYUNWWGGB7CVEIECAHCF6FFGEUYYBF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/29/19 2:51 AM, Ira Weiny wrote:
>> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
>> index 377712e85605..2e661a08dae5 100644
>> --- a/arch/powerpc/lib/pmem.c
>> +++ b/arch/powerpc/lib/pmem.c
>> @@ -17,14 +17,31 @@ void arch_wb_cache_pmem(void *addr, size_t size)
>>   	unsigned long start = (unsigned long) addr;
>>   	flush_dcache_range(start, start + size);
>>   }
>> -EXPORT_SYMBOL(arch_wb_cache_pmem);
>> +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> 
> Unrelated change?
> 
>

Yes, will split that as a separate patch.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
