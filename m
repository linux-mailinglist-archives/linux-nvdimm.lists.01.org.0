Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCF22B736
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 22:08:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF2D9125181E3;
	Thu, 23 Jul 2020 13:08:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7EA24125181E2
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 13:08:31 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595534908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcJAgsOSpTUEgvY6TWictE7IGPlqieS/49LNHUp//Yw=;
	b=CRCgIJGJxugLOeTOjkAKqyyWua6AvCfsKSCzuzfk55e8lISsF4ESPLNp3f9NWlaiKxBUzv
	AlYD1UiYT071te14Adxvg5Ukcn9eRsw0LkEawZU0jXCPPCrf80QNqTQEa/OkzHi+y57iCn
	f50E6YAnfuVo87toqIOCGVSXDZHG/SNtytOlbaeIjXI/theIMXRW8OjXXiRSgf0OpW0qEi
	agbaK6t00ae+2XwJ5Ygm6/OhjUgrMa9vzDQHM2y4QCTvh1N2c/72aEzQcsjyOQv8+a1Zko
	KLMEvzza4qp0QTwTbN+0w+TU02cXZ+KkRidBVwnzrBgrsRVWp2ZMbE8oCYwmQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595534908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcJAgsOSpTUEgvY6TWictE7IGPlqieS/49LNHUp//Yw=;
	b=v2BAJcOjy+PMvyzn34HicDvcq5vL36f83YwtzQiduKbxChpsust4smos5IhggWXITd1iLU
	tCWUu0G6ipkNHUAA==
To: Ira Weiny <ira.weiny@intel.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <20200717100610.GH10769@hirez.programming.kicks-ass.net> <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
Date: Thu, 23 Jul 2020 22:08:27 +0200
Message-ID: <87o8o6vvt0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: TDPMARPLTDM4BGLAQXMHCS6MT7BFDHNX
X-Message-ID-Hash: TDPMARPLTDM4BGLAQXMHCS6MT7BFDHNX
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TDPMARPLTDM4BGLAQXMHCS6MT7BFDHNX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:
> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> I've been really digging into this today and I'm very concerned that I'm
> completely missing something WRT idtentry_enter() and idtentry_exit().
>
> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
> with trace_printk()'s.
>
> With this debug code, I have found an instance where it seems like
> idtentry_enter() is called without a corresponding idtentry_exit().  This has
> left the thread ref counter at 0 which results in very bad things happening
> when __dev_access_disable() is called and the ref count goes negative.
>
> Effectively this seems to be happening:
>
> ...
> 	// ref == 0
> 	dev_access_enable()  // ref += 1 ==> disable protection
> 		// exception  (which one I don't know)
> 			idtentry_enter()
> 				// ref = 0
> 				_handler() // or whatever code...
> 			// *_exit() not called [at least there is no trace_printk() output]...
> 			// Regardless of trace output, the ref is left at 0
> 	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
> 	(Bad stuff is bound to happen now...)

Well, if any exception which calls idtentry_enter() would return without
going through idtentry_exit() then lots of bad stuff would happen even
without your patches.

> Also is there any chance that the process could be getting scheduled and that
> is causing an issue?

Only from #PF, but after the fault has been resolved and the tasks is
scheduled in again then the task returns through idtentry_exit() to the
place where it took the fault. That's not guaranteed to be on the same
CPU. If schedule is not aware of the fact that the exception turned off
stuff then you surely get into trouble. So you really want to store it
in the task itself then the context switch code can actually see the
state and act accordingly.

Thanks,

        tglx

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
