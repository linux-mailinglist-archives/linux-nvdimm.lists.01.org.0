Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1433264927
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 17:55:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16BA513D73CD3;
	Thu, 10 Sep 2020 08:55:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35F9F13D73CC4
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 08:55:53 -0700 (PDT)
IronPort-SDR: aE6f7HfrQYJ1kiXgv5NbjC2maHPDxwiZ05aUnBjDhGhUoerGJbj3GwQQbbRYIycOQY0jNbs+M1
 BhM0JyLhliAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="157848867"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600";
   d="scan'208";a="157848867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 08:55:53 -0700
IronPort-SDR: mdE+NB6LIJFFEpYlXw+w/dp1bIOLDHSskRELYdPHSV87quvSW71AhFkqp6C9isjWBxvi00K/Ij
 QcMBUzhKiWiA==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600";
   d="scan'208";a="480943809"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 08:55:52 -0700
Date: Thu, 10 Sep 2020 08:55:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Fix warning triggered by
 perf_stats_show()
Message-ID: <20200910155552.GN1930795@iweiny-DESK2.sc.intel.com>
References: <20200910092212.107674-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910092212.107674-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: HSQDIJOCDYBM6PMXBIOXBWFNEAXIYGGB
X-Message-ID-Hash: HSQDIJOCDYBM6PMXBIOXBWFNEAXIYGGB
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HSQDIJOCDYBM6PMXBIOXBWFNEAXIYGGB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2020 at 02:52:12PM +0530, Vaibhav Jain wrote:
> A warning is reported by the kernel in case perf_stats_show() returns
> an error code. The warning is of the form below:
> 
>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>  	  Failed to query performance stats, Err:-10
>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
> 
> On investigation it looks like that the compiler is silently truncating the
> return value of drc_pmem_query_stats() from 'long' to 'int', since the
> variable used to store the return code 'rc' is an 'int'. This
> truncated value is then returned back as a 'ssize_t' back from
> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
> unsigned number and triggers this warning..
> 
> To fix this we update the type of variable 'rc' from 'int' to
> 'ssize_t' that prevents the compiler from truncating the return value
> of drc_pmem_query_stats() and returning correct signed value back from
> perf_stats_show().
> 
> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
>        stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index a88a707a608aa..9f00b61676ab9 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -785,7 +785,8 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  static ssize_t perf_stats_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	int index, rc;
> +	int index;
> +	ssize_t rc;

I'm not sure this is really fixing everything here.

drc_pmem_query_stats() can return negative errno's.  Why are those not checked
somewhere in perf_stats_show()?

It seems like all this fix is handling is a > 0 return value: 'ret[0]' from
line 289 in papr_scm.c...  Or something?

Worse yet drc_pmem_query_stats() is returning ssize_t which is a signed value.
Therefore, it should not be returning -errno.  I'm surprised the static
checkers did not catch that.

I believe I caught similar errors with a patch series before which did not pay
attention to variable types.

Please audit this code for these types of errors and ensure you are really
doing the correct thing when using the sysfs interface.  I'm pretty sure bad
things will eventually happen (if they are not already) if you return some
really big number to the sysfs core from *_show().

Ira

>  	struct seq_buf s;
>  	struct papr_scm_perf_stat *stat;
>  	struct papr_scm_perf_stats *stats;
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
