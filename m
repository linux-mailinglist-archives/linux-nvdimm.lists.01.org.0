Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC611C4833
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 22:26:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49C761162A356;
	Mon,  4 May 2020 13:24:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE0331006C5E7
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 13:24:39 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 87AA42073B
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588623978;
	bh=DUmpNCt7sNyutHVhULaA6d0vAPjjPhpTraWgkmnZdyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NegKgKRyNaBnuN1TsEeybVyUpLpVAhemIuLm9j/zLlEB3qOt+cLqmOs0ponzzNQza
	 RVlNbSAfJLTkubAHt/TYjR+dWgCr9hhLfxw9jLQyoh04MDTj5pxeTsfjOZTAodh7c2
	 T41uMj5P2AlxGzwIoma3qeOBFrZQfayEHF9uRg4I=
Received: by mail-wr1-f44.google.com with SMTP id k1so26255wro.12
        for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 13:26:18 -0700 (PDT)
X-Gm-Message-State: AGi0PubJLr79a/IxSLW2000YmXrVbKtHIky6Vho2L3zAKMI8/GxDzDLU
	KgSis3O3S7invykWcbccpg9RL/VENuygcoixDpng7g==
X-Google-Smtp-Source: APiQypJgIr3SLa4yyIaFXtdy872yoxtbq48e5nGbKjFHKp58KwjtLIyJDkPPDArLP6fzN/fnACAi9buLhS2L24Hcp80=
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr1151633wrr.70.1588623976949;
 Mon, 04 May 2020 13:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net> <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
 <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7F612DF4@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F612DF4@ORSMSX115.amr.corp.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 4 May 2020 13:26:05 -0700
X-Gmail-Original-Message-ID: <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
Message-ID: <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: Y2WR2XCHSP5CTXRIO4V6EE5CMEGUMGX7
X-Message-ID-Hash: Y2WR2XCHSP5CTXRIO4V6EE5CMEGUMGX7
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y2WR2XCHSP5CTXRIO4V6EE5CMEGUMGX7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2020 at 1:05 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > When a copy function hits a bad page and the page is not yet known to
> > be bad, what does it do?  (I.e. the page was believed to be fine but
> > the copy function gets #MC.)  Does it unmap it right away?  What does
> > it return?
>
> I suspect that we will only ever find a handful of situations where the
> kernel can recover from memory that has gone bad that are worth fixing
> (got to be some code path that touches a meaningful fraction of memory,
> otherwise we get code complexity without any meaningful payoff).
>
> I don't think we'd want different actions for the cases of "we just found out
> now that this page is bad" and "we got a notification an hour ago that this
> page had gone bad". Currently we treat those the same for application
> errors ... SIGBUS either way[1].

Oh, I agree that the end result should be the same.  I'm thinking more
about the mechanism and the internal API.  As a somewhat silly example
of why there's a difference, the first time we try to read from bad
memory, we can expect #MC (I assume, on a sensibly functioning
platform).  But, once we get the #MC, I imagine that the #MC handler
will want to unmap the page to prevent a storm of additional #MC
events on the same page -- given the awful x86 #MC design, too many
all at once is fatal.  So the next time we copy_mc_to_user() or
whatever from the memory, we'll get #PF instead.  Or maybe that #MC
will defer the unmap?

So the point of my questions is that the overall design should be at
least somewhat settled before anyone tries to review just the copy
functions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
