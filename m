Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A3366FCD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Apr 2021 18:17:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75091100EAB4C;
	Wed, 21 Apr 2021 09:17:22 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9715E100EBBA2
	for <linux-nvdimm@lists.01.org>; Wed, 21 Apr 2021 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VZtC96Y0rpZ/52zKQRX4/P2lTW92hzX2CCMG++WmSmQ=; b=l5o9ShQKethQzm+HeTC3GC8Hlb
	bebQKKhYDn9xfC/9aQ2QcoabqTOygNoJ8pOuTjWO59kTWcX9EhLI/8A2m2RBTvW/wIcFo8tEpH6tj
	opeJ3tYBPw/yDGReuzqf/FpZHo/MyRkf3UaOWV2ZqjeQm8FM91Ar136HMnSI/Eb+efyh46Oi5B+pp
	twZglBMv+kmcX6Lfud0ZDZB0biZsG6PiYvrBHOR1e68fQtRvXn6GKDs7Dw2zPBRj8EqocFdMhFKKA
	a6+3Ox02Yfqj8YptVWFCKtOcun+0OLE7r6yYfiT8G1+k9q8EE1+MzbUOtj3iy0ReIaEGi4y6pro5S
	3BLhoOQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lZFWa-00GkII-JV; Wed, 21 Apr 2021 16:16:29 +0000
Date: Wed, 21 Apr 2021 17:16:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210421161624.GJ3596236@casper.infradead.org>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-2-vgoyal@redhat.com>
 <20210421092440.GM8706@quack2.suse.cz>
 <20210421155631.GC1579961@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421155631.GC1579961@redhat.com>
Message-ID-Hash: WIWSNZC7DTD6WYGJ6NP75L2LSEVXHXCD
X-Message-ID-Hash: WIWSNZC7DTD6WYGJ6NP75L2LSEVXHXCD
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WIWSNZC7DTD6WYGJ6NP75L2LSEVXHXCD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 21, 2021 at 11:56:31AM -0400, Vivek Goyal wrote:
> +/**
> + * enum dax_entry_wake_mode: waitqueue wakeup toggle

s/toggle/behaviour/ ?

> + * @WAKE_NEXT: wake only the first waiter in the waitqueue
> + * @WAKE_ALL: wake all waiters in the waitqueue
> + */
> +enum dax_entry_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};
> +
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>  		void *entry, struct exceptional_entry_key *key)
>  {
> @@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(w
>   * The important information it's conveying is whether the entry at
>   * this index used to be a PMD entry.
>   */
> -static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> +static void dax_wake_entry(struct xa_state *xas, void *entry,
> +			   enum dax_entry_wake_mode mode)

It's an awfully verbose name.  'dax_wake_mode'?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
