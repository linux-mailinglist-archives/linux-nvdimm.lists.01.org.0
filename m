Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4F22B34A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 18:18:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D454C1250EFCC;
	Thu, 23 Jul 2020 09:18:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=fenghua.yu@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCC251250EFCB
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 09:18:19 -0700 (PDT)
IronPort-SDR: jRAu/bd+D0MbiXFR+mxyGq7QqTCzx7CGLV2vmRnAGX6SupdHBXCNq/LcrLf8cqUTR06nb/9W2m
 RgMncc4Yy2vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148058231"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="148058231"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:18:19 -0700
IronPort-SDR: kf2KWN7WI2p4vd74GFsxQMiXONFSvdTEj6bfjU/HaqJRxh3PGZm95T03EkTMNRYV+oRWiqE8bl
 Q0ShhWAOk+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="311087983"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 09:18:18 -0700
Date: Thu, 23 Jul 2020 09:18:18 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200723161818.GA77434@romley-ivt3.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Message-ID-Hash: BL3AG6BMYBA7CF3WJSV5UO2YVFCPILWT
X-Message-ID-Hash: BL3AG6BMYBA7CF3WJSV5UO2YVFCPILWT
X-MailFrom: fenghua.yu@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BL3AG6BMYBA7CF3WJSV5UO2YVFCPILWT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 22, 2020 at 09:21:43AM -0700, Andy Lutomirski wrote:
> On Fri, Jul 17, 2020 at 12:21 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The PKRS MSR is not managed by XSAVE.  It is already preserved through a
> > context switch but this support leaves exception handling code open to
> > memory accesses which the interrupted process has allowed.
> >
> > Close this hole by preserve the current task's PKRS MSR, reset the PKRS
> > MSR value on exception entry, and then restore the state on exception
> > exit.
> 
> Should this live in pt_regs?

The PKRS MSR has been preserved in thread_info during kernel entry. We
don't need to preserve it in another place (i.e. idtentry_state).

To avoid confusion, I think we need to change the above commit message to:

"Exception handling code is open to memory accesses which the interrupted
process has allowed.

Close this hole by reset the PKRS MSR value on exception entry and restore
the state on exception exit. The MSR was preserved in thread_info."

The patch needs to be changed accordingly, I think:

1. No need to define "pks" in struct idtentry_state because the MSR is
   already preserved in thread_info.
2. idt_save_pkrs() could be renamed as idt_reset_pkrs() to reset
   the MSR (no need to save it). "state.pkrs" can be replaced by
   "current->thread_info.pkrs" now.
3. The "pkrs_ref" could be defined in thread_info as well. But I'm not
   sure if it's better than defined in idtentry_state.

Thanks.

-Fenghua
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
