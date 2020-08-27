Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EFF2540C1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 10:26:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AD951257E83D;
	Thu, 27 Aug 2020 01:26:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 88D96125203D9
	for <linux-nvdimm@lists.01.org>; Thu, 27 Aug 2020 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S6YVOoqzwTlckg/PNbF867wxnwUJFXoSme6f6Yt+mow=; b=Ow/iU5CfLqY1ciE8rv01JdZ/mE
	AjAOqYOAmWLUqBopr/QulUYZJh3jS39U4nTR8Vt6Xa81V1HBII8Kvd02XA9HLuFgPpfn/keVhYytK
	kVq7hIGC+vYqgfNeqAi3DYZETLqtCfaZoJhxTiM7Yk6r7VeBTwKQKc+mw+B2eEzuz+B94XDjLzJdL
	vX3pvwTmI/n2moHRdQzBjVdkIGJiHZlwXDspqjwFRMyYPJYvjEOrSLRW5Agi5Lgtyf093OQ6Ir6Zg
	5RE4nce6CHzX6Ykc7dcVE3zZ+axlfae2zVgIxna1mRtnNHV4GK1+6ZVRWi+R7grvNDwqEvdU614IO
	00zfb0Eg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBDEy-0003Bb-Sc; Thu, 27 Aug 2020 08:26:36 +0000
Date: Thu, 27 Aug 2020 09:26:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200827082636.GB11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: YXR76AV42Q7M2REVDZY7VAX27V7KZQPB
X-Message-ID-Hash: YXR76AV42Q7M2REVDZY7VAX27V7KZQPB
X-MailFrom: BATV+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YXR76AV42Q7M2REVDZY7VAX27V7KZQPB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>  static inline struct iomap_page *to_iomap_page(struct page *page)
>  {
> +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
>  	if (page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;

Nit: can you add an empty line after the VM_BUG_ON_PGFLAGS assert to
keep the function readable?  Maybe also add a comment on the assert,
as it isn't totally obvious.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
