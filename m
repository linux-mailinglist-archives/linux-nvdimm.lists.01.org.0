Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4629BE5745
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 01:51:13 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C66F9100EA600;
	Fri, 25 Oct 2019 16:52:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3079100EEBBA
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 16:52:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 16:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400";
   d="scan'208";a="210467658"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 16:51:02 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 16:51:02 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx120.amr.corp.intel.com ([169.254.15.63]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 16:51:02 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Topic: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Index: AQHVhffdKVQAtmMLOEqII07S9c0vNKdpS+GAgAAGTQCAAxxDAIAAGRSA
Date: Fri, 25 Oct 2019 23:51:01 +0000
Message-ID: <bb1f1bfa167c7c7fd5a9dca2c88338f31650e061.camel@intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
	 <20191018202302.8122-4-jmoyer@redhat.com>
	 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
	 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
	 <49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
	 <7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
	 <20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <3A7DF3215E54364D92A5A57EBD0A536A@intel.com>
MIME-Version: 1.0
Message-ID-Hash: TTDIKM3VIW4IW4GFQH4LRY42SNMQWRBI
X-Message-ID-Hash: TTDIKM3VIW4IW4GFQH4LRY42SNMQWRBI
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TTDIKM3VIW4IW4GFQH4LRY42SNMQWRBI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-10-25 at 15:21 -0700, Ira Weiny wrote:
> How about this patch instead?  Untested.
> 
> Ira

Not a big deal, but just a quick note - if you include a scissors line
here, I can easily apply it via git am --scissors

--8<--

Otherwise this looks good in principle.

I've already got Jeff's original (less intrusive) patch queued for v67 -
maybe we can rebase this to be its own refactoring patch, and get some
testing etc. for 68?

> 
> From 24511b6a9f1b5e5c9e36c70ef6a03da5100cf4c7 Mon Sep 17 00:00:00 2001
> From: Ira Weiny <ira.weiny@intel.com>
> Date: Fri, 25 Oct 2019 15:16:13 -0700
> Subject: [PATCH] ndctl: Clean up loop logic in query_fw_finish_status
> 
> This gets rid of a redundant variable as originally pointed out by Jeff
> Moyer[1]
> 
> Also, while we are here change the printf's to fprintf(stderr, ...)
> 
> [1] https://patchwork.kernel.org/patch/11199557/
> 
> Suggested-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  ndctl/dimm.c | 142 +++++++++++++++++++++++++--------------------------
>  1 file changed, 70 insertions(+), 72 deletions(-)
> 
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index 5e6fa19bab15..84de014e93d6 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  	struct ndctl_cmd *cmd;
>  	int rc;
>  	enum ND_FW_STATUS status;
> -	bool done = false;
>  	struct timespec now, before, after;
>  	uint64_t ver;
>  
> @@ -692,88 +691,87 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  
>  	rc = clock_gettime(CLOCK_MONOTONIC, &before);
>  	if (rc < 0)
> -		goto out;
> +		goto unref;
>  
>  	now.tv_nsec = fw->query_interval / 1000;
>  	now.tv_sec = 0;
>  
> -	do {
> -		rc = ndctl_cmd_submit(cmd);
> -		if (rc < 0)
> -			break;
> +again:
> +	rc = ndctl_cmd_submit(cmd);
> +	if (rc < 0)
> +		goto unref;
>  
> -		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
> -		switch (status) {
> -		case FW_SUCCESS:
> -			ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
> -			if (ver == 0) {
> -				fprintf(stderr, "No firmware updated.\n");
> -				rc = -ENXIO;
> -				goto out;
> -			}
> +	status = ndctl_cmd_fw_xlat_firmware_status(cmd);
> +	if (status == FW_EBUSY) {
> +		/* Still on going, continue */
> +		rc = clock_gettime(CLOCK_MONOTONIC, &after);
> +		if (rc < 0) {
> +			rc = -errno;
> +			goto unref;
> +		}
>  
> -			printf("Image updated successfully to DIMM %s.\n",
> -					ndctl_dimm_get_devname(dimm));
> -			printf("Firmware version %#lx.\n", ver);
> -			printf("Cold reboot to activate.\n");
> -			done = true;
> -			rc = 0;
> -			break;
> -		case FW_EBUSY:
> -			/* Still on going, continue */
> -			rc = clock_gettime(CLOCK_MONOTONIC, &after);
> -			if (rc < 0) {
> -				rc = -errno;
> -				goto out;
> -			}
> +		/*
> +		 * If we expire max query time,
> +		 * we timed out
> +		 */
> +		if (after.tv_sec - before.tv_sec >
> +				fw->max_query / 1000000) {
> +			rc = -ETIMEDOUT;
> +			goto unref;
> +		}
>  
> -			/*
> -			 * If we expire max query time,
> -			 * we timed out
> -			 */
> -			if (after.tv_sec - before.tv_sec >
> -					fw->max_query / 1000000) {
> -				rc = -ETIMEDOUT;
> -				goto out;
> -			}
> +		/*
> +		 * Sleep the interval dictated by firmware
> +		 * before query again.
> +		 */
> +		rc = nanosleep(&now, NULL);
> +		if (rc < 0) {
> +			rc = -errno;
> +			goto unref;
> +		}
> +		goto again;
> +	}
>  
> -			/*
> -			 * Sleep the interval dictated by firmware
> -			 * before query again.
> -			 */
> -			rc = nanosleep(&now, NULL);
> -			if (rc < 0) {
> -				rc = -errno;
> -				goto out;
> -			}
> -			break;
> -		case FW_EBADFW:
> -			fprintf(stderr,
> -				"Firmware failed to verify by DIMM %s.\n",
> -				ndctl_dimm_get_devname(dimm));
> -		case FW_EINVAL_CTX:
> -		case FW_ESEQUENCE:
> -			done = true;
> +	/* We are done determine error code */
> +	switch (status) {
> +	case FW_SUCCESS:
> +		ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
> +		if (ver == 0) {
> +			fprintf(stderr, "No firmware updated.\n");
>  			rc = -ENXIO;
> -			goto out;
> -		case FW_ENORES:
> -			fprintf(stderr,
> -				"Firmware update sequence timed out: %s\n",
> -				ndctl_dimm_get_devname(dimm));
> -			rc = -ETIMEDOUT;
> -			done = true;
> -			goto out;
> -		default:
> -			fprintf(stderr,
> -				"Unknown update status: %#x on DIMM %s\n",
> -				status, ndctl_dimm_get_devname(dimm));
> -			rc = -EINVAL;
> -			done = true;
> -			goto out;
> +			goto unref;
>  		}
> -	} while (!done);
>  
> -out:
> +		fprintf(stderr, "Image updated successfully to DIMM %s.\n",
> +			ndctl_dimm_get_devname(dimm));
> +		fprintf(stderr, "Firmware version %#lx.\n", ver);
> +		fprintf(stderr, "Cold reboot to activate.\n");
> +		rc = 0;
> +		break;
> +	case FW_EBADFW:
> +		fprintf(stderr,
> +			"Firmware failed to verify by DIMM %s.\n",
> +			ndctl_dimm_get_devname(dimm));
> +		/* FALLTHROUGH */
> +	case FW_EINVAL_CTX:
> +	case FW_ESEQUENCE:
> +		rc = -ENXIO;
> +		break;
> +	case FW_ENORES:
> +		fprintf(stderr,
> +			"Firmware update sequence timed out: %s\n",
> +			ndctl_dimm_get_devname(dimm));
> +		rc = -ETIMEDOUT;
> +		break;
> +	default:
> +		fprintf(stderr,
> +			"Unknown update status: %#x on DIMM %s\n",
> +			status, ndctl_dimm_get_devname(dimm));
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +unref:
>  	ndctl_cmd_unref(cmd);
>  	return rc;
>  }

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
