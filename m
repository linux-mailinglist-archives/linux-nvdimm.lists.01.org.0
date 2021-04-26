Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B036B43A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 26 Apr 2021 15:46:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D747100EBB6B;
	Mon, 26 Apr 2021 06:46:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 095DC100EBB68
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N1CS+JREmKmZmsb3/+Y0E8O1tSvBvWwvhYqw5K1frW8=; b=fyFSwHnVtojOmyAIldsnUxbp2c
	fStqfRoBxbicVf6TyYYq5KR7CSJtoZlTTGuM55J44givMzR8eZ6GmAM9wLvG2YRqzc1esFeeuM/5N
	5kzj7tysOOMdsK3iixuRAjwN3UEKRmXeyAf8ljNskHktrDG6f90ueV6ojBicMYS/cR6CwKGV8d2DY
	ELU56FceROBeH1ibYgIa1NJvmGI9rkEEOTOd5onPHysUEFA/3xQKzSPzTIuVhmTeFUYcYGLJJqleY
	hcipJwnP68IeYZLj2WZoRCgao/jEx6d8B8QCOvvqpYtNU2mw90m0fXkoUuVTGsXCocKhCH1tk/ztB
	TnIlW3tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lb1ZI-005fv5-OG; Mon, 26 Apr 2021 13:46:36 +0000
Date: Mon, 26 Apr 2021 14:46:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210426134632.GM235567@casper.infradead.org>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
 <20210423130723.1673919-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423130723.1673919-2-vgoyal@redhat.com>
Message-ID-Hash: AVGUOEH75TYUVHQJJQLDN2FRBBOWF7ID
X-Message-ID-Hash: AVGUOEH75TYUVHQJJQLDN2FRBBOWF7ID
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AVGUOEH75TYUVHQJJQLDN2FRBBOWF7ID/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 23, 2021 at 09:07:21AM -0400, Vivek Goyal wrote:
> +enum dax_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};

Why define them in this order when ...

> @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>  	 * must be in the waitqueue and the following check will see them.
>  	 */
>  	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);

... they're used like this?  This is almost as bad as

enum bool {
	true,
	false,
};
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
