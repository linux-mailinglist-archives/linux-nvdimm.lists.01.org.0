Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011BDF58E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:03:08 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E36A1007B824;
	Mon, 21 Oct 2019 12:04:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 370FC1007988B
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 01:49:27 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id D3542B730;
	Mon, 21 Oct 2019 08:47:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 18AF91E4AA0; Mon, 21 Oct 2019 10:47:38 +0200 (CEST)
Date: Mon, 21 Oct 2019 10:47:38 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
Message-ID: <20191021084738.GA17810@quack2.suse.cz>
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: THKJFRLCUSGUBRKIYEHQZ5TR4RBMKT33
X-Message-ID-Hash: THKJFRLCUSGUBRKIYEHQZ5TR4RBMKT33
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/THKJFRLCUSGUBRKIYEHQZ5TR4RBMKT33/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat 19-10-19 09:26:19, Dan Williams wrote:
> Check for NULL entries before checking the entry order, otherwise NULL
> is misinterpreted as a present pte conflict. The 'order' check needs to
> happen before the locked check as an unlocked entry at the wrong order
> must fallback to lookup the correct order.
> 
> Reported-by: Jeff Smits <jeff.smits@intel.com>
> Reported-by: Doug Nelson <doug.nelson@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Good catch! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a71881e77204..08160011d94c 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -221,10 +221,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>  
>  	for (;;) {
>  		entry = xas_find_conflict(xas);
> +		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> +			return entry;
>  		if (dax_entry_order(entry) < order)
>  			return XA_RETRY_ENTRY;
> -		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> -				!dax_is_locked(entry))
> +		if (!dax_is_locked(entry))
>  			return entry;
>  
>  		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
