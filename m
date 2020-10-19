Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA352924B6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 11:37:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9263D15E1587F;
	Mon, 19 Oct 2020 02:37:38 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D7AA15E1587D
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O3B5SDSSGOQ/+MQUdt0Hy/pyKJ8BUU2Uw0eRUC0gQJw=; b=UjWOH0rqHpfO2evvAot8XfZPhm
	Ujz8nN5NXFhX2X4ST7K3yr0FRVocJcnYRDv/x7ri2cofoF0tNd4LH43/uNrRKlRuD7TzTxbBiCxfy
	f08AUp6A/Do8cyTspB4hlKZPrmm2mETomhSipdZAEa6fN7de/Z1evQijJAVE/MGG/DxVM2iU4Qn1q
	FUGEOKLtigWd+T+4WYYGb9bKOVXkDEghzmKrV64OZSbp3a8dondpd2YaqnxT8BjrOR+snVk2sP+AP
	w4nUUDdb7ykKA7E8PI1XyPVgSG1NlxEHDdKwSNLo4JS+pBVzA5E8S9e3uLAZUr0QXqTZzSQjS9Nvy
	WFDYp1rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kURbQ-0003ky-22; Mon, 19 Oct 2020 09:37:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B242E3012C3;
	Mon, 19 Oct 2020 11:37:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id A127821447780; Mon, 19 Oct 2020 11:37:14 +0200 (CEST)
Date: Mon, 19 Oct 2020 11:37:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201019093714.GI2628@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
 <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: P7VYK6DC5I25RZYIEEWSXXCAKUGNSAEN
X-Message-ID-Hash: P7VYK6DC5I25RZYIEEWSXXCAKUGNSAEN
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P7VYK6DC5I25RZYIEEWSXXCAKUGNSAEN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2020 at 10:14:10PM -0700, Ira Weiny wrote:
> > so it either needs to
> > explicitly do so, or have an assertion that preemption is indeed
> > disabled.
> 
> However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
> handle the preempt_disable() for us? 

It does.

> Is it not sufficient to rely on that?

It is.

> Dave's comment seems to be the opposite where we need to eliminate preempt
> disable before calling write_pkrs().
> 
> FWIW I think I'm mistaken in my response to Dave regarding the
> preempt_disable() in pks_update_protection().

Dave's concern is that we're calling with with preemption already
disabled so disabling it again is superfluous.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
