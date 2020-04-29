Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371971BD6A5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Apr 2020 09:56:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED325100675E5;
	Wed, 29 Apr 2020 00:54:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 34EBC100675E4
	for <linux-nvdimm@lists.01.org>; Wed, 29 Apr 2020 00:54:55 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T7WWFx017254;
	Wed, 29 Apr 2020 03:55:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30mhq9afn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 03:55:55 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03T7pRUU114112;
	Wed, 29 Apr 2020 03:55:55 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30mhq9afm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 03:55:54 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03T7odrF005691;
	Wed, 29 Apr 2020 07:55:53 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma03wdc.us.ibm.com with ESMTP id 30mcu6k3dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2020 07:55:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03T7tqmP24576292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2020 07:55:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4101136059;
	Wed, 29 Apr 2020 07:55:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9EF5136055;
	Wed, 29 Apr 2020 07:55:49 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.44.76])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2020 07:55:49 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH v2 2/6] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR_SCM dimm family
In-Reply-To: <20200420075556.272174-3-vaibhav@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com>
 <20200420075556.272174-3-vaibhav@linux.ibm.com>
Date: Wed, 29 Apr 2020 13:25:47 +0530
Message-ID: <87d07q20ak.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_02:2020-04-28,2020-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290057
Message-ID-Hash: XQLUXN5LZJIXH3ZFYVPIRWU2473HMGTK
X-Message-ID-Hash: XQLUXN5LZJIXH3ZFYVPIRWU2473HMGTK
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XQLUXN5LZJIXH3ZFYVPIRWU2473HMGTK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Add necessary scaffolding in libndctl for dimms that support papr_scm
> specification[1]. Since there can be platforms that support
> Open-Firmware[2] but not the papr_scm specification, hence the changes
> proposed first add support for probing if the dimm bus supports
> Open-Firmware. This is done via querying for sysfs attribute 'of_node'
> in dimm device sysfs directory. If available newly introduced member
> 'struct ndctl_bus.has_of_node' is set. During the probe of the dimm
> and execution of add_dimm(), the newly introduced add_of_pmem_dimm()
> is called if dimm bus reports supports Open-Firmware.
>
> Function add_of_pmem_dimm() queries the 'compatible' device tree
> attribute and based on its value assign NVDIMM_FAMILY_PAPR_SCM to the
> dimm command family. In future, based on the contents of 'compatible'
> attribute more of_pmem dimm families can be queried.
>
> We also add support for parsing the dimm flags for
> NVDIMM_FAMILY_PAPR_SCM supporting nvdimms as described at [3]. A newly
> introduced function parse_papr_scm_flags() reads the contents of this
> flag file and sets appropriate flag bits in 'struct
> ndctl_dimm.flags'.

The mixing of of_pmem and papr_scm is confuring here considering we have
two different driver in the kernel. If both can be handled by the same
code them possibly function that indicate both? ie, replace
add_of_pmem_dimm() with something more generic?

>
> Also we advertise support for monitor mode by allocating a file
> descriptor to the dimm 'flags' file and assigning it to 'struct
> ndctl_dimm.health_event_fd'.
>
> The dimm-ops implementation for NVDIMM_FAMILY_PAPR_SCM is
> available in global variable 'papr_scm_dimm_ops' which points to
> skeleton implementation in newly introduced file 'lib/papr_scm.c'.
>


-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
