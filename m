Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35882109204
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Nov 2019 17:41:33 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C1A31011330A;
	Mon, 25 Nov 2019 08:44:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 611A710113308
	for <linux-nvdimm@lists.01.org>; Mon, 25 Nov 2019 08:44:51 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v138so13691189oif.6
        for <linux-nvdimm@lists.01.org>; Mon, 25 Nov 2019 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+EcTLko/p4bJ6jJO0C9lQhVndIFrtgXLxWfjta1Ss4=;
        b=kfzWheBuxI2ukOAG9YRc+e7L4+AXM8seHNFuLi8U8M94hZ/VbKgdur7a3Ds5NPYiWX
         J0XtYyzH24XRYTNUO8LzK4+El6WxhD8fI2sHErrOOjqEzE6VYoI60KoPm7+JSq0miySx
         2jiFlVr51/mToK+hE5Ji1aO3RLhIRJAmDO/8CQ0w/0fMaSjEEaHym2yswK3Hog4d4ETN
         MKBnnhq5ZYO1np2HOWo25ydRkjAY1+CJOpd+LRV9RoQWKgfmnMXB5+BHFUff9Q73H267
         SZzbuI+ZR8ui6UOqTiFwvreRACziXE0h02J6Yke9kT3/rwf3gC4pI4E8s4iCc9Y2tED9
         ahBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+EcTLko/p4bJ6jJO0C9lQhVndIFrtgXLxWfjta1Ss4=;
        b=ayCkYGnNzk/XSLzaqU3FWfTl/pNpi+rFXzZNEwHR+owyz2uxccEWf7o/GbhmpQQAVZ
         aGXk/DxuflFne0ygN+znPHOZhV+STRC44Y2q5TEaBwVuX2xIyulTT+5IfgCEzRuV+sbV
         r3tx+Inv8P+fAyRBG/SNJJlZBwNGDR7UqJvjymhzxtTcvmJilxnqaKyq2ALZHH/7VrLa
         P30YOvGThpelg9vgpTxQQCVBUb4QDlBzatr/00Y5PXp6lidm0AH8aCg5+SoW/dsW5Z46
         SuoSceBjoQzYVKAYFraRzsQ+LYj5q5oZOnGYrGx8S2oAIyWlBesFKxa6s8vyIoxY14JQ
         m/9Q==
X-Gm-Message-State: APjAAAVhtcLeMK6krlYBsAXz3LWZ/55Xzu13GyqtDNigfyWtKU8a4OfB
	qpBLv9oOJhAXiplS1xYCqetaGA9ByEBviKhUzgtviw==
X-Google-Smtp-Source: APXvYqxm6md6vLwzQ4bD00wEiiMr9oWkW4o3uzNKoxR9r2p4WilcYr70KCmNXGLZ1mPoFYnSCJZpz2SdsryKXe8d67g=
X-Received: by 2002:a05:6808:1da:: with SMTP id x26mr24438096oic.149.1574700088026;
 Mon, 25 Nov 2019 08:41:28 -0800 (PST)
MIME-Version: 1.0
References: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20191125085052.05cfe063@lwn.net>
In-Reply-To: <20191125085052.05cfe063@lwn.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Nov 2019 08:41:16 -0800
Message-ID: <CAPcyv4gHTz4Zw=hQgkJ1e-_O5PSyMosfQ4iTHZLD03Vw+MWZWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Maintainer Entry Profiles
To: Jonathan Corbet <corbet@lwn.net>
Message-ID-Hash: NF6K6FMKNSVTKJ7WXWRF3SC6TZO6RMB7
X-Message-ID-Hash: NF6K6FMKNSVTKJ7WXWRF3SC6TZO6RMB7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>, Joe Perches <joe@perches.com>, "Tobin C. Harding" <me@tobin.cc>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve French <stfrench@microsoft.com>, Olof Johansson <olof@lixom.net>, Paul Walmsley <paul.walmsley@sifive.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NF6K6FMKNSVTKJ7WXWRF3SC6TZO6RMB7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2019 at 7:51 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Sun, 24 Nov 2019 12:59:42 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Changes since v2 [1]:
> > - Drop any consideration for coding style concerns in the profile. It
> >   was a minor aspect of the proposal that generated the bulk of the
> >   feedback on v2. Lets make progress on the rest.
> >
> > - Clarify that the "Submit Checklist Addendum" can also include details
> >   that submitters need to take into account before even beginning to
> >   craft a patch. This is in response to the RISC-V use case of
> >   declaring specification readiness as a patch gate, and is now also used
> >   by the libnvdimm subsystem to clarify details about ACPI NVDIMM Device
> >   Specific Method specifications. (Paul)
> >
> > - Non-change from v2: Kees had asked for a common directory for all
> >   profiles to live, but Mauro noted that this could be handled later
> >   with some scripting to post-process the MAINTAINERS file, or otherwise
> >   converting MAINTAINERS to ReST.
> >
> > - Clarify the cover letter to focus on the contributor focused
> >   Maintainer Entry Profiles, and defer discussion of a maintainer
> >   focused Handbook.
>
> OK, some notes...
>
> I wish you'd done this against docs-next, that would have saved me
> resolving a few conflicts on the MAINTAINERS file.
>
> I thought we'd agreed to move this to the process book?  That said, I now
> wonder about that...today I read the document as information for
> maintainers on how to create their profile, so its location in the
> maintainers manual is appropriate.
>
> There were a number RST issues and warnings that I fixed up with the
> following add-on patch; it was mostly a matter of adding blank lines where
> needed.
>
> One other warning resulted from the nvdimm profile document not being
> linked into the TOC tree.  I've added a TOC section to the new document to
> bring these things together for now.  This is almost certainly not what we
> want in the longer term.
>
> It was tempting to ask for this stuff to be fixed up, but I didn't want to
> delay this work any longer.  So it's applied to docs-next; unless something
> explodes in the very near future, I intend to push this for 5.5.

Apologies for all of the above. I rushed it without considering the
docs submission basics. Thanks for moving this forward.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
