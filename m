Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF8153EA2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 07:21:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E09AC10FC33FC;
	Wed,  5 Feb 2020 22:25:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0A8A10FC33FA
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 22:25:10 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669wwY144036
	for <linux-nvdimm@lists.01.org>; Thu, 6 Feb 2020 01:21:53 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhme24uw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 06 Feb 2020 01:21:52 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Thu, 6 Feb 2020 06:21:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 6 Feb 2020 06:21:46 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0166LkaH56033382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2020 06:21:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00CEBA4040;
	Thu,  6 Feb 2020 06:21:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C5A0A4053;
	Thu,  6 Feb 2020 06:21:43 +0000 (GMT)
Received: from [9.85.90.213] (unknown [9.85.90.213])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  6 Feb 2020 06:21:43 +0000 (GMT)
Subject: Re: [PATCH 2/5] mm/memremap_pages: Introduce memremap_compat_align()
To: Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <875zgl3fa9.fsf@mpe.ellerman.id.au>
 <CAPcyv4jVHnJbPYp1gqDnuwtEgt1NNHDt72vby7hK5dP43C+s8Q@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 6 Feb 2020 11:51:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jVHnJbPYp1gqDnuwtEgt1NNHDt72vby7hK5dP43C+s8Q@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20020606-4275-0000-0000-0000039E6A61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020606-4276-0000-0000-000038B296A0
Message-Id: <aecd7276-fb03-5269-6ca1-9a1fb2e23b95@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=994 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002060048
Message-ID-Hash: UYW23AJPJCNXFRFI57GPY5PK6TBYCL65
X-Message-ID-Hash: UYW23AJPJCNXFRFI57GPY5PK6TBYCL65
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UYW23AJPJCNXFRFI57GPY5PK6TBYCL65/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2/6/20 11:21 AM, Dan Williams wrote:
....

>>>
>>> Link: http://lore.kernel.org/r/CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com
>>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Reported-by: Jeff Moyer <jmoyer@redhat.com>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>   arch/powerpc/include/asm/io.h |   10 ++++++++++
>>>   drivers/nvdimm/pfn_devs.c     |    2 +-
>>>   include/linux/io.h            |   23 +++++++++++++++++++++++
>>>   include/linux/mmzone.h        |    1 +
>>>   4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> The powerpc change here looks fine to me.
>>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> Thanks Michael, unfortunately the kbuild robot just woke up and said
> that mips does not like including mmzone.h from io.h. The
> entanglements look intractable.
> 
> Is there a file I can stash a strong definition of
> memremap_compat_align(), maybe arch/powerpc/mm/mem.c? Then I can put a
> generic __weak definition in mm/memremap.c rather than play header
> file include games.
> 


arch/powerpc/mm/ioremap.c ?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
