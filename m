Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE145365BAB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 17:01:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DC06100F225F;
	Tue, 20 Apr 2021 08:01:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84683100F225C
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 08:01:08 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE7CC613CD;
	Tue, 20 Apr 2021 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618930864;
	bh=8H5HU47vEWQjvvF+2Pz4ChL06bcJ0cPitsV98kgBsxg=;
	h=From:To:Cc:Subject:Date:From;
	b=n4Nm3HlpfChYGkCY62zrscIigP2PS/KwtQe3rk8cf0a4kmFXBffFMI/JZOZf3lqXG
	 I2DY9NMidPqLhsTgvFwkE+J6Fy9TPmwoPeQuiLO1iU5ibpkWYcCNMkqL8WamECYDx/
	 cFnHJ2L51bPl3ihavFrLiRAdeJI2Bij5m4ZGUDbwVRUbPbbbOGIQTyE7lxfqgkGVlh
	 +EYbmgdDfDCeyFVzW71FzXt7d+plT2fK+Ik0mpJZ2ndkuq0eiTmXZAZ7zGob/famDE
	 EyW64QzflOhPuGIz3FV6JVuCs/V9Kd04MBng8Mkhuo5rTiWoHO+xJJif/5vq6yiKU1
	 X3aq4Yn+wxUkw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/2]  secretmem: optimize page_is_secretmem()
Date: Tue, 20 Apr 2021 18:00:47 +0300
Message-Id: <20210420150049.14031-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Message-ID-Hash: 7UCCUWM5PYMMR2CQT7FFL2PFEI7ETY27
X-Message-ID-Hash: 7UCCUWM5PYMMR2CQT7FFL2PFEI7ETY27
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel B
 utt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7UCCUWM5PYMMR2CQT7FFL2PFEI7ETY27/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is an updated version of page_is_secretmem() changes.
This is based on v5.12-rc7-mmots-2021-04-15-16-28.

@Andrew, please let me know if you'd like me to rebase it differently or
resend the entire set.

v3:
* add missing put_compound_head() if we are to return NULL from
  gup_page_range(), thanks David.
* add unlikely() to test for page_is_secretmem.

v2:
* move the check for secretmem page in gup_pte_range after we get a
  reference to the page, per Matthew.

Mike Rapoport (2):
  secretmem/gup: don't check if page is secretmem without reference
  secretmem: optimize page_is_secretmem()

 include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
 mm/gup.c                  |  6 +++---
 mm/secretmem.c            | 12 +-----------
 3 files changed, 29 insertions(+), 15 deletions(-)

-- 
2.28.0


Mike Rapoport (2):
  secretmem/gup: don't check if page is secretmem without reference
  secretmem: optimize page_is_secretmem()

 include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
 mm/gup.c                  |  8 +++++---
 mm/secretmem.c            | 12 +-----------
 3 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
