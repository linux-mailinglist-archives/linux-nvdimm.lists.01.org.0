Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F016B341
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 22:53:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4887B10FC358A;
	Mon, 24 Feb 2020 13:54:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4BDE810FC3406
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582581228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4YTOFOiOnkKkiliUoZ/jqhMNCus3zHP0xUGk3kFXx8=;
	b=exyUpSWRGbARQl4a77GRXxLpQAVXu4D6kqBSLjeC0gsRzWNVh+lcVfJyOARY9zv1yDl+V7
	uNOwGlzMbCM36lTcvizCdVitoQbip55j3oO/biQ27+JyqE2ZpwrhwVKcFeOf2e6r+wbvNx
	gX4t7gTbiM6yVmfDT5biN9WlsKaIYbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-s0mb0vPUOqKMXSwc_5rNKA-1; Mon, 24 Feb 2020 16:53:43 -0500
X-MC-Unique: s0mb0vPUOqKMXSwc_5rNKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71C4107ACC4;
	Mon, 24 Feb 2020 21:53:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A58CB8B77D;
	Mon, 24 Feb 2020 21:53:38 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
	<20200218214841.10076-3-vgoyal@redhat.com>
	<x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
	<20200220215707.GC10816@redhat.com>
	<x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
	<20200221201759.GF25974@redhat.com>
	<20200223230330.GE10737@dread.disaster.area>
	<CAPcyv4ghusuMsAq8gSLJKh1fiKjwa8R_-ojVgjsttoPRqBd_Sg@mail.gmail.com>
	<x49blpop00m.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 24 Feb 2020 16:53:37 -0500
In-Reply-To: <CAPcyv4gCA_oR8_8+zhAhMnqOga9GcpMX97S+x8_UD6zLEQ0Cew@mail.gmail.com>
	(Dan Williams's message of "Mon, 24 Feb 2020 12:48:35 -0800")
Message-ID: <x49sgizodni.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: T73OQEWFTZRH7FNQE6P7U3FNUIZRU2KN
X-Message-ID-Hash: T73OQEWFTZRH7FNQE6P7U3FNUIZRU2KN
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T73OQEWFTZRH7FNQE6P7U3FNUIZRU2KN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>> Let's just focus on reporting errors when we know we have them.
>
> That's the problem in my eyes. If software needs to contend with
> latent error reporting then it should always contend otherwise
> software has multiple error models to wrangle.

The only way for an application to know that the data has been written
successfully would be to issue a read after every write.  That's not a
performance hit most applications are willing to take.  And, of course,
the media can still go bad at a later time, so it only guarantees the
data is accessible immediately after having been written.

What I'm suggesting is that we should not complete a write successfully
if we know that the data will not be retrievable.  I wouldn't call this
adding an extra error model to contend with.  Applications should
already be checking for errors on write.

Does that make sense?  Are we talking past each other?

> Setting that aside we can start with just treating zeroing the same as
> the copy_from_iter() case and fail the I/O at the dax_direct_access()
> step.

OK.

> I'd rather have a separate op that filesystems can use to clear errors
> at block allocation time that can be enforced to have the correct
> alignment.

So would file systems always call that routine instead of zeroing, or
would they first check to see if there are badblocks?

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
