Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1C274DCF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 02:27:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECA29148EAD16;
	Tue, 22 Sep 2020 17:26:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DD4A1486BC3B
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 17:26:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u21so25394947eja.2
        for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVimv4F4pEyqaeD0LO4zdEDOLVsHvqmHuDl7JJ50ulQ=;
        b=egeCKs17gt8CwPK7u6srOHG8/XtUaR57acvx0TxFQN4OgfTewTTwNVhJ3xelSuchN5
         dH/v0TdAhVjm1OyK8YI/T1+nqHAvQGirk70/PXrjkrdJstF0zEVxO5EnN1TxNqfCZaIs
         sVFUFHg41vJCFF8sHTLjyTKmBQc6j+DXLyARf1yKv3ipC/84wjQsbZkM+FPiwArDH8cJ
         bKSG7LvIosF6KjiHPL5OTU7DIEfS5cCFKMjLfJ3X4RvlJz61N2TQQVaxEsdJ9C8UZ2Ss
         6EcJmIO8EzYqFXjqs1VH/T6FFOBJAM/zJ/HxZwB4JnNx4mM4AmtxRYYLWa/cjUZee6+T
         Cwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVimv4F4pEyqaeD0LO4zdEDOLVsHvqmHuDl7JJ50ulQ=;
        b=LG6bFGERkFp3kX5qQKK32E10XaiGrQXCwSocNc3lNZsju+vOeTJApE8huzy7TalegF
         JKLV608XAocwZPBPN9Jv7Cah/LWqEL4YYuvrpWoQ9ni5TQZM8elTUNP0sBfqNQpzCM0h
         PdGOJoOxog2AojZ+cUPOInT4yn1gRxrvqV0Lsx1idWDgApq/LfzQBfEnRjqecCxU1EVx
         5dfbUWH7JEvbUEm7ZvUkZaCWZ0FFchZaT+0Zge85iOElWv4Sl5GppUhMAg2+1WelwFO4
         wL1q4JitweIaZ4A2Xb+FEjkx2s5tP9ffKFbxQH1J7+r1+HpQZfJxFN/vsD6OeYte/fEB
         ZK+w==
X-Gm-Message-State: AOAM530rFpq41d5j9iZaencGZi8E4Bnloco9FZ6nqck9K5w2ykrqz2Dy
	655Qydsx4hTAb3j3+/A4O8BgFDMuLlEdAgpeF3+kQw==
X-Google-Smtp-Source: ABdhPJzMI1hBpS5IYBJf0bWw0qKhmM688XSDWbxykQZ6wRaR8yLKTmjvfdk/TFFeszIL860KBJljCLyAkyMM+SAS30U=
X-Received: by 2002:a17:906:2354:: with SMTP id m20mr7460553eja.341.1600820812915;
 Tue, 22 Sep 2020 17:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <159630256804.3143511.8894023468833792004.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200803094257.GA23458@shao2-debian> <20200806133452.GA2077191@gmail.com>
 <CAPcyv4hS7K0Arrd+C0LhjrFH=yGJf3g55_WkHOET4z58AcWrJw@mail.gmail.com> <20200806153500.GC2131635@gmail.com>
In-Reply-To: <20200806153500.GC2131635@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Sep 2020 17:26:41 -0700
Message-ID: <CAPcyv4jk8TRDSJVmN_sAbqkHAQa4gvE2_k4Vrg1aUOikX44yMA@mail.gmail.com>
Subject: Re: [x86/copy_mc] a0ac629ebe: fio.read_iops -43.3% regression
To: Ingo Molnar <mingo@kernel.org>
Message-ID-Hash: 5FJO4ONT44IEXJ2M2XEF6HNOMZGRNPPK
X-Message-ID-Hash: 5FJO4ONT44IEXJ2M2XEF6HNOMZGRNPPK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kernel test robot <rong.a.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 0day robot <lkp@intel.com>, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5FJO4ONT44IEXJ2M2XEF6HNOMZGRNPPK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 6, 2020 at 8:35 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Aug 6, 2020 at 6:35 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * kernel test robot <rong.a.chen@intel.com> wrote:
> > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -43.3% regression of fio.read_iops due to commit:
> > > >
> > > >
> > > > commit: a0ac629ebe7b3d248cb93807782a00d9142fdb98 ("x86/copy_mc: Introduce copy_mc_generic()")
> > > > url: https://github.com/0day-ci/linux/commits/Dan-Williams/Renovate-memcpy_mcsafe-with-copy_mc_to_-user-kernel/20200802-014046
> > > >
> > > >
> > > > in testcase: fio-basic
> > > > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
> > > > with following parameters:
> > >
> > > So this performance regression, if it isn't a spurious result, looks
> > > concerning. Is this expected?
> >
> > This is not expected and I think delays these patches until I'm back
> > from leave in a few weeks. I know that we might lose some inlining
> > effect due to replacing native memcpy, but I did not expect it would
> > have an impact like this. In my testing I was seeing a performance
> > improvement from replacing the careful / open-coded copy with rep;
> > mov;, which increases the surprise of this result.
>
> It would be nice to double check this on the kernel-test-robot side as
> well, to make sure it's not a false positive.

Circling back to this, I found the bug. This incremental patch nearly
doubles the iops in the case when copy_mc_fragile() is enabled because
it was turning around and redoing the copy with copy_mc_generic(). So
this would have been a regression for existing systems that indicate
that "carefu/fragilel" copying can avoid some PCC=1 machine checks. My
performance checkout was comparing copy_mc_fragile() and
copy_mc_generic() in isolation. Refreshed patches inbound.

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 9e6fac1ab72e..afac844c8f45 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -58,7 +58,8 @@ copy_mc_to_user(void *to, const void *from, unsigned len)
        __uaccess_begin();
        if (static_branch_unlikely(&copy_mc_fragile_key))
                ret = copy_mc_fragile(to, from, len);
-       ret = copy_mc_generic(to, from, len);
+       else
+               ret = copy_mc_generic(to, from, len);
        __uaccess_end();
        return ret;
 }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
