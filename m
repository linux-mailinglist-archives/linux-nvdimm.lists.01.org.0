Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86268219613
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 04:13:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECBBD11167BDB;
	Wed,  8 Jul 2020 19:13:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2A3E5111661B8
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qi5089B5TBHI+zy9mDefYNvDdHyy2eklBkVImsmfAA8=; b=XR04+03woT3Wc7Z/57jVKd4hjt
	3/E+cPTx2AQKCpc/7RreVQxlA9fQYhnyQYvjGihVTwBeUhMvD1az1bE+aXIowHLHsO4PPVi+sxQwA
	w3nQAbkppGId8GQAhA5vINNi51acayCJgaGvH8tDYh9hhuTWECwDBu6AGIzdVjzzQC3Zgoo+4Dbnz
	AZjcV2gbkzzZX2ShVFGcqhY1KThJMO/jobs64MREKH5Ezengt4WKDQkr3yw0rrWp+e+/1nIZ1URDR
	u8M4sp6A3rWRF3TEykU38Xw06lEG6SCF2w3ZwXpgRBaTt6syvQbk7T5XdAmus0UblYhhdytIy8B1y
	yTszHv4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtM1h-0006v4-Cd; Thu, 09 Jul 2020 02:11:06 +0000
Date: Thu, 9 Jul 2020 03:11:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jia He <justin.he@arm.com>
Subject: Re: [PATCH v3 4/6] mm: don't export memory_add_physaddr_to_nid in
 arch specific directory
Message-ID: <20200709021104.GZ25523@casper.infradead.org>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709020629.91671-5-justin.he@arm.com>
Message-ID-Hash: 6O4UMR6WZC6A3NMKEOOJBM2CTYDSALMK
X-Message-ID-Hash: 6O4UMR6WZC6A3NMKEOOJBM2CTYDSALMK
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6O4UMR6WZC6A3NMKEOOJBM2CTYDSALMK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 09, 2020 at 10:06:27AM +0800, Jia He wrote:
> After a general version of __weak memory_add_physaddr_to_nid implemented
> and exported , it is no use exporting twice in arch directory even if
> e,g, ia64/x86 have their specific version.
> 
> This is to suppress the modpost warning:
> WARNING: modpost: vmlinux: 'memory_add_physaddr_to_nid' exported twice.
> Previous export was in vmlinux

It's bad form to introduce a warning and then send a follow-up patch to
fix the warning.  Just fold this patch into patch 1/6.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
