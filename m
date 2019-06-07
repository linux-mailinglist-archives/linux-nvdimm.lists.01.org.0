Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0F039661
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 22:03:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A3B721290DFB;
	Fri,  7 Jun 2019 13:03:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AA3CD21290DDD
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 13:03:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 203so2257115oid.13
 for <linux-nvdimm@lists.01.org>; Fri, 07 Jun 2019 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tNWHofgNaqy6pErzI2UDdlfPXYGdisLICCNigvI4kL0=;
 b=u6rXT3Xk89E7qKZJuqet/kerwsW/8pbifYfbULG0Hl/9cqx/I2ZRAEyvBG62o4extZ
 wAaIEjw3XjBv16xyVl1le/CrVWXfxtjbO+/oJacrZ7oKh3hvurUvbwDA/9HTSM20GBjn
 w5BBygSxhP2JKc63CxyI3teYBc84w8qnOmwxMKIgAOtMMiuAcSIq4AtgY5fyAra+CJHI
 oF4c/P4dsqTzwVfwmGRtz2IoT9hpxJhBJtN/CXH5nQ6lK38J+bgrm3NiRudTmRV4xr8B
 w9zoN74jsv49+DgrTPWzcfpX7kTtx8FhE+9Qxspy8dgylv58d2b5qynGCr7A6rUP8kjG
 xw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tNWHofgNaqy6pErzI2UDdlfPXYGdisLICCNigvI4kL0=;
 b=GA9Lt6N5SfGs3vKqWDeiPnK//q7vVHcmKnx4HKBS/AHqRJ1zLHkVQthLAqNF1g30pg
 a8L8QKP0eOE3Qba2JzqYL0oYAFA7Voh5X5LVzuPlPJBLBrHgJIonOXlR5/lOSPPiEUr5
 kwy9NIE5bcbzsCyKmTL5J38NISg+K3mYebgf/CsaGeROqTHnxUWcaAiZOX8BFItE9CXo
 QrSHibOy9LJbyQKMS423Jy+UDbQl0ps7GushK6YxxNIiQBTRbW8S4gdvCYC8xeMnovWS
 uRuyphZ0ixaEF9ohdh7rtuXb5v7e78XlVfYmapWtI5DD0t/zCtGxyDS2VvlWJZhtc5bO
 Ok6Q==
X-Gm-Message-State: APjAAAU2rizAUtvSbLEV/kRNHm08g9kfOZ3NuBoT/dtc3jZySp72gg7/
 2S26CLM+zcRWVUj2OZlxet1VNw8O8yJWTftZEw9Ryg==
X-Google-Smtp-Source: APXvYqzjRw0XmHbFfB6N+LCDL02dSt9gHYEVSEZPCDUNI5M9/YAyKIO6lrQhDDoN+9fLMKTRkM2lsSceY96vks8ggTQ=
X-Received: by 2002:aca:aa88:: with SMTP id t130mr2819351oie.70.1559937817614; 
 Fri, 07 Jun 2019 13:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993564854.3036719.3692507629721494555.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f6c2d673-a202-4ad5-7055-5aaece9356e1@intel.com>
In-Reply-To: <f6c2d673-a202-4ad5-7055-5aaece9356e1@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Jun 2019 13:03:26 -0700
Message-ID: <CAPcyv4iFG3Z9xL9TSmqLVHxLZ6oiz-uWD6iKgJ8LF4f0n=m9=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] efi: Enumerate EFI_MEMORY_SP
To: Dave Hansen <dave.hansen@intel.com>
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
Cc: X86 ML <x86@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 7, 2019 at 12:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 12:27 PM, Dan Williams wrote:
> > @@ -848,15 +848,16 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
> >       if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
> >                    EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
> >                    EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
> > -                  EFI_MEMORY_NV |
> > +                  EFI_MEMORY_NV | EFI_MEMORY_SP |
> >                    EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
> >               snprintf(pos, size, "|attr=0x%016llx]",
> >                        (unsigned long long)attr);
> >       else
> >               snprintf(pos, size,
> > -                      "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> > +                      "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> >                        attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
> >                        attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
> > +                      attr & EFI_MEMORY_SP      ? "SP"  : "",
> >                        attr & EFI_MEMORY_NV      ? "NV"  : "",
> >                        attr & EFI_MEMORY_XP      ? "XP"  : "",
> >                        attr & EFI_MEMORY_RP      ? "RP"  : "",
>
> Haha, I went digging in sysfs to find out where this gets dumped out.
> The joke was on me because it seems to only go to dmesg.
>
> Separate from these patches, should we have a runtime file that dumps
> out the same info?  dmesg isn't always available, and hotplug could
> change this too, I'd imagine.

Perhaps, but I thought /proc/iomem was that runtime file. Given that
x86/Linux only seems to care about the the EFI to E820 translation of
the map and the E820 map is directly reflected in /proc/iomem, do we
need another file?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
