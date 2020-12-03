Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B12CD407
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Dec 2020 11:54:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4739B100ED498;
	Thu,  3 Dec 2020 02:54:23 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BE9A100ED497
	for <linux-nvdimm@lists.01.org>; Thu,  3 Dec 2020 02:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9XAdOW0NAX0z97TKLA8+FaheS9mZEC++RheCYzCJiC0=; b=KKTMVrk2lo1kupWYSi6GnJ50BP
	bbFlrFd213SadLnGexgRgxCz6XGnrCowFQbZYP0Ek8+TnQmvse7dy5OKwmn3pXSROdY1BzfrmJGB7
	WW45gsa7uqgVDk/WxaN9QYY8s+hVcAKPMCMPVFg2fu9KPvvCsD0GvKgR/MmFKuTbob/dBDcKLVx5B
	P4sgOAspA60qV3ACg3l+Xcm5i655Z8KcWvX8nWRsfPX46HdLgl5RGBnPSVO5i2BEUZohg7qg0CNNo
	nWKWXZKL375ibiXy3GHDnLyLwKh1LD+IWnvr+atfzHA8HHC/BA61aXGhVhSOPkC/SH6irn6M9BAc8
	ZESKvs0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkmFV-0001La-1V; Thu, 03 Dec 2020 10:54:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C29D305C11;
	Thu,  3 Dec 2020 11:54:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 26E2820C22F92; Thu,  3 Dec 2020 11:54:07 +0100 (CET)
Date: Thu, 3 Dec 2020 11:54:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] x86/mm: Fix leak of pmd ptlock
Message-ID: <20201203105407.GL2414@hirez.programming.kicks-ass.net>
References: <160697689204.605323.17629854984697045602.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160697689204.605323.17629854984697045602.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: TNODC4BNNBISNME5CPSHA6HA5PQBJVAW
X-Message-ID-Hash: TNODC4BNNBISNME5CPSHA6HA5PQBJVAW
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Yi Zhang <yi.zhang@redhat.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TNODC4BNNBISNME5CPSHA6HA5PQBJVAW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 02, 2020 at 10:28:12PM -0800, Dan Williams wrote:
> pmd_free() is close, but it is a messy fit due to requiring an @mm arg.

Hurpm, only parisc and s390 actually use that argument. And s390
_really_ needs it, because they're doing runtime folding per mm.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
