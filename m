Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E2179090
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 13:44:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 743C510FC3634;
	Wed,  4 Mar 2020 04:45:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 924F41003ECBA
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 04:45:20 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 155BBB362;
	Wed,  4 Mar 2020 12:44:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 85A171E0E99; Wed,  4 Mar 2020 13:44:25 +0100 (CET)
Date: Wed, 4 Mar 2020 13:44:25 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 1/2] ndctl/test: Cleanup test-vs-production
 nvdimm module detection
Message-ID: <20200304124425.GD21048@quack2.suse.cz>
References: <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158327631042.2222444.6483138766986602497.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <158327631042.2222444.6483138766986602497.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: EGEIWNWYUZRIYUM3ZE5Q62DCR5W5SKEU
X-Message-ID-Hash: EGEIWNWYUZRIYUM3ZE5Q62DCR5W5SKEU
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EGEIWNWYUZRIYUM3ZE5Q62DCR5W5SKEU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 03-03-20 14:58:30, Dan Williams wrote:
> Update nfit_test_init() to use strcmp() instead of strstr() to filter
> which modules are probed to come from the out-of-tree unit-test set.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Link: http://lore.kernel.org/r/20200303132850.GA21048@quack2.suse.cz
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  test/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/test/core.c b/test/core.c
> index 888f5d8c0e42..3aa746fe6786 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -164,7 +164,7 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  		 * Don't check for device-dax modules on kernels older
>  		 * than 4.7.
>  		 */
> -		if (strstr(name, "dax")
> +		if (strcmp(name, "dax") == 0
>  				&& !ndctl_test_attempt(test,
>  					KERNEL_VERSION(4, 7, 0)))
>  			continue;
> @@ -172,8 +172,8 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  		/*
>  		 * Skip device-dax bus-model modules on pre-v5.1
>  		 */
> -		if ((strstr(name, "dax_pmem_core")
> -				|| strstr(name, "dax_pmem_compat"))
> +		if ((strcmp(name, "dax_pmem_core") == 0
> +				|| strcmp(name, "dax_pmem_compat") == 0)
>  				&& !ndctl_test_attempt(test,
>  					KERNEL_VERSION(5, 1, 0)))
>  			continue;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
