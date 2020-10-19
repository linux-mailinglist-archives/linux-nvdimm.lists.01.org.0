Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B047F292E12
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 21:04:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C09215EC4FD4;
	Mon, 19 Oct 2020 12:04:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=trix@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF6D815EADDD4
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1603134277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=BNebSzKa24Vd+I/nEx9yjLMrhbD2Rzt4FX+UGJijfis=;
	b=C8AuI0DMhBfvOg0xW6fQP7XAuVbFV8lJe15JRPSsgYhhrL7e68ihVDvPX8xNr50pebkAox
	o6Yx+PFMFOkyjNvlD999sO5CVtwdirL+Ben01YCIxLemBPocqmr/SdUH7Aw9qnTOhAF1O3
	MQkfSE9lzogsk79l1haXNQozeX2GVK4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-XI9CX31gN2-WbguqP-Olxw-1; Mon, 19 Oct 2020 15:04:35 -0400
X-MC-Unique: XI9CX31gN2-WbguqP-Olxw-1
Received: by mail-qk1-f198.google.com with SMTP id d124so411563qke.4
        for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 12:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BNebSzKa24Vd+I/nEx9yjLMrhbD2Rzt4FX+UGJijfis=;
        b=gD58Gyzi6qHNah0wKjvPA3wpcveijplLYBy2FUipv8w0cKYLjQedVe472b2/sfZcc6
         ZGNyeXsgDgSfVU6qMJu8awrRj8yEAlZYFIozx+4eLcT1em+CuF02xWv0YLm6BxgYCrkb
         hAbBLuzUgE/x5nIXST9edlzrorBTMAVxxCvMtyaZB5poFf0zXLSxWF3v1FRG14O1yw1h
         GeHljE54EWagQfd0Zut+QedyY8GprhktL3eynthCackq7O//PaqOU/TiyKeLd/3q//0Q
         LPSVqTFDi3uTql0ZXbPynu8VUJ5FWXX0l5WH2/RwMHrqyyE5NSRro+xWj8+yTmKeHxIo
         ojug==
X-Gm-Message-State: AOAM532Bv+vguiILG6s5QBpbjfci8S/bmPnc/jDlp47T0UO5+RWlEm8x
	ju95xJheN/kvasm8cyUgbMp+5bAMRsTAhEmPqCr8pBckQAOtULLUEt+4VU/CWjriG7G9FufK3PJ
	0VxKyYpJa77mfWy1o1emn
X-Received: by 2002:a05:620a:110f:: with SMTP id o15mr1089476qkk.86.1603134274766;
        Mon, 19 Oct 2020 12:04:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsvFnGYA6/V12A5HT/qy7T29vsPsa7OWyG0NuExIzbt5nxxVicTk6e6xyaEkXkWMmPQRYaqQ==
X-Received: by 2002:a05:620a:110f:: with SMTP id o15mr1089436qkk.86.1603134274362;
        Mon, 19 Oct 2020 12:04:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 68sm390030qkg.108.2020.10.19.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:04:33 -0700 (PDT)
From: trix@redhat.com
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH] nvdimm: remove unneeded break
Date: Mon, 19 Oct 2020 12:04:29 -0700
Message-Id: <20201019190429.8165-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: AXM42F3FUFVT5KYVRVIYEGUYCHD2VHVB
X-Message-ID-Hash: AXM42F3FUFVT5KYVRVIYEGUYCHD2VHVB
X-MailFrom: trix@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AXM42F3FUFVT5KYVRVIYEGUYCHD2VHVB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvdimm/claim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 5a7c80053c62..2f250874b1a4 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -202,7 +202,6 @@ ssize_t nd_namespace_store(struct device *dev,
 	default:
 		len = -EBUSY;
 		goto out_attach;
-		break;
 	}
 
 	if (__nvdimm_namespace_capacity(ndns) < SZ_16M) {
-- 
2.18.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
