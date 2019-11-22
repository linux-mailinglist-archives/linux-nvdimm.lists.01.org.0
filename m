Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E01075BC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 17:25:27 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AAAC2100DC407;
	Fri, 22 Nov 2019 08:25:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC57F100DC406
	for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1574439921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHdyHfkNKosHl51NLrMjsjBT0ZayHryhZQGO5Md7wqE=;
	b=fkgsDrpJ7qdIE/ZntwpIM9t+ZRHI9I5rZef9UUq/cc683neCdFAK8wWNTagVaOZypEDPJj
	F+K+n9KUBq5NYuzGaOwTp4CB7XaPiP4Wwhxu7MRK5Lrnr7mbChG+Wwwa5B+JEmHUw5zgXm
	0Omj5nQeZygrjnBujNrvFfvvSS1obTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-FxwrXjrrPBO6LPh4PmY5hA-1; Fri, 22 Nov 2019 11:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B7B184CAA8;
	Fri, 22 Nov 2019 16:25:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 659181CB;
	Fri, 22 Nov 2019 16:25:13 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
References: <20191120092831.6198-1-pagupta@redhat.com>
	<x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
	<x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 22 Nov 2019 11:25:11 -0500
In-Reply-To: <CAPcyv4idC=LgkwP+A1GKJ1CWkzUZ_RVBDCVfA3yAL9TNw1zZmw@mail.gmail.com>
	(Dan Williams's message of "Fri, 22 Nov 2019 08:13:05 -0800")
Message-ID: <x49d0djev4o.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FxwrXjrrPBO6LPh4PmY5hA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: UVUH5NHA7L7FAUTJWNAE7HT6IKLFLBFS
X-Message-ID-Hash: UVUH5NHA7L7FAUTJWNAE7HT6IKLFLBFS
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UVUH5NHA7L7FAUTJWNAE7HT6IKLFLBFS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Nov 22, 2019 at 8:09 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>> >>
>> >> Pankaj Gupta <pagupta@redhat.com> writes:
>> >>
>> >> >  Remove logic to create child bio in the async flush function which
>> >> >  causes child bio to get executed after parent bio 'pmem_make_request'
>> >> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
>> >> >  data write request.
>> >> >
>> >> >  Instead we are performing flush from the parent bio to maintain the
>> >> >  correct order. Also, returning from function 'pmem_make_request' if
>> >> >  REQ_PREFLUSH returns an error.
>> >> >
>> >> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
>> >> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>> >>
>> >> There's a slight change in behavior for the error path in the
>> >> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
>> >> converted to -EIO.  Now, they are reported as-is.  I think this is
>> >> actually an improvement.
>> >>
>> >> I'll also note that the current behavior can result in data corruption,
>> >> so this should be tagged for stable.
>> >
>> > I added that and was about to push this out, but what about the fact
>> > that now the guest will synchronously wait for flushing to occur. The
>> > goal of the child bio was to allow that to be an I/O wait with
>> > overlapping I/O, or at least not blocking the submission thread. Does
>> > the block layer synchronously wait for PREFLUSH requests?
>>
>> You *have* to wait for the preflush to complete before issuing the data
>> write.  See the "Explicit cache flushes" section in
>> Documentation/block/writeback_cache_control.rst.
>
> I'm not debating the ordering, or that the current implementation is
> obviously broken. I'm questioning whether the bio tagged with PREFLUSH
> is a barrier for future I/Os. My reading is that it is only a gate for
> past writes, and it can be queued. I.e. along the lines of
> md_flush_request().

Sorry, I misunderstood your question.

For a write bio with REQ_PREFLUSH set, the PREFLUSH has to be done
before the data attached to the bio is written.  That preflush is not an
I/O barrier.  In other words, for unrelated I/O (any other bio in the
system), it does not impart any specific ordering requirements.  Upper
layers are expected to wait for any related I/O completions before
issuing a flush request.

So yes, you can queue the bio to a worker thread and return to the
caller.  In fact, this is what I had originally suggested to Pankaj.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
