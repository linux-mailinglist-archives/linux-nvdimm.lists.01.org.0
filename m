Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395A30C93B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 19:15:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C3862100EA2BD;
	Tue,  2 Feb 2021 10:15:17 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0763100EA2BC
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0+8razvFOQF0lS6CiOBgQgUcWVFkIsoX+gdB9DN1ClU=; b=pNl3Xj1mdOaJGg6BrCAQmSG7Yh
	xz2YE7gjLnfL+2/GiMGVjBPbhl+yAOvvb9WyejQVrN8ASA+sApTEgdMZq6SPqZhELIactT8GnHZBZ
	uIWRAL7abBYC1cEV/DH66sGw4D2Lopy0ffjVfSU2sL589ol0WjYdso9YEnZbAJgshi96MRmYIcN4T
	M7T5cXgp059iRV3fT/LBqwIz+iHcW+zMZezLX9zlniZYb6laU4PicbHSn8m5Ny2ZF0RvzrAL9dkie
	o4kQrizef23/6Gs5w98dW4KM1QAVnkE69Pi5hqMpkQpCWGf1lxQRjpzbA6D4cy+tAiHzgQAZHMNRj
	9bKuHTPQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l70Cf-00FZxS-Kf; Tue, 02 Feb 2021 18:15:06 +0000
Date: Tue, 2 Feb 2021 18:15:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 06/14] cxl/mem: Add basic IOCTL interface
Message-ID: <20210202181505.GF3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-7-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-7-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 3BE5X7EPJOLPQXZWZLZHPJHPJ2PNZYN2
X-Message-ID-Hash: 3BE5X7EPJOLPQXZWZLZHPJHPJ2PNZYN2
X-MailFrom: BATV+78410b086ab5a19d433c+6372+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3BE5X7EPJOLPQXZWZLZHPJHPJ2PNZYN2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +#if defined(__cplusplus)
> +extern "C" {
> +#endif

This has no business in a kernel header.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
