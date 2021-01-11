Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FF2F188D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 11 Jan 2021 15:44:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 252AE100EC1E6;
	Mon, 11 Jan 2021 06:44:31 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2002:c35c:fd02::1; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN> 
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7167C100ED498
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 06:44:28 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyyQ1-009I2g-Bx; Mon, 11 Jan 2021 14:43:41 +0000
Date: Mon, 11 Jan 2021 14:43:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210111144341.GZ3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
 <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
 <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Message-ID-Hash: XKAJ5ZWGBCKAMQ7OSHRYIUUWAXBCB2T2
X-Message-ID-Hash: XKAJ5ZWGBCKAMQ7OSHRYIUUWAXBCB2T2
X-MailFrom: viro@ftp.linux.org.uk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: 'Mikulas Patocka' <mpatocka@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Wang Jianchao <jianchao.wan9@gmail.com>, "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XKAJ5ZWGBCKAMQ7OSHRYIUUWAXBCB2T2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 11, 2021 at 11:57:08AM +0000, David Laight wrote:
> > > > 		size = copy_to_iter(to, ptr, size);
> > > > 		if (unlikely(!size)) {
> > > > 			r = -EFAULT;
> > > > 			goto ret_r;
> > > > 		}
> > > >
> > > > 		pos += size;
> > > > 		total += size;
> > > > 	} while (iov_iter_count(to));
> > >
> > > That isn't the best formed loop!
> > >
> > > 	David
> > 
> > I removed the second "while" statement and fixed the arguments to
> > copy_to_iter - other than that, Al's function works.
> 
> The extra while is easy to write and can be difficult to spot.
> I've found them looking as the object code before now!

	That extra while comes from editing cut'n'pasted piece of
source while writing a reply.  Hint: original had been a do-while.

> Oh - the error return for copy_to_iter() is wrong.
> It should (probably) return 'total' if it is nonzero.

	copy_to_iter() call there has an obvious problem
(arguments in the wrong order), but return value is handled
correctly.  It does not do a blind return -EFAULT.  RTFS...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
