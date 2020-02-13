Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B515CD29
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 22:21:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10F3110FC33F6;
	Thu, 13 Feb 2020 13:24:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D25E10FC33F3
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:24:43 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 77so7057144oty.6
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGsKTwmXZKkhgFvhpGRDEU0YJwm0F82TSOoNgccUJWs=;
        b=EFwrmKlscNSkDz4PTNnaFK6o1tRIerj9Wx3vR0EhvSuOklj8Fl892cSjNi+1vE1SEi
         A8W2LUABtLqi3ObjLd4VB8bVDo+ya3e2tAzUF5bsBfw0mtEkI9BW0L1BQz1D0191ZZP8
         fNwmyD4ePeGipnp5V7F5jXPWHbSOeA47W3GOVyHrZijfg6pUEJhoHpiKiGgD7J3X9aOc
         gITLUZ0Bi4G8tZyBJKXoFVMjdz+z/HGwDwHOlbKjI5ESfr4OaRt9hupuUFU6p7tytw0T
         gY5D4jtOeDKfWyEXKADwn0Bqc8nZZjFZkvTbUHQB8OsEKz/ja0Ho/BzmgrpU3kgH0N8A
         fYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGsKTwmXZKkhgFvhpGRDEU0YJwm0F82TSOoNgccUJWs=;
        b=tHPb2O+5ik08lMrZqDEhNovgVx7zHjm2NX8sNvaPi4G4H2I7zAaZtOR8u9VyhDH4Kr
         1AcWpD5PKSq2fZqFQfELqLDWevt6e6Sr4BOJ/bA5K/lJVdQPniv0SQCjANqTB0DRWxjr
         +SWEHxsGy1EMK6Tq6VH+qDxPDfGrXdM2sFrIaO1qKjXZWdx28eT9XTP7saEU/584PdqY
         tomfT6YSY2bWX4rxBhmEozOcukxy5LvkDwPsKmnshFbiwwt39p5Jxr1ixvddckkwEKQn
         UU6UtNRQdRVAhWdrSGILUCs0IB3R6LUssNOODLXZWHGAi+WAz/kiWQgdfiVGDTtESRib
         P43w==
X-Gm-Message-State: APjAAAV4VoTjWe0/hA1POgSwpOZZnjgY6rGNvJkPOMq1dkY8RjYqVe86
	il3tHNTlHdO4UzJ6iu7heRGqPUSd5zw3zOqLev5TEw==
X-Google-Smtp-Source: APXvYqxqSR6Goyr2KCN3goF6e96KcdmhwnR4SgD29bhp+Sk6iKS8Im4RLkbyZSHY/3GL5iAhFPf2ezlKNv406KBKVUI=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr8517375oti.207.1581628885704;
 Thu, 13 Feb 2020 13:21:25 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
 <877e0q3f68.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877e0q3f68.fsf@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 13:21:14 -0800
Message-ID: <CAPcyv4gNYS_MCF9PgMUFfC-WChbk3VJF8qkNUV4wGaLk0SjL0g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: FD5YI7BBUBC5J4OG7H6K3EBMZBIAA4YQ
X-Message-ID-Hash: FD5YI7BBUBC5J4OG7H6K3EBMZBIAA4YQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FD5YI7BBUBC5J4OG7H6K3EBMZBIAA4YQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2020 at 3:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > +#ifdef CONFIG_KEEP_NUMA
> > +#define __initdata_numa
> > +#else
> > +#define __initdata_numa __initdata
> > +#endif
>
> TBH, I find this conditional annotation mightingly confusing.
>
> __initdata_numa still suggest that this is __initdata, just a different
> section and some extra rules or whatever.
>
> Something like __initdata_or_keepnuma (sorry I could not come up with
> something prettier, but you get the idea.

Yes, and to dovetail with Ingo's feedback I think
__initdata_or_meminfo conveys it's optionally init vs runtime data.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
