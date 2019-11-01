Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111CEC9EE
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Nov 2019 21:53:00 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F354100DC415;
	Fri,  1 Nov 2019 13:55:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6AF4100DC414
	for <linux-nvdimm@lists.01.org>; Fri,  1 Nov 2019 13:55:52 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 13:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400";
   d="scan'208";a="199916667"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2019 13:52:54 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 1 Nov 2019 13:52:54 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.167]) with mapi id 14.03.0439.000;
 Fri, 1 Nov 2019 13:52:53 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] libnvdimm/pmem: Delete include of nd-core.h
Thread-Topic: [PATCH] libnvdimm/pmem: Delete include of nd-core.h
Thread-Index: AQHVkE2z3NSFKZ0vREyUBbLgylDZYad3QWQA
Date: Fri, 1 Nov 2019 20:52:52 +0000
Message-ID: <86ea4fc17a94446df545af450e9de704e674b68c.camel@intel.com>
References: <157256829077.1212326.8726596129631121970.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157256829077.1212326.8726596129631121970.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <9FAEA65EFF47F44A81AEC60455BFA102@intel.com>
MIME-Version: 1.0
Message-ID-Hash: OGQKN53ET6CAM2PQHUEGEUTXCPHHMFA7
X-Message-ID-Hash: OGQKN53ET6CAM2PQHUEGEUTXCPHHMFA7
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiang@ml01.01.org, , Ira@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OGQKN53ET6CAM2PQHUEGEUTXCPHHMFA7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2019-10-31 at 17:31 -0700, Dan Williams wrote:
> The entire point of nd-core.h is to hide functionality that no leaf
> driver should touch. In fact, the commit that added it had no need to
> include it.
> 
> Fixes: 06e8ccdab15f ("acpi: nfit: Add support for detect platform...")
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/pmem.c |    1 -
>  1 file changed, 1 deletion(-)

Looks good,
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 7a6f4501dcda..ad8e4df1282b 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -28,7 +28,6 @@
>  #include "pmem.h"
>  #include "pfn.h"
>  #include "nd.h"
> -#include "nd-core.h"
>  
>  static struct device *to_dev(struct pmem_device *pmem)
>  {
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
