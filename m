Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7027214394
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:46:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DE0511504B11;
	Fri,  3 Jul 2020 20:46:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D69F011504B11
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6EonKUvskMRhUPMN+Ghhg/8Utfl6KLu/Eki0DelHmZo=; b=NLw/zpYV5if9WIc2kLc0j4W712
	8Jg1xRzVSe4FU9+/MJd+DzxGrj5zuTTH3UACVYBfUTc3LgNKZky1fuNTrWLrYl02NRENH/wMEww9R
	345jy/WUIadRLg+uwmwNQJAk6BRytXY6LUAROs54TzWlgJaLdwFgY566WYCzDVtgID0NtsB1x3u24
	rDuBvadU7LyywbNwvpPHxr3SrEqAFa+x5FyI/MuwmhpK87Oy65ypBopGLVaf9+Z1KIa0+Ux2UQBFt
	YhwONxgqkorRSqFpjoVV/GekOJgIMYbEideBvS4if5O7t2LHJ5yoPM750Ucw56UPYzcQRZLaN3Fjg
	ax+0AsuQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ80-0001Xb-SC; Sat, 04 Jul 2020 03:46:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] Documentation/driver-api: ntb: drop doubled word
Date: Fri,  3 Jul 2020 20:44:57 -0700
Message-Id: <20200704034502.17199-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: WVWBAYALQW6FYUS2P33YNWCZOACXQRNS
X-Message-ID-Hash: WVWBAYALQW6FYUS2P33YNWCZOACXQRNS
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVWBAYALQW6FYUS2P33YNWCZOACXQRNS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "with".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
---
 Documentation/driver-api/ntb.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/ntb.rst
+++ linux-next-20200701/Documentation/driver-api/ntb.rst
@@ -9,7 +9,7 @@ registers and memory translation windows
 scratchpad and message registers. Scratchpad registers are read-and-writable
 registers that are accessible from either side of the device, so that peers can
 exchange a small amount of information at a fixed address. Message registers can
-be utilized for the same purpose. Additionally they are provided with with
+be utilized for the same purpose. Additionally they are provided with
 special status bits to make sure the information isn't rewritten by another
 peer. Doorbell registers provide a way for peers to send interrupt events.
 Memory windows allow translated read and write access to the peer memory.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
