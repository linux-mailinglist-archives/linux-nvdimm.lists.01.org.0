Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 520BAE58DC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 26 Oct 2019 08:44:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D11C100EA602;
	Fri, 25 Oct 2019 23:45:16 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+332c21a18e206945ff7a+5907+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0434E100EA601
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=aiPSd/BZaq8mZvPjuhE4XI65j8OE7xLRgVlrgYKV6X8=; b=F/jZojJuWlmtYwiabWSCN61UA
	DJTL0DKDCRX7BN+qAIbWIW+jalp4XIg7RqqpMFKWAIL/mWu2jghSkj2qPCYYZZVTynp1AhxZlzMEC
	5CEaqn3UkS8suk+1IHtm1KeugWS7ohi18uMi3TB0S0K3ZNPNhjoJ1Gm4ryl+MZGrz8gt2FoEI0OSM
	nCEY4LXt4xg21LC0vJk1U/1WBysEfj1A2GnytuxvgI++Gagou1GrLIdA1ILFw5rHWoVVLkycXCmiN
	V8HiJ0HsLPFP6ZVtquvpFwy1vmdAy8v/83zH4KWCrK7ER1LJoSDlG2R/9bTULsTpS2qWJ6BCIFVtn
	CDN4nubow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOFnR-0007qU-Gs; Sat, 26 Oct 2019 06:43:33 +0000
Date: Fri, 25 Oct 2019 23:43:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the
 generic OCXL driver
Message-ID: <20191026064333.GA24422@infradead.org>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-11-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191025044721.16617-11-alastair@au1.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: YDXOEHORZGXHGIUX3BHX7KRSBKYRXXDL
X-Message-ID-Hash: YDXOEHORZGXHGIUX3BHX7KRSBKYRXXDL
X-MailFrom: BATV+332c21a18e206945ff7a+5907+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Allison Randal <allison@lohutok.net>, David Gibson <david@gibson.dropbear.id.au>, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kern
 el.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YDXOEHORZGXHGIUX3BHX7KRSBKYRXXDL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 25, 2019 at 03:47:05PM +1100, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch allows the user to bind OpenCAPI SCM devices to the generic OCXL
> driver.

This completely misses any explanation of why you'd want that.  The
what is rather obvious from the patch.

> +config OCXL_SCM_GENERIC
> +	bool "Treat OpenCAPI Storage Class Memory as a generic OpenCAPI device"
> +	default n

n is the default default.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
