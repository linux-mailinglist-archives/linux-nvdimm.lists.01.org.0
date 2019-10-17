Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACADA44C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Oct 2019 05:19:14 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEC0010FCDE67;
	Wed, 16 Oct 2019 20:22:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 681EB10FCDE67
	for <linux-nvdimm@lists.01.org>; Wed, 16 Oct 2019 20:21:46 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H3CM1X159142;
	Wed, 16 Oct 2019 23:18:45 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vnppv2u9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2019 23:18:45 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9H3BW04024928;
	Thu, 17 Oct 2019 03:18:47 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma01wdc.us.ibm.com with ESMTP id 2vk6f71y6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2019 03:18:47 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H3IhxV62390568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2019 03:18:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A52DF78064;
	Thu, 17 Oct 2019 03:18:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BA1D7805F;
	Thu, 17 Oct 2019 03:18:42 +0000 (GMT)
Received: from [9.199.35.94] (unknown [9.199.35.94])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 17 Oct 2019 03:18:42 +0000 (GMT)
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: Dan Williams <dan.j.williams@intel.com>
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
 <7376f286-0947-61aa-7ebf-c50f32642ed8@linux.ibm.com>
 <CAPcyv4jrdAAxtrre4Ypt-+ZpuqKia5kLwCO4qfryshhxVj6eFA@mail.gmail.com>
 <2144f6dc-faab-3e93-d049-cc146c38258a@linux.ibm.com>
 <CAPcyv4iAz1OSDCKhNt+weBOTg1OsKbs6h740vG8P2NxRHbUrPw@mail.gmail.com>
 <07a4dd71-65f0-a911-60be-e3ea1ce8305b@linux.ibm.com>
 <CAPcyv4grR0o5jRH+hqPNqDW8rCmU4bUfctzPxGUg+mZN9h_8TQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <d99770e8-ae29-c38f-9daf-6965d5eab2cb@linux.ibm.com>
Date: Thu, 17 Oct 2019 08:48:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4grR0o5jRH+hqPNqDW8rCmU4bUfctzPxGUg+mZN9h_8TQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170022
Message-ID-Hash: W4BC4VGITTY7BTPHJ4WXUCIDE66HH7AW
X-Message-ID-Hash: W4BC4VGITTY7BTPHJ4WXUCIDE66HH7AW
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W4BC4VGITTY7BTPHJ4WXUCIDE66HH7AW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/17/19 8:34 AM, Dan Williams wrote:
> On Wed, Oct 16, 2019 at 7:43 PM Aneesh Kumar K.V


....

>>>
>> The error is printed by generic code and the failures are due to fixed
>> size. We can't workaround that using vmalloc=<size> option.
> 
> Darn.
> 
> Ok, explain to me again how this patch helps. This just seems to delay
> the inevitable failure a bit, but the end result is that the user
> needs to pick and choose which namespaces to enable after the kernel
> has tried to auto-probe namespaces.
>

Right now we map the entire namespace using I/O remap range while 
probing and if we find the namespace mode to be fsdax or devdax we unmap 
the namespace and map them back using direct-map range. This temporary 
mapping cause transient failures if two large namespaces were probed at 
the same time. We try to map the second names space in the I/O remap 
range while the first one is already mapped there. ie,

If we have two 6TB namespaces with an I/O remap range limit of 8TB. We 
can individually create these namespaces and enable/disable them because 
they are within the 8TB limit. But if we try to probe them together,
and if namespace1 is already mapped in the I/O remap range we have only 
2TB space left in the I/O remap range and trying to probe the second 
namespace at the same time fails due to lack of space to map the 
namespace during probing.

This is not an issue with raw/btt, because they keep the namespace 
always mapped in the I/O remap range and if we are able to create a 
namespace we can enable them together. (we do have the issue of creating 
large raw/btt namespace while other raw/btt namespaces are disabled and 
trying to enable them all together).

The fix proposed in this patch is to not map the full namespace range 
while probing. We just need to map the reserve block to find the 
namespace mode. Based on the detected namespace mode, we either use 
direct-map range or I/O range to map the full namespace.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
