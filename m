Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E436878C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 22:01:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFF92100EC1D5;
	Thu, 22 Apr 2021 13:01:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8134A100EF26A
	for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 13:01:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so70626180ejr.5
        for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iL1WsOQVTYMGLSrNemHFm1Wr4O/+l/TQ2XP4MbaIT84=;
        b=CmFvXIcEhplHy1cMKEiKqrrqPheSSo1tQSdHL5LuMKhZpbjL0xzsjRbBEY7JGPNwgB
         Rq2HDJXX7H9NUz+rdw7db6fYhPfq+H4AGu9PcMFUm5AhsIBYGkPErbJhrcfuYlbBPFYQ
         HLRYZPoypAdPbIrrECtkBoFVczwlLhCcpX0aY3EAAk+3n7JPzT+V2jtReizvuenO7+j8
         ASjo98WFatar+0BBXCjWu/epjHUSYjFmdVvwLdtR9NMGSyP556uJiaR9BXYmAkz6Dk++
         VqnXUHcRFiLap4vdlP7I9NJWWERch31qrDZ1/V0QRI0/hvcEqMMe9fYP62kf6RyW0FIS
         dLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iL1WsOQVTYMGLSrNemHFm1Wr4O/+l/TQ2XP4MbaIT84=;
        b=IWkPKdb2wJcMjo/blJh9wKQBITYm27lceYQo+I9eeDPTkqP9gc+V277azFWxR310xK
         xZMcoXbGm4x1bxcdsTPEhKhhg13mOv/rTuozuZa6iWn5mhibHBB6Uh2G3UQtApIRyZ2k
         skVnTaErB3YKizx0oqH7D9XAEUt6WZZw4nBqH5wj2PRUz3p/saEZvLkCNGZC8RAtwUM4
         Y4TLdbRZia0M6Wqb/S5HZfIksM4A7Zk0SobZXRsm0rmrna0KqseNWleRdaNTaMnTvuJT
         E1pFADZ32sZNjDfQrD7q4oShfdhxEDXss1DvnifR/b6QdBNNDYtecI7XBBoPsXOF8rcw
         Lq5A==
X-Gm-Message-State: AOAM531B0HTtq3DJUiDWNxZzKVAMCNeD5I4ixMEBDz+m26YqdY5vBcYk
	88s6WuAvDnQmuOzWz00+TaYzQsuWIkqZM3UrmEFC6w==
X-Google-Smtp-Source: ABdhPJxheq+t6LYA8/KKx2YNYbEpR++dNjUtqeUQbiQdqjBErA0pDEeM018l9DULvaWGHbUk0fe1JMJaEi3JtxAjkBw=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr359080ejf.341.1619121682614;
 Thu, 22 Apr 2021 13:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com> <20210422062458.GA4176641@infradead.org>
In-Reply-To: <20210422062458.GA4176641@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 22 Apr 2021 13:01:15 -0700
Message-ID: <CAPcyv4h42yPKmWByBVkjgL_0LjBg3ZNYKLBJKgjixsdTzOpaiA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: MLQHZ6PBGNCDUGXG3FFJRGNHPH7VHE6Z
X-Message-ID-Hash: MLQHZ6PBGNCDUGXG3FFJRGNHPH7VHE6Z
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg Kurz <groug@kaod.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Miklos Szeredi <miklos@szeredi.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtio-fs-list <virtio-fs@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MLQHZ6PBGNCDUGXG3FFJRGNHPH7VHE6Z/>
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

I think asking a submitter to resend a series is par for the course,
especially for poor saps like me burdened by corporate email systems.
Vivek, if this is too onerous a request just give me a heads up and
I'll manually pull out the patch content from your replies.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
