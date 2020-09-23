Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0B274F3E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 04:49:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEA8E14F5F7D3;
	Tue, 22 Sep 2020 19:49:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B0DA14F5F7D1
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+tm3L9Qdu9Qa27/TXUn0VZXyFl0wWgXIWdk1uWUmYXo=; b=bro9h2a+1VJMD+WRmif02SxOCd
	V6iYwofbx8Scioi6syigtzG1nhgPfDNbKD+0AWCloYcoCtuGqizghQ+7957ITN7duW0ad3Y5qa8VB
	ihRdtXr+JyqzpvML6OtwnnNFi7N//U0P0vnT9u30mG5Rim8975d7CazXnklVXf3CEerJaHJoGFIz9
	4bAUYyK+H0hxgkSUl+ojUHYKyXOM0gcJpmUlOTvCob9VH08ZAXjhQFntUbdjqyBJJLNWrbVYtRIHC
	OodUmoJ9hZSATDquWRrgE+cTS0iPMrQgoPY77FgQMh9bNrJbF4LdjWkjTbbI5hNKEdsJTwkzAeM1R
	P9U1wjcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKuq4-0000Po-1g; Wed, 23 Sep 2020 02:49:00 +0000
Date: Wed, 23 Sep 2020 03:48:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qian Cai <cai@redhat.com>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200923024859.GM32101@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-6-willy@infradead.org>
 <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
 <20200922170526.GK32101@casper.infradead.org>
 <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
Message-ID-Hash: U6WPPL324DWI64GZGYUIQFBAZGXHTHD4
X-Message-ID-Hash: U6WPPL324DWI64GZGYUIQFBAZGXHTHD4
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Dave Chinner <dchinner@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U6WPPL324DWI64GZGYUIQFBAZGXHTHD4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 22, 2020 at 09:06:03PM -0400, Qian Cai wrote:
> On Tue, 2020-09-22 at 18:05 +0100, Matthew Wilcox wrote:
> > On Tue, Sep 22, 2020 at 12:23:45PM -0400, Qian Cai wrote:
> > > On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > > Size the uptodate array dynamically to support larger pages in the
> > > > page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> > > > but with a 2MB maximum page size, we'd have to allocate more than 4kB
> > > > per page.  Add a few debugging assertions.
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Some syscall fuzzing will trigger this on powerpc:
> > > 
> > > .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> > > 
> > > [ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-
> > > io.c:78 iomap_page_release+0x250/0x270
> > 
> > Well, I'm glad it triggered.  That warning is:
> >         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> >                         PageUptodate(page));
> > so there was definitely a problem of some kind.
> > 
> > truncate_cleanup_page() calls
> > do_invalidatepage() calls
> > iomap_invalidatepage() calls
> > iomap_page_release()
> > 
> > Is this the first warning?  I'm wondering if maybe there was an I/O error
> > earlier which caused PageUptodate to get cleared again.  If it's easy to
> > reproduce, perhaps you could try something like this?
> > 
> > +void dump_iomap_page(struct page *page, const char *reason)
> > +{
> > +       struct iomap_page *iop = to_iomap_page(page);
> > +       unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> > +
> > +       dump_page(page, reason);
> > +       if (iop)
> > +               printk("iop:reads %d writes %d uptodate %*pb\n",
> > +                               atomic_read(&iop->read_bytes_pending),
> > +                               atomic_read(&iop->write_bytes_pending),
> > +                               nr_blocks, iop->uptodate);
> > +       else
> > +               printk("iop:none\n");
> > +}
> > 
> > and then do something like:
> > 
> > 	if (bitmap_full(iop->uptodate, nr_blocks) != PageUptodate(page))
> > 		dump_iomap_page(page, NULL);
> 
> This:
> 
> [ 1683.158254][T164965] page:000000004a6c16cd refcount:2 mapcount:0 mapping:00000000ea017dc5 index:0x2 pfn:0xc365c
> [ 1683.158311][T164965] aops:xfs_address_space_operations ino:417b7e7 dentry name:"trinity-testfile2"
> [ 1683.158354][T164965] flags: 0x7fff8000000015(locked|uptodate|lru)
> [ 1683.158392][T164965] raw: 007fff8000000015 c00c0000019c4b08 c00c0000019a53c8 c000201c8362c1e8
> [ 1683.158430][T164965] raw: 0000000000000002 0000000000000000 00000002ffffffff c000201c54db4000
> [ 1683.158470][T164965] page->mem_cgroup:c000201c54db4000
> [ 1683.158506][T164965] iop:none

Oh, I'm a fool.  This is after the call to detach_page_private() so
page->private is NULL and we don't get the iop dumped.

Nevertheless, this is interesting.  Somehow, the page is marked Uptodate,
but the bitmap is deemed not full.  There are three places where we set
an iomap page Uptodate:

1.      if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
                SetPageUptodate(page);

2.      if (page_has_private(page))
                iomap_iop_set_range_uptodate(page, off, len);
        else
                SetPageUptodate(page);

3.      BUG_ON(page->index);
...
        SetPageUptodate(page);

It can't be #2 because the page has an iop.  It can't be #3 because the
page->index is not 0.  So at some point in the past, the bitmap was full.

I don't think it's possible for inode->i_blksize to change, and you
aren't running with THPs, so it's definitely not possible for thp_size()
to change.  So i_blocks_per_page() isn't going to change.

We seem to have allocated enough memory for ->iop because that's also
based on i_blocks_per_page().

I'm out of ideas.  Maybe I'll wake up with a better idea in the morning.
I've been trying to reproduce this on x86 with a 1kB block size
filesystem, and haven't been able to yet.  Maybe I'll try to setup a
powerpc cross-compilation environment tomorrow.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
