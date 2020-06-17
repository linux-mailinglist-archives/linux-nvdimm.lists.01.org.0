Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ED61FC323
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jun 2020 03:02:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AFF610FC3712;
	Tue, 16 Jun 2020 18:02:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FD7010096677
	for <linux-nvdimm@lists.01.org>; Tue, 16 Jun 2020 18:02:42 -0700 (PDT)
IronPort-SDR: NVcmrPaXcYqV5TVsoqviD/L2SKIGP+jAQN+UFIvydShXTpSIA8iGmCjg0pxwv3TB8KxZrQ7RuK
 hFCpdcM2szGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 18:02:41 -0700
IronPort-SDR: q2bGW9PjPiz2FG6p5s5x2DVvqUZN/fHS/M93VU4TTOg2n+cA3zgWPIaVyCcb9JuYxQJ9OwWcgF
 Ewbo+2SoU8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400";
   d="scan'208";a="476647614"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2020 18:02:39 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.71]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.232]) with mapi id 14.03.0439.000;
 Tue, 16 Jun 2020 18:02:39 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v6 2/5] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Topic: [ndctl PATCH v6 2/5] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Index: AQHWQ59Qyv82nhInrE6CX0GV8knobKjcdBWA
Date: Wed, 17 Jun 2020 01:02:39 +0000
Message-ID: <64610f17651362e0ecd22ce99740cc9a9e57d6ef.camel@intel.com>
References: <20200616053029.84731-1-vaibhav@linux.ibm.com>
	 <20200616053029.84731-3-vaibhav@linux.ibm.com>
In-Reply-To: <20200616053029.84731-3-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <176E3632D910CB489C31DB69DBDB56F3@intel.com>
MIME-Version: 1.0
Message-ID-Hash: F6CQVM2MPU43Z6EXLEWQOTATJNT2O4V4
X-Message-ID-Hash: F6CQVM2MPU43Z6EXLEWQOTATJNT2O4V4
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F6CQVM2MPU43Z6EXLEWQOTATJNT2O4V4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-16 at 11:00 +0530, Vaibhav Jain wrote:
> Add necessary scaffolding in libndctl for dimms that support papr_scm

support /the/ papr_scm specification

> specification[1]. Since there can be platforms that support
> Open-Firmware[2] but not the papr_scm specification, hence the changes

s/hence//

> proposed first add support for probing if the dimm bus supports
> Open-Firmware. This is done via querying for sysfs attribute 'of_node'

This is done /by/ querying for /the/ sysfs attribute

> in dimm device sysfs directory. If available newly introduced member
> 'struct ndctl_bus.has_of_node' is set. During the probe of the dimm
> and execution of add_dimm(), the newly introduced add_papr_dimm()

During 'add_dimm()', the newly introduced..

> is called if dimm bus reports supports Open-Firmware.
> 
> Function add_papr_dimm() queries the 'compatible' device tree
> attribute via newly introduced ndctl_bus_is_papr_scm() and based on
> its value assign NVDIMM_FAMILY_PAPR to the dimm command family. In

based on its value, assigns NVDIM_..

> future, based on the contents of 'compatible' attribute more of_pmem

In /the/ future

> dimm families can be queried.
> 
> We also add support for parsing the dimm flags for

'We' can be ambiguous. Say something like: "Additionally, add support.."

> NVDIMM_FAMILY_PAPR supporting nvdimms as described at [3]. A newly
> introduced function parse_papr_flags() reads the contents of this
> flag file and sets appropriate flag bits in 'struct
> ndctl_dimm.flags'.
> 
> Also we advertise support for monitor mode by allocating a file

"Advertise support for monitor mode.."

> descriptor to the dimm 'flags' file and assigning it to 'struct
> ndctl_dimm.health_event_fd'.
> 
> The dimm-ops implementation for NVDIMM_FAMILY_PAPR is
> available in global variable 'papr_dimm_ops' which points to
> skeleton implementation in newly introduced file 'lib/papr.c'.

This paragraph can just be dropped - it's a minor implementation detail,
and doesn't add much to the commit message. The same actually goes for
the part above that talks about setting flags.

> 
> References:
> [1] Documentation/powerpc/papr_hcalls.rst
> https://lore.kernel.org/linux-nvdimm/20200529214719.223344-2-vaibhav@linux.ibm.com
> 
> [2] https://en.wikipedia.org/wiki/Open_Firmware
> 
> [3] Documentation/ABI/testing/sysfs-bus-papr-pmem
> https://lore.kernel.org/linux-nvdimm/20200529214719.223344-4-vaibhav@linux.ibm.com

Not a huge deal, but the lore links can probably be updated to the
latest posting.

> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> 
[..]

> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
> new file mode 100644
> index 000000000000..4b6ce8beccab
> --- /dev/null
> +++ b/ndctl/lib/papr.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: LGPL-2.1

I'm not sure if you intended to drop the copyright line here :)

> +
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <util/log.h>
> +#include <ndctl.h>
> +#include <ndctl/libndctl.h>
> +#include <lib/private.h>
> +
> +static bool papr_cmd_is_supported(struct ndctl_dimm *dimm, int cmd)
> +{
> +	/* Handle this separately to support monitor mode */
> +	if (cmd == ND_CMD_SMART)
> +		return true;
> +
> +	return !!(dimm->cmd_mask & (1ULL << cmd));
> +}
> +
> +struct ndctl_dimm_ops * const papr_dimm_ops = &(struct ndctl_dimm_ops) {
> +	.cmd_is_supported = papr_cmd_is_supported,
> +};
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
