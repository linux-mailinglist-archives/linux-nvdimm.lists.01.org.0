Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBA27E6EA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 12:44:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4BEA7154A9ACB;
	Wed, 30 Sep 2020 03:44:06 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN> 
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EE69154A9ACB
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5qZQjs1EsA6boevvDA9SSd2z5d4qbdVT+hJQw1G/0sA=; b=lmuRNBBJk1jt8rrS9q/PkAhZuG
	fIzl2JL+dfOhTfqi4qYpOXkOTWYgdR39HrKy+8qBSsHCzFUSr8Hbxvdnkpd6E31zUVmcvLq+NQQKR
	Km30qLapukE1XiWNMZYMwvSGoygMffiap4x5lbx9lgZq4Hnrxnm6rchZSVISeJ59yIac7RQbn0luB
	bmOV0s5w4LtQIfeHyEhfyrF1DZLlA2g81NZcHjR4G3OqgBHVZBs3y5vjhZl5424UOd073D6LaCNgz
	68atLfVY8PEoJv37EsSaHNcu4ERIGnpJARBoGgq9+unozcIKEkW6uHN3Bt1Rs8lI0jogsaCMfl1qu
	mpna8MXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNZaJ-0002EU-BE; Wed, 30 Sep 2020 10:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E04C5300446;
	Wed, 30 Sep 2020 12:43:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7F922022B66B; Wed, 30 Sep 2020 12:43:39 +0200 (CEST)
Date: Wed, 30 Sep 2020 12:43:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200930104339.GK2611@hirez.programming.kicks-ass.net>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200930102031.GJ2142832@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930102031.GJ2142832@kernel.org>
Message-ID-Hash: FMS6RIX3UFWXBGOJ6S5FT7YIAZEM7DNO
X-Message-ID-Hash: FMS6RIX3UFWXBGOJ6S5FT7YIAZEM7DNO
X-MailFrom: peterz@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linu
 x-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, songliubraving@fb.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FMS6RIX3UFWXBGOJ6S5FT7YIAZEM7DNO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2020 at 01:20:31PM +0300, Mike Rapoport wrote:

> I tried to dig the regression report in the mailing list, and the best I
> could find is
> 
> https://lore.kernel.org/lkml/20190823052335.572133-1-songliubraving@fb.com/
> 
> which does not mention the actual performance regression but it only
> complaints about kernel text mapping being split into 4K pages.
> 
> Any chance you have the regression report handy? 

I think the saga started here:

 20190820075128.2912224-1-songliubraving@fb.com
 20190820202314.1083149-1-songliubraving@fb.com
 20190823052335.572133-1-songliubraving@fb.com

After that Thomas did the patch I referred to earlier and I endeavoured
to rewrite x86-ftrace.

I added Song to CC, maybe he can remember more.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
