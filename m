Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8EE2F2FB3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 13:58:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9F0D100EB833;
	Tue, 12 Jan 2021 04:58:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C197100EB832
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 04:58:30 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D35C22312F;
	Tue, 12 Jan 2021 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1610456310;
	bh=0xLiq19uuF+LFA0yw7Rwauxqd1irVWHtnuE67K59/lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8O+IFZDV1mhk5XsTsWbLrW1xzrSVYxvK5blw0fJPWOYpStCe3DCIq7EXWLyLxolN
	 TLMwQfBVojPJMLN9JxABbmBux71bYXWiqRGUpVBKyaKjN3hBfImirfcsTX4oH+j2ru
	 NjHhomzM0c8ys/od7truSD0S2+6XeKJDbsnP5x000hT9HFGAVLJgzYU/CLFIieWddh
	 cF9uNR0cr8ARsiFzmgcVojEDTN8GkQ6qGGVIMtUaW9OAcXLdoF/mm5w9+Eul9btKCh
	 DvWDBUQcBKH18yRPmjz5KQMwz+CMKgkHCylmUjpUG9h+5SMHgh9mAuDaslVTUGVmFq
	 W1kWy89IcdHiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 4/8] arch/arc: add copy_user_page() to <asm/page.h> to fix build error on ARC
Date: Tue, 12 Jan 2021 07:58:19 -0500
Message-Id: <20210112125823.71463-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125823.71463-1-sashal@kernel.org>
References: <20210112125823.71463-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: OFTAAYDDR7DVWMK3UUZLE72G6DAY4KKM
X-Message-ID-Hash: OFTAAYDDR7DVWMK3UUZLE72G6DAY4KKM
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Sasha Levin <sashal@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OFTAAYDDR7DVWMK3UUZLE72G6DAY4KKM/>
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
index 8f1145ed0046f..fd2c88ef2e2b8 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -17,6 +17,7 @@
 #define free_user_page(page, addr)	free_page(addr)
 
 #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
 
 struct vm_area_struct;
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
