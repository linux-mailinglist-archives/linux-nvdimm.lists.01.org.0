Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47A2F2F71
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 13:56:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AE1E100EB82A;
	Tue, 12 Jan 2021 04:56:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C582E100EBB8C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 04:56:20 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82C822310F;
	Tue, 12 Jan 2021 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1610456179;
	bh=ZfRNyTieOsoVNKe8Y2oI4EMd7ks971g+wnjHRo7dt18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqXxn/DgLD+d0rPjUUJBXj4JJwMU47kZnN1obfF3BpYR6vsCBDSF0CGok+z1JzXID
	 s7/WcaVsAPP0U6fLDvLXz+x81AlDrmMeAwykwHZvViPf2S5q7FMQ3oNxTT5Wy5X2mw
	 7it9K2GxOFAG9xRbyIOBtj6Ql9cIDBHQ2dD+C1fetuWiiDTk7/lGHyJvZnRwZ8Ym8Q
	 W9QYhp1K96PSFdyftVb4JWN1EmupGYpYzSwsU9g3pJMJirWcJNbjYIKYsQNzxM9jEs
	 s3E4EeI1cBgKSM807siv5f6LAQUOKBe53c/0sIvnVilNvIkT6X7FdG2G2iM9xSQJX5
	 5jKlPx4s+lzCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 34/51] arch/arc: add copy_user_page() to <asm/page.h> to fix build error on ARC
Date: Tue, 12 Jan 2021 07:55:16 -0500
Message-Id: <20210112125534.70280-34-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125534.70280-1-sashal@kernel.org>
References: <20210112125534.70280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: Q7MB7XJZWISQRS2NFLKFZA3O4ENEJUXV
X-Message-ID-Hash: Q7MB7XJZWISQRS2NFLKFZA3O4ENEJUXV
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Sasha Levin <sashal@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7MB7XJZWISQRS2NFLKFZA3O4ENEJUXV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 8a48c0a3360bf2bf4f40c980d0ec216e770e58ee ]

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
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/page.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index b0dfed0f12be0..d9c264dc25fcb 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
 
 struct vm_area_struct;
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
