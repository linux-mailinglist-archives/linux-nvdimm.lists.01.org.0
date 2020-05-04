Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65B1C4608
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 20:34:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 929C3115170E9;
	Mon,  4 May 2020 11:32:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DDB4D11504EDE
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 11:32:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr25so14797303ejb.10
        for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Glau+s6Q6iM76mHi/QXePg8xF2snTXD5otz87ESSu8A=;
        b=F+2NEE8n0+6a2Uxkq3oo+gK/iDs1gXhBaBtJu3It7O83YXrMkKTw/j5R5KqU4cLb1I
         vlOYdG8d6H2sSQjfFpkieMLY+KM5edr1MbbCXsj+B9wkYlXKMNdfSGw1CJFXf7fx5Q7C
         nLx7CYq5rjomyrqgHsVmp6vku6f3HeDmYZpPHsh7ka8b5Df1pXeivwm1iUG0Tio8BF4o
         ZS585n3JOtRJMk45ZcupX+D3R94fYlWZsYjSr5wbogW/u9eqdMEat4pDnASo56oFKvzS
         7tnb7wc1b4OhUfvjaDeX366gFmfgoP2fFKltlwAvd8N31RZXbHNtbqksmP+ogCEDB/JL
         SgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Glau+s6Q6iM76mHi/QXePg8xF2snTXD5otz87ESSu8A=;
        b=a7mVkx8kJIkIvp8dBkvp6A2WrC4q5/ElFxLFAkZ0eVo22qWkbPjYYX5TECmMtfGPUs
         Vepb8qi3m60wvxkMhsfcDV+i64aJycr9EbWALbodGzS+Vno3dswGdmwq7mWT1/B4e6l8
         uw/Lh5BSGy2E+fbBxO/iSmfIvTPSLAvbYuAgDiZvrwy1KON5RDF5IEN4nOnYpxcAEbRI
         1WaQ4Qo193e6N2yj4kegyt9NLipeg2g6wwlqJAl+IXJfbZzEX/YvhbUGBqOkulnDgGaQ
         UNStUwHasKybgxqEZQXZKQ2MNL3etisaRs67EZI6qjwp4cI7U9XNzOqp3A8eSVP834bb
         0F1Q==
X-Gm-Message-State: AGi0PuZWZEQ8MiEwteETM1BFqFwZSmEjNww0nw+NB77oWmzPXYKraKEk
	/sCBUEaiMGb0DKZtvJEVwdx1smhBweRW9XshcU0bgA==
X-Google-Smtp-Source: APiQypKMZgww2SWaJ3dlnMp45iEyQic5CmZ0rEfuzBZzZC+1C4Op+IwopR9sfyLSwESK4to/xI+WLCvGiTO9JNWKJqE=
X-Received: by 2002:a17:907:9e5:: with SMTP id ce5mr15759967ejc.123.1588617237480;
 Mon, 04 May 2020 11:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com> <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
 <CAPcyv4g0a406X9-=NATJZ9QqObim9Phdkb_WmmhsT9zvXsGSpw@mail.gmail.com>
 <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <CAPcyv4jvgCGU700x_U6EKyGsHwQBoPkJUF+6gP4YDPupjdViyQ@mail.gmail.com>
 <CAHk-=wiPkwF2+y6wZd=VD9BooKxHRWhSVW8dr+WSeeSPkJk7kQ@mail.gmail.com> <a4aabe6f2ca649779a772a5f0365af6f@AcuMS.aculab.com>
In-Reply-To: <a4aabe6f2ca649779a772a5f0365af6f@AcuMS.aculab.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 May 2020 11:33:46 -0700
Message-ID: <CAPcyv4i8V9FCuTHZG2RG9o3vjrMmLkv40-41MwLBO8tZWUsZ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: David Laight <David.Laight@aculab.com>
Message-ID-Hash: 6VG7LF6XQVO53YK5RFWPI7MHG32TTHQD
X-Message-ID-Hash: 6VG7LF6XQVO53YK5RFWPI7MHG32TTHQD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6VG7LF6XQVO53YK5RFWPI7MHG32TTHQD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, May 3, 2020 at 5:57 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> > Sent: 01 May 2020 19:29
> ...
> > And as DavidL pointed out - if you ever have "iomem" as a source or
> > destination, you need yet another case. Not because they can take
> > another kind of fault (although on some platforms you have the machine
> > checks for that too), but because they have *very* different
> > performance profiles (and the ERMS "rep movsb" sucks baby donkeys
> > through a straw).
>
>
> I was actually thinking that the nvdimm accesses need to be treated
> much more like (cached) memory mapped io space than normal system
> memory.
> So treating them the same as "iomem" and then having access functions
> that report access failures (which the current readq() doesn't)
> might make sense.

While I agree that something like copy_mc_iomem_to_{user,kernel} could
have users, nvdimm is not one of them.

> If you are using memory that 'might fail' for kernel code or data
> you really get what you deserve.

nvdimms are no less "might fail" than DRAM, recall that some nvdimms
are just DRAM with a platform promise that their contents are battery
backed.

> OTOH system response to PCIe errors is currently rather problematic.
> Mostly reads time out and return ~0u.
> This can be checked for and, if possibly valid, a second location read.

Yes, the ambiguous ~0u return needs careful handling.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
