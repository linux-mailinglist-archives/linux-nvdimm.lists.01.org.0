Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA21C3482
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 10:31:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4BBB311509E2E;
	Mon,  4 May 2020 01:30:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57FCA11509E1E
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 01:30:04 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04482DkG160153
	for <linux-nvdimm@lists.01.org>; Mon, 4 May 2020 04:31:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8hdudm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 04:31:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0448Trjd015006
	for <linux-nvdimm@lists.01.org>; Mon, 4 May 2020 08:31:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 30s0g5matg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 08:31:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0448VWVY10879232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2020 08:31:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DDFD5204F;
	Mon,  4 May 2020 08:31:32 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.89.222])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 2E3CE52063;
	Mon,  4 May 2020 08:31:29 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 04 May 2020 14:01:28 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH v2 2/6] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
In-Reply-To: <87d07q20ak.fsf@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com> <20200420075556.272174-3-vaibhav@linux.ibm.com> <87d07q20ak.fsf@linux.ibm.com>
Date: Mon, 04 May 2020 14:01:28 +0530
Message-ID: <87ftcgdrtr.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_04:2020-05-01,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=7 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040064
Message-ID-Hash: SV4MISWAU4P2Q43I2YQLZCWGVSJXABYB
X-Message-ID-Hash: SV4MISWAU4P2Q43I2YQLZCWGVSJXABYB
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SV4MISWAU4P2Q43I2YQLZCWGVSJXABYB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
>> Add necessary scaffolding in libndctl for dimms that support papr_scm
>> specification[1]. Since there can be platforms that support
>> Open-Firmware[2] but not the papr_scm specification, hence the changes
>> proposed first add support for probing if the dimm bus supports
>> Open-Firmware. This is done via querying for sysfs attribute 'of_node'
>> in dimm device sysfs directory. If available newly introduced member
>> 'struct ndctl_bus.has_of_node' is set. During the probe of the dimm
>> and execution of add_dimm(), the newly introduced add_of_pmem_dimm()
>> is called if dimm bus reports supports Open-Firmware.
>>
>> Function add_of_pmem_dimm() queries the 'compatible' device tree
>> attribute and based on its value assign NVDIMM_FAMILY_PAPR_SCM to the
>> dimm command family. In future, based on the contents of 'compatible'
>> attribute more of_pmem dimm families can be queried.
>>
>> We also add support for parsing the dimm flags for
>> NVDIMM_FAMILY_PAPR_SCM supporting nvdimms as described at [3]. A newly
>> introduced function parse_papr_scm_flags() reads the contents of this
>> flag file and sets appropriate flag bits in 'struct
>> ndctl_dimm.flags'.
>
> The mixing of of_pmem and papr_scm is confuring here considering we have
> two different driver in the kernel. If both can be handled by the same
> code them possibly function that indicate both? ie, replace
> add_of_pmem_dimm() with something more generic?
Currently this function handles only papr compliant memory hence will
rename the function to add_papr_pmem_dimm() as discussed offline.

>
>>
>> Also we advertise support for monitor mode by allocating a file
>> descriptor to the dimm 'flags' file and assigning it to 'struct
>> ndctl_dimm.health_event_fd'.
>>
>> The dimm-ops implementation for NVDIMM_FAMILY_PAPR_SCM is
>> available in global variable 'papr_scm_dimm_ops' which points to
>> skeleton implementation in newly introduced file 'lib/papr_scm.c'.
>>
>
>
> -aneesh
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
