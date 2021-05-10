Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4237978B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 May 2021 21:20:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97E75100EB822;
	Mon, 10 May 2021 12:20:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 20D85100EBB9F
	for <linux-nvdimm@lists.01.org>; Mon, 10 May 2021 12:20:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ga25so390334ejb.12
        for <linux-nvdimm@lists.01.org>; Mon, 10 May 2021 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYWAx/GVWalndOcYOu02DjsV8gfmpcaozEycxHwwb08=;
        b=hQiDm7liVQizlEq991s/huupFIAIRbDMQs0rIBB8pYXXX0E40psanEfZMAZxU7yZgA
         pjNO98KgV71tHMH+KE5rn3es4Voh9hWnevABaM7hGpgta9goeA/BwCfjwaisAgPIQpAD
         EoKgFGyM9C5jPRkV6O23nNalBR60I56IqGbODhaPWhFjV26Xn0JiV+gVsb5RnqCRfj2W
         yYCgg9AXjoYRbYC26davkf7Vrrfh+QjKLXADDsy1b9ED+UofrgQzmw18c6euyChOutxc
         FP4dzzol+/VOabZ8+GPwwLq5eTQJa0ufSJE/YZbevg42T/uWr57QChbISQT7uBnNLHb/
         FvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYWAx/GVWalndOcYOu02DjsV8gfmpcaozEycxHwwb08=;
        b=do863pCDLOv/2yQbfCIyCs2ftZRW6aKZN760Bdto0g1QD7ZSuU0pMZo6wruai4UaB3
         WroZHnekxX0FymhOZwsQlBCGzaVmSGbBsNu2PN4hqB+ulRmcwr2DyhDTZSHEcFgwxDam
         CBwywJHgjNefWwqazvmd1zfM5rK+BHhKhE69npMN/CqnQl66UZm4WO/yPfBeMh8hrj7B
         7fKgFjxachvtI9cklAecKueQoDgyP0R5KyqviJ6x/4AzdrrGt5/4E77fuwpPR//fpN3I
         AtDg9KAdXedZxbwXssJEraeGfw+C32V/DlG9+cLBISW8iX9xEnZKso2IK00jjYXuFDu7
         Wh0w==
X-Gm-Message-State: AOAM533QmPpC0Cgs/J37X6krNi6I5JDyMwB22ZH2pncuqCHRLamueUxh
	1UOUHXnh19ecaA6RGy7tscmeHfHHjbVlvWVtNiKjMA==
X-Google-Smtp-Source: ABdhPJzw6HKGgR+vihd+OqgUFjKjHIncCGCJNhZQ0q/KlbHLSbaN1zudTYoKT2gXDUdUyHIHCRcnArwtGH+QxMClEmI=
X-Received: by 2002:a17:907:1183:: with SMTP id uz3mr26880105ejb.264.1620674407187;
 Mon, 10 May 2021 12:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-8-joao.m.martins@oracle.com> <CAPcyv4hcMg6cJctnY6V=ngL9GoPVvd3sSYRbS-WZoTg=SnrhEw@mail.gmail.com>
 <63ce653d-4d21-c955-7b81-abba25b9e4b6@oracle.com>
In-Reply-To: <63ce653d-4d21-c955-7b81-abba25b9e4b6@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 10 May 2021 12:19:56 -0700
Message-ID: <CAPcyv4guVWx0TdEe_Z+CQEbRPDk9LGcgb87pb=g8XdRyeUaPcQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] mm/sparse-vmemmap: populate compound pagemaps
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: LPTVW4PYYJBG7YDVGOERTH7APGXEL4QO
X-Message-ID-Hash: LPTVW4PYYJBG7YDVGOERTH7APGXEL4QO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LPTVW4PYYJBG7YDVGOERTH7APGXEL4QO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 6, 2021 at 4:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
[..]
> >> +static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
> >
> > I think this can be replaced with a call to follow_pte(&init_mm...).
> >
>
> Ah, of course! That would shorten things up too.

Now that I look closely, I notice that function disclaims being
suitable as a general purpose pte lookup utility. If it works for you,
great, but if not I think it's past time to create such a helper. I
know Ira is looking for one, and I contributed to the proliferation
when I added dev_pagemap_mapping_shift().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
