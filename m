Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8181DB81A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 May 2020 17:25:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A58A311D77B8B;
	Wed, 20 May 2020 08:22:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B579D11D77B88
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 08:22:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id yc10so4282575ejb.12
        for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmgOIn7CLKu0/cluJFaG5idJvO1nymi+j4c/I4o6A5Y=;
        b=Qgy/XtcHoi9ZAcx9KfXpQh1hEMUZwd60c5Tc6HwImodikXHQ3WWjJddr3duPA+g0aJ
         IOm8S1DosmIyQDxFSiWLzeKIgkYBUuhMHCkWT0Bxb21CIz1zs+LmyTbV0XH+FPGEflMn
         i2NOLSwhV0pWln/dtffguH47aDwfE2Oa65KFVm7XT/cPVxp/Uv0qKK98Wva5QdhTlUYA
         SZRi6yhKIWkwWAbF5vEb2MIxNt9+J6hcwHvrbERPeLuaR4vRBenWMILZDxISaQ9EdxgH
         0966BZYXXprTJAgdtoPxbqoK1oDe0+mJv5OXr5X3SQTtN9mgWJbAPsCWpLAUYT/wALPf
         EsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmgOIn7CLKu0/cluJFaG5idJvO1nymi+j4c/I4o6A5Y=;
        b=g19cizK6AGLGxTo9chlf1xOmTq9/lL89xjTv1B0icSJlqAd5a0zZAG1pXmCxmNHVaw
         Bvr4CCz6vYgujndK8QyINW1f89oZtG2YDOb2MWRqwnTXV+uZT/ndpafVFu43NPVdK2ae
         Zn6/63L3/4M5lU9VSfdFhpolsVM3kwCY7rHLtrnLz/hxE+YJdm+exD/51Z63bu3fO7wx
         /OGOZSmKC9zGWQRzIhf6LnHFf6+WR0Ay+lmTlKCWBgZFxLmrdTeSkWwEA8RGyR1TyaxH
         SxN4vfNTBJpFjqCb7FibT2KomtCNdLwLpX0HBKiiD4ivkthZhoTPqy6+Nm5FdPfK88Zg
         QcRQ==
X-Gm-Message-State: AOAM531tU8mof6S6AiuGK8dJiAHRvgQjuPvoXPJS4PD9YhuWtZSnBohs
	aPUvS4RDFIKfNZ7PUlNJzKe17chzMaNhEiG2mu3Smw==
X-Google-Smtp-Source: ABdhPJxKctA75G7J/qj6W53QptYi2MZiZGA/evgiJh+TTmSwgPpMWJZVUfO6u+1qqh8vaK8Uz54Ei0uURfXf108uvpU=
X-Received: by 2002:a17:906:ff54:: with SMTP id zo20mr4065711ejb.124.1589988353659;
 Wed, 20 May 2020 08:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <158992635164.403910.2616621400995359522.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158992635697.403910.6957168747147028694.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87d06z7x1a.fsf@mpe.ellerman.id.au>
In-Reply-To: <87d06z7x1a.fsf@mpe.ellerman.id.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 May 2020 08:25:42 -0700
Message-ID: <CAPcyv4igM-jK6OkPzd91ur_fNCaUxwbWTHhwWsWe-PJNjZdWGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID-Hash: CBECHTS4VZYXUSVTJ3DJC25VEOJYZIVD
X-Message-ID-Hash: CBECHTS4VZYXUSVTJ3DJC25VEOJYZIVD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CBECHTS4VZYXUSVTJ3DJC25VEOJYZIVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2020 at 2:54 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Dan,
>
> Just a couple of minor things ...
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > In reaction to a proposal to introduce a memcpy_mcsafe_fast()
> > implementation Linus points out that memcpy_mcsafe() is poorly named
> > relative to communicating the scope of the interface. Specifically what
> > addresses are valid to pass as source, destination, and what faults /
> > exceptions are handled. Of particular concern is that even though x86
> > might be able to handle the semantics of copy_mc_to_user() with its
> > common copy_user_generic() implementation other archs likely need / want
> > an explicit path for this case:
> ...
>
> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> > index 0969285996cb..dcbbcbf3552c 100644
> > --- a/arch/powerpc/include/asm/uaccess.h
> > +++ b/arch/powerpc/include/asm/uaccess.h
> > @@ -348,6 +348,32 @@ do {                                                             \
> >  extern unsigned long __copy_tofrom_user(void __user *to,
> >               const void __user *from, unsigned long size);
> >
> > +#ifdef CONFIG_ARCH_HAS_COPY_MC
> > +extern unsigned long __must_check
>
> We try not to add extern in headers anymore.

Ok, I was doing the copy-pasta dance, but I'll remove this.

>
> > +copy_mc_generic(void *to, const void *from, unsigned long size);
> > +
> > +static inline unsigned long __must_check
> > +copy_mc_to_kernel(void *to, const void *from, unsigned long size)
> > +{
> > +     return copy_mc_generic(to, from, size);
> > +}
> > +#define copy_mc_to_kernel copy_mc_to_kernel
> > +
> > +static inline unsigned long __must_check
> > +copy_mc_to_user(void __user *to, const void *from, unsigned long n)
> > +{
> > +     if (likely(check_copy_size(from, n, true))) {
> > +             if (access_ok(to, n)) {
> > +                     allow_write_to_user(to, n);
> > +                     n = copy_mc_generic((void *)to, from, n);
> > +                     prevent_write_to_user(to, n);
> > +             }
> > +     }
> > +
> > +     return n;
> > +}
> > +#endif
>
> Otherwise that looks fine.

Cool.

>
> ...
>
> > diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
> > index 0917983a1c78..959817e7567c 100644
> > --- a/tools/testing/selftests/powerpc/copyloops/Makefile
> > +++ b/tools/testing/selftests/powerpc/copyloops/Makefile
> > @@ -45,9 +45,9 @@ $(OUTPUT)/memcpy_p7_t%:     memcpy_power7.S $(EXTRA_SOURCES)
> >               -D SELFTEST_CASE=$(subst memcpy_p7_t,,$(notdir $@)) \
> >               -o $@ $^
> >
> > -$(OUTPUT)/memcpy_mcsafe_64: memcpy_mcsafe_64.S $(EXTRA_SOURCES)
> > +$(OUTPUT)/copy_mc: copy_mc.S $(EXTRA_SOURCES)
> >       $(CC) $(CPPFLAGS) $(CFLAGS) \
> > -             -D COPY_LOOP=test_memcpy_mcsafe \
> > +             -D COPY_LOOP=test_copy_mc \

Ok.

>
> This needs a fixup:
>
> diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
> index 959817e7567c..b4eb5c4c6858 100644
> --- a/tools/testing/selftests/powerpc/copyloops/Makefile
> +++ b/tools/testing/selftests/powerpc/copyloops/Makefile
> @@ -47,7 +47,7 @@ $(OUTPUT)/memcpy_p7_t%:       memcpy_power7.S $(EXTRA_SOURCES)
>
>  $(OUTPUT)/copy_mc: copy_mc.S $(EXTRA_SOURCES)
>         $(CC) $(CPPFLAGS) $(CFLAGS) \
> -               -D COPY_LOOP=test_copy_mc \
> +               -D COPY_LOOP=test_copy_mc_generic \
>                 -o $@ $^
>
>  $(OUTPUT)/copyuser_64_exc_t%: copyuser_64.S exc_validate.c ../harness.c \
>
>
> >               -o $@ $^
> >
> >  $(OUTPUT)/copyuser_64_exc_t%: copyuser_64.S exc_validate.c ../harness.c \
> > diff --git a/tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S b/tools/testing/selftests/powerpc/copyloops/copy_mc.S
> > similarity index 100%
> > rename from tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S
> > rename to tools/testing/selftests/powerpc/copyloops/copy_mc.S
>
> This file is a symlink to the file in arch/powerpc/lib, so the name of
> the link needs updating, as well as the target.
>
> Also is there a reason you dropped the "_64"? It would make most sense
> to keep it I think, as then the file in selftests and the file in arch/
> have the same name.
>
> If you want to keep the copy_mc.S name it needs the diff below. Though
> as I said I think it would be better to use copy_mc_64.S.

copy_mc_64.S looks good to me.

Thanks Michael!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
