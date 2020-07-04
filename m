Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF6214386
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:45:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FF13114EFCF4;
	Fri,  3 Jul 2020 20:45:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D10B2114EFCF4
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rIE2HiSejbxqQ8BF9s2XxhnmsjYecXnzhkq4IxXMVOY=; b=pyKk1gSSLI0/FWyvONIFuBgUsH
	m+eAPUwqj653x5k8g1mS6agzbN27hETdg3MeXx2pzq5mtFOV1+9R1RYQ6Lu/INZw/8FQPRmT+/Ath
	BfLOIp6Y4DkXXTpHEWzMtfSnIa1p9xwb/0NN8CjviT9URBWx9J1n6l8phiwv/IZn7Yd7KJcAPk3LN
	uq0jPnrM/ICLBiUMxzwOznk+EXA3kICZqhCRY2ifqd6Jfm4zqhyjI9t7Ak0QOS1VlBgPDvidof/U/
	6CzcnzRx6fg21g3HMxwVUg90l/zmtyMOQplMv+f7N412o8WCEzSnRpXRvuFa4Pg1b01cx5cc2k6KC
	Qbild4Lg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7a-0001Xb-8O; Sat, 04 Jul 2020 03:45:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] Documentation/driver-api: iio/buffers: drop doubled word
Date: Fri,  3 Jul 2020 20:44:52 -0700
Message-Id: <20200704034502.17199-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: DKDFAZBAUGPEOKETES3HYG3SXUZWMKN5
X-Message-ID-Hash: DKDFAZBAUGPEOKETES3HYG3SXUZWMKN5
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKDFAZBAUGPEOKETES3HYG3SXUZWMKN5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "struct".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 Documentation/driver-api/iio/buffers.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/iio/buffers.rst
+++ linux-next-20200701/Documentation/driver-api/iio/buffers.rst
@@ -88,7 +88,7 @@ fields in iio_chan_spec definition::
 The driver implementing the accelerometer described above will have the
 following channel definition::
 
-   struct struct iio_chan_spec accel_channels[] = {
+   struct iio_chan_spec accel_channels[] = {
            {
                    .type = IIO_ACCEL,
 		   .modified = 1,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
