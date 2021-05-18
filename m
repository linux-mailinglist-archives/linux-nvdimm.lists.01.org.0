Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E090A387676
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 12:27:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 420E7100F2240;
	Tue, 18 May 2021 03:27:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC739100EB35A
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621333638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
	b=hu4cwNlgqIF9y6apOx12S2Ln9ed/WSIc5qETK3CNvMU7q+r+gTr9soTYGttRGNOEuNjaSM
	pif+hPFuDmB8R2mJotHO4CzpzJhMpNxX4EHGbSKhfFIAr+uY9x3aA88hXNFEMEcnWGVn3z
	Gw01N0VUayxiTcznVWu9omKv/9drT/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-EwjSMdHCMS6ZfwlHUOd_bA-1; Tue, 18 May 2021 06:27:17 -0400
X-MC-Unique: EwjSMdHCMS6ZfwlHUOd_bA-1
Received: by mail-wm1-f72.google.com with SMTP id b128-20020a1c1b860000b029015b52bdb65aso393165wmb.5
        for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 03:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Th9b0uelp+zuS5Dolk9edCcQodErGvwWmi6QbbSzCQ8=;
        b=QUSx7qqcc9HLaRjy9f01BDZaZ8WkvPer1jdLeqAenI2ha7u47KKesxHaiaSDvIvOBc
         AwT1wZthr7ZoBeSP79bv3wq7O3QdVLyP7yu22WxkKP7bdfnuehJ0CFM7mjZsOCZpSclV
         f4ZKn63qb9suRsFXmo6i08e/2lYmAAtMeVIgSyyo6PmmoGdl5vFEp8vJ8qz7Zj/YBAva
         o6/4907qiJJZ+DsuDr6178v6z7SY73jomZOw7AyJ8CIsqsxlDXVtzmMYZNcEgJe03sCT
         J92TextPjGflQo8EX1mMMhXQP2WnMQeRS/+rQEJdiYpftoL35Hg+QuJvtOc3XB28rS4o
         i8mQ==
X-Gm-Message-State: AOAM532OKN5h0ldaPSg+yKqXpT3JIXM8s+4bi4kYrkWux3vBt1q1Ovn1
	Up44hH1t7rq05oT58wa9Ug+wiuRb9V/1whLJkVuLRsBslkzHtHCmGwA1rjGfB1uU+N5rYuLIDIC
	4ujf54Fe7aFqZrt1+UszK
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525895wmq.157.1621333636757;
        Tue, 18 May 2021 03:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+bP4BGJ/+tDiLE4ZHcq1wv671RbTKwVIAcgFztdQnfjanbuq/Gm2r3B/QzaKSEduy6Y9Cg==
X-Received: by 2002:a05:600c:35cc:: with SMTP id r12mr4525739wmq.157.1621333635433;
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fd.dip0.t-ipconnect.de. [91.12.100.253])
        by smtp.gmail.com with ESMTPSA id z3sm1173826wrq.42.2021.05.18.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 03:27:15 -0700 (PDT)
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To: Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-7-rppt@kernel.org>
 <20210518102424.GD82842@C02TD0UTHF1T.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <47d0e5b1-ffee-d694-4865-8718619c1be0@redhat.com>
Date: Tue, 18 May 2021 12:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518102424.GD82842@C02TD0UTHF1T.local>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: HFQUJXED4NHFE57FTMJLIUPHMPEEMLNF
X-Message-ID-Hash: HFQUJXED4NHFE57FTMJLIUPHMPEEMLNF
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@i
 ntel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HFQUJXED4NHFE57FTMJLIUPHMPEEMLNF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 18.05.21 12:24, Mark Rutland wrote:
> On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> It is unsafe to allow saving of secretmem areas to the hibernation
>> snapshot as they would be visible after the resume and this essentially
>> will defeat the purpose of secret memory mappings.
>>
>> Prevent hibernation whenever there are active secret memory users.
> 
> Have we thought about how this is going to work in practice, e.g. on
> mobile systems? It seems to me that there are a variety of common
> applications which might want to use this which people don't expect to
> inhibit hibernate (e.g. authentication agents, web browsers).
> 
> Are we happy to say that any userspace application can incidentally
> inhibit hibernate?

It's worth noting that secretmem has to be explicitly enabled by the 
admin to even work.

-- 
Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
