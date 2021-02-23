Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0F3233E6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 23:48:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD6F8100EB347;
	Tue, 23 Feb 2021 14:48:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6E8A100EB320
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 14:48:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so77056ejc.1
        for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utqrte5njtReY0wG/Z3veQ9qWAdkPkCn5cfJZJyg6bo=;
        b=LiBdc3KtcUX2h4zj4qDhPbz7Vbhk3LbV04a3tI6bodDVgR32pz6A+W8H0um97NS9Lr
         ggU0Seiiyc3rsD3S9Tg0YxrpA0AHny/BiUjJKTXsSU+RUjHAJ4qcx8ozeTz7ZGyKbN1M
         pGUgw4n3UjMGgyLLjhuPTo9q5kixr31ras5CTU6VsbSon26t4FecmGJRpgJART+1cmw1
         sVLKFpbRmcoXjGJH5+lcm3cP5JpX+6/OA8ZP3vNFte2ptAjm+AgbdPqZoG8RrgsIPO1e
         tu1vNDN5jkGG75Mae6VNsROib3mujKDzLX4KcaVjvi/bpwN9yt26/0/ihXu3ZszMfOMh
         9i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utqrte5njtReY0wG/Z3veQ9qWAdkPkCn5cfJZJyg6bo=;
        b=nEF7gVROHWnoeyZqCSt1wEGBxA1nKuwgmi5LXivmYqLvcSyq+ARD0qVIe/ig9MSjix
         2WyWiljUqgGvPr73xo5x6T/Xr0pB83UuVejt8mwqnLm14ZtKoqyjXn0UoRC9txkBHEH2
         3CbRDNXy079HSbFoxTbxoxVjyeSatuVlcDwLnuoOgd5x73PDNiA6597RwU1cSlb6J5fG
         m87IG2h1cu+VaRE1UEZpTsZ7lbXaaqRw/nSZAoldEa03OX84DyTQyEVRIP+fvhx/F5ei
         +rzuWYceFljGIkObttTgPSlm6/aPrcl49RA9RF+Lrx/kMbjhc2EWhiMf9tszX2GwEznf
         oVRQ==
X-Gm-Message-State: AOAM531c/wh2mlIYHCBjeaeVXJSzUdt8vdv7IdaFid2JfixT44LzrBUx
	1XJDhiu2rVVtRrfSaXiiV8BvYBH/psaPsn+8GN8XOA==
X-Google-Smtp-Source: ABdhPJxOeF+0YxvLFBx8TcAxLNMINPN0/N/SIl8wsbXZm8lye6NyJGla5zyHcDu9BO5zGcekAuVvQOqtS5eYo8UN0nQ=
X-Received: by 2002:a17:906:cc91:: with SMTP id oq17mr27779064ejb.45.1614120504150;
 Tue, 23 Feb 2021 14:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com> <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
 <20210223185435.GO2643399@ziepe.ca>
In-Reply-To: <20210223185435.GO2643399@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Feb 2021 14:48:20 -0800
Message-ID: <CAPcyv4gnga5py0j+_1y_9tAxi98+FmYrtOVy7xQTHJ1zJhz2ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Jason Gunthorpe <jgg@ziepe.ca>
Message-ID-Hash: 27OGDHEQZ5HMNZL7P3YBM4EBBWUSFPB3
X-Message-ID-Hash: 27OGDHEQZ5HMNZL7P3YBM4EBBWUSFPB3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/27OGDHEQZ5HMNZL7P3YBM4EBBWUSFPB3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 10:54 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Feb 23, 2021 at 08:44:52AM -0800, Dan Williams wrote:
>
> > > The downside would be one extra lookup in dev_pagemap tree
> > > for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
> > > per gup-fast() call.
> >
> > I'd guess a dev_pagemap lookup is faster than a get_user_pages slow
> > path. It should be measurable that this change is at least as fast or
> > faster than falling back to the slow path, but it would be good to
> > measure.
>
> What is the dev_pagemap thing doing in gup fast anyhow?
>
> I've been wondering for a while..

It's there to synchronize against dax-device removal. The device will
suspend removal awaiting all page references to be dropped, but
gup-fast could be racing device removal. So gup-fast checks for
pte_devmap() to grab a live reference to the device before assuming it
can pin a page.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
