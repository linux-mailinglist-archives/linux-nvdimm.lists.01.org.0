Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B245179091
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 13:45:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D88210FC363D;
	Wed,  4 Mar 2020 04:45:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3083910FC3634
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 04:45:53 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E7F4EB2F5;
	Wed,  4 Mar 2020 12:44:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id ADF531E0E99; Wed,  4 Mar 2020 13:44:59 +0100 (CET)
Date: Wed, 4 Mar 2020 13:44:59 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 2/2] ndctl/test: Relax dax_pmem_compat
 requirement
Message-ID: <20200304124459.GE21048@quack2.suse.cz>
References: <158300774836.2141307.13052648687237614794.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158327631566.2222444.16879386597302511191.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <158327631566.2222444.16879386597302511191.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 65Q76GW7QCPCWBUXQLO5IVENCSAFZ2XC
X-Message-ID-Hash: 65Q76GW7QCPCWBUXQLO5IVENCSAFZ2XC
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/65Q76GW7QCPCWBUXQLO5IVENCSAFZ2XC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 03-03-20 14:58:35, Dan Williams wrote:
> While there are some tests that require the new "dax-bus" device model,
> none of the tests require compatibility mode. Drop the requirement so
> the tests work with DEV_DAX_PMEM_COMPAT=n kernels.
> 
> Link: http://lore.kernel.org/r/20200123154720.12097-1-jack@suse.cz
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  test/core.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/test/core.c b/test/core.c
> index 3aa746fe6786..5118d86483d4 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -180,6 +180,14 @@ int nfit_test_init(struct kmod_ctx **ctx, struct kmod_module **mod,
>  
>  retry:
>  		rc = kmod_module_new_from_name(*ctx, name, mod);
> +
> +		/*
> +		 * dax_pmem_compat is not required, missing is ok,
> +		 * present-but-production is not ok.
> +		 */
> +		if (rc && strcmp(name, "dax_pmem_compat") == 0)
> +			continue;
> +
>  		if (rc) {
>  			log_err(&log_ctx, "%s.ko: missing\n", name);
>  			break;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
