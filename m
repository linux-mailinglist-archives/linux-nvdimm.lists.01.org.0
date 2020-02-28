Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93517395A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 15:05:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B32810FC36E5;
	Fri, 28 Feb 2020 06:06:09 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+961d4909b86d2e9c90d3+6032+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98BAD10FC36E4
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l/9vD4kWJ5DgSyvKhFv1tb5oLOTsgXLSNIzvAAdRX2o=; b=mtQ9sSvzCTY3BgpfOC5D6cHQFZ
	Ixh2Tv/4gk5gFcBys/QcmXPiA5puZzBqBTeFRuaSaH9QNSl0CfAglRw6bNLx6AhO7qlQlH957/HD6
	HM0yj+eoyohvvRCiPJYQqJWZABZeaoIgzGoT8oK1uBJSrUjBGRXGgJDcuyyxFISQGu0lsQukeM5/4
	GLt4ahZoIPPu7FbZqDZ12B/QLmJAxu3kS6CLYe1V0/Shv7FP6vb8SJfCGT0WrmWMLoe5Cd1+J4lcY
	UAGcWqH+e1nEcznk5WKgMdVW6DkCturcBrWQ1BrsKa7ai3BQXloxASvhwdD8ZZkDDocxBjmYONzzP
	80DEcfqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7gGK-00048K-IE; Fri, 28 Feb 2020 14:05:08 +0000
Date: Fri, 28 Feb 2020 06:05:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200228140508.GA2987@infradead.org>
References: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
 <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com>
 <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area>
 <20200224153844.GB14651@redhat.com>
 <20200227030248.GG10737@dread.disaster.area>
 <CAPcyv4gTSb-xZ2k938HxQeAXATvGg1aSkEGPfrzeQAz9idkgzQ@mail.gmail.com>
 <20200228013054.GO10737@dread.disaster.area>
 <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4i2vjUGrwaRsjp1-L0wFf0a00e46F-SUbocQBkiQ3M1kg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: RLF6LFUXMGABRK6AEEQU7OYNG5U4YJLV
X-Message-ID-Hash: RLF6LFUXMGABRK6AEEQU7OYNG5U4YJLV
X-MailFrom: BATV+961d4909b86d2e9c90d3+6032+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RLF6LFUXMGABRK6AEEQU7OYNG5U4YJLV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2020 at 07:28:41PM -0800, Dan Williams wrote:
> "don't perform generic memory-error-handling, there's an fs that owns
> this daxdev and wants to disposition errors". The fs/dax.c
> infrastructure that sets up ->index and ->mapping would still need to
> be there for ext4 until its ready to take on the same responsibility.
> Last I checked the ext4 reverse mapping implementation was not as
> capable as XFS. This goes back to why the initial design avoided
> relying on not universally available / stable reverse-mapping
> facilities and opted for extending the generic mm/memory-failure.c
> implementation.

The important but is that we stop using ->index and ->mapping when XFS
is used as that enables using DAX+reflinks, which actually is the most
requested DAX feature on XFS (way more than silly runtime flag switches
for example).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
