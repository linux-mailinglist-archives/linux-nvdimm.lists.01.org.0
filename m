Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEF16621C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 17:17:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D73B10FC35BE;
	Thu, 20 Feb 2020 08:18:28 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+d8ceb162cb84e4d8f427+6024+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C935A10FC35BE
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q6BSWjM65+xsI6RMc+4ahg0/DV1eL9zz/PZWUf5jLtY=; b=dcHiV43sjKmZrUNsXebdzPuUQl
	mlPFSTKgiaSvfuhuGidj/lmSot9z4loj/Lqce7qkL8BrWqT9g+ExQr5HDOkFhg6mNsWr6/vzG4HdI
	ArHYKYCMnonmJKis3eCd7+z7BouVVz4q8lgMjmn7VdW4NcAoruXu29VoAKtwJ4AAHMD6IeRvEtJtJ
	mEwKozwa87eKYd8wsKnRrUPd49vkdmeCV1cv/CfSEIlfTcC8hXSubYbJoz8/+vhC6vEbF1ybcr1cS
	NJwmzL3GKQN0kmLxYtHRozpEAwPDi1Poy9GWuvTZ1zmW+9pkiRO9PFmDYDX8EDVvh48O2ACmIBMNs
	kF1Rcrsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4oW4-0008HH-K2; Thu, 20 Feb 2020 16:17:32 +0000
Date: Thu, 20 Feb 2020 08:17:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 3/8] pmem: Enable pmem_do_write() to deal with
 arbitrary ranges
Message-ID: <20200220161732.GB31606@infradead.org>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218214841.10076-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: ZU4AAOBXAGMQ3KLF43IFEX3O6H6ATOZK
X-Message-ID-Hash: ZU4AAOBXAGMQ3KLF43IFEX3O6H6ATOZK
X-MailFrom: BATV+d8ceb162cb84e4d8f427+6024+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZU4AAOBXAGMQ3KLF43IFEX3O6H6ATOZK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 04:48:36PM -0500, Vivek Goyal wrote:
> Currently pmem_do_write() is written with assumption that all I/O is
> sector aligned. Soon I want to use this function in zero_page_range()
> where range passed in does not have to be sector aligned.
> 
> Modify this function to be able to deal with an arbitrary range. Which
> is specified by pmem_off and len.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
