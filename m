Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5C17402A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 20:17:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB74B10FC36D9;
	Fri, 28 Feb 2020 11:18:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::943; helo=mail-ua1-x943.google.com; envelope-from=adelva@google.com; receiver=<UNKNOWN> 
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D32C210FC337C
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:18:42 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id h32so1385391uah.4
        for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXA3/+C+Ws03rM5oecAfvZ0EjvjFdg2ZbM6QXJtOnis=;
        b=T85BmpDrleLyl915HxeMadTD8HviR0L4YI8g1TPE3bzM0UctdJVLSN9P2/laHAAMSR
         upFTHz+wPJzr7i4Kmsk87YXVm3GIj8ZRb29Jod2t6WqHxNhpchtwJDD3oQSj5yOOZ+VA
         0xFJMmVLfXQegbcviPjOWZJAOHv/hAvB7tfno8C6Cc4qnuJG4rnyd7SewPIMeLg5qfTP
         0iOb2BIh6w+DBm+BgJgnPIbzYb6W1N0uSTX0wHehFWdXEmViuSrDILQJS2dFGSvWI7n+
         9QAM8+Tr/LSd7aW7pyGeSy14nQvI3fNhAz79HVyqyE4Y+nSqVU7aqfQq2cgQ04SgFn1n
         sI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXA3/+C+Ws03rM5oecAfvZ0EjvjFdg2ZbM6QXJtOnis=;
        b=aWKojct1XCTWaEXjPCYsB0cnpWZbP+2fTMFU+1tbQo5Wnd3owe/DinJlF5UnauGw5m
         KrCgFnBe7lXVOogcBdK5iL1BpDCHOoruZ5HtXKRqo22voH917NMLnDSEXp7zCshI5nIM
         iKpnVdSyBA1bSb11j9S/FBvcwwWXWSXRmyxF1Wgo9kW7AFo++EacO2euOGv5Z4PhXDwm
         GZBr+1gXXAp0wlIHRPoQ/rfj/Mj13wJpxpMJkghwYNN3t///7cXHROnv7VY+r8UtGILy
         jdm8qL+hvCtaA/6zfauSQPL+UCKPnamr414Tw4OAQF4I9m1h4JX0YHiusFFbd2da+gy6
         HMQw==
X-Gm-Message-State: ANhLgQ1YvtJ+TqOtFgtIrQve+uxoUNL1r7aAcC1wDn8rzfYhMDoDdsV/
	KaNicoorKDsv8AqeBM4uynrM1tuAKktgHBMTrMuj8Q==
X-Google-Smtp-Source: ADFU+vvsbZIc5VB+r9XiljUrppstnkF/gEQRydJ0xpNF0569jfMXKelO0dOU5dM371tMVLG+h8JPKHod/4zNraTMhww=
X-Received: by 2002:a9f:36ca:: with SMTP id p68mr2882516uap.112.1582917469575;
 Fri, 28 Feb 2020 11:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20200224021029.142701-1-adelva@google.com> <20200224021029.142701-3-adelva@google.com>
 <20200227232253.GA5966@bogus>
In-Reply-To: <20200227232253.GA5966@bogus>
From: Alistair Delva <adelva@google.com>
Date: Fri, 28 Feb 2020 11:17:38 -0800
Message-ID: <CANDihLFFUoauKxwcNDNE4=PuhzHSpB+FecxFJOn5H2GkreiYhw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: pmem-region: Document memory-region
To: Rob Herring <robh@kernel.org>
Message-ID-Hash: DKJWRR755Q6SAYZVFZ2ZA5JIPQKWDSAA
X-Message-ID-Hash: DKJWRR755Q6SAYZVFZ2ZA5JIPQKWDSAA
X-MailFrom: adelva@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, Kenny Root <kroot@google.com>, Device Tree <devicetree@vger.kernel.org>, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKJWRR755Q6SAYZVFZ2ZA5JIPQKWDSAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

Thanks for reviewing.

On Thu, Feb 27, 2020 at 3:22 PM Rob Herring <robh@kernel.org> wrote:
>> On Sun, Feb 23, 2020 at 06:10:29PM -0800, Alistair Delva wrote:
> > From: Kenny Root <kroot@google.com>
> >
> > Add documentation and example for memory-region in pmem.
> >
> > Signed-off-by: Kenny Root <kroot@google.com>
> > Signed-off-by: Alistair Delva <adelva@google.com>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-nvdimm@lists.01.org
> > Cc: kernel-team@android.com
> > ---
> > [v3: adelva: remove duplicate "From:"]
> >  .../devicetree/bindings/pmem/pmem-region.txt  | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> > index 5cfa4f016a00..0ec87bd034e0 100644
> > --- a/Documentation/devicetree/bindings/pmem/pmem-region.txt
> > +++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> > @@ -29,6 +29,18 @@ Required properties:
> >               in a separate device node. Having multiple address ranges in a
> >               node implies no special relationship between the two ranges.
> >
> > +             This property may be replaced or supplemented with a
> > +             memory-region property. Only one of reg or memory-region
> > +             properties is required.
> > +
> > +     - memory-region:
> > +             Reference to the reserved memory node. The reserved memory
> > +             node should be defined as per the bindings in
> > +             reserved-memory.txt
>
> Though we've never enforced it, but /reserved-memory should be within
> the bounds of /memory node(s). Is that the intent here? If so, how does
> that work? Wouldn't all the memory be persistent then? Or some other
> system processor is preserving the contents?

On the systems we're working with, the RAM remains refreshed across
reboots, but the contents of RAM could be changed by something outside
of Linux (i.e. the bootloader). By reserving this region in DT for
pmem we are saying "this is persistent like the rest of RAM on this
device, but it is also not going to be touched by anything besides
this Linux driver".

> > +
> > +             This property may be replaced or supplemented with a reg
> > +             property. Only one of reg or memory-region is required.
> > +
> >  Optional properties:
> >       - Any relevant NUMA assocativity properties for the target platform.
> >
> > @@ -63,3 +75,20 @@ Examples:
> >               volatile;
> >       };
> >
> > +
> > +     /*
> > +      * This example uses a reserved-memory entry instead of
> > +      * specifying the memory region directly in the node.
> > +      */
> > +
> > +     reserved-memory {
> > +             pmem_1: pmem@5000 {
> > +                     no-map;
>
> Just add 'compatible = "pmem-region";' here and be done with it. Why add
> a layer of indirection?

Sure, I'll do that..

> > +                     reg = <0x00005000 0x00001000>;
> > +             };
> > +     };
> > +
> > +     pmem@1 {
>
> No 'reg', so shouldn't have a unit-address here.

..then I guess I can just delete this. v4 incoming.


> > +             compatible = "pmem-region";
> > +             memory-region = <&pmem_1>;
> > +     };
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
