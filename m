Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E612E82E7
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 Jan 2021 05:29:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB659100EC1C8;
	Thu, 31 Dec 2020 20:29:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3155100ED4A5
	for <linux-nvdimm@lists.01.org>; Thu, 31 Dec 2020 20:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=03MHVj7uFca2pur9ftrcvmwDErnMJojp89WXgKNO4AA=; b=ulXhILNkO4Vn79Fz0WFS5QtaVf
	qFVb6mSuOHgqmfqc1tMBC67fYnpVzBFFXg3A4KfH4e8wRzR55lj+uaovFmy4DxEmleKrSjZ2LdGbQ
	ac7wa5VoRQUnjiBgRnbVQWRzf+hGu+NG1PQyfbh3wrjL5bHHzEEx1Ps0vVzBbjNC1KRlsMaYiEQtE
	S0WcdNbWWEbIvEBHdnKLZWUqsXVgFNXvgRWbsh7EcrPb1WPDe2yvILSvE3WKeDBEn6e5kpJ/5lbqr
	eA+tcvY7ADwkPGBS/IS5raxViLjPSg3TI2JwcGA/8KrnyVI8vj0kKe6Ek0zxYU6WWZLOOHKajeUkL
	8ZUS163Q==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kvC41-0006xy-6o; Fri, 01 Jan 2021 04:29:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Date: Thu, 31 Dec 2020 20:29:14 -0800
Message-Id: <20210101042914.5313-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: O732654IICSCC4523ZNSVEH5RN7HRY6Q
X-Message-ID-Hash: O732654IICSCC4523ZNSVEH5RN7HRY6Q
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O732654IICSCC4523ZNSVEH5RN7HRY6Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

fs/dax.c uses copy_user_page() but ARC does not provide that interface,
resulting in a build error.

Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
add <asm/page.h> to fs/dax.c to fix the build error.

../fs/dax.c: In function 'copy_cow_page_dax':
../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
Acked-by: Vineet Gupta <vgupts@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
---
v2: rebase, add more Cc:

 arch/arc/include/asm/page.h |    1 +
 fs/dax.c                    |    1 +
 2 files changed, 2 insertions(+)

--- lnx-511-rc1.orig/fs/dax.c
+++ lnx-511-rc1/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <asm/page.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
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
