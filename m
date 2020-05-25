Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CEB1E0E04
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 14:01:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7815712227BEB;
	Mon, 25 May 2020 04:57:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2092612227BEA
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 04:57:27 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PBVAUQ035241;
	Mon, 25 May 2020 08:00:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 316weudjhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2020 08:00:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04PBvJuB031814;
	Mon, 25 May 2020 12:00:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf8v17p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2020 12:00:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04PC0kQq60424296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2020 12:00:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F2834C050;
	Mon, 25 May 2020 12:00:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 163AE4C046;
	Mon, 25 May 2020 12:00:43 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.3.198])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 25 May 2020 12:00:42 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 25 May 2020 17:30:42 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm, uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <87ftbswhb6.fsf@linux.ibm.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com> <87367t941j.fsf@mpe.ellerman.id.au> <87ftbswhb6.fsf@linux.ibm.com>
Date: Mon, 25 May 2020 17:30:42 +0530
Message-ID: <87a71ww7f9.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_05:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250087
Message-ID-Hash: ESAPQZH5DHAUHHWWY55XGW4FX2JXY53S
X-Message-ID-Hash: ESAPQZH5DHAUHHWWY55XGW4FX2JXY53S
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ESAPQZH5DHAUHHWWY55XGW4FX2JXY53S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ira, Mpe and Aneesh,

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Ira Weiny <ira.weiny@intel.com> writes:
>>> On Wed, May 20, 2020 at 12:30:57AM +0530, Vaibhav Jain wrote:
>>>> Introduce support for Papr nvDimm Specific Methods (PDSM) in papr_scm
>>>> modules and add the command family to the white list of NVDIMM command
>>>> sets. Also advertise support for ND_CMD_CALL for the dimm
>>>> command mask and implement necessary scaffolding in the module to
>>>> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
>> ...
>>>> + *
>>>> + * Payload Version:
>>>> + *
>>>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>>>> + * version of the structure present in PDSM Payload for a given PDSM command.
>>>> + * This provides backward compatibility in case the PDSM Payload structure
>>>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>>>> + *
>>>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>>>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>>>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>>>> + * uses 'payload struct version' == MIN('payload_version field',
>>>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>>>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>>>> + * struct in returned 'payload_version' field.
>>>
>>> FWIW many people believe using a size rather than version is more sustainable.
>>> It is expected that new payload structures are larger (more features) than the
>>> previous payload structure.
>>>
>>> I can't find references at the moment through.
>>
>> I think clone_args is a good modern example:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sched.h#n88
>>
>> cheers
>
> Thank Ira and Mpe for pointing this out. I looked into how clone3 sycall
> handles clone_args and few differences came out:
>
> * Unlike clone_args that are always transferred in one direction from
>   user-space to kernel, payload contents of pdsms are transferred in both
>   directions. Having a single version number makes it easier for
>   user-space and kernel to determine what data will be exchanged.
>
> * For PDSMs, the version number is negotiated between libndctl and
>   kernel. For example in case kernel only supports an older version of
>   a structure, its free to send a lower version number back to
>   libndctl. Such negotiations doesnt happen with clone3 syscall.

If you are ok with the explaination above please let me know. I will
quickly spin off a v8 addressing your review comments.

Thanks,
-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
