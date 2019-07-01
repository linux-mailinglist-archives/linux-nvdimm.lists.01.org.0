Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8A5C60B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 01:51:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36540212AAB88;
	Mon,  1 Jul 2019 16:51:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5855F2128D6BE
 for <linux-nvdimm@lists.01.org>; Mon,  1 Jul 2019 16:51:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net
 [73.223.200.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CACB21473;
 Mon,  1 Jul 2019 23:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562025112;
 bh=m49J8QUAIUGzLQ10Pk7MDlm3F9FEcvjOwjEaylX3Yg0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tEEn9+drzZeoB0fZ7R/AqFp9Wzc7N8ww7Vx902mD+h3w9UbMjzy9+UZPaIV+7VP8V
 NDsRCIHliWNtovAnQoKH8EnUvaYKwMZYlGBgh1p6MTymacyx+u8OdvNZ2Wd/9kx4jf
 Qr+rVz9DGogNzkjQgju1/GWOVyi6riVhx3LtcqkM=
Date: Mon, 1 Jul 2019 16:51:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm/nvdimm: Add is_ioremap_addr and use that to check
 ioremap address
Message-Id: <20190701165152.7a55299eb670b0ca326f24dd@linux-foundation.org>
In-Reply-To: <20190701134038.14165-1-aneesh.kumar@linux.ibm.com>
References: <20190701134038.14165-1-aneesh.kumar@linux.ibm.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon,  1 Jul 2019 19:10:38 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Architectures like powerpc use different address range to map ioremap
> and vmalloc range. The memunmap() check used by the nvdimm layer was
> wrongly using is_vmalloc_addr() to check for ioremap range which fails for
> ppc64. This result in ppc64 not freeing the ioremap mapping. The side effect
> of this is an unbind failure during module unload with papr_scm nvdimm driver

The patch applies to 5.1.  Does it need a Fixes: and a Cc:stable?

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
