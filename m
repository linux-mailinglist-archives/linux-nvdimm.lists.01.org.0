Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA531DDB05
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 01:32:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 282EA1171B4BE;
	Thu, 21 May 2020 16:29:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 324AA116F5972
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 16:29:17 -0700 (PDT)
IronPort-SDR: k7i+6yIIkMhAiKIdohvXY6aPPPJ3GQDROd1L6HhytCr3O3FGqEFUL+BTMe0vqvBnAu5n46izsC
 myooPhHden2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:32:51 -0700
IronPort-SDR: iXDJu0gHCZ++z4lJs2CJwAwxWiqu1G57gotmEGMU7x42fkmIXHH5MA5pmiaIC0yU53MHWv3T5+
 0u4bppZYbnvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400";
   d="scan'208";a="467106648"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 21 May 2020 16:32:51 -0700
Date: Thu, 21 May 2020 16:32:51 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [RESEND PATCH v7 3/5] powerpc/papr_scm: Fetch nvdimm health
 information from PHYP
Message-ID: <20200521233250.GA310685@iweiny-DESK2.sc.intel.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com>
 <20200519190058.257981-4-vaibhav@linux.ibm.com>
 <20200520145430.GB3660833@iweiny-DESK2.sc.intel.com>
 <87tv0awmr5.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tv0awmr5.fsf@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 2V2QC6CRYDTDXUH5P75UZNCEQJQQVVPZ
X-Message-ID-Hash: 2V2QC6CRYDTDXUH5P75UZNCEQJQQVVPZ
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2V2QC6CRYDTDXUH5P75UZNCEQJQQVVPZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2020 at 10:45:58PM +0530, Vaibhav Jain wrote:
...

> > On Wed, May 20, 2020 at 12:30:56AM +0530, Vaibhav Jain wrote:

...

> >> @@ -39,6 +78,15 @@ struct papr_scm_priv {
> >>  	struct resource res;
> >>  	struct nd_region *region;
> >>  	struct nd_interleave_set nd_set;
> >> +
> >> +	/* Protect dimm health data from concurrent read/writes */
> >> +	struct mutex health_mutex;
> >> +
> >> +	/* Last time the health information of the dimm was updated */
> >> +	unsigned long lasthealth_jiffies;
> >> +
> >> +	/* Health information for the dimm */
> >> +	u64 health_bitmap;
> >
> > I wonder if this should be typed big endian as you mention that it is in the
> > commit message?
> This was discussed in an earlier review of the patch series at
> https://lore.kernel.org/linux-nvdimm/878sjetcis.fsf@mpe.ellerman.id.au
> 
> Even though health bitmap is returned in big endian format (For ex
> value 0xC00000000000000 indicates bits 0,1 set), its value is never
> used. Instead only test for specific bits being set in the register is
> done.
> 
> Hence using native cpu type instead of __be64 to store this value.

ok.

> 
> >
> >>  };
> >>  
> >>  static int drc_pmem_bind(struct papr_scm_priv *p)
> >> @@ -144,6 +192,62 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
> >>  	return drc_pmem_bind(p);
> >>  }
> >>  
> >> +/*
> >> + * Issue hcall to retrieve dimm health info and populate papr_scm_priv with the
> >> + * health information.
> >> + */
> >> +static int __drc_pmem_query_health(struct papr_scm_priv *p)
> >> +{
> >> +	unsigned long ret[PLPAR_HCALL_BUFSIZE];
> >
> > Is this exclusive to 64bit?  Why not u64?
> Yes this is specific to 64 bit as the array holds 64 bit register values
> returned from PHYP. Can u64 but here that will be a departure from existing
> practice within arch/powerpc code to use an unsigned long array to fetch
> returned values for PHYP.
> 
> >
> >> +	s64 rc;
> >
> > plpar_hcall() returns long and this function returns int and rc is declared
> > s64?
> >
> > Why not have them all be long to follow plpar_hcall?
> Yes 'long' type is better suited for variable 'rc' and I will get it fixed.
> 
> But the value of variable 'rc' is never directly returned from this
> function, we always return kernel error codes instead. Hence the
> return type of this function is consistent.

Honestly masking the error return of plpar_hcall() seems a problem as well...
but ok.

Ira

> 
> >
> >> +
> >> +	/* issue the hcall */
> >> +	rc = plpar_hcall(H_SCM_HEALTH, ret, p->drc_index);
> >> +	if (rc != H_SUCCESS) {
> >> +		dev_err(&p->pdev->dev,
> >> +			 "Failed to query health information, Err:%lld\n", rc);
> >> +		rc = -ENXIO;
> >> +		goto out;
> >> +	}
> >> +
> >> +	p->lasthealth_jiffies = jiffies;
> >> +	p->health_bitmap = ret[0] & ret[1];
> >> +
> >> +	dev_dbg(&p->pdev->dev,
> >> +		"Queried dimm health info. Bitmap:0x%016lx Mask:0x%016lx\n",
> >> +		ret[0], ret[1]);
> >> +out:
> >> +	return rc;
> >> +}
> >> +
> >> +/* Min interval in seconds for assuming stable dimm health */
> >> +#define MIN_HEALTH_QUERY_INTERVAL 60
> >> +
> >> +/* Query cached health info and if needed call drc_pmem_query_health */
> >> +static int drc_pmem_query_health(struct papr_scm_priv *p)
> >> +{
> >> +	unsigned long cache_timeout;
> >> +	s64 rc;
> >> +
> >> +	/* Protect concurrent modifications to papr_scm_priv */
> >> +	rc = mutex_lock_interruptible(&p->health_mutex);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	/* Jiffies offset for which the health data is assumed to be same */
> >> +	cache_timeout = p->lasthealth_jiffies +
> >> +		msecs_to_jiffies(MIN_HEALTH_QUERY_INTERVAL * 1000);
> >> +
> >> +	/* Fetch new health info is its older than MIN_HEALTH_QUERY_INTERVAL */
> >> +	if (time_after(jiffies, cache_timeout))
> >> +		rc = __drc_pmem_query_health(p);
> >
> > And back to s64 after returning int?
> Agree, will change 's64 rc' to 'int rc'.
> 
> >
> >> +	else
> >> +		/* Assume cached health data is valid */
> >> +		rc = 0;
> >> +
> >> +	mutex_unlock(&p->health_mutex);
> >> +	return rc;
> >> +}
> >>  
> >>  static int papr_scm_meta_get(struct papr_scm_priv *p,
> >>  			     struct nd_cmd_get_config_data_hdr *hdr)
> >> @@ -286,6 +390,64 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
> >>  	return 0;
> >>  }
> >>  
> >> +static ssize_t flags_show(struct device *dev,
> >> +				struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct nvdimm *dimm = to_nvdimm(dev);
> >> +	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
> >> +	struct seq_buf s;
> >> +	u64 health;
> >> +	int rc;
> >> +
> >> +	rc = drc_pmem_query_health(p);
> >
> > and back to int...
> >
> drc_pmem_query_health() returns an 'int' so the type of variable 'rc'
> looks correct to me.
> 
> > Just make them long all through...
> I think the return type for above all functions is 'int' with
> an issue in drc_pmem_query_health() that you pointed out.
> 
> With that fixed the usage of 'int' return type for functions will become
> consistent.
> 
> >
> > Ira
> >
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	/* Copy health_bitmap locally, check masks & update out buffer */
> >> +	health = READ_ONCE(p->health_bitmap);
> >> +
> >> +	seq_buf_init(&s, buf, PAGE_SIZE);
> >> +	if (health & PAPR_SCM_DIMM_UNARMED_MASK)
> >> +		seq_buf_printf(&s, "not_armed ");
> >> +
> >> +	if (health & PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK)
> >> +		seq_buf_printf(&s, "flush_fail ");
> >> +
> >> +	if (health & PAPR_SCM_DIMM_BAD_RESTORE_MASK)
> >> +		seq_buf_printf(&s, "restore_fail ");
> >> +
> >> +	if (health & PAPR_SCM_DIMM_ENCRYPTED)
> >> +		seq_buf_printf(&s, "encrypted ");
> >> +
> >> +	if (health & PAPR_SCM_DIMM_SMART_EVENT_MASK)
> >> +		seq_buf_printf(&s, "smart_notify ");
> >> +
> >> +	if (health & PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED)
> >> +		seq_buf_printf(&s, "scrubbed locked ");
> >> +
> >> +	if (seq_buf_used(&s))
> >> +		seq_buf_printf(&s, "\n");
> >> +
> >> +	return seq_buf_used(&s);
> >> +}
> >> +DEVICE_ATTR_RO(flags);
> >> +
> >> +/* papr_scm specific dimm attributes */
> >> +static struct attribute *papr_scm_nd_attributes[] = {
> >> +	&dev_attr_flags.attr,
> >> +	NULL,
> >> +};
> >> +
> >> +static struct attribute_group papr_scm_nd_attribute_group = {
> >> +	.name = "papr",
> >> +	.attrs = papr_scm_nd_attributes,
> >> +};
> >> +
> >> +static const struct attribute_group *papr_scm_dimm_attr_groups[] = {
> >> +	&papr_scm_nd_attribute_group,
> >> +	NULL,
> >> +};
> >> +
> >>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
> >>  {
> >>  	struct device *dev = &p->pdev->dev;
> >> @@ -312,8 +474,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
> >>  	dimm_flags = 0;
> >>  	set_bit(NDD_LABELING, &dimm_flags);
> >>  
> >> -	p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
> >> -				  PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
> >> +	p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_attr_groups,
> >> +				  dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
> >>  	if (!p->nvdimm) {
> >>  		dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
> >>  		goto err;
> >> @@ -399,6 +561,9 @@ static int papr_scm_probe(struct platform_device *pdev)
> >>  	if (!p)
> >>  		return -ENOMEM;
> >>  
> >> +	/* Initialize the dimm mutex */
> >> +	mutex_init(&p->health_mutex);
> >> +
> >>  	/* optional DT properties */
> >>  	of_property_read_u32(dn, "ibm,metadata-size", &metadata_size);
> >>  
> >> -- 
> >> 2.26.2
> >> _______________________________________________
> >> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> >> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> 
> -- 
> Cheers
> ~ Vaibhav
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
