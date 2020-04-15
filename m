Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26B1A9AFF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 12:42:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05ABB10106308;
	Wed, 15 Apr 2020 03:42:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 133B710106306
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 03:42:56 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 50499AE72;
	Wed, 15 Apr 2020 10:42:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id D21A61E1250; Wed, 15 Apr 2020 12:42:23 +0200 (CEST)
Date: Wed, 15 Apr 2020 12:42:23 +0200
From: Jan Kara <jack@suse.cz>
To: Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH v2] dax: Add missing annotation for wait_entry_unlocked()
Message-ID: <20200415104223.GB6126@quack2.suse.cz>
References: <20200401153400.23610-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200401153400.23610-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: ZMDJVDZEYNXRZK5LZKLKUDPQ3ZG3S3VR
X-Message-ID-Hash: ZMDJVDZEYNXRZK5LZKLKUDPQ3ZG3S3VR
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "open list:FILESYSTEM DIRECT ACCESS (DAX)" <linux-fsdevel@vger.kernel.org>, "open list:FILESYSTEM DIRECT ACCESS (DAX)" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZMDJVDZEYNXRZK5LZKLKUDPQ3ZG3S3VR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 01-04-20 16:33:59, Jules Irenge wrote:
> Sparse reports a warning at wait_entry_unlocked()
> 
> warning: context imbalance in wait_entry_unlocked() - unexpected unlock
> 
> The root cause is the missing annotation at wait_entry_unlocked()
> Add the missing __releases(xas->xa->xa_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 35da144375a0..ee0468af4d81 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>   * After we call xas_unlock_irq(), we cannot touch xas->xa.
>   */
>  static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> +	__releases(xas->xa->xa_lock)
>  {
>  	struct wait_exceptional_entry_queue ewait;
>  	wait_queue_head_t *wq;
> -- 
> Change since v2
> - gives more accurate lock variable name
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
