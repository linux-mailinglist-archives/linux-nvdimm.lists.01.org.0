Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9EE27EF64
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 18:38:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CCB4154C7B64;
	Wed, 30 Sep 2020 09:38:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA1251545C4B6
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 09:38:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092a00869c7b979af15d7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:869c:7b97:9af1:5d7f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEF5B1EC046E;
	Wed, 30 Sep 2020 18:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1601483922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=qAutDQ7C4SpF2Xd7IzT0f8niJ7rna8nfCt9PiwTl0gI=;
	b=Ilk2SJpEVtOdFldPJj0cEec9cU137AP1ZEKp6NPU9ORTQBLGkeCwnovf7BktfO+U/6MfCY
	+RwSEwUATCpRhutk9lvhzkJX69+TFV5nLV3a2ShkFmDyy0GfNKSLY9TK9Ad6RZu3AB4mQk
	Do/rR6fBumhX2rgXEIjHLDdXr4EqHvY=
Date: Wed, 30 Sep 2020 18:38:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user,
 kernel}
Message-ID: <20200930163839.GK6810@zn.tnic>
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com>
 <20200930050455.GA6810@zn.tnic>
 <CAPcyv4j=eyVMbcnrGDGaPe4AVXy5pJwa6EapH3ePh+JdF6zxnQ@mail.gmail.com>
 <20200930162403.GI6810@zn.tnic>
 <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
Message-ID-Hash: CV5OGWJ4E5WQRGCPI3YDE3XHTIGLTDYX
X-Message-ID-Hash: CV5OGWJ4E5WQRGCPI3YDE3XHTIGLTDYX
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 0day robot <lkp@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CV5OGWJ4E5WQRGCPI3YDE3XHTIGLTDYX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 09:28:33AM -0700, Linus Torvalds wrote:
> Oh, it's pretty much 100%.

Oh good.

> I can't imagine what would make me skip an rc8 at this point.
> Everything looks good right now (but not rc7, we had a stupid bug),
> but I'd rather wait a week than fins another silly bug the day after
> release (like happened in rc7)..

Yeah, -rc8 is clearly the best idea, why *wouldn't* one do it?!

:-)))

> We're talking literal "biblical burning bushes telling me to do a
> release" kind of events to skip rc8 by now.

If you do, it probably'll look like this:

diff --git a/Makefile b/Makefile
index 992d24467ca0..5e8819b99110 100644
--- a/Makefile
+++ b/Makefile
@@ -2,8 +2,8 @@
 VERSION = 5
 PATCHLEVEL = 9
 SUBLEVEL = 0
-EXTRAVERSION = -rc7
-NAME = Kleptomaniac Octopus
+EXTRAVERSION =
+NAME = Biblical Burning Bushes
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
