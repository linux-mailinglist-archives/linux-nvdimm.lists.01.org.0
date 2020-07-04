Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9821438D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38BEC114EFCFC;
	Fri,  3 Jul 2020 20:46:07 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06206114EFCFB
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=r1aEn+t8j2wA7e0I1OW+BPLKTMMoNGZMWbd9fmMpZqM=; b=Bf7UEtxchI7uzsegrZdvsGmrc9
	o54oS1+GEx9s96zmUe3AL/sWiWdhOKDloa22aQ4S0qWGNBFE7Mej7wXlYw7vRPJIPsytdGY2hcbCo
	0a3Gy/WZ5D8lUTsbdZStrXsqiPWU2PTBQizk7kHRBiDkXdc0Ozj/vm17vf3QLzZu+Jgc2QvWqO/ir
	DxrFku1YVsvED4x7TNCGGospZLqCSMDJbNczoqYUouxdDxaD2+eodhQu8Z3c+lbvweNYKbsR3bT0w
	JASGoMQH95cHVt5eQsEmBjz+tOpCqwL9JMwgvL/B6V3gJyZsqzOQvUTLWa7ocEF0PUZsMrt9rNIPd
	7ntghEEQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7l-0001Xb-2Y; Sat, 04 Jul 2020 03:45:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] Documentation/driver-api: media/dtv-frontend: drop doubled word
Date: Fri,  3 Jul 2020 20:44:54 -0700
Message-Id: <20200704034502.17199-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: KG4U4JR7ETIE7O4LDR7CUGLIZAQHGXAG
X-Message-ID-Hash: KG4U4JR7ETIE7O4LDR7CUGLIZAQHGXAG
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KG4U4JR7ETIE7O4LDR7CUGLIZAQHGXAG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "errors".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/dtv-frontend.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/dtv-frontend.rst
+++ linux-next-20200701/Documentation/driver-api/media/dtv-frontend.rst
@@ -244,7 +244,7 @@ Carrier Signal to Noise ratio (:ref:`DTV
     Having it available after inner FEC is more common.
 
 Bit counts post-FEC (:ref:`DTV-STAT-POST-ERROR-BIT-COUNT` and :ref:`DTV-STAT-POST-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors after
+  - Those counters measure the number of bits and bit errors after
     the forward error correction (FEC) on the inner coding block
     (after Viterbi, LDPC or other inner code).
 
@@ -253,7 +253,7 @@ Bit counts post-FEC (:ref:`DTV-STAT-POST
     see :c:type:`fe_status`).
 
 Bit counts pre-FEC (:ref:`DTV-STAT-PRE-ERROR-BIT-COUNT` and :ref:`DTV-STAT-PRE-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors before
+  - Those counters measure the number of bits and bit errors before
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
@@ -263,7 +263,7 @@ Bit counts pre-FEC (:ref:`DTV-STAT-PRE-E
     after ``FE_HAS_VITERBI``, see :c:type:`fe_status`).
 
 Block counts (:ref:`DTV-STAT-ERROR-BLOCK-COUNT` and :ref:`DTV-STAT-TOTAL-BLOCK-COUNT`)
-  - Those counters measure the number of blocks and block errors errors after
+  - Those counters measure the number of blocks and block errors after
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
