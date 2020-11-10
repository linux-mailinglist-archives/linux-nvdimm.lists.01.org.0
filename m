Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF32ADE91
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 19:42:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8CA31664021B;
	Tue, 10 Nov 2020 10:42:20 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EE0B16640219
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 10:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RlvumwFFqtHHTtqgXiiCCmpECmDemzXqXgYQ9Vk4WBw=; b=RkBCGrtqgxR5MwtIwJ7MABW3TI
	AjONZMSKrcdRtT06jWDpO73w2mbRWkvVywabhoWVQPGuGsvEnkjKlsofAnDFVnJ+R69qpKA6Gwnh5
	vvR0L+DVDIJcPnYNSW3FIa42EcQ5ty8XXXARL2tHT55wqjQNMNkrASal1SB7mK9X/EKk2m18Y6XL4
	p45LENjHF8RSDd+71xAPqsSRCownFFpae4+kYuIZO3GD8J9FDMU+BMwjH2754N6Y3KgF82rjRIYQz
	TEpmLiKGZeK6GJ451hAWDBiszx5b5TzJuenpoGwOZh7OyEVjWZzErjzKsE5e/zdgJjEDIBQ4qj7vn
	JEYKKn4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcYat-00031m-Be; Tue, 10 Nov 2020 18:42:15 +0000
Date: Tue, 10 Nov 2020 18:42:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm: simplify follow_pte{,pmd}
Message-ID: <20201110184215.GM17076@casper.infradead.org>
References: <20201029101432.47011-1-hch@lst.de>
 <20201029101432.47011-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-3-hch@lst.de>
Message-ID-Hash: BPUTBKBH7H4AH7O6RNA4PKXGS7AXKYKH
X-Message-ID-Hash: BPUTBKBH7H4AH7O6RNA4PKXGS7AXKYKH
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BPUTBKBH7H4AH7O6RNA4PKXGS7AXKYKH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2020 at 11:14:32AM +0100, Christoph Hellwig wrote:
> Merge __follow_pte_pmd, follow_pte_pmd and follow_pte into a single
> follow_pte function and just pass two additional NULL arguments for
> the two previous follow_pte callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I'm not entirely convinced this is the right interface, but your patch
makes things better, so I approve.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
