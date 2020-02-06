Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE23153F54
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 08:41:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 754DB10FC3400;
	Wed,  5 Feb 2020 23:45:03 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+77e6982e77fa0b5443e9+6010+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DDD410FC33FC
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 23:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v4sgkrFRRT25twWgnublfu8qExfh0axFqZunM0WK1gU=; b=VgB0OvYzeVchVCoUP2+LkP98Af
	3gMHK/5aS3eJ9KoukvYbk0b+nJBmaQL0QEgbGs+sO1cvP4oI5Ri9bKwsrJ6vf+hBo3LPHbxWxAvu2
	gRH39qOT2jLoKfq07rUO1RbeqRLzlAtRH1fV0dNtb7yohuHMpjKTSHehAF4a0oATh8lBJBRzYPKPW
	qeFSYYoXUha5yEWdNry31aDBGq2gXAf/nsjqK4HIRB3kY8KGGdHNaMK4+yKInYQhJlUzmxJ9w2eTJ
	Olrj/7qfs0xImdjcLa68RWZrnWg2DXT60LDktCtjG8ENas/72pvNyvWuzG3B33T7nHx+E48YuJmry
	jZTSCkPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izbnC-0001q3-Tg; Thu, 06 Feb 2020 07:41:42 +0000
Date: Wed, 5 Feb 2020 23:41:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200206074142.GB28365@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: LQP5BALS4V7QEUXCBQOOZISAYGRIZDY4
X-Message-ID-Hash: LQP5BALS4V7QEUXCBQOOZISAYGRIZDY4
X-MailFrom: BATV+77e6982e77fa0b5443e9+6010+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQP5BALS4V7QEUXCBQOOZISAYGRIZDY4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > will make changes.
> 
> The problem is device-mapper. That wants to use offset to route
> through the map to the leaf device. If it weren't for the firmware
> communication requirement you could do:
> 
> dax_direct_access(...)
> generic_dax_zero_page_range(...)
> 
> ...but as long as the firmware error clearing path is required I think
> we need to do pass the pgoff through the interface and do the pgoff to
> virt / phys translation inside the ops handler.

Maybe phys_addr_t was the wrong type - but why do we split the offset
into the block device argument into a pgoff and offset into page instead
of a single 64-bit value?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
