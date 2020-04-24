Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7611B6BD8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Apr 2020 05:20:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9047E10FC389F;
	Thu, 23 Apr 2020 20:20:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50DD710FC3897
	for <linux-nvdimm@lists.01.org>; Thu, 23 Apr 2020 20:19:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so1528211pje.1
        for <linux-nvdimm@lists.01.org>; Thu, 23 Apr 2020 20:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cCvu9PWKxKrms8aW1C54HePFnidQrgsf5hMRoohpycU=;
        b=li+fXRYWOINaITP4+1mz3aj2XAM6LhcHq8BdhUD8F4+MVLAUFVU2dFybQhLPjjmSzX
         16BWR0kDknJMr7wkvykNQSBPtq5q8cxYUA106pYT+jidcQBnEP1bTtOaX/CesTa7SSgI
         Bc1ec1ab9UxBVTaLNIwcCfzYkIaYTNiy9jwBeOQXaT+G3qslxiHKtMfjNSY5B22qDJw3
         tvdoZ7YQ4tB798gsqOlr09e+oPCBH6XvhxX3HkQrRsykduayT0KItVZrZp5IE3wJZ4ZK
         +xI1rclcPQo+RiIXOR4oUEmWJI1sA+Bi9PO6Zp/9voprMdFbrcggC+s2ca02CiUFmLHZ
         X92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cCvu9PWKxKrms8aW1C54HePFnidQrgsf5hMRoohpycU=;
        b=SeLDk/RrEzyrOvGn09a+6OXsfM/aL7yleM5s2nk9C6EWUkZvuN8AR9emc9ta/zuj51
         ZKqCsWJRk2oWIpADTLeXRcgHvTIdZ3aVwjJHSnGR3JsDHxpnqBcVUyU6kIavMYVJHDtt
         KhD/IY5XHXN6kOatkqC5nr0d/lTaKnS9zC8pX8bHPJmWKySF+NrqVHRRUTb7E0SxMOBn
         Y+0+gf2a7mtRDqw6IuXTU1a/3ToIZYBC2CzNPWZ8faHj0BxlAOSFcHvW3O3SSYJRUiO2
         IlkDvkA+R8WoR4QBqU3IH6PQA3f0TWLdkLjO6f3nZ1G9pIIv0qyvqvSx0xaeD0oz9DAF
         iQHA==
X-Gm-Message-State: AGi0Pub5vAoookfkGOtbm7q19Utqd969mrmWu04PcTSUP2Tx67wiAh6m
	qBWzdD4gXeMwQqXepGS15X63uQ==
X-Google-Smtp-Source: APiQypJ8gEMiOs2GxPrTKpKD8h4PWxGoDmIrpxxmK370tlUiAgk1VDwG+Yt033CooFucyMY7Pt8/mQ==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr7170913pll.62.1587698426242;
        Thu, 23 Apr 2020 20:20:26 -0700 (PDT)
Received: from localhost ([106.198.47.139])
        by smtp.gmail.com with ESMTPSA id r4sm3455553pgi.6.2020.04.23.20.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 20:20:25 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH v2 1/6] libndctl: Refactor out add_dimm() to handle NFIT specific init
In-Reply-To: <20200420075556.272174-2-vaibhav@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com> <20200420075556.272174-2-vaibhav@linux.ibm.com>
Date: Fri, 24 Apr 2020 08:48:11 +0530
Message-ID: <87zhb1po5o.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 6M7HAQ5EQX6DUTYMFJW3LK4V4T6UA4FB
X-Message-ID-Hash: 6M7HAQ5EQX6DUTYMFJW3LK4V4T6UA4FB
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6M7HAQ5EQX6DUTYMFJW3LK4V4T6UA4FB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

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
> v1..v2:
> * None


Looks good to me. For the series,

Reviewed-by: Santosh S <santosh@fossix.org>


Thanks,
Santosh

> ---
>  ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 81 deletions(-)
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
> -		return NULL;
> -
> -	sprintf(path, "%s/nfit/formats", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		formats = 1;
> -	else
> -		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
> -
> -	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
> -	if (!dimm)
> -		goto err_dimm;
> -	dimm->bus = bus;
> -	dimm->id = id;
> -
> -	sprintf(path, "%s/dev", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	if (sscanf(buf, "%d:%d", &dimm->major, &dimm->minor) != 2)
> -		goto err_read;
> -
> -	sprintf(path, "%s/commands", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	dimm->cmd_mask = parse_commands(buf, 1);
> -
> -	dimm->dimm_buf = calloc(1, strlen(dimm_base) + 50);
> -	if (!dimm->dimm_buf)
> -		goto err_read;
> -	dimm->buf_len = strlen(dimm_base) + 50;
> -
> -	dimm->dimm_path = strdup(dimm_base);
> -	if (!dimm->dimm_path)
> -		goto err_read;
> -
> -	sprintf(path, "%s/modalias", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0)
> -		goto err_read;
> -	dimm->module = to_module(ctx, buf);
> -
> -	dimm->handle = -1;
> -	dimm->phys_id = -1;
> -	dimm->serial = -1;
> -	dimm->vendor_id = -1;
> -	dimm->device_id = -1;
> -	dimm->revision_id = -1;
> -	dimm->health_eventfd = -1;
> -	dimm->dirty_shutdown = -ENOENT;
> -	dimm->subsystem_vendor_id = -1;
> -	dimm->subsystem_device_id = -1;
> -	dimm->subsystem_revision_id = -1;
> -	dimm->manufacturing_date = -1;
> -	dimm->manufacturing_location = -1;
> -	dimm->cmd_family = -1;
> -	dimm->nfit_dsm_mask = ULONG_MAX;
> -	for (i = 0; i < formats; i++)
> -		dimm->format[i] = -1;
> -
> -	sprintf(path, "%s/flags", dimm_base);
> -	if (sysfs_read_attr(ctx, path, buf) < 0) {
> -		dimm->locked = -1;
> -		dimm->aliased = -1;
> -	} else
> -		parse_dimm_flags(dimm, buf);
> -
> -	if (!ndctl_bus_has_nfit(bus))
> -		goto out;
> +		return -1;
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
>  		parse_nfit_mem_flags(dimm, buf);
>  
>  	dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
> +	rc = 0;
> + err_read:
> +
> +	free(path);
> +	return rc;
> +}
> +
> +static void *add_dimm(void *parent, int id, const char *dimm_base)
> +{
> +	int formats, i, rc = -ENODEV;
> +	struct ndctl_dimm *dimm = NULL;
> +	char buf[SYSFS_ATTR_SIZE];
> +	struct ndctl_bus *bus = parent;
> +	struct ndctl_ctx *ctx = bus->ctx;
> +	char *path = calloc(1, strlen(dimm_base) + 100);
> +
> +	if (!path)
> +		return NULL;
> +
> +	sprintf(path, "%s/nfit/formats", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		formats = 1;
> +	else
> +		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
> +
> +	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
> +	if (!dimm)
> +		goto err_dimm;
> +	dimm->bus = bus;
> +	dimm->id = id;
> +
> +	sprintf(path, "%s/dev", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	if (sscanf(buf, "%d:%d", &dimm->major, &dimm->minor) != 2)
> +		goto err_read;
> +
> +	sprintf(path, "%s/commands", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	dimm->cmd_mask = parse_commands(buf, 1);
> +
> +	dimm->dimm_buf = calloc(1, strlen(dimm_base) + 50);
> +	if (!dimm->dimm_buf)
> +		goto err_read;
> +	dimm->buf_len = strlen(dimm_base) + 50;
> +
> +	dimm->dimm_path = strdup(dimm_base);
> +	if (!dimm->dimm_path)
> +		goto err_read;
> +
> +	sprintf(path, "%s/modalias", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		goto err_read;
> +	dimm->module = to_module(ctx, buf);
> +
> +	dimm->handle = -1;
> +	dimm->phys_id = -1;
> +	dimm->serial = -1;
> +	dimm->vendor_id = -1;
> +	dimm->device_id = -1;
> +	dimm->revision_id = -1;
> +	dimm->health_eventfd = -1;
> +	dimm->dirty_shutdown = -ENOENT;
> +	dimm->subsystem_vendor_id = -1;
> +	dimm->subsystem_device_id = -1;
> +	dimm->subsystem_revision_id = -1;
> +	dimm->manufacturing_date = -1;
> +	dimm->manufacturing_location = -1;
> +	dimm->cmd_family = -1;
> +	dimm->nfit_dsm_mask = ULONG_MAX;
> +	for (i = 0; i < formats; i++)
> +		dimm->format[i] = -1;
> +
> +	sprintf(path, "%s/flags", dimm_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0) {
> +		dimm->locked = -1;
> +		dimm->aliased = -1;
> +	} else
> +		parse_dimm_flags(dimm, buf);
> +
> +	/* Check if the given dimm supports nfit */
> +	if (ndctl_bus_has_nfit(bus)) {
> +		dimm->formats = formats;
> +		rc = add_nfit_dimm(dimm, dimm_base);
> +	}
> +
> +	if (rc == -ENODEV) {
> +		/* Unprobed dimm with no family */
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	/* Assign dimm-ops based on command family */
> +	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
> +		dimm->ops = intel_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
> +		dimm->ops = hpe1_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
> +		dimm->ops = msft_dimm_ops;
> +	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
> +		dimm->ops = hyperv_dimm_ops;
>   out:
> +	if (rc) {
> +		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
> +		goto err_read;
> +	}
> +
>  	list_add(&bus->dimms, &dimm->list);
>  	free(path);
>  
> -- 
> 2.25.3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
