Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEED33303B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 21:50:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 286DC100EB85F;
	Tue,  9 Mar 2021 12:50:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::133; helo=mail-il1-x133.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN> 
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B2BF100EB856
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 12:50:21 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p10so13433630ils.9
        for <linux-nvdimm@lists.01.org>; Tue, 09 Mar 2021 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8Beol1vwvugLcX6dyhYM7QV2XmUWY2CELTq49rlsJk=;
        b=D4CmLh/h2w/J1i0VPcOxlMFzEuqzUjkpZtNtGOHi/2VTPRS7Z4qe8S9++KSJqtONh2
         GOPmuiR+6JbHCGHAK13IqjCjXyDgT+XXLFglPrNmHuLwPgKTq7CqhnBpQJQ70AMRdJjx
         9AcgAFs/YLmF9GzqzhmbtkFISp6+3GH3IngohIJDFQBaAml64P+bL1kaBQDvjiHAD+nZ
         ylIvnP/ECzkcH6FTu/Eq8i3heCzxDc+WojQ+JLZxZg36GU20orXdHOUYWfHzCBedmaED
         sMWf4IbjzJFW7nkYDaVelbHDETMOt1gMYXO8haqGobcIHTaasa4OPllmCpVlfRC4Ix3c
         YTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8Beol1vwvugLcX6dyhYM7QV2XmUWY2CELTq49rlsJk=;
        b=gEJMZ3C+yMhn0Nk0lItSojHkYEpruEKO6+mU0DgueCpS87hJOX8HMU0thbEK5w3Prc
         YxKIM6NXUtZNQXfYEww2VqmDW7PITld2cZSI00oCdo21mhKbuOVoA3d1hxbdMaYc+XnU
         h4/cCC5/eToFjJWOjFSZ89Ca9MdGBbmMcYm0YxxBMl71a6VGnLP3JQDA+Drjy6ftq1Fj
         KflVZY/Alv+Q50RT4nlE1/eti0p4BWXaVx7d/gC5z4gthFOT/F7XWXb7x+znwpEde4jl
         SRspcSKEuUzLcUY4ZfmmXFyDb2IG6OWqEQhPnLYF2EGj3d9znUksDW0ZUi1wWSB8v7yj
         F7eA==
X-Gm-Message-State: AOAM530poDGcoAqBipZnpT5OeY5pTF6r3p1p0XHbTLIARpSh0XC5m0om
	SEel7OS4D81wK/c7qd7aiq7IuQ==
X-Google-Smtp-Source: ABdhPJzL4us6wU9N46CCAROdfi7JEXE1HxM1m4J4+Smd3ru46Jtr3H8nfy06m2kjHYjK9tiAsRTGag==
X-Received: by 2002:a92:ddd0:: with SMTP id d16mr45367ilr.52.1615323019838;
        Tue, 09 Mar 2021 12:50:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c19sm8079624ile.17.2021.03.09.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:50:19 -0800 (PST)
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20210309195747.283796-1-willy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b4d3285a-e1a2-1381-2bfd-ceeaf5ab55c9@kernel.dk>
Date: Tue, 9 Mar 2021 13:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
Content-Language: en-US
Message-ID-Hash: LT7DDILILKDRIMXGHXDVEXSPMKCP4KGY
X-Message-ID-Hash: LT7DDILILKDRIMXGHXDVEXSPMKCP4KGY
X-MailFrom: axboe@kernel.dk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LT7DDILILKDRIMXGHXDVEXSPMKCP4KGY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/9/21 12:57 PM, Matthew Wilcox (Oracle) wrote:
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.

For the block bits:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
