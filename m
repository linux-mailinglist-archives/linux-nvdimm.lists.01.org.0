Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE617245B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 18:01:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E89BD10FC363E;
	Thu, 27 Feb 2020 09:02:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2CFE510FC3639
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 09:02:29 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 66so3573632otd.9
        for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6h30Tw2mjD0V+USDZTW8hFhBkYs512Lqr51yu3+ofs=;
        b=uAn0b8d75rtFVOIdOZnsmQfugjpQalJefb4ste8jolUNr1Yv8HzUsChA5IZdX6dVwd
         XioJKiTWbGnDtU4IboFdBuWNdSUJyhqOywZAqPHtfAPsP5EE2Vctx7h4d3HzmAz8kJg2
         QEZGCgmxda9Q1U7l8UKx5rYUE8e0CalNOfmq1Gr0p48T3nigCDKHxAA95PerIyA9cG+e
         dR6hBEjqTyDoYw9c1pPJAGrnBH4XrcTdP2uQp8VES5MNja8u2NBJLM/amQM8kZtjM4o2
         775/8oUqrrg44OGDHSVN//FW3bxKZ/Q8bzo3dFUV9T7ZLLB9OUQvlYn0dAJ0bMRvvuyk
         8XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6h30Tw2mjD0V+USDZTW8hFhBkYs512Lqr51yu3+ofs=;
        b=XXRSo/Ca7Z4PDwXbITpqO2322GXG+iXPO1yKR3jYtgUYMO2Dmn8pSlJiVVX4UpGej5
         QTvKD9HM/Vl8OMCRncrGHK8Wl7xZ9WipROjaWvODn5T4jwoWFlH1fuUrQO8AwqOu7aiK
         OsqhxJDG/j/3wwPDvAHMGWCTNQl2/Jc2vReLCpNL/ScZPa3mb8Te+HTX80HRGOLpIFad
         Z4zlPAhgZHB2g5V2sq8SsNfb34T0RvUKtUkYxL6CvzKQRQ/47z9o4YGi5gWkx5WH0OC8
         Ogsn4g92+2LFeLqwbNXtUePGlndDx4bfXfnK7uSFACiImu3sHrsFLLum7r0F79X4j2ei
         X5ng==
X-Gm-Message-State: APjAAAXFyddYTuWPvf9ZhcCvJ6lM23bNoPwU255VDnROJ9Ms7XBOCZwe
	ggOFEBSLlasIapi8PWxIeGxfLb+ndveeqZm8huJFOg==
X-Google-Smtp-Source: APXvYqyXwQILrbtHCsUHMWn42meoZX0KXIZsOEVsgrRpEJ3IcJaY2hGUVFuyZ1kdlGiQhmRiXVOeUC0xDwMJYMZQufs=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr525264otl.71.1582822896420;
 Thu, 27 Feb 2020 09:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-15-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-15-alastair@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Feb 2020 09:01:25 -0800
Message-ID: <CAPcyv4iJahL8w3mjfS3C6Pb5PgAsN9+7=FDVgtndU2oHmYYUgQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] powerpc/powernv/pmem: Add support for Admin commands
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: 7URFXY3TENAQZ2U7BNDGX3CWFGVCKGKZ
X-Message-ID-Hash: 7URFXY3TENAQZ2U7BNDGX3CWFGVCKGKZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashev
 skiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7URFXY3TENAQZ2U7BNDGX3CWFGVCKGKZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This patch requests the metadata required to issue admin commands, as well
> as some helper functions to construct and check the completion of the
> commands.

What are the admin commands? Any pointer to a spec? Why does Linux
need to support these commands?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
