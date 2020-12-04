Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B9F2CEF77
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Dec 2020 15:12:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5403E100EBBCC;
	Fri,  4 Dec 2020 06:12:08 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9C4E100ED4A0
	for <linux-nvdimm@lists.01.org>; Fri,  4 Dec 2020 06:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LGx56xgp9qjEXeA8lKWYnMftFHX6kuyyVNYMLfZB01A=; b=Zyyuhxpi2UUOsDhs4KncGUQE2N
	LnQKR4+15yLvhkybkc+5Sy0zpnZywGJ+FS7LMzvJ7ah3/bgHJfsa1IkT+nrFZ9UuZI21GNk/exMuW
	J55Bo60H5JzJR0gGdNtULhgHHCyLAUS4s+hKKFnuy55oqNtEqrsz4rcXea8a97Ifr1p9UYZ0LR9aD
	r4W/xYq6lr0GYfwQO4cGvhkfcvIHOmNRNKc0uT1RpYUmKae4V8gx8Nptbtd8C6It64yVFEpKmFGpt
	USNH8o5F/JfTANyjhUe/UdCkRY+2YMNUi/cyzLnfpFZXQvXqeGYuaLhA+EKK2OT6Py/f5Qj2w4iot
	asllIRyg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klBoR-0008Kl-NL; Fri, 04 Dec 2020 14:11:56 +0000
Date: Fri, 4 Dec 2020 14:11:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John David Anglin <dave.anglin@bell.net>
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
Message-ID: <20201204141155.GO11935@casper.infradead.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
 <20201204034843.GM11935@casper.infradead.org>
 <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
 <20201204124402.GN11935@casper.infradead.org>
 <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
Message-ID-Hash: RTCQKS2KRD74MKQA4CG3IBOKT4IGE3HM
X-Message-ID-Hash: RTCQKS2KRD74MKQA4CG3IBOKT4IGE3HM
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Helge Deller <deller@gmx.de>, James Bottomley <James.Bottomley@hansenpartnership.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTCQKS2KRD74MKQA4CG3IBOKT4IGE3HM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2020 at 08:28:47AM -0500, John David Anglin wrote:
> (.mlocate): page allocation failure: order:5, mode:0x40cc0(GFP_KERNEL|__G=
FP_COMP), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> =A0[<000000004035416c>] __kmalloc+0x5e4/0x740
> =A0[<00000000040ddbe8>] nfsd_reply_cache_init+0x1d0/0x360 [nfsd]

Oof, order 5.  Fortunately, that one was already fixed by commit
8c38b705b4f4ca4e7f9cc116141bc38391917c30.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
