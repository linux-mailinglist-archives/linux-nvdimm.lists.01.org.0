Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BC21435E
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:45:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 438321145BDE5;
	Fri,  3 Jul 2020 20:45:22 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DF46114493D6
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cfuMtEE7aLNsTWKrfmSLBZiVov+0MQq3QCFMWag3GnA=; b=poKqFqzyZYsZV/s9ZcbOe5p0/E
	YQRhrHdTpIgWrm9jdD+AcSJi8nWKFsktCg96n2jVBrA5NPjK7nFn+3cPxt9gI89iFbLBqSOjJ9J44
	BnTgPWt2Vxg+A1LTYLRK5dCMwJxvCyb1Nyczq6lScDORAnhB6pLkQpvP+8JXd5j6NWs1kypdPYPuO
	beeIefvHuzMOndhAaROWvf3UVxqPWkvP2U2DOoeRNL7Jhcd8T0wTqlC1+WpRc1osfE0grZpc9ODKY
	kT52GGrivXHQK/CiWI0eIILr9iqcLk2pMwJOtem2DtcAArS+ddJC1p+dsxkMdgWY6guRTnxzkYAvi
	OSAgyBMg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ73-0001Xb-CK; Sat, 04 Jul 2020 03:45:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] Documentation/driver-api: dmaengine/provider: drop doubled word
Date: Fri,  3 Jul 2020 20:44:46 -0700
Message-Id: <20200704034502.17199-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: Q6IPRGV65CGB4Z3O5FH2MUGT7GJOFCEX
X-Message-ID-Hash: Q6IPRGV65CGB4Z3O5FH2MUGT7GJOFCEX
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q6IPRGV65CGB4Z3O5FH2MUGT7GJOFCEX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "has".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 Documentation/driver-api/dmaengine/provider.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/dmaengine/provider.rst
+++ linux-next-20200701/Documentation/driver-api/dmaengine/provider.rst
@@ -507,7 +507,7 @@ dma_cookie_t
 DMA_CTRL_ACK
 
 - If clear, the descriptor cannot be reused by provider until the
-  client acknowledges receipt, i.e. has has a chance to establish any
+  client acknowledges receipt, i.e. has a chance to establish any
   dependency chains
 
 - This can be acked by invoking async_tx_ack()
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
