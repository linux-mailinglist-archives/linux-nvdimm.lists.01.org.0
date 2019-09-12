Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF6B10EB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 16:18:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C38A202E2936;
	Thu, 12 Sep 2019 07:18:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 79BE7202E292C
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:18:07 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s28so26220697otd.4
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=as20/K/wrQh0VcPp2JWZkYWpNUtTzdFQp/D51GEnJ2A=;
 b=VsK63YxZZ74Soq7i8sbb6fh8HuUwyRP41aJpm+IyEEVxbFiT+L+HI7tHr2Vtr0PsHQ
 fDXFh2WJkHcBM2sQqx1nz4YhINjpIBCvGC9TrFffsfvAIt4gr3yYNVISifAiKggfChWB
 2eA96VKb6o3jBW1xy3BW5dlaSz0jNJM08lR86GYMPhTh3k+K1N87uSTRdNbiDRyiowpt
 ZwXe3nzkYOIn1ZNixxsiuJTCR4BF0L25n4IU8DzNBCsoClLT/Gf5jHWOcunpLH27oWeT
 r5TNuXp8viQJvL/EuRe9CAFlXbBTqM99aMDd+dlIzc3ACil8+YLF6nLcaSfVseT69/36
 Ivxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=as20/K/wrQh0VcPp2JWZkYWpNUtTzdFQp/D51GEnJ2A=;
 b=sU0VJQt0oZMLeVKEl/A7wsuq4ZPcgX/WqwwbCMnIltpOqah8fRFHeXniUki32pMfrm
 6nql4Yr88kpNPmanXFrBVlTRvJLcQyCKkdVB/N8ZjdX1oId/1MSaKiqh6BXDzR4npGM8
 g/JVipnr7p1G9LYa7IoJF7XkjWOQmpR9NcYaoz0Wd2Q1wahsvXhh4FjyuNrpXlST81IM
 Q5zSgUUl24CLVEax/8M75D4ypom+vl1hSRZvAHPDZIo7FXN3NJel57fWtNeVIq6f0ccH
 4CC8aNh0DIFXk4ZYKmYzd2CeaC1IhJAwDePKbYMecius9lEiicyoqEScRyzh5r9+c9io
 opew==
X-Gm-Message-State: APjAAAX9WstJKsKBG+2VpxUjte/oVh5FmuAF/EfKqed7KE9ynzcLN+77
 Wa3fFdhKFKpmMCCrEkUQhkiUF8oX4rJEXy+DDv8vAg==
X-Google-Smtp-Source: APXvYqww7bFfGwyc5qF49rVm8WTD42K5tWa0xz3KchY2iJm2zV03eJqbCs0F8Uc+E8PPkm5kQfSl9zD6BO6JdIqdc4I=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr10806424otp.363.1568297884741; 
 Thu, 12 Sep 2019 07:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
 <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
 <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
In-Reply-To: <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Sep 2019 07:17:51 -0700
Message-ID: <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
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
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 4:02 AM Joe Perches <joe@perches.com> wrote:
>
> (cut down the cc-list)
>
> On Thu, 2019-09-12 at 03:18 -0700, Joe Perches wrote:
> > On Thu, 2019-09-12 at 10:24 +0200, Miguel Ojeda wrote:
> > > On Thu, Sep 12, 2019 at 9:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > Now I come to find that CodingStyle has settled on clang-format (in
> > > > the last 15 months) as the new standard which is a much better answer
> > > > to me than a manually specified style open to interpretation. I'll
> > > > take a look at getting libnvdimm converted over.
> > >
> > > Note that clang-format cannot do everything as we want within the
> > > kernel just yet, but it is a close enough approximation -- it is near
> > > the point where we could simply agree to use it and stop worrying
> > > about styling issues. However, that would mean everyone needs to have
> > > a recent clang-format available, which I think is the biggest obstacle
> > > at the moment.
> >
> > I don't think that's close to true yet for clang-format.
> >
> > For instance: clang-format does not do anything with
> > missing braces, or coalescing multi-part strings,
> > or any number of other nominal coding style defects
> > like all the for_each macros, aligning or not aligning
> > columnar contents appropriately, etc...
> >
> > clang-format as yet has no taste.

Ok, good to confirm that we do not yet have an objective standard for
coding style. This means it's not yet something process documentation
can better standardize for contributors and will be subject to ongoing
taste debates. Lets reclaim the time to talk about objective items
that *can* clarified across maintainers.

> >
> > I believe it'll take a lot of work to improve it to a point
> > where its formatting is acceptable and appropriate.
> .
>
> Just fyi:
>
> Here's the difference that clang-format produces from the current
> nvdimm sources to the patch series I posted.
>
> clang-format does some OK, some not OK, some really bad.
> (e.g.: __stringify)
>
> My git branch for my patches is 20190911_nvdimm, and
> using Stephen Rothwell's git tree for -next:
>
> $ git checkout next-20190904
> $ clang-format -i drivers/nvdimm/*.[ch]
> $ git diff --stat -p 20190911_nvdimm -- drivers/nvdimm/ > nvdimm.clang-diff
> ---
[..]
>  25 files changed, 895 insertions(+), 936 deletions(-)

So, I'm lamenting the damage either of these mass conversions is going
to do git blame flows. To be honest I regret broaching Coding Style
standardization because it's taking the air out of the room for the
wider discussion of the maintainer/contributor topics we might be able
to agree.

As for libnvdimm at this point I'd rather start with objective
checkpatch error cleanups and defer the personal taste items.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
