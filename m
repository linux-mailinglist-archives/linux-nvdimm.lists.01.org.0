Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00C25E092
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Sep 2020 19:11:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A518313C440DD;
	Fri,  4 Sep 2020 10:11:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 618F413C440D9
	for <linux-nvdimm@lists.01.org>; Fri,  4 Sep 2020 10:11:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id q8so4238124lfb.6
        for <linux-nvdimm@lists.01.org>; Fri, 04 Sep 2020 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwSOZ3VxHk2DxOprDUCFltuLBh+Nnc13XxZ9vhv/VSM=;
        b=Ai5VYeCU8N0HEbW+IM5blqtlPgBAdGE7a3XFUEbRHQk5rk29NE1Y6tMiu2T/EMq17a
         oE42EL494zdqelcOJfkWDvC8gduDspSWRXtrBLodjT6PNtuIMZdw4lEZsKoERdT4+qfQ
         DzOZXMaeU+RmNmSqU9sHI/NrjQBcHXnvyzI6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwSOZ3VxHk2DxOprDUCFltuLBh+Nnc13XxZ9vhv/VSM=;
        b=F9PeqmIS5P3kduTDuBYkOv/BVgXTJ09kXvzHeecv2YaKFKZZINfqgTRsVRT5tgnuK5
         XI7vQr+9i8pHCxLOJBzwQP67LPgdUvZ4WU6L4vg9BvP0ugMnucz+SqNH9H683NQglncR
         /NKVfEw5G2xpl4o5+9UxfeZUjVe7b34rmCaqf2AXzMGFhXhkf+zhnBVoc7Xijyjj9HUE
         m6/PXn7FdHURuUOwaRFuZoo/h2oToFc+pKaoe8U+hF3o8zhFmfYl8QovaCnXqlxFxF0h
         EcOQzDwGfFJImVRvHS79CQsnA12UJfO6azs3JVhHhs1RfocOZHe8YPYPARNwXX1QNnnw
         EYsw==
X-Gm-Message-State: AOAM532xvozlJbdopGrHY24SH9tNPNfnLaYSa19Hf9NB1sAyGjYTltyK
	UgDiLIuQ2UVohA2W7q0H9bJZEIdJAGE12g==
X-Google-Smtp-Source: ABdhPJwh1lFMPsYAcUQ2m286tviuaCHZW0QzOmKjeByxE+27dVQq8pWzzoDLrR0DF2Sr89RHANx/ww==
X-Received: by 2002:a19:4094:: with SMTP id n142mr4303417lfa.166.1599239486578;
        Fri, 04 Sep 2020 10:11:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o8sm1361416ljg.132.2020.09.04.10.11.22
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 10:11:22 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id q8so4237987lfb.6
        for <linux-nvdimm@lists.01.org>; Fri, 04 Sep 2020 10:11:22 -0700 (PDT)
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr4298936lfb.192.1599239481877;
 Fri, 04 Sep 2020 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whpJp9W_eyhqJU3Y2JsnX45xMfQHFNQSsb9dNirdMFnaA@mail.gmail.com> <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009040402560.14993@file01.intranet.prod.int.rdu2.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Sep 2020 10:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmhDNm7+w0atqAj3X=izWxNut_4kQGTG8n=+HhtxEbRw@mail.gmail.com>
Message-ID: <CAHk-=wgmhDNm7+w0atqAj3X=izWxNut_4kQGTG8n=+HhtxEbRw@mail.gmail.com>
Subject: Re: a crash when running strace from persistent memory
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: 4UXXYD3AGZUUX2U44LKVXGEN37WTGMKN
X-Message-ID-Hash: 4UXXYD3AGZUUX2U44LKVXGEN37WTGMKN
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4UXXYD3AGZUUX2U44LKVXGEN37WTGMKN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 4, 2020 at 1:08 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I applied these four patches and strace works well. There is no longer any
> warning or crash.

Ok. I obviously approve of that series whole-heartedly, but I still
didn't want to apply it this way (and with this kind of "mid-rc"
timing).

I was hoping to just leave it for the next merge window, but there are
now two independent problems that that forced COW patch of mine
caused, and a plain revert isn't acceptable either, so I've just
applied that series to my tree despite the garbage timing.

Maybe I'm just making excuses and rationalizing because I wanted that
series anyway, and patches that remove lines in core code make me
happy, but I don't see other great alternatives.

              Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
