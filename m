Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4C1A2EBC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Apr 2020 07:14:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B2BB10113FD1;
	Wed,  8 Apr 2020 22:15:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40B6A10113FD0
	for <linux-nvdimm@lists.01.org>; Wed,  8 Apr 2020 22:15:13 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bd14so11710062edb.10
        for <linux-nvdimm@lists.01.org>; Wed, 08 Apr 2020 22:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY7MUWYg0CK1Tvzj+QeStPn2WOKppk76oqJCa/ryNiY=;
        b=ncEgIzCvOvPaBRt8Ee6N8e5EoonoCr5fsBu95DHAeb5SJ/12QZWvHXq4GN+jqapHR4
         briZV+vnfqG1R6TU3oAExC6nQcl5dDnQXYHTkbEyeVCw67ecoGBtAmTOzWrj1xEHs5Jv
         5XIH391bN25Bgynirn/RSGkCeMx9OjprrwTDd/curha6Yfmukf7sVh/1ibdeaKrDNzU7
         34S6wSkNykWLijBhaPsvBKkaDXPLtwfgJ5HC0+WkdoLAj0Qge34IecQk1x36bYE+zalQ
         sp1Ps7btAz97osQcuqtcWIwS0CO4Of/IWFErKeWhiNcNj4Ez5657kFYuJi1N9SaW+TLT
         5QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY7MUWYg0CK1Tvzj+QeStPn2WOKppk76oqJCa/ryNiY=;
        b=T9g9t/al81JMcRBcvSAEm/3acXzTOJ/8IH8p/lNffjAHUPIUEHh69JRCSAo7Mykoyc
         H0vSVFUoG4jMp608tMFFVkvmCVFbKT3zKN0LfEGkgy03prC9daddzPjSdMIJWBGM9PeA
         PPZS4wraMOHKUxjCtDY+aHHxl8ef4RoTDhjjpbh1CA5+zUIPmIz07G0GniEjpz+st6He
         FbtsgbuQb7Oz59GpA4sH5ykiRbW2+JBZIS8y8WCu45TghNdpFWA5Q1umKWZ75eAmjku7
         424/6teYcXzIAGpu/QbbRpDnuneWcLvjKIZWR7s/fQSdlEt1xXikxi1Zd5aayRyyYY5z
         VFcw==
X-Gm-Message-State: AGi0PuZ+2UI85Qn0YBG/IpvwRi/xdjYTwq0i9Yh+dzFA4PQPedu36OE5
	cFdYE45YTGcLCkBaMbwMqAdc9ktDoONo/Z+SEa3tRA==
X-Google-Smtp-Source: APiQypKWClH3zGpC71koBaydDhSE0bupeJ0O0XyeGFTZoiaBGvpA9xzgxXuW3dPnCi0PoIHYk0YHMzS7SxCzW5IYnhc=
X-Received: by 2002:a17:906:6987:: with SMTP id i7mr9963952ejr.12.1586409262689;
 Wed, 08 Apr 2020 22:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
 <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
In-Reply-To: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Apr 2020 22:14:11 -0700
Message-ID: <CAPcyv4g0-rxw2KXrRRe4Mr-zS4ujx6pTqApZgZrPhJetLgjRPA@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for v5.7
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: OKRSI5KVCK6TTCOZZPJMVOKHH54D2NIS
X-Message-ID-Hash: OKRSI5KVCK6TTCOZZPJMVOKHH54D2NIS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OKRSI5KVCK6TTCOZZPJMVOKHH54D2NIS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 8, 2020 at 9:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Apr 7, 2020 at 1:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >       mm/memremap_pages: Introduce memremap_compat_align()
>
> Why is this an exported function that just returns a constant?
>
> Why isn't it just a #define (or inline) in a header file?
>
> Yes, yes, it would need to be conditional on not having that
> CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN, but it does look strange.
>
> I've pulled it, since it doesn't matter that much, but I find it silly
> to have full-fledged functions - and exported them GPL-only - to
> return a constant. Crazy.

Yes. tl;dr I gave up after failing to unwind a header dependency chain [1].

The source of the trouble was trying to find an existing top-level
header file that included an asm local version, but also needed to
include mmzone.h for the definition of SUBSECTION_SIZE.
include/linux/io.h fit that requirement, pulling in mmzone.h there
proved more difficult than my header unwinding skills could
accomplish.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=c990ae9376c15f40aff2f61f42a71be5b81f9ee1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
