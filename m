Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF376223874
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:34:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E34C11F7AAF0;
	Fri, 17 Jul 2020 02:34:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6DD7211EB8D8F
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G+DDgxlCayqTqkbq04dhgvzaNPWJG1ftzlKeUp8ZiFs=; b=J5mK0s4tYmqK6uzf1Ef8cazS/R
	to9O6JMHWxqFx/Q73rJAgfpYCwgTaJ2p4J5jxdEO1zUSL7Q4VWYsXvU5iJzpQR2ZqKENNkHA9EXJr
	ftW+mfAAxwQ0HjEBs1RO0M9ljr04qNOR8yuXhaTdKDLmU0XpO0pwG7bwgBFNDuapJ5HJ7u1Mkd+pS
	cs/sgBSDcF/Dyb1pJETDT1yOY35LS/DK7+hqF+OFHaCvScr8WU5GtLwxRBallJ4KReWd7/F5srgru
	lKtFmrRk7I9GXt8BOAWYoRmFymx51TOWhwZyWD7BZYyNmj+oPmp2nqUHzPk+UataRPkG6PLrUCiUk
	ljYZR/SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMkl-00005B-TB; Fri, 17 Jul 2020 09:34:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C058C300130;
	Fri, 17 Jul 2020 11:34:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id B322929CF6F55; Fri, 17 Jul 2020 11:34:01 +0200 (CEST)
Date: Fri, 17 Jul 2020 11:34:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200717093401.GG10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-18-ira.weiny@intel.com>
Message-ID-Hash: 7QENOEZIWCRYPYVFGT7DTWPBISC6AR7W
X-Message-ID-Hash: 7QENOEZIWCRYPYVFGT7DTWPBISC6AR7W
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7QENOEZIWCRYPYVFGT7DTWPBISC6AR7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> +/* Define as macros to prevent conflict of inline and noinstr */
> +#define idt_save_pkrs(state)
> +#define idt_restore_pkrs(state)

Use __always_inline
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
