Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2661C07D4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 22:25:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C60BC111387F8;
	Thu, 30 Apr 2020 13:24:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4194C111387F7
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 13:24:05 -0700 (PDT)
IronPort-SDR: Nfjob8wcsLvj4KiJgbpZu4BDvJGEKVNwJMzxPaELsbiQKLI6HNWqswme9fhwlN8zvQU6U1Mq0t
 VsJ6oQdWurtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 13:25:18 -0700
IronPort-SDR: cdfVVzrh6ngjaDBZLFBICWr5KRRav1Et0SERCoAbGfCgIsOaX0I4vgmIe0LtMc4Ae0ffdyOSxM
 B/T8PSwMcZVQ==
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400";
   d="scan'208";a="249848943"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 13:25:17 -0700
Date: Thu, 30 Apr 2020 13:25:16 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Message-ID: <20200430202516.GA26147@agluck-desk2.amr.corp.intel.com>
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
 <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0Sza8uzQHzJbdt7FFc7bRK+o1BB=VBUGrQEvVv6+23w@mail.gmail.com>
Message-ID-Hash: KPZKC5BW5EMJ7DKKE4MNR2YDGLW5CCXF
X-Message-ID-Hash: KPZKC5BW5EMJ7DKKE4MNR2YDGLW5CCXF
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KPZKC5BW5EMJ7DKKE4MNR2YDGLW5CCXF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 12:50:40PM -0700, Linus Torvalds wrote:

I see your point about the namimg being important.  I think Dan's
case is indeed "copy from pmem to user" where only options for faulting
are #MC on the source addresses, and #PF on the destination.

> The only *fundamental* access would likely be a single read/write
> operation, not a copy operation. Think "get_user()" instead of
> "copy_from_user()".  Even there you get combinatorial explosions with
> access sizes, but you can often generate those automatically or with
> simple patterns, and then you can build up the copy functions from
> that if you really need to.

That's maybe very clean. But it looks like it would be hard to build
a high performance interface on top of that primitive. Remember that
for Dan's copy 99.999999999367673%[1] of copies will not hit a machine
check on the read from pmem.

Dan wants (whatever the function name) to get to a "REP MOVS" with an
exception table entry to handle the cases where there is a fault.

-Tony

[1] Likely several more '9's in there
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
