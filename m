Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311C374B49
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:34:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EE6A100F2253;
	Wed,  5 May 2021 15:34:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF56B100EB85D
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:34:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so5263777ejc.10
        for <linux-nvdimm@lists.01.org>; Wed, 05 May 2021 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1bm9uJX30iPwZls3eRhxhkP/DbQdOuBZzDJzJyq+2I=;
        b=EFgg2BvMDvkr9HS5wBP8RzrFMmKRNRLT4ZsUlkUW5MxTzaAG758PvgHZDX6erpf1W8
         OuFhBoWMGuYMLS/qTKt3YoXY/B8An3fvpbnzWx6DZGOVwVWg0sPKlSYODmqO4mAAHZ+s
         GdJNyEEoP3dXCmWOeTIYjmsDtziqLVHcgySJsF6+0jRObqf9QtdtUuh5t3enkjfIz6DM
         omtiNzJJpCwMjtFTYc54S4TNKjtJaV6C4cCa81L8jfu7JfqrVW7Qn2b8awvslSILBP7b
         ITHfdPKapQIJYiJgp5lK+/TzDTC0Q/W8D7j0P+tKDdL2pBwM0Gk+1Jo68K9BmRwKOjkt
         VlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1bm9uJX30iPwZls3eRhxhkP/DbQdOuBZzDJzJyq+2I=;
        b=A4E2q7T0qw8wX7qGw1qSysRy3GC3nFrkN8EpJvDz/dhL0SlITbXYIChGiGZDe8L01F
         MhApjoqdfLYw1AzlQ40G/6kKwEmV2X/VPg+65/hyHPOWbGR0nqAaShJEE1J4GrjINykY
         lLhhSx+khM872BiZZYC61DtQRv15QmbMtuY36xnv2RWzddWO0CVUuzjiF/Ffz7L1v2Ta
         PmYjpshV2Tba2nVVrOUZvepXs24sQGc8227rvdOm9QeG5Ktrl0iGQF0Z4KopzMKJpVk2
         ZxIB/48CnNrdy7Hu1J6E2Qavxl72W/XzxPy6PUWC8ZGaSe97V234szbH/TYagdWOBEaw
         xScw==
X-Gm-Message-State: AOAM532tIe+E03I5X+ajgmBqgC27MVFbJgnKGyCMgn1SzcfZQfO439Ww
	p+TRiAQrZgawto6hYqKKFj6jptpEjiHUcxyTYaeEJA==
X-Google-Smtp-Source: ABdhPJx1MBEljZ3xcoj0GQnKnzUMPQV7wGRSF4ZNYBLUGHBQDVcb+JN5tEMQt4PocQ5of1gymzvVs1VRU0eqQqhNTBw=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr1056579eja.472.1620254090125;
 Wed, 05 May 2021 15:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com> <20210325230938.30752-6-joao.m.martins@oracle.com>
In-Reply-To: <20210325230938.30752-6-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 May 2021 15:34:54 -0700
Message-ID: <CAPcyv4iOh5wS04F=hftcwN1e3DJTg-qUhw8KHR=+wncqJ2KZsg@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] mm/sparse-vmemmap: add a pgmap argument to
 section activation
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: 5OUL3DYI37SER3L5RHTFLM6KSHS5ZGR5
X-Message-ID-Hash: 5OUL3DYI37SER3L5RHTFLM6KSHS5ZGR5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5OUL3DYI37SER3L5RHTFLM6KSHS5ZGR5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> @altmap is stored in a dev_pagemap, but it will be repurposed for
> hotplug memory for storing the memmap in the hotplugged memory[*] and
> reusing the altmap infrastructure to that end. This is to say that
> altmap can't be replaced with a @pgmap as it is going to cover more than
> dev_pagemap backend altmaps.

I was going to say, just pass the pgmap and lookup the altmap from
pgmap, but Oscar added a use case for altmap independent of pgmap. So
you might refresh this commit message to clarify why passing pgmap by
itself is not sufficient.

Other than that, looks good.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
