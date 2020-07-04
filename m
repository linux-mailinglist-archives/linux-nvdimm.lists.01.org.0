Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FE21437E
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:45:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E576C114EFCF3;
	Fri,  3 Jul 2020 20:45:51 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E1657114EFCF2
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Br7ciRkToTzu9/SujjXjuCMCVdJ9xhWa8uu/HHCT9l8=; b=EgemK5cZlfAMhE9a1wh8G8Hp82
	J7kTS++6PFbZ51Aj2m/BKisHz8t5K24o92ZXLKqzbL0PocTNNSM14IKRg8ZEaTSRuOpLNAmsk/zie
	CR7F/mFuv8GpJWPmmuGzrZYtzzgd6ohotx8F3rzbGEFIcnwenK8mKMLEcv8f8KPAhi6mxTnB+jk/6
	lzY4YxB/cKEwv6/6ZCDoPugagg/o04mcXzjAQN/uX05nAacqzAqMl0gZCqVHXsqcuZi12MWAXqCEU
	Ro6Mi6wRV05x6k88IQzMDioCUWitzpInVbMrFnDZQ3UE2Etn3g0rBSvnXrPOsnPCdL0K0S9yGm/18
	KYUv61VA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7U-0001Xb-Lc; Sat, 04 Jul 2020 03:45:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] Documentation/driver-api: generic-counter: drop doubled word
Date: Fri,  3 Jul 2020 20:44:51 -0700
Message-Id: <20200704034502.17199-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: WXXCED6PBXJNGRFUXBDXIDFIL4QCKNQC
X-Message-ID-Hash: WXXCED6PBXJNGRFUXBDXIDFIL4QCKNQC
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WXXCED6PBXJNGRFUXBDXIDFIL4QCKNQC/>
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
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 Documentation/driver-api/generic-counter.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/generic-counter.rst
+++ linux-next-20200701/Documentation/driver-api/generic-counter.rst
@@ -262,7 +262,7 @@ the system.
 Counter Counts may be allocated via counter_count structures, and
 respective Counter Signal associations (Synapses) made via
 counter_synapse structures. Associated counter_synapse structures are
-stored as an array and set to the the synapses array member of the
+stored as an array and set to the synapses array member of the
 respective counter_count structure. These counter_count structures are
 set to the counts array member of an allocated counter_device structure
 before the Counter is registered to the system.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
