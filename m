Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C115C1FD274
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jun 2020 18:42:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76B3210FC447B;
	Wed, 17 Jun 2020 09:42:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5EF9A10FC4477
	for <linux-nvdimm@lists.01.org>; Wed, 17 Jun 2020 09:42:23 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HGWLGD175359;
	Wed, 17 Jun 2020 12:42:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31q6hk5a5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 12:42:20 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HGWZkE176838;
	Wed, 17 Jun 2020 12:42:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31q6hk5a4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 12:42:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HGZmaV009284;
	Wed, 17 Jun 2020 16:42:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04ams.nl.ibm.com with ESMTP id 31q6ch9bxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2020 16:42:18 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HGgGVN33816666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2020 16:42:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7B4811C04C;
	Wed, 17 Jun 2020 16:42:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E78C11C05B;
	Wed, 17 Jun 2020 16:42:12 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.49.232])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 17 Jun 2020 16:42:12 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 17 Jun 2020 22:12:10 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: "Verma\, Vishal L" <vishal.l.verma@intel.com>,
        "linux-nvdimm\@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH v6 2/5] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR nvdimm family
In-Reply-To: <64610f17651362e0ecd22ce99740cc9a9e57d6ef.camel@intel.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com> <20200616053029.84731-3-vaibhav@linux.ibm.com> <64610f17651362e0ecd22ce99740cc9a9e57d6ef.camel@intel.com>
Date: Wed, 17 Jun 2020 22:12:10 +0530
Message-ID: <875zbpprtp.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170127
Message-ID-Hash: YTGOHU5ZC7ATZ5OZAGV7VG5Q4KXF2NKO
X-Message-ID-Hash: YTGOHU5ZC7ATZ5OZAGV7VG5Q4KXF2NKO
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YTGOHU5ZC7ATZ5OZAGV7VG5Q4KXF2NKO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vishal,

Thanks for reviewing this patch. I will be addressing your review
comments in v7 of this patch series.

~ Vaibhav

"Verma, Vishal L" <vishal.l.verma@intel.com> writes:

> On Tue, 2020-06-16 at 11:00 +0530, Vaibhav Jain wrote:
>> Add necessary scaffolding in libndctl for dimms that support papr_scm
>
> support /the/ papr_scm specification
>
>> specification[1]. Since there can be platforms that support
>> Open-Firmware[2] but not the papr_scm specification, hence the changes
>
> s/hence//
>
>> proposed first add support for probing if the dimm bus supports
>> Open-Firmware. This is done via querying for sysfs attribute 'of_node'
>
> This is done /by/ querying for /the/ sysfs attribute
>
>> in dimm device sysfs directory. If available newly introduced member
>> 'struct ndctl_bus.has_of_node' is set. During the probe of the dimm
>> and execution of add_dimm(), the newly introduced add_papr_dimm()
>
> During 'add_dimm()', the newly introduced..
>
>> is called if dimm bus reports supports Open-Firmware.
>> 
>> Function add_papr_dimm() queries the 'compatible' device tree
>> attribute via newly introduced ndctl_bus_is_papr_scm() and based on
>> its value assign NVDIMM_FAMILY_PAPR to the dimm command family. In
>
> based on its value, assigns NVDIM_..
>
>> future, based on the contents of 'compatible' attribute more of_pmem
>
> In /the/ future
>
>> dimm families can be queried.
>> 
>> We also add support for parsing the dimm flags for
>
> 'We' can be ambiguous. Say something like: "Additionally, add support.."
>
>> NVDIMM_FAMILY_PAPR supporting nvdimms as described at [3]. A newly
>> introduced function parse_papr_flags() reads the contents of this
>> flag file and sets appropriate flag bits in 'struct
>> ndctl_dimm.flags'.
>> 
>> Also we advertise support for monitor mode by allocating a file
>
> "Advertise support for monitor mode.."
>
>> descriptor to the dimm 'flags' file and assigning it to 'struct
>> ndctl_dimm.health_event_fd'.
>> 
>> The dimm-ops implementation for NVDIMM_FAMILY_PAPR is
>> available in global variable 'papr_dimm_ops' which points to
>> skeleton implementation in newly introduced file 'lib/papr.c'.
>
> This paragraph can just be dropped - it's a minor implementation detail,
> and doesn't add much to the commit message. The same actually goes for
> the part above that talks about setting flags.
>
>> 
>> References:
>> [1] Documentation/powerpc/papr_hcalls.rst
>> https://lore.kernel.org/linux-nvdimm/20200529214719.223344-2-vaibhav@linux.ibm.com
>> 
>> [2] https://en.wikipedia.org/wiki/Open_Firmware
>> 
>> [3] Documentation/ABI/testing/sysfs-bus-papr-pmem
>> https://lore.kernel.org/linux-nvdimm/20200529214719.223344-4-vaibhav@linux.ibm.com
>
> Not a huge deal, but the lore links can probably be updated to the
> latest posting.
>
>> 
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> 
> [..]
>
>> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
>> new file mode 100644
>> index 000000000000..4b6ce8beccab
>> --- /dev/null
>> +++ b/ndctl/lib/papr.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: LGPL-2.1
>
> I'm not sure if you intended to drop the copyright line here :)
>
>> +
>> +#include <stdint.h>
>> +#include <stdlib.h>
>> +#include <limits.h>
>> +#include <util/log.h>
>> +#include <ndctl.h>
>> +#include <ndctl/libndctl.h>
>> +#include <lib/private.h>
>> +
>> +static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
>> +{
>> +	/* Handle this separately to support monitor mode */
>> +	if (cmd == ND_CMD_SMART)
>> +		return true;
>> +
>> +	return !!(dimm->cmd_mask & (1ULL << cmd));
>> +}
>> +
>> +struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
>> +	.cmd_is_supported = papr_cmd_is_supported,
>> +};
>> 

-- 
Cheers
~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
