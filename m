Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C95233FC7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 09:12:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAA0012871EA6;
	Fri, 31 Jul 2020 00:12:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 798391286FDFC
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 00:12:54 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V70dii019649;
	Fri, 31 Jul 2020 03:12:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32maxxn7j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 03:12:47 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V70vI0020921;
	Fri, 31 Jul 2020 03:12:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32maxxn7fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 03:12:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V74RwK015159;
	Fri, 31 Jul 2020 07:12:39 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma04dal.us.ibm.com with ESMTP id 32gcq24urk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 07:12:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V7CcWi28967412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2020 07:12:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6967D6A051;
	Fri, 31 Jul 2020 07:12:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 692F36A04F;
	Fri, 31 Jul 2020 07:12:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.75.5])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2020 07:12:35 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v4 1/2] powerpc/papr_scm: Fetch nvdimm performance stats
 from PHYP
In-Reply-To: <20200731064153.182203-2-vaibhav@linux.ibm.com>
References: <20200731064153.182203-1-vaibhav@linux.ibm.com>
 <20200731064153.182203-2-vaibhav@linux.ibm.com>
Date: Fri, 31 Jul 2020 12:42:32 +0530
Message-ID: <87ime4yx7j.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_01:2020-07-30,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=2
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310047
Message-ID-Hash: 2YE7PPZUFY2NTAREMZSZBMMGBEOQK62F
X-Message-ID-Hash: 2YE7PPZUFY2NTAREMZSZBMMGBEOQK62F
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2YE7PPZUFY2NTAREMZSZBMMGBEOQK62F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Update papr_scm.c to query dimm performance statistics from PHYP via
> H_SCM_PERFORMANCE_STATS hcall and export them to user-space as PAPR
> specific NVDIMM attribute 'perf_stats' in sysfs. The patch also
> provide a sysfs ABI documentation for the stats being reported and
> their meanings.
>
> During NVDIMM probe time in papr_scm_nvdimm_init() a special variant
> of H_SCM_PERFORMANCE_STATS hcall is issued to check if collection of
> performance statistics is supported or not. If successful then a PHYP
> returns a maximum possible buffer length needed to read all
> performance stats. This returned value is stored in a per-nvdimm
> attribute 'stat_buffer_len'.
>
> The layout of request buffer for reading NVDIMM performance stats from
> PHYP is defined in 'struct papr_scm_perf_stats' and 'struct
> papr_scm_perf_stat'. These structs are used in newly introduced
> drc_pmem_query_stats() that issues the H_SCM_PERFORMANCE_STATS hcall.
>
> The sysfs access function perf_stats_show() uses value
> 'stat_buffer_len' to allocate a buffer large enough to hold all
> possible NVDIMM performance stats and passes it to
> drc_pmem_query_stats() to populate. Finally statistics reported in the
> buffer are formatted into the sysfs access function output buffer.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v4:
> * Fixed a build issue with this patch by moving a hunk from second
>   patch in series to this patch. [ Aneesh ]
>
> v3:
> * Updated drc_pmem_query_stats() to not require 'buff_size' and 'out'
>   args to the function. Instead 'buff_size' is calculated from
>   'num_stats' and instead of populating 'R4' in arg 'out' the value is
>   returned from the function in case 'R4' represents
>   'max-buffer-size'.
>
> Resend:
> None
>
> v2:
> * Updated 'struct papr_scm_perf_stats' and 'struct papr_scm_perf_stat'
> to use big-endian types. [ Aneesh ]
> * s/len_stat_buffer/stat_buffer_len/ [ Aneesh ]
> * s/statistics_id/stat_id/ , s/statistics_val/stat_val/ [ Aneesh ]
> * Conversion from Big endian to cpu endian happens later rather than
> just after its fetched from PHYP.
> * Changed a log statement to unambiguously report dimm performance
> stats are not available for the given nvdimm [ Ira ]
> * Restructed some code to handle error case first [ Ira ]
> ---
>  Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 ++++
>  arch/powerpc/platforms/pseries/papr_scm.c     | 150 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-papr-pmem b/Documentation/ABI/testing/sysfs-bus-papr-pmem
> index 5b10d036a8d4..c1a67275c43f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-papr-pmem
> +++ b/Documentation/ABI/testing/sysfs-bus-papr-pmem
> @@ -25,3 +25,30 @@ Description:
>  				  NVDIMM have been scrubbed.
>  		* "locked"	: Indicating that NVDIMM contents cant
>  				  be modified until next power cycle.
> +
> +What:		/sys/bus/nd/devices/nmemX/papr/perf_stats
> +Date:		May, 2020
> +KernelVersion:	v5.9
> +Contact:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm@lists.01.org,
> +Description:
> +		(RO) Report various performance stats related to papr-scm NVDIMM
> +		device.  Each stat is reported on a new line with each line
> +		composed of a stat-identifier followed by it value. Below are
> +		currently known dimm performance stats which are reported:
> +
> +		* "CtlResCt" : Controller Reset Count
> +		* "CtlResTm" : Controller Reset Elapsed Time
> +		* "PonSecs " : Power-on Seconds
> +		* "MemLife " : Life Remaining
> +		* "CritRscU" : Critical Resource Utilization
> +		* "HostLCnt" : Host Load Count
> +		* "HostSCnt" : Host Store Count
> +		* "HostSDur" : Host Store Duration
> +		* "HostLDur" : Host Load Duration
> +		* "MedRCnt " : Media Read Count
> +		* "MedWCnt " : Media Write Count
> +		* "MedRDur " : Media Read Duration
> +		* "MedWDur " : Media Write Duration
> +		* "CchRHCnt" : Cache Read Hit Count
> +		* "CchWHCnt" : Cache Write Hit Count
> +		* "FastWCnt" : Fast Write Count
> \ No newline at end of file
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 3d1235a76ba9..f37f3f70007d 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -64,6 +64,26 @@
>  				    PAPR_PMEM_HEALTH_FATAL |	\
>  				    PAPR_PMEM_HEALTH_UNHEALTHY)
>  
> +#define PAPR_SCM_PERF_STATS_EYECATCHER __stringify(SCMSTATS)
> +#define PAPR_SCM_PERF_STATS_VERSION 0x1
> +
> +/* Struct holding a single performance metric */
> +struct papr_scm_perf_stat {
> +	u8 stat_id[8];
> +	__be64 stat_val;
> +} __packed;
> +
> +/* Struct exchanged between kernel and PHYP for fetching drc perf stats */
> +struct papr_scm_perf_stats {
> +	u8 eye_catcher[8];
> +	/* Should be PAPR_SCM_PERF_STATS_VERSION */
> +	__be32 stats_version;
> +	/* Number of stats following */
> +	__be32 num_statistics;
> +	/* zero or more performance matrics */
> +	struct papr_scm_perf_stat scm_statistic[];
> +} __packed;
> +
>  /* private struct associated with each region */
>  struct papr_scm_priv {
>  	struct platform_device *pdev;
> @@ -92,6 +112,9 @@ struct papr_scm_priv {
>  
>  	/* Health information for the dimm */
>  	u64 health_bitmap;
> +
> +	/* length of the stat buffer as expected by phyp */
> +	size_t stat_buffer_len;
>  };
>  
>  static LIST_HEAD(papr_nd_regions);
> @@ -200,6 +223,79 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
>  	return drc_pmem_bind(p);
>  }
>  
> +/*
> + * Query the Dimm performance stats from PHYP and copy them (if returned) to
> + * provided struct papr_scm_perf_stats instance 'stats' that can hold atleast
> + * (num_stats + header) bytes.
> + * - If buff_stats == NULL the return value is the size in byes of the buffer
> + * needed to hold all supported performance-statistics.
> + * - If buff_stats != NULL and num_stats == 0 then we copy all known
> + * performance-statistics to 'buff_stat' and expect to be large enough to
> + * hold them.
> + * - if buff_stats != NULL and num_stats > 0 then copy the requested
> + * performance-statistics to buff_stats.
> + */
> +static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
> +				    struct papr_scm_perf_stats *buff_stats,
> +				    unsigned int num_stats)
> +{
> +	unsigned long ret[PLPAR_HCALL_BUFSIZE];
> +	size_t size;
> +	s64 rc;
> +
> +	/* Setup the out buffer */
> +	if (buff_stats) {
> +		memcpy(buff_stats->eye_catcher,
> +		       PAPR_SCM_PERF_STATS_EYECATCHER, 8);
> +		buff_stats->stats_version =
> +			cpu_to_be32(PAPR_SCM_PERF_STATS_VERSION);
> +		buff_stats->num_statistics =
> +			cpu_to_be32(num_stats);
> +
> +		/*
> +		 * Calculate the buffer size based on num-stats provided
> +		 * or use the prefetched max buffer length
> +		 */
> +		if (num_stats)
> +			/* Calculate size from the num_stats */
> +			size = sizeof(struct papr_scm_perf_stats) +
> +				num_stats * sizeof(struct papr_scm_perf_stat);
> +		else
> +			size = p->stat_buffer_len;
> +	} else {
> +		/* In case of no out buffer ignore the size */
> +		size = 0;
> +	}
> +
> +	/* Do the HCALL asking PHYP for info */
> +	rc = plpar_hcall(H_SCM_PERFORMANCE_STATS, ret, p->drc_index,
> +			 buff_stats ? virt_to_phys(buff_stats) : 0,
> +			 size);
> +
> +	/* Check if the error was due to an unknown stat-id */
> +	if (rc == H_PARTIAL) {
> +		dev_err(&p->pdev->dev,
> +			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
> +		return -ENOENT;
> +	} else if (rc != H_SUCCESS) {
> +		dev_err(&p->pdev->dev,
> +			"Failed to query performance stats, Err:%lld\n", rc);
> +		return -EIO;
> +
> +	} else if (!size) {
> +		/* Handle case where stat buffer size was requested */
> +		dev_dbg(&p->pdev->dev,
> +			"Performance stats size %ld\n", ret[0]);
> +		return ret[0];
> +	}
> +
> +	/* Successfully fetched the requested stats from phyp */
> +	dev_dbg(&p->pdev->dev,
> +		"Performance stats returned %d stats\n",
> +		be32_to_cpu(buff_stats->num_statistics));
> +	return 0;
> +}
> +
>  /*
>   * Issue hcall to retrieve dimm health info and populate papr_scm_priv with the
>   * health information.
> @@ -637,6 +733,48 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  	return 0;
>  }
>  
> +static ssize_t perf_stats_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	int index, rc;
> +	struct seq_buf s;
> +	struct papr_scm_perf_stat *stat;
> +	struct papr_scm_perf_stats *stats;
> +	struct nvdimm *dimm = to_nvdimm(dev);
> +	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
> +
> +	if (!p->stat_buffer_len)
> +		return -ENOENT;
> +
> +	/* Allocate the buffer for phyp where stats are written */
> +	stats = kzalloc(p->stat_buffer_len, GFP_KERNEL);
> +	if (!stats)
> +		return -ENOMEM;
> +
> +	/* Ask phyp to return all dimm perf stats */
> +	rc = drc_pmem_query_stats(p, stats, 0);
> +	if (rc)
> +		goto free_stats;

So we end up making a HCALL for each read of the sysfs file? You do
throttle that for PAPR_HEALTH hcall (flags sysfs file). Do we need to do
that here? If not should we make this CAP_SYS_ADMIN?  You can possibly
add is_visible callback to papr group and then restrict this all to
CAP_SYS_ADMIN?


> +	/*
> +	 * Go through the returned output buffer and print stats and
> +	 * values. Since stat_id is essentially a char string of
> +	 * 8 bytes, simply use the string format specifier to print it.
> +	 */
> +	seq_buf_init(&s, buf, PAGE_SIZE);
> +	for (index = 0, stat = stats->scm_statistic;
> +	     index < be32_to_cpu(stats->num_statistics);
> +	     ++index, ++stat) {
> +		seq_buf_printf(&s, "%.8s = 0x%016llX\n",
> +			       stat->stat_id,
> +			       be64_to_cpu(stat->stat_val));
> +	}
> +
> +free_stats:
> +	kfree(stats);
> +	return rc ? rc : seq_buf_used(&s);
> +}
> +DEVICE_ATTR_RO(perf_stats);
> +
>  static ssize_t flags_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
> @@ -682,6 +820,7 @@ DEVICE_ATTR_RO(flags);
>  /* papr_scm specific dimm attributes */
>  static struct attribute *papr_nd_attributes[] = {
>  	&dev_attr_flags.attr,
> +	&dev_attr_perf_stats.attr,
>  	NULL,
>  };
>  
> @@ -702,6 +841,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	struct nd_region_desc ndr_desc;
>  	unsigned long dimm_flags;
>  	int target_nid, online_nid;
> +	ssize_t stat_size;
>  
>  	p->bus_desc.ndctl = papr_scm_ndctl;
>  	p->bus_desc.module = THIS_MODULE;
> @@ -769,6 +909,16 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	list_add_tail(&p->region_list, &papr_nd_regions);
>  	mutex_unlock(&papr_ndr_lock);
>  
> +	/* Try retriving the stat buffer and see if its supported */
> +	stat_size = drc_pmem_query_stats(p, NULL, 0);
> +	if (stat_size > 0) {
> +		p->stat_buffer_len = stat_size;
> +		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
> +			p->stat_buffer_len);
> +	} else {
> +		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
> +	}
> +
>  	return 0;
>  
>  err:	nvdimm_bus_unregister(p->bus);
> -- 
> 2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
