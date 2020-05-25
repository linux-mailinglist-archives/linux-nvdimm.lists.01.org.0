Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B21E1285
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 18:19:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDF5011D7C3A1;
	Mon, 25 May 2020 09:15:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net; receiver=<UNKNOWN> 
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3C1B122338D3
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 09:15:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DBA9C2DC;
	Mon, 25 May 2020 16:19:14 +0000 (UTC)
Date: Mon, 25 May 2020 10:19:13 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] nvdimm: fixes to maintainter-entry-profile
Message-ID: <20200525101913.07735d91@lwn.net>
In-Reply-To: <103a0e71-28b5-e4c2-fdf2-80d2dd005b44@infradead.org>
References: <103a0e71-28b5-e4c2-fdf2-80d2dd005b44@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Message-ID-Hash: I5M7MMQXZPB6P6IYRDFQZ3Z4XQTZ543F
X-Message-ID-Hash: I5M7MMQXZPB6P6IYRDFQZ3Z4XQTZ543F
X-MailFrom: corbet@lwn.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I5M7MMQXZPB6P6IYRDFQZ3Z4XQTZ543F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2020 09:51:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix punctuation and wording in a few places.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/nvdimm/maintainer-entry-profile.rst |   14 ++++++------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
