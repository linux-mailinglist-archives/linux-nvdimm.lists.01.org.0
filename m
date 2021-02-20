Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 223FB3202B0
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:50:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 521CB100EB859;
	Fri, 19 Feb 2021 17:50:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33643100EB84F
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:49:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t11so17333521ejx.6
        for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlJ4JxE7cEgv2VZzZcchEQjl5uSa6wQTW8zoDR1tYi0=;
        b=MlnEBIvHPCH5Q4hKCYH2Y6aAEdoklM2Nc2qNb6idhxXnrH70htTbvKj22LsIsgI0BN
         xUUQ+3Uzfedq9kalg4MKgY7nLuhqQDGecOsN2eV+UtzveJipQxQrWsZxkOUatzlGQEaB
         xJSDgkVxsi+66XAFhld1Nh4GrATj/5RNps6Yls0Utt9xFHnzW5NjpvUnkcSyVUEaXXGH
         DEdwC+rge+6N4zfMgAFUhHpoyAL7RN6E7NiPIP0Oi2/Ujd6lKY3EA32RltsrxJOsksUo
         my+L9kwvBaN10PizSg4mtZeZsXcVsY0kiVVj+9mh0LJQvvYTHI5f8IZw598uIT9Kt2og
         LUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlJ4JxE7cEgv2VZzZcchEQjl5uSa6wQTW8zoDR1tYi0=;
        b=rnaTKhJmJbVndtX7AJCV7G/Z9y80MjsAh4wLi1yG6D8cq1kacoPelo6kpYvOhgKYXY
         PkVQCpcqo0lEUWNUWzr2VuLgqZdQKlD+f5Zo26+ywROZ1khnZYXvJ0OeOxy4594ixF7r
         OBgEeel+MCE83q/mNuVU1tlvrhfESwmCNP9wynDMzjvyf6xcDNdY0NAr9Uf2zUvC/hqR
         GhZDkXuzhoZjwPcNXvq4UMMgw8n7VptkoZ2b+HCINyw1dJYJ5Qg7+6gGQWV2xMmPg+wD
         iDsB5laHI/kCQJ29PPbyen2EIECslzghkXDUFGwnKBKF/HyP+3zBEkV4v1bur7EGqdzr
         1AAQ==
X-Gm-Message-State: AOAM530nqzEl2zjL/6m6P2jpHAsvk59peR4plM0m8pjGLNg35YkXdVsy
	Yb0ZV63iN+snPjaj8t7/xO6Igvl7jECVR9ts9RwxTA==
X-Google-Smtp-Source: ABdhPJxSBmWtc3D7yPoJ+VvZwQfVKtSvpKlz5Q5fcePwTfVx7Kma0dmk1uAB6TiQzCAMap/Zi2MCZTFA7fcw42RWxpg=
X-Received: by 2002:a17:906:fad4:: with SMTP id lu20mr11358011ejb.341.1613785796220;
 Fri, 19 Feb 2021 17:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com> <20201208172901.17384-3-joao.m.martins@oracle.com>
In-Reply-To: <20201208172901.17384-3-joao.m.martins@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Feb 2021 17:49:48 -0800
Message-ID: <CAPcyv4gXOGZKGkEPKmFa-w=BavUbUH8o9WxpzDugbuOHt-Y8Tw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] sparse-vmemmap: Consolidate arguments in vmemmap
 section populate
To: Joao Martins <joao.m.martins@oracle.com>
Message-ID-Hash: RJTO24XIPSDKCJ3D7FXH56DOIJCGF4CT
X-Message-ID-Hash: RJTO24XIPSDKCJ3D7FXH56DOIJCGF4CT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJTO24XIPSDKCJ3D7FXH56DOIJCGF4CT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 9:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Replace vmem_altmap with an vmem_context argument. That let us
> express how the vmemmap is gonna be initialized e.g. passing
> flags and a page size for reusing pages upon initializing the
> vmemmap.
>

Per the comment on the last patch, if compound dev_pagemap never
collides with vmem_altmap then I don't think this patch is needed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
