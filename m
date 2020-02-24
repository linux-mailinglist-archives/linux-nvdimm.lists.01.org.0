Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A22916AA4B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 16:38:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6306410FC3597;
	Mon, 24 Feb 2020 07:39:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F227910FC3596
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582558732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLyonSIDC83RBTPHCM8f4o4yMY3G8tzoWeqc8LOk64E=;
	b=ctE3imUCyAxMorQuveVrKIKKK8Hs8etUlcezAo2CQ0Ujgpsut/a+Mw54I3tW1w4ZJWo0Rb
	Hhqk3lLV3VyPYqa6D7LRV8un2OQ1WFEWWGwZWr+gjgn/TJwT+7KxmgPzpFO1UyIAsr9UVF
	rA3jYwnK/biVfgIO3KkGFgs0YE3e0tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202--esf3cAoOSmm3_PTQ-NYEw-1; Mon, 24 Feb 2020 10:38:48 -0500
X-MC-Unique: -esf3cAoOSmm3_PTQ-NYEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EFB1800D5E;
	Mon, 24 Feb 2020 15:38:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6F125C1D6;
	Mon, 24 Feb 2020 15:38:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 571B3220A24; Mon, 24 Feb 2020 10:38:44 -0500 (EST)
Date: Mon, 24 Feb 2020 10:38:44 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200224153844.GB14651@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200223230330.GE10737@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: LCBJDMPPBWUXOYQJKH7O3XDDYL24QTKD
X-Message-ID-Hash: LCBJDMPPBWUXOYQJKH7O3XDDYL24QTKD
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LCBJDMPPBWUXOYQJKH7O3XDDYL24QTKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2020 at 10:03:30AM +1100, Dave Chinner wrote:

[..]
> > > > Hi Jeff,
> > > >
> > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > a range which is less than a sector. Or which is bigger than a sector
> > > > but start and end are not aligned on sector boundaries.
> > > 
> > > Sure, but who will call it with misaligned ranges?
> > 
> > create a file foo.txt of size 4K and then truncate it.
> > 
> > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > 4095.
> 
> This should fail with EIO. Only full page writes should clear the
> bad page state, and partial writes should therefore fail because
> they do not guarantee the data in the filesystem block is all good.
> 
> If this zeroing was a buffered write to an address with a bad
> sector, then the writeback will fail and the user will (eventually)
> get an EIO on the file.
> 
> DAX should do the same thing, except because the zeroing is
> synchronous (i.e. done directly by the truncate syscall) we can -
> and should - return EIO immediately.
> 
> Indeed, with your code, if we then extend the file by truncating up
> back to 4k, then the range between 23 and 512 is still bad, even
> though we've successfully zeroed it and the user knows it. An
> attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> will fail with EIO, but reading 10 bytes at offset 2000 will
> succeed.

Hi Dave,

What is expected if I do "truncate -s 512 foo.txt". Say first sector (0 to
511) is poisoned and rest don't have poison. Should this fail with -EIO.

In current implementation it does not. Because all sector aligned I/O
we redirect through blkdev_issue_zeroout() and that will happly zero
out sector 2-8 without worrying about the state of sector 1. Hence user
which tries to read 10 bytes at offset 100, will still fail. This probably
should be fixed if we want to retain existing behavior.

Anyway, partial page truncate can't ensure that data in rest of the page can
be read back successfully. Memory can get poison after the write and
hence read after truncate will still fail.

Hence, all we are trying to ensure is that if a poison is known at the
time of writing partial page, then we should return error to user space.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
