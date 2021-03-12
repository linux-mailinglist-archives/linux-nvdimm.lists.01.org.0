Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B084B33849F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 05:21:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC5C0100F2275;
	Thu, 11 Mar 2021 20:21:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=pankaj.gupta@cloud.ionos.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 63A58100ED4AE
	for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 20:21:29 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u4so43595748lfs.0
        for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2UujaTrfRHurTxUIOvZX13ebBTXXB4ge6ZkHfxLOJc=;
        b=jRRWw3s+gDc/TM2KGngoCnT4EjieGWpZy4OsQuPBtoG18gNVuRVl4PTaoCZ3Al7gAc
         2BA9iFvVVYkQzCYibz4t50KOVphhUtnrLKVDI6Kl4U1Ka4CefhSyt/C1X5E0b9WRHq71
         n0/51GvL/E8k2pOFzsn4LStIJusD/pGkfjoOF/MxwhTyffrmjqE56xv0z+XkkXmUFfi0
         5UImo4mvljVZ79utr2/uY/cpw2LVPbxsnP1ldcc4qs8dHRABFJgNL7AcQnZBuw9gKPJP
         CGn25eBHcs48/nG8aQFF/+J4/cSzwtxvmZ3RIJkZesN7EmawZ4lSu7tYtX7d9DWnKJLC
         BFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2UujaTrfRHurTxUIOvZX13ebBTXXB4ge6ZkHfxLOJc=;
        b=hqZLD9Or6eBXoEy25N2gzZWY1jjU6sxmpc0X6ui19GRpBwP5p4msBed9P+ORrmXbKs
         hTNRR/bkrDKGymu7KxwGAArv1ca7l5/kIR7zlik/mi/Xg8+h/DeTlfan47lErkhP/dVf
         AnTT8Ua1+R70m/CSdhrJz7qWGZV9T9vk3srhGr/I/eH4fJOR8eR+uqCKGVLKwym6XU44
         V/gl8PXxm8iZ1f5y/Eff7V4gCH5SiGzqftMRjxHabO0XyFspqsTe1TdrBbYHT18UAO/I
         Q5Aoez0vUajahWd5M/vsVmAkr5UynqrZXHiVo8hxv1y2mJZIzN3gklUlUWW1AMhbRPW1
         qIXA==
X-Gm-Message-State: AOAM532paRM0evFJOaTWXg7nWVxTo5LBT+wJzlF6tmwE7zNhlRVJKIHS
	sNMrkT1UPezN+/AB9c6Y/b5JX7VDi9Pb32XjthwiOw==
X-Google-Smtp-Source: ABdhPJxEsTRa+p/GJ5b3jEaXi5W4gqiB8heDCJwqpk7DymhAA2BQLF3qfqtOWc53h8RKOPnbJzg2ZPABM9Qw9s00Dxo=
X-Received: by 2002:a19:6b10:: with SMTP id d16mr4104042lfa.540.1615522886724;
 Thu, 11 Mar 2021 20:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com> <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
In-Reply-To: <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
From: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Date: Fri, 12 Mar 2021 05:21:14 +0100
Message-ID: <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: 7SGIWDFR2OGBUXTAQT6JEQXBHWYYXNQN
X-Message-ID-Hash: 7SGIWDFR2OGBUXTAQT6JEQXBHWYYXNQN
X-MailFrom: pankaj.gupta@cloud.ionos.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7SGIWDFR2OGBUXTAQT6JEQXBHWYYXNQN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi David,

> >   Jeff reported preflush order issue with the existing implementation
> >   of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
> >   for virtio pmem using work queue as done in md/RAID. This patch series
> >   intends to solve the preflush ordering issue and also makes the flush
> >   asynchronous from the submitting thread POV.
> >
> >   Submitting this patch series for feeback and is in WIP. I have
> >   done basic testing and currently doing more testing.
> >
> > Pankaj Gupta (2):
> >    pmem: make nvdimm_flush asynchronous
> >    virtio_pmem: Async virtio-pmem flush
> >
> >   drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
> >   drivers/nvdimm/pmem.c        | 15 ++++----
> >   drivers/nvdimm/region_devs.c |  3 +-
> >   drivers/nvdimm/virtio_pmem.c |  9 +++++
> >   drivers/nvdimm/virtio_pmem.h | 12 +++++++
> >   5 files changed, 78 insertions(+), 27 deletions(-)
> >
> > [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> >
>
> Just wondering, was there any follow up of this or are we still waiting
> for feedback? :)

Thank you for bringing this up.

My apologies I could not followup on this. I have another version in my local
tree but could not post it as I was not sure if I solved the problem
correctly. I will
clean it up and post for feedback as soon as I can.

P.S: Due to serious personal/family health issues I am not able to
devote much time
on this with other professional commitments. I feel bad that I have
this unfinished task.
Just in last one year things have not been stable for me & my family
and still not getting :(

Best regards,
Pankaj
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
