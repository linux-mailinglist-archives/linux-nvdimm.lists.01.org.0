Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C761C06FD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 21:51:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 349A5110BB081;
	Thu, 30 Apr 2020 12:50:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 38D23110BB080
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:50:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k22so5563312eds.6
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+FwAVJSyrEXzkxSrmCS02v7oMdKUwO+F0o4wshx4Ek=;
        b=vVUQtbBBW2Z6/5fnVMc/CHaP+nmdWUZ9QxTg9U+zXdocuJvECmz2ZYNIGKPPz6wnQ8
         Y/blY8yPzeccGFk3m1sEppcnDb2DSh0FgHkCsa362EpoiStkcCEFl/jvgV3GTQCJGqIR
         1F5ZNP+5RAyCH89lA/zS+VK58cK0uw0HhqVN63Enq4YTlK6yQyXV4DIfnL10P+OqgGw/
         HCg5266Eh5MmmWWOvAC6lE6/rve3bHhcEcgVc+Td4DD9a+Td1zEyKuOO0czcYWrzhCcT
         tvoeMJf89WE0O/M4IxIXqvfJwcRgTiFBEmYdGzxdktpJKukTKOFi25Kns4jm5Sm2dyAU
         yc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+FwAVJSyrEXzkxSrmCS02v7oMdKUwO+F0o4wshx4Ek=;
        b=mV2DeS5LqouBTQ6GHe4/G7S62w1GmM9X20dYEWyQzZRoGMY0++oeAuSwJ08FypaxK8
         OMzvQFh0KfF2rs+F+OH4hDwEGwzb2RyMrpPyaQVJYOZEdIFlVZKoFT71jO53/qBs4kke
         7S/sdi1N6n/AgljKGuws/5hz5CtAafNwvfBr7/WhCLaQY/DH6dm5giA0cYdCfdo5BuYu
         qGxCf9W48g33MQzs9olL/t/Ov6OFdRI3/7RToFUBGtvuTYg6gabtHz5/CHih9LAiWB2k
         09WzklZK5As8viwv157OMrscjm9V15IEqY6k5xtNHqZgZpNkYT+1K6YS63g9KDObNeTn
         A08w==
X-Gm-Message-State: AGi0PuYhnnfKrq615gNYZWz+SpzZS2f9X0YwtSPHOGXaZztjgFzKqMRc
	wVZNyfw3ptPijIr/t+NxSdDkHXvvffYdfz3bJDjh3g==
X-Google-Smtp-Source: APiQypKSjYZOD7xk1KJYIgeWWnr+Sy7zH5f3yAinfHlnQz1vSgERtk1La4XpoWwZWcsoyFjvzfAAP5KPRwAA/g7JUtg=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr620607edr.154.1588276309142;
 Thu, 30 Apr 2020 12:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com> <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 30 Apr 2020 12:51:38 -0700
Message-ID: <CAPcyv4g8rA2TRvoFHqEjs5Xn74gdZx8uF0PXFYCjTcx56yA=Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: EGB7E34HRZ3KVZVRFIR7EGVHSRCLNOL7
X-Message-ID-Hash: EGB7E34HRZ3KVZVRFIR7EGVHSRCLNOL7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EGB7E34HRZ3KVZVRFIR7EGVHSRCLNOL7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 12:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Apr 30, 2020 at 11:42:20AM -0700, Andy Lutomirski wrote:
> > I suppose there could be a consistent naming like this:
> >
> > copy_from_user()
> > copy_to_user()
> >
> > copy_from_unchecked_kernel_address() [what probe_kernel_read() is]
> > copy_to_unchecked_kernel_address() [what probe_kernel_write() is]
> >
> > copy_from_fallible() [from a kernel address that can fail to a kernel
> > address that can't fail]
> > copy_to_fallible() [the opposite, but hopefully identical to memcpy() on x86]
> >
> > copy_from_fallible_to_user()
> > copy_from_user_to_fallible()
> >
> > These names are fairly verbose and could probably be improved.
>
> How about
>
>         try_copy_catch(void *dst, void *src, size_t count, int *fault)
>
> returns number of bytes not-copied (like copy_to_user etc).
>
> if return is not zero, "fault" tells you what type of fault
> cause the early stop (#PF, #MC).

I do like try_copy_catch() for the case when neither of the buffers
are __user (like in the pmem driver) and _copy_to_iter_fallible()
(plus all the helpers it implies) for the other cases.

copy_to_user_fallible
copy_fallible_to_page
copy_pipe_to_iter_fallible

...because the mmu-fault handling is an aspect of "_user" and fallible
implies other source fault reasons. It does leave a gap if an
architecture has a concept of a fallible write, but that seems like
something that will be handled asynchronously and not subject to this
interface.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
