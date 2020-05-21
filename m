Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090631DCFC4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 16:32:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8BDB1003EFB1;
	Thu, 21 May 2020 07:29:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=michaele@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE0EF1003EFAF
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 07:29:12 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04LEVufn147495;
	Thu, 21 May 2020 10:32:10 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 315pfwseqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2020 10:31:57 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04LEVQ0o011028;
	Thu, 21 May 2020 14:31:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04fra.de.ibm.com with ESMTP id 313wne2dwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2020 14:31:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04LEVNbt64749568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2020 14:31:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4A764C04A;
	Thu, 21 May 2020 14:31:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 129BC4C046;
	Thu, 21 May 2020 14:31:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2020 14:31:23 +0000 (GMT)
Received: from localhost (unknown [9.102.46.56])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2C0B1A01EB;
	Fri, 22 May 2020 00:31:17 +1000 (AEST)
From: Michael Ellerman <michaele@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v7 3/5] powerpc/papr_scm: Fetch nvdimm health information from PHYP
In-Reply-To: <87tv0awmr5.fsf@linux.ibm.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-4-vaibhav@linux.ibm.com> <20200520145430.GB3660833@iweiny-DESK2.sc.intel.com> <87tv0awmr5.fsf@linux.ibm.com>
Date: Fri, 22 May 2020 00:31:41 +1000
Message-ID: <87k115gy0i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_08:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 cotscore=-2147483648
 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 mlxlogscore=985 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210106
Message-ID-Hash: 6V5T3FO5TGB6GQRD2IPOMF3BN2HB6BLJ
X-Message-ID-Hash: 6V5T3FO5TGB6GQRD2IPOMF3BN2HB6BLJ
X-MailFrom: michaele@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6V5T3FO5TGB6GQRD2IPOMF3BN2HB6BLJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> Thanks for reviewing this this patch Ira. My responses below:
> Ira Weiny <ira.weiny@intel.com> writes:
>> On Wed, May 20, 2020 at 12:30:56AM +0530, Vaibhav Jain wrote:
>>> Implement support for fetching nvdimm health information via
>>> H_SCM_HEALTH hcall as documented in Ref[1]. The hcall returns a pair
>>> of 64-bit big-endian integers, bitwise-and of which is then stored in
>>> 'struct papr_scm_priv' and subsequently partially exposed to
>>> user-space via newly introduced dimm specific attribute
>>> 'papr/flags'. Since the hcall is costly, the health information is
>>> cached and only re-queried, 60s after the previous successful hcall.
...
>>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>>> index f35592423380..142636e1a59f 100644
>>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>>> @@ -39,6 +78,15 @@ struct papr_scm_priv {
>>>  	struct resource res;
>>>  	struct nd_region *region;
>>>  	struct nd_interleave_set nd_set;
>>> +
>>> +	/* Protect dimm health data from concurrent read/writes */
>>> +	struct mutex health_mutex;
>>> +
>>> +	/* Last time the health information of the dimm was updated */
>>> +	unsigned long lasthealth_jiffies;
>>> +
>>> +	/* Health information for the dimm */
>>> +	u64 health_bitmap;
>>
>> I wonder if this should be typed big endian as you mention that it is in the
>> commit message?
> This was discussed in an earlier review of the patch series at
> https://lore.kernel.org/linux-nvdimm/878sjetcis.fsf@mpe.ellerman.id.au
>
> Even though health bitmap is returned in big endian format (For ex
> value 0xC00000000000000 indicates bits 0,1 set), its value is never
> used. Instead only test for specific bits being set in the register is
> done.

This has already caused a lot of confusion, so let me try and clear it
up. I will probably fail :)

The value is not big endian.

It's returned in a GPR (a register), from the hypervisor. The ordering
of bytes in a register is not dependent on what endian we're executing
in.

It's true that the hypervisor will have been running big endian, and
when it returns to us we will now be running little endian. But the
value is unchanged, it was 0xC00000000000000 in the GPR while the HV was
running and it's still 0xC00000000000000 when we return to Linux. You
can see this in mambo, see below for an example.


_However_, the specification of the bits in the bitmap value uses MSB 0
ordering, as is traditional for IBM documentation. That means the most
significant bit, aka. the left most bit, is called "bit 0".

See: https://en.wikipedia.org/wiki/Bit_numbering#MSB_0_bit_numbering

That is the opposite numbering from what most people use, and in
particular what most code in Linux uses, which is that bit 0 is the
least significant bit.

Which is where the confusion comes in. It's not that the bytes are
returned in a different order, it's that the bits are numbered
differently in the IBM documentation.

The way to fix this kind of thing is to read the docs, and convert all
the bits into correct numbering (LSB=0), and then throw away the docs ;)

cheers



In mambo we can set a breakpoint just before the kernel enters skiboot,
towards the end of __opal_call. The kernel is running LE and skiboot
runs BE.

  systemsim-p9 [~/skiboot/skiboot/external/mambo] b 0xc0000000000c1744
  breakpoint set at [0:0:0]: 0xc0000000000c1744 (0x00000000000C1744) Enc:0x2402004C : hrfid

Then run:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] c
  [0:0:0]: 0xC0000000000C1744 (0x00000000000C1744) Enc:0x2402004C : hrfid
  INFO: 121671618: (121671618): ** Execution stopped: user (tcl),  **
  121671618: ** finished running 121671618 instructions **

And we stop there, on an hrfid that we haven't executed yet.
We can print r0, to see the OPAL token:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] p r0
  0x0000000000000019

ie. we're calling OPAL_CONSOLE_WRITE_BUFFER_SPACE (25).

And we can print the MSR:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] p msr
  0x9000000002001033
  
                     64-bit mode (SF): 0x1 [64-bit mode]
                Hypervisor State (HV): 0x1
               Vector Available (VEC): 0x1
  Machine Check Interrupt Enable (ME): 0x1
            Instruction Relocate (IR): 0x1
                   Data Relocate (DR): 0x1
           Recoverable Interrupt (RI): 0x1
              Little-Endian Mode (LE): 0x1 [little-endian]

ie. we're little endian.

We then step one instruction:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] s
  [0:0:0]: 0x0000000030002BF0 (0x0000000030002BF0) Enc:0x7D9FFAA6 : mfspr   r12,PIR

Now we're in skiboot. Print the MSR again:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] p msr
  0x9000000002001002
  
                     64-bit mode (SF): 0x1 [64-bit mode]
                Hypervisor State (HV): 0x1
               Vector Available (VEC): 0x1
  Machine Check Interrupt Enable (ME): 0x1
           Recoverable Interrupt (RI): 0x1

We're big endian.
Print r0:

  systemsim-p9 [~/skiboot/skiboot/external/mambo] p r0
  0x0000000000000019

r0 is unchanged!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
