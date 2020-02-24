Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D3169D0F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 05:38:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFF5710FC3409;
	Sun, 23 Feb 2020 20:39:09 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97EC710FC3408
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 20:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3x72YyawiT+qy2td7cpd28NQAFlPEu7/enza7D57Et4=; b=YnvgoyzDCY7RY0g+SAmg6beiS+
	ZxADpTEUvAfco3MMCmW2+jIaN/5jUoEeRSOth35TpB+zO89Nd7QPAmtF2tNA/5EFvRTI9ASvQcBTZ
	S811CVIJn5Z61wJcKTnhjULCopl2lMpaSlzG2P209wiZEz/A4Gm838o9rSt3ju0q2HheM9nKP4mwL
	sSEZtCJCAJ7JPsGeqB8JwK5p9p7gNig9e5CVSjRUtjtyQEmC0+lm94GK1srxAlmp3xhmuFWhvlKza
	4AdO6LBTv4ODP59vG9o46FZE4VeF7HplPeIie846DiECSHQO8R6h7xmOIHsbX+UXWR4GxVCf9P//M
	Y1y1PXqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j65V8-0001aO-Bq; Mon, 24 Feb 2020 04:37:50 +0000
Date: Sun, 23 Feb 2020 20:37:50 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory
 devices
Message-ID: <20200224043750.GM24185@bombadil.infradead.org>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
Message-ID-Hash: H62A2UHCMOAEPRCWMJVVWX7WP5ECSRKJ
X-Message-ID-Hash: H62A2UHCMOAEPRCWMJVVWX7WP5ECSRKJ
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
 , Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H62A2UHCMOAEPRCWMJVVWX7WP5ECSRKJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> V3:
>   - Rebase against next/next-20200220
>   - Move driver to arch/powerpc/platforms/powernv, we now expect this
>     driver to go upstream via the powerpc tree

That's rather the opposite direction of normal; mostly drivers live under
drivers/ and not in arch/.  It's easier for drivers to get overlooked
when doing tree-wide changes if they're hiding.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
