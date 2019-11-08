Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39CCF3E25
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Nov 2019 03:42:07 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4301100EA625;
	Thu,  7 Nov 2019 18:44:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 80697100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 18:44:24 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id r24so3908967otk.12
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 18:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toJ5uCNFjWzAJBR7ewaPVlC4vkW0KDP/L41X/HMgzgw=;
        b=lPy/NPVDDKD+ljwMBp5nM3NVDpwEfFYxmWpm5I2XkGmYtaHYtOtuieVIpZ11xSy5D5
         zDu67m4cQNjGUQr+N3ov/20jQetm+yuZmeWgycWda/4Z8WWX2JqYr0ibGqm+PQBYhfTV
         FFphYJWpn0ZVinfKUyrxMsb4yNcnrqag9h3ss+ouB+Qxgf9FSOwCEPszXFWHay7/a2BR
         yjqh5G92uY/ZvsjM9xQgsg/0csXrSv+O2AK0wqeAnjVXS+9wHONM/o1DGmTvOyI7CTcH
         WUtxubP94Xixp79t2VSY3o1w4ZEoj+7uxOTBvwEg2KSaIXv2OhS/bUyYcuKs4AzwOoXS
         8w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toJ5uCNFjWzAJBR7ewaPVlC4vkW0KDP/L41X/HMgzgw=;
        b=tZ8ck/UQELYRAhVWmdgRwXL3TskUpG/i5nb2sZ/jF7AhD/RYIhk+IZ6u4MBsEz/SXu
         UsVUKTlibZquVFTb8v1x68e2OXwkVs1veN7Y2eFpTos0zpLJwUL1gYEBl9Mt0ibchNXj
         MeYRbs5xytMBiHzbFFHZGNwMTB+x60AYbYvOwLLjvYGjp3YeLyiQKZN6f/LGFtCg99K0
         S7nXRlCIv3n761F52xS4CNTs1VIPAM7rb3MAimGGcEa+LP24roSIlBxtuzge9/u6xmR8
         pyTynk1zlF6i/pqPtQxa08z4r7+w66QS9bVMgbEzHt4JUlBPWZpj9wtPq+2HflBimqni
         RUwg==
X-Gm-Message-State: APjAAAVpq6VxpjjYK+d6FOFy6W17puJr8aWFj1LaJCmszc/ZRdOYTa2O
	aSbk9iQWw+RvZxQNT4vmTkXNbZWliEK+R3nQoLnRkQ==
X-Google-Smtp-Source: APXvYqxiarfUJuzJ/cdOES1XRvlOh8CKmQ30F2dBwib+G2RYBXD1qCju76LJ23t8FPP3e6cmQLgaXAwfB5jE1+JkAmg=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr5849948otd.247.1573180918867;
 Thu, 07 Nov 2019 18:41:58 -0800 (PST)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191001075559.629eb059@lwn.net> <20191107131313.26b2d2cc@lwn.net>
In-Reply-To: <20191107131313.26b2d2cc@lwn.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Nov 2019 18:41:46 -0800
Message-ID: <CAPcyv4ihn9kgO-VDOK=Jyj8RrG2RVXUvu8Y66zR7JYZm9-rWPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
To: Jonathan Corbet <corbet@lwn.net>
Message-ID-Hash: 4NRMIHYXQEKVGCR3N54XCCKAYXL6PF76
X-Message-ID-Hash: 4NRMIHYXQEKVGCR3N54XCCKAYXL6PF76
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Steve French <stfrench@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Dmitry Vyukov <dvyukov@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, ksummit <ksummit-discuss@lists.linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4NRMIHYXQEKVGCR3N54XCCKAYXL6PF76/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 12:13 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Hi, Dan,
>
> A month or so ago I wrote...
>
> > > See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> > > and a follow-on example profile for the libnvdimm subsystem.
> >
> > Thus far, the maintainer guide is focused on how to *be* a maintainer.
> > This document, instead, is more about how to deal with specific
> > maintainers.  So I suspect that Documentation/maintainer might be the
> > wrong place for it.
> >
> > Should we maybe place it instead under Documentation/process, or even
> > create a new top-level "book" for this information?
>
> Unless I missed it, I've not heard back from you on this.  I'd like to get
> this stuff pulled in for 5.5 if possible...  would you object if I were to
> apply your patches, then tack on a move over to the process guide?

Sorry for the delay.

Yes, the process book is a better location now that this information
is focused on being supplemental guidelines for submitters rather than
a "how to maintain X subsystem" guide.

I do want to respin this without the Coding Style addendum to address
the specific feedback there, but other than that I'm happy to see this
move forward.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
