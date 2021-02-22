Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F689321C77
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 17:12:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1193100EB833;
	Mon, 22 Feb 2021 08:12:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15AFA100EB82B
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 08:12:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h25so9077898eds.4
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emGlnXqclXarc6XinJzjsJwBcr9ep89p4hBrZ50PBUk=;
        b=HOfGy23TaiAXDhDXx6MF/w8gWpPG5jL9XO/SQfdnS4xfWn53XErZxVptHXfiEmec1z
         1DL2H5n6TC3X5AkERzAoWecGjOK425BHGyQv25Yu/R7rBRkka6KdGkaTmfa1USmK+zlz
         LrLDQuvbedGO2basfUH4ot9xU2OdYcWFLNK2W9qpB8Gcy1YnZBPCF5+9SRzg3eNHXwCg
         ib8Cb2IlOp18alWhJMP8n0+wMF1zfkeVf3z29yAaBJ+fo9vyFAIjcBAnF/wnB11NJeYF
         K7dKdfH6nZjrd3LCTLDa/rYV2/o6HNzPhlOtiWVceN58xD1AIy/U/OXUjmKnJhstuGti
         eYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emGlnXqclXarc6XinJzjsJwBcr9ep89p4hBrZ50PBUk=;
        b=sm3MilJRj5Clf4MEuLlr6YjqE9C1U8Mw3glDSeetevk+2c5h+PFg/qTZskOqzjSblJ
         SiRg6VdtAZzq6zhxeGv4LtNggnqU3/hqGb8FT8P/ddztKIdBn+U5NPOjkABmRuOzkGQc
         WG+0mw4MaFcom33+AVoQ/Xk/tN1ZVZpmIl1AX3QxPa/TCUco50CjPfscfVHvGF5WidC9
         U5ExwqVbHgXE74pagFmCd2Si9E+a93yqL3X5RhdeOSo1lJDT3KKKPmPrueMFQ5AwK4K6
         WJz48hMG699h9yzfkrm81YNDU0AVfaJ/IzhVmcVezjsdylVNCufROtPjEUDJYJjh7Y8T
         /fEg==
X-Gm-Message-State: AOAM533OosqOCS1DpPBWNKWzaa7FsQ5pmYvFDShDvE6mwQ6EGL5q4JAx
	xV3L5cVng7RjPAntrW8wIWxu1edIcHTMDrE7fJX+rQ==
X-Google-Smtp-Source: ABdhPJzkbvr0lPYEuSyq3XzUq/hFn7o16di5v9Gr3bliZj4j+tNNJhDD+5mQGRMaYPMJBCwjYSnLAXoc2rxZaBbgCa0=
X-Received: by 2002:aa7:d315:: with SMTP id p21mr21752804edq.300.1614010337292;
 Mon, 22 Feb 2021 08:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com> <20210221034703.ncetonon7iseqd72@intel.com>
In-Reply-To: <20210221034703.ncetonon7iseqd72@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Feb 2021 08:12:12 -0800
Message-ID: <CAPcyv4jx67uyiypbkM-Yd-yTMw-tcrKkkH3YdjkjBa3m2XXF0g@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: DWTUJKD2OCXJLTEY3QAHBAHDIM5QCLVM
X-Message-ID-Hash: DWTUJKD2OCXJLTEY3QAHBAHDIM5QCLVM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-cxl@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, Alison Schofield <alison.schofield@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DWTUJKD2OCXJLTEY3QAHBAHDIM5QCLVM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Feb 20, 2021 at 7:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-20 18:38:36, Dan Williams wrote:
> > On Sat, Feb 20, 2021 at 1:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > When submitting a command for userspace, input and output payload bounce
> > > buffers are allocated. For a given command, both input and output
> > > buffers may exist and so when allocation of the input buffer fails, the
> > > output buffer must be freed. As far as I can tell, userspace can't
> > > easily exploit the leak to OOM a machine unless the machine was already
> > > near OOM state.
> > >
> > > This bug was introduced in v5 of the patch and did not exist in prior
> > > revisions.
> > >
> >
> > Thanks for the quick turnaround, but I think that speed introduced
> > some issues...
> >
> > > While here, adjust the variable 'j' found in patch review by Konrad.
> >
> > Please split this pure cleanup to its own patch. The subject says
> > "Fixes", but it's only the one fix.
> >
>
> This was intentional. I pinged you internally to just drop it if you don't like
> to combine these kind of things.

Apologies, I've been offline this weekend and missed that. I will
point out though that in general I will not change patch contents on
the way upstream. The adjusted patch must appear on the mailing list.
The new korg support for attaching attestation to patches requires
they all be on the list, so even small adjustments need new postings.

> It didn't feel worthwhile to introduce a new
> patch to change the 'j'.

Janitorial patches happen all the time, so I think it's ok.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
