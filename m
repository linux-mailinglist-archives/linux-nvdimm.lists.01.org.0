Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EA920EF21
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 09:16:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71838111FF496;
	Tue, 30 Jun 2020 00:16:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED2E1111F3707
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 00:16:40 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so14939914edm.4
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cj4l0FfWIZexrEyJBVaXKE1UP+4gVH5S5DhnnxEjqJg=;
        b=BeT+2qC6v1slqT3X6EG8MZlgYKAnJOcKbod3ySHD15gfDykCMrkKrOgG357yc/H9fc
         gEpyLIIXyjbjIj6PHBsS9XDPCzRs2t1w0Rvb99ed8tXm69KDpzbYRV3wHbvAJdcoXQJ2
         HvYRvlEaPJWfCfJ7MkI00pb9ZjMbMzqMEAv0gdS8yN8iyQkyX7AuGFHw77eYVyfTgvk2
         yaORzXp6ghCWz5zo/BusxYAae+nKeyVbW9opyOKXKghrbqEpiUtOA3UW06g/IIakUqFK
         12l+2IoAfsx0zAoDWNIzJsOoP9HHJ2ic4eye0n79MPx3UR/NWoNdE89zJlE/L3pHTYKE
         Bksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj4l0FfWIZexrEyJBVaXKE1UP+4gVH5S5DhnnxEjqJg=;
        b=mq0c9uPjakoDbHQA4FkgJKCCaGjkLJza+C5OH5U2U/zwHrDbewfz0fjJUeRzQQvrnV
         CKuMTLsEZHiplyDbBGm5rLiX9xaoyPfxhIeLtFmyvlT1P0RVXz1VJ2QH0LAsbvgeP2Vn
         S8GOgd1snvJVgKYndowDaW5gMVg06Pqg/E+fvoAY3/YnHymCMOgmYW07P3jAK9lPdV1a
         1aPtMED0WOf3xl+ZWkt1laqpklPeqwVIMN64DyBECSKFeechzEcT+e3h3NGiVaABGh/e
         srmG37HqyxFq88O6+VE0JKL675JZAHOV/tB/xNh0XSvyu2KlWhurqr/crEpwKXfeuTzW
         o1Kg==
X-Gm-Message-State: AOAM530Gh29Cv8AjIisv/39Bsunc60dx0Lwi/KLmwZ3urGe3DTH/wp7T
	55ZaRbfiOw81sia3Sj4KbWGa7HqgbjFJSlh0a2bsUg==
X-Google-Smtp-Source: ABdhPJyS8XmrSmjalkHZfnt48YECQbiEpYZIAu0UqS/vLFSq79Y4Mnzjv0etdc0fSJ0YLr8yDJL8qU4W0uJHgKnu9CA=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr22349682edo.102.1593501399478;
 Tue, 30 Jun 2020 00:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-6-aneesh.kumar@linux.ibm.com> <CAPcyv4hFfU0r0GmCgV-wKXq+H=GDV-OPsGNPWmFijrdWm58X_A@mail.gmail.com>
 <87ftadgn3r.fsf@linux.ibm.com>
In-Reply-To: <87ftadgn3r.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jun 2020 00:16:28 -0700
Message-ID: <CAPcyv4iuSm40=8qnSKNZxhN5pD_VLra2Qf4iYSwkZfPE5uqkjw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] powerpc/pmem/of_pmem: Update of_pmem to use the
 new barrier instruction.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: 5V4ZSU2O6PELYABB2M3V2MUHYV4QTUIZ
X-Message-ID-Hash: 5V4ZSU2O6PELYABB2M3V2MUHYV4QTUIZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5V4ZSU2O6PELYABB2M3V2MUHYV4QTUIZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 10:05 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Mon, Jun 29, 2020 at 6:58 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> of_pmem on POWER10 can now use phwsync instead of hwsync to ensure
> >> all previous writes are architecturally visible for the platform
> >> buffer flush.
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/cacheflush.h | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> >> index 54764c6e922d..95782f77d768 100644
> >> --- a/arch/powerpc/include/asm/cacheflush.h
> >> +++ b/arch/powerpc/include/asm/cacheflush.h
> >> @@ -98,6 +98,13 @@ static inline void invalidate_dcache_range(unsigned long start,
> >>         mb();   /* sync */
> >>  }
> >>
> >> +#define arch_pmem_flush_barrier arch_pmem_flush_barrier
> >> +static inline void  arch_pmem_flush_barrier(void)
> >> +{
> >> +       if (cpu_has_feature(CPU_FTR_ARCH_207S))
> >> +               asm volatile(PPC_PHWSYNC ::: "memory");
> >
> > Shouldn't this fallback to a compatible store-fence in an else statement?
>
> The idea was to avoid calling this on anything else. We ensure that by
> making sure that pmem devices are not initialized on systems without that
> cpu feature. Patch 1 does that. Also, the last patch adds a WARN_ON() to
> catch the usage of this outside pmem devices and on systems without that
> cpu feature.

If patch1 handles this why re-check the cpu-feature in this helper? If
the intent is for these routines to be generic why not have them fall
back to the P8 barrier instructions for example like x86 clwb(). Any
kernel code can call it, and it falls back to a compatible clflush()
call on older cpus. I otherwise don't get the point of patch7.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
