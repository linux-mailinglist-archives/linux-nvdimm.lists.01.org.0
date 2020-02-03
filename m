Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CA1511E2
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 22:37:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92EE210FC337B;
	Mon,  3 Feb 2020 13:40:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06A4C10FC3378
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 13:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EeOvvWZvH50eEtBKHt08qpUyamao6FaQ0LtUnWK0t5w=; b=MbYqw/Vx49lRe78eDwZHP4w6TQ
	AFN++lIatMW4RPg/gX94FI0W6fBb+aofjMfYjdZf2T4WYLPc7hk9sPYr2XepIC2kngyt5oWzR5Ar4
	FcAMWsZ+tpIgZdVNLm7Ys9M1agWjLMHSXX6nGIwvk4lK0hf3Khqnt0Nst+2zDuQQO3b4gBuTDHm5q
	/bQ67UZbBgjnmnrXWRFAE6UlKG/ETmoHmPhfKHNoLJ1mCTjO2ryl4Ix/Tak+7/1IAnzk3gFgDma21
	0G622TPsNo9G0c9ZKdm+yeDwghp2gZLQnxF5JUafrOyFDT3OQZt/W836k7QOwEehg/ZwWiKWps8K7
	Ne8pgJ0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyjPD-0005ga-0O; Mon, 03 Feb 2020 21:37:19 +0000
Date: Mon, 3 Feb 2020 13:37:18 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 02/10] mm: Handle pmd entries in follow_pfn()
Message-ID: <20200203213718.GL8731@bombadil.infradead.org>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-3-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200110190313.17144-3-joao.m.martins@oracle.com>
Message-ID-Hash: CQZIVTLGULFJRIYXHCMBKYUZHYNVJNGU
X-Message-ID-Hash: CQZIVTLGULFJRIYXHCMBKYUZHYNVJNGU
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CQZIVTLGULFJRIYXHCMBKYUZHYNVJNGU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 07:03:05PM +0000, Joao Martins wrote:
> @@ -4366,6 +4366,7 @@ EXPORT_SYMBOL(follow_pte_pmd);
>  int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>  	unsigned long *pfn)
>  {
> +	pmd_t *pmdpp = NULL;

Please rename to 'pmdp'.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
