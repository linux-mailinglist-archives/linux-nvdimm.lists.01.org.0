Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7B21A771
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 21:04:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB5C711427DB8;
	Thu,  9 Jul 2020 12:04:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A8A7111FF49B
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 12:04:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so3455895eje.1
        for <linux-nvdimm@lists.01.org>; Thu, 09 Jul 2020 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HVrknSfL8ql+C23zw01ZWqmehR9FZjHU4JZV921bnc=;
        b=o4cabljzdVbvDH8O8NkX8+BhJj0J92SAVsLoM3pNwetYQiDTkMzoiHBSoqyaRCcbpK
         bN3H0cE8VPe0X8dPdyd/BZYyO+ePbrAUQeTD7LGWSgFlwWmvOq1I4F8T9cXBObRwQrfb
         xRsYODmdA8314Xm7gGM+KNWAbt51b9QDUygBTUXBh8Xm0dHfvJ1WUpm0UCoz8Jw3Hhba
         fV23BgNXazQOXhAW9gek7HPXWykmppTF8Wc1jXbRlz40p5qbgf0OebvTVWFAxmt7CfSF
         LtfGadVLwFXU7Xfp5ZdVQCjvZoXK5ec7UnKtie+S8Sjfg3ZDbDegw+0zJ/gMp4vDAUIN
         5m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HVrknSfL8ql+C23zw01ZWqmehR9FZjHU4JZV921bnc=;
        b=ILDR/QTEG0+5BhYJL0cPjs34oG/IMar92daXSVQvF17ZnAb1+bhkD4LFi7zvRigZyK
         /e9CUUzfwuLsoyIVuLQPSFkAMO9e/sF7Oa68iNrBhuGl2D1uxP7wyXTA/u8pqxjOGp8u
         OfLGLiHuHmdVvVplV1M1xBlg/810CQCwXVIFk8K1a+oy8cTZgKBOuS6wDOpitC4igkQh
         UNn08Myn8SRSYX/QfOS3g/gPClbsM/dqMbCUB5fF06o0NAWn9dBNGLwicwUTFdpBYzcF
         QNBbIwGUhWlJNheIU94iEWMSpoCtkSa4X/P96rp+V2dgdHuZKpPplkIy6F3Zj08sCocp
         hKRg==
X-Gm-Message-State: AOAM530Gev2EkJXByHg2oBUyJxgWUlTxoLnsYhH4UOIbZAXhUncyZ2Re
	xoALLNrKeU27m4UJbQc8N+wkaYmpUbKty1myoSjOtg==
X-Google-Smtp-Source: ABdhPJzUIwtwWlF5/vzyXp5OGJ+9E9DozhqBCwMNVckhSLhoi82zOvGsERiI6MqqXzGdkmHx0OKIBGLsGNdCW4aEY40=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr56909701ejf.455.1594321482210;
 Thu, 09 Jul 2020 12:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <23449996.3uVv1d17cZ@kreacher>
In-Reply-To: <23449996.3uVv1d17cZ@kreacher>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Jul 2020 12:04:30 -0700
Message-ID: <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: JS5YOLQO7FQVSFNOABUTXFMRQP6ID224
X-Message-ID-Hash: JS5YOLQO7FQVSFNOABUTXFMRQP6ID224
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JS5YOLQO7FQVSFNOABUTXFMRQP6ID224/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2020 at 7:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
> > The runtime firmware activation capability of Intel NVDIMM devices
> > requires memory transactions to be disabled for 100s of microseconds.
> > This timeout is large enough to cause in-flight DMA to fail and other
> > application detectable timeouts. Arrange for firmware activation to be
> > executed while the system is "quiesced", all processes and device-DMA
> > frozen.
> >
> > It is already required that invoking device ->freeze() callbacks is
> > sufficient to cease DMA. A device that continues memory writes outside
> > of user-direction violates expectations of the PM core to be to
> > establish a coherent hibernation image.
> >
> > That said, RDMA devices are an example of a device that access memory
> > outside of user process direction. RDMA drivers also typically assume
> > the system they are operating in will never be hibernated. A solution
> > for RDMA collisions with firmware activation is outside the scope of
> > this change and may need to rely on being able to survive the platform
> > imposed memory controller quiesce period.
>
> Thanks for following my suggestion to use the hibernation infrastructure
> rather than the suspend one, but I think it would be better to go a bit
> further with that.
>
> Namely, after thinking about this a bit more I have come to the conclusion
> that what is needed is an ability to execute a function, inside of the
> kernel, in a "quiet" environment in which memory updates are unlikely.
>
> While the hibernation infrastructure as is can be used for that, kind of, IMO
> it would be cleaner to introduce a helper for that, like in the (untested)
> patch below, so if the "quiet execution environment" is needed, whoever
> needs it may simply pass a function to hibernate_quiet_exec() and provide
> whatever user-space I/F is suitable on top of that.
>
> Please let me know what you think.

This looks good to me in concept.

Would you expect that I trigger this from libnvdimm sysfs, or any
future users of this functionality to trigger it through their own
subsystem specific mechanisms?

I have a place for it in libvdimm and could specify the activation
method directly as "suspend" vs "live" activation.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
