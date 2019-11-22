Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FE10756F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 17:09:01 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7759910113300;
	Fri, 22 Nov 2019 08:09:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5EC8D100DC407
	for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1574438935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aChokPuSf/E1/myJnN2scacEgSwoRMHnNtyJ+8WYM+U=;
	b=bZKVkc80LqafSV4UKq4s6/QqRLLEijI5u81HkHqcWRkWLnzDY7hUgIPziITJRMVBi0eYDB
	wB1BFM6TPt3Ak1yXaLNjRBJk0ljDDWe1HgANZ0iLsItt2mxnFad8SaSmHh2D2ut+Fst6KA
	+K6XV3hKctpTfLdgyqcYaey8kur3nBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-paFjoYLyMj6EbrgB8Ql3JA-1; Fri, 22 Nov 2019 11:08:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889F01005510;
	Fri, 22 Nov 2019 16:08:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B08A8516;
	Fri, 22 Nov 2019 16:08:48 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
References: <20191120092831.6198-1-pagupta@redhat.com>
	<x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 22 Nov 2019 11:08:46 -0500
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
	(Dan Williams's message of "Wed, 20 Nov 2019 23:23:46 -0800")
Message-ID: <x49h82vevw1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: paFjoYLyMj6EbrgB8Ql3JA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: RGVZXKXIRZFVGMNYF4KF7GDGVCN2C6DL
X-Message-ID-Hash: RGVZXKXIRZFVGMNYF4KF7GDGVCN2C6DL
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RGVZXKXIRZFVGMNYF4KF7GDGVCN2C6DL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Pankaj Gupta <pagupta@redhat.com> writes:
>>
>> >  Remove logic to create child bio in the async flush function which
>> >  causes child bio to get executed after parent bio 'pmem_make_request'
>> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
>> >  data write request.
>> >
>> >  Instead we are performing flush from the parent bio to maintain the
>> >  correct order. Also, returning from function 'pmem_make_request' if
>> >  REQ_PREFLUSH returns an error.
>> >
>> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
>> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>>
>> There's a slight change in behavior for the error path in the
>> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
>> converted to -EIO.  Now, they are reported as-is.  I think this is
>> actually an improvement.
>>
>> I'll also note that the current behavior can result in data corruption,
>> so this should be tagged for stable.
>
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests?

You *have* to wait for the preflush to complete before issuing the data
write.  See the "Explicit cache flushes" section in
Documentation/block/writeback_cache_control.rst.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
