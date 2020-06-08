Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718401F1CEA
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Jun 2020 18:07:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E654710109146;
	Mon,  8 Jun 2020 09:07:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7A6A10106A09
	for <linux-nvdimm@lists.01.org>; Mon,  8 Jun 2020 09:07:49 -0700 (PDT)
IronPort-SDR: M3UprTygFNs7grnzZemtENq2yHwr/lC8G3Wj0F6MAjvRfbc0SkX7PbGq22frsCcYk/hxORptjI
 3j4HpVz/YRLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 09:07:48 -0700
IronPort-SDR: nj6H1nx1dfa6r0w/NIMfuEQlWaDAdrMcRgCbwY9lcFrLKtz9i47DJxhXA9oOgKYhQw47y86wAk
 mNLDIM8YSp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400";
   d="scan'208";a="258727589"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2020 09:07:48 -0700
Date: Mon, 8 Jun 2020 09:07:48 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v11 4/6] powerpc/papr_scm: Improve error logging and
 handling papr_scm_ndctl()
Message-ID: <20200608160747.GA2936401@iweiny-DESK2.sc.intel.com>
References: <20200607131339.476036-1-vaibhav@linux.ibm.com>
 <20200607131339.476036-5-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200607131339.476036-5-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: GNBL7G2WM5XJSFVJEQSQTNEKNFP7GVTH
X-Message-ID-Hash: GNBL7G2WM5XJSFVJEQSQTNEKNFP7GVTH
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GNBL7G2WM5XJSFVJEQSQTNEKNFP7GVTH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jun 07, 2020 at 06:43:37PM +0530, Vaibhav Jain wrote:
> Since papr_scm_ndctl() can be called from outside papr_scm, its
> exposed to the possibility of receiving NULL as value of 'cmd_rc'
> argument. This patch updates papr_scm_ndctl() to protect against such
> possibility by assigning it pointer to a local variable in case cmd_rc
> == NULL.
> 
> Finally the patch also updates the 'default' add a debug log unknown
> 'cmd' values.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v10..v11:
> * Instead of returning *cmd_rd just return '0' in case nd_cmd is
>   handled. In case of unknown nd-cmd return -EINVAL
>   [ Ira and Dan Williams ]
> * Updated patch description.
> 
> v9..v10
> * New patch in the series
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0c091622b15e..692ad3d79826 100644
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
>  	p = nvdimm_provider_data(nvdimm);
>  
>  	switch (cmd) {
> @@ -381,6 +386,7 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  		break;
>  
>  	default:
> +		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
