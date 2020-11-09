Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5312AAED6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 02:50:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BC8A165124E0;
	Sun,  8 Nov 2020 17:50:11 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 956C4165124DE
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 17:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AobZxJ/HiQYFTgs4zqC9zfaXXKVlXCBSCwwjLD1KjZ0=; b=VPWIUXEkn7yjll3UOVUmXLbIcA
	YMnxFyPYYzn4DTPL5anGuzZwIqHfAh9oX4jdLowsEs29/895OopcscxmA620gE0/nJ4NfTqMY7URw
	BNexVF7JDxKxv6ip9/Zc+HOuSB97Y2UqkQ5g7YX8LDudu5YajcnTkxNwl6uUGY+TuGZ7ZiqcHL+cn
	lsnmsZsfxBBb09s6jr/22M2VHJIojwdAeqd1IOT//5TfZ2nqH9g7/SdY6H5f7XEQ3stg0lzbRqSlQ
	BZb2pyGvLHNu/ahXhtbz/ind2IYXxf7AIsUiLozPIg3uelHzStb/4dX9Qd6kVfUYinbp9kaU47BSA
	23tCnATw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbwJl-0006Kt-Lq; Mon, 09 Nov 2020 01:50:01 +0000
Date: Mon, 9 Nov 2020 01:50:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201109015001.GX17076@casper.infradead.org>
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109013322.GA9685@magnolia>
Message-ID-Hash: NSWPBV75XSOG5CJS7PWNMEGFX43HWFV2
X-Message-ID-Hash: NSWPBV75XSOG5CJS7PWNMEGFX43HWFV2
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NSWPBV75XSOG5CJS7PWNMEGFX43HWFV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> > to XA_ZERO_ENTRY for representing holes in files.
> 
> Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
> same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
> because we took a read fault on a sparse file hole").

There's no current user of XA_ZERO_ENTRY in i_pages, whether it be
DAX or non-DAX.

> > XA_ZERO_ENTRY
> > is defined in include/linux/xarray.h, where it's defined using
> > xa_mk_internal(257). This function returns a void pointer, which
> > is incompatible with the bitwise arithmetic it is performed on with.

We don't really perform bitwise arithmetic on it, outside of:

static int dax_is_zero_entry(void *entry)
{
        return xa_to_value(entry) & DAX_ZERO_PAGE;
}

> > Currently, DAX_ZERO_PAGE is defined as an unsigned long,
> > so I considered typecasting it. Typecasting every time would be
> > repetitive and inefficient. I thought about making a new definition
> > for it which has the typecast, but this breaks the original point of
> > using already defined terms.
> > 
> > Should we go the route of adding a new definition, we might as
> > well just change the definition of DAX_ZERO_PAGE. This would
> > break the simplicity of the current DAX bit definitions:
> > 
> > #define DAX_LOCKED      (1UL << 0)
> > #define DAX_PMD               (1UL << 1)
> > #define DAX_ZERO_PAGE  (1UL << 2)
> > #define DAX_EMPTY      (1UL << 3)

I was proposing deleting the entire bit and shifting DAX_EMPTY down.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
