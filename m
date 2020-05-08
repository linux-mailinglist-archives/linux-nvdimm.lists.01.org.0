Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D991CA654
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 10:42:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C338611842515;
	Fri,  8 May 2020 01:40:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4DA111842512
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1588927363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMwBMWVz7Kvu4wPaq4Zrf2HTRO5lLJ1XAoScD/RMxlg=;
	b=MfS0ALA0IUQSDvZwVHpeWvS9SAw1DpdgHcy5xdvgCVTVDeGtoruiyZUhZiHcOKXqkhPvL6
	IJmCHEdqyV+xFh6Lon7SCUqsSP55GP4olPewJUjzIP1ZIA4zIDY9AmXzNtINcu3fL/7HEc
	CH/AN2xpg6oZCAU7SVZYJ/J8th6rfC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-mShYxTwKMfS5m95lvKsheg-1; Fri, 08 May 2020 04:42:40 -0400
X-MC-Unique: mShYxTwKMfS5m95lvKsheg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03028107ACCA;
	Fri,  8 May 2020 08:42:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-181.ams2.redhat.com [10.36.113.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED1635C1B0;
	Fri,  8 May 2020 08:42:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] kexec_file: Don't place kexec images on IORESOURCE_MEM_DRIVER_MANAGED
Date: Fri,  8 May 2020 10:42:16 +0200
Message-Id: <20200508084217.9160-4-david@redhat.com>
In-Reply-To: <20200508084217.9160-1-david@redhat.com>
References: <20200508084217.9160-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: OZXPKJOPTU7AZGTH45Y24WXD5NHZ5BMK
X-Message-ID-Hash: OZXPKJOPTU7AZGTH45Y24WXD5NHZ5BMK
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OZXPKJOPTU7AZGTH45Y24WXD5NHZ5BMK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Memory flagged with IORESOURCE_MEM_DRIVER_MANAGED is special - it won't be
part of the initial memmap of the kexec kernel and not all memory might be
accessible. Don't place any kexec images onto it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/kexec_file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index faa74d5f6941..bb05fd52de85 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -540,6 +540,11 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
 	unsigned long sz = end - start + 1;
 
 	/* Returning 0 will take to next memory range */
+
+	/* Don't use memory that will be detected and handled by a driver. */
+	if (res->flags & IORESOURCE_MEM_DRIVER_MANAGED)
+		return 0;
+
 	if (sz < kbuf->memsz)
 		return 0;
 
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
