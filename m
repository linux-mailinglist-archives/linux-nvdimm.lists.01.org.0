Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8185196AB6
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Mar 2020 04:57:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CADF1003E9A2;
	Sat, 28 Mar 2020 19:58:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 348C110097DFC
	for <linux-nvdimm@lists.01.org>; Sat, 28 Mar 2020 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4yXTPf18akGL4F1+3ogioOkX9iKPvYO8hyOrfJXVtE8=; b=JQUR5R0lE7xi/bwp2+wCOJ6n+2
	jr/hNpXfA6Sap1y57jeS+TIIvZ50P9Y0zhfobUFlky6zEHnrl36iUVGituZcetweLxImlDgR+0iir
	d3QCGnZfRnPVOSoC/nsRLR2bhPsiB+W2w8sFoZ77juMrW4OGkTFvQUvqhPA08FEK7I5Eg97c5tGib
	Zw7dB5t65kxfGeoY0SAo/6dRwhdi9zSLhZhYeBRJ2LSRPBWI8gvyMpqmHcCHQ0sWsQbZXQvsWH/mT
	6hETfSx0PyDhWRS+X/9G+thvPoa8q1ZMjK5EVIvLqln8TC7mmm8ZUKLOFxK9rhl7dENKu5keZOLVK
	thM8OiZQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIO7V-00020F-KY; Sun, 29 Mar 2020 02:56:17 +0000
Date: Sat, 28 Mar 2020 19:56:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH v4 10/25] nvdimm: Add driver for OpenCAPI Persistent
 Memory
Message-ID: <20200329025617.GT22483@bombadil.infradead.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
 <20200327071202.2159885-11-alastair@d-silva.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327071202.2159885-11-alastair@d-silva.org>
Message-ID-Hash: OMAM7VO27TFDUTUYDHWGHB2TI5L3MC7P
X-Message-ID-Hash: OMAM7VO27TFDUTUYDHWGHB2TI5L3MC7P
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
 , linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OMAM7VO27TFDUTUYDHWGHB2TI5L3MC7P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 27, 2020 at 06:11:47PM +1100, Alastair D'Silva wrote:
> +static struct mutex minors_idr_lock;
> +static struct idr minors_idr;
...
> +	mutex_lock(&minors_idr_lock);
> +	minor = idr_alloc(&minors_idr, ocxlpmem, 0, NUM_MINORS, GFP_KERNEL);
> +	mutex_unlock(&minors_idr_lock);
...
> +	mutex_lock(&minors_idr_lock);
> +	idr_remove(&minors_idr, MINOR(ocxlpmem->dev.devt));
> +	mutex_unlock(&minors_idr_lock);
...
> +	mutex_init(&minors_idr_lock);
> +	idr_init(&minors_idr);

Unless you look up ocxlpmem by minor number later in the patch series (and
most of the series didn't make it to my mailbox), this can just be an ida.

static DEFINE_IDA(minors);
...
minor = ida_alloc_max(&minors, NUM_MINORS, GFP_KERNEL);
...
ida_free(&minors, MINOR(ocxlpmem->dev.devt));
...
and you can drop the dynamic initialisation.  And the mutex.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
