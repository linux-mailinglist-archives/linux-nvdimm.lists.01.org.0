Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4280106048
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 06:37:11 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72C4E100DC2D4;
	Thu, 21 Nov 2019 21:37:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=pagupta@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD3BC100DC2D3
	for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 21:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1574401027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKkONTtWVn2eOzE/ZmOcrElOUkXfPmqcjl279Q5P6lw=;
	b=LaaInJqZ2i24ID8pX0KgMeK4DIr8FdwaniHZjHE/t5B+inLLsvdjZ5zTrc7/vfm8CCpspV
	k1inNaBbZ4R3DNu8wZ6dbW9WFOuQPZi2TJOcUpaTDiimTNptTSck3F2ySebKs4oqjHV3Rw
	elvKAlOVR0opkLtyTnOrlR6fxFhueDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-T_UOHI-YNQGQjE4f7guipw-1; Fri, 22 Nov 2019 00:37:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D69E11800D41;
	Fri, 22 Nov 2019 05:37:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B6730100EA05;
	Fri, 22 Nov 2019 05:37:00 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 895A218095FF;
	Fri, 22 Nov 2019 05:37:00 +0000 (UTC)
Date: Fri, 22 Nov 2019 00:37:00 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <838611538.35971353.1574401020319.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gsQXY5C5URF2vrTaD-0Q_CJ+ib3GVb1VFZAO+1Gdau2w@mail.gmail.com>
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com> <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com> <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com> <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com> <560894997.35969622.1574397521533.JavaMail.zimbra@redhat.com> <CAPcyv4gsQXY5C5URF2vrTaD-0Q_CJ+ib3GVb1VFZAO+1Gdau2w@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
MIME-Version: 1.0
X-Originating-IP: [10.67.116.214, 10.4.195.30]
Thread-Topic: virtio pmem: fix async flush ordering
Thread-Index: yct1AVHQcm+1LDSyVVEj51GYlhrF5A==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: T_UOHI-YNQGQjE4f7guipw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: CLYO7P5M4NIZGUV6YFFP4YUYZHVIMDTF
X-Message-ID-Hash: CLYO7P5M4NIZGUV6YFFP4YUYZHVIMDTF
X-MailFrom: pagupta@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CLYO7P5M4NIZGUV6YFFP4YUYZHVIMDTF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> > > > > >
> > > > > > I added that and was about to push this out, but what about the
> > > > > > fact
> > > > > > that now the guest will synchronously wait for flushing to occur.
> > > > > > The
> > > > > > goal of the child bio was to allow that to be an I/O wait with
> > > > > > overlapping I/O, or at least not blocking the submission thread.
> > > > > > Does
> > > > > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > > > > think a synchronous wait is going to be a significant performance
> > > > > > regression. Are there any numbers to accompany this change?
> > > > >
> > > > > Why not just swap the parent child relationship in the PREFLUSH case?
> > > >
> > > > I we are already inside parent bio "make_request" function and we
> > > > create
> > > > child
> > > > bio. How we exactly will swap the parent/child relationship for
> > > > PREFLUSH
> > > > case?
> > > >
> > > > Child bio is queued after parent bio completes.
> > >
> > > Sorry, I didn't quite mean with bio_split, but issuing another request
> > > in front of the real bio. See md_flush_request() for inspiration.
> >
> > o.k. Thank you. Will try to post patch today to be considered for 5.4.
> >
> 
> I think it is too late for v5.4-final, but we can get it in the
> -stable queue. Let's take the time to do it right and get some testing
> on it.

Sure.

Just sharing probable patch for early feedback, if I am doing it correctly?
I will test it thoroughly.

Thanks,
Pankaj

========

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fa..c683e0e2515c 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -112,6 +112,12 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
                bio_copy_dev(child, bio);
                child->bi_opf = REQ_PREFLUSH;
                child->bi_iter.bi_sector = -1;
+
+               if (unlikely(bio->bi_opf & REQ_PREFLUSH)) {
+                       struct request_queue *q = bio->bi_disk->queue;
+                       q->make_request_fn(q, child);
+                       return 0;
+               }
                bio_chain(child, bio);
                submit_bio(child);
                return 0;

 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
