Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B992F09D0
	for <lists+linux-nvdimm@lfdr.de>; Sun, 10 Jan 2021 22:19:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C53E1100EC1E9;
	Sun, 10 Jan 2021 13:19:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE364100EF27E
	for <linux-nvdimm@lists.01.org>; Sun, 10 Jan 2021 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1610313563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GzR2svGdni3UUiAwy2uWgYKwGxzlJZYVizDa0vCUdQY=;
	b=QICQkAEWBK7v64WCZ/rP/AW6Wr0iISKQN+8sLsfm1Qe34zlFMjfNeLDo52tBvoyEFSAsF+
	dnqN2hafP1rsHbbmSFQWw9/oB23CUrcs47ubOrbR8+lfUq9zl7f06KTkQ99znJrQeTGb1k
	ix8fOUKhiik01xlL0OlwQCBlAk4cjlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-gerFTRC6OEKKrZ73RlIjtA-1; Sun, 10 Jan 2021 16:19:18 -0500
X-MC-Unique: gerFTRC6OEKKrZ73RlIjtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69C8615720;
	Sun, 10 Jan 2021 21:19:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E1FA350A80;
	Sun, 10 Jan 2021 21:19:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10ALJFNW017003;
	Sun, 10 Jan 2021 16:19:15 -0500
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10ALJFs6016999;
	Sun, 10 Jan 2021 16:19:15 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Sun, 10 Jan 2021 16:19:15 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Expense of read_iter
In-Reply-To: <20210110061321.GC35215@casper.infradead.org>
Message-ID: <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: PE6VEWBRNCIHLW7KBY33EWGBGAWX4HOQ
X-Message-ID-Hash: PE6VEWBRNCIHLW7KBY33EWGBGAWX4HOQ
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PE6VEWBRNCIHLW7KBY33EWGBGAWX4HOQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sun, 10 Jan 2021, Matthew Wilcox wrote:

> > That is the reason for that 10% degradation with read_iter.
> 
> You seem to be focusing on your argument for "let's just permit
> filesystems to implement both ->read and ->read_iter".  My suggestion
> is that we need to optimise the ->read_iter path, but to do that we need
> to know what's expensive.
> 
> nvfs_rw_iter_locked() looks very complicated.  I suspect it can
> be simplified.

I split it to a separate read and write function and it improved 
performance by 1.3%. Using Al Viro's read_iter improves performance by 3%.

> Of course new_sync_read() needs to be improved too,
> as do the other functions here, but fully a third of the difference
> between read() and read_iter() is the difference between nvfs_read()
> and nvfs_rw_iter_locked().

I put counters into vfs_read and vfs_readv.

After a fresh boot of the virtual machine, the counters show "13385 4". 
After a kernel compilation they show "4475220 8".

So, the readv path is almost unused.

My reasoning was that we should optimize for the "read" path and glue the 
"readv" path on the top of that. Currently, the kernel is doing the 
opposite - optimizing for "readv" and glueing "read" on the top of it.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
