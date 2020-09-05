Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15825E768
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Sep 2020 14:11:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FD30137E5AEC;
	Sat,  5 Sep 2020 05:11:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E0A61252D34A
	for <linux-nvdimm@lists.01.org>; Sat,  5 Sep 2020 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599307885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HJzFO7pAp71wK9aXPM9q5yt4bMuyYKdTaYajwPv7ro=;
	b=USetTins5hZ9/jwekFv3Sf43shqw3jqIYOaieFj3O01aWOl8CA3DNDtX5/iFcRXaG+Eeba
	zCXvi38etgQlp+82mUpvedCw7Rk6mN+jnOfeCdIeEVGn2UR0nV5Hdw/+9MnQlJju0Y5EXO
	qw8/Q8QNri40q5mdPj6EXqne0OVfeGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-zs11oeW0P32FFs86Hfex0w-1; Sat, 05 Sep 2020 08:11:21 -0400
X-MC-Unique: zs11oeW0P32FFs86Hfex0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106EB10054B0;
	Sat,  5 Sep 2020 12:11:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60FAC7FB92;
	Sat,  5 Sep 2020 12:11:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 085CBDc6012762;
	Sat, 5 Sep 2020 08:11:13 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 085CBBbB012758;
	Sat, 5 Sep 2020 08:11:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Sat, 5 Sep 2020 08:11:11 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: make misbehavior on ext2 in dax mode (was: a crash when running
 strace from persistent memory)
In-Reply-To: <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: GIEJBUYH2YRR2YIQ2BAFQAUNUZZNNQM5
X-Message-ID-Hash: GIEJBUYH2YRR2YIQ2BAFQAUNUZZNNQM5
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GIEJBUYH2YRR2YIQ2BAFQAUNUZZNNQM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 4 Sep 2020, Mikulas Patocka wrote:

> Hmm, so I've found another bug in dax mode.
> 
> If you extract the Linux kernel tree on dax-based ext2 filesystem (use the 
> real ext2 driver, not ext4), and then you run make twice, the second 
> invocation will rebuild everything. It seems like a problem with 
> timestamps.
> 
> mount -t ext2 -o dax /dev/pmem0 /mnt/ext2/
> cd /mnt/ext2/usr/src/git/linux-2.6
> make clean
> make -j12
> make -j12	<--- this rebuilds the whole tree, althought it shouldn't
> 
> I wasn't able to bisect it because this bug seems to be present in every 
> kernel I tried (back to 4.16.0). Ext4 doesn't seem to have this bug.
> 
> Mikulas

I've found out the root cause for this bug (XFS has it too) and I'm 
sending patches.

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
