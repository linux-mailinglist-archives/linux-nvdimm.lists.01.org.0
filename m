Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE61C4913
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 23:31:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9616F1162A524;
	Mon,  4 May 2020 14:29:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 576A61162A364
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 14:29:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so102457edv.2
        for <linux-nvdimm@lists.01.org>; Mon, 04 May 2020 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6K9rzdvWscNG4wZPQ1rJpU9QAUIGngtAWX+SWcl3dk=;
        b=HFz4z/6vNebp8NseCgqhAEQfo5KWVIcyjrxldQaD5QkV0Qfculhk7762n62lN/0bGY
         EE5bkJGb69yHfC2fRhWCC/qXBf0gqZ5OdDpol202tw5MCCGK1ss2EAsqOa++mVG1KjiN
         SurKrYicx486IwQfZJdRs1K1Cwxb2R+dhl5qBJGNKhdfs6IztdFeg4HM3b4kHaSWRylb
         R/CI15wL0O7F4WhglJR6q+k5Lj11gnXFenkR/PqnxmqL7/PGOCFnvYrgLsL6QN1xnOTD
         eX2JK0UM7l00ntGZVtUsQc6pmed40z1McRpthk7/QXnBlGQ+Fa7IOG1WRA1dOIO2eX1k
         5Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6K9rzdvWscNG4wZPQ1rJpU9QAUIGngtAWX+SWcl3dk=;
        b=Dx/Ikrfh7b1+q0yHKThpPHj8BqjlMV4bd5eYWmC+oWcY2ASQtk585NCN3kP6Z1Dyb4
         Rg8WoDKjC5uzZ9vzG6PRW+eD/geaxDS7/uqkit+uNcLRAeTZOsMAGoZw2Bo4omo6Lhhw
         36DQvubqMKv0gQKm98SEBtYG0tO19aru0zXmGeDU6XtQILHFHPXs/QQ0+mturcb5HU+C
         JuLv/mHAjTW0DcpAdxybjJq1lqJG+HzlmTffvRu+wo+P4R/wbgPkh27brfc79MFVJSAy
         VCcF4jQ5CkIzh3gwB+MvkGFLCox+bf1vJE12aC10yGiErfZ8ZcYfyErsMWQqj+AVdyJ9
         wXWg==
X-Gm-Message-State: AGi0Puary8K2PLX9ajNrsIyIXfLB4/BraYmx0UP7jq9UE9RYlwWumi2W
	fD/BHxbz9F/N5nipjGAZ6khxCclWRopNE0wDtAy50Q==
X-Google-Smtp-Source: APiQypLsUbY4xwta6nK8zdFY4PM1aXzxNUct4mV5ijnB2SRzlqauiInU9dEyyDSrj2cbNV1Gqc9iBqjU95LVtXcZorM=
X-Received: by 2002:a50:bb6b:: with SMTP id y98mr42475ede.296.1588627865384;
 Mon, 04 May 2020 14:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net> <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
 <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F612DF4@ORSMSX115.amr.corp.intel.com> <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
In-Reply-To: <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 May 2020 14:30:54 -0700
Message-ID: <CAPcyv4g9nTLTMjhQOJdu+v8n-Sc9L566KfnSjcz+0TS_Ge15Fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Andy Lutomirski <luto@kernel.org>
Message-ID-Hash: 4OFUEVNFQ556UGHISGJ6UB5BQR4UD7EJ
X-Message-ID-Hash: 4OFUEVNFQ556UGHISGJ6UB5BQR4UD7EJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Luck, Tony" <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4OFUEVNFQ556UGHISGJ6UB5BQR4UD7EJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2020 at 1:26 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, May 4, 2020 at 1:05 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > When a copy function hits a bad page and the page is not yet known to
> > > be bad, what does it do?  (I.e. the page was believed to be fine but
> > > the copy function gets #MC.)  Does it unmap it right away?  What does
> > > it return?
> >
> > I suspect that we will only ever find a handful of situations where the
> > kernel can recover from memory that has gone bad that are worth fixing
> > (got to be some code path that touches a meaningful fraction of memory,
> > otherwise we get code complexity without any meaningful payoff).
> >
> > I don't think we'd want different actions for the cases of "we just found out
> > now that this page is bad" and "we got a notification an hour ago that this
> > page had gone bad". Currently we treat those the same for application
> > errors ... SIGBUS either way[1].
>
> Oh, I agree that the end result should be the same.  I'm thinking more
> about the mechanism and the internal API.  As a somewhat silly example
> of why there's a difference, the first time we try to read from bad
> memory, we can expect #MC (I assume, on a sensibly functioning
> platform).  But, once we get the #MC, I imagine that the #MC handler
> will want to unmap the page to prevent a storm of additional #MC
> events on the same page -- given the awful x86 #MC design, too many
> all at once is fatal.  So the next time we copy_mc_to_user() or
> whatever from the memory, we'll get #PF instead.  Or maybe that #MC
> will defer the unmap?

After the consumption the PMEM driver arranges for the page to never
be mapped again via its "badblocks" list.

>
> So the point of my questions is that the overall design should be at
> least somewhat settled before anyone tries to review just the copy
> functions.

I would say that DAX / PMEM stretches the Linux memory error handling
model beyond what it was originally designed. The primary concepts
that bend the assumptions of mm/memory-failure.c are:

1/ DAX pages can not be offlined via the page allocator.

2/ DAX pages (well cachelines in those pages) can be asynchronously
marked poisoned by a platform or device patrol scrub facility.

3/ DAX pages might be repaired by writes.

Currently 1/ and 2/ are managed by a per-block-device "badblocks" list
that is populated by scrub results and also amended when #MC is raised
(see nfit_handle_mce()). When fs/dax.c services faults it will decline
to map the page if the physical file extent intersects a bad block.

There is also support for sending SIGBUS if userspace races the
scrubber to consume the badblock. However, that uses the standard
'struct page' error model and assumes that a file backed page is 1:1
mapped to a file. This requirement prevents filesystems from enabling
reflink. That collision and the desire to enable reflink is why we are
now investigating supplanting the mm/memory-failure.c model. When the
page is "owned" by a filesystem invoke the filesystem to handle the
memory error across all impacted files.

The presence of 3/ means that any action error handling takes to
disable access to the page needs to be capable of being undone, which
runs counter to the mm/memory-failure.c assumption that offlining is a
one-way trip.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
