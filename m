Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADA3385A1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 07:03:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6D16100EAB46;
	Thu, 11 Mar 2021 22:03:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FC0A100EAB44
	for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 22:03:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jt13so51192228ejb.0
        for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfCBCTaP1vXjkaRzljC2VcBZdRN8O9pFYDwkYEocyzU=;
        b=lxffCQD3jaOe97GKa/5NQMiB73O5eAi76/tyW3Pu+JhPNjDzbPRvMOyRY/aHQlUGnn
         cIhlguDTYjUgB4cjRxPgHONNDtBsJFAmJGEQhDXExPZJ/JOfXFozZ93HM5KsC67SyXY9
         c2W2orXhUnalqNJjPfemhU9vcAMz1Q8aiHcaEeIbMb5dKJOLyeROZpkzFjHxSkTfnGFT
         nzfJIr7OYETT2chi6BgSrS7wZUz0PUlm774qQ3az4YXGsWxy0C39CFsPyWcxVt8vXgNY
         7m0TQOLbGn9cflSRrjOfGL23t7JKa3GHFlJVARDcn7tHyyrmrAGYOadgzO1X82NnBvnb
         mibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfCBCTaP1vXjkaRzljC2VcBZdRN8O9pFYDwkYEocyzU=;
        b=HaXKyp6vlUTkbi4go2YUCIKbiFXjHqj+FRo6toyaxuZiK7f6lw8mHWqRstqO4QSmak
         vWIytjBTbtakr/E4fW9NOgy6R1IaGOfXI8QAP6R4R6aIlTugyvXvn+jQu5Fjh4UKM5Be
         X9LgaFizgefaIUl7pqDD7oZ2lLFfMSSkXAa6/eFVFvhdKG9hRuz6maYfrOl42waubdFz
         2xjPz7Vf2hxe1gvWccTNcLV9lvOByBXyy17JG3eTKtsg+JBTHms7enU21OMxzgLepyup
         0tx2LAVLlFO7/KkFMneiHFHfkK6kglxwFnn6bgNu44mY8R30P/TnO5z10fjcfiFhhBuV
         YzLg==
X-Gm-Message-State: AOAM531SEya32gzsVQyvajkJmBrD6QrzPY5ewS8R9Lleumr0B0z1JPMx
	6MziIGwUPYLVx1hSibrwOECQF8fdE5CCIFGrXHtyhA==
X-Google-Smtp-Source: ABdhPJxDQvayRA8ra9dwsMhMsScdFFOH6MxL7dzrw5+/N+8T56mvPYwThVzjLbUxJJ0BINW83E36ex9iut3BH0vYjNo=
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr6807846ejg.418.1615528982973;
 Thu, 11 Mar 2021 22:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
 <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com> <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
In-Reply-To: <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Mar 2021 22:02:52 -0800
Message-ID: <CAPcyv4i4=2zT65Ym-sQv4gSa421q7FUAcX6Un3hf8=FW5qi3yw@mail.gmail.com>
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Message-ID-Hash: MRDI3B4YR7A5VS4BBF4ZQLJXAEHDWW52
X-Message-ID-Hash: MRDI3B4YR7A5VS4BBF4ZQLJXAEHDWW52
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MRDI3B4YR7A5VS4BBF4ZQLJXAEHDWW52/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 11, 2021 at 8:21 PM Pankaj Gupta
<pankaj.gupta@cloud.ionos.com> wrote:
>
> Hi David,
>
> > >   Jeff reported preflush order issue with the existing implementation
> > >   of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
> > >   for virtio pmem using work queue as done in md/RAID. This patch series
> > >   intends to solve the preflush ordering issue and also makes the flush
> > >   asynchronous from the submitting thread POV.
> > >
> > >   Submitting this patch series for feeback and is in WIP. I have
> > >   done basic testing and currently doing more testing.
> > >
> > > Pankaj Gupta (2):
> > >    pmem: make nvdimm_flush asynchronous
> > >    virtio_pmem: Async virtio-pmem flush
> > >
> > >   drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
> > >   drivers/nvdimm/pmem.c        | 15 ++++----
> > >   drivers/nvdimm/region_devs.c |  3 +-
> > >   drivers/nvdimm/virtio_pmem.c |  9 +++++
> > >   drivers/nvdimm/virtio_pmem.h | 12 +++++++
> > >   5 files changed, 78 insertions(+), 27 deletions(-)
> > >
> > > [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> > >
> >
> > Just wondering, was there any follow up of this or are we still waiting
> > for feedback? :)
>
> Thank you for bringing this up.
>
> My apologies I could not followup on this. I have another version in my local
> tree but could not post it as I was not sure if I solved the problem
> correctly. I will
> clean it up and post for feedback as soon as I can.
>
> P.S: Due to serious personal/family health issues I am not able to
> devote much time
> on this with other professional commitments. I feel bad that I have
> this unfinished task.
> Just in last one year things have not been stable for me & my family
> and still not getting :(

No worries Pankaj. Take care of yourself and your family. The
community can handle this for you. I'm open to coaching somebody
through what's involved to get this fix landed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
