Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C61DDB55
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 01:54:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B11FD1172D36C;
	Thu, 21 May 2020 16:50:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B610D1172D367
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 16:50:27 -0700 (PDT)
IronPort-SDR: pjZv4CvDK/UXGvwWS4blWir7fGeB5dSg6l84u+yYoMX77lvMo9v/WDFnecAg6Hwphy+CXIUVDo
 rujQk/X+F4Iw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:54:01 -0700
IronPort-SDR: uN2JO7VRFCA+BU+ZiUlQtX0aFqBz4P05q3uuqVEjHelJfxM6w40okjP2byV05yOD9ToPqPTWjj
 ++x+te6Tpbsg==
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400";
   d="scan'208";a="309216914"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:54:00 -0700
Subject: [5.4-stable PATCH 1/7] mm/memremap_pages: Kill unused
 __devm_memremap_pages()
From: Dan Williams <dan.j.williams@intel.com>
To: stable@vger.kernel.org
Date: Thu, 21 May 2020 16:37:48 -0700
Message-ID: <159010426892.1062454.14033665233091025420.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4JTVBEMWY2UT6A5ZNVJ2ZFIODCJ46RZ3
X-Message-ID-Hash: 4JTVBEMWY2UT6A5ZNVJ2ZFIODCJ46RZ3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4JTVBEMWY2UT6A5ZNVJ2ZFIODCJ46RZ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Commit 1d0827b75ee7df497f611a2ac412a88135fb0ef5 upstream.

Kill this definition that was introduced in commit 41e94a851304 ("add
devm_memremap_pages") add never used.

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/158041476158.3889308.4221100673554151124.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/io.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index a59834bc0a11..35e8d84935e0 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -79,8 +79,6 @@ void *devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void devm_memunmap(struct device *dev, void *addr);
 
-void *__devm_memremap_pages(struct device *dev, struct resource *res);
-
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
