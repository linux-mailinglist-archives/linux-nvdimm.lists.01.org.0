Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D641FA070
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jun 2020 21:41:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC6B0110E5FDE;
	Mon, 15 Jun 2020 12:41:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DA7C110E5FD9
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 12:41:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c35so12411695edf.5
        for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4s29RXI4DZmoz7Uu9spIoKDjM10KzT1NJ7eoQ6iGuKQ=;
        b=O0zD/ignX49ZyEfuD6nUnsJTM4Z2o6FY8NMNsDmSNfe6aQVWNrOXTRTPjuGCOQ7uCB
         k9fwQ/N07Of5R++0Wqywf7IkNDOTgpQYrKqFq25Z4tEh9kpSx0iQG8sB0skjvtknQbe8
         LAlKIYFmc59bA3kzhgA6+V+U1gaq//XY0YNfP9M1mcKrtpnepdygD4ppBX7FT2nrwDnH
         SQHjoOUEzTNzr7VSEmdqRr8gky5IcYTdj1QWaJduNkBbFQDElcSFHxEf5PNUM5ITYStm
         7DRJEHhlCSLXRKelwGOwYMezexaBwP1VefdC3djrn0BKXNFFcPnyNgUmAm3/YL88FCYy
         QPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4s29RXI4DZmoz7Uu9spIoKDjM10KzT1NJ7eoQ6iGuKQ=;
        b=WlN7QAprDpLvjND0lDNID+PWoGr3T3HPJEl7yi8/LWGQtMzbRKLlCRyYr2eWPhAE0t
         wu/BQBKZ4DSONTjxSHI55/voE9O5CE9B4hbrA3RyAGSM5k4Nqgz1oyuVkwGIkx0/oZv2
         vEJH3gBaNC3yGZMf5IhuNYHWLxKVlHgsVu4NpXEQlF02Skqi5pZkRFfUiL+t07G38fua
         pCIEKAMTbTEjvqlFhTrq3Hk3A8FKfSSgf1WgVVqarkfTXLY20Y0149/pGhpW34+VORl1
         Wt3FYX1jywYrh1yBxzj7nFNkkSGM/7XyTMnkKHNaNbhDH4o7qjxsuDn47IAxXbSq8DZE
         bncQ==
X-Gm-Message-State: AOAM532KhY0ULTNzQZu+q4dm0Z/eE16WaBzOZ7JUS4OPCyP3lnMl4N94
	n45bVWjp/he50koh9N4t5Q+Es+k4/9aCi+44ANoTwQ==
X-Google-Smtp-Source: ABdhPJw7gZGRCrEp8Uckb0OtIxiFQkW6W0bIFXefK59EdVk9QlmbMAZVSR15quYWqkF3RICuTtvR0uovNicOGRMtPBI=
X-Received: by 2002:a50:c359:: with SMTP id q25mr26045616edb.123.1592250060573;
 Mon, 15 Jun 2020 12:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615124407.32596-1-vaibhav@linux.ibm.com> <20200615124407.32596-3-vaibhav@linux.ibm.com>
 <20200615125552.GI14668@zn.tnic>
In-Reply-To: <20200615125552.GI14668@zn.tnic>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 15 Jun 2020 12:40:49 -0700
Message-ID: <CAPcyv4gmAk=mRCVQCgdSEN9JQ9b+C_u0xug-knZpQmGNL_ywxA@mail.gmail.com>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
To: Borislav Petkov <bp@alien8.de>
Message-ID-Hash: NHNTITWIOHRL2MM3N43JZ2EYTSTSLBJX
X-Message-ID-Hash: NHNTITWIOHRL2MM3N43JZ2EYTSTSLBJX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NHNTITWIOHRL2MM3N43JZ2EYTSTSLBJX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 15, 2020 at 5:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Jun 15, 2020 at 06:14:03PM +0530, Vaibhav Jain wrote:
> > 'seq_buf' provides a very useful abstraction for writing to a string
> > buffer without needing to worry about it over-flowing. However even
> > though the API has been stable for couple of years now its still not
> > exported to kernel loadable modules limiting its usage.
> >
> > Hence this patch proposes update to 'seq_buf.c' to mark
> > seq_buf_printf() which is part of the seq_buf API to be exported to
> > kernel loadable GPL modules. This symbol will be used in later parts
> > of this patch-set to simplify content creation for a sysfs attribute.
> >
> > Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> > Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> > Changelog:
> >
> > v12..v13:
> > * None
> >
> > v11..v12:
> > * None
>
> Can you please resend your patchset once a week like everyone else and
> not flood inboxes with it?

Hi Boris,

I gave Vaibhav some long shot hope that his series could be included
in my libnvdimm pull request for -rc1. Save for a last minute clang
report that I misread as a gcc warning, I likely would have included.
This spin is looking to address the last of the comments I had and
something I would consider for -rc2. So, in this case the resends were
requested by me and I'll take the grumbles on Vaibhav's behalf.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
