Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F7148C76
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jan 2020 17:46:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3B2D10097E04;
	Fri, 24 Jan 2020 08:49:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E5CFE10097E02
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 08:49:20 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id r16so2221613otd.2
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vx32s1QrcrR1CE45A5+ztz3JWzyujxM7S4tHTiGrQ6s=;
        b=ulmPI/+5gDxlL5EMXmUmJof04etydvLJjFrBRJa3GAzzprltI7yDtsDiZ4uQd14vO0
         blwDwp+HOJINILBA9f9Cgu4VXZtvUvtHvCRQ+gqrm6BZ7kyGIWX7vrwjGE0jUm1MXTq2
         N7nrC3DhytFjVd5uDYI89Ew/96ql0EXsocP1oF9rERuBxFaP4jX+mNkuG/UwmR28sJhH
         tG93jESmtAGQ8iqox34vZhvU6ADa3GEoOQ6pksYEnZeLZTQQFc1PaTly8ZtPxHnmxZZc
         3oBQxbqIeIPf3dENx/bHu76rOEWSTW+JyGgkchcHRwkucxfvijXOc6JskMCvmhL4l/P/
         e6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vx32s1QrcrR1CE45A5+ztz3JWzyujxM7S4tHTiGrQ6s=;
        b=G2N/Pkc1Mosi+XTO/pv0taDsJZHQWUrgoQvZHGNqfaIHrHMDmaSp5n58ED6JoGLrC4
         kp92FPtA85f5sJTJMuOgUxCwSRnoVWogfpi7IZ+vwTEb39w34Aea1x2rstmzx2gKfG6r
         fzQRIRHLMjkain8g/s5Bg9E08FuBFHh8vBM76rvN2E02t2SzbRn8OXeQFf5WedJBNCYr
         ngs9grLkW2mSsr+NNkea2Ii/LlIu2Vum/tj51VU3C1+oFf61+5hUHr49WJVg1t2onqYC
         1klqZ4r2NJ75NZg3WNHDUhhCtt+N98cZ3HOL/WmVUMYZiN4lzWX3bfGCWEYJl03Qn9W8
         jWig==
X-Gm-Message-State: APjAAAWojq/EjjVfPyBoPWh3MJqzrYktg3riAC9pISYqLuI76jUTEgQh
	3e06c0NyucU248+UIMGyZjifcpfJSDNbesnMn7t2ww==
X-Google-Smtp-Source: APXvYqzGKqBnAJBuibbEZGdKZNPU3lEf95MPBnTrB8xPgN2lx5i+KeP9tgQeT9ZmW3GEY2OnZ4MwY5fVogobDXDptLc=
X-Received: by 2002:a9d:1284:: with SMTP id g4mr573667otg.207.1579884361270;
 Fri, 24 Jan 2020 08:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
 <20200120140749.69549-2-aneesh.kumar@linux.ibm.com> <CAPcyv4jcZhQcKr=0OGWc1aZb0OQ1ws2edd-LZMR-EJ_Z2174Sg@mail.gmail.com>
 <5fd11235-5f26-b10a-140f-ef24214c85b1@linux.ibm.com>
In-Reply-To: <5fd11235-5f26-b10a-140f-ef24214c85b1@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 Jan 2020 08:45:50 -0800
Message-ID: <CAPcyv4jP3S0h9vUVVU16ipeauXyaW3qxUdridagA4SNJ1UW+Vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: RSD4BXJ2KI6NPXFSNFF6Z6SAIP7SZUTG
X-Message-ID-Hash: RSD4BXJ2KI6NPXFSNFF6Z6SAIP7SZUTG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RSD4BXJ2KI6NPXFSNFF6Z6SAIP7SZUTG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 23, 2020 at 11:34 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 1/24/20 11:27 AM, Dan Williams wrote:
> > On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
> >
>
> ....
>
> >>
> >> +unsigned long arch_namespace_map_size(void)
> >> +{
> >> +       return PAGE_SIZE;
> >> +}
> >> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
> >> +
> >> +
> >>   static void __cpa_flush_all(void *arg)
> >>   {
> >>          unsigned long cache = (unsigned long)arg;
> >> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >> index 9df091bd30ba..a3476dbd2656 100644
> >> --- a/include/linux/libnvdimm.h
> >> +++ b/include/linux/libnvdimm.h
> >> @@ -284,4 +284,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
> >>   }
> >>   #endif
> >>
> >> +unsigned long arch_namespace_map_size(void);
> >
> > This property is more generic than the nvdimm namespace mapping size,
> > it's more the fundamental remap granularity that the architecture
> > supports. So I would expect this to be defined in core header files.
> > Something like:
> >
> > diff --git a/include/linux/io.h b/include/linux/io.h
> > index a59834bc0a11..58b3b2091dbb 100644
> > --- a/include/linux/io.h
> > +++ b/include/linux/io.h
> > @@ -155,6 +155,13 @@ enum {
> >   void *memremap(resource_size_t offset, size_t size, unsigned long flags);
> >   void memunmap(void *addr);
> >
> > +#ifndef memremap_min_align
> > +static inline unsigned int memremap_min_align(void)
> > +{
> > +       return PAGE_SIZE;
> > +}
> > +#endif
> > +
>
>
> Should that be memremap_pages_min_align()?

No, and on second look it needs to be a common value that results in
properly aligned / sized namespaces across architectures.

What would it take for Power to make it's minimum mapping granularity
SUBSECTION_SIZE? The minute that the minimum alignment changes across
architectures we lose compatibility.

The namespaces need to be sized such that the mode can be changed freely.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
