Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED952E3E8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 19:49:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CAB32128DD41;
	Wed, 29 May 2019 10:49:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6ED8F21275462
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 10:49:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v25so2226278oic.9
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P18EkxmcF+Sl4DCKo/2tHknknlpgkHuSZZhc4ypMuvI=;
 b=mr7yKTFGgPnwaAb/x9yE1YYnPVq5T3ylAnw8p0H+ByaAn2h2bPxsD1MO90IFm3+CX6
 zc1SBxsBqi8Q4RA91ZZRxZ1Ox2LMCPVMj4lTYpzMeGThTUgH3X+MZTT6KW+XmsJ0+hPq
 OtS07XCO+LJqGiIrKhQOOE3eiIIiU2cbveHVBn1sdWUAaCKJuxwsHcid+HJxq1CbgVSB
 sw4qawONqpn/X0kjblrqUaUcInOfIBW3U3jCeX4JdouKsODXlj0+9MR2YTdHc/PUoYKX
 f0NVGEb1HBfkMJzurt5/1zjLufN7ksPiL/6UOmLs0n5e2lRuazqZdTcgWiiaOdV9f0hz
 b7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P18EkxmcF+Sl4DCKo/2tHknknlpgkHuSZZhc4ypMuvI=;
 b=AEQIZF2QOxgM3cWkiyjQeCpbasLu0ze3XO/L8o+3NKFm1FO7RuCplfmyhs7eX7bPRX
 5KNqRP2rkJFzznjIneKw+g5WzGh9dRYn8tMz9BQgG9hHHCKRDgA98Fv4dUIvorTb98VM
 qj+O9dULAWfNZr+sZn0n5M96UA0toWC9iNGHWDbO6feo0Lqqj0TcSGIw+KkiZ+IvoiE5
 n+wBc3wHQYlA15nin8PySJ67vHcm+z+5c4S3SM+et7RLVm1H30Jf6LwhWZkCu9VRcUSO
 h8f9lHePlcbG+5js6b+U5aReu9V23VA2iynyEyK7vfOe/PuFW97QMuhydeBvLEPrjo12
 ghqg==
X-Gm-Message-State: APjAAAWhacExSvY6lJ66mkDtcBS54ygSyjmr+eFtnfUvqCR4TRo07fIN
 DJE/XW/O/fzh7BEHTCclZFz2pxQAF6MiifsFlD1bBA==
X-Google-Smtp-Source: APXvYqxl3ukelM+BvDMd+LyOy/qsa9vQ3fYRaBnCQzrFGCecAYjqRXxVFmM4lzW8uNDRx7gPoC9aG8kINjcW5qXe07I=
X-Received: by 2002:aca:b641:: with SMTP id g62mr7333392oif.149.1559152183819; 
 Wed, 29 May 2019 10:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-9-vishal.l.verma@intel.com>
In-Reply-To: <20190528222440.30392-9-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 29 May 2019 10:49:33 -0700
Message-ID: <CAPcyv4iKz-x4oLjW1=TDByfw9_ergexAGNDpPuTwP-88P_v4=A@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 08/10] Documentation/daxctl: add a man page for
 daxctl-reconfigure-device
To: Vishal Verma <vishal.l.verma@intel.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a man page describing the new daxctl-reconfigure-device command.
>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Documentation/daxctl/Makefile.am              |   3 +-
>  .../daxctl/daxctl-reconfigure-device.txt      | 118 ++++++++++++++++++
>  2 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/daxctl/daxctl-reconfigure-device.txt
[..]
> +-N::
> +--no-online::
> +       By default, memory sections provided by system-ram devices will be
> +       brought online automatically and immediately. Use this option to
> +       disable the automatic onlining behavior.

With a --no-online option it feels like we also need a "daxctl
online-memory" command to hot-add the memory range associated with the
given dax device. Otherwise, this looks good to me.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
