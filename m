Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48EFEC3C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 16 Nov 2019 13:15:58 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D899D100DC3D9;
	Sat, 16 Nov 2019 04:17:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42F78100DC3D8
	for <linux-nvdimm@lists.01.org>; Sat, 16 Nov 2019 04:17:06 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGC730L065502;
	Sat, 16 Nov 2019 07:15:42 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2waeh6bd1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2019 07:15:41 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAGCAEGF020642;
	Sat, 16 Nov 2019 12:15:40 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma02wdc.us.ibm.com with ESMTP id 2wa8r5jv54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2019 12:15:40 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAGCFd3l47579472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2019 12:15:39 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A5BA6A04F;
	Sat, 16 Nov 2019 12:15:39 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2016A054;
	Sat, 16 Nov 2019 12:15:37 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.44.87])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Sat, 16 Nov 2019 12:15:36 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size validation arch dependent
In-Reply-To: <87o8xp5lo9.fsf@linux.ibm.com>
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com> <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com> <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com> <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com> <87o8xp5lo9.fsf@linux.ibm.com>
Date: Sat, 16 Nov 2019 17:45:34 +0530
Message-ID: <8736eohva1.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-16_03:2019-11-15,2019-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911160114
Message-ID-Hash: BNSX2VNYTEBG3NQM6JG5FIIDRW6BM3AA
X-Message-ID-Hash: BNSX2VNYTEBG3NQM6JG5FIIDRW6BM3AA
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BNSX2VNYTEBG3NQM6JG5FIIDRW6BM3AA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Dan,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Wed, Oct 30, 2019 at 10:35 PM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>> [..]
>>> > True, for the pfn device and the device-dax mapping size, but I'm
>>> > suggesting adding another instance of alignment control at the raw
>>> > namespace level. That would need to be disconnected from the
>>> > device-dax page mapping granularity.
>>> >
>>>
>>> Can you explain what you mean by raw namespace level ? We don't have
>>> multiple values against which we need to check the alignment of
>>> namespace start and namespace size.
>>>
>>> If you can outline how and where you would like to enforce that check I
>>> can start working on it.
>>>
>>
>> What I mean is that the process of setting up a pfn namespace goes
>> something like this in shell script form:
>>
>> 1/ echo $size > /sys/bus/nd/devices/$namespace/size
>> 2/ echo $namespace > /sys/bus/nd/devices/$pfn/namespace
>> 3/ echo $pfn_align > /sys/bus/nd/devices/$pfn/align
>>
>> What I'm suggesting is add an optional 0th step that does:
>>
>> echo $raw_align > /sys/bus/nd/devices/$namespace/align
>>
>> Where the raw align needs to be needs to be max($pfn_align,
>> arch_mapping_granulariy).
>
>
> I started looking at this and was wondering about userspace being aware
> of the direct-map mapping size. We can figure that out by parsing kernel
> log
>
> [    0.000000] Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
>
>
> But I am not sure we want to do that. There is not set of raw_align
> value to select. What we need to make sure is the below.
>
> 1) While creating a namespace we need to make sure that namespace size
> is multiple of direct-map mapping size. If we ensure that
> size is aligned, we should also get the namespace start to be aligned?
>
> 2) While initialzing a namespace by scanning label area, we need to make
> sure every namespace in the region satisfy the above requirement. If not
> we should mark the region disabled. 
>
>
>>
>> So on powerpc where PAGE_SIZE < arch_mapping_granulariy, the following:
>>
>> cat /sys/bus/nd/devices/$namespace/supported_aligns
>>
>> ...would show the same output as:
>>
>> cat /sys/bus/nd/devices/$pfn/align
>>
>> ...but with any alignment choice less than arch_mapping_granulariy removed.
>>
>
> I am not sure why we need to do that. For example: even if we have
> direct-map mapping size as PAGE_SIZE (64K), we still should allow an user
> mapping with hugepage size (16M)?
>


Considering the direct-map map size is not going to be user selectable,
do you agree that we can skip the above step 0 configuration you
suggested.

The changes proposed in the patch series essentially does the rest.

1) It validate the size against the arch specific limit during
namespace creation. (part of step 1)
2) It also disable initializing a region if it find the size not
correctly aligned as per the platform requirement.
3) Direct map  mapping size is different from supported_alignment for a
namespace. The supported alignment controls what possible PAGE SIZE user want the
namespace to be mapped to user space.


With the above do you think the current patch series is good?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
