Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80228353B21
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Apr 2021 05:47:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0448C100EBBBB;
	Sun,  4 Apr 2021 20:47:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AA0E100ED4A4
	for <linux-nvdimm@lists.01.org>; Sun,  4 Apr 2021 20:47:12 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1353Xu4r178885;
	Sun, 4 Apr 2021 23:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fS17YGZlnRxBEsmZlS1zMSRS74sXkIfkrqbZYkQdVTE=;
 b=Of5P/9TMdqd/JA+rfgdQdOkuVW2HOFBFA318v5JCtIy9CI+L5WSFZ54RLcwD3so6euEy
 LVrHYuetP61X2WepS9CXRa+W4LjaWipQiQ0k45FbhiUmixdOz7v9Cxlow9rhZ9/2wmL8
 /KCEnR2HDBHQkBJMhT0DUiAx9HWH2R0AiyHWKCGeWby9++jQLjfPlObszZ5WJNuryrYH
 F3y8q+z8S5q0oW0pRgKIQCbTKKll6XD7/wWhTQy4XXRKH8UOPL2sfZYgdYfO4DfvZzbl
 I0eJwg8zpikYy6jmDqSLBkTBvu2IFxMp7fmeihRPnIzFSwWKbk7yv3/N7yrLnsaHVs3i LQ==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37q603wwag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Apr 2021 23:47:10 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1353gmIm009827;
	Mon, 5 Apr 2021 03:47:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 37q2n2ry2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Apr 2021 03:47:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1353kjT932768468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Apr 2021 03:46:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD8A14C04A;
	Mon,  5 Apr 2021 03:47:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FC3A4C040;
	Mon,  5 Apr 2021 03:47:04 +0000 (GMT)
Received: from [9.85.75.170] (unknown [9.85.75.170])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  5 Apr 2021 03:47:03 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/papr_scm: Implement support for H_SCM_FLUSH
 hcall
To: Michael Ellerman <ellerman@au1.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>, sbhat@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-nvdimm@lists.01.org
References: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
 <87mtul6xzj.fsf@linux.ibm.com> <87zgyjwrnv.fsf@mpe.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <cbc59da3-3206-9ad5-fa8f-8fcd1df510ec@linux.ibm.com>
Date: Mon, 5 Apr 2021 09:17:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <87zgyjwrnv.fsf@mpe.ellerman.id.au>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c7pV3CUuqn9-sktYxpG-_Wg-MSbId8oQ
X-Proofpoint-GUID: c7pV3CUuqn9-sktYxpG-_Wg-MSbId8oQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050022
Message-ID-Hash: 3J7BLOL5N3AAE7UEKZ3T7UGJ2EQH2MVY
X-Message-ID-Hash: 3J7BLOL5N3AAE7UEKZ3T7UGJ2EQH2MVY
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-doc@vger.kernel.org, vaibhav@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3J7BLOL5N3AAE7UEKZ3T7UGJ2EQH2MVY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 3/31/21 3:50 PM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>>
>>> Add support for ND_REGION_ASYNC capability if the device tree
>>> indicates 'ibm,hcall-flush-required' property in the NVDIMM node.
>>> Flush is done by issuing H_SCM_FLUSH hcall to the hypervisor.
>>>
>>> If the flush request failed, the hypervisor is expected to
>>> to reflect the problem in the subsequent nvdimm H_SCM_HEALTH call.
>>>
>>> This patch prevents mmap of namespaces with MAP_SYNC flag if the
>>> nvdimm requires an explicit flush[1].
>>>
>>> References:
>>> [1] https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c
>>
>>
>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Do we need an ack from nvdimm folks on this?
> 
> Or is it entirely powerpc internal (seems like it from the diffstat)?
> 

This is within powerpc and we are implementing details w.r.t PAPR spec. 
There is a Qemu implementation that is getting reviewed here
https://lore.kernel.org/linux-nvdimm/161650723087.2959.8703728357980727008.stgit@6532096d84d3

But with respect to this patch, we can take that independent of the Qemu 
backend implementation.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
