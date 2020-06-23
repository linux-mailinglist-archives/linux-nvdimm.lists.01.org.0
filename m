Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02437205B8C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 21:14:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6996910FC38BC;
	Tue, 23 Jun 2020 12:14:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 673A9100978D9
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 12:14:11 -0700 (PDT)
IronPort-SDR: t5ibL9flPDRa+u2oRVRnPnQamgKh5VdfkGtfaYZiQKV5uMrHfuB7hJash8kCo7qkgkW+tZ2Qgd
 pjj+f627XUFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="142427118"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="142427118"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 12:14:11 -0700
IronPort-SDR: aSHQQvRvGFfed0wXnzX5YxhKZO0WAMes9KU4/xZi/0Bcs3CYIGE720ow1jLD0cs7OBEJgs5aFi
 /DMR2SuTJjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800";
   d="scan'208";a="384947445"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2020 12:14:10 -0700
Date: Tue, 23 Jun 2020 12:14:10 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/papr_scm: Add support for fetching nvdimm
 'fuel-gauge' metric
Message-ID: <20200623191410.GH3910394@iweiny-DESK2.sc.intel.com>
References: <20200622042451.22448-1-vaibhav@linux.ibm.com>
 <20200622042451.22448-3-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622042451.22448-3-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: EMXEV7YTZMGCRFSFKHCNEVXFRRR6MOZ3
X-Message-ID-Hash: EMXEV7YTZMGCRFSFKHCNEVXFRRR6MOZ3
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMXEV7YTZMGCRFSFKHCNEVXFRRR6MOZ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 22, 2020 at 09:54:51AM +0530, Vaibhav Jain wrote:
> We add support for reporting 'fuel-gauge' NVDIMM metric via
> PAPR_PDSM_HEALTH pdsm payload. 'fuel-gauge' metric indicates the usage
> life remaining of a papr-scm compatible NVDIMM. PHYP exposes this
> metric via the H_SCM_PERFORMANCE_STATS.
> 
> The metric value is returned from the pdsm by extending the return
> payload 'struct nd_papr_pdsm_health' without breaking the ABI. A new
> field 'dimm_fuel_gauge' to hold the metric value is introduced at the
> end of the payload struct and its presence is indicated by by
> extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID.
> 
> The patch introduces a new function papr_pdsm_fuel_gauge() that is
> called from papr_pdsm_health(). If fetching NVDIMM performance stats
> is supported then 'papr_pdsm_fuel_gauge()' allocated an output buffer
> large enough to hold the performance stat and passes it to
> drc_pmem_query_stats() that issues the HCALL to PHYP. The return value
> of the stat is then populated in the 'struct
> nd_papr_pdsm_health.dimm_fuel_gauge' field with extension flag
> 'PDSM_DIMM_HEALTH_RUN_GAUGE_VALID' set in 'struct
> nd_papr_pdsm_health.extension_flags'
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/papr_pdsm.h |  9 +++++
>  arch/powerpc/platforms/pseries/papr_scm.c | 47 +++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/powerpc/include/uapi/asm/papr_pdsm.h b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> index 9ccecc1d6840..50ef95e2f5b1 100644
> --- a/arch/powerpc/include/uapi/asm/papr_pdsm.h
> +++ b/arch/powerpc/include/uapi/asm/papr_pdsm.h
> @@ -72,6 +72,11 @@
>  #define PAPR_PDSM_DIMM_CRITICAL      2
>  #define PAPR_PDSM_DIMM_FATAL         3
>  
> +/* struct nd_papr_pdsm_health.extension_flags field flags */
> +
> +/* Indicate that the 'dimm_fuel_gauge' field is valid */
> +#define PDSM_DIMM_HEALTH_RUN_GAUGE_VALID 1
> +
>  /*
>   * Struct exchanged between kernel & ndctl in for PAPR_PDSM_HEALTH
>   * Various flags indicate the health status of the dimm.
> @@ -84,6 +89,7 @@
>   * dimm_locked		: Contents of the dimm cant be modified until CEC reboot
>   * dimm_encrypted	: Contents of dimm are encrypted.
>   * dimm_health		: Dimm health indicator. One of PAPR_PDSM_DIMM_XXXX
> + * dimm_fuel_gauge	: Life remaining of DIMM as a percentage from 0-100
>   */
>  struct nd_papr_pdsm_health {
>  	union {
> @@ -96,6 +102,9 @@ struct nd_papr_pdsm_health {
>  			__u8 dimm_locked;
>  			__u8 dimm_encrypted;
>  			__u16 dimm_health;
> +
> +			/* Extension flag PDSM_DIMM_HEALTH_RUN_GAUGE_VALID */
> +			__u16 dimm_fuel_gauge;
>  		};
>  		__u8 buf[ND_PDSM_PAYLOAD_MAX_SIZE];
>  	};
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index cb3f9acc325b..39527cd38d9c 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -506,6 +506,45 @@ static int is_cmd_valid(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
>  	return 0;
>  }
>  
> +static int papr_pdsm_fuel_gauge(struct papr_scm_priv *p,
> +				union nd_pdsm_payload *payload)
> +{
> +	int rc, size;
> +	struct papr_scm_perf_stat *stat;
> +	struct papr_scm_perf_stats *stats;
> +
> +	/* Silently fail if fetching performance metrics isn't  supported */
> +	if (!p->len_stat_buffer)
> +		return 0;
> +
> +	/* Allocate request buffer enough to hold single performance stat */
> +	size = sizeof(struct papr_scm_perf_stats) +
> +		sizeof(struct papr_scm_perf_stat);
> +
> +	stats = kzalloc(size, GFP_KERNEL);
> +	if (!stats)
> +		return -ENOMEM;
> +
> +	stat = &stats->scm_statistic[0];
> +	memcpy(&stat->statistic_id, "MemLife ", sizeof(stat->statistic_id));
> +	stat->statistic_value = 0;
> +
> +	/* Fetch the fuel gauge and populate it in payload */
> +	rc = drc_pmem_query_stats(p, stats, size, 1, NULL);
> +	if (!rc) {

Always best to except the error case...

	if (rc) {
		... print debuging from below...
		goto free_stats;
	}

> +		dev_dbg(&p->pdev->dev,
> +			"Fetched fuel-gauge %llu", stat->statistic_value);
> +		payload->health.extension_flags |=
> +			PDSM_DIMM_HEALTH_RUN_GAUGE_VALID;
> +		payload->health.dimm_fuel_gauge = stat->statistic_value;
> +
> +		rc = sizeof(struct nd_papr_pdsm_health);
> +	}
> +

free_stats:

> +	kfree(stats);
> +	return rc;
> +}
> +
>  /* Fetch the DIMM health info and populate it in provided package. */
>  static int papr_pdsm_health(struct papr_scm_priv *p,
>  			    union nd_pdsm_payload *payload)
> @@ -546,6 +585,14 @@ static int papr_pdsm_health(struct papr_scm_priv *p,
>  
>  	/* struct populated hence can release the mutex now */
>  	mutex_unlock(&p->health_mutex);
> +
> +	/* Populate the fuel gauge meter in the payload */
> +	rc = papr_pdsm_fuel_gauge(p, payload);
> +
> +	/* Error fetching fuel gauge is not fatal */
> +	if (rc < 0)
> +		dev_dbg(&p->pdev->dev, "Err(%d) fetching fuel gauge\n", rc);

Why even return an error?  Just have *_fuel_guage() the print the debugging and
return void.

> +
>  	rc = sizeof(struct nd_papr_pdsm_health);

You just override rc here anyway...

Ira

>  
>  out:
> -- 
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
