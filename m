Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750D1C063D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 21:23:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D673110053E15;
	Thu, 30 Apr 2020 12:21:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=tony.luck@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2AE810053E02
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 12:21:48 -0700 (PDT)
IronPort-SDR: 7eK7VvzhANR4pZz528zGpX0YIYTZNwVwiDxrVWlBXSIH65X/e2AmZnDlxLbUUGqwMaXpewx9To
 xnUyQmonPlcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 12:23:00 -0700
IronPort-SDR: mmOO9TeGehW6ZKsO2AabJSyPfx1On12iSR7UbQV26uvMH5iIZWkP61nrPG6nfcG9OdZdtKTjq6
 DEfOJCg3MGgg==
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400";
   d="scan'208";a="459685832"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 12:22:59 -0700
Date: Thu, 30 Apr 2020 12:22:58 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Message-ID: <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com>
Message-ID-Hash: YOWGLR53LKTABIJBJDWVYFGPVXTICIIH
X-Message-ID-Hash: YOWGLR53LKTABIJBJDWVYFGPVXTICIIH
X-MailFrom: tony.luck@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YOWGLR53LKTABIJBJDWVYFGPVXTICIIH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 11:42:20AM -0700, Andy Lutomirski wrote:
> I suppose there could be a consistent naming like this:
> 
> copy_from_user()
> copy_to_user()
> 
> copy_from_unchecked_kernel_address() [what probe_kernel_read() is]
> copy_to_unchecked_kernel_address() [what probe_kernel_write() is]
> 
> copy_from_fallible() [from a kernel address that can fail to a kernel
> address that can't fail]
> copy_to_fallible() [the opposite, but hopefully identical to memcpy() on x86]
> 
> copy_from_fallible_to_user()
> copy_from_user_to_fallible()
> 
> These names are fairly verbose and could probably be improved.

How about

	try_copy_catch(void *dst, void *src, size_t count, int *fault)

returns number of bytes not-copied (like copy_to_user etc).

if return is not zero, "fault" tells you what type of fault
cause the early stop (#PF, #MC).

-Tony
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
