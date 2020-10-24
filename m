Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4E297B6A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Oct 2020 10:19:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9F9115E58C22;
	Sat, 24 Oct 2020 01:19:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+e363d8ba4ad667775814+6271+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 524771639A156
	for <linux-nvdimm@lists.01.org>; Sat, 24 Oct 2020 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=mxlZbLyfTc89MkEIeN5/d3Y+Ll
	xIkxDswsxqzUWAvtlVfj3HTfroGog8s381TwUy1oVuaeQmJarql6VironVSRddymvlIifKld/T6i9
	I+luXUdidxW+45Bpd9U3BuiApJv/WvXkMJ67ibdLiZmeuct4jqGBaAZxDXz8qn7c2Hhv+VgKnUJLw
	kmBLsC8rW5JmT+rdHjvrMSFzOFiCaHffq1BZfu+yKu7eijy63j10h+0J1b/M7HZvGltiHxaJOHmX6
	mcbL7nnnljVEO5i4ZggQTp832va69Qj9ICGt/iroiAm9Cv6+/UBgbMeHk8ixhZ2R3ulVQkGjdrsvP
	SLjUI5wA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWEle-0002hB-LK; Sat, 24 Oct 2020 08:19:14 +0000
Date: Sat, 24 Oct 2020 09:19:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
Message-ID: <20201024081914.GA10244@infradead.org>
References: <20201023183222.13186-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201023183222.13186-1-rcampbell@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: MHXIUYI6RJ7FN55X7SOL6M5JWJANS5UM
X-Message-ID-Hash: MHXIUYI6RJ7FN55X7SOL6M5JWJANS5UM
X-MailFrom: BATV+e363d8ba4ad667775814+6271+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Ira@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MHXIUYI6RJ7FN55X7SOL6M5JWJANS5UM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
