Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA64909E6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 23:01:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5851C202E8419;
	Fri, 16 Aug 2019 14:03:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 22800202BB9AE
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:03:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net
 [73.223.200.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28D7C2133F;
 Fri, 16 Aug 2019 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565989295;
 bh=MxoPEBdUgeGG8r1YMtqWjR43bDHROWKuxhhQbv0Dyd4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=V+taPJeoXoU39dnw4eLkWys2oiJYLOa4Kz30m61AGUDeqfuWPigLu5mtk/NBZ4EVe
 B+vgjZJsohmFph06ZE175qMwGCufq9Lz2dwY9FU1nW8Qnmq5y54FKkcs3RmSkO7pGl
 B5jzTM/MEaZDZcmqg90IE5o1Sx27v/d00qBxFkww=
Date: Fri, 16 Aug 2019 14:01:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] resource: add a not device managed
 request_free_mem_region variant
Message-Id: <20190816140134.1f3225bed9bf2734c03341b1@linux-foundation.org>
In-Reply-To: <20190816065434.2129-2-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
 <20190816065434.2129-2-hch@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 16 Aug 2019 08:54:31 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Just add a simple macro that passes a NULL dev argument to
> dev_request_free_mem_region, and call request_mem_region in the
> function for that particular case.

Nit:

> +struct resource *request_free_mem_region(struct resource *base,
> +		unsigned long size, const char *name);

This isn't a macro ;)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
