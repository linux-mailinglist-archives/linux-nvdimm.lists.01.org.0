Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D02F1011
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 11:29:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E045D100EBBB9;
	Mon, 11 Jan 2021 02:29:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.85.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3D1AF100EBBB4
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 02:29:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-34-7ibnZ-d1Oea7y-_CqhqRwQ-1; Mon, 11 Jan 2021 10:29:29 +0000
X-MC-Unique: 7ibnZ-d1Oea7y-_CqhqRwQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 Jan 2021 10:29:28 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 Jan 2021 10:29:28 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>, Mikulas Patocka <mpatocka@redhat.com>
Subject: RE: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Topic: [RFC v2] nvfs: a filesystem for persistent memory
Thread-Index: AQHW52zcFLyucqAcQUmnqwhwPozPcaoiOfvQ
Date: Mon, 11 Jan 2021 10:29:28 +0000
Message-ID: <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210110162008.GV3579531@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Message-ID-Hash: Z7PLQ5H3WZGAZFF6Y5F2M7QPEUQUB2GP
X-Message-ID-Hash: Z7PLQ5H3WZGAZFF6Y5F2M7QPEUQUB2GP
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>,
	"Dave Jiang  <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,  Matthew Wilcox  <willy@infradead.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse" <swhiteho@redhat.com>,
	Eric Sandeen <esandeen@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Wang Jianchao <jianchao.wan9@gmail.com>, Norton@ml01.01.org,
	Scott@ml01.01.org, Rajesh <rajesh.tadakamadla@hpe.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z7PLQ5H3WZGAZFF6Y5F2M7QPEUQUB2GP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: 10 January 2021 16:20
> 
> On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> > Hi
> >
> > I announce a new version of NVFS - a filesystem for persistent memory.
> > 	http://people.redhat.com/~mpatocka/nvfs/
> Utilities, AFAICS
> 
> > 	git://leontynka.twibright.com/nvfs.git
> Seems to hang on git pull at the moment...  Do you have it anywhere else?
> 
> > I found out that on NVFS, reading a file with the read method has 10%
> > better performance than the read_iter method. The benchmark just reads the
> > same 4k page over and over again - and the cost of creating and parsing
> > the kiocb and iov_iter structures is just that high.
> 
> Apples and oranges...  What happens if you take
> 
> ssize_t read_iter_locked(struct file *file, struct iov_iter *to, loff_t *ppos)
> {
> 	struct inode *inode = file_inode(file);
> 	struct nvfs_memory_inode *nmi = i_to_nmi(inode);
> 	struct nvfs_superblock *nvs = inode->i_sb->s_fs_info;
> 	ssize_t total = 0;
> 	loff_t pos = *ppos;
> 	int r;
> 	int shift = nvs->log2_page_size;
> 	size_t i_size;
> 
> 	i_size = inode->i_size;
> 	if (pos >= i_size)
> 		return 0;
> 	iov_iter_truncate(to, i_size - pos);
> 
> 	while (iov_iter_count(to)) {
> 		void *blk, *ptr;
> 		size_t page_mask = (1UL << shift) - 1;
> 		unsigned page_offset = pos & page_mask;
> 		unsigned prealloc = (iov_iter_count(to) + page_mask) >> shift;
> 		unsigned size;
> 
> 		blk = nvfs_bmap(nmi, pos >> shift, &prealloc, NULL, NULL, NULL);
> 		if (unlikely(IS_ERR(blk))) {
> 			r = PTR_ERR(blk);
> 			goto ret_r;
> 		}
> 		size = ((size_t)prealloc << shift) - page_offset;
> 		ptr = blk + page_offset;
> 		if (unlikely(!blk)) {
> 			size = min(size, (unsigned)PAGE_SIZE);
> 			ptr = empty_zero_page;
> 		}
> 		size = copy_to_iter(to, ptr, size);
> 		if (unlikely(!size)) {
> 			r = -EFAULT;
> 			goto ret_r;
> 		}
> 
> 		pos += size;
> 		total += size;
> 	} while (iov_iter_count(to));

That isn't the best formed loop!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
