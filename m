Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26392ED48D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Jan 2021 17:43:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 425D7100EAB56;
	Thu,  7 Jan 2021 08:43:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mingkaidong@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFE55100EAB53
	for <linux-nvdimm@lists.01.org>; Thu,  7 Jan 2021 08:43:28 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a188so4187879pfa.11
        for <linux-nvdimm@lists.01.org>; Thu, 07 Jan 2021 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wlIZkPGKoQxUHBPSASacN9V2y3esHgkn8bU6DGmdh/U=;
        b=AdHaxLcS2e+H/EbRu2XgBJ2Q4XhNpzAE7sZFJLuDSeU33L8QmXXbyUoms1kmMAmLDQ
         NOomoUrvCpPmmaVU/m+hCT2xeKSdt5EHRRJLAF0rA5i4+1mJp2uvBGOISeZjQ9SKfAjS
         rcv2CkBLhyee7O5jHF8CVBlp3ub1JvClNRww2NYHQ9+omUQENnastCI7NNuaXckA4GPs
         vMYdvMOxO+omN3qD/1QoN38HTCPOnlUN9TQzn+eSU9YVSfOFQQO+bSNIRmg+pwiXUX4A
         HrOcHM4/G0Mng8xc4rNTVE4N5qYSj81xm4ts5v55aTltkLhNALa4dssrt6UKfv3SUz6e
         hf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wlIZkPGKoQxUHBPSASacN9V2y3esHgkn8bU6DGmdh/U=;
        b=V5HKNI+D1nSI+E3aEnstzi9lNqXldogeQNBjhmFb/iQfM9svoPpuMwaphYuhjqrr94
         nYmGGigm3kpm39dRGXv5XZ2pPnFO6BFO7/VKvhPzaIcOg6oZcjg8Ul72JpkmA4ZFgjH8
         BI76WTqIlF2UjNEokXKc4VHOX9hh7RBzbgg0s0s901UM/8Lg8GMEniWH5FgdhsYQWo33
         EahLcrcYVvxuvuwgeCC5mOptt8fxA6kx7/E30IKO0P/wodj3H2eCqZvCU8LXUb6znNXf
         si7e4iUb6wbJMBnpljY++Sqh1QeSqIZwPJv3BcBBaTXbJGsbgXnBsRd6mZ5quSHNN1X+
         Ohcg==
X-Gm-Message-State: AOAM531Tcx9+BPOoSNuNyx+Luy3K5ZBaEfKQuZtU7hRFMGweUgGI5f90
	FgT11EytcgK34mxeT44e7lIWbbEa29ODQ3KU4sQ=
X-Google-Smtp-Source: ABdhPJyPiXtEd0GEQuaVCHAy2JP1TMLyh1OHWw65ZEzPXICZAme/iC9QnXymWl68ojN2928hSS4cJw==
X-Received: by 2002:a63:4c4b:: with SMTP id m11mr2690509pgl.20.1610037808072;
        Thu, 07 Jan 2021 08:43:28 -0800 (PST)
Received: from [127.0.0.1] (89.208.248.183.16clouds.com. [89.208.248.183])
        by smtp.gmail.com with ESMTPSA id mj5sm2591568pjb.20.2021.01.07.08.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:43:27 -0800 (PST)
From: Mingkai Dong <mingkaidong@gmail.com>
X-Google-Original-From: Mingkai Dong <MinGKaiDong@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: Expense of read_iter
In-Reply-To: <20210107151125.GB5270@casper.infradead.org>
Date: Fri, 8 Jan 2021 00:43:20 +0800
Message-Id: <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Message-ID-Hash: TUIZIO4PM7YFOLLUQFGS67DM4V4SJQNR
X-Message-ID-Hash: TUIZIO4PM7YFOLLUQFGS67DM4V4SJQNR
X-MailFrom: mingkaidong@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mikulas Patocka <mpatocka@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, sunrise_l@sjtu.edu.cn
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TUIZIO4PM7YFOLLUQFGS67DM4V4SJQNR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Matthew,

We have also discovered the expense of `->read_iter` in our study on Ext4-DAX.
In single-thread 4K-reads, the `->read` version could outperform `->read_iter`
by 41.6% in terms of throughput.

According to our observation and evaluation, at least for Ext4-DAX, the cost
also comes from the invocation of `->iomap_begin` (`ext4_iomap_begin`),
which might not be simply avoided by adding a new iter_type.
The slowdown is more significant when multiple threads reading different files
concurrently, due to the scalability issue (grabbing a read lock to check the
status of the journal) in `ext4_iomap_begin`.

In our solution, we implemented the `->read` and `->write` interfaces for
Ext4-DAX. Thus, we also think it would be good if both `->read` and `->read_iter`
could exist.

By the way, besides the implementation of `->read` and `->write`, we have
some other optimizations for Ext4-DAX and would like to share them once our
patches are prepared.

Thanks,
Mingkai


> On Jan 7, 2021, at 23:11, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
>> I'd like to ask about this piece of code in __kernel_read:
>> 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
>> 		return warn_unsupported...
>> and __kernel_write:
>> 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
>> 		return warn_unsupported...
>> 
>> - It exits with an error if both read_iter and read or write_iter and 
>> write are present.
>> 
>> I found out that on NVFS, reading a file with the read method has 10% 
>> better performance than the read_iter method. The benchmark just reads the 
>> same 4k page over and over again - and the cost of creating and parsing 
>> the kiocb and iov_iter structures is just that high.
> 
> Which part of it is so expensive?  Is it worth, eg adding an iov_iter
> type that points to a single buffer instead of a single-member iov?
> 
> +++ b/include/linux/uio.h
> @@ -19,6 +19,7 @@ struct kvec {
> 
> enum iter_type {
>        /* iter types */
> +       ITER_UBUF = 2,
>        ITER_IOVEC = 4,
>        ITER_KVEC = 8,
>        ITER_BVEC = 16,
> @@ -36,6 +36,7 @@ struct iov_iter {
>        size_t iov_offset;
>        size_t count;
>        union {
> +               void __user *buf;
>                const struct iovec *iov;
>                const struct kvec *kvec;
>                const struct bio_vec *bvec;
> 
> and then doing all the appropriate changes to make that work.
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
