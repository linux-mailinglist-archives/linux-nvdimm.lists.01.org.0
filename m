Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5402F25410A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 10:39:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD08F1257EAB4;
	Thu, 27 Aug 2020 01:39:57 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA0C01257EAB0
	for <linux-nvdimm@lists.01.org>; Thu, 27 Aug 2020 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M2uZojDOOMLE39hrWQtfZ22Q97aL3ayjlw6wCDd+LVA=; b=ddjam0kF1zHBRftbdmXZA7oFBW
	n0D78lJ9zlPjJpIO3e/IRxadnz2vaOXh/2TnZGn1SuTFJeFzyTlk2+4pfs16OyfnRDI6LIahc4Wz0
	CHzRhQoo11OCyDgC6qRONa9DaG5Li8strlXlG7Db8CCU4RJV6X1Iz6ddHjNrSAqXi0r3y/1ZZI2aS
	eiQHcv5MqVH8DLlLPDi8ccqYWnZD6hJbv/z5sFxMM1im+qiuZckEjcWDrqZOiS3PRncA7icaD59sP
	z2hvnmJOn+mGFj3Fti+niOFAKnNLqPvE/5xvbx2tZCl0Q3GY5fnM3BAFxO1UwIOH1f8LlTgktGLvT
	HuAxgdlA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBDRl-00040W-CS; Thu, 27 Aug 2020 08:39:49 +0000
Date: Thu, 27 Aug 2020 09:39:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 9/9] iomap: Change calling convention for zeroing
Message-ID: <20200827083949.GE11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-10-willy@infradead.org>
 <20200825222355.GL6096@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825222355.GL6096@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: VQ74AFIXHPOWLXH5KSJKLX27FRUHQUBR
X-Message-ID-Hash: VQ74AFIXHPOWLXH5KSJKLX27FRUHQUBR
X-MailFrom: BATV+811462fdb5f870f212f0+6213+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VQ74AFIXHPOWLXH5KSJKLX27FRUHQUBR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2020 at 03:23:55PM -0700, Darrick J. Wong wrote:
> Sorry for my ultra-slow response to this.  The u64 length seems ok to me
> (or uint64_t, I don't care all /that/ much), but using loff_t as a
> return type bothers me because I see that and think that this function
> is returning a new file offset, e.g. (pos + number of bytes zeroed).
> 
> So please, let's use s64 or something that isn't so misleading.
> 
> FWIW, Linus also[0] doesn't[1] like using loff_t for the number of bytes
> copied.

Let's just switch to u64 and s64 then.  Unless we want to come up with
our own typedefs.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
