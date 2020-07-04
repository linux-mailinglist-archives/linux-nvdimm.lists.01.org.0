Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE9214391
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6271211504B0D;
	Fri,  3 Jul 2020 20:46:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBF9811504B0C
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=/CGMiPAz1EqlmAsuqBAdyktP4CyuJQt8tuDtDyXNR6Y=; b=Ba1zfCJUJkqxlIdW9NwaYHEcyF
	MUxE9LcPWFaVt1IkC8D8F+X1OIQXwvnN6awtL4ky5UGvax4zDdWGiHgT841yxr3dqNim6QFPwn8vN
	GMhffP4nmlRfdqHpuugtZuepsX43cLgQrRmyz601mCHSYu7TArLaqoNB+9GWPt/KoJ6o1HlnGFW6+
	ffXycZpHadTyGoB6jodB59F5Uky/eEp/HhIxxp8ecbrze2ib5Xij1IrEw8ppucqYNnTB/F67CDIW5
	1gP2g017fPDIvX4CaiYCMfiPQk2Gzae5rRr4uN2SrC8CVH/dLvYWnF7La5HikU4HIXPq6URlT+LRQ
	f1tiDR5Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7v-0001Xb-Dv; Sat, 04 Jul 2020 03:46:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] Documentation/driver-api: driver-model/platform: drop doubled word
Date: Fri,  3 Jul 2020 20:44:56 -0700
Message-Id: <20200704034502.17199-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: L6TT7B24IUCCRKRRMJYQ6ZSQT2BH3YG7
X-Message-ID-Hash: L6TT7B24IUCCRKRRMJYQ6ZSQT2BH3YG7
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L6TT7B24IUCCRKRRMJYQ6ZSQT2BH3YG7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/driver-model/platform.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/driver-model/platform.rst
+++ linux-next-20200701/Documentation/driver-api/driver-model/platform.rst
@@ -108,7 +108,7 @@ field to hold additional information.
 
 Embedded systems frequently need one or more clocks for platform devices,
 which are normally kept off until they're actively needed (to save power).
-System setup also associates those clocks with the device, so that that
+System setup also associates those clocks with the device, so that
 calls to clk_get(&pdev->dev, clock_name) return them as needed.
 
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
