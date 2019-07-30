Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EB7B568
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Jul 2019 00:01:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8FFF0212E4B7F;
	Tue, 30 Jul 2019 15:03:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=msnitzer@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F09AA212E13A9
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 15:03:37 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E44D4E8AC;
 Tue, 30 Jul 2019 22:01:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 667E719724;
 Tue, 30 Jul 2019 22:01:03 +0000 (UTC)
Date: Tue, 30 Jul 2019 18:01:02 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: dm: fix dax_dev NULL dereference
Message-ID: <20190730220102.GA15604@redhat.com>
References: <20190730113708.14660-1-pagupta@redhat.com>
 <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com>
 <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 30 Jul 2019 22:01:06 +0000 (UTC)
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 30 2019 at  5:38pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > I staged the fix (which I tweaked) here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e
> 
> Thanks for picking this up Mike, but I'd prefer to just teach
> dax_synchronous() to return false if the passed in dax_dev is NULL.
> Thoughts?

I considered that too but I moved away from it because I'm so used to
the various block interfaces requiring the caller pass a non-NULL
pointer (e.g. request_queue):

$ grep -ri return drivers/md/dm-table.c | grep \&\&
drivers/md/dm-table.c:        return dev->dax_dev && dax_synchronous(dev->dax_dev);
drivers/md/dm-table.c:        return q && blk_queue_zoned_model(q) == *zoned_model;
drivers/md/dm-table.c:        return q && blk_queue_zone_sectors(q) == *zone_sectors;
drivers/md/dm-table.c:        return q && (q->queue_flags & flush);
drivers/md/dm-table.c:        return q && blk_queue_nonrot(q);
drivers/md/dm-table.c:        return q && !blk_queue_add_random(q);
drivers/md/dm-table.c:        return q && !q->limits.max_write_same_sectors;
drivers/md/dm-table.c:        return q && !q->limits.max_write_zeroes_sectors;
drivers/md/dm-table.c:        return q && !blk_queue_discard(q);
drivers/md/dm-table.c:        return q && !blk_queue_secure_erase(q);
drivers/md/dm-table.c:        return q && bdi_cap_stable_pages_required(q->backing_dev_info);

I'm fine with however you'd like to skin this cat though.

Just let me know and I'll keep/drop this patch accordingly.

Thanks,
Mike
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
