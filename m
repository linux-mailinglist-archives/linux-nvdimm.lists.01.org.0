Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DFDDB03
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Oct 2019 22:50:09 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83CEB1007B6B5;
	Sat, 19 Oct 2019 13:52:05 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 563931007B6B4
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=vbPmDbJYJWKyeK0k+G+8kKAF+nSpAsbuTcFnR8Fac1Q=; b=VBOM8ALHBxuQDtxSnr/K8IhOk
	YS+OXjD7EM96EzTrltFEBRFvyu3vTQyScYFIgXlRrWU/SS00QDJsCAJjBa7VtZKv3e+vnUrC7QO4W
	Wzdg/9xg1SzJYKmEREwmo4y9jKEQcOg9CErjABpBg1umbq9nSBgQ+fmurJelYsVegUwwI7QFVl+jd
	Jhaz5NByjv1d8wIJrg7ISfs2lYSVYm4tyKUzqnRTYPFKOsFeJndEYCKko/t+leEfBB5dNIEXP11sU
	2JUIokXixpXQuE5VjXPTujvDwqBvhC0OIbrBoCYHW/NnQZ4TnwpeZvoD2+B2p+qmmIMTlU4VDY0q9
	650UY7YBw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLvfn-0003xi-MD; Sat, 19 Oct 2019 20:50:03 +0000
Date: Sat, 19 Oct 2019 13:50:03 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
Message-ID: <20191019205003.GN32665@bombadil.infradead.org>
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Message-ID-Hash: MDF5LHLLDMZLJETBZJIEWXJVR4LAIZLK
X-Message-ID-Hash: MDF5LHLLDMZLJETBZJIEWXJVR4LAIZLK
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDF5LHLLDMZLJETBZJIEWXJVR4LAIZLK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 19, 2019 at 09:26:19AM -0700, Dan Williams wrote:
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

Yes, I think this works.  Should we also add:

 static unsigned int dax_entry_order(void *entry)
 {
+	BUG_ON(!xa_is_value(entry));
 	if (xa_to_value(entry) & DAX_PMD)
 		return PMD_ORDER;
 	return 0;
 }

which would have caught this logic error before it caused a performance
regression?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
