Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624627DFD7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 07:05:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49630154A9B0E;
	Tue, 29 Sep 2020 22:05:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A27E5154A75E5
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 22:05:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092a003ee64aac7a8dc174.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:3ee6:4aac:7a8d:c174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36A3D1EC03D5;
	Wed, 30 Sep 2020 07:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1601442304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=n2nkxu4xTZZhZzy2McG9Zfzz9yulljqwC+oUwVYbXuw=;
	b=bLBgSqlZAZjg/6IZuhzkE8BHpsAH5mJ25Fl0wXPymz3R8Iiowss8xSVi+BiZ9ck57j+EGU
	IFHvRlGQiaArpROj2Q5VR4U27AlusQLRhCDHJLtKYLefaO5/YSzLcB4Y7pJ6X5vUW/QYMl
	0+0rTy9poUtzo/YQjbVC4Aivf9qvARQ=
Date: Wed, 30 Sep 2020 07:04:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user,
 kernel}
Message-ID: <20200930050455.GA6810@zn.tnic>
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com>
Message-ID-Hash: 2GBVZ26R4DLPXPN26RRNFIGZGBYYJFVH
X-Message-ID-Hash: 2GBVZ26R4DLPXPN26RRNFIGZGBYYJFVH
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 0day robot <lkp@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2GBVZ26R4DLPXPN26RRNFIGZGBYYJFVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 03:32:07PM -0700, Dan Williams wrote:
> Given that Linus was the primary source of review feedback on these
> patches and a version of them have been soaking in -next with only a
> minor conflict report with vfs.git for the entirety of the v5.9-rc
> cycle (left there inadvertently while I was on leave), any concerns
> with me sending this to Linus directly during the merge window?

What's wrong with them going through tip?

But before that pls have a look at this question I have here:

https://lkml.kernel.org/r/20200929102512.GB21110@zn.tnic

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
