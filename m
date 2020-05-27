Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E021E4C41
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 19:45:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F90212241857;
	Wed, 27 May 2020 10:41:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7050A12241856
	for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 10:41:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so29077230ejd.8
        for <linux-nvdimm@lists.01.org>; Wed, 27 May 2020 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mFtPr70+M6apdHwECQwtE0zBIswHryRWPxkV/RNuy4=;
        b=dvDvQkJQFI8yWa2awybOsZrnFGgmcqFM7ZW4rJz0zjtlx9s5xgduk+OM2lc7nFfjCo
         c6Vz/iUvE0DfRgVV8SbSVoTXQXQ0YkZok9A0AcjzfZBwT7RKbjwXU4ELIKGZQStewJmz
         kknihChozQhZ/pQ1tJ0hEKMYQq7b7X7ggStktoC+sFL9O5rM300uiKvwtj8+HhR2zmvF
         Jt8Sa02KiuYawH9lV3OB5Lv0XI4o4N8/YWfD1IIinggWKQj3PAk/vq+0MWxl8fLsc4Hy
         KkfBO7OGsIxqdFboM3JUWjhvWxCNRHxD/Pm6nPrxZ79lem0gPlqNHUEYAtaF7FUfRBhN
         54Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mFtPr70+M6apdHwECQwtE0zBIswHryRWPxkV/RNuy4=;
        b=brEzQkasEMIM6JzHYevh5o9p2DXhME58fH3X2daN6OjwWyamqX0TNuZSSliIr+jqao
         mZCDFr4ccDmL7za4eSxNdu6CrouSgCtgD3yQclf6kj1f6cGhgDnqxbRecJR2Hl5YDRJ9
         buyUrE+GmJgROBSrJA8m2rBiNqu2l3k5rZDB0MCKVCTuNN1BNwKS9snhh8uHVIf49B9D
         ksprba2Qd7aLcfhDUrDSR+vPTlU21wflR6nqfprTsOu9Wu+xfDfOPEKSAK9dVestUw04
         O2hIm3+UuVWDq9YThzEnmLwndaytRr0dZrWrXTp//U33tIOGmdKodJh4LsuEyIDJ4XVT
         qTAw==
X-Gm-Message-State: AOAM531l0gqeSIZD7K2Rvy2A8sNG6Bmno0ir58wsDI5nvxYJlB7yjHJ8
	Zna0jMs43FVrn4WqJI9Jgpp7C+cIUR6vp/w7Shwr6Q==
X-Google-Smtp-Source: ABdhPJyTjA/zTkYCTIHeH9PsmBKXEZoxnZzzLtoLEydIvlAGMECI+VKgrxr/M1xDJHkM9rV+v4IRpxyHFaY0PLCjndg=
X-Received: by 2002:a17:906:3597:: with SMTP id o23mr7022104ejb.174.1590601516095;
 Wed, 27 May 2020 10:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <159010126119.975921.6614194205409771984.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159010126739.975921.6393757191247357952.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87mu5yg8n6.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mu5yg8n6.fsf@mpe.ellerman.id.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 May 2020 10:45:05 -0700
Message-ID: <CAPcyv4h6moXY0fB=cyGuXOpT=+rFWupCy0kh87OT0X_1ZB2ROg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86, powerpc: Rename memcpy_mcsafe() to
 copy_mc_to_{user, kernel}()
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID-Hash: 4SIDTVVK7XCT7WZ6456WSUXPEN5SQHAK
X-Message-ID-Hash: 4SIDTVVK7XCT7WZ6456WSUXPEN5SQHAK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Mikulas Patocka <mpatocka@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4SIDTVVK7XCT7WZ6456WSUXPEN5SQHAK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, May 23, 2020 at 5:04 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Dan,
>
> Sorry one minor nit below.
>
> Dan Williams <dan.j.williams@intel.com> writes:
> > diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
> > index ddaf140b8255..1152bcc819fe 100644
> > --- a/tools/testing/selftests/powerpc/copyloops/.gitignore
> > +++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
> > @@ -12,4 +12,4 @@ memcpy_p7_t1
> >  copyuser_64_exc_t0
> >  copyuser_64_exc_t1
> >  copyuser_64_exc_t2
> > -memcpy_mcsafe_64
> > +copy_mc_to_user
>
> Should be:
>
> +copy_mc_64
>
> Otherwise the powerpc bits look good to me.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Will update, thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
