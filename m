Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CB312C3C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 09:50:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D9EF100EB82E;
	Mon,  8 Feb 2021 00:50:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28C96100EB82E
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 00:50:48 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3831364E92;
	Mon,  8 Feb 2021 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1612774247;
	bh=XFR7qlL7+pkOKnccs9pAjAfcgzqh5naLhoZXuUY1qdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpYPGmCjxHaJQ/xRjVDBFNaabGX7SfniSNpizVfPWQqvRJrWDl186kwV1DSYQHhr9
	 OgIW5BKOXbfsGqZxb2hzjyzRhDHDnwOa4fZgo3NG83Ap866Pk9FyUKP52pJS7Gf7vd
	 gT3GpIUspHtBOoHDk+uUbO2o3jReEMN8bSIEzkNeYAmgmta7vDfGLQcSmS8+sLhW8f
	 qZmes4wFBQmxgnF1WvDrDvZiaD++1Sn8BPGFZtca610Rn1sBihsdvCdYNHnITb/7pO
	 lzz+MW+aByZHL5edu47l8nLT5ZD2/pvhNQqRtUq7BtefEBmwMTJBYftriq/VMujEfK
	 jvK/EiewXBaYA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v17 06/10] arm64: kfence: fix header inclusion
Date: Mon,  8 Feb 2021 10:49:16 +0200
Message-Id: <20210208084920.2884-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210208084920.2884-1-rppt@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: E4IF62YD7WR5A2XTIGFJSOBDXGBGMB2M
X-Message-ID-Hash: E4IF62YD7WR5A2XTIGFJSOBDXGBGMB2M
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@
 linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Dmitry Vyukov <dvyukov@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E4IF62YD7WR5A2XTIGFJSOBDXGBGMB2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds started warning about a missing function declaration
after set_memory_valid() is moved to a new file:

In file included from mm/kfence/core.c:26:
arch/arm64/include/asm/kfence.h:17:2: error: implicit declaration of function 'set_memory_valid' [-Werror,-Wimplicit-function-declaration]

Include the correct header again.

Link: https://lkml.kernel.org/r/20210125125025.102381-1-arnd@kernel.org
Fixes: 9e18ec3cfabd ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
Fixes: 204555ff8bd6 ("arm64, kfence: enable KFENCE for ARM64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/include/asm/kfence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index d061176d57ea..aa855c6a0ae6 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
