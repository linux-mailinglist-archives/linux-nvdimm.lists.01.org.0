Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A89828078E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Oct 2020 21:12:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C7A4155EA59A;
	Thu,  1 Oct 2020 12:12:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21E0914DEB3C4
	for <linux-nvdimm@lists.01.org>; Thu,  1 Oct 2020 12:12:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so9662602ejb.12
        for <linux-nvdimm@lists.01.org>; Thu, 01 Oct 2020 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVHKGkTv8PByBSw5x5TAqafUmlr9UdQTcHRRx3gB2PY=;
        b=wj1V3E+Xo/qZX2n2TWSTBFK1h5lLngoTdOEOoGP2nX7u0ogu4VgtfvbzyJr37mIOR3
         kkHHKyJAQ4zGeEWHu7jHqhwHa85fcXFctsNqfk0hA4oDY2Koxwh5IXm9N3FUT8dyCCSI
         ibNcKnFBgwXB2ouDk5TulMQYmXXI+Zjl9HTGNo1tpAldWFQdASR9IJm8EVd4Mahabfmo
         WMI/wbGd/mR/neJ0DwIHgEVS0jZvYPWMZ2OjaV6Sor+ORnbsMmY0udfwqgUuPK85ELGC
         TFX5jKMdaItdWj4xCGKEyOAvUuUvtxNuR2SG5Ic8SNYPt6rm7CE7J0gH7++J9KfrwwFP
         xEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVHKGkTv8PByBSw5x5TAqafUmlr9UdQTcHRRx3gB2PY=;
        b=Oeh1RAGJ+vmBESui5HDFLaf/kYx2GYCSBTe9DX3vcC+4hJS/XOABJPx+tph6dwb99R
         BWANrNsD394FxxClzVIeU5kMYVczbR8dQmAW6LFaMM6R6pS833E8Sk4zporGltXZviGm
         Xk/21xNPFgtqNuZ9Gvn4KqSjyKYG0D4mCLUAkcmPBgWmgWOEmO8Q3uOKAqv0gYrSJKd6
         bpI9VUukSV5JiByif7rV8K7qyE1KVJx78TV1Gjj5ucxNHepf2j/Rm9xKBiEA1bO/I+EM
         aJdJnbUp1T3B4n2k5pEr/OGU5HbOqyrVatCn521smBQLn/D3LlUldvkcVpVQN6+faCiU
         lkzw==
X-Gm-Message-State: AOAM533SyxCdYXeV/KENc2T2j0DuZcSFyK1Zk/oVgCIM9TarZWsbtfCG
	QviPvBL+ecVXBFruV71WFIShuMDy4qxY9Xp3zaa7XQ==
X-Google-Smtp-Source: ABdhPJx2xuTe9l+SDL/5xLNgCEWJKaFIrTbLSDyHIXAINehaPQgc2qztyz23QccWB3sUHSjq3YIOjigycbLia5rcLws=
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr8349424ejb.45.1601579556191;
 Thu, 01 Oct 2020 12:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160106110513.30709.4303239334850606031.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e3b7c947-c221-8be7-41ae-aed2f481d640@redhat.com> <CAPcyv4io6a7qaX+oa8uL9C0nc9J9UMx0CfC5E1DYdhSPvYVeOw@mail.gmail.com>
 <8012a7c2-750f-38e1-0df0-200b56109fd6@redhat.com>
In-Reply-To: <8012a7c2-750f-38e1-0df0-200b56109fd6@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 1 Oct 2020 12:12:25 -0700
Message-ID: <CAPcyv4hXMeb0NSLMObxZCQiVDe7ZcZT2wZk13jAqpoH5An7hnA@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] device-dax: make pgmap optional for instance creation
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: V7L23FURXTKFL4P2HR2NC6RJQ6QQLWPW
X-Message-ID-Hash: V7L23FURXTKFL4P2HR2NC6RJQ6QQLWPW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Brice Goglin <Brice.Goglin@inria.fr>, Jia He <justin.he@arm.com>, Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V7L23FURXTKFL4P2HR2NC6RJQ6QQLWPW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 1, 2020 at 10:39 AM David Hildenbrand <david@redhat.com> wrote:
[..]
> >> include/linux/range.h seems to have this function - why is this here needed?
> >
> > It's there because I add it later in this series. I waited until
> > "mm/memremap_pages: convert to 'struct range'" to make it global as
> > that's the first kernel-wide visible usage of it.
>
> Ah okay - I'd just place it right at the final destination, instead of
> moving fresh code around within a single series.

Yeah, it's looking like this series will all land together so I'll go
ahead and move it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
