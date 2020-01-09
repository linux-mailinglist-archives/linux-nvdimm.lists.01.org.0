Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3E136233
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 22:05:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0D97210097DCC;
	Thu,  9 Jan 2020 13:08:27 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 497DE10097DCA
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 13:08:24 -0800 (PST)
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1ipez7-0008OC-Ij; Thu, 09 Jan 2020 22:04:53 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
	id 0AA1A105BCE; Thu,  9 Jan 2020 22:04:53 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/14] x86/mm: Introduce lookup_address_in_mm()
In-Reply-To: <20200108202448.9669-6-sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com> <20200108202448.9669-6-sean.j.christopherson@intel.com>
Date: Thu, 09 Jan 2020 22:04:53 +0100
Message-ID: <871rs8batm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Message-ID-Hash: B25QYIO7JLOTIQEMDFFXHPYAHOM2NXNX
X-Message-ID-Hash: B25QYIO7JLOTIQEMDFFXHPYAHOM2NXNX
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B25QYIO7JLOTIQEMDFFXHPYAHOM2NXNX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b5e49e6bac63..400ac8da75e8 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -561,6 +561,10 @@ static inline void update_page_count(int level, unsigned long pages) { }
>  extern pte_t *lookup_address(unsigned long address, unsigned int *level);
>  extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  				    unsigned int *level);
> +
> +struct mm_struct;
> +pte_t *lookup_address_in_mm(struct mm_struct *mm, unsigned long address,
> +			    unsigned int *level);

Please keep the file consistent and use extern even if not required.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
