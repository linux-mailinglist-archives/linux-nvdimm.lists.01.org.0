Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126526A8F7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 17:41:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F9C8141316F2;
	Tue, 15 Sep 2020 08:41:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.86.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BA57913FD9F3F
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 08:40:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-53-W38LQ2b8OBS5NKJlBcK7FA-1; Tue, 15 Sep 2020 16:40:53 +0100
X-MC-Unique: W38LQ2b8OBS5NKJlBcK7FA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Sep 2020 16:40:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Sep 2020 16:40:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
Thread-Topic: [PATCH v2 2/9] fs: Introduce i_blocks_per_page
Thread-Index: AQHWh8zSUX5EB+iAm0+PkXaO9U0VzKlp3UwQ
Date: Tue, 15 Sep 2020 15:40:52 +0000
Message-ID: <0c874f14499c4d819f3e8e09f5086d77@AcuMS.aculab.com>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-3-willy@infradead.org>
In-Reply-To: <20200910234707.5504-3-willy@infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Message-ID-Hash: ZZJNDVUR33DDQNHGT3WMY2UZADOC665I
X-Message-ID-Hash: ZZJNDVUR33DDQNHGT3WMY2UZADOC665I
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Darrick J . Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	"jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>,
	Christoph Hellwig <hch@lst.de>, Dave@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZZJNDVUR33DDQNHGT3WMY2UZADOC665I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Matthew Wilcox (Oracle)
> Sent: 11 September 2020 00:47
> This helper is useful for both THPs and for supporting block size larger
> than page size.  Convert all users that I could find (we have a few
> different ways of writing this idiom, and I may have missed some).
> 
...
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d81a9a86c5aa..330f86b825d7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> 
> -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> +	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;
> 
>  	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> @@ -147,7 +147,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	unsigned int i;
> 
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
> +	for (i = 0; i < i_blocks_per_page(inode, page); i++) {

You probably don't want to call the helper every time
around the loop.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
