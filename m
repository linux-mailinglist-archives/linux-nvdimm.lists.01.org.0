Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAAD30ED17
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 08:17:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E161100EAB01;
	Wed,  3 Feb 2021 23:17:02 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+5218da1eca3c543fccff+6374+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9D75100EAB5F
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 23:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QgfWxu4yt82JE/xIZ7oOgqgnaPHBT7dbTPo6JkGjbSA=; b=lwT7az+6ZMRVD6pMMGQeUxcGkz
	3sALDZXQnzoZAsV22q0sZB+6S/aKedsLuXCbgPrJ755mQQeczFZ3/OkCvIZaNAN1CpijxKmBvg872
	5+Dzv3/TXvRgYoYNI0fwjsd4wWwnvgiaKGwtH43/d+PMeW2C+pFw4V1KjDNnustdp1/7uD2knEK1p
	2ZqTmGENdZcvywP7ZnZSFdo+Azf3/Gieg5+M1xCdPooxSra5JG9Qe7BFX4IkCr0LbJeKyz0MJpxrd
	+rtljPjDSwGZkFQlZuyQQvP7Q0B3B0RBBv9nwpXRaHVzScnSqM6y4b/tUsWT6n88kcKSdYQvEM7nk
	s5pqCAlg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l7Ysg-000W3O-9s; Thu, 04 Feb 2021 07:16:46 +0000
Date: Thu, 4 Feb 2021 07:16:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210204071646.GA122880@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <20210202181016.GD3708021@infradead.org>
 <20210202182418.3wyxnm6rqeoeclu2@intel.com>
 <20210203171534.GB4104698@infradead.org>
 <20210203172342.fpn5vm4xj2xwh6fq@intel.com>
 <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hvFjs=QqmUYqPipuaLoFiZ-dr6qVhqbDupWuKTw3QDkg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: GWZ4EWSWCNS6VLTZ3K3TYGP5HNLEVTG5
X-Message-ID-Hash: GWZ4EWSWCNS6VLTZ3K3TYGP5HNLEVTG5
X-MailFrom: BATV+5218da1eca3c543fccff+6374+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GWZ4EWSWCNS6VLTZ3K3TYGP5HNLEVTG5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 03, 2021 at 01:23:31PM -0800, Dan Williams wrote:
> > I'd prefer to keep the helpers for now as I do find them helpful, and so far
> > nobody else who has touched the code has complained. If you feel strongly, I
> > will change it.
> 
> After seeing the options, I think I'd prefer to not have to worry what
> extra magic is happening with cxl_read_mbox_reg32()
> 
> cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> 
> readl(cxlm->mbox_regs + CXLDEV_MB_CAPS_OFFSET);
> 
> The latter is both shorter and more idiomatic.

Same here.  That being said I know some driver maintainers like
wrappers, my real main irk was the macro magic to generate them.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
