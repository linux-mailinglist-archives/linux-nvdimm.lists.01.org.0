Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB2BFB65
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Sep 2019 00:45:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB64721967BC5;
	Thu, 26 Sep 2019 15:47:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5771B2010BCBC
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 15:47:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0F33207E0;
 Thu, 26 Sep 2019 22:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569537908;
 bh=rQC3J8EPwzkHKWjOg8mvpEytGCu5pe1CrK00J5y86/I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PXvulo9Fu5ero0Z/ID0ePs5iVDl9ix284AJhH+ldQuSxyxoK6ed2yrgHTpKFmqrrU
 4Q5XkaHWMvQ/NRvbKoNRWlKYMcW/KAq470h5mVAUlgN9hl4t2JOdLm3KZcnFwQzYyI
 ntxKH5qMSbx3V4AvMoxU13ndZpwmM5sEUKNJ04gc=
Date: Thu, 26 Sep 2019 15:45:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm/memunmap: Use the correct start and end pfn when
 removing pages from zone
Message-Id: <20190926154508.3dba3dc398b7bb9a40ba15da@linux-foundation.org>
In-Reply-To: <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
References: <20190830091428.18399-1-david@redhat.com>
 <20190926122552.17905-1-aneesh.kumar@linux.ibm.com>
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
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org,
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 26 Sep 2019 17:55:51 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> With altmap, all the resource pfns are not initialized. While initializing
> pfn, altmap reserve space is skipped. Hence when removing pfn from zone skip
> pfns that were never initialized.
> 
> Update memunmap_pages to calculate start and end pfn based on altmap
> values. This fixes a kernel crash that is observed when destroying namespace.
> 
> [   74.745056] BUG: Unable to handle kernel data access at 0xc00c000001400000
> [   74.745256] Faulting instruction address: 0xc0000000000b58b0
> cpu 0x2: Vector: 300 (Data Access) at [c00000026ea93580]
>     pc: c0000000000b58b0: memset+0x68/0x104
>     lr: c0000000003eb008: page_init_poison+0x38/0x50
>     ...
>   current = 0xc000000271c67d80
>   paca    = 0xc00000003fffd680   irqmask: 0x03   irq_happened: 0x01
>     pid   = 3665, comm = ndctl
> [link register   ] c0000000003eb008 page_init_poison+0x38/0x50
> [c00000026ea93830] c0000000004754d4 remove_pfn_range_from_zone+0x64/0x3e0
> [c00000026ea938a0] c0000000004b8a60 memunmap_pages+0x300/0x400
> [c00000026ea93930] c0000000009e32a0 devm_action_release+0x30/0x50

Doesn't apply to mainline or -next.  Which tree is this against?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
