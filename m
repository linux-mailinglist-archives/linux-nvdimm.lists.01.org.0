Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992DF28FF02
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Oct 2020 09:20:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD8281606AEA5;
	Fri, 16 Oct 2020 00:20:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9800E16061123
	for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 00:20:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so1683565ejc.5
        for <linux-nvdimm@lists.01.org>; Fri, 16 Oct 2020 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+iSrMtFmHg3O+4hlshnuS7Wz4B1TlsOgXx5v5XjsoE=;
        b=vg/WLfljNwT3yKOv24xrjqtBiu8lH/dpD84sxLvDLdiCRZ4CZoVic/nofgZfwYfuz/
         3PxBi033iTuyi2wbzvTNBfGE/6ilHVLQn6xvFq6O1Obbh1GY7Kj6BwyOVSJ/mUxovVBn
         eODmPnH3VGICg5PyF8lmoaes/o8FQ0F9nkzAOIu0qXU+kMW6c2w4QZ15kAnKb4YwpnRD
         Naip5szpL9zOlHX6BTa5WYJU2ZRG6E3UQnwcTEqOgiG2Ehat9KdTf/MX7OIIJ4zog1Lu
         YkGd4Ct7nCbT00A8S+DwnRzN2qVT+Y4G1Q1RIT6urFSzG8UKZbpJqDvLEFoVQ28NsJzh
         5qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+iSrMtFmHg3O+4hlshnuS7Wz4B1TlsOgXx5v5XjsoE=;
        b=c7oMnumXv+CnDE4Jum7QrFLN5pgh51JUCkIoNQxZrRoafcAD9GgzfPaH7/DmG4Fiwz
         g/xJaWImxcO9IjLDhl5dT4BVwL5NAFr0bmSa2gIXmZjr+Suuk+INfbVX+pSlmEhwlxWC
         scx2kXNLd8lyyE00Yf3WNbnw7GeyEfu57C6PupxInnybIEJb68xyZyvuWvncklARCVA9
         Nx79Qdd4iwEyMDWQ/MD10RdHHKUnkbbJ/yjv/y9af4ChYxRM+mFoWvRSP80cBJz45lS/
         zfCgMq7Xo/fKUlldXl3NRcAxFx7k9e34ohJ9t2omjO6qzb5/kjuebCzgF7Yxaz+PqN19
         whkQ==
X-Gm-Message-State: AOAM531LWiOJifs2D56GKFOu8u9VJmTI/PEncSRayDkWWdv9qK/a4584
	xeQFMqkXFx46lsHTE1a5wmBhUHCZAZll/U19D4G/RQ==
X-Google-Smtp-Source: ABdhPJwsZKRUlEtaH2jW4zm6+ObdYyma4WzjAY6/gqrvL7MJ0zdVlvrDX7hH6dJ9+oZOkdOi9rdrMaiO6R5Dtfp138I=
X-Received: by 2002:a17:906:7e47:: with SMTP id z7mr2250318ejr.418.1602832799499;
 Fri, 16 Oct 2020 00:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <160281074218.3146890.3209259735282870612.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20201016065901.GA10448@infradead.org>
In-Reply-To: <20201016065901.GA10448@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Oct 2020 00:19:49 -0700
Message-ID: <CAPcyv4iYj6U=Ww5e5W+c_1_SDq2fP3iPa4fYXF++bV3g-Cs8pg@mail.gmail.com>
Subject: Re: [ndctl PATCH] Clarify COPYING
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: WNJNWPD73V5KORRMV3IKGAJ2C5QW2L6H
X-Message-ID-Hash: WNJNWPD73V5KORRMV3IKGAJ2C5QW2L6H
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WNJNWPD73V5KORRMV3IKGAJ2C5QW2L6H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2020 at 11:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Oct 15, 2020 at 06:12:22PM -0700, Dan Williams wrote:
> > The tools and the libraries this project produces are licensed under the
> > GPLv2 and LGPLv2.1 licenses respectively. Add a COPYING file that
> > highlights this arrangement and fixup files in */lib that mistakenly had
> > a GPLv2 header applied.
>
> Maybe it is time to move to formal SPDX annotations and the LICENSES/
> infrastructure from the kernel?

Ah yes, I hadn't noticed the LICENSES/ style. That's a better fit.
I'll go that route and do the SPDX conversion as well.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
