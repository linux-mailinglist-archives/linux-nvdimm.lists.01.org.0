Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49212FD9EF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 20:47:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BA45100EB84B;
	Wed, 20 Jan 2021 11:47:33 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+dcef5ab2ace0ac473575+6359+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02F4F100EBB8F
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 11:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YO65qeuBlA/Px+uGMMtu2IuI+NS6eKWvr/uQdksGWHk=; b=ZYDNsDliyOykuxcU6CwW9AORNj
	ZzPzRXjpZ4vAseB9D1pGl/v+qNQQTd9OgLgVGnHxs0IYXMTzdUFNoY/83XdgFLMYKqtwmYsmLC+3N
	T8ti0RrUuYHx2n6d4EuFca1Ny+AQ7fARvLk6EMdX6h4B8tNVxPDxZO9+2OkFRY1Lr8OpckAc1obUt
	GBEOaH+rkalJhuHqexjqMEZtLgE13JQawomCk9KlSJ219bLbR0L/jJ4R12Uc1Qvz3upn0DrXGT5xI
	XQXV9cwjphk57JfdCHXtQpPNSpTWWXpVO2R3u71K4dQ1ezoik1ozlEivZlaBKTR4VpOkyF2vfCCrE
	upz1ZNAA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2JQf-00G8fi-Js; Wed, 20 Jan 2021 19:46:15 +0000
Date: Wed, 20 Jan 2021 19:46:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
Message-ID: <20210120194609.GA3843758@infradead.org>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: SSSJDLQWGCQYQSMCG7GUV7ENM3L6YQDJ
X-Message-ID-Hash: SSSJDLQWGCQYQSMCG7GUV7ENM3L6YQDJ
X-MailFrom: BATV+dcef5ab2ace0ac473575+6359+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: gregkh@linuxfoundation.org, logang@deltatee.com, Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SSSJDLQWGCQYQSMCG7GUV7ENM3L6YQDJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The subject doesn't make any sense to me.

But thn again queued sound really weird.  You just have a managed
API with a refcount and synchronization, right?

procfs and debugfs already support these kind of managed ops, kinda sad
to duplicate this concept yet another time.

> +static long cdev_queued_ioctl(struct file *file, unsigned int cmd, unsigned long arg)

Overly long line.

> +__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
> +					dev_t dev, unsigned count,
> +					const struct cdev_operations *qops)
> +{
> +	int rc;
> +
> +	if (!qops->ioctl || !owner)
> +		return -EINVAL;

Why is the ioctl method mandatory?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
