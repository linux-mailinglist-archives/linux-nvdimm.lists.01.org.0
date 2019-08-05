Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFEF8250A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 20:50:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC28A213030B3;
	Mon,  5 Aug 2019 11:52:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 685BD213030A1
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 11:52:29 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED067300CB70;
 Mon,  5 Aug 2019 18:49:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0D1E5EE1D;
 Mon,  5 Aug 2019 18:49:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5FE9022377E; Mon,  5 Aug 2019 14:49:51 -0400 (EDT)
Date: Mon, 5 Aug 2019 14:49:51 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
Message-ID: <20190805184951.GC13994@redhat.com>
References: <20190802192956.GA3032@redhat.com>
 <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
 <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 05 Aug 2019 18:49:58 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, virtio-fs@redhat.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 05, 2019 at 02:53:06PM +0300, Boaz Harrosh wrote:
> On 02/08/2019 22:37, Dan Williams wrote:
> > On Fri, Aug 2, 2019 at 12:30 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >>
> >> As of now dax_layout_busy_page() calls unmap_mapping_range() with last
> >> argument as 1, which says even unmap cow pages. I am wondering who needs
> >> to get rid of cow pages as well.
> >>
> >> I noticed one interesting side affect of this. I mount xfs with -o dax and
> >> mmaped a file with MAP_PRIVATE and wrote some data to a page which created
> >> cow page. Then I called fallocate() on that file to zero a page of file.
> >> fallocate() called dax_layout_busy_page() which unmapped cow pages as well
> >> and then I tried to read back the data I wrote and what I get is old
> >> data from persistent memory. I lost the data I had written. This
> >> read basically resulted in new fault and read back the data from
> >> persistent memory.
> >>
> >> This sounds wrong. Are there any users which need to unmap cow pages
> >> as well? If not, I am proposing changing it to not unmap cow pages.
> >>
> >> I noticed this while while writing virtio_fs code where when I tried
> >> to reclaim a memory range and that corrupted the executable and I
> >> was running from virtio-fs and program got segment violation.
> >>
> >> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> >> ---
> >>  fs/dax.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Index: rhvgoyal-linux/fs/dax.c
> >> ===================================================================
> >> --- rhvgoyal-linux.orig/fs/dax.c        2019-08-01 17:03:10.574675652 -0400
> >> +++ rhvgoyal-linux/fs/dax.c     2019-08-02 14:32:28.809639116 -0400
> >> @@ -600,7 +600,7 @@ struct page *dax_layout_busy_page(struct
> >>          * guaranteed to either see new references or prevent new
> >>          * references from being established.
> >>          */
> >> -       unmap_mapping_range(mapping, 0, 0, 1);
> >> +       unmap_mapping_range(mapping, 0, 0, 0);
> > 
> > Good find, yes, this looks correct to me and should also go to -stable.
> > 
> 
> Please pay attention that unmap_mapping_range(mapping, ..., 1) is for the truncate case and friends
> 
> So as I understand the man page:
> fallocate(FL_PUNCH_HOLE); means user is asking to get rid also of COW pages.
> On the other way fallocate(FL_ZERO_RANGE) only the pmem portion is zeroed and COW (private pages) stays

I tested fallocate(FL_PUNCH_HOLE) on xfs (non-dax) and it does not seem to
get rid of COW pages and my test case still can read the data it wrote
in private pages.

> 
> Just saying I have not followed the above code path
> (We should have an xfstest for this?)

I don't know either. It indeed is interesting to figure out what's the
expected behavior with fallocate() and truncate() for COW pages and cover
that using xfstest (if not already done).

Irrespective of that, for dax, it seems particularly bad because
we call unmap_mapping_range() for the whole file. So even if we are
punching hole on a single page and expected cow page to go away associated
with that page, currently it will get rid of all COW pages in whole
file.

So to me it makes sense to not get rid of COW pages and possibly
introduce option of performing dax_layout_busy_page() on a range
of pages (as opposed to whole file) and caller can specify whether
to zap cow pages or not in the specified range.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
