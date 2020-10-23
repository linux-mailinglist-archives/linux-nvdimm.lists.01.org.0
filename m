Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9C82969E0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 08:46:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E15A0162D4A76;
	Thu, 22 Oct 2020 23:46:36 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+ae109258c1d10f479368+6270+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25A3616271500
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Zl0rvw/qJiKPxvEy3tqCZ3HJK8WyPTbT7XwamJFSaI=; b=rr6gPWvoN9S4AOg+TyKLYaGM3d
	LMw71ZZ60yc2agUfvIQOxbtcESBDo56obTsheeYUCAdW/g4FNZelg8wfaTVeyGxNJX58CVawinboC
	jdBhcD12BCUyA41Etq0vQ8oulE4vU1tL9L0vPykeNMTUWWi7v4qrwPURxGF1iCWww0+UIP214JQXo
	UKqM9T2y7G5Pr40dulT/ZzzVzuNLqjl8+8aoczuStfw8wK2OMVHJZqHxCPbqgWgUBboIoqmJfJxA7
	ToATrTdrYw6O0IOwZHxycZOo+QlptP+rRNzySE3H8bQgoyJg5ewJBXoZgdBwXDlG1YNZXKrqpZEom
	mUtdZMuw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVqq2-0005yw-W4; Fri, 23 Oct 2020 06:46:11 +0000
Date: Fri, 23 Oct 2020 07:46:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
Message-ID: <20201023064610.GA22405@infradead.org>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
 <20201022154124.GA537138@iweiny-DESK2.sc.intel.com>
 <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: U3XIPWEIWEUTOLR6LPSXY5JZ6O3F2RVB
X-Message-ID-Hash: U3XIPWEIWEUTOLR6LPSXY5JZ6O3F2RVB
X-MailFrom: BATV+ae109258c1d10f479368+6270+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U3XIPWEIWEUTOLR6LPSXY5JZ6O3F2RVB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 22, 2020 at 11:19:43AM -0700, Ralph Campbell wrote:
> 
> On 10/22/20 8:41 AM, Ira Weiny wrote:
> > On Thu, Oct 22, 2020 at 11:37:53AM +0530, Aneesh Kumar K.V wrote:
> > > commit 6f42193fd86e ("memremap: don't use a separate devm action for
> > > devmap_managed_enable_get") changed the static key updates such that we
> > > now call devmap_managed_enable_put() without doing the equivalent
> > > devmap_managed_enable_get().
> > > 
> > > devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
> > > MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
> > > types too. This results in the below warning when switching between
> > > system-ram and devdax mode for devdax namespace.
> > > 
> > >   jump label: negative count!
> > >   WARNING: CPU: 52 PID: 1335 at kernel/jump_label.c:235 static_key_slow_try_dec+0x88/0xa0
> > >   Modules linked in:
> > >   ....
> > > 
> > >   NIP [c000000000433318] static_key_slow_try_dec+0x88/0xa0
> > >   LR [c000000000433314] static_key_slow_try_dec+0x84/0xa0
> > >   Call Trace:
> > >   [c000000025c1f660] [c000000000433314] static_key_slow_try_dec+0x84/0xa0 (unreliable)
> > >   [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
> > >   [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
> > >   [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
> > >   [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
> > >   [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
> > >   [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
> > >   [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
> > >   [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
> > >   [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
> > >   [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
> > >   [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
> > >   [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
> > >   [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
> > >   [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
> > >   [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
> > >   [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
> > >   [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
> > >   [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
> > >   [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
> > >   [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c
> > > 
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > > Cc: linux-nvdimm@lists.01.org
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   mm/memremap.c | 19 +++++++++++++++----
> > >   1 file changed, 15 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memremap.c b/mm/memremap.c
> > > index 73a206d0f645..d4402ff3e467 100644
> > > --- a/mm/memremap.c
> > > +++ b/mm/memremap.c
> > > @@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
> > >   {
> > >   	unsigned long pfn;
> > >   	int i;
> > > +	bool need_devmap_managed = false;
> > > +
> > > +	switch (pgmap->type) {
> > > +	case MEMORY_DEVICE_PRIVATE:
> > > +	case MEMORY_DEVICE_FS_DAX:
> > > +		need_devmap_managed = true;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > 
> > Is it overkill to avoid duplicating this switch logic in
> > page_is_devmap_managed() by creating another call which can be used here?
> 
> Perhaps. I can imagine a helper defined in include/linux/mm.h which
> page_is_devmap_managed() could also call but that would impact a lot of
> places that include mm.h. Since memremap.c already has to have intimate
> knowledge of the pgmap->type, I think limiting the change to just what
> is needed is better for now. So the patch looks OK to me.
> 
> Looking at this some more, I would suggest changing devmap_managed_enable_get()
> and devmap_managed_enable_put() to do the special case checking instead of
> doing it in memremap_pages() and memunmap_pages().
> Then devmap_managed_enable_get() doesn't need to return an error if
> CONFIG_DEV_PAGEMAP_OPS isn't defined. I have only compile tested the
> following.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

This looks ok as well.  Can you submit it as a proper standalone patch?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
