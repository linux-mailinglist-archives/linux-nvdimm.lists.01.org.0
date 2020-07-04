Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F221436D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 Jul 2020 05:45:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC46C114EB6C6;
	Fri,  3 Jul 2020 20:45:44 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1CD3114EB6C2
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jul 2020 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=azvx83xWOF3kgC3cI2uK3xiDXooMGlcuFMVIJEx/1Lo=; b=Tcd3aFlNwzruQOdCr9D4GGOjOy
	EZcH45N2UM7LMqVLlNGSFqIVhxzPnuiVmKv0rMC2i+u2lhJrHpqjBbed530iF+80r6C57nR2I5gLr
	KIlYsBVb1icYkVQkEPZuCD/+qq3qapwnTiudopeWjl3k0J3mTVtfzpbMYPZzjfr9ES5I5bk6BLzPx
	rkoT+VM19+vYj5fTo9n1ocTlqn8AWkHYDeC1YH2nmyvZsfvEmF3xbYTPuTtXrFP0UxdcJu+9U6PLg
	MKWX0pKCkQz+k6+VFgiRfI9YS6noGKAmiqyCM+ygBUCXIATIGobU4EyGmOrGS/gICWnwrgW1HxKcu
	jTKSiCgQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrZ7P-0001Xb-73; Sat, 04 Jul 2020 03:45:36 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] Documentation/driver-api: firmware/request_firmware: drop doubled word
Date: Fri,  3 Jul 2020 20:44:50 -0700
Message-Id: <20200704034502.17199-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: TQ36PX4ZDSPJLYEUPJAPA3CYWGKUOJ2L
X-Message-ID-Hash: TQ36PX4ZDSPJLYEUPJAPA3CYWGKUOJ2L
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TQ36PX4ZDSPJLYEUPJAPA3CYWGKUOJ2L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the doubled word "call".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/request_firmware.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/request_firmware.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/request_firmware.rst
@@ -76,5 +76,5 @@ firmware. For example if you used reques
 the driver has the firmware image accessible in fw_entry->{data,size}.
 If something went wrong request_firmware() returns non-zero and fw_entry
 is set to NULL. Once your driver is done with processing the firmware it
-can call call release_firmware(fw_entry) to release the firmware image
+can call release_firmware(fw_entry) to release the firmware image
 and any related resource.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
