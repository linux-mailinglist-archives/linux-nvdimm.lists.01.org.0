Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77722432E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 20:35:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E26571166404F;
	Fri, 17 Jul 2020 11:35:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8503211664050
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 11:35:39 -0700 (PDT)
IronPort-SDR: wcihTpixlB/Awk2psALbG4GcEKeVNiT3UdVaA4O8IkLxmnOc7rh7GEtmVmVPp6AOn/A848iyed
 xLm/KS7Ipjiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="211200603"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800";
   d="scan'208";a="211200603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 11:35:38 -0700
IronPort-SDR: NM0cihuSUbRCIDOLyO/wBY2MF3ksevxSGDa5V+IUtDhZZaOYtFM2Tniyt0T2c8qqZVGvMEg7QH
 jYrVMRbFM3mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800";
   d="scan'208";a="270882934"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2020 11:35:38 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.122]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.92]) with mapi id 14.03.0439.000;
 Fri, 17 Jul 2020 11:35:37 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Jiang, Dave"
	<dave.jiang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Weiny, Ira"
	<ira.weiny@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "grandmaster@al2klimov.de"
	<grandmaster@al2klimov.de>
Subject: Re: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Thread-Topic: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Thread-Index: AQHWXGeTmvbPt1aLLEiZkNSAVB7nYakMjqkA
Date: Fri, 17 Jul 2020 18:35:37 +0000
Message-ID: <7a2bdfafc7c8e22e87aa142b18390e1e8c921e4a.camel@intel.com>
References: <20200717182436.75214-1-grandmaster@al2klimov.de>
In-Reply-To: <20200717182436.75214-1-grandmaster@al2klimov.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <F90A9ADFCEFEFF4498B736AC8AD77289@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XJZAD5UEIGSRIRSAVAFLHWGCN36OWEEM
X-Message-ID-Hash: XJZAD5UEIGSRIRSAVAFLHWGCN36OWEEM
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XJZAD5UEIGSRIRSAVAFLHWGCN36OWEEM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-07-17 at 20:24 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  .../firmware-guide/acpi/DSD-properties-rules.rst       |  4 ++--
>  .../firmware-guide/acpi/dsd/data-node-references.rst   |  4 ++--
>  Documentation/firmware-guide/acpi/dsd/graph.rst        | 10 +++++-----
>  Documentation/firmware-guide/acpi/dsd/leds.rst         |  6 +++---
>  Documentation/firmware-guide/acpi/lpit.rst             |  2 +-
>  drivers/acpi/Kconfig                                   |  2 +-
>  drivers/acpi/nfit/nfit.h                               |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)

For nfit/nfit.h,
Acked-by: Vishal Verma <vishal.l.verma@intel.com>

> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index f5525f8bb770..a303f0123394 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -16,7 +16,7 @@
>  /* ACPI 6.1 */
>  #define UUID_NFIT_BUS "2f10e7a4-9e91-11e4-89d3-123b93f75cba"
>  
> -/* http://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf */
> +/* https://pmem.io/documents/NVDIMM_DSM_Interface-V1.6.pdf */
>  #define UUID_NFIT_DIMM "4309ac30-0d11-11e4-9191-0800200c9a66"
>  
>  /* https://github.com/HewlettPackard/hpe-nvm/blob/master/Documentation/ */
> -- 
> 2.27.0
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
