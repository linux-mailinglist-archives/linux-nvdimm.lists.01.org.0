Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA73201EA5
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 01:34:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A83910FC72A5;
	Fri, 19 Jun 2020 16:34:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 398AC10FC72A0
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 16:34:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cy7so2467267edb.5
        for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3oh1lM0wdhqgCoOS/xFM5A00tFqVqN9JQEyMolcljC8=;
        b=uBQGrWj5aIklwNrXWJPn+kMeNQ808Jyi7uAgvjfUlhKZ5C7IajaHOnvoi7RgEVsoSB
         iIZR0CQDNqm0YpU4bo2KW309H44aKomWkZ17amf6FzJQm90Q1djsFxbcz6yavhV/0Ri7
         GdYcNAdVbTkgDrjMKIP5iIoNlmK6C83f8A6omRBPYPNaNEpqThZ82XYRDuSYc5SLGhEf
         SWbPaSD7Vm/gShuWTjkH/fGG21QMCTdtLRY0cUWscgrNtvrOlxQPC/Wtv0XbTpkaITTC
         xg/VCz2MaLUbU5UKoSWxAoet+5ACVmIu7wW03vNqiZU7bBv+8xOSumWl6qv9N0X0uzy3
         IjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3oh1lM0wdhqgCoOS/xFM5A00tFqVqN9JQEyMolcljC8=;
        b=IDscR2rwtkEaRhWCVqYfztz3x0428+TkSvH7QrxxQsxrPmHcrky1t5XWcxujK1jtzy
         GfgWq5QOmHwbsK13H5oVkzOogJ33yFaYx6oQedccwPFzSvWDLjbbIi7FJYTKFUPZp+s5
         22kDj/jBSlf2x5EupH5CpqfuhgUE/BSZwZ0cJzFR57Qs7Gs8yT/lTN6Z4Hjgz04AQ12U
         LL2gmXBkNw3iJDMRD85qPIrUHGPYezC2qIA+yls+4GCLsIrTATRfK5/KdZA4e32OuXul
         vgqXC8ksYU+SL/WQLdrvJhhssiXvl6hVQYwNLw0vc8cd4mNBt/R1u58LlsCu6hkkYfPO
         GgRA==
X-Gm-Message-State: AOAM5309E6WFMjeGMfmNSETYfDVIYDjDb+/1FGPDf9KjMfsHlmSDS8Yr
	8iH76od7Q88d7YqOOLDFY+M8k1DMc70X8q3I420eKA==
X-Google-Smtp-Source: ABdhPJx1kkg19lhWY7x+PtRXCZG0CgWfBnmVpjBQddrdGinubYZdjNuitdIlW40ThyK57GofL1ihsG13q4deUgTRKWs=
X-Received: by 2002:a05:6402:1441:: with SMTP id d1mr5551416edx.93.1592609670144;
 Fri, 19 Jun 2020 16:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Jun 2020 16:34:19 -0700
Message-ID: <CAPcyv4jDgD82S9VHWb-P5iP+UH-gqdsYcNmA=aMFNhKrdSEUqg@mail.gmail.com>
Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)
To: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
Message-ID-Hash: OQCJN6ZFP52AOIRL3FLBET76QMTAZSIK
X-Message-ID-Hash: OQCJN6ZFP52AOIRL3FLBET76QMTAZSIK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OQCJN6ZFP52AOIRL3FLBET76QMTAZSIK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 19, 2020 at 4:18 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
>
> I have a question on the default REGION creation (unlabeled NVDIMM) on the Interleave Sets.  I observe that for a Single Interleave Set, the Linux Kernels earlier to 4.9 create only one "Region0->namespace0.0" (pmem0 for the entire size), but in the later Kernels I observe for the same Interleave Set it creates "Region0->namespace0.0" and "Region1->namespace1.0" by default (pmem0, pmem1 for half the size of the Interleave set).
>
> I don't have any explicit labels created using the ndctl utilities. I just plug-in the fresh NVDIMM modules like I always do.
>
> I searched for and found the relevant information on that front regarding the nd_pmem driver and the support for multiple pmem namespaces.  I am wondering whether is there a way I could -- through Kernel Parameters or something -- get the default behavior the same as it existed before Kernel 4.9 driver changes.

How is your platform BIOS indicating the persistent memory range? I
suspect you might be using the non-standard Type-12 memory hack and
are hitting this issue:

23446cb66c07 x86/e820: Don't merge consecutive E820_PRAM ranges
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23446cb66c07

For it to show up as one range the BIOS needs to tell Linux that it is
one coherent range. You can force the kernel to override the BIOS
provided memory map with the memmap= parameter. Some details of that
here:

https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
