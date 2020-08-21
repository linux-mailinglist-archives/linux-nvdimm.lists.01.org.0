Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415924E3DA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 22 Aug 2020 01:21:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DA64123C6957;
	Fri, 21 Aug 2020 16:21:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C50C119F4879
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 16:21:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2FBDB20738;
	Fri, 21 Aug 2020 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598052096;
	bh=QzsBSM5u7JGxRu/ciLFY8y7akMNJdP69NV9xh2R8jvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3PNG0sdPSD3mPcp20plSlrktFCtDBHymfxjoAkCJTF0xWbhYdG9I8/LK5zKQmOfc
	 aVNBWa+C6CggUUGGV+olsDq6o9MmoD5h9q1OcDoDl3tuTi6/L4uwG/WzHeo5ThisZB
	 bgh7ZNG+YssW/9/xO4xyBm7lxev6px6GfWmnJzfw=
Date: Fri, 21 Aug 2020 16:21:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved
 ranges
Message-Id: <20200821162134.97d551c6fe45b489992841a8@linux-foundation.org>
In-Reply-To: <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
	<c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com>
	<CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 32QQWRUKBMXR6VYRYASYII4PTYQ7532A
X-Message-ID-Hash: 32QQWRUKBMXR6VYRYASYII4PTYQ7532A
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inria.fr
 >, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/32QQWRUKBMXR6VYRYASYII4PTYQ7532A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2020 18:53:57 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> > I think I am missing some important pieces. Bear with me.
> 
> No worries, also bear with me, I'm going to be offline intermittently
> until at least mid-September. Hopefully Joao and/or Vishal can jump in
> on this discussion.

Ordinarily I'd prefer a refresh&resend for 2+ week-old series such as
this.

But given that v4 all applies OK and that Dan has pending outages, I'll
scoop up this version, even though at least one change has been suggested.

Also, this series has killed Zhen Lei's little cleanup
(http://lkml.kernel.org/r/20200817065926.2239-1-thunder.leizhen@huawei.com).
I don't think the affected code was moved elsewhere, so I'll drop that
patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
