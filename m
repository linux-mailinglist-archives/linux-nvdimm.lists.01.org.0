Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ED116F019
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 21:32:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A59F10FC36C5;
	Tue, 25 Feb 2020 12:33:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1227910FC36C2
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582662769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xvbWbC+c+tVCEK40qjhzeXODS5wv3ih00+5vhWuBChU=;
	b=Uv6+onyndCKdR8oMBZ4chAjuV4Pygv1Ox6kPSYhp/WvMJV5ilG+toHrbqmictdR3M+blLx
	WwWin4vvML39Md6oJLFDE5JbBHzwpBsVPPctANo2W2DSfF6QrTYWbzoztO9XP2KvXlaE8m
	0aUjNybQd5lgvwm6yVsoNFNE4S+R6T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-r9cwb_RqMgCs7YqAfBVZkQ-1; Tue, 25 Feb 2020 15:32:47 -0500
X-MC-Unique: r9cwb_RqMgCs7YqAfBVZkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72FB6800D54;
	Tue, 25 Feb 2020 20:32:46 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6532C92972;
	Tue, 25 Feb 2020 20:32:42 +0000 (UTC)
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
	<x49sgizodni.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4gUM47QgGKvK4ZVUek6f=ABT7hRFX47-DQiD6AcrxtRHA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 25 Feb 2020 15:32:41 -0500
In-Reply-To: <CAPcyv4gUM47QgGKvK4ZVUek6f=ABT7hRFX47-DQiD6AcrxtRHA@mail.gmail.com>
	(Dan Williams's message of "Mon, 24 Feb 2020 16:26:17 -0800")
Message-ID: <x494kveh0gm.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: 7OGJZAXOXRFFAOCVYAAKA2ONRFMEFRPF
X-Message-ID-Hash: 7OGJZAXOXRFFAOCVYAAKA2ONRFMEFRPF
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7OGJZAXOXRFFAOCVYAAKA2ONRFMEFRPF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Feb 24, 2020 at 1:53 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> >> Let's just focus on reporting errors when we know we have them.
>> >
>> > That's the problem in my eyes. If software needs to contend with
>> > latent error reporting then it should always contend otherwise
>> > software has multiple error models to wrangle.
>>
>> The only way for an application to know that the data has been written
>> successfully would be to issue a read after every write.  That's not a
>> performance hit most applications are willing to take.  And, of course,
>> the media can still go bad at a later time, so it only guarantees the
>> data is accessible immediately after having been written.
>>
>> What I'm suggesting is that we should not complete a write successfully
>> if we know that the data will not be retrievable.  I wouldn't call this
>> adding an extra error model to contend with.  Applications should
>> already be checking for errors on write.
>>
>> Does that make sense? Are we talking past each other?
>
> The badblock list is late to update in both directions, late to add
> entries that the scrub needs to find and late to delete entries that
> were inadvertently cleared by cache-line writes that did not first
> ingest the poison for a read-modify-write.

We aren't looking for perfection.  If the badblocks list is populated,
then report the error instead of letting the user write data that we
know they won't be able to access later.

You have confused me, though, since I thought that stores to bad media
would not clear errors.  Perhaps you are talking about some future
hardware implementation that doesn't yet exist?

> So I see the above as being wishful in using the error list as the
> hard source of truth and unfortunate to up-level all sub-sector error
> entries into full PAGE_SIZE data offline events.

The page size granularity is only an issue for mmap().  If you are using
read/write, then 512 byte granularity can be achieved.  Even with mmap,
if you encounter an error on a 4k page, you can query the status of each
sector in that page to isolate the error.  So I'm not quite sure I
understand what you're getting at.

> I'm hoping we can find a way to make the error handling more fine
> grained over time, but for the current patch, managing the blast
> radius as PAGE_SIZE granularity at least matches the zero path with
> the write path.

I think the write path can do 512 byte granularity, not page size.
Anyway, I think we've gone far enough off into the weeds that more
patches will have to be posted for debate.  :)

>> > Setting that aside we can start with just treating zeroing the same as
>> > the copy_from_iter() case and fail the I/O at the dax_direct_access()
>> > step.
>>
>> OK.
>>
>> > I'd rather have a separate op that filesystems can use to clear errors
>> > at block allocation time that can be enforced to have the correct
>> > alignment.
>>
>> So would file systems always call that routine instead of zeroing, or
>> would they first check to see if there are badblocks?
>
> The proposal is that filesystems distinguish zeroing from free-block
> allocation/initialization such that the fsdax implementation directs
> initialization to a driver callback. This "initialization op" would
> take care to check for poison and clear it. All other dax paths would
> not consult the badblocks list.

What do you mean by "all other dax paths?"  Would that include
mmap/direct_access?  Because that definitely should still consult the
badblocks list.

I'm not against having a separate operation for clearing errors, but I
guess I'm not convinced it's cleaner, either.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
