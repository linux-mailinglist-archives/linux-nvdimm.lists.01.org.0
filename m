Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC027B15B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:04:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1AF78143A367B;
	Mon, 28 Sep 2020 09:04:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6124313AA072E
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:04:50 -0700 (PDT)
IronPort-SDR: LI1ZcfUXlSnnW7joATvn0rOjx27PFWaChMA/G2ejxK3ouQlbbkFQVj73I4RTHoQsuHoSx5y7P1
 CtEP6T3swlkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="149791977"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400";
   d="scan'208";a="149791977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:04:44 -0700
IronPort-SDR: r02vg2GzNT9s6ig5PnS8z6+btkjA2PxNk8YI5QVkNNrotNBPht0BBBVH0n/5MNu01J2R2YNsBi
 xeYBM+AB0Q6A==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400";
   d="scan'208";a="514311781"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:04:43 -0700
Date: Mon, 28 Sep 2020 09:04:43 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Support dynamic enable/disable of
 performance statistics
Message-ID: <20200928160443.GB458519@iweiny-DESK2.sc.intel.com>
References: <20200913212115.24958-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200913212115.24958-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: GV2FDIKN3XF5FZZBQTK22ERR2G4IRV5I
X-Message-ID-Hash: GV2FDIKN3XF5FZZBQTK22ERR2G4IRV5I
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GV2FDIKN3XF5FZZBQTK22ERR2G4IRV5I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 14, 2020 at 02:51:15AM +0530, Vaibhav Jain wrote:
> Collection of performance statistics of an NVDIMM can be dynamically
> enabled/disabled from the Hypervisor Management Console even when the
> guest lpar is running. The current implementation however will check if
> the performance statistics collection is supported during NVDIMM probe
> and if yes will assume that to be the case afterwards.
> 
> Hence we update papr_scm to remove this assumption from the code by
> eliminating the 'stat_buffer_len' member from 'struct papr_scm_priv'
> that was used to cache the max buffer size needed to fetch NVDIMM
> performance stats from PHYP. With that struct member gone, various
> functions that depended on it are updated. Specifically
> perf_stats_show() is updated to query the PHYP first for the size of
> buffer needed to hold all performance statistics instead of relying on
> 'stat_buffer_len'
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 53 +++++++++++------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 27268370dee00..6697e1c3b9ebe 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -112,9 +112,6 @@ struct papr_scm_priv {
>  
>  	/* Health information for the dimm */
>  	u64 health_bitmap;
> -
> -	/* length of the stat buffer as expected by phyp */
> -	size_t stat_buffer_len;
>  };
>  
>  static LIST_HEAD(papr_nd_regions);
> @@ -230,14 +227,15 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
>   * - If buff_stats == NULL the return value is the size in byes of the buffer
>   * needed to hold all supported performance-statistics.
>   * - If buff_stats != NULL and num_stats == 0 then we copy all known
> - * performance-statistics to 'buff_stat' and expect to be large enough to
> - * hold them.
> + * performance-statistics to 'buff_stat' and expect it to be large enough to
> + * hold them. The 'buff_size' args contains the size of the 'buff_stats'
>   * - if buff_stats != NULL and num_stats > 0 then copy the requested
>   * performance-statistics to buff_stats.
>   */
>  static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>  				    struct papr_scm_perf_stats *buff_stats,
> -				    unsigned int num_stats)
> +				    unsigned int num_stats,
> +				    size_t buff_size)
>  {
>  	unsigned long ret[PLPAR_HCALL_BUFSIZE];
>  	size_t size;
> @@ -261,12 +259,18 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>  			size = sizeof(struct papr_scm_perf_stats) +
>  				num_stats * sizeof(struct papr_scm_perf_stat);
>  		else
> -			size = p->stat_buffer_len;
> +			size = buff_size;
>  	} else {
>  		/* In case of no out buffer ignore the size */
>  		size = 0;
>  	}
>  
> +	/* verify that the buffer size needed is sufficient */
> +	if (size > buff_size) {
> +		__WARN();
> +		return -EINVAL;
> +	}
> +
>  	/* Do the HCALL asking PHYP for info */
>  	rc = plpar_hcall(H_SCM_PERFORMANCE_STATS, ret, p->drc_index,
>  			 buff_stats ? virt_to_phys(buff_stats) : 0,
> @@ -277,6 +281,10 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>  		dev_err(&p->pdev->dev,
>  			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
>  		return -ENOENT;
> +	} else if (rc == H_AUTHORITY) {
> +		dev_dbg(&p->pdev->dev,
> +			"Performance stats in-accessible\n");
> +		return -EPERM;
>  	} else if (rc != H_SUCCESS) {
>  		dev_err(&p->pdev->dev,
>  			"Failed to query performance stats, Err:%lld\n", rc);
> @@ -526,10 +534,6 @@ static int papr_pdsm_fuel_gauge(struct papr_scm_priv *p,
>  	struct papr_scm_perf_stat *stat;
>  	struct papr_scm_perf_stats *stats;
>  
> -	/* Silently fail if fetching performance metrics isn't  supported */
> -	if (!p->stat_buffer_len)
> -		return 0;
> -
>  	/* Allocate request buffer enough to hold single performance stat */
>  	size = sizeof(struct papr_scm_perf_stats) +
>  		sizeof(struct papr_scm_perf_stat);
> @@ -543,9 +547,11 @@ static int papr_pdsm_fuel_gauge(struct papr_scm_priv *p,
>  	stat->stat_val = 0;
>  
>  	/* Fetch the fuel gauge and populate it in payload */
> -	rc = drc_pmem_query_stats(p, stats, 1);
> +	rc = drc_pmem_query_stats(p, stats, 1, size);
>  	if (rc < 0) {
>  		dev_dbg(&p->pdev->dev, "Err(%d) fetching fuel gauge\n", rc);
> +		/* Silently fail if unable to fetch performance metric */
> +		rc = 0;
>  		goto free_stats;
>  	}
>  
> @@ -786,23 +792,25 @@ static ssize_t perf_stats_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
>  	int index;
> -	ssize_t rc;
> +	ssize_t rc, buff_len;
>  	struct seq_buf s;
>  	struct papr_scm_perf_stat *stat;
>  	struct papr_scm_perf_stats *stats;
>  	struct nvdimm *dimm = to_nvdimm(dev);
>  	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
>  
> -	if (!p->stat_buffer_len)
> -		return -ENOENT;
> +	/* fetch the length of buffer needed to get all stats */
> +	buff_len = drc_pmem_query_stats(p, NULL, 0, 0);
> +	if (buff_len <= 0)
> +		return buff_len;

Generally I can't find anything wrong with this patch technically but the
architecture of drc_pmem_query_stats() seems overly complicated.

IOW, I feel like you are overloading drc_pmem_query_stats() in an odd way which
makes it and the callers code confusing.  Why can't you have a separate
function which returns the max buffer length and separate out the logic within
drc_pmem_query_stats() to make it clear how to call plpar_hcall() to get this
information?

Ira

>  
>  	/* Allocate the buffer for phyp where stats are written */
> -	stats = kzalloc(p->stat_buffer_len, GFP_KERNEL);
> +	stats = kzalloc(buff_len, GFP_KERNEL);
>  	if (!stats)
>  		return -ENOMEM;
>  
>  	/* Ask phyp to return all dimm perf stats */
> -	rc = drc_pmem_query_stats(p, stats, 0);
> +	rc = drc_pmem_query_stats(p, stats, 0, buff_len);
>  	if (rc)
>  		goto free_stats;
>  	/*
> @@ -891,7 +899,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	struct nd_region_desc ndr_desc;
>  	unsigned long dimm_flags;
>  	int target_nid, online_nid;
> -	ssize_t stat_size;
>  
>  	p->bus_desc.ndctl = papr_scm_ndctl;
>  	p->bus_desc.module = THIS_MODULE;
> @@ -962,16 +969,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	list_add_tail(&p->region_list, &papr_nd_regions);
>  	mutex_unlock(&papr_ndr_lock);
>  
> -	/* Try retriving the stat buffer and see if its supported */
> -	stat_size = drc_pmem_query_stats(p, NULL, 0);
> -	if (stat_size > 0) {
> -		p->stat_buffer_len = stat_size;
> -		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
> -			p->stat_buffer_len);
> -	} else {
> -		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
> -	}
> -
>  	return 0;
>  
>  err:	nvdimm_bus_unregister(p->bus);
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
