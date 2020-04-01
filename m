Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655A19A7C0
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:49:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9878210FC3BC1;
	Wed,  1 Apr 2020 01:50:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 911D110FC3BB9
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:50:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cf14so28673758edb.13
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7+9v32j9cPB3QX5vXPFoTYuOQMb+jFtKmzdafzKlXc=;
        b=IfBVo0qtkzx0IwrTLjMKGmOczvAfIcGCXFrucXhdytTeaMv3LlGABrbnLscvf6EhPu
         ZipNSAsdlrGbSXI2CqQreu8FxLOGRWD8tJDVQkXpETIdmXHwd+Xv1jp44fy/mtTN32kt
         fVa09PGK306kWlrf3zKeHF07SGJb0bHLqW0CIkn37zcb7BIrEg+bNikwEXJacTI+GagZ
         hpxLEcN73/j3YUhCKXBElj08nNWzPs0hV3h929pXH5yevZyR1Cqzb0EOT5jcy3jgbKE7
         d2Ahuxp5GjmVR/tbuNADZWn5ZmlTpD668O9WqG3hIA5ukj8ZWJtmtna2sM5J2LzKH6Sn
         jAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7+9v32j9cPB3QX5vXPFoTYuOQMb+jFtKmzdafzKlXc=;
        b=r5CkUgXp5f058GZs+xrs3zAq9MG/lEE0L8EILcN/oK2nIGKiqTuG9VZAv8fYnFtYNP
         RI5X1pElRjAxZwjWa3nkR7SoSrd8Dn8OYqtJbiyJoVd25K1DPDvmckwGMAPAAC0cZ3gu
         vWCFtavubnrB6nKPNdiKnJuTjef01DDC+DVKgojIJE2nL8fwCkav3bfG/rW4RJaEGlzO
         N1phjdUvdCvKFL3dk+sKhIolMdXkxk97yPsX4w65Htkss09AcMgoxt+HCkki/dQbeBo7
         ZUE2FjPRuX+hsdCjoFDNZjNQdW4QqBKemPr3zXvNgJCGIJUuRRdEAQH8gFEtxN+io4hR
         ROSQ==
X-Gm-Message-State: ANhLgQ1ol0dZ7AAtfQiUlz8mM2se5PvPuIKgdjq+2+Qqvuy8PNbM+Wqq
	0/Uf7ru6yWt40463lhUu/T9zDu1jOGx+85YOikOvpA==
X-Google-Smtp-Source: ADFU+vvi5v9sHbdO0IWcuuBEvZqkCqjH7pX1tPN0HKLi97q9NYRu1C93IYlcqCprR6w1SOFMCMFSMzwhs34udzF7ni0=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr18635550ejj.317.1585730979486;
 Wed, 01 Apr 2020 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-9-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-9-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:49:28 -0700
Message-ID: <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC
 memory was detected
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: AJZEGJJW3KJOS7RHL5EMKFDVCUAJBLEH
X-Message-ID-Hash: AJZEGJJW3KJOS7RHL5EMKFDVCUAJBLEH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AJZEGJJW3KJOS7RHL5EMKFDVCUAJBLEH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch emits a message showing how much LPC memory & special purpose
> memory was detected on an OCXL device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  drivers/misc/ocxl/config.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index a62e3d7db2bf..69cca341d446 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
>                 afu->special_purpose_mem_size =
>                         total_mem_size - lpc_mem_size;
>         }
> +
> +       dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
> +                afu->lpc_mem_size, afu->special_purpose_mem_size);

A patch for a single log message is too fine grained for my taste,
let's squash this into another patch in the series.

> +
>         return 0;
>  }
>
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
