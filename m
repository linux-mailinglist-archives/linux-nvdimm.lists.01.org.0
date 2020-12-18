Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E42DDD94
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 05:05:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DBC17100EB827;
	Thu, 17 Dec 2020 20:05:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39D06100EBB9C
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 20:05:11 -0800 (PST)
IronPort-SDR: CG8ENTe4we4LQJN5scFUvRbz75U00FDRsMKNrGbv7ALRbK57vHx+4Bb/Sbcg5FcQKtRt36Rsu+
 VWPgXKG6tNrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="155182758"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="155182758"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:10 -0800
IronPort-SDR: H7Ptrfhyn4Q0/MQ290Py5RH1IOQkdFP9uA3u+tCGsO9MgVxuu6W0YKL6rjeHqs7mJDR3X8q6uC
 hP2pWdLfD4iQ==
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400";
   d="scan'208";a="353728334"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 20:05:10 -0800
Date: Thu, 17 Dec 2020 20:05:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 10/10] x86/pks: Add PKS test code
Message-ID: <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-11-ira.weiny@intel.com>
 <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: YTAKTSR25TEZEMP75TAIVPY65EX7CGNI
X-Message-ID-Hash: YTAKTSR25TEZEMP75TAIVPY65EX7CGNI
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YTAKTSR25TEZEMP75TAIVPY65EX7CGNI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 12:55:39PM -0800, Dave Hansen wrote:
> On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> > +		/* Arm for context switch test */
> > +		write(fd, "1", 1);
> > +
> > +		/* Context switch out... */
> > +		sleep(4);
> > +
> > +		/* Check msr restored */
> > +		write(fd, "2", 1);
> 
> These are always tricky.  What you ideally want here is:
> 
> 1. Switch away from this task to a non-PKS task, or
> 2. Switch from this task to a PKS-using task, but one which has a
>    different PKS value

Or both...

> 
> then, switch back to this task and make sure PKS maintained its value.
> 
> *But*, there's no absolute guarantee that another task will run.  It
> would not be totally unreasonable to have the kernel just sit in a loop
> without context switching here if no other tasks can run.
> 
> The only way you *know* there is a context switch is by having two tasks
> bound to the same logical CPU and make sure they run one after another.

Ah...  We do that.

...
+       CPU_ZERO(&cpuset);
+       CPU_SET(0, &cpuset);
+       /* Two processes run on CPU 0 so that they go through context switch.  */
+       sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
...

I think this should be ensuring that both the parent and the child are
running on CPU 0.  At least according to the man page they should be.

<man>
	A child created via fork(2) inherits its parent's CPU affinity mask.
</man>

Perhaps a better method would be to synchronize the 2 threads more to ensure
that we are really running at the 'same time' and forcing the context switch.

>  This just gets itself into a state where it *CAN* context switch and
> prays that one will happen.

Not sure what you mean by 'This'?  Do you mean that running on the same CPU
will sometimes not force a context switch?  Or do you mean that the sleeps
could be badly timed and the 2 threads could run 1 after the other on the same
CPU?  The latter is AFAICT the most likely case.

> 
> You can also run a bunch of these in parallel bound to a single CPU.
> That would also give you higher levels of assurance that *some* context
> switch happens at sleep().

I think more cycles is a good idea for sure.  But I'm more comfortable with
forcing the test to be more synchronized so that it is actually running in the
order we think/want it to be.

> 
> One critical thing with these tests is to sabotage the kernel and then
> run them and make *sure* they fail.  Basically, if you screw up, do they
> actually work to catch it?

I'll try and come up with a more stressful test.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
