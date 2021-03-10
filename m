Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C291333D33
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 14:02:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8053100EB32F;
	Wed, 10 Mar 2021 05:02:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68A49100EB32D
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ALr5iWDNLGdU3HVoDSzUHGSO+jgvXP9RVBf6+KXFgYU=; b=G03GxTkrZ0HvyN9TVTTGv9fFLu
	gglr3sTaBNVnfJtIdTSSB3LxjkuAQCN2m8iNAGscB85rKFvB+BNOo0fcOeMhm6uSOC32XSEbiHq8C
	pqA92+K31BjmkI5VQ4CKOtGV0af3hjaG+wyN5nnEIbT1f4dhM5s114qtLSudoKjXcF4vjuLaUUQuW
	PBedOIBQUD58iR43kVmEiEOTxom08dYlGj2BYh9vMwA+ltYAI5zuIhaV6NSnijO6ClL59uCl0bJTl
	iwWyJUrreoI1HR6Nn9PaGnXWN98KC9HTZzq/VQTuGCX7GPBlPOIRxLVlfNfcjMjnM+7KQ62pgaidJ
	hsNHYh/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lJyTr-003TrT-Va; Wed, 10 Mar 2021 13:02:28 +0000
Date: Wed, 10 Mar 2021 13:02:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310130227.GN3479805@casper.infradead.org>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
Message-ID-Hash: 7TEWQX27HQRPGKLVLZGYX2C6PH237GHF
X-Message-ID-Hash: 7TEWQX27HQRPGKLVLZGYX2C6PH237GHF
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7TEWQX27HQRPGKLVLZGYX2C6PH237GHF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> Forgive my ignorance, but is there a reason why this isn't wired up to
> Btrfs at the same time? It seems weird to me that adding a feature

btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.

If you think about it, btrfs and DAX are diametrically opposite things.
DAX is about giving raw access to the hardware.  btrfs is about offering
extra value (RAID, checksums, ...), none of which can be done if the
filesystem isn't in the read/write path.

That's why there's no DAX support in btrfs.  If you want DAX, you have
to give up all the features you like in btrfs.  So you may as well use
a different filesystem.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
