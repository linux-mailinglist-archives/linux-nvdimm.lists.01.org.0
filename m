Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFC29151B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 18 Oct 2020 02:05:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57049158A3293;
	Sat, 17 Oct 2020 17:05:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8696158A3288
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 17:05:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so8481649lfa.8
        for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwELQNGP6UkpPlOimYrMazMJwsHunIQQ9G2ROVl0mqc=;
        b=eaFsjl/uJMvNGO77u8TJBI1lpj8JVCnyIv7lWC6siFEmD/+aSv1tgjGxgpdgys2rPg
         t/798mY2oV/9HpYeSMQPhJD2qhaEWMwjE2nuMyUwHZLLI5KPcq5X9gjgf9KtIrjpJi8k
         HMK/o6Iol06QIssjk+IlEeind+oAT5pf512mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwELQNGP6UkpPlOimYrMazMJwsHunIQQ9G2ROVl0mqc=;
        b=e3AdD45iQJ4BoY9vX8RWi4ZFM29ZNLjiCWU+Nbh5AmMozn4qH2c/pXC/zRyhx8LuNd
         oKMus1YsITwPrOGLoOLZEPs1NUwQQIRi/3V1TpJ2Bl3Q5X1oT7/MUnFNcqPb5fL59g8y
         lslWUyk8YCE/TNKKg4uNs4Lf560pV3AzJUigYyJS9V72BFrehFoCrDTcnkZG+4On2Wu+
         kadJ4Rbe3T3auXgoWnj1oomN6lVD87AfRaE/g+PRnGEEyXPaHLmp4JQanAOYVm+oTW7I
         ykSC2WKBwHO5N7T46CwvpyFB62FEwUWHh1KT+ODs4KTwc3Y45PeSvm7nNYlvP1ki5kuf
         Ee3A==
X-Gm-Message-State: AOAM533eIayYNeZmTVQiZymTarUFb5lONKXUuIXhrX67QwWzIV4DKdHt
	66ZkYzqgWdMscK3hKJcLlSs5mHLQVhZuzQ==
X-Google-Smtp-Source: ABdhPJyJRbNlH6Rf+O9sZFsP9xZzetBJHsamGwL6z2GLCCSFG1kZTgZXF2LG2x3BoxZt5RNY2qxTGA==
X-Received: by 2002:a19:c811:: with SMTP id y17mr3921251lff.259.1602979520495;
        Sat, 17 Oct 2020 17:05:20 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f10sm2582157ljn.87.2020.10.17.17.05.19
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 17:05:19 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id z2so8536843lfr.1
        for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 17:05:19 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr3869391lfz.344.1602979518759;
 Sat, 17 Oct 2020 17:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <160288261564.3242821.6055291930923876456.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
 <CAPcyv4jSji5KvLuouqSt-O_-iuKnCu4pXL1cEUqd1Ws+gjxqHw@mail.gmail.com> <20201017144351.faf85ca9880e43e68e7f9991@linux-foundation.org>
In-Reply-To: <20201017144351.faf85ca9880e43e68e7f9991@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Oct 2020 17:05:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvoCJVQXMTL+tKk5BsgwR5O1HSMwKfBOw=LAra65YBCA@mail.gmail.com>
Message-ID: <CAHk-=wjvoCJVQXMTL+tKk5BsgwR5O1HSMwKfBOw=LAra65YBCA@mail.gmail.com>
Subject: Re: [PATCH] device-dax/kmem: Use struct_size()
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: 476RTYRT6ZE44EPC4G5YO3FXFZJ2PLTU
X-Message-ID-Hash: 476RTYRT6ZE44EPC4G5YO3FXFZJ2PLTU
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, David Miller <davem@davemloft.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/476RTYRT6ZE44EPC4G5YO3FXFZJ2PLTU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2020 at 2:43 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> mm-commits is writeable-only-by-akpm.

Ahh.

That's fine, it's only inconvenient for these kinds of "people replied
to patches".

It's not necessarily just me either - people reply with Ack's etc, and
the fact that the list is write-by-akpm-only them means that "b4" etc
won't see it.

Normally I pick those things up personally, though, so apart from the
whole lore link issue that's not necessarily a big deal either.

And afaik, this is the first time somebody actually tried to refer to
a lore link and it failed.

Often you cc other lists as well, but that tends to be a
patch-by-patch thing, so it's not reliable.

            Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
