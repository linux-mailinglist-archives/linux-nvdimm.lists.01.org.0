Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D5E10F5ED
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Dec 2019 04:51:24 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E921610113667;
	Mon,  2 Dec 2019 19:54:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 442E61011363F
	for <linux-nvdimm@lists.01.org>; Mon,  2 Dec 2019 19:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=BbBVtzqyLX3V7hQkcfe1XWeHTgk9SApN2HtkYlUf5aM=; b=bIgrpTpW8FbPSaXgqF6UMLN3M
	FUeoNypzpw8d++tw9PLJCtSF4gX4MIuuHVX+IQT2GCK0DZjpMznuyyeM1+Zxd5lc5RBihefQ7vvwK
	JAXmDbeI1mhUPdzyaz7RmJ7n/+4qtwnZ9pJxVPC6jU8v/Iao1OSOQ7wQwMb4qzXBHM6wCX+1WhsKC
	+Go4rZvKK+5B00Jwf9Vlw0B7QWYr0QY9RcV9R7h3JVMtHtGkivfdctbkU63lulo71u4yw5DLtRbbD
	jsdxBbYcdlGSEX82rXZYAvEDW52Lw71QJfxzNB5Tr39ypmEfzKNLJhDVdKt82zsotUR75abVgqFzj
	hRST76cUw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibzDF-00056D-TP; Tue, 03 Dec 2019 03:50:57 +0000
Date: Mon, 2 Dec 2019 19:50:57 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
Message-ID: <20191203035057.GR20752@bombadil.infradead.org>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203034655.51561-1-alastair@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Message-ID-Hash: QTLGHCMSSLFQZFJFYGIHFKSAKUM3EEZA
X-Message-ID-Hash: QTLGHCMSSLFQZFJFYGIHFKSAKUM3EEZA
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.or
 g, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QTLGHCMSSLFQZFJFYGIHFKSAKUM3EEZA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 03, 2019 at 02:46:28PM +1100, Alastair D'Silva wrote:
> This series adds support for OpenCAPI SCM devices, exposing

Could we _not_ introduce yet another term for persistent memory?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
