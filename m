Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C482EA40A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 04:48:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B5D9C100EC1FA;
	Mon,  4 Jan 2021 19:48:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 682F2100EC1EE
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 19:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xvxlCGowN31Xh/eMwMOxKX1sU7xQYvnwJjb9H7a7Qfg=; b=fCOcY9KPiE3XxHr3mGOAN9ApBw
	xwhr9RFjdx/HiAqNsrqURth49nt/hE+aettEIsGIjhsfRhogSUvHCLPaWdYU/eCOxX8fUrverXQR8
	QM0M9hbX5loFyoLA673vdQKUP3M7zwXBfTgQ2V1DLyX6sPuxTiHyJ+xYCMnjVE1MCNZRAcrGG2Gnc
	zRIeawk6r+suf8O68gRuFKUqfWKXOgq2Oy7MZdYLDSIqEwu9DjMYRmU+175FCNyHZtVvVoACKzh+l
	aWKp/kC+vglC9HQLKl5Bkfme1t4d6me6C2VlRHTHOsh2waxKdspw9XXAvAdJhapR7QfupQhWBM+kI
	b+79Zuyg==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
	id 1kwdHH-000pmb-BU; Tue, 05 Jan 2021 03:45:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3] arch/arc: add copy_user_page() to <asm/page.h> to fix build error on ARC
Date: Mon,  4 Jan 2021 19:44:53 -0800
Message-Id: <20210105034453.12629-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: WQZ6TEITBX6VZQRX6Q6O2M4H53WFQHDW
X-Message-ID-Hash: WQZ6TEITBX6VZQRX6Q6O2M4H53WFQHDW
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WQZ6TEITBX6VZQRX6Q6O2M4H53WFQHDW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fs/dax.c uses copy_user_page() but ARC does not provide that interface,
resulting in a build error.

Provide copy_user_page() in <asm/page.h>.

../fs/dax.c: In function 'copy_cow_page_dax':
../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
#Acked-by: Vineet Gupta <vgupta@synopsys.com> # v1
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
#Reviewed-by: Ira Weiny <ira.weiny@intel.com> # v2
---
v2: rebase, add more Cc:
v3: add copy_user_page() to arch/arc/include/asm/page.h

 arch/arc/include/asm/page.h |    1 +

--- lnx-511-rc1.orig/arch/arc/include/asm/page.h
+++ lnx-511-rc1/arch/arc/include/asm/page.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
 
 struct vm_area_struct;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
