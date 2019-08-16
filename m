Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15256909E0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 23:01:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CDA6202BB9AE;
	Fri, 16 Aug 2019 14:02:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 98527202B75F7
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:02:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net
 [73.223.200.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63B872133F;
 Fri, 16 Aug 2019 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565989258;
 bh=KfBZ36B394sYe7mkkVCgZdVU+aXcwatWWBVhiPlhweY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VlfOwai9UGWDt96zOxfmiJOjMKL4/lmTbJ7PqIEIxnyMIOfLWuddL1N3iELB68ZwV
 49+0YjcPaM+mIQShOMVbqE8qsPT2r00wphg3FQZt2qwvyLZ/Yx6Q/DttOKk3Qqky2X
 fWUsSZZOIVwzkbcSzs9cbFq2jWb0fV/fhH1SNQ88=
Date: Fri, 16 Aug 2019 14:00:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] memremap: provide a not device managed memremap_pages
Message-Id: <20190816140057.c1ab8b41b9bfff65b7ea83ba@linux-foundation.org>
In-Reply-To: <20190816065434.2129-5-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
 <20190816065434.2129-5-hch@lst.de>
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

On Fri, 16 Aug 2019 08:54:34 +0200 Christoph Hellwig <hch@lst.de> wrote:

> The kvmppc ultravisor code wants a device private memory pool that is
> system wide and not attached to a device.  Instead of faking up one
> provide a low-level memremap_pages for it.  Note that this function is
> not exported, and doesn't have a cleanup routine associated with it to
> discourage use from more driver like users.

Confused. Which function is "not exported"?

> +EXPORT_SYMBOL_GPL(memunmap_pages);
> +EXPORT_SYMBOL_GPL(memremap_pages);
>  EXPORT_SYMBOL_GPL(devm_memremap_pages);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
