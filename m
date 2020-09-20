Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDB827185A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 00:04:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 931D614CAF104;
	Sun, 20 Sep 2020 15:03:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A5F014CAF103
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 15:03:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so4573266lfj.0
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ri07SWB636BQu9HeTZXldjDnXsp6QhYO/5gj4FXNUIo=;
        b=ehY/ZfgBKBZu+aLDoJAH14zbHNeQQ4gPKz81o3C3zMJoYWW+yWIZcVreq3Bx9P2Kbq
         B4WYpqJ4sY4sPF0L4iVeGXgGQYf4oxxPGdpLAEYNYEBQrbTiD3o+Bh45zKmRlQcOmARx
         jtQ+yhKP/y6+y2YXVRrsKT1ot1Q5AvF0e2b7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ri07SWB636BQu9HeTZXldjDnXsp6QhYO/5gj4FXNUIo=;
        b=ZtbRf5oGzcLfrtfsJXYKtcCPb2DePrpOpJ7IRfUDvnhAvYdDDsuF+0DdKD8rJ2o4NG
         IYDEVpp1Idl+kEwaB/hAOrzC4azeS0jkLX82tk3Z3G30PLqDVGCanMrcDwQqBRIQpdPl
         CR9gXU7UB47yAo6f3Zbq2qwgV9JNr1ci3RrxXwM8AfrDjxopFE7a8OTEhxqQc2BBK+/o
         L3EYcR1s4c5XL8x1wTWSLldnt/bhus1RakOsk48+fsq20CAXngx1PwZLxo2QFCXkGUvI
         fWxs/9jONr4x8iKR87AbKIedThmupYcJdKQJGLW86oI+JGl0twr3NANJUkIPLSDOR2s5
         uNCA==
X-Gm-Message-State: AOAM5300Dqo+NAB0AQW1GqpH4/c0f+5QauH91fQRwozCzF+sVkSniOWp
	ZO54m4cna7sZDDukWuGPekgolMNUAsmvFA==
X-Google-Smtp-Source: ABdhPJxGG2xPKbb4N5lYUoyv1l3aohmt5CDTFc/DHKy3JU3MDjs2NMLLQ2z9lCiqILXFGhErJcVx+A==
X-Received: by 2002:a19:383:: with SMTP id 125mr15198269lfd.356.1600639434558;
        Sun, 20 Sep 2020 15:03:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id x11sm2047651lfa.174.2020.09.20.15.03.52
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 15:03:53 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id v23so9515489ljd.1
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 15:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr14128964ljp.314.1600639432685;
 Sun, 20 Sep 2020 15:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
In-Reply-To: <CAPcyv4h3oKM-2hoG=FWHJwzVqjptnpQV9C+W6txfp_qcBhd7yQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Sep 2020 15:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuR1ZHV4c6a7d3EmgRBFfQfYGckD2t1kQXDpwnf50ATA@mail.gmail.com>
Message-ID: <CAHk-=whuR1ZHV4c6a7d3EmgRBFfQfYGckD2t1kQXDpwnf50ATA@mail.gmail.com>
Subject: Re: libnvdimm fixes 5.9-rc6
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 5XIX2QSD3O3HYCATWB2DXZUNV32NSKR7
X-Message-ID-Hash: 5XIX2QSD3O3HYCATWB2DXZUNV32NSKR7
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>, Jan Kara <jack@suse.cz>, Adrian Huang12 <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5XIX2QSD3O3HYCATWB2DXZUNV32NSKR7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2020 at 11:56 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
>    You will notice that this branch was rebased this
> morning and it has not appeared in -next. I decided to cut short the
> soak time because the infinite-recursion regression is currently
> crashing anyone attempting to test filesystem-dax in 5.9-rc5+.

Thanks for the explanation, all looks fine.

             Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
