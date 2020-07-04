Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0EB2143A2
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0887911508C21;
	Fri,  3 Jul 2020 20:46:48 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7F5B11508C21
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QMUoZdBV4wse9lG8bnGaYE8IXC2pAaw0z4G8gYRTTas=; b=twiINFJbNLpQTiX+61YMRDPQ7P
	Ih4JzjvMGpS/7co6aGhmYZ1snZh0VmzNAo8ri2YrNhS8zoVk1giZdDlpOU5Rn1V7vSb8wxLsEkds3
	LW6DwFhnksRRYmEUCnDnC0kgfGsmeNcGUGkg7OJB1cXe5h+q6e8GWOj2KlMypltNJYGARtLBoKsuu
	qIwB5yLKA6jD9zzxRl5301Z8EldaWs3/x5EaQq5ODvudFnfk5lGrUS+jcb6iVGixaS1WuEE5rKlTk
	gYwayt4ffNIsoPjU91v/FUf2M4DkReF69U2OOA2ND3wXinIvmvqPOAj9W12NAZbh2q054EbNmBE0X
	WtMgmQ1w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ8R-0001Xb-Dk; Sat, 04 Jul 2020 03:46:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] Documentation/driver-api: xillybus: drop doubled word
Date: Fri,  3 Jul 2020 20:45:02 -0700
Message-Id: <20200704034502.17199-18-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: Q5HVEGWMI3XKJCAH6AF3LTPZ66FJJOEA
X-Message-ID-Hash: Q5HVEGWMI3XKJCAH6AF3LTPZ66FJJOEA
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q5HVEGWMI3XKJCAH6AF3LTPZ66FJJOEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Eli Billauer <eli.billauer@gmail.com>
---
 Documentation/driver-api/xillybus.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/xillybus.rst
+++ linux-next-20200701/Documentation/driver-api/xillybus.rst
@@ -273,7 +273,7 @@ buffer is full, the FPGA informs the hos
 XILLYMSG_OPCODE_RELEASEBUF message channel 0 and sending an interrupt if
 necessary). The host responds by making the data available for reading through
 the character device. When all data has been read, the host writes on the
-the FPGA's buffer control register, allowing the buffer's overwriting. Flow
+FPGA's buffer control register, allowing the buffer's overwriting. Flow
 control mechanisms exist on both sides to prevent underflows and overflows.
 
 This is not good enough for creating a TCP/IP-like stream: If the data flow
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
