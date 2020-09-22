Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71161274765
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Sep 2020 19:25:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CEB414DF65C2;
	Tue, 22 Sep 2020 10:25:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=cai@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8855C14DF65C2
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600795551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZmFKoK2MR7ChNH+SzztUzepcIAB3ilvtz5u7xppUU8=;
	b=Sp3jWxDg6Vl2hLmdR95gTDlEFTdZNaWmkm+6JuYX/OCpyI3DenTMbNZpVHwknoPGd+MNCu
	o918R7igDv+cdl/i5x7jarPpj6d3wexaZOxV1uh0leBCt+CW1wBTLXFHLh5UPhtcjjRSgI
	vISv9zC5c0elfGHXSp21mRrdjXqoq2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-mvCMT2fhNdqivAS76rFhIg-1; Tue, 22 Sep 2020 13:25:46 -0400
X-MC-Unique: mvCMT2fhNdqivAS76rFhIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC1D80EF8B;
	Tue, 22 Sep 2020 17:25:44 +0000 (UTC)
Received: from ovpn-66-35.rdu2.redhat.com (unknown [10.10.67.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 606C310013D7;
	Tue, 22 Sep 2020 17:25:43 +0000 (UTC)
Message-ID: <c804f9ec9e15daa4e82483c546558599c662f53c.camel@redhat.com>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
From: Qian Cai <cai@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Date: Tue, 22 Sep 2020 13:25:42 -0400
In-Reply-To: <20200922170526.GK32101@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
	 <20200910234707.5504-6-willy@infradead.org>
	 <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
	 <20200922170526.GK32101@casper.infradead.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 2SPZ5HLL266OKGBKDWUNKFLSYT4ZYY4J
X-Message-ID-Hash: 2SPZ5HLL266OKGBKDWUNKFLSYT4ZYY4J
X-MailFrom: cai@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Darrick J ."@ml01.01.org, Wong@ml01.01.org,
	" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, "@ml01.01.org,
	linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Dave Chinner <dchinner@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2SPZ5HLL266OKGBKDWUNKFLSYT4ZYY4J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-09-22 at 18:05 +0100, Matthew Wilcox wrote:
> On Tue, Sep 22, 2020 at 12:23:45PM -0400, Qian Cai wrote:
> > On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > Size the uptodate array dynamically to support larger pages in the
> > > page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> > > but with a 2MB maximum page size, we'd have to allocate more than 4kB
> > > per page.  Add a few debugging assertions.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > Some syscall fuzzing will trigger this on powerpc:
> > 
> > .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> > 
> > [ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-
> > io.c:78 iomap_page_release+0x250/0x270
> 
> Well, I'm glad it triggered.  That warning is:
>         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>                         PageUptodate(page));
> so there was definitely a problem of some kind.
> 
> truncate_cleanup_page() calls
> do_invalidatepage() calls
> iomap_invalidatepage() calls
> iomap_page_release()
> 
> Is this the first warning?  I'm wondering if maybe there was an I/O error
> earlier which caused PageUptodate to get cleared again.  If it's easy to
> reproduce, perhaps you could try something like this?

Yes, this is the first warning. BTW, I did run the reproducer of a805c111650c
("iomap: fix WARN_ON_ONCE() from unprivileged users") earlier, so I am wondering
if this is just another victim WARN_ON_ONCE() from it.

> 
> +void dump_iomap_page(struct page *page, const char *reason)
> +{
> +       struct iomap_page *iop = to_iomap_page(page);
> +       unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> +
> +       dump_page(page, reason);
> +       if (iop)
> +               printk("iop:reads %d writes %d uptodate %*pb\n",
> +                               atomic_read(&iop->read_bytes_pending),
> +                               atomic_read(&iop->write_bytes_pending),
> +                               nr_blocks, iop->uptodate);
> +       else
> +               printk("iop:none\n");
> +}
> 
> and then do something like:
> 
> 	if (bitmap_full(iop->uptodate, nr_blocks) != PageUptodate(page))
> 		dump_iomap_page(page, NULL);
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
