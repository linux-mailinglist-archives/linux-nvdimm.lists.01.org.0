Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B752C877F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Nov 2020 16:15:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56D7A100EBBA2;
	Mon, 30 Nov 2020 07:15:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFC7A100EC1FD
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 07:15:51 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id k26so14516936oiw.0
        for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ymyaL/VUpjN77BfIwvfG83Gjo8xA1mMwJchE8PRew4=;
        b=EIborbJSi32Et+tlLG4313xYIP2E3fWXKGWG4CmfMxWL4UBTb7z5GJd8bc5jo+mh9c
         +erGEbjQJyF4MPmU4AP9zCCTUaszDh499A45iJ/yuE66+2y0JLCptTvCFbBOp7Dfr0yp
         nOnk2x7+ZobpMnhsYTjlV20Jl15HQdShdR+5r2OvaXVlupcIj0MVm3ets6qUyRFaolNC
         3fzgDztJ2yDTBMxIM59y1iS/zXM8a70KVKzGgyDPNHeZXzxD54VdTjwUIyaSzqNYTp9z
         BOMPANOza1sI2Tf2sr9CbBUvafDAVf6vWh6h2K/fViP1Z3glqv44TI2M8h8o0nwc4ivt
         ujww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ymyaL/VUpjN77BfIwvfG83Gjo8xA1mMwJchE8PRew4=;
        b=bAu9Vo+yUgI/4iR/gD85OqPpX/ZDyqY4DwrlP7U3hcpxsFRcnpdodVgk+Dun1tP6LU
         HnD1I7/OFvMuVhxxRPLhREnFQpXVHOPj2B1JjX2HpSudpdSdPntMes6b1uaB6Llxrmg5
         q3WU6W6eLndLUB133Q/dx8VAsv6T80G1/OtwOMuZ6snCiVMlHfC7qUo8FNgQXEecT5BE
         kaS+S7LVebNBPgOrC9Mn+tTiNegZk0KZTcVF/k+CEkk0CXrWhjbWk51QWUpSWqQG8aLx
         CnHqOpkV2NVVIZgLLcy+00TKnJ3l/iLJOweLiKPNRdalPuot1+1/qojsL/CjbPhtezkn
         1yTg==
X-Gm-Message-State: AOAM531WuIUKHm0iD9QSdIuOe638YzAAmbpRDmbZVza8PCAS1ZWRHxJ/
	oJ//tL5hjq/0Dm33zfnzr6aIzR3tN9bFDr0mhRg=
X-Google-Smtp-Source: ABdhPJxiPTP/CF84AZyrf4L3bu/MOkkWh5CU4td+FRRmmgMPCCM3Cu/iLRxu129MCvubGP5gfWmTtbj2353izp7blPE=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr15041901oid.114.1606749350848;
 Mon, 30 Nov 2020 07:15:50 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz> <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
 <20201130150923.GM11250@quack2.suse.cz>
In-Reply-To: <20201130150923.GM11250@quack2.suse.cz>
From: Amy Parker <enbyamy@gmail.com>
Date: Mon, 30 Nov 2020 07:15:39 -0800
Message-ID: <CAE1WUT54mPvQUEdLm_wt2-63oZvGO-uUCvhdHFosiN1ngm_NjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: HPCPBKSDXYB4WOFEC6C7CZISPNFH4WCO
X-Message-ID-Hash: HPCPBKSDXYB4WOFEC6C7CZISPNFH4WCO
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HPCPBKSDXYB4WOFEC6C7CZISPNFH4WCO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 30, 2020 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-11-20 06:22:42, Amy Parker wrote:
> > > > +/*
> > > > + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> > > > + * definition helps with checking if an entry is a PMD size.
> > > > + */
> > > > +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> > > > +
> > >
> > > Firstly, if you define a macro, we usually wrap it inside braces like:
> > >
> > > #define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)
> > >
> > > to avoid unexpected issues when macro expands and surrounding operators
> > > have higher priority.
> >
> > Oops! Must've missed that - I'll make sure to get on that when
> > revising this patch.
> >
> > > Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
> > > other bits for that matter). XA_ZERO_ENTRY is defined as
> > > xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
> > > the bits xarray internal entries are using and things will break.
> >
> > Could you provide an example of this overlap? I can't seem to find any.
>
> Well XA_ZERO_ENTRY | DAX_PMD == ((257 << 2) | 2) | (1 << 1). So the way
> you've defined XA_ZERO_PMD_ENTRY the DAX_PMD will just get lost. AFAIU (but
> Matthew might correct me here), for internal entries (and XA_ZERO_ENTRY is
> one instance of such entry) low 10-bits of the of the entry values are
> reserved for internal xarray usage so DAX could use only higher bits. For
> classical value entries, only the lowest bit is reserved for xarray usage,
> all the rest is available for the user (and so DAX uses it).

Ah, thank you. I'm not as familiar with DAX as I'd like. So what should we do?

Best regards,
Amy Parker
(she/her)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
