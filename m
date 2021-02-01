Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5430B275
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 23:02:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E45B3100EA914;
	Mon,  1 Feb 2021 14:02:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EAB09100ED499
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 14:02:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so26802702ejc.1
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 14:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=yRi8mguQqwGyP74Lz8HnidEorwfF7klt4qQMuE6uyPGrI0nnVf3UO1/tbJR+kWOOGR
         dWmIQcJgh8tUURN0ieUfGpl3soucjW0wrSDuKx6Y9XL66sU8opnIg7sxdwSNSWp0fLIr
         nQTxV7ahPPxceFtgJKNxCIJWgLTD7hfKHYxTCqUPpp1scoT0JWUDr3XWsuBhkaWsp2Ko
         ku9Jrb6DLqZ+8d/xmEcVgGxMbIkRA+sIynA/F4cTTRjVtBfrkLzvKwBPHtBFKCEVpHC4
         s94dtYIxVabjk/YTMSmQlvYnC5/uXpJNxnnYFAza3R9pXfMZNpwI9PbJpgEUEG7m6ZhM
         cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHpWXQOSv7s9aWUS8YqFMt0x/4KDBay3sfDCNqdteVQ=;
        b=EjlQEYWyIo80/Cb/FgWT3gLo8RhSWOw2eRwhA9UDYlNs04dq+jlOdvnUFoGefqSIeA
         fhm/ceJK3kaVCGa26PWFCSN1lLPo3Mng2lq21AX7UXvCOuhSG3pPqU0dJYWEMWwOYH25
         MtI0MKAwUOZvcZahDFVw0u7EqgvCsNZ6LzfrgZiYZo1DOKtiTxF9rHv+AUb7gPRobwio
         dKHtzQMCYHxa3/PmXJDNp8OgwMg5o9Iwvo30ct4s6V6tDnKvdxb1wqG63hzz4x31Zrso
         vkkVzBOfnjN+VfZNPG9r4RAptIRr0PSVaTiCJBTk6xyILSY4uTHUxSQV8qdFyuG5XXwI
         CbOA==
X-Gm-Message-State: AOAM530bsUY39QVZTYnInDp6UlzhZv66t2T8mdFrei0qg6JQpuzVkkhq
	NhEFwU1JNzFawP1eTZb/i6Z0KPNaPqo9S7rWGXQDiA==
X-Google-Smtp-Source: ABdhPJwx5HQJkiYYzBPXX7BYLe1eriXrLIkYHDMYupmuWFH/I1Xqh4x+vyz3z88NdGsEK2HXTHd3EhXx58RQNYJdZQ8=
X-Received: by 2002:a17:906:af6b:: with SMTP id os11mr8117536ejb.472.1612216934397;
 Mon, 01 Feb 2021 14:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
In-Reply-To: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 14:02:11 -0800
Message-ID: <CAPcyv4jyojkRqkXPK=ZgMfUATVNUf71GZsgQuarygz4QEM1o-w@mail.gmail.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
To: David Rientjes <rientjes@google.com>
Message-ID-Hash: 6JGUTZ4TS3ERNHJRW5CRRYQRHY4CIRFD
X-Message-ID-Hash: 6JGUTZ4TS3ERNHJRW5CRRYQRHY4CIRFD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6JGUTZ4TS3ERNHJRW5CRRYQRHY4CIRFD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 1:51 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > On 21-01-30 15:51:49, David Rientjes wrote:
> > > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > >
> > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > +{
> > > > + const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > +
> > > > + cxlm->mbox.payload_size =
> > > > +         1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > +
> > > > + /* 8.2.8.4.3 */
> > > > + if (cxlm->mbox.payload_size < 256) {
> > > > +         dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > +                 cxlm->mbox.payload_size);
> > > > +         return -ENXIO;
> > > > + }
> > >
> > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and
> > > return ENXIO if true?
> >
> > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > driver not allow it?
> >
>
> Because the spec disallows it :)

Unless it causes an operational failure in practice I'd go with the
Robustness Principle and be liberal in accepting hardware geometries.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
