Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0162C05BB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 13:26:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14823100EBBA1;
	Mon, 23 Nov 2020 04:26:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5C83100EBBA0
	for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 04:26:27 -0800 (PST)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 743BB2076E;
	Mon, 23 Nov 2020 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1606134387;
	bh=frCVka9YuGqxr2RrDANFnW8tkhiq/VbNt2PTcU9GSGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=he2CNP2JfSz3SRBG9V7gwEOPOCXY5CvTJCTBpfjMPVN1bbMSkLAwiYPL/3k3FqxmF
	 ICfkFkdY3JWioWoTZQMBC1Yc4y7wlrHkxM4Y5eXIiagCDWy5N+Ii0qv5y3S8VIf705
	 hSI0ex9rdXllik1LxtJRREQaskl6Wk0bMWGWh3is=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 23/47] MIPS: export has_transparent_hugepage() for modules
Date: Mon, 23 Nov 2020 13:22:09 +0100
Message-Id: <20201123121806.663159108@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123121805.530891002@linuxfoundation.org>
References: <20201123121805.530891002@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Message-ID-Hash: MJUFPOEI64PC7W65VLK3DVUWQAGKXGDB
X-Message-ID-Hash: MJUFPOEI64PC7W65VLK3DVUWQAGKXGDB
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, linux-nvdimm@lists.01.org, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MJUFPOEI64PC7W65VLK3DVUWQAGKXGDB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 31b4d8e172f614adc53ddecb4b6b2f6411a49b84 ]

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
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/tlb-r4k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 0596505770dba..11985399c4695 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -424,6 +424,7 @@ int has_transparent_hugepage(void)
 	}
 	return mask == PM_HUGE_MASK;
 }
+EXPORT_SYMBOL(has_transparent_hugepage);
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
 
-- 
2.27.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
