Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878029E8D7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Oct 2020 11:19:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24F4F16381CD7;
	Thu, 29 Oct 2020 03:18:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+253bd1d761fb220e0d1c+6276+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1615116381CD5
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Zns1ysEyW/6YEAQtEOc2r63tr9Y6svfKyny2d9qVHyM=; b=r4pJ7G6qvKdBOk+QTWN21fiCfd
	LpNaHk07zgUMFQpHZPBK59I1JRAJ9h+2q1m1JNgphyY6SpfCsNWW5WJVHnNqj4mzrHJLa/mcQbtM2
	lPAxdBH8GmSocF07pX8G7QqLV5sRHXY5EjMbPe2dpvRtgswDN9o/vKwnGHeuYNzI2iB1TJPOC8Pl4
	Vnrcklckg5tUpYBSe1k2vh/EWF38hj8BYNRzAANTbr56cV2nrW5JksH82ZTg5noEUhZE4Hknsbswj
	a3YD9sansNmeA1mAmfTrFXwPAexev3mgl0Jz6he4YhZw6yRo/mV83XL14bKBzZLa7wN2nSZT9GasX
	jBohiqzg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kY51B-0004BL-O5; Thu, 29 Oct 2020 10:18:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] mm: unexport follow_pte_pmd
Date: Thu, 29 Oct 2020 11:14:31 +0100
Message-Id: <20201029101432.47011-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029101432.47011-1-hch@lst.de>
References: <20201029101432.47011-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: 7OMAPAPPDRY2EQSZUDACTXP5FBBJ323U
X-Message-ID-Hash: 7OMAPAPPDRY2EQSZUDACTXP5FBBJ323U
X-MailFrom: BATV+253bd1d761fb220e0d1c+6276+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7OMAPAPPDRY2EQSZUDACTXP5FBBJ323U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

follow_pte_pmd is only used by the DAX code, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e50268..00458e7b49fef8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4787,7 +4787,6 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 						    ptepp, pmdpp, ptlp)));
 	return res;
 }
-EXPORT_SYMBOL(follow_pte_pmd);
 
 /**
  * follow_pfn - look up PFN at a user virtual address
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
