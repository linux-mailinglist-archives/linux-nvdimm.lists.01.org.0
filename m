Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AACCC1C0322
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 18:52:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BB76110EAE2D;
	Thu, 30 Apr 2020 09:50:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DA9C110EAE28
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 09:50:46 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8B51D208DB
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588265517;
	bh=Qh9yGfu7EKu8YBjyZn57LidMIeIdE9hqIfI7Nfz5zto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQERtHd2tvFSzKdIw7cibcdVNaSdmyG20LzUeHLE/Rd8Ra4MIYEURm5Tv//rSLTV3
	 Ek6VFKay/KjG3PAgO0ceXHc5n3oywEIqZ8rPWxNojM3LY+jscNuyhwVbvMuYomubRe
	 4UlthhnQYnlVlPE86wP9+rVbZLbym61P7wrGwo7c=
Received: by mail-wm1-f43.google.com with SMTP id g12so2764252wmh.3
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 09:51:57 -0700 (PDT)
X-Gm-Message-State: AGi0PubSwDc/dT26Ol7JAWeDq+15+3xVQT7DjbBK5tpG32RGMcyb3mU3
	OnKTWMKuvImObLSiW6zH1ACZ+J5ULTgtvs1xm7Qvhg==
X-Google-Smtp-Source: APiQypIwzIih6qzG1E5/i+OpsglU4R3LqlrtKcQTjqR7B2k+mg5tCDSXpdynOS/JVqaM9P2DnRTopkyMsvqVuCFJ0bE=
X-Received: by 2002:a1c:23d4:: with SMTP id j203mr4175179wmj.49.1588265515945;
 Thu, 30 Apr 2020 09:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
In-Reply-To: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 30 Apr 2020 09:51:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
Message-ID: <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 6I7527PR7POVUVYY7ZN2LJUO26237EM4
X-Message-ID-Hash: 6I7527PR7POVUVYY7ZN2LJUO26237EM4
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6I7527PR7POVUVYY7ZN2LJUO26237EM4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 7:03 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Apr 30, 2020 at 1:41 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > With the above realizations the name "mcsafe" is no longer accurate and
> > copy_safe() is proposed as its replacement. x86 grows a copy_safe_fast()
> > implementation as a default implementation that is independent of
> > detecting the presence of x86-MCA.
>
> How is this then different from "probe_kernel_read()" and
> "probe_kernel_write()"? Other than the obvious "it does it for both
> reads and writes"?
>
> IOW, wouldn't it be sensible to try to match the naming and try to
> find some unified model for all these things?
>
> "probe_kernel_copy()"?

I don't like this whole concept.

If I'm going to copy from memory that might be bad but is at least a
valid pointer, I want a function to do this.  If I'm going to copy
from memory that might be entirely bogus, that's a different
operation.  In other words, if I'm writing e.g. filesystem that is
touching get_user_pages()'d persistent memory, I don't want to panic
if the memory fails, but I do want at least a very loud warning if I
follow a wild pointer.

So I think that probe_kernel_copy() is not a valid replacement for
memcpy_mcsafe().

--Andy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
