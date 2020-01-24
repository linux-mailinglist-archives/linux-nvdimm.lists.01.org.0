Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40982148DBC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jan 2020 19:26:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84EC31007B8FC;
	Fri, 24 Jan 2020 10:29:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C82FC1007B8F9
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 10:29:29 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g64so2504503otb.13
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jan 2020 10:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8o++U1OmXpf2JE6b6QRiJ0bOENUzj7zTAOxMX0rWlok=;
        b=YU2azlWvgcA7FOt8vcFjC6cHg3FCwutokUVpbsMDptk7DpseCRgMvu9HKVvALhWPyy
         ICSg+RfNl/vtaUMoUBOpcHeLwfHHLY1gu2KwfL+zL45prxQStNJG6rKaEQsXpDoCoz9M
         ki9vrsHd1GnU7eMN/n4GSC2eWmjn/fAD+nG5uMseEgFAjt4upSOjIRFZconsqIGhPsYg
         UT+nwvRjsFWBVx2zYlTKqolmzat1Cl5zwi8dzrOtme0BkwdDZ9FVwrlOzcLl/uMBiZXS
         HUGhAOh1JC7nr4yR1TJpekgyKsHIttDAP1Xcx5H3zBCkmmCw8Gu1JCEGHU5CwmJ3+8kU
         QP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8o++U1OmXpf2JE6b6QRiJ0bOENUzj7zTAOxMX0rWlok=;
        b=HPz/+R3FrWSVNz7n8MELJZLEp6LC0UV/vQT8tJ82dfoDZkDi6Bv2job+ApJxbbUsAa
         FgVRtgDM72UHP1WhY/i+VkVkBXfCoNfXCgJLg4d0tYaz4GN8gBxLh2+Agf7kubYb3jaw
         lYEUdTvmZt83EataUfEBb7nw+T497qEKwqAJf0iSOMM/zvPiX4zaWkVIZJOS1aUh2dsS
         2ZX0zFzHXBf2MX12yDcAXVwsXu26xhgPL66Byk4xvc9C3zEUpLdC8dw/f8c2HrgDON1c
         olywWOtwtrJIjzJF/Ztgm+EEmgjXoDV6kztB5fIcT0jJ0p9pjgBZgSLSD2OzWJnnCnRv
         IbSw==
X-Gm-Message-State: APjAAAVhn5Y95A5MuIOcdwd1nopYnXLcPY7nwucqlQBodRXCuNSgP7ow
	7MAXdk34MTi/sdUEVBsDJbYjKZAzSd0Up6iNfH02CA==
X-Google-Smtp-Source: APXvYqykgaY5Iw/3p878fhnSLc22PkG7WoQ+Y/sslWkhJ7Odm93sCb9/yxa3uTZg6M/q45CXWPp/DPa6eHPCz4PJUaY=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr3806090otk.363.1579890370532;
 Fri, 24 Jan 2020 10:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
 <20200120140749.69549-2-aneesh.kumar@linux.ibm.com> <CAPcyv4jcZhQcKr=0OGWc1aZb0OQ1ws2edd-LZMR-EJ_Z2174Sg@mail.gmail.com>
 <5fd11235-5f26-b10a-140f-ef24214c85b1@linux.ibm.com> <CAPcyv4jP3S0h9vUVVU16ipeauXyaW3qxUdridagA4SNJ1UW+Vw@mail.gmail.com>
 <cb71528e-0ea9-cb56-6b51-ae7a5231ad54@linux.ibm.com>
In-Reply-To: <cb71528e-0ea9-cb56-6b51-ae7a5231ad54@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 Jan 2020 10:25:59 -0800
Message-ID: <CAPcyv4jPBfhC4t5+e2gxhzKfaLdQi_qTKfLEcXdo-MjTA5a+aw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: HAZH2WMJIECXR7RCSV52Q5V7SXYT6QT5
X-Message-ID-Hash: HAZH2WMJIECXR7RCSV52Q5V7SXYT6QT5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HAZH2WMJIECXR7RCSV52Q5V7SXYT6QT5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 24, 2020 at 9:07 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 1/24/20 10:15 PM, Dan Williams wrote:
> > On Thu, Jan 23, 2020 at 11:34 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 1/24/20 11:27 AM, Dan Williams wrote:
> >>> On Mon, Jan 20, 2020 at 6:08 AM Aneesh Kumar K.V
> >>>
> >>
> >> ....
> >>
> >>>>
> >>>> +unsigned long arch_namespace_map_size(void)
> >>>> +{
> >>>> +       return PAGE_SIZE;
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(arch_namespace_map_size);
> >>>> +
> >>>> +
> >>>>    static void __cpa_flush_all(void *arg)
> >>>>    {
> >>>>           unsigned long cache = (unsigned long)arg;
> >>>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >>>> index 9df091bd30ba..a3476dbd2656 100644
> >>>> --- a/include/linux/libnvdimm.h
> >>>> +++ b/include/linux/libnvdimm.h
> >>>> @@ -284,4 +284,5 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
> >>>>    }
> >>>>    #endif
> >>>>
> >>>> +unsigned long arch_namespace_map_size(void);
> >>>
> >>> This property is more generic than the nvdimm namespace mapping size,
> >>> it's more the fundamental remap granularity that the architecture
> >>> supports. So I would expect this to be defined in core header files.
> >>> Something like:
> >>>
> >>> diff --git a/include/linux/io.h b/include/linux/io.h
> >>> index a59834bc0a11..58b3b2091dbb 100644
> >>> --- a/include/linux/io.h
> >>> +++ b/include/linux/io.h
> >>> @@ -155,6 +155,13 @@ enum {
> >>>    void *memremap(resource_size_t offset, size_t size, unsigned long flags);
> >>>    void memunmap(void *addr);
> >>>
> >>> +#ifndef memremap_min_align
> >>> +static inline unsigned int memremap_min_align(void)
> >>> +{
> >>> +       return PAGE_SIZE;
> >>> +}
> >>> +#endif
> >>> +
> >>
> >>
> >> Should that be memremap_pages_min_align()?
> >
> > No, and on second look it needs to be a common value that results in
> > properly aligned / sized namespaces across architectures.
> >
> > What would it take for Power to make it's minimum mapping granularity
> > SUBSECTION_SIZE? The minute that the minimum alignment changes across
> > architectures we lose compatibility.
> >
> > The namespaces need to be sized such that the mode can be changed freely.
> >
>
> Linux on ppc64 with hash translation use just one page size for direct
> mapping and that is 16MB.

Ok, I think this means that the dream of SUBSECTION_SIZE being the
minimum compat alignment is dead, or at least a dream deferred.

Let's do this, change the name of this function to:

    memremap_compat_align()

...and define it to be the max() of all the alignment constraints that
the arch may require through either memremap(), or memremap_pages().
Then, teach ndctl to make its default alignment compatible by default,
16MiB, with an override to allow namespace creation with the current
architecture's memremap_compat_align(), exported via sysfs, if it
happens to be less then 16MiB. Finally, cross our fingers and hope
that Power remains the only arch that violates the SUBSECTION_SIZE
minimum value for memremap_compat_align().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
