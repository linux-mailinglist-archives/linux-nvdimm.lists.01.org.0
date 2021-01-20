Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563C2FD381
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 16:12:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64E50100EB83A;
	Wed, 20 Jan 2021 07:12:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD073100EB82B
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1611155532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0WX/IW9qTI7pWygS2OV9t8yQ+iugqSZyKKAWy8i8Ng=;
	b=Q3Qr/1uFoCj2oZ+RSHr16kN0zvUkjivP6oK6ISezJiCaVM03csR7Mkk5R7R9E4nhvQjxCR
	VtJmuW5Kdg36JwaNYgQXdcz+pamYp13pA6Qy25fHC+POYIE+tPvdpExgMWRHP3s6xWtpNJ
	0dRwynmVFYgi8rTV8b6H9zjFjhIkpTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-i0lmVuOrNH2l7F-G-gW3wA-1; Wed, 20 Jan 2021 10:12:08 -0500
X-MC-Unique: i0lmVuOrNH2l7F-G-gW3wA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE2D8066E5;
	Wed, 20 Jan 2021 15:12:05 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 926EA608BA;
	Wed, 20 Jan 2021 15:12:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 10KFC4DG027528;
	Wed, 20 Jan 2021 10:12:04 -0500
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 10KFC1Sq027524;
	Wed, 20 Jan 2021 10:12:01 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Wed, 20 Jan 2021 10:12:01 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Jan Kara <jack@suse.cz>
Subject: Re: Expense of read_iter
In-Reply-To: <20210120141834.GA24063@quack2.suse.cz>
Message-ID: <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com> <20210107151125.GB5270@casper.infradead.org> <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com> <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com> <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn> <20210120044700.GA4626@dread.disaster.area> <20210120141834.GA24063@quack2.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: RRNNXDMRK2IQYTCZSRAWZGEGL7VCTIIG
X-Message-ID-Hash: RRNNXDMRK2IQYTCZSRAWZGEGL7VCTIIG
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Zhongwei Cai <sunrise_l@sjtu.edu.cn>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, David Laight <David.Laight@aculab.com>, Mingkai Dong <mingkaidong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Wang Jianchao <jianchao.wan9@gmail.com>, Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RRNNXDMRK2IQYTCZSRAWZGEGL7VCTIIG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 20 Jan 2021, Jan Kara wrote:

> Yeah, I agree. I'm against ext4 private solution for this read problem. And
> I'm also against duplicating ->read_iter functionatily in ->read handler.
> The maintenance burden of this code duplication is IMHO just too big. We
> rather need to improve the generic code so that the fast path is faster.
> And every filesystem will benefit because this is not ext4 specific
> problem.
> 
> 								Honza

Do you have some idea how to optimize the generic code that calls 
->read_iter?

vfs_read calls ->read if it is present. If not, it calls new_sync_read. 
new_sync_read's frame size is 128 bytes - it holds the structures iovec, 
kiocb and iov_iter. new_sync_read calls ->read_iter.

I have found out that the cost of calling new_sync_read is 3.3%, Zhongwei 
found out 3.9%. (the benchmark repeatedy reads the same 4k page)

I don't see any way how to optimize new_sync_read or how to reduce its 
frame size. Do you?

Mikulas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
