Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9653A21438F
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4EBF611504B0B;
	Fri,  3 Jul 2020 20:46:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA5C1114EFCFD
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1H7C7zEDvKakDL7QnZ6YmqSUL7TPTa6iZ3cT+yZu6A8=; b=GtpfoO3Lq6+v0NtA8liEWd9qgV
	VsngCQVZFPAM3xaUwaEe9+2Ur58T6S2ns5C4EWZEG5ppc3SFASQgYLAQHbmCiEsutt2InWimt2bNl
	p3nAqrXve5Cjf8gA3+6BRISnsgnAcz6yH1iS5S5MnRUu7+VBdsDz9hn2zezk2fz8N3d/d6sP5swTO
	Lvc7GiJhA37+nbwPXGGHwJvWz/E9+/rF2ilC3mucKV0wcutPnCzC9t0bslUPnIeLvAbcKmwleY0lR
	c+bb8P8COrkZC+T2VVxTCCpMup16boKrHqFN6EZ5THEJ+CVj3wNg6NEtNywP5Mtuz8pVMpJAKxGOR
	KRKn35gQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7q-0001Xb-Fo; Sat, 04 Jul 2020 03:46:03 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] Documentation/driver-api: media/v4l2-dev: drop doubled word
Date: Fri,  3 Jul 2020 20:44:55 -0700
Message-Id: <20200704034502.17199-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: 5KOD3GK4UQSFMG3WC2S7EYK4VXF4RCOE
X-Message-ID-Hash: 5KOD3GK4UQSFMG3WC2S7EYK4VXF4RCOE
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5KOD3GK4UQSFMG3WC2S7EYK4VXF4RCOE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "device".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/v4l2-dev.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/v4l2-dev.rst
+++ linux-next-20200701/Documentation/driver-api/media/v4l2-dev.rst
@@ -212,7 +212,7 @@ types exist:
 ========================== ====================	 ==============================
 
 The last argument gives you a certain amount of control over the device
-device node number used (i.e. the X in ``videoX``). Normally you will pass -1
+node number used (i.e. the X in ``videoX``). Normally you will pass -1
 to let the v4l2 framework pick the first free number. But sometimes users
 want to select a specific node number. It is common that drivers allow
 the user to select a specific device node number through a driver module
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
