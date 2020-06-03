Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE41EC8F1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 07:47:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97BD01011760B;
	Tue,  2 Jun 2020 22:42:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5036E1011760A
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 22:42:46 -0700 (PDT)
IronPort-SDR: cvyIhAblC8IrD3HoIqpSVNOsmHb4A3nMQLnLhcKLeXWPMz5lzclXJmMg9ewAfgYv5EaCxcE3ur
 krTaLElwXQvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 22:47:41 -0700
IronPort-SDR: DZP9RSJdAtukErQWk4I0TqtFdH+w8LCvQrO/sYgN30bVrD49qo0puHgEO7XU3JuZvyq/ZhyWQG
 sHlZtzl3tVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400";
   d="scan'208";a="377988390"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2020 22:47:40 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 22:47:41 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.32]) with mapi id 14.03.0439.000;
 Tue, 2 Jun 2020 22:47:40 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v5 2/6] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Topic: [ndctl PATCH v5 2/6] libncdtl: Add initial support for
 NVDIMM_FAMILY_PAPR nvdimm family
Thread-Index: AQHWNgVrYu93SLPBr0Kz9r0KmQnTSqjG3kcA
Date: Wed, 3 Jun 2020 05:47:39 +0000
Message-ID: <2960499ffc4f5f3f3ab305eaba84c2bca15b45ae.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
	 <20200529220600.225320-3-vaibhav@linux.ibm.com>
In-Reply-To: <20200529220600.225320-3-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <22A026317A31DA4496BA7D5C445E1510@intel.com>
MIME-Version: 1.0
Message-ID-Hash: FVLQV57Z2Z4AF7U2KFZTTRQFQFLJ3UNJ
X-Message-ID-Hash: FVLQV57Z2Z4AF7U2KFZTTRQFQFLJ3UNJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FVLQV57Z2Z4AF7U2KFZTTRQFQFLJ3UNJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-05-30 at 03:35 +0530, Vaibhav Jain wrote:

> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index d76dbf7e17de..a52c2e208fbe 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -799,6 +799,28 @@ static void parse_nfit_mem_flags(struct ndctl_dimm *dimm, char *flags)
>  				ndctl_dimm_get_devname(dimm), flags);
>  }
>  
> +static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
> +{
> +	char *start, *end;
> +
> +	start = flags;
> +	while ((end = strchr(start, ' '))) {
> +		*end = '\0';
> +		if (strcmp(start, "not_armed") == 0)
> +			dimm->flags.f_arm = 1;
> +		else if (strcmp(start, "flush_fail") == 0)
> +			dimm->flags.f_flush = 1;
> +		else if (strcmp(start, "restore_fail") == 0)
> +			dimm->flags.f_restore = 1;
> +		else if (strcmp(start, "smart_notify") == 0)
> +			dimm->flags.f_smart = 1;
> +		start = end + 1;
> +	}
> +	if (end != start)
> +		dbg(ndctl_dimm_get_ctx(dimm), "%s: %s\n",
> +				ndctl_dimm_get_devname(dimm), flags);

I think this would be more readable if ctx was obtained and saved in a
'ctx' variable at the start. Also, it might be better if 'flags' was
included in the string - something like "%s flags: %s\n"

> +}
> +
>  static void parse_dimm_flags(struct ndctl_dimm *dimm, char *flags)
>  {
>  	char *start, *end;
> @@ -856,6 +878,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
>  		bus->revision = strtoul(buf, NULL, 0);
>  	}
>  
> +	sprintf(path, "%s/device/of_node/compatible", ctl_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		bus->has_of_node = 0;
> +	else
> +		bus->has_of_node = 1;
> +
>  	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
>  	if (sysfs_read_attr(ctx, path, buf) < 0)
>  		bus->nfit_dsm_mask = 0;
> @@ -964,6 +992,10 @@ NDCTL_EXPORT int ndctl_bus_has_nfit(struct ndctl_bus *bus)
>  	return bus->has_nfit;
>  }
>  
> +NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
> +{
> +	return bus->has_of_node;
> +}

New libndctl APIs need to update the 'symbol script' -
ndctl/lib/libndctl.sym. Create a new 'section' at the bottom, and add
all new symbols to that section. The new section would be 'LIBNDCTL_24'
(Everything going into a given release gets a new section in that file,
so any subsequent patches - throughout the release cycle - that add new
APIs can add them to this new section).

>  /**
>   * ndctl_bus_get_major - nd bus character device major number
>   * @bus: ndctl_bus instance returned from ndctl_bus_get_{first|next}
> @@ -1441,6 +1473,47 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>  
> +static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
> +{
> +	int rc = -ENODEV;
> +	char buf[SYSFS_ATTR_SIZE];
> +	struct ndctl_ctx *ctx = dimm->bus->ctx;
> +	char *path = calloc(1, strlen(dimm_base) + 100);
> +
> +	dbg(ctx, "Probing of_pmem dimm %d at %s\n", dimm->id, dimm_base);
> +
> +	if (!path)
> +		return -ENOMEM;
> +
> +	sprintf(path, "%s/../of_node/compatible", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto out;

Two things here:
1. Why not use the new ndctl_bus_has_of_node helper here? and
2. This looks redundant. add_papr_dimm() is only called if
ndctl_bus_has_of_node() during add_dimm.

> +
> +

Nit: double newline here 

> +	dbg(ctx, "Compatible of_pmem dimm %d at %s\n", dimm->id, buf);
> +	/* construct path to the papr compatible dimm flags file */
> +	sprintf(path, "%s/papr/flags", dimm_base);
> +
> +	if (strcmp(buf, "ibm,pmemory") == 0 &&
> +	    sysfs_read_attr(ctx, path, buf) == 0) {
> +
> +		dbg(ctx, "Found papr dimm %d at %s\n", dimm->id, buf);

Throughout the series - it would be better to print messages such as:

	"%s: adding papr dimm with flags: %s\n", devname, buf

This would result in the canonical dimm names - nmem1, nmem2 and so on
being used instead of "dimm 1" which can be confusing just from a
convention standpoint.

Similarly for the print a few lines above this:

	"%s: of_pmem compatible dimm: %s\n", devname, buf

(In this case, what does the 'compatible' sysfs attrubute contain? Is it
useful to print here? - I havent't looked, just asking).

> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
> new file mode 100644
> index 000000000000..5ddf2755a950
> --- /dev/null
> +++ b/ndctl/lib/papr.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 2020 IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU Lesser General Public License,
> + * version 2.1, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT ANY
> + * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> + * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> + * more details.
> + */

Prefer SPDX license header instead fo the long form text for new files.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
