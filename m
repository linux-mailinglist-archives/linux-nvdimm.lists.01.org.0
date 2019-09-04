Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7120A78B7
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 04:21:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22E3F20216B86;
	Tue,  3 Sep 2019 19:22:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 17EE121A070B6
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 19:22:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id g128so14651238oib.1
 for <linux-nvdimm@lists.01.org>; Tue, 03 Sep 2019 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PWWxkJM/5hEQh0Zx8r/IL2EuUlvwB6A9IDhSgX6Pqr8=;
 b=e9bTLV/UqIM4ro0g9ajIAZuKoZZ/OzPIyuX8p/ekNpZlC1pM4eEyzNTjlpQgdqcpYD
 BQqoueuL9e0R0AwekP0W8Hwk43T273a9ywXnk89Th8SSFbh8EfpA3v7qUBadFSoyxk5w
 SWPxUw9M7HjFWe1SqZbRYkTyGtJJfLqexQpLCrd7+1wVDgAoJDgnA8iTZ1I1Ecl2fBTO
 F/TfAhpEEMy0/EYJBcjIjuPdm/3FbZqFh1Irkpa5AWZ70MhA89LSLkacYlUW0aQuOnkg
 YPHoXgrVw7sSiSc2+U+Qtg+UFm78qUInQAT3fkOgnDWeECN+QLtxAwvt9G0IbY/nkfSm
 QAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PWWxkJM/5hEQh0Zx8r/IL2EuUlvwB6A9IDhSgX6Pqr8=;
 b=BzMycXjv9vNg7N8481m0EBREk5cnabynbkvKnVV7clB7cjNsxwKX7zd4retOm+k41v
 meS6v2MMaV+9fOOuZaYgjcMzKaK1CJPAC5IS5VMWex3HXpN42ftmHSJQY0d9GW4HpFCM
 UYH7RhkcryKiFl/iIIiCgCKKGFUlpsa+NB5h6Sq+oDVd5RRmCHPOn/864HWkbch70+3Q
 YV0u0aAaNlZmweOhn0S14tygOkw8yRR/o9eFc99alwMoveFP0iBZzLc3jhaHk/vlTomt
 qBksVENVGDdcJ/GUiwPtThzQtKsJxlDliQWKAvaqR1xQo8v/QV1b4ZoYxkgXrhkJz/Kf
 7rwQ==
X-Gm-Message-State: APjAAAWwC+mNGSzBuFdvm5ToNIjNZuixdBjUzpaSA7mpwKCM/CyVuFBG
 EgLzRmMRGFdkHUMiUgZXKDovzKyM+IXhr6ThB7yycw==
X-Google-Smtp-Source: APXvYqynZztZGupwwwRFpuFaVYMY/MxiwII9dYfVKZNcURnzBoDLspsKsMBIykxipYKGtLvOs/EndkmkIIhchTSBBOc=
X-Received: by 2002:aca:62d7:: with SMTP id w206mr1810406oib.0.1567563700771; 
 Tue, 03 Sep 2019 19:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
In-Reply-To: <20190904010819.11012-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Sep 2019 19:21:30 -0700
Message-ID: <CAPcyv4ia8aQLk_p04bS-SdCSc5BSTJtdO-XWAKJhS=7_C5DyzA@mail.gmail.com>
Subject: Re: [ndctl PATCH 1/2] libdaxctl: fix the system-ram capability check
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
Cc: Brice Goglin <Brice.Goglin@inria.fr>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 3, 2019 at 6:08 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> When checking a daxctl device for system-ram capability, we needn't look
> at the symlink resolution for /sys/bus/dax.../driver/module since the
> driver in question may not always have an associated module, and could
> be builtin instead.
>
> Change the symlink we resolve to simply '/sys/bus/dax.../driver' and
> since that too resolves to '.../kmem' in the system-ram case, the
> rest of the check remains unchanged.
>
> This is a pre-requisite to making daxctl-reconfigure-device work
> correctly when the target mode's driver might be builtin.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index c0a859c..d9f2c33 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -406,7 +406,7 @@ static int dev_is_system_ram_capable(struct daxctl_dev *dev)
>         if (!daxctl_dev_is_enabled(dev))
>                 return false;
>
> -       if (snprintf(path, len, "%s/driver/module", dev->dev_path) >= len) {
> +       if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {

Nice catch.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
