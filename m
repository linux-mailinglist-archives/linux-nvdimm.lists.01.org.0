Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC4275023
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 07:00:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FD381502C6B0;
	Tue, 22 Sep 2020 22:00:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA1F21486BC24
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 22:00:33 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N50B5Y102299;
	Wed, 23 Sep 2020 05:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=y7KcEv0cH2wcXQfqZi8DVT/Kis2ijpSFtePEekaqdn0=;
 b=ovwcldhHfVKucVYCJd2vN1Fbfe6WoW53QXU879Cu1Rgu573PEqJgipAl/U7jJpVFGrQ4
 MEng3+DWWWBWvC7BzRxicAFVBzkV6EWjcc/F/GMfskogXQHOLLdAK/6rOSoah3m1GfEB
 mWrigoUD0c6eVmMJeqWXfIxmJihpPkWKcijjv+aOuBKTC3PmWNmn2KAmzuKmBF/0AzFU
 Mq9Y4P7GyJlKppJ0Yvd92IzepZ0DQN0ZVRRwmUKYirYJx4+/6jxgWFlNXBL8paqf6qo3
 f+DRI5KpvnxyngyBTg91o3TXO4OVDGN8TvzWkTYkrNyvj0lZhgL04TT+kFaRRrrfiR8u HQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 33qcptw4yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Sep 2020 05:00:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N4uOxi070114;
	Wed, 23 Sep 2020 05:00:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 33nuru241f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2020 05:00:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08N503p5025876;
	Wed, 23 Sep 2020 05:00:03 GMT
Received: from localhost (/10.159.235.171)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 22 Sep 2020 22:00:03 -0700
Date: Tue, 22 Sep 2020 22:00:01 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200923050001.GE7949@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-6-willy@infradead.org>
 <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
 <20200922170526.GK32101@casper.infradead.org>
 <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
 <20200923024859.GM32101@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923024859.GM32101@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230038
Message-ID-Hash: 34VJISIZL4U5UKY5CVAXTD6VDSI3ZWWY
X-Message-ID-Hash: 34VJISIZL4U5UKY5CVAXTD6VDSI3ZWWY
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Dave Chinner <dchinner@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/34VJISIZL4U5UKY5CVAXTD6VDSI3ZWWY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 23, 2020 at 03:48:59AM +0100, Matthew Wilcox wrote:
> On Tue, Sep 22, 2020 at 09:06:03PM -0400, Qian Cai wrote:
> > On Tue, 2020-09-22 at 18:05 +0100, Matthew Wilcox wrote:
> > > On Tue, Sep 22, 2020 at 12:23:45PM -0400, Qian Cai wrote:
> > > > On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > > > Size the uptodate array dynamically to support larger pages in the
> > > > > page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> > > > > but with a 2MB maximum page size, we'd have to allocate more than 4kB
> > > > > per page.  Add a few debugging assertions.
> > > > > 
> > > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Some syscall fuzzing will trigger this on powerpc:
> > > > 
> > > > .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> > > > 
> > > > [ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-
> > > > io.c:78 iomap_page_release+0x250/0x270
> > > 
> > > Well, I'm glad it triggered.  That warning is:
> > >         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> > >                         PageUptodate(page));
> > > so there was definitely a problem of some kind.
> > > 
> > > truncate_cleanup_page() calls
> > > do_invalidatepage() calls
> > > iomap_invalidatepage() calls
> > > iomap_page_release()
> > > 
> > > Is this the first warning?  I'm wondering if maybe there was an I/O error
> > > earlier which caused PageUptodate to get cleared again.  If it's easy to
> > > reproduce, perhaps you could try something like this?
> > > 
> > > +void dump_iomap_page(struct page *page, const char *reason)
> > > +{
> > > +       struct iomap_page *iop = to_iomap_page(page);
> > > +       unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> > > +
> > > +       dump_page(page, reason);
> > > +       if (iop)
> > > +               printk("iop:reads %d writes %d uptodate %*pb\n",
> > > +                               atomic_read(&iop->read_bytes_pending),
> > > +                               atomic_read(&iop->write_bytes_pending),
> > > +                               nr_blocks, iop->uptodate);
> > > +       else
> > > +               printk("iop:none\n");
> > > +}
> > > 
> > > and then do something like:
> > > 
> > > 	if (bitmap_full(iop->uptodate, nr_blocks) != PageUptodate(page))
> > > 		dump_iomap_page(page, NULL);
> > 
> > This:
> > 
> > [ 1683.158254][T164965] page:000000004a6c16cd refcount:2 mapcount:0 mapping:00000000ea017dc5 index:0x2 pfn:0xc365c
> > [ 1683.158311][T164965] aops:xfs_address_space_operations ino:417b7e7 dentry name:"trinity-testfile2"
> > [ 1683.158354][T164965] flags: 0x7fff8000000015(locked|uptodate|lru)
> > [ 1683.158392][T164965] raw: 007fff8000000015 c00c0000019c4b08 c00c0000019a53c8 c000201c8362c1e8
> > [ 1683.158430][T164965] raw: 0000000000000002 0000000000000000 00000002ffffffff c000201c54db4000
> > [ 1683.158470][T164965] page->mem_cgroup:c000201c54db4000
> > [ 1683.158506][T164965] iop:none
> 
> Oh, I'm a fool.  This is after the call to detach_page_private() so
> page->private is NULL and we don't get the iop dumped.
> 
> Nevertheless, this is interesting.  Somehow, the page is marked Uptodate,
> but the bitmap is deemed not full.  There are three places where we set
> an iomap page Uptodate:
> 
> 1.      if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
>                 SetPageUptodate(page);
> 
> 2.      if (page_has_private(page))
>                 iomap_iop_set_range_uptodate(page, off, len);
>         else
>                 SetPageUptodate(page);
> 
> 3.      BUG_ON(page->index);
> ...
>         SetPageUptodate(page);
> 
> It can't be #2 because the page has an iop.  It can't be #3 because the
> page->index is not 0.  So at some point in the past, the bitmap was full.
> 
> I don't think it's possible for inode->i_blksize to change, and you
> aren't running with THPs, so it's definitely not possible for thp_size()
> to change.  So i_blocks_per_page() isn't going to change.
> 
> We seem to have allocated enough memory for ->iop because that's also
> based on i_blocks_per_page().
> 
> I'm out of ideas.  Maybe I'll wake up with a better idea in the morning.
> I've been trying to reproduce this on x86 with a 1kB block size
> filesystem, and haven't been able to yet.  Maybe I'll try to setup a
> powerpc cross-compilation environment tomorrow.

FWIW I managed to reproduce it with the following fstests configuration
on a 1k block size fs on a x86 machinE:

SECTION      -- -no-sections-
FSTYP        -- xfs
MKFS_OPTIONS --  -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024
MOUNT_OPTIONS --  -o usrquota,grpquota,prjquota
HOST_OPTIONS -- local.config
CHECK_OPTIONS -- -g auto
XFS_MKFS_OPTIONS -- -bsize=4096
TIME_FACTOR  -- 1
LOAD_FACTOR  -- 1
TEST_DIR     -- /mnt
TEST_DEV     -- /dev/sde
SCRATCH_DEV  -- /dev/sdd
SCRATCH_MNT  -- /opt
OVL_UPPER    -- ovl-upper
OVL_LOWER    -- ovl-lower
OVL_WORK     -- ovl-work
KERNEL       -- 5.9.0-rc4-djw

The kernel is more or less iomap-for-next.

--D
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
