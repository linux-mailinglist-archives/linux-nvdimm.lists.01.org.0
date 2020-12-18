Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539A2DEBB7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 23:44:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C1BF100EB349;
	Fri, 18 Dec 2020 14:44:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BB3AC100ED48D
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 14:44:49 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1608331487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSvGwnCoAalQdHR+Ln4Q2sS79B4UxqMN+RD1afn6GC4=;
	b=WLPlBrXYqR/QHDC+jzhTogdMRUXRoXK7xVn6httZGE/POOtKQOICxm2Vx7GbejEFjraKCp
	8FtPz4HV4CtlPx6lsNBoWhtimmNasXfdHmGCB3HmbMpO6jtChbcJzok72ZwXgYgiPqi/+W
	TVo3o8mEE5wxXl7oVY4N8wC2y8Fd1c5dq3sp22pGFacd1ybmBMogWCrnWhS0YH/Yv6bOLv
	jy76FaA3txWF3rrqdIiM/E1ZuVFE2VhdGDiw8WjIanN7S0vT61aUViIeTCTFVaKx6xUytw
	RvdtJ7Gjd4DRTiq5bs+kLdz+fgJOLnKr2p1wVbJxp5o5kFLaeENoshm8pvRMtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1608331487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSvGwnCoAalQdHR+Ln4Q2sS79B4UxqMN+RD1afn6GC4=;
	b=adzlxci9JislJbxDWr9PbAbA3shNaiVRFjiwlYUSAoyCp+6io/bqTAyHyqeJm/zADQxY5/
	Mn3qg+DY7xHFSeBA==
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com> <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de> <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com> <875z4yrfhr.fsf@nanos.tec.linutronix.de> <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
Date: Fri, 18 Dec 2020 23:44:47 +0100
Message-ID: <87wnxepwdc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: QZBXQJAZYLWTH47YVGN6R2EX7VWIEP3D
X-Message-ID-Hash: QZBXQJAZYLWTH47YVGN6R2EX7VWIEP3D
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QZBXQJAZYLWTH47YVGN6R2EX7VWIEP3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18 2020 at 13:58, Dan Williams wrote:
> On Fri, Dec 18, 2020 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> kmap_local() is fine. That can work automatically because it's strict
>> local to the context which does the mapping.
>>
>> kmap() is dubious because it's a 'global' mapping as dictated per
>> HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
>> identify cases where the mapped address is really handed to a different
>> execution context. We want to see those cases and analyse whether this
>> can't be solved in a different way. That's why I suggested to do a
>> warning in that case.
>>
>> Also vs. the DAX use case I really meant the code in fs/dax and
>> drivers/dax/ itself which is handling this via dax_read_[un]lock.
>>
>> Does that make more sense?
>
> Yup, got it. The dax code can be precise wrt to PKS in a way that
> kmap_local() cannot.

Which makes me wonder whether we should have kmap_local_for_read()
or something like that, which could be obviously only be RO enforced for
the real HIGHMEM case or the (for now x86 only) enforced kmap_local()
debug mechanics on 64bit.

So for the !highmem case it would not magically make the existing kernel
mapping RO, but this could be forwarded to the PKS protection. Aside of
that it's a nice annotation in the code.

That could be used right away for all the kmap[_atomic] -> kmap_local
conversions.

Thanks,

        tglx
---
 include/linux/highmem-internal.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -32,6 +32,10 @@ static inline void kmap_flush_tlb(unsign
 #define kmap_prot PAGE_KERNEL
 #endif
 
+#ifndef kmap_prot_to
+#define kmap_prot PAGE_KERNEL_RO
+#endif
+
 void *kmap_high(struct page *page);
 void kunmap_high(struct page *page);
 void __kmap_flush_unused(void);
@@ -73,6 +77,11 @@ static inline void *kmap_local_page(stru
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
+static inline void *kmap_local_page_for_read(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot_ro);
+}
+
 static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
@@ -169,6 +178,11 @@ static inline void *kmap_local_page_prot
 {
 	return kmap_local_page(page);
 }
+
+static inline void *kmap_local_page_for_read(struct page *page)
+{
+	return kmap_local_page(page);
+}
 
 static inline void *kmap_local_pfn(unsigned long pfn)
 {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
