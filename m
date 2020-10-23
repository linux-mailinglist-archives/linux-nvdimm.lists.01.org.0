Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988622977D1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 21:45:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25A1915DB3920;
	Fri, 23 Oct 2020 12:44:59 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17D6B163575C4
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hsGIUb4yucLxGB3KN+5kBK6FXlbisJz2OT8Rmz4D5Zs=; b=Wg3yFwabw2DWOYk8RC1PyxinQI
	mtZO++ShyMlNEV9tzo2uFUDBkAaHw4lf0EffeW11V45x/I2FzlUFfrroCp8J97fTfWiQspPsCuZJp
	MRqF93sO5l9ixgqnI7sriKWLX1wsvimQrTzp2IT2bTOtdxwEMi0SGeZiHTNdvJT2QBnXQD/+ZknIG
	da5yxZAP1wTxlBs7eX3csrnFjSvulbiL1ey0bETpxASWegLVu186qxQA9qIb1A3pfzo5W5dAsWY3k
	xvqqDgE2pCB+rVDAADttp3Ebkl7SY5cOkAHGuIu6DThA6hVZUIezOvSHwWmzHg4wTxVUcy45XQsoY
	fdwWW6fA==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW2zX-0008HT-DG; Fri, 23 Oct 2020 19:44:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: export has_transparent_hugepage() for modules
Date: Fri, 23 Oct 2020 12:44:40 -0700
Message-Id: <20201023194440.13371-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: WRGYAC4BQ2DEM5KFZS4DB6DRCWHVV2ZW
X-Message-ID-Hash: WRGYAC4BQ2DEM5KFZS4DB6DRCWHVV2ZW
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, linux-nvdimm@lists.01.org, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WRGYAC4BQ2DEM5KFZS4DB6DRCWHVV2ZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

MIPS should export its local version of "has_transparent_hugepage"
so that loadable modules (dax) can use it.

Fixes this build error:
ERROR: modpost: "has_transparent_hugepage" [drivers/dax/dax.ko] undefined!

Fixes: fd8cfd300019 ("arch: fix has_transparent_hugepage()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/mips/mm/tlb-r4k.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201022.orig/arch/mips/mm/tlb-r4k.c
+++ linux-next-20201022/arch/mips/mm/tlb-r4k.c
@@ -438,6 +438,7 @@ int has_transparent_hugepage(void)
 	}
 	return mask == PM_HUGE_MASK;
 }
+EXPORT_SYMBOL(has_transparent_hugepage);
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
