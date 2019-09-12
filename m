Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C900B0A86
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 10:42:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 33C4D21962301;
	Thu, 12 Sep 2019 01:42:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 51E84202E2903
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:42:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c195so3766216lfg.9
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lNrIuUYLDbT7zQ5324Ye/I2/Q3u9VnMzuPI9RQmmH+s=;
 b=HQvte52rfMzXkfmg2dy9fX6VpDW3IFfdlGC05XQ8K1w8RM25pVju8tCDde4KUH0v1a
 1kcdT7UH/73YhhPccKsaGWDyC+Sz+Wb6IX/AHz34Gb0cW2pCuGQRxZhr8jDVO1REPKTg
 jwEpA+OPl7mOutzaxAJv2kNWbY5ouhp4RVMwiy22nCjmfGZ+3EozFEdOLX9t+9uGjz3t
 bBEXwt2yJqGwzYLFaPWKmr6RdcKpM7iziqyRJYi127B5fZCPWJI/JZSJ0wUocRLM5+dS
 Gc+Gp17oJ9b/iyPdk67fWEsZUWN8K4JROeX14wCj6dt/srxxNI6pKTv+Ztoedr/7VPPN
 Ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lNrIuUYLDbT7zQ5324Ye/I2/Q3u9VnMzuPI9RQmmH+s=;
 b=HpOubqaOYMTHYJruWg8zweA2xiDf7ftlf98UGCiGg0cHibmupP1ZKk8QW9DqKQ2p88
 mE1MxR1yxOPVX6MYBWNGEMvVRIPEMbFH8VSUZo9P925Jv1Lp3Rdt9/oJAUX1rtcd/Crh
 itvDdrsgCcR6deY3bQ3cnsi5BjXqly6O0nAGqoikYJd6tV1CHFjU4DX4DrKa29YjnTVC
 Bwvd0u/Le6DMaCa2d207pY1ZYttIPLOags182SdiB3USLj/zMFh7TdJkMqnTFoL6Tb1D
 2tst4EDzrrY0i7y6i3EMIJXxaLi8MwRuyaJURGnZEX9olGkWX0KNN6rZK/Uodi5ucBjU
 QsAg==
X-Gm-Message-State: APjAAAUwifhfKJ2Rrlk/EEvwRSCEP2wy7ej7UQD9W5V31DvNhEdQAtLE
 QB593ZRynkHgjf5VZrVjtd2mDJ8rmi4nksV/hYU=
X-Google-Smtp-Source: APXvYqxyEQdbpMlCuAav1TG4x6BjkXais5Z79dXqr0CkWkZVoUFV3EnetqKauoIdCFU9Ic5EJVQo610gutjyqWbL3VU=
X-Received: by 2002:ac2:4351:: with SMTP id o17mr1127056lfl.131.1568277737781; 
 Thu, 12 Sep 2019 01:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
 <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
 <be3c626c2e9d14fe2fa9d0403bc02832231cc437.camel@perches.com>
In-Reply-To: <be3c626c2e9d14fe2fa9d0403bc02832231cc437.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Sep 2019 10:42:06 +0200
Message-ID: <CANiq72==rV-CY5d3poN6j10qSuF2ux-sJGqZS+YOXeZgGmmh3g@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To: Joe Perches <joe@perches.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 10:15 AM Joe Perches <joe@perches.com> wrote:
>
> I am adding Miguel Ojeda to the cc's.

Thanks Joe!

> Of course you are welcome to try it, but I believe that
> clang-format doesn't work all that well yet.
>
> It's more a work in progress rather than a "standard".
>
> I believe you'll find that the patch series I sent
> ends up with a rather more typical kernel style.
>
> I suggest you try to apply the series I sent and then
> run clang-format on that and see the differences.

Indeed, it is not there just yet. There are a few differences w.r.t.
the kernel style that aren't supported yet. However, for block/batch
conversions, it is very useful.

Luckily, one of the biggest ones (the consecutive macros alignment,
and we have a lot of them given this is C and a kernel) is going away
with LLVM 9 which is about to be released next week.

> Ideally one day, something tool like clang-format
> might be locally applied by every developer for their
> own personal style with some other neutral style the
> content actually distributed.

If that day comes, I hope we can all agree to a single format and
apply it everywhere as other major projects have done. I think
agreeing to a given style is much, much easier for any of us when
formatting is fully automatic -- because at that point you don't need
to spend mental cycles (and memory!) on it. :-)

If I had to guess, I would say the path forward will start with some
subsystem maintainers starting to apply clang-format systematically on
their trees. That is why I think it is very useful that Dan tries it
out and let us know his impressions.

Cheers,
Miguel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
