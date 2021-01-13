Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47872F468F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 09:35:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3ABA100EB33A;
	Wed, 13 Jan 2021 00:35:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.111.4.25; helo=out1-smtp.messagingengine.com; envelope-from=greg@kroah.com; receiver=<UNKNOWN> 
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 24ED7100EB339
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 00:35:44 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DC04E5C04B6;
	Wed, 13 Jan 2021 03:35:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Jan 2021 03:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=fm2; bh=QFrd8/Cm4EwX8Y7araktIbSjoBl
	mXGo8qHRYothcUyU=; b=Kc5lJDiYtkhMTO7ecGVPIhoQYr5AUQEoty0oA+U8XVN
	b7XttLCYOcLbaJMf6RPAljjcuVDRSqxPgmukEK2zvWtPKKy3LxevMkLGtUjqTbiD
	nRYh02JKFktwEm2CxlTtu2gJTb4ZXQb9jmU0gwFtxH4JPBQX3E809PBrSn5n+x+b
	ML0n9ctNnAk4BVSdLyHrb/RrvAvMtG1wyz80aPqH0IfJegZFU370ysrYPfuW0vSo
	QhrzCAbzbgvWcz9XwVtDjn4ydVjRkZQZu51lbGhBvQRZbRzb3+DF/5p/sq+WRYdE
	kO7bHfQyv0eJ55S3rvZQTW5Q5F4nz5JiECbUkm8mHDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QFrd8/
	Cm4EwX8Y7araktIbSjoBlmXGo8qHRYothcUyU=; b=SwWlAa8LMivcmJGLD1cwjv
	suhdxuYwhuXHJlAy1GSEdpl1uXcy4ShehvrNaPVmfwwEmewzJmZWVIw+e4Mumxva
	3B8pGLaRYornUZzuT51RlsLaG2QHVBfLouoON2+znNxLS3dK4KJKa5GyAzvSeLJX
	FZg9lB2KtXRgCy3kICY0BHybOpNP8+tXo80cAskFthG04zUPt44bZ6fjkT2PyAQA
	Hme38ep5tBjjhquaq6JIqQu/OYqPE7ArIPBKeRYG0b17i/X2F53dLS8U7JDBwHkJ
	S1rf7ZEUUua5CNXojfWMZ3+cSL3GAtWu6xb50jFee2wY5eBGokkerk79hA6U9dNg
	==
X-ME-Sender: <xms:3rD-X-jOkVkIr1Z8xi4W4VDOddYVNHMN9rqHZGADCmz0RAmWFi4S5A>
    <xme:3rD-X_Ckz1goHfYtkRKTtEtBY7ZDfFUEae5dk5GCG_l0pF3E_vEK0M-23AAC45y3n
    oqyV-P_FlyDyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
    ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhm
X-ME-Proxy: <xmx:3rD-X2EyOYM4ypF6A0E-P-iczXKe12dJlYUZGkcbngr0p1ZQXWD-Qw>
    <xmx:3rD-X3QF7RaRXjw_e71eNiLII30xN58X-s-jW-ZYsNtwkUPrqt0q4A>
    <xmx:3rD-X7xOBZEbS2vFukfL6_cx9sdEUVuQRMqRjbWxEJG-2f29EuL_eA>
    <xmx:3rD-X2q8w4IWXomhGhLsnJUarPV878703cMpdfSWn9OIosD0ZwvFwA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
	by mail.messagingengine.com (Postfix) with ESMTPA id 356DD1080059;
	Wed, 13 Jan 2021 03:35:42 -0500 (EST)
Date: Wed, 13 Jan 2021 09:35:40 +0100
From: Greg KH <greg@kroah.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 6/6] libnvdimm/namespace: Fix visibility of namespace
 resource attribute
Message-ID: <X/6w3MKvKChR3cn4@kroah.com>
References: <161052331545.1805594.2356512831689786960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161052334995.1805594.12054873528154362921.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161052334995.1805594.12054873528154362921.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: CYZJ4B3SVA4LUBP5DBSMI66AJNR6Q4S6
X-Message-ID-Hash: CYZJ4B3SVA4LUBP5DBSMI66AJNR6Q4S6
X-MailFrom: greg@kroah.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, stable@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CYZJ4B3SVA4LUBP5DBSMI66AJNR6Q4S6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 12, 2021 at 11:35:50PM -0800, Dan Williams wrote:
> Legacy pmem namespaces lost support for the "resource" attribute when
> the code was cleaned up to put the permission visibility in the
> declaration. Restore this by listing 'resource' in the default
> attributes.
> 
> A new ndctl regression test for pfn_to_online_page() corner cases builds
> on this fix.
> 
> Fixes: bfd2e9140656 ("libnvdimm: Simplify root read-only definition for the 'resource' attribute")
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/namespace_devs.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
