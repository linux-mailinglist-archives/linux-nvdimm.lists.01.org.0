Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7A9258C4A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 12:05:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1511139E926F;
	Tue,  1 Sep 2020 03:05:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F6EF1383DA9F
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 03:05:04 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A0E47ADE5;
	Tue,  1 Sep 2020 10:05:02 +0000 (UTC)
Date: Tue, 1 Sep 2020 12:05:00 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: Re: [PATCH 3/3] namespace-action: Drop zero namespace checks.
Message-ID: <20200901100500.GH29521@kitsune.suse.cz>
References: <d2d35ad93256c3ff6dbd3f9c7bd237933c59ae26.1598608222.git.msuchanek@suse.de>
 <486878ed6f1d74827afb42543f3186fe386059de.1598608222.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <486878ed6f1d74827afb42543f3186fe386059de.1598608222.git.msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: CN3SF6QWPBUM2C5J4E23TIC3SWQHEQHO
X-Message-ID-Hash: CN3SF6QWPBUM2C5J4E23TIC3SWQHEQHO
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CN3SF6QWPBUM2C5J4E23TIC3SWQHEQHO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 28, 2020 at 11:51:05AM +0200, Michal Suchanek wrote:
> From: Santosh Sivaraj <santosh@fossix.org>
> 
> With seed namespaces catched early on these checks for sizes in enable
> and destroy namespace code path are not needed.

Effectively reverts the two below commits:

Fixes: b9cb03f6d5a8 ("ndctl/namespace: Fix enable-namespace error for seed namespaces")
Fixes: e01045e58ad5 ("ndctl/namespace: Fix destroy-namespace accounting relative to seed devices")
> Link: https://patchwork.kernel.org/patch/11739975/
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> [rebased on top of the previous patches]
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  ndctl/lib/libndctl.c |  5 -----
>  ndctl/namespace.c    | 11 -----------
>  2 files changed, 16 deletions(-)
> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 952192c4c6b5..ecced5a3ae0b 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4253,16 +4253,11 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
>  	const char *devname = ndctl_namespace_get_devname(ndns);
>  	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
>  	struct ndctl_region *region = ndns->region;
> -	unsigned long long size = ndctl_namespace_get_size(ndns);
>  	int rc;
>  
>  	if (ndctl_namespace_is_enabled(ndns))
>  		return 0;
>  
> -	/* Don't try to enable idle namespace (no capacity allocated) */
> -	if (size == 0)
> -		return -ENXIO;
> -
>  	rc = ndctl_bind(ctx, ndns->module, devname);
>  
>  	/*
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 835f4076008a..65bca9191603 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1094,7 +1094,6 @@ static int namespace_destroy(struct ndctl_region *region,
>  		struct ndctl_namespace *ndns)
>  {
>  	const char *devname = ndctl_namespace_get_devname(ndns);
> -	unsigned long long size;
>  	bool did_zero = false;
>  	int rc;
>  
> @@ -1139,19 +1138,9 @@ static int namespace_destroy(struct ndctl_region *region,
>  		goto out;
>  	}
>  
> -	size = ndctl_namespace_get_size(ndns);
> -
>  	rc = ndctl_namespace_delete(ndns);
>  	if (rc)
>  		debug("%s: failed to reclaim\n", devname);
> -
> -	/*
> -	 * Don't report a destroyed namespace when no capacity was
> -	 * allocated.
> -	 */
> -	if (size == 0 && rc == 0)
> -		rc = 1;
> -
>  out:
>  	return rc;
>  }
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
