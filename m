Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB99CEB78C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 19:50:54 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 146C1100DC40A;
	Thu, 31 Oct 2019 11:51:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23088100DC409
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:51:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 53so6321637otv.4
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=visRjrack2Ucrz4TCekic+nMUdhhC4QKbbJVxOOf1vw=;
        b=2GO2WR1YbDTfUSvkOLueLHCDFZKW2ZWvpCZlXfaBp1IxQFmfAGHuElVzbDZbBv5SNq
         wrTPkzydf2lvK/S1ryYP4XgbzB5seAe4MfSNH6Z++5bPVHGCIRYrSvmKoIUibJTEmAe6
         3ArqNT7pj2t0HWfwLtEX0dT9emhNIUX8B/Puq0hPWC2Utlpn+y6zuetqEE3t4HnC0LmH
         wtFsr5ytKJPg2xK513ckHMrapg+QxwdqwS3aoMMBVJBWKU0pCXkxr8GvKD0S3WsmGGqh
         eMGWiGIQ4LB2wlriXA+SaVb79LO7wAo/chPeMqmmWxBY3gPguJBLxvja4Nm0X/lmPcB3
         xitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=visRjrack2Ucrz4TCekic+nMUdhhC4QKbbJVxOOf1vw=;
        b=aoVnyAljNZMOL6Ks0pZfIzCzMzBidaDIaJ5UKoUMs+NefcHTsZ9pQ5mUbcePQg0rOk
         huppWt2B+3RPFGfHQUaQ+kbn6+7W9li10NYIRjkMv8OW3aNKF8vL3gxyaFpgz+5dUxjG
         KlDrDInOjJ6yjQe3LIwEOY8S+3q0TqxQxSKy9aLyyglNIL0xiCeVmOggtIV4f5MARPR8
         TLjSa68HynYG3R/W5DFcroqrmt+IBYCJypraYCofmIzxdaheRNOKLbKzuX/sSt6sWDNM
         tWifBzAbs5MCg8bhG3CpREDpzQbdKBVU7b9KzfaTt6vvO40Sk/gjto5ZzFAMBmF+mBIp
         +mTA==
X-Gm-Message-State: APjAAAUIS3S1p0DWTKfrPiq8cKtgRTEiQZqGdIOz99z5MUXD2i4zR+w6
	eTpUHS71D/rnG3dw2x4QmqpedjoarjVO4r524WhXDFrm
X-Google-Smtp-Source: APXvYqwO39xIYvT9ydCSAy33PbpiVWU201M1y3KBiM2KlQT5JuQwX0+0cbmG+kY5H4osMpND4S4wAw/aqhhqDJao/a4=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5847528otg.363.1572547848881;
 Thu, 31 Oct 2019 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 31 Oct 2019 11:50:37 -0700
Message-ID: <CAPcyv4jdgYvmYNaftOA41Ta_4ntXY3xCXKzhbP-aiPNeitMU2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] libnvdimm/pfn_dev: Don't clear device memmap area
 during generic namespace probe
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: CSP55ADH27NUQGWN54PB6EAPON6O4ALJ
X-Message-ID-Hash: CSP55ADH27NUQGWN54PB6EAPON6O4ALJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CSP55ADH27NUQGWN54PB6EAPON6O4ALJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2019 at 3:57 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> nvdimm core use nd_pfn_validate when looking for devdax or fsdax namespace. In this
> case device resources are allocated against nd_namespace_io dev. In-order to
> allow remap of range in nd_pfn_clear_memmap_error(), move the device memmap
> area clearing while initializing pfn namespace. With this device
> resource are allocated against nd_pfn and we can use nd_pfn->dev for remapping.
>
> This also avoids calling nd_pfn_clear_mmap_errors twice. Once while probing the
> namespace and second while initialzing a pfn namespace.

Nice find!

For the resend: s/initialzing/initializing/

>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/nvdimm/pfn_devs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 60d81fae06ee..fc2cd412861a 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -591,7 +591,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>                 return -ENXIO;
>         }
>
> -       return nd_pfn_clear_memmap_errors(nd_pfn);
> +       return 0;
>  }
>  EXPORT_SYMBOL(nd_pfn_validate);
>
> @@ -730,7 +730,8 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
>
>         rc = nd_pfn_validate(nd_pfn, sig);
>         if (rc != -ENODEV)
> -               return rc;
> +               /* Clear the memap range of errors */

No need for this comment the following function name is descriptive enough.

> +               return nd_pfn_clear_memmap_errors(nd_pfn);

While this does allow for the errors to be cleared once on each
activation, it blocks validation errors from being reported up the
stack. It also does not address errors being cleared on create, but
that was also a problem shared with the current implementation.

I think you want something like this? This passes my testing, but
please review / test to make sure I'm not overlooking something, and
update the changelog to reflect that errors are now also cleared on
create.

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 5a848a014d6d..c1eb99c0ca76 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -725,9 +725,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
                sig = PFN_SIG;

        rc = nd_pfn_validate(nd_pfn, sig);
-       if (rc != -ENODEV)
-               /* Clear the memap range of errors */
+       if (rc == 0)
                return nd_pfn_clear_memmap_errors(nd_pfn);
+       if (rc != -ENODEV)
+               return rc;

        /* no info block, do init */;
        memset(pfn_sb, 0, sizeof(*pfn_sb));
@@ -793,7 +794,10 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
        checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
        pfn_sb->checksum = cpu_to_le64(checksum);

-       return nvdimm_write_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0);
+       rc = nvdimm_write_bytes(ndns, SZ_4K, pfn_sb, sizeof(*pfn_sb), 0);
+       if (rc)
+               return rc;
+       return nd_pfn_clear_memmap_errors(nd_pfn);
 }

 /*
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
