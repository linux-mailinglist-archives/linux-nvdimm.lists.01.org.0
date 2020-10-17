Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A032914D7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 23:43:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE11315B52C67;
	Sat, 17 Oct 2020 14:43:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C900515B52C64
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 14:43:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 38A9D207BB;
	Sat, 17 Oct 2020 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602971032;
	bh=mKSsEA+CHGSr4w2wPFuxsWZIlxQ5m4d+o0FC2tKtPLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IizuI3dcpkeMihl/D2eDP8IMaPe3LXKYR4wVNFZ2IOe4j3LPKSVLp4M4/pqvcQ05r
	 Wcvdyps+m2KlM/Kqt7MAVdUmzbcU5D9HG0vJJRrJx3R9n5KyJnc8+bnCqWO9kCeWvx
	 vx1Rx4NjA3jxkqO9+Eh/diPBE5kML8z6qBIyzwAE=
Date: Sat, 17 Oct 2020 14:43:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] device-dax/kmem: Use struct_size()
Message-Id: <20201017144351.faf85ca9880e43e68e7f9991@linux-foundation.org>
In-Reply-To: <CAPcyv4jSji5KvLuouqSt-O_-iuKnCu4pXL1cEUqd1Ws+gjxqHw@mail.gmail.com>
References: <160288261564.3242821.6055291930923876456.stgit@dwillia2-desk3.amr.corp.intel.com>
	<CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
	<CAPcyv4jSji5KvLuouqSt-O_-iuKnCu4pXL1cEUqd1Ws+gjxqHw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: XO7G4WPAQRILLTYL7R36EQXLKGEYQEM7
X-Message-ID-Hash: XO7G4WPAQRILLTYL7R36EQXLKGEYQEM7
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, David Miller <davem@davemloft.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XO7G4WPAQRILLTYL7R36EQXLKGEYQEM7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2020 13:54:08 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> On Sat, Oct 17, 2020 at 11:39 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Link: http://lore.kernel.org/r/CAHk-=wgNTLbvAD8mNTvh+GQyapNWeX20PXhU_+frqEvVq4298w@mail.gmail.com
> >
> > Does that link work for you?
> >
> > Because I can't see it.
> >
> > In fact, I don't see my email at all on lore, even if I see Andrew's
> > email that I answered to:
> >
> >     https://lore.kernel.org/mm-commits/20201016024059.Ycwm4GmQ8%25akpm@linux-foundation.org/
> >
> > but your link gives me "Not Found", and when I search for emails from
> > me on mm-commits I don't see them either.
> >
> > Adding Konstantin just to solve the mystery. Some odd mirroring
> > problem, perhaps?
> 
> The link did not, and still does not work for me. I was hoping that
> was a temporary condition until the thread made it out to the
> mm-commits@ archive on lore, but it never seemed to resolve.

mm-commits is writeable-only-by-akpm.  That's how davem originally set
it up, not sure why.  I don't think this has caused difficulty in the
past, but it is a bit odd.  Dave, can we please turn it into a
regularly managed list?

Thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
