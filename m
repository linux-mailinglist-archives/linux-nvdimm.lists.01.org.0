Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3E17083
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 07:49:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 941CB2125585D;
	Tue,  7 May 2019 22:49:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A07ED21255855
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 22:49:06 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2318C05D3FD;
 Wed,  8 May 2019 05:49:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94A901001E60;
 Wed,  8 May 2019 05:49:05 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5054918089C8;
 Wed,  8 May 2019 05:49:05 +0000 (UTC)
Date: Wed, 8 May 2019 01:49:04 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <7976014.27184867.1557294544901.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190507161736.GV5207@magnolia>
References: <20190426050039.17460-1-pagupta@redhat.com>
 <20190426050039.17460-7-pagupta@redhat.com>
 <CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
 <20190507161736.GV5207@magnolia>
Subject: Re: [Qemu-devel] [PATCH v7 6/6] xfs: disable map_sync for async flush
MIME-Version: 1.0
X-Originating-IP: [10.65.16.19, 10.4.195.7]
Thread-Topic: disable map_sync for async flush
Thread-Index: JBzJaF62TCLP+9MfvU9kbFR+Dq73zQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 08 May 2019 05:49:06 +0000 (UTC)
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
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 kilobyte@angband.pl, Rik van Riel <riel@surriel.com>,
 yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 cohuck@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> On Tue, May 07, 2019 at 08:37:01AM -0700, Dan Williams wrote:
> > On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > >
> > > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > > with asynchronous dax_device. Virtio pmem provides
> > > asynchronous host page cache flush mechanism. We don't
> > > support 'MAP_SYNC' with virtio pmem and xfs.
> > >
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > Darrick, does this look ok to take through the nvdimm tree?
> 
> <urk> forgot about this, sorry. :/
> 
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index a7ceae90110e..f17652cca5ff 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1203,11 +1203,14 @@ xfs_file_mmap(
> > >         struct file     *filp,
> > >         struct vm_area_struct *vma)
> > >  {
> > > +       struct dax_device       *dax_dev;
> > > +
> > > +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
> > >         /*
> > > -        * We don't support synchronous mappings for non-DAX files. At
> > > least
> > > -        * until someone comes with a sensible use case.
> > > +        * We don't support synchronous mappings for non-DAX files and
> > > +        * for DAX files if underneath dax_device is not synchronous.
> > >          */
> > > -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > > +       if (!daxdev_mapping_supported(vma, dax_dev))
> > >                 return -EOPNOTSUPP;
> 
> LGTM, and I'm fine with it going through nvdimm.  Nothing in
> xfs-5.2-merge touches that function so it should be clean.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thank you for the review.

Pankaj

> 
> --D
> 
> > >
> > >         file_accessed(filp);
> > > --
> > > 2.20.1
> > >
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
