Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEC81DE11D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 09:38:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A78A4117AE4DC;
	Fri, 22 May 2020 00:35:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83DA6117AE4D9
	for <linux-nvdimm@lists.01.org>; Fri, 22 May 2020 00:35:13 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04M7V8Vw046770;
	Fri, 22 May 2020 03:38:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31659tfr9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2020 03:38:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04M7adhL007546;
	Fri, 22 May 2020 07:38:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 313xas755h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2020 07:38:12 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04M7cAwO6619602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2020 07:38:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C48F4C04A;
	Fri, 22 May 2020 07:38:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20FC4C062;
	Fri, 22 May 2020 07:38:06 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.80.144])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 22 May 2020 07:38:06 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 22 May 2020 13:08:05 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm, uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <87367t941j.fsf@mpe.ellerman.id.au>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com> <87367t941j.fsf@mpe.ellerman.id.au>
Date: Fri, 22 May 2020 13:08:05 +0530
Message-ID: <87ftbswhb6.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_04:2020-05-21,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=974 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220052
Message-ID-Hash: 352KH34EXAJWN5I5J47LWTTHBDZDFCUL
X-Message-ID-Hash: 352KH34EXAJWN5I5J47LWTTHBDZDFCUL
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/352KH34EXAJWN5I5J47LWTTHBDZDFCUL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michael Ellerman <mpe@ellerman.id.au> writes:

> Ira Weiny <ira.weiny@intel.com> writes:
>> On Wed, May 20, 2020 at 12:30:57AM +0530, Vaibhav Jain wrote:
>>> Introduce support for Papr nvDimm Specific Methods (PDSM) in papr_scm
>>> modules and add the command family to the white list of NVDIMM command
>>> sets. Also advertise support for ND_CMD_CALL for the dimm
>>> command mask and implement necessary scaffolding in the module to
>>> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
> ...
>>> + *
>>> + * Payload Version:
>>> + *
>>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>>> + * version of the structure present in PDSM Payload for a given PDSM command.
>>> + * This provides backward compatibility in case the PDSM Payload structure
>>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>>> + *
>>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>>> + * uses 'payload struct version' == MIN('payload_version field',
>>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>>> + * struct in returned 'payload_version' field.
>>
>> FWIW many people believe using a size rather than version is more sustainable.
>> It is expected that new payload structures are larger (more features) than the
>> previous payload structure.
>>
>> I can't find references at the moment through.
>
> I think clone_args is a good modern example:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sched.h#n88
>
> cheers

Thank Ira and Mpe for pointing this out. I looked into how clone3 sycall
handles clone_args and few differences came out:

* Unlike clone_args that are always transferred in one direction from
  user-space to kernel, payload contents of pdsms are transferred in both
  directions. Having a single version number makes it easier for
  user-space and kernel to determine what data will be exchanged.

* For PDSMs, the version number is negotiated between libndctl and
  kernel. For example in case kernel only supports an older version of
  a structure, its free to send a lower version number back to
  libndctl. Such negotiations doesnt happen with clone3 syscall.
  
-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
