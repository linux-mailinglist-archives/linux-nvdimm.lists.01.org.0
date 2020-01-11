Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A2137B6E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Jan 2020 05:55:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D79531007B8C0;
	Fri, 10 Jan 2020 20:59:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6687210096CAC
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 20:59:14 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id r9so4055767otp.13
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 20:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXw7+lmwxxGW0pW3Lab+hpREo++qohaUzd19RBqCoKA=;
        b=kojBvxELyYGWWAc/77rNWYrUSn6AH9BEDZAg875w0dJasG5wADCzZ0TrQz8Lhlec46
         C8x8nkpfjtUXcxyP7w4hBONLRzI7OImpA8VVQ+KQz0m3N6y2guOAOQmxN0MJwFZ3XHEG
         m2KyOHLn4bg5oHxw1gKUmT0gvi7DTmk7xB40F4SPZPAIllXcXNxeo/pcVrj+2X4BU8Hi
         sbm9RnHrxRY69yEkgfabT+fT6ZegNHIIb+PHd/AJgGRYVG47gVvkpcPD98eqVjyiclXC
         lGBckyRMoslduNyfoll1Q5ejfhvtYHc6B740cPhls9PW34vNPj+m9yITDhgGx/NW+Op2
         ssHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXw7+lmwxxGW0pW3Lab+hpREo++qohaUzd19RBqCoKA=;
        b=QhaQHpAo8LCeAR7xzUAn26QAcoI6eh6UYRzGd3EvjZi3QB13xxRsW9bsv9OC5Lh6VL
         6IUGlnck+MDWMvKvOhf5htcQnTdAXFtah6qvdKwQvyboOPJZQKpdsHlWZn9BMV+DTIRR
         fjlyG1OxZflKN6sCXrSzf5zt/WuNCdUyu5AKrd/h4bti227Aot4vFk775SJEMks+5c5J
         B4TUoCstj5z/B8JFhyPq/RGYAH4DEN5MxbmZl3Z18ei+u8UV871yFpKQo26fToicL4Y6
         akivRsc/QCbshPT8prCTEiD1t+1C7DA6xR1YdsE4Wm9lKy3ichdXIzNUujD591p0I6Mm
         cdSA==
X-Gm-Message-State: APjAAAU+0i/PxLkHgtMA46ZI77FfMvKEm5a+9IdHxPnnpUHLBS8ov5RA
	R1u0Jpg9ff6mPp09GqpgvDpdTncV8GiHI0Klwz/qPQ==
X-Google-Smtp-Source: APXvYqztZUwMmGPluzhv4MCHVJzT4kLaj+aPPjdSNnXZp6j2pZ6cvLnIMxs30I0/ASwFjgll57VoxvcEkTkR6X9aiY4=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr5461736oto.207.1578718554461;
 Fri, 10 Jan 2020 20:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20200108065219.171221-1-aneesh.kumar@linux.ibm.com>
 <x49muavm4gx.fsf@segfault.boston.devel.redhat.com> <253f7f57-d27f-91f1-4e99-ff69a0e88084@linux.ibm.com>
In-Reply-To: <253f7f57-d27f-91f1-4e99-ff69a0e88084@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jan 2020 20:55:43 -0800
Message-ID: <CAPcyv4jKC=TBYh7pnF__iHNpcunifcRKhz4eQ3t86uCd4ZNNwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: NMXTG4P5FQ53XDSES7HM2SUVF32OA3QR
X-Message-ID-Hash: NMXTG4P5FQ53XDSES7HM2SUVF32OA3QR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NMXTG4P5FQ53XDSES7HM2SUVF32OA3QR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 8:33 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 1/11/20 2:08 AM, Jeff Moyer wrote:
> > Hi, Aneesh,
> >
> > After applying this patch series, several of my namespaces no longer
> > enumerate:
> >
> > Before:
> >
> > # ndctl list
> > [
> >    {
> >      "dev":"namespace0.2",
> >      "mode":"sector",
> >      "size":106541672960,
> >      "uuid":"ea1122b2-c219-424c-b09c-38a6e94a1042",
> >      "sector_size":512,
> >      "blockdev":"pmem0.2s"
> >    },
> >    {
> >      "dev":"namespace0.1",
> >      "mode":"fsdax",
> >      "map":"dev",
> >      "size":10567548928,
> >      "uuid":"68b6746f-481a-4ae6-80b5-71d62176606c",
> >      "sector_size":512,
> >      "align":4096,
> >      "blockdev":"pmem0.1"
> >    },
> >    {
> >      "dev":"namespace0.0",
> >      "mode":"fsdax",
> >      "map":"dev",
> >      "size":52850327552,
> >      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
> >      "sector_size":512,
> >      "align":2097152,
> >      "blockdev":"pmem0"
> >    }
> > ]
> >
> > After:
> >
> > # ndctl list
> > [
> >    {
> >      "dev":"namespace0.0",
> >      "mode":"fsdax",
> >      "map":"dev",
> >      "size":52850327552,
> >      "uuid":"6d3a0199-5d9a-4fed-830d-e25249b70571",
> >      "sector_size":512,
> >      "align":2097152,
> >      "blockdev":"pmem0"
> >    }
> > ]
> >
> > I won't have time to dig into it this week, but I wanted to mention it
> > before Dan merged these patches.
> >
> > I'll follow up next week with more information.
> >
>
> dmesg should contain details  like
>
> [    5.810939] nd_pmem namespace0.1: invalid size/SPA
> [    5.810969] nd_pmem: probe of namespace0.1 failed with error -95
>
> This is mostly due to the namespace start address not aligned to
> subsection size.
>
> "namespace0.2" not having a 2MB aligned size which cause namespace 0.1
> start addr to be not aligned. Hence both the namespace are marked disabled.
>

2 observations:

- It's ok if the namespace start address is not subsection aligned as
long as the mapped portion for data access is subsection aligned, at
least on x86.

- "sector" mode namespaces are not mapped by devm_memremap_pages() so
there should be no restriction there. If powerpc can't map them that's
a separate concern.

So, cross arch compatible namespaces is a goal, but not regressing
existing namespaces takes precedence. I'd be happy if newly created
namespaces tried to account for all the arch quirks, but if libnvdimm
can enable a namespace it should try.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
