Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C462ED357
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Jan 2021 16:14:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3642D100EAB4F;
	Thu,  7 Jan 2021 07:14:47 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=90.155.50.34; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D625D100EAB4F
	for <linux-nvdimm@lists.01.org>; Thu,  7 Jan 2021 07:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0BDgIONn6TjjQMsa9yNHOZnzgJZxqty6jQ95csWbZak=; b=VqtzpDEUiHiNIlsNu1O/yx6KxX
	LbBd4nXTprs9jRxCfiLT8qrfTU68eKVlHiCFzq3vgfnIntYgs9WeDxbYsFpYFzp0TYe1z/UrbyqnX
	Z+gprP/3UA3U+ecTAdgGFDt+6i/tGrbEzWXSu3VHz+sIZHQGE8S00RLosjrGr3KyKHbJeRL8kYZ1E
	v53WctRMSqqioV0Vp+ylJrjmE1x19psmquRxI3q+noZne4ZljZHRSqcweQd5i3S+lPqkoH3ZN+lf+
	ovW9vu3XH/DUFguJG2ZgT6hIJS8d2VvA7jxwPdBG2YtE4jjL13TWA+qgbZ/1XObAeenKM4TNPvlJx
	VEfhfjXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1kxWwf-000A25-U4; Thu, 07 Jan 2021 15:12:09 +0000
Date: Thu, 7 Jan 2021 15:11:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Expense of read_iter
Message-ID: <20210107151125.GB5270@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID-Hash: CN7M36VX74RL3MZVWGNQTQGTVT6CRYIJ
X-Message-ID-Hash: CN7M36VX74RL3MZVWGNQTQGTVT6CRYIJ
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CN7M36VX74RL3MZVWGNQTQGTVT6CRYIJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> I'd like to ask about this piece of code in __kernel_read:
> 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
> 		return warn_unsupported...
> and __kernel_write:
> 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> 		return warn_unsupported...
> 
> - It exits with an error if both read_iter and read or write_iter and 
> write are present.
> 
> I found out that on NVFS, reading a file with the read method has 10% 
> better performance than the read_iter method. The benchmark just reads the 
> same 4k page over and over again - and the cost of creating and parsing 
> the kiocb and iov_iter structures is just that high.

Which part of it is so expensive?  Is it worth, eg adding an iov_iter
type that points to a single buffer instead of a single-member iov?

+++ b/include/linux/uio.h
@@ -19,6 +19,7 @@ struct kvec {
 
 enum iter_type {
        /* iter types */
+       ITER_UBUF = 2,
        ITER_IOVEC = 4,
        ITER_KVEC = 8,
        ITER_BVEC = 16,
@@ -36,6 +36,7 @@ struct iov_iter {
        size_t iov_offset;
        size_t count;
        union {
+               void __user *buf;
                const struct iovec *iov;
                const struct kvec *kvec;
                const struct bio_vec *bvec;

and then doing all the appropriate changes to make that work.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
