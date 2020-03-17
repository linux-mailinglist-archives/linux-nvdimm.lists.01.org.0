Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCE1890FD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Mar 2020 23:05:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3392510FC338E;
	Tue, 17 Mar 2020 15:05:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C239910FC3166
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 15:05:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 13so14651209oiy.9
        for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY+guVjbAMZU5uOESZLzfUGHTA73g3d/loWemG4Z+tE=;
        b=DgVudzFUJBGxeDF2iH5mheVO+tEr9voArIx64eJyZEBBg7cRUGb+cj/MjOf9oq3B2R
         QJIL+lhTJMNAQ2ngIH0YwrqRSHxOD/fXTbGSyUUiG2SG3d9V05oxPGTwun4uO4gi4IlX
         WxNQwPnIrSGREpuL3ogprgQmp5jDmU634+TUNER/9IW612bYKA/Y0kZDlnRh7OPIc7fZ
         N3HkePiHhMsx27VQXonJFl9bdxeB0ntQKwRhkKFQ/5Yysl6eRd32am9KSXxFsta5qcIo
         i3a8vj0Uaqxhll7rOfD9Qno75Qopvm5OE8wtwmN62BUdRv/lvuW7wYkuuokxAAcPHEuO
         2jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY+guVjbAMZU5uOESZLzfUGHTA73g3d/loWemG4Z+tE=;
        b=neeCXgVm2JXJBwdMeam3dShVKAPIpfYrTeWo2GadQ2pyKwn75ZcXWIInaWLR46B6bH
         8XRw49BJpeCvsy86pB9sG240PywRsrlLLzQ+9h82gvsYxNrMV2Fuqk5J/yTXPcFj1qRl
         qaZnIQuVnJX9b1JkyYyGbQJjQnBDZGm031b0IDd6OsrgAfb1wWu/xRzXTB4YdDcgeY/Z
         LFIImS5DssOyLrwDila4SOWNgupwE6f8vdxOwaSdx6LfGU3RvQZf/ywEOIvC1TeReUrV
         TozrhvYGmhw21dl6zYML0cj+xANfedeK+afXoPYGH4kxL+L7yS1ugiNUm0ZhMdZ5XD0i
         zmbQ==
X-Gm-Message-State: ANhLgQ0RzxcpAyBIkh4VZ1pFjRQ1aviqxKUIhnr5Wedkl7ZgaN4UaPxB
	db6y2ZLNuM2w4jW7esm2MOmZq2aFZuKp+UtWjLpPfw==
X-Google-Smtp-Source: ADFU+vsQvOL9wprxrkAHycoZPlNxRbxXsmPicT5n7p0w61/VCYW5GHZo0bAl/D1XuM3Nq16vsV01jj1nZ/5wYharha8=
X-Received: by 2002:aca:4d8:: with SMTP id 207mr838171oie.70.1584482698821;
 Tue, 17 Mar 2020 15:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318762012.2216124.16408566404290491508.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1848cdb9-8c19-d7fe-870c-175bd60bc364@amd.com>
In-Reply-To: <1848cdb9-8c19-d7fe-870c-175bd60bc364@amd.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Mar 2020 15:04:48 -0700
Message-ID: <CAPcyv4goRP8EAfMX8oOANgzgm3Pn=wES42MCDXbP_x__-GW52g@mail.gmail.com>
Subject: Re: [PATCH 4/5] resource: Report parent to walk_iomem_res_desc() callback
To: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID-Hash: RPD2AD3HGL4QKBKQVZZ3JQHH5CVYNXZH
X-Message-ID-Hash: RPD2AD3HGL4QKBKQVZZ3JQHH5CVYNXZH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RPD2AD3HGL4QKBKQVZZ3JQHH5CVYNXZH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 5, 2020 at 6:42 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/2/20 4:20 PM, Dan Williams wrote:
> > In support of detecting whether a resource might have been been claimed,
> > report the parent to the walk_iomem_res_desc() callback. For example,
> > the ACPI HMAT parser publishes "hmem" platform devices per target range.
> > However, if the HMAT is disabled / missing a fallback driver can attach
> > devices to the raw memory ranges as a fallback if it sees unclaimed /
> > orphan "Soft Reserved" resources in the resource tree.
> >
> > Otherwise, find_next_iomem_res() returns a resource with garbage data
> > from the stack allocation in __walk_iomem_res_desc() for the res->parent
> > field.
>
> Just wondering if we shouldn't just copy the complete resource struct and
> just override the start and end values? That way, if some code in the
> future wants to look at sibling or child values, another change isn't needed.
>
> Just a thought.

Thanks for taking a look. I think it's ok to come update this again if
that need arises.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
