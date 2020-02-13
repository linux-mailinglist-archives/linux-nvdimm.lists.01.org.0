Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3015CD66
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 22:40:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6866D10FC33F7;
	Thu, 13 Feb 2020 13:43:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C79A210FC33F6
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:43:40 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 59so7098239otp.12
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTv9gN6I6yzih5qKCBcYKwo2e18uwbHe8iXC38+9hd0=;
        b=pOLKBGFdDmsjxxfsFb1e7iJQtMQ7g+GGM3cpiCIvN06JvANWBupzho8YYBSAAbeKaY
         Zla3c948sXHK4kc/W0U68fIEojXwyz/BhRmi0DHOh7I/TrksghWSyuAfEqqILp7fTJkc
         aiisRybHg46rfa447mtqBqwCp6mBjdbMwcSXEw1oe8ki4SBgbMPUyDMlyVlImCGC+Q1W
         cnDG83FfPU5WEldM8Od9jZauR50FdGvRpB6FFFutJtRLguIojSNyJ5mzr1o7nQ2AYNbX
         tLz7cet7HxsV1Fj7UFt8lZOYf4ibR9GrjIXtTipstk+tMM13uqbl3qugjZvJi1TE/Dn1
         42Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTv9gN6I6yzih5qKCBcYKwo2e18uwbHe8iXC38+9hd0=;
        b=h5+O2mJnpbqJAbcpkWV3qvLqyj5Xyuc043VD9iz/ydBKwC3zfWFY9eAgL8piPim+eR
         QhZudsnArM1GGuG1l9veeI0qU7L7JsC5DLKu0LU71URaLamQ1/8pqszHhdbdJo1WpSCV
         qrc+TfeVXMzptSGSit9uGk36wdYA510zIP/DdspAPl32baUaK0kxxWUkhPWKd3wU1eSQ
         sywg0ByliVJaRqH2IfLhIh4U8S74GNJKPrFa0d01y9h1RqaIozLA4uTRWyiqEePYcbXY
         yC7+faZOW+snQjBGlzp4VyqHyqsk4zTai+zvp7TQKMoWx9v/iOuQGGaQ9cH5gxxLt6HU
         fUZg==
X-Gm-Message-State: APjAAAV5xW6CKfTKT1zD/1cgP+Wu7wKZt9+6qOvmypBpC0n2FeIm7WV2
	7jxA3R+2nQohgVyHDe5jOgu42kZ7TtwVB8wKhwCaYw==
X-Google-Smtp-Source: APXvYqw5aEfUpyFTQZazSkVeOJDzHTwzm+wOG5KP2AGcBjkKirUZiP9tAackQuvwRLWXumQcnRB+P+mYdWGMw5tsiJg=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr8569240oti.207.1581630022932;
 Thu, 13 Feb 2020 13:40:22 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
 <874kvu3egp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kvu3egp.fsf@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 13:40:12 -0800
Message-ID: <CAPcyv4gDnbTss7cAph4vyiO2R5cJeACOReTgzafoT6iHxsR6Ew@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup facility
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: QO4CUNH7XSOAGDAKAY3O7V2HA5DMPZCF
X-Message-ID-Hash: QO4CUNH7XSOAGDAKAY3O7V2HA5DMPZCF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QO4CUNH7XSOAGDAKAY3O7V2HA5DMPZCF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2020 at 3:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > +/**
> > + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> > + * @dst: numa_meminfo to move block to
> > + * @idx: Index of memblk to remove
> > + * @src: numa_meminfo to remove memblk from
> > + *
> > + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> > + * @dst->nr_blks, then remove it from @src.
>
> This is not correct. It's suggesting that these operations are only
> happening when @dst is non-NULL. Remove is unconditional though.
>
> Also this is called with &numa_reserved_meminfo as @dst argument, which is:
>
> > +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
>
> So how would @dst ever be NULL?

Ugh, something I should have caught. An earlier version of this patch
optionally defined numa_reserved_meminfo [1], but I later switched to
the current / cleaner __initdata_or_meminfo scheme. Will clean this
up.

[1]: https://lore.kernel.org/linux-mm/157309907296.1582359.7986676987778026949.stgit@dwillia2-desk3.amr.corp.intel.com/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
