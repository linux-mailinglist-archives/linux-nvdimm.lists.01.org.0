Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794871EA6F1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 17:36:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B15A9100DD896;
	Mon,  1 Jun 2020 08:31:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c01:e000:3a1::42; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60C87100DD895
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 08:31:39 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AA8EB37B;
	Mon,  1 Jun 2020 15:36:22 +0000 (UTC)
Date: Mon, 1 Jun 2020 09:36:21 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: fixes to the maintainer-entry-profile
 template
Message-ID: <20200601093621.0c0b8345@lwn.net>
In-Reply-To: <fbaa9b67-e7b8-d5e8-ecbb-6ae068234880@infradead.org>
References: <fbaa9b67-e7b8-d5e8-ecbb-6ae068234880@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Message-ID-Hash: BYVHS2B5IKPCQL4R7ICB56Z6TZRWDAAM
X-Message-ID-Hash: BYVHS2B5IKPCQL4R7ICB56Z6TZRWDAAM
X-MailFrom: corbet@lwn.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BYVHS2B5IKPCQL4R7ICB56Z6TZRWDAAM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2020 18:17:13 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Do some wordsmithing and copy editing on the maintainer-entry-profile
> profile (template, guide):
> - fix punctuation
> - fix some wording
> - use "-rc" consistently
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst |   12 +++++-----
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
