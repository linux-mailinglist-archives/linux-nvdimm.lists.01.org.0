Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C02214395
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A093A11504EA1;
	Fri,  3 Jul 2020 20:46:27 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E2A9114EB6C5
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=l2dNp9CDCJWinvc4lxu8WrMSWxEENUQ4lh7tctfmeCY=; b=o2zYcSx9s6tpm7oS6TkJxGFzET
	04GnFb6LY6i2JGbzGnYpv5GmmiWMlIAYslf9NEz4RLDjcxPhTmfE9OMuRd5/2OC/GPr2rAqYPo8W8
	qSGhJPbgp5fTLRoz+sn/a8VJGfB0SNZipL70akZNifLrdIdBeWnN8rdpm8pNQ3HA+vpMB2GOyVUxI
	Y4szHID82GDhxLVjUJZ9uaHzSr4XoD6clWAtjhxb2IyAyDhQ6aHKdCeIIqauIKdvu1+/yKzcQc+Wl
	O7iD2RUa+l28E2AyoxXLI/7M22gBBZDsAJ4ASC/BjtzT15nB/F4BrOpdVTZE3ln5bkfGwS9uMGKOE
	y4jxsvkg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ85-0001Xb-S7; Sat, 04 Jul 2020 03:46:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] Documentation/driver-api: nvdimm: drop doubled word
Date: Fri,  3 Jul 2020 20:44:58 -0700
Message-Id: <20200704034502.17199-14-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: K5HXKMEEF7QSD4LRH26RS7D7EAQQZSGT
X-Message-ID-Hash: K5HXKMEEF7QSD4LRH26RS7D7EAQQZSGT
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K5HXKMEEF7QSD4LRH26RS7D7EAQQZSGT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
---
 Documentation/driver-api/nvdimm/nvdimm.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/nvdimm/nvdimm.rst
+++ linux-next-20200701/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -73,7 +73,7 @@ DAX:
   process address space.
 
 DSM:
-  Device Specific Method: ACPI method to to control specific
+  Device Specific Method: ACPI method to control specific
   device - in this case the firmware.
 
 DCR:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
