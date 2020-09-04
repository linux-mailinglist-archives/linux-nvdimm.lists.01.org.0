Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C925D336
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Sep 2020 10:08:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C92B13CCBB2C;
	Fri,  4 Sep 2020 01:08:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4976E126B3EAB
	for <linux-nvdimm@lists.01.org>; Fri,  4 Sep 2020 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599206920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SO1+KNA9ZAbDAbragBawZT9Ig1IFiDJv5+VVeyfD9cA=;
	b=fxpeJ0Kk002XrhFJTls2z5wbf28lJzir51gkuZxmuRcyrBss0IkrmTcFf6BcV6VJk7+g+9
	3MApSfBkpg+NReoMV79r66DlcNCmHWHSZuzAZtfXfF4XPLslrHd2hJCRxBaPQT5k5IPd+F
	JtcwZnCmAN/E2zFrhKDiUz2RWGH1ZYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vmHYr-41PsCP_UiG7NElMA-1; Fri, 04 Sep 2020 04:08:36 -0400
X-MC-Unique: vmHYr-41PsCP_UiG7NElMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA7656BE3;
	Fri,  4 Sep 2020 08:08:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D0F01A4D6;
	Fri,  4 Sep 2020 08:08:28 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08488SAu016399;
	Fri, 4 Sep 2020 04:08:28 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08488Qmj016395;
	Fri, 4 Sep 2020 04:08:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Fri, 4 Sep 2020 04:08:26 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a crash when running strace from persistent memory
In-Reply-To: <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: TZ6JWIUA37RBDOYPRDDOBH6IGOJFFZYL
X-Message-ID-Hash: TZ6JWIUA37RBDOYPRDDOBH6IGOJFFZYL
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TZ6JWIUA37RBDOYPRDDOBH6IGOJFFZYL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 3 Sep 2020, Linus Torvalds wrote:

> On Thu, Sep 3, 2020 at 12:24 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > There's a bug when you run strace from dax-based filesystem.
> >
> > -- create real or emulated persistent memory device (/dev/pmem0)
> > mkfs.ext2 /dev/pmem0
> > -- mount it
> > mount -t ext2 -o dax /dev/pmem0 /mnt/test
> > -- copy the system to it (well, you can copy just a few files that are
> >    needed for running strace and ls)
> > cp -ax / /mnt/test
> > -- bind the system directories
> > mount --bind /dev /mnt/test/dev
> > mount --bind /proc /mnt/test/proc
> > mount --bind /sys /mnt/test/sys
> > -- run strace on the ls command
> > chroot /mnt/test/ strace /bin/ls
> >
> > You get this warning and ls is killed with SIGSEGV.
> >
> > I bisected the problem and it is caused by the commit
> > 17839856fd588f4ab6b789f482ed3ffd7c403e1f (gup: document and work around
> > "COW can break either way" issue). When I revert the patch (on the kernel
> > 5.9-rc3), the bug goes away.
> 
> Funky. I really don't see how it could cause that, but we have the
> UDDF issue too, so I'm guessing I will have to fix it the radical way
> with Peter Xu's series based on my "rip out COW special cases" patch.
> 
> Or maybe I'm just using that as an excuse for really wanting to apply
> that series.. Because we can't just revert that GUP commit due to
> security concerns.
> 
> > [   84.191504] WARNING: CPU: 6 PID: 1350 at mm/memory.c:2486 wp_page_copy.cold+0xdb/0xf6
> 
> I'm assuming this is the WARN_ON_ONCE(1) on line 2482, and you have
> some extra debug patch that causes that line to be off by 4? Because
> at least for me, line 2486 is actually an empty line in v5.9-rc3.

Yes, that's it. I added a few printk to look at the control flow.

> That said, I really think this is a pre-existing race, and all the
> "COW can break either way" patch does is change the timing (presumably
> due to the actual pattern of actually doing the COW changing).
> 
> See commit c3e5ea6ee574 ("mm: avoid data corruption on CoW fault into
> PFN-mapped VMA") for background.
> 
> Mikulas, can you check that everything works ok for that case if you
> apply Peter's series? See
> 
>     https://lore.kernel.org/lkml/20200821234958.7896-1-peterx@redhat.com/

I applied these four patches and strace works well. There is no longer any 
warning or crash.

Mikulas

> or if you have 'b4' installed, use
> 
>     b4 am 20200821234958.7896-1-peterx@redhat.com
> 
> to get the series..
> 
>                      Linus
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
