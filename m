Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1E20ED18
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 07:05:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8044511202AC7;
	Mon, 29 Jun 2020 22:05:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5BF6E111FF492
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 22:05:55 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U52bVR100668;
	Tue, 30 Jun 2020 01:05:52 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ycd4sbfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 01:05:52 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U50coD007733;
	Tue, 30 Jun 2020 05:05:51 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04wdc.us.ibm.com with ESMTP id 31x5vx310b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 05:05:51 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U55o3R27984198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2020 05:05:50 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E027C605D;
	Tue, 30 Jun 2020 05:05:50 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8508FC6057;
	Tue, 30 Jun 2020 05:05:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.48.28])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2020 05:05:47 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 7/8] powerpc/pmem: Add WARN_ONCE to catch the wrong
 usage of pmem flush functions.
In-Reply-To: <CAPcyv4giMdgjNVudw1q7p-UpyLMTHTqTad=2Ks8ATNo==edKvQ@mail.gmail.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-8-aneesh.kumar@linux.ibm.com>
 <CAPcyv4giMdgjNVudw1q7p-UpyLMTHTqTad=2Ks8ATNo==edKvQ@mail.gmail.com>
Date: Tue, 30 Jun 2020 10:35:45 +0530
Message-ID: <87d05hgn2u.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 cotscore=-2147483648 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300033
Message-ID-Hash: 7TZ52UBKPRV4C3ES7E26X63VE27ZRS4H
X-Message-ID-Hash: 7TZ52UBKPRV4C3ES7E26X63VE27ZRS4H
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7TZ52UBKPRV4C3ES7E26X63VE27ZRS4H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Jun 29, 2020 at 6:58 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> We only support persistent memory on P8 and above. This is enforced by the
>> firmware and further checked on virtualzied platform during platform init.
>> Add WARN_ONCE in pmem flush routines to catch the wrong usage of these.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/cacheflush.h | 2 ++
>>  arch/powerpc/lib/pmem.c               | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
>> index 95782f77d768..1ab0fa660497 100644
>> --- a/arch/powerpc/include/asm/cacheflush.h
>> +++ b/arch/powerpc/include/asm/cacheflush.h
>> @@ -103,6 +103,8 @@ static inline void  arch_pmem_flush_barrier(void)
>>  {
>>         if (cpu_has_feature(CPU_FTR_ARCH_207S))
>>                 asm volatile(PPC_PHWSYNC ::: "memory");
>> +       else
>> +               WARN_ONCE(1, "Using pmem flush on older hardware.");
>
> This seems too late to be making this determination. I'd expect the
> driver to fail to successfully bind default if this constraint is not
> met.

We do that in Patch 1.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
