Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 584011C1CF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 07:27:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 641A2212746E5;
	Mon, 13 May 2019 22:27:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 60C8321CB74A4
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 22:27:22 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09F663092670;
 Tue, 14 May 2019 05:27:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3478600C6;
 Tue, 14 May 2019 05:27:19 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9997218089C8;
 Tue, 14 May 2019 05:27:18 +0000 (UTC)
Date: Tue, 14 May 2019 01:27:17 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <676644679.28490825.1557811637861.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
 <20190510155202.14737-4-pagupta@redhat.com>
 <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
 <864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
 <CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
 <2003480558.28042237.1557537797923.JavaMail.zimbra@redhat.com>
 <116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
 <CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
MIME-Version: 1.0
X-Originating-IP: [10.65.16.148, 10.4.195.17]
Thread-Topic: libnvdimm: add dax_dev sync flag
Thread-Index: wQqDJDTh4d6BDzUQZjrFKazK6E2QhQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 14 May 2019 05:27:21 +0000 (UTC)
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
 Andrea Arcangeli <aarcange@redhat.com>, jstaron@google.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Adam Borowski <kilobyte@angband.pl>, Rik van Riel <riel@surriel.com>,
 yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 cohuck@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> >
> >
> > Hi Dan,
> >
> > While testing device mapper with DAX, I faced a bug with the commit:
> >
> > commit ad428cdb525a97d15c0349fdc80f3d58befb50df
> > Author: Dan Williams <dan.j.williams@intel.com>
> > Date:   Wed Feb 20 21:12:50 2019 -0800
> >
> > When I reverted the condition to old code[1] it worked for me. I
> > am thinking when we map two different devices (e.g with device mapper),
> > will
> > start & end pfn still point to same pgmap? Or there is something else which
> > I am missing here.
> >
> > Note: I tested only EXT4.
> >
> > [1]
> >
> > -               if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
> > +               end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> > +               if (pgmap && pgmap == end_pgmap && pgmap->type ==
> > MEMORY_DEVICE_FS_DAX
> > +                               && pfn_t_to_page(pfn)->pgmap == pgmap
> > +                               && pfn_t_to_page(end_pfn)->pgmap == pgmap
> > +                               && pfn_t_to_pfn(pfn) ==
> > PHYS_PFN(__pa(kaddr))
> > +                               && pfn_t_to_pfn(end_pfn) ==
> > PHYS_PFN(__pa(end_kaddr)))
> 
> Ugh, yes, device-mapper continues to be an awkward fit for dax (or
> vice versa). We would either need a way to have a multi-level pfn to
> pagemap lookup for composite devices, or a way to discern that even
> though the pagemap is different that the result is still valid / not
> an indication that we have leaked into an unassociated address range.
> Perhaps a per-daxdev callback for ->dax_supported() so that
> device-mapper internals can be used for this validation.

Yes, Will look at it.

> 
> We need to get that fixed up, but I don't see it as a blocker /
> pre-requisite for virtio-pmem.

Agree. Will send virtio-pmem patch series.

Thank you,
Pankaj
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
