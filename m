Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D1152206
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 22:43:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B25561007B1F3;
	Tue,  4 Feb 2020 13:47:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D694E1007B1F1
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 13:47:07 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 77so18670812oty.6
        for <linux-nvdimm@lists.01.org>; Tue, 04 Feb 2020 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4sd+ZATda3xgd2Cabp+ey5GfoagpPrGA3dH0HD9uD4=;
        b=om0IxymUwPkvWyb01X9tGRJ2/DQx9Zp+ONzq9K7omFBcxtLbIr+tzBJigBSQmHj8ji
         gecf238XvqhNWCuCqz2KAnrN3hTNL031wGf8u0cF3krNJjO2TYR57Dh5Iw9/Q50LRnkl
         QuE9a58jgymDElHyDs9NcX4/me9PQ561Fcz/F9UKFm3td3WJmgu2NBt2/IM50iZA2jYR
         ynmSHN6PcWaa83ih4P3Dpic9Y+SrcIIVXw5jNyh5WQPZRLL9gyDTVPllEJgs5elyQq2f
         f0vXXrc67OfZVvCrI/PryDxZ6ot5Kg/9J5OGoqR0kSXlTMTH4V1nKwTKuhVR/rFzH6xV
         XGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4sd+ZATda3xgd2Cabp+ey5GfoagpPrGA3dH0HD9uD4=;
        b=S2xw/dpUvvOlecv2NV2nd5EtB0svmGjBJ4D+sDv5Ibjl/sqWAWZRz9t10OTICxmdvx
         kGbtGVQKkcuE/ybLzLXqRW3nQYLThLBIUun4/heDYxnJq/6qOm4od5r4uDqgJuIAs6TC
         oR8R9J3nTTNKx/GunrpbfPmmWn4yHGODPBf67Fu/fFknnRhvmYTA5KXHtMKa96iavEWS
         lsSxTTS7wWxhXAZheZYqkB840oCHQJBTLXO3ui0KjMc/oYWon3AQW3rccHVjLeoaj3Tp
         Qnl/w1o20rH+4jyNNYuQfTdyy/TrbiqjBHuCIT/iSoaY92XOromA74yWlyvaxOP9OuSP
         XSqA==
X-Gm-Message-State: APjAAAU+04Od2vxh1W5fia+dNfjoCkDrN20UljK9MJFd5ODxug8bKrNV
	2qoTGeSMQsghi/5gXXja8QcPzamv7POtoazYj/pwAQ==
X-Google-Smtp-Source: APXvYqyzRa/EgbcHWU5oWYs3EwkkIOeOuYIq70nRVJ+YY8OVe8Drtam8ArdPOslMqNhBe4zCRcUBk63gv56UchKAyW4=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr24222626otk.363.1580852628908;
 Tue, 04 Feb 2020 13:43:48 -0800 (PST)
MIME-Version: 1.0
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-11-joao.m.martins@oracle.com> <e605fed8-46f5-6a07-11e6-2cc079a1159b@google.com>
 <CAPcyv4iiSsEOsfEwLQcV3bNDjBSxw1OgWoBdEWPQEymq6=xm-A@mail.gmail.com> <ae788015-616f-96e6-3a0e-39c1911c4b01@google.com>
In-Reply-To: <ae788015-616f-96e6-3a0e-39c1911c4b01@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 4 Feb 2020 13:43:37 -0800
Message-ID: <CAPcyv4ibWZgCSTqnYLicVR3vXeNKwuWSnV5K8fCwvyhz_h=0GQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] nvdimm/e820: add multiple namespaces support
To: Barret Rhoden <brho@google.com>
Message-ID-Hash: RHT43YYBUL74YDJ33WQQPWL4LBAM36MR
X-Message-ID-Hash: RHT43YYBUL74YDJ33WQQPWL4LBAM36MR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, KVM list <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RHT43YYBUL74YDJ33WQQPWL4LBAM36MR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2020 at 10:20 AM Barret Rhoden <brho@google.com> wrote:
>
> Hi -
>
> On 2/4/20 11:44 AM, Dan Williams wrote:
> > On Tue, Feb 4, 2020 at 7:30 AM Barret Rhoden <brho@google.com> wrote:
> >>
> >> Hi -
> >>
> >> On 1/10/20 2:03 PM, Joao Martins wrote:
> >>> User can define regions with 'memmap=size!offset' which in turn
> >>> creates PMEM legacy devices. But because it is a label-less
> >>> NVDIMM device we only have one namespace for the whole device.
> >>>
> >>> Add support for multiple namespaces by adding ndctl control
> >>> support, and exposing a minimal set of features:
> >>> (ND_CMD_GET_CONFIG_SIZE, ND_CMD_GET_CONFIG_DATA,
> >>> ND_CMD_SET_CONFIG_DATA) alongside NDD_ALIASING because we can
> >>> store labels.
> >>
> >> FWIW, I like this a lot.  If we move away from using memmap in favor of
> >> efi_fake_mem, ideally we'd have the same support for full-fledged
> >> pmem/dax regions and namespaces that this patch brings.
> >
> > No, efi_fake_mem only supports creating dax-regions. What's the use
> > case that can't be satisfied by just specifying multiple memmap=
> > ranges?
>
> I'd like to be able to create and destroy dax regions on the fly.  In
> particular, I want to run guest VMs using the dax files for guest
> memory, but I don't know at boot time how many VMs I'll have, or what
> their sizes are.  Ideally, I'd have separate files for each VM, instead
> of a single /dev/dax.
>
> I currently do this with fs-dax with one big memmap region (ext4 on
> /dev/pmem0), and I use the file system to handle the
> creation/destruction/resizing and metadata management.  But since fs-dax
> won't work with device pass-through, I started looking at dev-dax, with
> the expectation that I'd need some software to manage the memory (i.e.
> allocation).  That led me to ndctl, which seems to need namespace labels
> to have the level of control I was looking for.

Ah, got it, you only ended up at wanting namespace labels because
there was no other way to carve up device-dax. That's changing as part
of the efi_fake_mem= enabling and I have a patch set in the works to
allow discontiguous sub-divisions of a device-dax range. Note that is
this branch rebases frequently:

https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending


>
> Thanks,
>
> Barret
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
