Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B7143F78
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 15:26:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C3DF1007B8CE;
	Tue, 21 Jan 2020 06:29:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6487C1007B8CD
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579616793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB7oBUxPFMMo41Dhy/A6/q8IlRImdTJH/qsnmSwn8s8=;
	b=SkNEywdQxA2MNtBg974Sn0ZydviqoFf7LucDrjpzy39Tsk8ub9HgZig3tiUC1+XV8YjbVC
	dTZMVC1+cXJQ0Y9JvlxcvsQVNTw2JT79hjDojprlb9ehkrPWMN4i5j+ONb6/mm5FEXWbh0
	xgCF491KvV5JkAxjJhjWm2briBhiIR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-8EVSDN8HOMODMl9BvaCj3w-1; Tue, 21 Jan 2020 09:26:31 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so1364999wrm.17
        for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wB7oBUxPFMMo41Dhy/A6/q8IlRImdTJH/qsnmSwn8s8=;
        b=XFCWMzkT7BLTKKKieiK3RDKnYrQGjqBQw9H7veu+yh52KmW5HRsH+l5BD2ioFXjERb
         dyZuRakvewDBAS0yM3fGA78WhShrtVsTTdJt17vv6IZlfIpfJV3TNEpsWBpIL3UMvSMe
         AlriLZNaOvWYD+mirsZaxcvq2PNaqkX0CqmpdyHCIhWo9ZH5uNlmUgEbC0TjChJ+JPHL
         Uxgbxwt78FVD0qcBEI6tYEn3SW9eG0g4LSSckC3KCX92qne/TImSk+wfKHNMkopQywnG
         2XGYSiF0ZGZvo3bZzTUQweGjCvpsyHog308TNK/vaOLH3/HU8FyGuBpS70Y3ujDElkBI
         U7yg==
X-Gm-Message-State: APjAAAXvMlr6N20TM3t7kyrv5nr9sEMSDWPH9UXS76hlr2pYWe7YDIWd
	7nZ3S3ejDIEaxxNbfK0R2qXuUGM9Khi9E6I6a0qf+JmdM9DEBOwLAbF6YIJsiKHPAHPMLEK2YsV
	nhHlE1qendfwoTZJ1JWG5
X-Received: by 2002:a5d:6089:: with SMTP id w9mr5614969wrt.228.1579616790219;
        Tue, 21 Jan 2020 06:26:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWjz4Oe+H/gSHDnoSQ5o2pah30WIinDPbt454AQ/QK4v/OQZOFatnXxkc9zEh4soAyNb9f2w==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr5614921wrt.228.1579616789896;
        Tue, 21 Jan 2020 06:26:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id q68sm4727432wme.14.2020.01.21.06.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:26:29 -0800 (PST)
Subject: Re: [PATCH 05/14] x86/mm: Introduce lookup_address_in_mm()
To: Thomas Gleixner <tglx@linutronix.de>,
 Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-6-sean.j.christopherson@intel.com>
 <871rs8batm.fsf@nanos.tec.linutronix.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <175cef39-1e0e-d1b7-69bc-95a3a2a651a7@redhat.com>
Date: Tue, 21 Jan 2020 15:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <871rs8batm.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
X-MC-Unique: 8EVSDN8HOMODMl9BvaCj3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: ZA6PEJF2AYT6OUON2KHKEQC4W26QLRYG
X-Message-ID-Hash: ZA6PEJF2AYT6OUON2KHKEQC4W26QLRYG
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZA6PEJF2AYT6OUON2KHKEQC4W26QLRYG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 09/01/20 22:04, Thomas Gleixner wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>> index b5e49e6bac63..400ac8da75e8 100644
>> --- a/arch/x86/include/asm/pgtable_types.h
>> +++ b/arch/x86/include/asm/pgtable_types.h
>> @@ -561,6 +561,10 @@ static inline void update_page_count(int level, unsigned long pages) { }
>>  extern pte_t *lookup_address(unsigned long address, unsigned int *level);
>>  extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>>  				    unsigned int *level);
>> +
>> +struct mm_struct;
>> +pte_t *lookup_address_in_mm(struct mm_struct *mm, unsigned long address,
>> +			    unsigned int *level);
> 
> Please keep the file consistent and use extern even if not required.
> 
> Other than that:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 

Adjusted, thanks for the review.

Paolo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
