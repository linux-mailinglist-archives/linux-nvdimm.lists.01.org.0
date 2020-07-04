Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC121438C
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25C83114EFCF6;
	Fri,  3 Jul 2020 20:46:03 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FD92114EFCF5
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=bouRfF6/sBtVI5L0f+o3qswHe079xcdi/E30/5xT1pk=; b=XHH2ztO1svnSw116jt9ZOBVu3g
	8ihrZ06RGuZUU1+9Ss+0SpdMxY6eZWCP869qGbzh3x9eqrA9Z6aqBlHoR50fbPXnCEivOfwo8FUk6
	6kAtKLIkrUVEnykvBJuua7L1A2rcrODPsN/HKNaCEzh3NYGZt8SOIbpaO0Haw1kguGAAQH00j34Sw
	GCG4LOBCB9ZtdRtiXiU1Tc/mFplI/c+3QFLjD7Tf9hHGQ8ghInj6T+4uIBc3aC0XhuNJEZtHySl9p
	6VpU5KJDpV4e7FJeQFWpONp3eDL7nsJ53o5irIw8xoqHLKskDW+wzOvhUHzB5HHHh8rBtU0zBrBnm
	qJSKMooA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7f-0001Xb-Kv; Sat, 04 Jul 2020 03:45:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] Documentation/driver-api: media/cec-core: drop doubled word
Date: Fri,  3 Jul 2020 20:44:53 -0700
Message-Id: <20200704034502.17199-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: NXDK5DQ7GV3SPAPC5MBREDKK32ZA343V
X-Message-ID-Hash: NXDK5DQ7GV3SPAPC5MBREDKK32ZA343V
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXDK5DQ7GV3SPAPC5MBREDKK32ZA343V/>
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
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/cec-core.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/cec-core.rst
+++ linux-next-20200701/Documentation/driver-api/media/cec-core.rst
@@ -341,7 +341,7 @@ So this must work:
 	$ cat einj.txt >error-inj
 
 The first callback is called when this file is read and it should show the
-the current error injection state:
+current error injection state:
 
 .. c:function::
 	int (*error_inj_show)(struct cec_adapter *adap, struct seq_file *sf);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
