Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C892310FDEB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 13:43:07 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9363F101134ED;
	Tue,  3 Dec 2019 04:46:28 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54FC0101134EA
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=y32EyG9QTIAAfBfEpUvYlhT+mcWXafYYc7fjM/sPObM=; b=m8Z9EA16p0cdhP5aXa2cDeouD
	8v18exxvbDL2VZ+g12YOFJL8h4D64m1aUWCjUztX9coGysKzDNmS82ECczmiSSugoSgZ9I8fL9733
	yByR1W4OgWm9Ji+79sSU19wUMIbaL9vhWILbJzqBWIYJTITSALTfX8PQqTR6ncq9isowfjM5tK81V
	DhgMGFKKI5B5HnMtJhJFcrzkzezv2TLmE+jL2cmZiZL0voqrqklRcOy//ON418iZSdT3QArUEvbuM
	ATlvjkn6wfb7OXS8n+w6/tzVdX7N06vOEiLtYT8y+Qz025I88HodvPHRaxMl+zkd3oThPgqxf9AOL
	VUr5RTx1g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic7Vo-0007i6-VW; Tue, 03 Dec 2019 12:42:40 +0000
Date: Tue, 3 Dec 2019 04:42:40 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
Message-ID: <20191203124240.GT20752@bombadil.infradead.org>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203035057.GR20752@bombadil.infradead.org>
 <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Message-ID-Hash: 5557RBDJ35KZBAJWSG4GX7OQLBQ3ELDM
X-Message-ID-Hash: 5557RBDJ35KZBAJWSG4GX7OQLBQ3ELDM
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.
 ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5557RBDJ35KZBAJWSG4GX7OQLBQ3ELDM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 03, 2019 at 03:01:17PM +1100, Alastair D'Silva wrote:
> On Mon, 2019-12-02 at 19:50 -0800, Matthew Wilcox wrote:
> > On Tue, Dec 03, 2019 at 02:46:28PM +1100, Alastair D'Silva wrote:
> > > This series adds support for OpenCAPI SCM devices, exposing
> > 
> > Could we _not_ introduce yet another term for persistent memory?
> > 
> 
> "Storage Class Memory" is an industry wide term, and is used repeatedly
> in the device specifications. It's not something that has been pulled
> out of thin air.

"Somebody else also wrote down Storage Class Memory".  Don't care.
Google gets 750k hits for Persistent Memory and 150k hits for
Storage Class Memory.  This term lost.

> The term is also already in use within the 'papr_scm' driver.

The acronym "SCM" is already in use.  Socket Control Messages go back
to early Unix (SCM_RIGHTS, SCM_CREDENTIALS, etc).  Really, you're just
making the case that IBM already uses the term SCM.  You should stop.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
