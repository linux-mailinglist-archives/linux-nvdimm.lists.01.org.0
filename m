Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B025E921
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Sep 2020 18:48:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C76D13DBA166;
	Sat,  5 Sep 2020 09:48:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 602AD13DBA164
	for <linux-nvdimm@lists.01.org>; Sat,  5 Sep 2020 09:48:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so506989ljj.4
        for <linux-nvdimm@lists.01.org>; Sat, 05 Sep 2020 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=IbD/06LcWNINiD1qQx76yuC4NnGDIsm3+GWIOtgRCjshaVtDI/A02DI5qKetncQ5Eq
         ETJ/AP0MURo4tMxU2BWA9ZqY9wz8byBe5Nb/ZFb/npAfuJhH/nO2eJvqX1EnmPNcLt9a
         /DIWjA8HitbuHHT5Zgo8zabEuZouEGY3xlN9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=a+L1B1nTJ5r2fM0R5QYfSFqBKVZP/hqa8nyKRQFQkWQ0oBnbK8qyLj7kFflDI9nFbq
         NAAPL6XwBACwwFooOpIRoKRg+zdRfQgbSBpwYz3VmMaFi3hmuq58rg+tEsaGCfwi9Pcy
         5t4qpMutlkSIWG2fK2D5ClgPoOsXC5ZG4HEsw+jAK7ETxsAeE1lFGTknO14/kYe0Im+G
         gKZ49WzVftQjNDZBQ4XDXTv4v2t9dxrShkznAxFuPDF/KCxoUdB1BdMeK6q+2sRFO4/m
         cApdGQLIUm+DKgRIR6s8mVQgyAl8+h0dXL+ZgIfx5KiUlMqpZ6lC0ORDmSx2NVUVoGc1
         Fc1w==
X-Gm-Message-State: AOAM532UHyFmYEjtqq0VTUUzTyn8PQUed2707EyCkfmE1pJiS/HNIYNk
	WiNJShvqxHSa1rn98Tbq8Kx3OUsliStZxw==
X-Google-Smtp-Source: ABdhPJzUN5zA/btbFiWYvhl2+QFzaHs3elevDavNkZyVlHASruK1R/mT5tkHuQt2hZNdrlrj6etAfg==
X-Received: by 2002:a2e:9784:: with SMTP id y4mr6141309lji.247.1599324492230;
        Sat, 05 Sep 2020 09:48:12 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w17sm2527501lfr.31.2020.09.05.09.48.09
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 09:48:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w11so5468428lfn.2
        for <linux-nvdimm@lists.01.org>; Sat, 05 Sep 2020 09:48:09 -0700 (PDT)
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr6480035lff.125.1599324489251;
 Sat, 05 Sep 2020 09:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Sep 2020 09:47:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
To: Mikulas Patocka <mpatocka@redhat.com>
Message-ID-Hash: TB2S3PW4VQQP5GGPINUJMSVAC6LTVF22
X-Message-ID-Hash: TB2S3PW4VQQP5GGPINUJMSVAC6LTVF22
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TB2S3PW4VQQP5GGPINUJMSVAC6LTVF22/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 5, 2020 at 5:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.

So your patch is obviously correct,  but at the same time I look at
the (buggy) ext2/xfs code you fixed, and I go "well, that was a really
natural mistake to make".

So I get the feeling that "yes, this was an ext2 and xfs bug, but we
kind of set those filesystems up to fail".

Could this possibly have been avoided by having nicer interfaces?

Grepping around, and doing a bit of "git blame", I note that ext4 used
to have this exact same bug too, but it was fixed three years ago in
commit fd96b8da68d3 ("ext4: fix fault handling when mounted with -o
dax,ro") and nobody at the time clearly realized it might be a
pattern.

And honestly, it's possible that the pattern came from cut-and-paste
errors, but it's equally likely that the pattern was there simply
because it was such a natural pattern and such an easy and natural
mistake to make.

Maybe it's inevitable. Some people do want (and need) the information
whether it was a write just because they care about the page table
issues (ie marking the pte dirty etc). To that kind of situation,
whether it's shared or not might not matter all that much. But to a
filesystem, a private write vs a shared write are quite different
things.

So I don't really have any suggestions, and maybe it's just what it
is, but maybe somebody has an idea for how to make it slightly less
natural to make this mistake..

But maybe just a test-case is all it takes, like Darrick suggests.

                  Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
