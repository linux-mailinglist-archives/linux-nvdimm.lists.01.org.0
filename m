Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84090302896
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 Jan 2021 18:18:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C93FB100EBBB8;
	Mon, 25 Jan 2021 09:18:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=shakeelb@google.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5ED16100EBBB4
	for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 09:18:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a8so18896656lfi.8
        for <linux-nvdimm@lists.01.org>; Mon, 25 Jan 2021 09:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF3PAS9R3ZcPxx4Z5KTeI/YMZHaaDZloSJa4zd+LcN4=;
        b=dcojzpvBme3j+zUhY3ahCgy1OWbsKkFNmO1SmDOVx9o3VOdmi1r2YX6L0pn3CYTKxE
         UuzL4cx554sA9UWfceH335k9zgKeNdNZbQkg0ruEwHt2oD7i5VhQHFj8dho+iNbxnOIi
         kbP6D0HNZYkv/fCic1j5WVLYkd7Cr9blj/atVb/ioXbDyORifrO8kcGBh7MCL0flLrDK
         D2ZQOL0FlMXMeBJEJSv+/JfLGOP1UGbY+1X/Y5zaitRWa/9P2DldYEEdQW4OPBEOCyLf
         c+RRNgmCaHeK6qP/DS1Pp+OIpiTReTg8yF4kHgiTCvjQR1HWcMVRmJAgmErZ8wIE4wHP
         EOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF3PAS9R3ZcPxx4Z5KTeI/YMZHaaDZloSJa4zd+LcN4=;
        b=tczGKQoJghaHRDqFh1SqYZLxDV5JcT130cXwUDKEzsYVvlTazV9xO4JCYcOl28uS6I
         +E0p/H8ZfXFzxrvFAdBJLepHcm7ph7LxQCmW9/ZfEDme+8k/3AFVCk4TTaNA7UOYUpog
         opZLRR9eUlEUDZxJ16CAmCSaoAlWTR6JNriKCWfGcvcAO+8hkUMKUCEXa4DCzEnC8ZW+
         7IGGm4poHeH52fhaxmCJTbEHQJEYAhth7XDkH9emTe0Pp1Sd2ku10G5YIwmTIVwp1dSK
         w9xS40JAoBhbff20Fad/aPYTC1s26ww4XI6syfnj3mIO6pO3pn4DwYM98GenvPxesTZL
         vqBw==
X-Gm-Message-State: AOAM532qrnhDmd/ynBPBXWl9XWZ5UWf/5WY4AXk4nP0fbPwSUfJN6b7S
	fgMBwKvyQkqJFATwD6OoyYZeJU7T1g6y3507qtxNag==
X-Google-Smtp-Source: ABdhPJwZgyZD9DAvRTvevIrwihPTON7uK5jWWLxrkR+Wnn2HSb0H7RhPgRrIgLYR899I6nP8mpJ+rzybzF2sMZbacI0=
X-Received: by 2002:a05:6512:79:: with SMTP id i25mr660173lfo.549.1611595095275;
 Mon, 25 Jan 2021 09:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20210121122723.3446-1-rppt@kernel.org> <20210121122723.3446-9-rppt@kernel.org>
 <20210125161706.GE308988@casper.infradead.org>
In-Reply-To: <20210125161706.GE308988@casper.infradead.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 25 Jan 2021 09:18:04 -0800
Message-ID: <CALvZod7rn_5oXT6Z+iRCeMX_iMRO9G_8FnwSRGpJJwyBz5Wpnw@mail.gmail.com>
Subject: Re: [PATCH v16 08/11] secretmem: add memcg accounting
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: AVYL7CAUIOEQPLMGXTQSYPILH2RB2DBG
X-Message-ID-Hash: AVYL7CAUIOEQPLMGXTQSYPILH2RB2DBG
X-MailFrom: shakeelb@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <w
 ill@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AVYL7CAUIOEQPLMGXTQSYPILH2RB2DBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 25, 2021 at 8:20 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 21, 2021 at 02:27:20PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Account memory consumed by secretmem to memcg. The accounting is updated
> > when the memory is actually allocated and freed.
>
> I think this is wrong.  It fails to account subsequent allocators from
> the same PMD.  If you want to track like this, you need separate pools
> per memcg.
>

Are these secretmem pools shared between different jobs/memcgs?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
