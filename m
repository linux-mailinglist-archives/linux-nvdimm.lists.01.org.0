Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F11EC666
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jun 2020 03:05:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFF0B10117609;
	Tue,  2 Jun 2020 18:00:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5A6E10117608
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 18:00:55 -0700 (PDT)
IronPort-SDR: 4VLl0/jsRycbKtiZeGjqNYjBdJ0ruYPhVdgfJwdZHIFvd/tMBEoKb5r/wCZdvia6q/E49u+Uvk
 3HEB/MTgJ3MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 18:05:48 -0700
IronPort-SDR: VADiPEv0fDC0nGXQ69IAveA9jkq3zmPXVh7WQBQbDWBwo1gxN2SLesNYjyG/1Fm09TetHU1PXl
 U1OAD2zAvkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400";
   d="scan'208";a="416391404"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2020 18:05:48 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 18:05:48 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.235]) with mapi id 14.03.0439.000;
 Tue, 2 Jun 2020 18:05:48 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v5 1/6] libndctl: Refactor out add_dimm() to
 handle NFIT specific init
Thread-Topic: [ndctl PATCH v5 1/6] libndctl: Refactor out add_dimm() to
 handle NFIT specific init
Thread-Index: AQHWNgVwQ+nY2CamdEWITUT3M9B+gKjGj4WA
Date: Wed, 3 Jun 2020 01:05:47 +0000
Message-ID: <51bb265a8f9e50214e9412cca57ae6dc7e16178b.camel@intel.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
	 <20200529220600.225320-2-vaibhav@linux.ibm.com>
In-Reply-To: <20200529220600.225320-2-vaibhav@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-ID: <7B73B5C216C48A45A6E6A58B027DEE3A@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 6S2SBWZSIHQPPX3DQIGFRFI2TX7OXZBO
X-Message-ID-Hash: 6S2SBWZSIHQPPX3DQIGFRFI2TX7OXZBO
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6S2SBWZSIHQPPX3DQIGFRFI2TX7OXZBO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-05-30 at 03:35 +0530, Vaibhav Jain wrote:
> Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence
> this patch refactors this functionality into two functions namely
> add_dimm() and add_nfit_dimm(). Function add_dimm() performs
> allocation and common 'struct ndctl_dimm' initialization and depending
> on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
> the probe is completed based on the value of 'ndctl_dimm.cmd_family'
> appropriate dimm-ops are assigned to the dimm.
> 
> In case dimm-bus is of unknown type or doesn't support NFIT the
> initialization still continues, with no dimm-ops assigned to the
> 'struct ndctl_dimm' there-by limiting the functionality available.
> 
> This patch shouldn't introduce any behavioral change.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v4..v5:
> * None
> 
> v3..v4:
> * None
> 
> v2..v3:
> * None
> 
> v1..v2:
> * None
> ---
>  ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++-----------------
> -
>  1 file changed, 112 insertions(+), 81 deletions(-)

Hi Vaibhav,

This mostly looks good, one minor nit below.

> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index ee737cbbfe3e..d76dbf7e17de 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -1441,82 +1441,15 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
>  static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
>  static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
>  
> -static void *add_dimm(void *parent, int id, const char *dimm_base)
> +static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
>  {
> -	int formats, i;
> -	struct ndctl_dimm *dimm;
> +	int i, rc = -1;
>  	char buf[SYSFS_ATTR_SIZE];
> -	struct ndctl_bus *bus = parent;
> -	struct ndctl_ctx *ctx = bus->ctx;
> +	struct ndctl_ctx *ctx = dimm->bus->ctx;
>  	char *path = calloc(1, strlen(dimm_base) + 100);
>  
>  	if (!path)

<snip>

> +		return -1;

You should generally avoid returning a plain '-1'. This really wants to
return an -ENOMEM.
>  
>  	/*
>  	 * 'unique_id' may not be available on older kernels, so don't
> @@ -1582,24 +1515,15 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
>  	sprintf(path, "%s/nfit/family", dimm_base);
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		dimm->cmd_family = strtoul(buf, NULL, 0);
> -	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
> -		dimm->ops = intel_dimm_ops;
> -	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
> -		dimm->ops = hpe1_dimm_ops;
> -	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
> -		dimm->ops = msft_dimm_ops;
> -	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
> -		dimm->ops = hyperv_dimm_ops;
>  
>  	sprintf(path, "%s/nfit/dsm_mask", dimm_base);
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		dimm->nfit_dsm_mask = strtoul(buf, NULL, 0);
>  
> -	dimm->formats = formats;
>  	sprintf(path, "%s/nfit/format", dimm_base);
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		dimm->format[0] = strtoul(buf, NULL, 0);
> -	for (i = 1; i < formats; i++) {
> +	for (i = 1; i < dimm->formats; i++) {
>  		sprintf(path, "%s/nfit/format%d", dimm_base, i);
>  		if (sysfs_read_attr(ctx, path, buf) == 0)
>  			dimm->format[i] = strtoul(buf, NULL, 0);
> @@ -1610,7 +1534,114 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)

<snip>

>   out:
> +	if (rc) {
> +		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);

Returning -1 being awkward is especially true when it might end up
getting printed as part of an error message like this. Indeed, you
shouldn't even print 'rc' as a number, which then needs to get looked up
- use strerror to turn it into a string.

Additionally, "dimm:<number>" is pretty nonstandard in ndctl, we
normally use the 'devname' for error messages. How about something like:

	err(ctx, "%s: probe failed: %s\n", ndctl_dimm_get_devname(dimm),
		strerror(-rc));

> +		goto err_read;
> +	}
> +
>  	list_add(&bus->dimms, &dimm->list);
>  	free(path);
>  
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
