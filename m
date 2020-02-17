Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B21613AB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:38:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C57310FC3537;
	Mon, 17 Feb 2020 05:41:28 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A47810FC341B
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6JduFHaGXL6ZuUJZD2z7J2KoISh0UFSCSqAsPWSzYK8=; b=WcToiemT9OwiY1JVONw87kYRgg
	X5bvNrZQCaBXL0cJztVNL6JdmzJgQQ0Kx2v1BzlHKuy2ZGQNS9dLRCgp/Y81iiX1BUJhj/TndRTS0
	lgq/rcNlgk8h4ez5IDuX1CgYpr6OShWYd6vHS+LXIdkL9x1h7RMrD8shn20i+ophyXl98cosFpBxq
	CLlCtncouXaYUGS4wIwPozUAjCWkJv0fmjsb6Hm3PffYgmgsEb1v7+CktaJ+PR3ydgoPRUxYKkpna
	rQutu0bPqSZujsZtAInJ26K+UEP3OlzqAZSHSfiiav5faBiiG49Jh69tU77ZxfEJ4h+M28XS147F+
	xtm/+fgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gap-0002YG-Fr; Mon, 17 Feb 2020 13:37:47 +0000
Date: Mon, 17 Feb 2020 05:37:47 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/6] dax: Define a helper dax_pgoff() which takes in
 dax_offset as argument
Message-ID: <20200217133747.GJ7778@bombadil.infradead.org>
References: <20200212170733.8092-1-vgoyal@redhat.com>
 <20200212170733.8092-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212170733.8092-2-vgoyal@redhat.com>
Message-ID-Hash: A35NDGADPHSFJPLPQOIKSNWFEGN5YSZT
X-Message-ID-Hash: A35NDGADPHSFJPLPQOIKSNWFEGN5YSZT
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A35NDGADPHSFJPLPQOIKSNWFEGN5YSZT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2020 at 12:07:28PM -0500, Vivek Goyal wrote:
> +int dax_pgoff(sector_t dax_offset, sector_t sector, size_t size, pgoff_t *pgoff)
> +{
> +	phys_addr_t phys_off = (dax_offset + sector) * 512;
> +
> +	if (pgoff)
> +		*pgoff = PHYS_PFN(phys_off);
> +	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +		return -EINVAL;
> +	return 0;

This is why we have IS_ERR_VALUE().  Just make this function return
a pgoff_t.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
