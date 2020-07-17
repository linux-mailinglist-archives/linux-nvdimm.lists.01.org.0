Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00D223841
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 11:25:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30DD711F7AAD7;
	Fri, 17 Jul 2020 02:25:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DEAA11F7AAD5
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oh4+QZoZC7XJ5liIvD/prbetozs/+rcdlSei8EeQx8I=; b=kazs8KzUqKOCO/2D6mprbyvEnU
	+fzslg8lr95LXVXM9aFdR5oVu7YU+jtZjZuUuNhtdMoijq35pApqNb0Kjpu2+qVjYJPMxBkMxwxwt
	zJhrNYgoG+hopYMkGXql6VsXOH/lcfSxf6ew9w8rrvlgWZWbac4aHyF3rLfDTz9Z9EaOC5qqudxmp
	MPUw2W8cUivp9Wp2v/EKMhTIHSccGcg5LfOOnbnhGaWNlBaW4Nt73aFJHO/KOx+DjkatJQ183jtX+
	+ShtbR2b2ELtr1q+XxcZs8EPUhEs/rKmpIBEOk0TS2IxU4449Zsd/jtbWwQvb1sB85UrR0QJJ9Ss7
	A65td5HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwMc8-00048L-Pk; Fri, 17 Jul 2020 09:25:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6906F300130;
	Fri, 17 Jul 2020 11:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5316B29CF6F53; Fri, 17 Jul 2020 11:25:07 +0200 (CEST)
Date: Fri, 17 Jul 2020 11:25:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: ira.weiny@intel.com
Subject: Re: [PATCH RFC V2 16/17] [dax|pmem]: Enable stray write protection
Message-ID: <20200717092507.GE10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-17-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-17-ira.weiny@intel.com>
Message-ID-Hash: 5KZQAVAZ7SBUOBDFNHOKFZUZR5SICPLI
X-Message-ID-Hash: 5KZQAVAZ7SBUOBDFNHOKFZUZR5SICPLI
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5KZQAVAZ7SBUOBDFNHOKFZUZR5SICPLI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 17, 2020 at 12:20:55AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Protecting against stray writes is particularly important for PMEM
> because, unlike writes to anonymous memory, writes to PMEM persists
> across a reboot.  Thus data corruption could result in permanent loss of
> data.  Therefore, there is no option presented to the user.
> 
> Enable stray write protection by setting the flag in pgmap which
> requests it.  Note if Zone Device Access Protection not be supported
> this flag will have no affect.

The actual implementation is stray-access-protection, as noted ealier.
This inconsisteny is throughout.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
