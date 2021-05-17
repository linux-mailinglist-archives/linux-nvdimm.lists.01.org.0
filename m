Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F491383AC4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 19:10:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A7F4100EBB6A;
	Mon, 17 May 2021 10:10:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A513D100EBBD9
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 10:10:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b25so10315902eju.5
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQWXlUNmoTHMgeRbNpcw353UuhR2CLKe5FdjnZVXGlM=;
        b=MEuKGQDcHa03p1BmMKDjhFT95CSl32JRfaB96FXizPYf8Meixkj8IxaD9gMkTgPIO0
         XX1zZSj9S+z4pY43YRyS1MKao/+Jd+WrLUSpeMpoPnMOISUydf+tvToYznbDhtlUqb85
         NjcKzHx/H/ClqIOIsnNOdcsfQ4XoGgo1836ZoDs/IonhB+P4ArtjGac/C73ltMYlPmH4
         E3gqunowJ4mvgfMJ1UfCJEVd/F4p+ot+0aMEK4QEPGhMWi8StQGiCXkIKCHLyINRVCcM
         /xyxbz71vbZCFW7sW2y2y4g8gHNjodC9L6wxGHNO78BArRWFkGxW2KJ9TJOA43gHei3q
         s9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQWXlUNmoTHMgeRbNpcw353UuhR2CLKe5FdjnZVXGlM=;
        b=kpoytoyXWS8p+xnsu40MapBGggJ43WFpasQpEBgL6UGFX/vQ1quAV24cQOj/uzuCi1
         Yxf8JbRuPUoWA2PBaP+Ja+m2B+0JbH4xskaM6Qts3i9mAUcUH6PxStcel2IctuRcgTwN
         8jVWiedZL+d8LbbWW27z+rDVUQqxV9muaMI+Z/5J3VSGMiN5AV7bMk4dqzLKIRGHPlHD
         ZJaPSD7hvbjpL8yBpiLnqvKg+H7sJ6prQp2uz5CrA2lyNLL8Y1SQBGTqvHZ+D3wGO3zf
         /HLEQoRbXHlOC78sQml1wkdChUQPIIcowYemRnLS2LHuVvnBM/yQmVsCmp+XPBQNLMQS
         se8w==
X-Gm-Message-State: AOAM5330DUcI+EQIVovir0o+4E/6Re5++/ImfsJVZqGkju/p+/tv2Cxn
	BgapKQhhEU60zGiv+kdv436Vz93NpTcRTdVW0EI5OA==
X-Google-Smtp-Source: ABdhPJxXNJ5er2bptuVybeBTe96h0U8ufAdgMDhfZnWJRD79gFPqAYeEfo4+/ynT0o+kO2+VTDRRV5Xudthz7jyEzxI=
X-Received: by 2002:a17:906:d285:: with SMTP id ay5mr960608ejb.418.1621271430280;
 Mon, 17 May 2021 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com> <20210422062458.GA4176641@infradead.org>
In-Reply-To: <20210422062458.GA4176641@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 May 2021 10:10:19 -0700
Message-ID: <CAPcyv4jukTfMroXaw+zWELp4JM=kbBaitG1FGwFhxP7u1yQMBA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: EIA3HEJD763WGN5BLCD3IAXXDJ5CXT7M
X-Message-ID-Hash: EIA3HEJD763WGN5BLCD3IAXXDJ5CXT7M
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EIA3HEJD763WGN5BLCD3IAXXDJ5CXT7M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > Can you get in the habit of not replying inline with new patches like
> > this? Collect the review feedback, take a pause, and resend the full
> > series so tooling like b4 and patchwork can track when a new posting
> > supersedes a previous one. As is, this inline style inflicts manual
> > effort on the maintainer.
>
> Honestly I don't mind it at all.  If you shiny new tooling can't handle
> it maybe you should fix your shiny new tooling instead of changing
> everyones workflow?

Fyi, shiny new tooling has been fixed:

http://lore.kernel.org/r/20210517161317.teawoh5qovxpmqdc@nitro.local

...it still requires properly formatted patches with commentary below
the "---" break line, but this should cut down on re-rolls.

Hat tip to Konstantin.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
