Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD702B482
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 May 2019 14:12:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5A8121276BBF;
	Mon, 27 May 2019 05:12:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=64.147.123.21; helo=wout5-smtp.messagingengine.com;
 envelope-from=greg@kroah.com; receiver=linux-nvdimm@lists.01.org 
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 88CD72194EB7A
 for <linux-nvdimm@lists.01.org>; Mon, 27 May 2019 05:12:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 73DC44B6;
 Mon, 27 May 2019 08:12:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 27 May 2019 08:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=igi5jOHudzHsQVB/gHrGY+DJZkT
 HuwbK/g/xsUuW8c4=; b=qn5vE6Zh3xBrGS8gJeCef7vw05IjMyT9QhOsIeyBhDZ
 qCbSGZeN0ZN8vngM/lla4ETs8Lp2Va24bCroP0Y8brZUY4d+0LBR/MU6B4KSKIz+
 Sr7+Ls+Rm5D+R2asW3GWC4Uh783OHiTjcTcf2fwId8o0uXOGhQSqEN9EF+0a71EC
 RoOiWhLSyyRjW7B4q1JeY4YinIPmm17K6iNnmYwr4xBgo3GcHzBTLU3+FgiDri3c
 TCqSAvBTL86Q7u6kcxaclQiVW1mQXXB4sqehGNBNyzQE+1MFP4S03gwfP113s8f1
 37h5dt8Zuj6Hjd82xlxXnto4keSjjpw10X4IyZZtROg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=igi5jO
 HudzHsQVB/gHrGY+DJZkTHuwbK/g/xsUuW8c4=; b=NyKw+nuprS/y+nR+K7OUIu
 U0Gtd2afSJPYbNPIe+ZERXy/sgX8zNYS+bkS2b6vGTXOAGnuzb04YDE2O3tZyFH3
 T7EnEjZHvPA+4fi3PmyNO9voRbwMIH73z+A756gaJ96grfhHWk40tr7DDQCxTfEj
 gbvguG502pjPC4nIzpYwW/zFIuIkycaJp0ck2YzJoUaRg6VB97wY2XFiFnRITaLo
 bGl1f0kkV6j6RqcdcHy9QsVMCNjWhrVC3E0WYyA3z1kkwMVCy/SjZIAVbwBdlVMY
 5EaR3ZhpRc+mWx7uh8F3M97HBLtOzAbFtUBYKxsl7DrO0gPdIZK+a2fVR4NT5PNQ
 ==
X-ME-Sender: <xms:DtTrXI7yrP9u7SMKxrA2V8vQaBC9Gk1IHJ2x2Ik5ujwbJ5oT0R5q4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvvddghedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
 ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
 dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
 vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DtTrXPLtU7TrWPfT_SRie-hHJ4MChgB7YIYOYmsgriObDtgnve9ioA>
 <xmx:DtTrXKEL6IrIfht1sFEDebRNp9alK-SsqRBpfb9SMl19_Y-kErA3yA>
 <xmx:DtTrXM21cre86uyxsMi496seUvt0az7z30O6BpvqzEz5ijoWryoWEQ>
 <xmx:ENTrXFtHSp8O-4GiV18Qde_EWszXUc7dcZnUb5KJ8-tMIKnKUZyvNw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 by mail.messagingengine.com (Postfix) with ESMTPA id 758DE80059;
 Mon, 27 May 2019 08:11:58 -0400 (EDT)
Date: Mon, 27 May 2019 14:11:56 +0200
From: Greg KH <greg@kroah.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [for-4.14.y PATCH] libnvdimm/namespace: Fix label tracking error
Message-ID: <20190527121156.GB607@kroah.com>
References: <155882542900.2471091.11258089584930875450.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155882542900.2471091.11258089584930875450.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org, stable@vger.kernel.org,
 Erwin Tsaur <erwin.tsaur@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sat, May 25, 2019 at 04:03:49PM -0700, Dan Williams wrote:
> commit c4703ce11c23423d4b46e3d59aef7979814fd608 upstream.
> 

Thanks for both of these, now queued up.

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
