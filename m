Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FE1EFE97
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 19:13:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 710A51009F03B;
	Fri,  5 Jun 2020 10:08:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E879C1009F039
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 10:08:01 -0700 (PDT)
IronPort-SDR: 7kT/yc6stHJ6h8FGOkCONAtSzcq3wE17Xa5sB31ExUJlnEHZdSLqcYh5Kk1fCK/qCdhu1bkCrd
 1J3/4loASowQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 10:13:13 -0700
IronPort-SDR: 8dXeibKw9Oymx4zZCYxphg3R+QpK3j/MMW6EYOklYlz1iNt6dXs2V1i7rgC+IijYWiuL9QozSq
 vrfI0EMm/8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400";
   d="scan'208";a="273530919"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2020 10:13:13 -0700
Date: Fri, 5 Jun 2020 10:13:13 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 4/6] powerpc/papr_scm: Improve error logging and
 handling papr_scm_ndctl()
Message-ID: <20200605171313.GO1505637@iweiny-DESK2.sc.intel.com>
References: <20200604234136.253703-1-vaibhav@linux.ibm.com>
 <20200604234136.253703-5-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200604234136.253703-5-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: WISBXAIIRMLKJFPRCT4HY5RJ4VKOXTOS
X-Message-ID-Hash: WISBXAIIRMLKJFPRCT4HY5RJ4VKOXTOS
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WISBXAIIRMLKJFPRCT4HY5RJ4VKOXTOS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 05, 2020 at 05:11:34AM +0530, Vaibhav Jain wrote:
> Since papr_scm_ndctl() can be called from outside papr_scm, its
> exposed to the possibility of receiving NULL as value of 'cmd_rc'
> argument. This patch updates papr_scm_ndctl() to protect against such
> possibility by assigning it pointer to a local variable in case cmd_rc
> == NULL.
> 
> Finally the patch also updates the 'default' clause of the switch-case
> block removing a 'return' statement thereby ensuring that value of
> 'cmd_rc' is always logged when papr_scm_ndctl() returns.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v9..v10
> * New patch in the series

Thanks for making this a separate patch it is easier to see what is going on
here.

> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0c091622b15e..6512fe6a2874 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -355,11 +355,16 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  {
>  	struct nd_cmd_get_config_size *get_size_hdr;
>  	struct papr_scm_priv *p;
> +	int rc;
>  
>  	/* Only dimm-specific calls are supported atm */
>  	if (!nvdimm)
>  		return -EINVAL;
>  
> +	/* Use a local variable in case cmd_rc pointer is NULL */
> +	if (!cmd_rc)
> +		cmd_rc = &rc;
> +

This protects you from the NULL.  However...

>  	p = nvdimm_provider_data(nvdimm);
>  
>  	switch (cmd) {
> @@ -381,12 +386,13 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  		break;
>  
>  	default:
> -		return -EINVAL;
> +		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
> +		*cmd_rc = -EINVAL;

... I think you are conflating rc and cmd_rc...

>  	}
>  
>  	dev_dbg(&p->pdev->dev, "returned with cmd_rc = %d\n", *cmd_rc);
>  
> -	return 0;
> +	return *cmd_rc;

... this changes the behavior of the current commands.  Now if the underlying
papr_scm_meta_[get|set]() fails you return that failure as rc rather than 0.

Is that ok?

Also 'logging cmd_rc' in the invalid cmd case does not seem quite right unless
you really want rc to be cmd_rc.

The architecture is designed to separate errors which occur in the kernel vs
errors in the firmware/dimm.  Are they always the same?  The current code
differentiates them.

Ira

>  }
>  
>  static ssize_t flags_show(struct device *dev,
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
