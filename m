Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF5104D16
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Nov 2019 09:00:46 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88D64100DC2BF;
	Thu, 21 Nov 2019 00:01:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=pagupta@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7E9A9100DC2BC
	for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 00:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1574323233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTQFAcYNqFBxu18ZqL1l7wDUq1TFcKVDobQ6ovOgA/g=;
	b=aoIaUXglZCMDMs/YcLbGuZgBcb1p0spJiDDpRKugF+dJR/mvPC+RYGnLS5Xz/YhHWoPtFT
	qVt6+EDxqpl55sxEPOy4yEdFipQJOCP9KrykS2kL10vUUawumVLR++mk7Hf1iO0J5onyo1
	3p/3tn7V4tiWRZILWoQgPH8G4s44Hyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-HvnOAqsgPY2_30n_0UNCFA-1; Thu, 21 Nov 2019 03:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EADBD107ACC9;
	Thu, 21 Nov 2019 08:00:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CE9EC5D6D2;
	Thu, 21 Nov 2019 08:00:27 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id A18E218089C8;
	Thu, 21 Nov 2019 08:00:27 +0000 (UTC)
Date: Thu, 21 Nov 2019 03:00:27 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com> <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com> <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
MIME-Version: 1.0
X-Originating-IP: [10.67.116.169, 10.4.195.1]
Thread-Topic: virtio pmem: fix async flush ordering
Thread-Index: 7Sg2VvKEGXDulgOI6hZ7i2wjSlDdeQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HvnOAqsgPY2_30n_0UNCFA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: KQK263RY7QCKLOHRVSVZK7UUF7EFCFKG
X-Message-ID-Hash: KQK263RY7QCKLOHRVSVZK7UUF7EFCFKG
X-MailFrom: pagupta@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KQK263RY7QCKLOHRVSVZK7UUF7EFCFKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> > >
> > > >  Remove logic to create child bio in the async flush function which
> > > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > > >  data write request.
> > > >
> > > >  Instead we are performing flush from the parent bio to maintain the
> > > >  correct order. Also, returning from function 'pmem_make_request' if
> > > >  REQ_PREFLUSH returns an error.
> > > >
> > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > >
> > > There's a slight change in behavior for the error path in the
> > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > actually an improvement.
> > >
> > > I'll also note that the current behavior can result in data corruption,
> > > so this should be tagged for stable.
> >
> > I added that and was about to push this out, but what about the fact
> > that now the guest will synchronously wait for flushing to occur. The
> > goal of the child bio was to allow that to be an I/O wait with
> > overlapping I/O, or at least not blocking the submission thread. Does
> > the block layer synchronously wait for PREFLUSH requests? If not I
> > think a synchronous wait is going to be a significant performance
> > regression. Are there any numbers to accompany this change?
> 
> Why not just swap the parent child relationship in the PREFLUSH case?

I we are already inside parent bio "make_request" function and we create child
bio. How we exactly will swap the parent/child relationship for PREFLUSH case?

Child bio is queued after parent bio completes.

Thanks,
Pankaj  

> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
