Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945EBD8824
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 07:29:41 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A110210FCD755;
	Tue, 15 Oct 2019 22:32:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 750E710FCD753
	for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 22:32:36 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G5MWVg080106;
	Wed, 16 Oct 2019 01:29:32 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vnt73vhfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2019 01:29:31 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9G5PwIS025736;
	Wed, 16 Oct 2019 05:29:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by ppma01wdc.us.ibm.com with ESMTP id 2vk6f6snss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2019 05:29:33 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G5TUKq5898924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2019 05:29:30 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A20528058;
	Wed, 16 Oct 2019 05:29:30 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69A792805C;
	Wed, 16 Oct 2019 05:29:29 +0000 (GMT)
Received: from [9.204.201.52] (unknown [9.204.201.52])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2019 05:29:29 +0000 (GMT)
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: Dan Williams <dan.j.williams@intel.com>
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com>
Date: Wed, 16 Oct 2019 10:59:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160050
Message-ID-Hash: VWNE4FJHFQ3RC2SAU74QZTGFM4Y4CFTW
X-Message-ID-Hash: VWNE4FJHFQ3RC2SAU74QZTGFM4Y4CFTW
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWNE4FJHFQ3RC2SAU74QZTGFM4Y4CFTW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/16/19 3:32 AM, Dan Williams wrote:
> On Tue, Oct 15, 2019 at 8:33 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> nvdimm core currently maps the full namespace to an ioremap range
>> while probing the namespace mode. This can result in probe failures
>> on architectures that have limited ioremap space.
> 
> Is there a #define for that limit?
> 

Arch specific #define. For example. ppc64 have different limits based on 
platform and translation mode. Hash translation with 4k PAGE_SIZE limit 
ioremap range to 8TB.

>> nvdimm core can avoid this failure by only mapping the reserver block area to
>> check for pfn superblock type and map the full namespace resource only before
>> using the namespace. nvdimm core use ioremap range only for the raw and btt
>> namespace and we can limit the max namespace size for these two modes. For
>> both fsdax and devdax this change enables nvdimm to map namespace larger
>> that ioremap limit.
> 
> If the direct map has more space I think it would be better to add a
> way to use that to map for all namespaces rather than introduce
> arbitrary failures based on the mode.
> 
> I would buy a performance argument to avoid overmapping, but for
> namespace access compatibility where an alternate mapping method would
> succeed I think we should aim for that to be used instead. Thoughts?
> 

That would require to have struct page allocated for these range and 
both raw and btt don't need a struct page backing?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
