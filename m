Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C9123D93F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 12:27:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD19212BCD29D;
	Thu,  6 Aug 2020 03:27:53 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=kirill@shutemov.name; receiver=<UNKNOWN> 
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6DCD12BCD29C
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 03:27:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so16394645ljn.2
        for <linux-nvdimm@lists.01.org>; Thu, 06 Aug 2020 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=q44JM/MhPtGS1X8CEtdPT8jY1IsznRmL/EUJCRVKZ0SQjpJuKmiF3MRSg0V201k6/0
         7wdleRwGXgcpS6GBcJQn3aN4+K1pHDGZuvFRDvTF9APAIhXb+a2xl9Jp+eur4UHwQKOG
         a+RLO7aCLHiHjNUkqDHv3KHpAByqNpYKygFYVYfjG2rDRNZ1boVJjHid9G6QxHXMRDHj
         lxu6G5SWy3EMKBtlkZJxRZeLycn9DXYVVNUnw64xSNl8FhKmMBKmB/5GaDUrg6bknGVy
         69EcKcUZE3qqrUPWzoTffaHacemMJWCOZb/G6QEBjYa8rAKMuVSkNGFwC876gdtvvS/j
         Xp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=Jduh8YvGE1HI0+G2Va7m9qh11cG71lmL6SxsOgtDQBh9IuorYd9NjgCpnFjktA558D
         +ooJNr7DmLbe6rKPxsnZ/Ynp+6XT2Ql7jaocvlkOwCSHc74ln1emnb1c9qo8KBvLk0Bx
         EmYx+jVL+7lFBwtdj4lHXUZbNM8+sUQSMhOISqpL5h0xe7lj+xOPtRcqsc3lgVA4AUWR
         jSvQ/X+brBXivgqtje+Y9M0s/Li43FRKZOq24XukPRNwBlyHgqprMx4fEtmok/qyyCwo
         Uf7YtOKRgK8kw5Y5N48AR31e2vDEjRdIc3c8l5qMe1Fc+Z4MBMYPLYRHFqT4cIqIG6d1
         zo0A==
X-Gm-Message-State: AOAM531uqX20YA8Il2htRVdKT+2Y9ukQ6qO4qur09bPXZkWzJW3NAqB1
	O8LqmNN51aT6DsG9rvV5Lmi/Jw==
X-Google-Smtp-Source: ABdhPJwKs0kOBphzk4nhXY72GuBZVVKvwfIRMs8kMWmC7io4Zo82tk1RHZ72Ob2Qcz50sTYcK1DvmA==
X-Received: by 2002:a05:651c:201b:: with SMTP id s27mr3653296ljo.468.1596709669841;
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18sm2208204ljk.7.2020.08.06.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
	id 80A47102E1B; Thu,  6 Aug 2020 13:27:57 +0300 (+03)
Date: Thu, 6 Aug 2020 13:27:57 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200806102757.7vobcaewdukr2xdl@box>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804095035.18778-4-rppt@kernel.org>
Message-ID-Hash: QMCAYPGG4X6T64OTIBEKNYRT2I2TGJGA
X-Message-ID-Hash: QMCAYPGG4X6T64OTIBEKNYRT2I2TGJGA
X-MailFrom: kirill@shutemov.name
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdev
 el@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QMCAYPGG4X6T64OTIBEKNYRT2I2TGJGA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 04, 2020 at 12:50:32PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> The user will create a file descriptor using the memfd_secret() system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
> 
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.

I'm not sure why flag for exclusive mode is needed. It has to be default.
And if you want uncached on top of that set the flag.
What am I missing?

-- 
 Kirill A. Shutemov
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
