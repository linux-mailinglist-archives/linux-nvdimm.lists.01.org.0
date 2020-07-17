Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D722381A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:20:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8979B11F7AAC5;
	Fri, 17 Jul 2020 02:20:25 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D0F3411EB8D9B
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vD7ogw/DhcHODHv2SCgzRx5wCV73axCwV9UAHq/1Hbs=; b=AEJQmWGipvhnfI6mCc6xEM/Rt1
	P3GrZ7sBFk0hlBFp137PYFnvWOJGZNv3bFsNz986Z2rFlhmlsxqsFiuWGdaFXV58Q/0Q1lwLZWhkY
	tohXqG4s7Guw2+BMyDO6CLmxbq8RVdkl9Uuvsse7QROwJgF8eklcfc38kX9b0GGQ7LUZ4vI4Dbn6x
	7n+sL8Wa+yeDoXbuafGGA9MdKyEXEpDIsXCr9cRjsEyjdb5oLGK4REc34sUtyh1ApWgoc5qsynV83
	GGvV+NQoh/Ropd/S9sG5wyHDOFNOfzYQZ9l88S2lEIq5poau+tVs1/+tSpgzET+mJwXFSvJfBgWIB
	fDmu/Ixw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMXQ-0002yY-4H; Fri, 17 Jul 2020 09:20:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7450300446;
	Fri, 17 Jul 2020 11:20:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id A22FF29CF6F51; Fri, 17 Jul 2020 11:20:14 +0200 (CEST)
Date: Fri, 17 Jul 2020 11:20:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Message-ID: <20200717092014.GB10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-13-ira.weiny@intel.com>
Message-ID-Hash: HFBKZHQ3TMP7BMNLWZ4XRFMUBYLQ35VJ
X-Message-ID-Hash: HFBKZHQ3TMP7BMNLWZ4XRFMUBYLQ35VJ
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HFBKZHQ3TMP7BMNLWZ4XRFMUBYLQ35VJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Device managed memory exposes itself to the kernel direct map which
> allows stray pointers to access these device memories.
> 
> Stray pointers to normal memory may result in a crash or other
> undesirable behavior which, while unfortunate, are usually recoverable
> with a reboot.  Stray writes to areas such as non-volatile memory are
> permanent in nature and thus are more likely to result in permanent user
> data loss vs a stray write to other memory areas

> +		pks_update_protection(dev_page_pkey, PKEY_DISABLE_ACCESS);

So on the one hand you talk about the problem of stray writes, but then
you disable all access.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
