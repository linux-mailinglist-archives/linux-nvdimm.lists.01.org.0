Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04C3158EA
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 22:51:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDA91100EAAE7;
	Tue,  9 Feb 2021 13:51:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09C38100EAAE2
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612907478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=flabV5XKoP8ykfYU3zWK4A4LzJ0ayRMZxLxftgoYk/M=;
	b=Fg90nB04NXLhIQ7OAolVi1YWliD+DPTirns3RqFNdOfmMSCXC+7Q2ByC+87NKQnhfFjylm
	uNbjDVHJPf99tiNUOCzP7A4Xq6Y/Dmeq9eugkH/NYIljUKT2efM4D7DkfE8BRRJtEg4QK/
	He5RAjxN1zRux8VTi/lbm6eITqfXe6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-RpsZ37XXMPibdacimoWBQw-1; Tue, 09 Feb 2021 16:51:16 -0500
X-MC-Unique: RpsZ37XXMPibdacimoWBQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78AC51005501;
	Tue,  9 Feb 2021 21:51:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A8919C78;
	Tue,  9 Feb 2021 21:51:14 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl patch] zero_info_block: skip seed devices
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 09 Feb 2021 16:51:53 -0500
Message-ID: <x49r1lohpty.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 627JXSRHOKD5PKLK6TAX2ENTMXWVVAWB
X-Message-ID-Hash: 627JXSRHOKD5PKLK6TAX2ENTMXWVVAWB
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/627JXSRHOKD5PKLK6TAX2ENTMXWVVAWB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, ndctl destroy-namespace -f all will output errors of the
form:

  Error: destroy namespace: namespace0.0 failed to enable for zeroing, continuing

for any zero-sized namespace.  That particular namespace looks like this:

  {
    "dev":"namespace0.0",
    "mode":"raw",
    "size":0,
    "uuid":"00000000-0000-0000-0000-000000000000",
    "sector_size":512,
    "state":"disabled"
  }

This patch skips over namespaces with size=0 when zeroing out info
blocks.

Fixes: 46654c2d60b70 ("ndctl/namespace: Always zero info-blocks")
Reported-by: Zhang Yi <yizhan@redhat.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0c8df9f..de1e08f 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1052,6 +1052,9 @@ static int zero_info_block(struct ndctl_namespace *ndns)
 	void *buf = NULL, *read_buf = NULL;
 	char path[50];
 
+	if (ndctl_namespace_get_size(ndns) == 0)
+		return 1;
+
 	ndctl_namespace_set_raw_mode(ndns, 1);
 	rc = ndctl_namespace_enable(ndns);
 	if (rc < 0) {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
