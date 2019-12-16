Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D816121334
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Dec 2019 19:00:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E729A10097F23;
	Mon, 16 Dec 2019 10:03:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8768610097F20
	for <linux-nvdimm@lists.01.org>; Mon, 16 Dec 2019 10:03:19 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d15so4804877pll.3
        for <linux-nvdimm@lists.01.org>; Mon, 16 Dec 2019 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DJGBGvTAS/i0iYU7uRr6zHHSNaYAfvF1fKpLbSg2osI=;
        b=KO0fUUxTz3mIKnh2o8stIaHBKDJy4a0Sc3zH32h6OoVde0KKE1Ne65jA1Z3fn0BvXE
         GSu/1gUbrSo5KfZdxNmUWB/K1AvEg4MvfxiCcUANexOkDwxGN3Oyj5WXkoaQyxgVAR3/
         5C4yQsQS61VeZghqqA4hZJVx8UI1eF8MlTCatlpDdGYBIubTWA7LDrXfOsNOtm8olk7M
         /WSAdAISwANmc7M+ANY1fqRhBsuHDj4Lyg3RflUojnVbnyBRjDSfqgLN7DmVNm2G06zl
         nX/0531PHuoPQwvxysjGCttHwIZO3itx9oF+3Th9NFQYHPL2novcu6kZz7LKPo/nyPrs
         6dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DJGBGvTAS/i0iYU7uRr6zHHSNaYAfvF1fKpLbSg2osI=;
        b=D92a0pNO0cjWerD3Z/MlLxQdpQa1pOgorZDaYVxqO2kdIFMUDBCpmuRtmkFW9wyT6t
         GlCO9D2GouV6Oe8Qz3DIHTibTRiqPHgROu0GSRwInyo5KsbV2zF2b2Dc2rIO59oAGWyt
         vk/f+NJzjB1CtBvUSQHn2VlybmTm73dVET7IsJDUiLceZhHDwbvsP4BDz9LGDroyrmED
         yqwlH3L5jotyJvf7/rbwCJH1Pg1HnZXBox6/tGagqi4Dnz4E3BQbxQ25+SKzYG+Zll/D
         F2tFJRMHvKZn02iaF3pBQxWqyeIuU024jZszEG7/yHxsMPvQgWil4RvSNKEs5+L5u4CH
         2N3Q==
X-Gm-Message-State: APjAAAWEL2P+t/uoim9vFJtj9VJhvehgtSC3+8cJ6yLGF+YSMLw7Hl/M
	k/ij9lwf+vqOhTm+b0aM0JjitQ==
X-Google-Smtp-Source: APXvYqwOJXNcFn1m98nkQulGDUAoyGF9vWbS/blvOgPSgK75hoZXtx3/MHs96VgAKvmCjNr5114E/Q==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr428610pjb.76.1576519196210;
        Mon, 16 Dec 2019 09:59:56 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id e9sm23597209pgn.49.2019.12.16.09.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 09:59:55 -0800 (PST)
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
To: Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-2-brho@google.com>
 <20191213174702.GB31552@linux.intel.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
Date: Mon, 16 Dec 2019 12:59:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213174702.GB31552@linux.intel.com>
Content-Language: en-US
Message-ID-Hash: EWMZBAFJEA3T564FLBLRAGSIZBPHMKBN
X-Message-ID-Hash: EWMZBAFJEA3T564FLBLRAGSIZBPHMKBN
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EWMZBAFJEA3T564FLBLRAGSIZBPHMKBN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/13/19 12:47 PM, Sean Christopherson wrote:
>> +unsigned long dev_pagemap_mapping_shift(unsigned long address,
>> +					struct mm_struct *mm)
>> +{
>> +	pgd_t *pgd;
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +	pte_t *pte;
>> +
>> +	pgd = pgd_offset(mm, address);
>> +	if (!pgd_present(*pgd))
>> +		return 0;
>> +	p4d = p4d_offset(pgd, address);
>> +	if (!p4d_present(*p4d))
>> +		return 0;
>> +	pud = pud_offset(p4d, address);
>> +	if (!pud_present(*pud))
>> +		return 0;
>> +	if (pud_devmap(*pud))
>> +		return PUD_SHIFT;
>> +	pmd = pmd_offset(pud, address);
>> +	if (!pmd_present(*pmd))
>> +		return 0;
>> +	if (pmd_devmap(*pmd))
>> +		return PMD_SHIFT;
>> +	pte = pte_offset_map(pmd, address);
>> +	if (!pte_present(*pte))
>> +		return 0;
>> +	if (pte_devmap(*pte))
>> +		return PAGE_SHIFT;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pagemap_mapping_shift);
> 
> This is basically a rehash of lookup_address_in_pgd(), and doesn't provide
> exactly what KVM needs.  E.g. KVM works with levels instead of shifts, and
> it would be nice to provide the pte so that KVM can sanity check that the
> pfn from this walk matches the pfn it plans on mapping.

One minor issue is that the levels for lookup_address_in_pgd() and for 
KVM differ in name, although not in value.  lookup uses PG_LEVEL_4K = 1. 
  KVM uses PT_PAGE_TABLE_LEVEL = 1.  The enums differ a little too: x86 
has a name for a 512G page, etc.  It's all in arch/x86.

Does KVM-x86 need its own names for the levels?  If not, I could convert 
the PT_PAGE_TABLE_* stuff to PG_LEVEL_* stuff.

> 
> Instead of exporting dev_pagemap_mapping_shift(), what about replacing it
> with a patch to introduce lookup_address_mm() and export that?
> 
> dev_pagemap_mapping_shift() could then wrap the new helper (if you want),

I might hold off on that for now, since that helper is used outside of 
x86, and I don't know if 'level' makes sense outside of x86.

Thanks,

Barret
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
