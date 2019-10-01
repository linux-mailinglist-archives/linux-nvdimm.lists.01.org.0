Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11722C3667
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Oct 2019 15:56:06 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A446610FC71F2;
	Tue,  1 Oct 2019 06:57:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 059EC10096C9B
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 06:57:29 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 32FD6491;
	Tue,  1 Oct 2019 13:56:00 +0000 (UTC)
Date: Tue, 1 Oct 2019 07:55:59 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
Message-ID: <20191001075559.629eb059@lwn.net>
In-Reply-To: <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
	<156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Message-ID-Hash: GP3CEOHGQ5PGGZVNK7M2ZYZTUP5EYQRT
X-Message-ID-Hash: GP3CEOHGQ5PGGZVNK7M2ZYZTUP5EYQRT
X-MailFrom: corbet@lwn.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Steve French <stfrench@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Dmitry Vyukov <dvyukov@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-nvdimm@lists.01.org, ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2019 08:48:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> As presented at the 2018 Linux Plumbers conference [1], the Maintainer
> Entry Profile (formerly Subsystem Profile) is proposed as a way to reduce
> friction between committers and maintainers and encourage conversations
> amongst maintainers about common best practices. While coding-style,
> submit-checklist, and submitting-drivers lay out some common expectations
> there remain local customs and maintainer preferences that vary by
> subsystem.
> 
> The profile contains short answers to some of the common policy questions a
> contributor might have that are local to the subsystem / device-driver, or
> otherwise not covered by the top-level process documents.
> 
> Overview: General introduction to how the subsystem operates
> Submit Checklist Addendum: Mechanical items that gate submission staging
> Key Cycle Dates:
>  - Last -rc for new feature submissions: Expected lead time for submissions
>  - Last -rc to merge features: Deadline for merge decisions
> Coding Style Addendum: Clarifications of local style preferences
> Resubmit Cadence: When to ping the maintainer
> Checkpatch / Style Cleanups: Policy on pure cleanup patches

So I'm finally back home after my European tour, and I have it on good
authority that my bag might even get here eventually too.  That means I'm
digging through a pile of docs stuff I've been neglecting badly...

My intention is to apply these patches.  But as I was reading through
them, one little nagging thing came to mind...

> See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> and a follow-on example profile for the libnvdimm subsystem.

Thus far, the maintainer guide is focused on how to *be* a maintainer.
This document, instead, is more about how to deal with specific
maintainers.  So I suspect that Documentation/maintainer might be the
wrong place for it.

Should we maybe place it instead under Documentation/process, or even
create a new top-level "book" for this information?

Thanks,

jon
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
