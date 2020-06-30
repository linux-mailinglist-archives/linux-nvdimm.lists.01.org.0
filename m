Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7720EAFE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 03:38:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A7C6111FF492;
	Mon, 29 Jun 2020 18:38:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E3B5111FF491
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:38:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so14698121edz.0
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93WBccPUu2ioEuQh2U0k1LEPpKIIzjUs7yzbc4BAlR0=;
        b=tIWvWILltP5OLWO1yEnYuelKoTVtBMt15QHCaV9NsTuEhz/McXz8h0EYx4YkES3ec+
         DvrcwCBGoiFSJwjLCNVGaVAv0V3CwnNLqQrLzS0giZSkTL+KMSzCrpNy2jD7HMFtjj16
         czDIQESEy50oLl2RJf3bNhMhpQ9ZYHGiawo42NNDG+yMBYqAVmyUayCAqC2ofqf+dsWJ
         pesGY44iqJV+Uk6u2Qvx5iW7RndA/++6fd0zNNe/L1M0eumPNWcGoTdI6th0yosd1ANQ
         UUcANoJ/jX4zRtPvdTdH1KjXEdEYHPW5Y+dWdsmfCE0qLzroE7yzEhpAUnjzXdQ14hDv
         lFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93WBccPUu2ioEuQh2U0k1LEPpKIIzjUs7yzbc4BAlR0=;
        b=N5OX/yUAJdWSMJIiVhJYcufXU4Vhp9949UdQrFD76PzpPWAIO2LxdzLLvbFxXMe3ji
         rY33kZBW96NNeDLbYW15E10bap9D+K8n5o4hMAKDXxwra0DzGAemABl1SIR7AfFEEqL6
         oePUKizQOJRgJAJldSWzDabBLJw0Ur+Cl+WR7dAJ/cyx8ECcw8cTGh8C8Ho+msAxlJrI
         o01J3Uw2F9lWk1SD3CkQcQNyKvxrxCGhUHD/S/r689WUJsRdHPv1Y0ckrBGfUlK4RIJS
         DKBV7dnddYWZpoq8KAAPcVlePRLm7pOwHYVnuKpqmat3CGEG0SvCXGCdV3qgg1OQbhWz
         xuEw==
X-Gm-Message-State: AOAM532zd+EAR01b39jNoQlBuECa3r29Qz8pS6Wvncdjzki4TN7sWvwR
	314LjUBn9z4LgwsJO/oFleFeQZsRQCV9NiOs0V2lsnwD
X-Google-Smtp-Source: ABdhPJz3PGEadKCW+KfEBrrRxT0/x9Ul9Ee6SKWlBeVrAe8PQ6lTxFMyy6xXUea7GIsBQT2aTJQ7eBLlC3PyeYQNFqY=
X-Received: by 2002:a05:6402:21c2:: with SMTP id bi2mr20337739edb.296.1593481093994;
 Mon, 29 Jun 2020 18:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com> <20200629135722.73558-6-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200629135722.73558-6-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jun 2020 18:38:03 -0700
Message-ID: <CAPcyv4hFfU0r0GmCgV-wKXq+H=GDV-OPsGNPWmFijrdWm58X_A@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] powerpc/pmem/of_pmem: Update of_pmem to use the
 new barrier instruction.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: Z7NBYGHNITGUFRNM7KHYQ2SPSFEJ5OLS
X-Message-ID-Hash: Z7NBYGHNITGUFRNM7KHYQ2SPSFEJ5OLS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z7NBYGHNITGUFRNM7KHYQ2SPSFEJ5OLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 6:58 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> of_pmem on POWER10 can now use phwsync instead of hwsync to ensure
> all previous writes are architecturally visible for the platform
> buffer flush.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 54764c6e922d..95782f77d768 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -98,6 +98,13 @@ static inline void invalidate_dcache_range(unsigned long start,
>         mb();   /* sync */
>  }
>
> +#define arch_pmem_flush_barrier arch_pmem_flush_barrier
> +static inline void  arch_pmem_flush_barrier(void)
> +{
> +       if (cpu_has_feature(CPU_FTR_ARCH_207S))
> +               asm volatile(PPC_PHWSYNC ::: "memory");

Shouldn't this fallback to a compatible store-fence in an else statement?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
