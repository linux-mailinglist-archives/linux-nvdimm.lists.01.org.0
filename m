Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D112E1AF3D6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:53:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4541C10FC62DF;
	Sat, 18 Apr 2020 11:53:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 43BCE10FC62DB
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:53:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so5558538ljl.6
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=Dab8X2CtWipiSivi9nyLxp8nBHQpWedKwzW35yNj8kBU3VxCHrB+3Kn5U3rtIjeKoA
         Lw3k/ndceMaBnN8HktM5POukz2zYdQKxOk+s6N6D5bBob3ys4IoAy4L7IIPc1NiF89LI
         qpPs2HFFi+SoqSVPJ7yi1QNfgGKP7Teiklti0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=XyMSwmkRtauebmRylcKlpGCp38QOh6UGLrssQwc2/lRhtmvBKjdc0Dx4kodz0dp0B5
         +QFWSz7uQgym5d0nFK1LWIXfZV+uKLQwrFOmc0xCW4lBdGkiBwMi0VpMVrDz+LbnwBY3
         ITnXSjd8JrB061Dfj6+xUu7KoM9rpgUmBJI0VjHTEIF4L5rLFkmK0Ry3lChXrsY19zQA
         mFl1885Grp4cA7w/03Zen5caxGg4pyWEp04cg96QVY4Pv5zjgI/C9gmH0Y4o9vOkMl29
         YocpKEppWs18mTL4BNGfnHeJ7YngF6qRaaJwsA2LamM6M9nW1digCbK/oxLl7xoeQfmY
         Tf9Q==
X-Gm-Message-State: AGi0PubrcoU5O6wHe44HUxkvDZA4fV4vjvURrnrVI/FjlZTitqMscKci
	c1vtd7KJkA7kgs2munBFCY/8CFGjqZI=
X-Google-Smtp-Source: APiQypKfBExqljapfdyqJL44+4Ywimrbh7uAGFFBuTgLlwcnkImT4ID7W1hkbWvymFbm51X3q2WrjQ==
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr5466501ljj.115.1587236000555;
        Sat, 18 Apr 2020 11:53:20 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 78sm19367232ljf.76.2020.04.18.11.53.19
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:53:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m2so4553220lfo.6
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr5483360lfk.192.1587235998911;
 Sat, 18 Apr 2020 11:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200418184111.13401-1-rdunlap@infradead.org> <20200418184111.13401-3-rdunlap@infradead.org>
In-Reply-To: <20200418184111.13401-3-rdunlap@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Apr 2020 11:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Subject: Re: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID-Hash: K3K4VODVSS4YIWSU3F3RUM4G634VLVLR
X-Message-ID-Hash: K3K4VODVSS4YIWSU3F3RUM4G634VLVLR
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-scsi <linux-scsi@vger.kernel.org>, target-devel <target-devel@vger.kernel.org>, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K3K4VODVSS4YIWSU3F3RUM4G634VLVLR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Apr 18, 2020 at 11:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix gcc empty-body warning when -Wextra is used:

Please don't do this.

First off, "do_empty()" adds nothing but confusion. Now it
syntactically looks like it does something, and it's a new pattern to
everybody. I've never seen it before.

Secondly, even if we were to do this, then the patch would be wrong:

>         if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
> -               /* fall through */ ;
> +               do_empty(); /* fall through */

That comment made little sense before, but it makes _no_ sense now.

What fall-through? I'm guessing it meant to say "nothing", and
somebody was confused. With "do_empty()", it's even more confusing.

Thirdly, there's a *reason* why "-Wextra" isn't used.

The warnings enabled by -Wextra are usually complete garbage, and
trying to fix them often makes the code worse. Exactly like here.

             Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
