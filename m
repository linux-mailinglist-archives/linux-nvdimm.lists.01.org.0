Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB128437A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 06:53:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CE21212B9A6B;
	Tue,  6 Aug 2019 21:55:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D15E7212E46E5
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 21:55:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j19so22600419otq.2
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 21:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6CpPIyvnKFWkuaLYcVpqDki1olWa07+gbL5ANQ9lHac=;
 b=peG6h4csqre45VhS+zD6MYcwYNk5HUeEqpbTFKlRVdPbpFw4X4ZCXJYHTjFVDLOtht
 RoN+lhMGgMtx3PKrIxjSzzfpOJPKV0ueUfGDu+OIGxQW+7so2ilek8xkgJ82Ipd1ijGw
 d0+ylJGG42kWhRW6VShBCYWd/p83y36oDxEyFPTKQIFmgNmnE+8M+pfDEXArysGMcABy
 DwMTL7bED7wKIUALO6OLmRFKcpd6Ew+WleYDNC7UXBkrzs2R3PIuOIKax7o+8mdp7oAm
 0aT0xr4ZlpzLEGuFAI2/SDTsEhLSUfpt4IfroKo6tnFlsyP0h4piF81YDWTeMmFRJicX
 LtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6CpPIyvnKFWkuaLYcVpqDki1olWa07+gbL5ANQ9lHac=;
 b=F0oI7DmqdtXkseWG1ICwVC+hMldjuQATD3H05aLsc8kaPumySH6hjc6eh6SoGXpBN8
 udgOvEIvMT7xop91ZBInM6dLl7w7Is17vbqnmzjfvRPnHW8pgm7fLkR2QpyKPE2eThBE
 aRqLrFkbkS4uIPQ65Rw+h5ZFz7cvZ1kVVmG1mU2A44Vjic0Rc0/XADP5htGHMg55+hpJ
 emCm7nA14raTyMdQJwIGkWxHFCW6eGmY/FaiZLPaLOT1uSM2/aceQ7lS7AUH0Mi9ZnnX
 fj53m7v/O04Q8p+kCEHsp6XgrkoOFhR0euuomVZ3RbO5u4tmQobMFHGSRPQCDFIwCV80
 jZUQ==
X-Gm-Message-State: APjAAAX7mcdiB0LSFnRU93PBAvLEDSVAXHQk9G1D4Ne2kJpmE8FQaqf/
 YYUCS0TCvv8DuCV2AN9bmhi8CT5d/Ewf2+RdIEbIrw==
X-Google-Smtp-Source: APXvYqw/J4KuoAhA+kSxUrBlU+W9n6v9nDVZqYvsp3MaYhj2HB7qQ5b5es8BCtv4fonyj8HLIBgBwbHMBjfP4P0GIxQ=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr6568561otk.363.1565153588793; 
 Tue, 06 Aug 2019 21:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4haXOjn7K-HgPV_WLqbfqRQbbiq=LvLt5Ue=OPAaBWN6A@mail.gmail.com>
 <c99ecdad-e9de-cd76-1601-841de35602a0@linux.ibm.com>
In-Reply-To: <c99ecdad-e9de-cd76-1601-841de35602a0@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Aug 2019 21:52:57 -0700
Message-ID: <CAPcyv4ia5F73Qd0FyOWkHAUGoXrPFFQwA-R3DNXb0mGyOS5fgQ@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 6, 2019 at 9:17 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 8/7/19 9:43 AM, Dan Williams wrote:
> > On Tue, Aug 6, 2019 at 9:00 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> ndctl utility requires the ndbus to have unique names. If not while
> >> enumerating the bus in userspace it drops bus with similar names.
> >> This results in us not listing devices beneath the bus.
> >
> > It does?
> >
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>   drivers/nvdimm/of_pmem.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> >> index a0c8dcfa0bf9..97187d6c0bdb 100644
> >> --- a/drivers/nvdimm/of_pmem.c
> >> +++ b/drivers/nvdimm/of_pmem.c
> >> @@ -42,7 +42,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
> >>                  return -ENOMEM;
> >>
> >>          priv->bus_desc.attr_groups = bus_attr_groups;
> >> -       priv->bus_desc.provider_name = "of_pmem";
> >> +       priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> >
> > This looks ok to me to address support for older ndctl binaries, but
> > I'd like to also fix the ndctl bug that makes non-unique provider
> > names fail.
> >
>
> 0462269ab121d323a016874ebdd42217f2911ee7 (ndctl: provide a method to
> invalidate the bus list)
>
> This hunk does the filtering.
>
> @@ -928,6 +929,14 @@ static int add_bus(void *parent, int id, const char
> *ctl_base)
>                 goto err_read;
>         bus->buf_len = strlen(bus->bus_path) + 50;
>
> +       ndctl_bus_foreach(ctx, bus_dup)
> +               if (strcmp(ndctl_bus_get_provider(bus_dup),
> +                                       ndctl_bus_get_provider(bus)) == 0) {
> +                       free_bus(bus, NULL);
> +                       free(path);
> +                       return 1;
> +               }
> +

Yup, that's broken, does this incremental fix work?

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 4d9cc7e29c6b..6596f94edef8 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -889,7 +889,9 @@ static void *add_bus(void *parent, int id, const
char *ctl_base)

        ndctl_bus_foreach(ctx, bus_dup)
                if (strcmp(ndctl_bus_get_provider(bus_dup),
-                                       ndctl_bus_get_provider(bus)) == 0) {
+                                       ndctl_bus_get_provider(bus)) == 0
+                               && strcmp(ndctl_bus_get_devname(bus_dup),
+                                       ndctl_bus_get_devname(bus)) == 0) {
                        free_bus(bus, NULL);
                        free(path);
                        return bus_dup;
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
