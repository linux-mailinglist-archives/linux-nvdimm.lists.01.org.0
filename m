Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2A14735B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jan 2020 22:49:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A73971007B8F5;
	Thu, 23 Jan 2020 13:53:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49B9910097DFE
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jan 2020 13:53:06 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c16so4453311oic.3
        for <linux-nvdimm@lists.01.org>; Thu, 23 Jan 2020 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S935iTNsR30a4CSNLom2KZfe2GAU9enVCcRjMbR4lpE=;
        b=AKigSPzM1pExN/0OUORy7NpgODYyQ4J3t8r/+dJLxrjRj6ZgcGmzkknMRn5g54jugV
         PuPjFHoT8J762NdoRQVHcHl9aReYnbqomBumabhWbyCGFZ3akBYIa+Oo2ZAyxeNPEUG6
         slSOLUOGXe0plcCeEtyTizIlDOrUNqXRHiyll5b912xeRne4Brkv3g2Yj5DnnnWMx9xf
         nOQ+q3+Roi/lwXJJNqrhQmJ7M+daSkVy5CUvw9WY97DQv/1645/V+S819BZ4sC9JHHJB
         FhR+LdjY2IZ9E5Xk/eA4jTuxHrwwKXTVcvl+QK/5vMd9aUzZIaBey7OBVe4+f9tunZmO
         QNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S935iTNsR30a4CSNLom2KZfe2GAU9enVCcRjMbR4lpE=;
        b=G5S1PsCh4H58YKzxA0XZj/M1nSEld1VQpygVx6wZwcOpIWSB0yBO4e+WGGCjPlefeu
         CS/LLuUj6NxuDt4iqW7ZVDKIo8RAWpx6mdFeWcUrhbWrMYtc+S+MiwWBVIpz8ZhYB8Rp
         etlucFjY+v4lLx9MD2CMQPKIqPb2BaUaxPtZHiwxICtE8vVOIpWA2A3pfhWXAAujlfdP
         yyWN+ZBHfVUqO+7m0BE+JGb5D9OSBIxe6yXJgjNlp9z6yVK4b0xQWMYPAVUIIDHEAY3G
         sfR4jHgJGBKMVudaIzMWDjR9W1bzrUj/KMaq16k6tDiitVTvUKzXQR6MTvqe0bE1pqvW
         mOOA==
X-Gm-Message-State: APjAAAXPTu+HgIqB2Rzv7GP55YXMqG1T1YC4k3d8WfbVJfnmyy0OCWKH
	d8kFSZIXCTzvkaa8UEZrj0Tdz79BGLTZxb0X1vx8vA==
X-Google-Smtp-Source: APXvYqx4QUtx9s2lROgpkdUqlxbaltm1ZPSPZIGO6zsZcw5gUbC6uA34HmB9vJLOfKcAsmsAfZMR+8aobM49R/8fTys=
X-Received: by 2002:aca:1103:: with SMTP id 3mr32140oir.70.1579816187113; Thu,
 23 Jan 2020 13:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203034655.51561-3-alastair@au1.ibm.com>
 <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
In-Reply-To: <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 23 Jan 2020 13:49:36 -0800
Message-ID: <CAPcyv4in5yHD3i2nYgaJsNKkVAJf4h4N+HUbhkmWjXzVK2jN=w@mail.gmail.com>
Subject: Re: [PATCH v2 02/27] nvdimm: remove prototypes for nonexistent functions
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: LVDUQG2MCTDERRLSWWSDUYQD3VPH6DMB
X-Message-ID-Hash: LVDUQG2MCTDERRLSWWSDUYQD3VPH6DMB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <li
 nux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVDUQG2MCTDERRLSWWSDUYQD3VPH6DMB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add Aneesh ]


On Tue, Dec 3, 2019 at 4:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Dec 2, 2019 at 7:48 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> >
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > These functions don't exist, so remove the prototypes for them.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> > ---
>
> This was already merged as commit:
>
>     cda93d6965a1 libnvdimm: Remove prototypes for nonexistent functions
>
> You should have received a notification from the patchwork bot that it
> was already accepted.
>
> What baseline did you use for this submission?

I never got an answer to this, and I have not seen any updates. Can I
ask you to get an initial review from Aneesh who has been doing good
work in the nvdimm core, and then we can look to get this in the
pipeline for the v5.7 kernel?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
