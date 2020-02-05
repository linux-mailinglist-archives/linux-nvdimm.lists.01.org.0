Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224E41537F4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 19:23:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA41110FC33E8;
	Wed,  5 Feb 2020 10:26:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95B3810FC33E7
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 10:26:30 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id i1so1712422oie.8
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCKSyIrMJQWi2dVW1d6lMlZcUF4Vpex7BkJoZ7HsUkQ=;
        b=FqyubSBkm08L9enJBWwrAwaBz/5JGqL+SYR8vRtbi4lfeXbty3oXeBf/P2ZwXEgPPQ
         Wy1oC+9Ljg1R7iRIR3OMCteODNhDv8W7OAgfbyd9/7wJnWUu+ARxALDU9mOshgB7YriK
         msoFHz8RX+XaNo8As61qFbufQ/WWchsz4gcCd6yfMM0cMt10lI6noizjCyQSKTi6edmn
         mySBm41GVlZhN7IpTeHg4z3Kad0uwAr5OMNARbl4+jwxcqsQYZGd0th7gtdTxjc4JZUg
         ZHHN4dS/V5ObkDjVGp8Su9bGE+v7vkMNcsDP8CjmNbcj+BHUb5+luw3BHyl+qzJzdgCH
         nszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCKSyIrMJQWi2dVW1d6lMlZcUF4Vpex7BkJoZ7HsUkQ=;
        b=g5SuAG6TnPzmQHpOk68U6Oc8vRDwJ7lhit7frlVXn4AowB0q/5duQLB1oDUfc1eE80
         tCKcjrZ3nm7pGMObmalGDg5tArGQT9c7hJEPaJ52wHJ151TiL83k8ik6CAB8TuGUQIcC
         l4F1hUu08YCcxnyihtjPlxuXKqk0/I3ODe4NiL9St3LVTnmNTb2kSacy+84DoSk0cbKA
         XpQO3afMFUollIWmBOupkQqkcK0703qXOce7bipDSZIuhRXFl+qVlTERRJdOpMUbIZzN
         BdZVItMImQgRYtpqNHCXpv2lbpH5ZnDcYS/C/Oqtal/CF/8yysecTdwa39j9AolAQGhv
         YvcA==
X-Gm-Message-State: APjAAAV/bzkA+AaplUWCyKvUAc44PD0wMrn4JPMyXxHpUhLoKGa95S1C
	Exo8k/HE8ueRgi0OW2aRGvXlpWaAcfS12YS5DjCw0A==
X-Google-Smtp-Source: APXvYqx2AOcVlU3axA5dA1CJpnQZ3D0S8Z7vI9sk9INbhkuWZ3d9B4MTipGux56U2IRyDvbCClmMPPbVwHK8vVpBAhk=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4033494oie.149.1580926991380;
 Wed, 05 Feb 2020 10:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
 <CAPcyv4j12vgjgEgY3xAr9bpV8dd+3E7Q5Q3OFo2AXmwnN45PBA@mail.gmail.com> <20200205181040.GC24804@kadam>
In-Reply-To: <20200205181040.GC24804@kadam>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 10:23:00 -0800
Message-ID: <CAPcyv4itFypOmv38Oo=DRWk_1Y3PFhPpYPDzxShmZVY9ZsTNLA@mail.gmail.com>
Subject: Re: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID-Hash: CRA6X7VDWNZY4WNODCS4JXSW52FJGP4S
X-Message-ID-Hash: CRA6X7VDWNZY4WNODCS4JXSW52FJGP4S
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CRA6X7VDWNZY4WNODCS4JXSW52FJGP4S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 10:11 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Feb 05, 2020 at 09:47:01AM -0800, Dan Williams wrote:
> > On Wed, Feb 5, 2020 at 4:38 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > Hello Dan Williams,
> > >
> > > The patch 4d88a97aa9e8: "libnvdimm, nvdimm: dimm driver and base
> > > libnvdimm device-driver infrastructure" from May 31, 2015, leads to
> > > the following static checker warning:
> > >
> > >         drivers/nvdimm/bus.c:511 nd_async_device_register()
> > >         error: dereferencing freed memory 'dev'
> > >
> > > drivers/nvdimm/bus.c
> > >    502  static void nd_async_device_register(void *d, async_cookie_t cookie)
> > >    503  {
> > >    504          struct device *dev = d;
> > >    505
> > >    506          if (device_add(dev) != 0) {
> > >    507                  dev_err(dev, "%s: failed\n", __func__);
> > >    508                  put_device(dev);
> > >                         ^^^^^^^^^^^^^^^
> > >    509          }
> > >    510          put_device(dev);
> > >                 ^^^^^^^^^^^^^^
> > >    511          if (dev->parent)
> > >    512                  put_device(dev->parent);
> > >    513  }
> > >
> > > We call get_device() from __nd_device_register(), I guess.  It seems
> > > buggy to call put device twice on error.
> >
> > The registration path does:
> >
> >         get_device(dev);
> >
> >         async_schedule_dev_domain(nd_async_device_register, dev,
> >                                   &nd_async_domain);
> >
> > ...and device_add() does its own get_device().
>
> device_add() does its own put_device() at the end so it's a net zero.
>

It does it's own, yes, but the put_device() after device_add() failure
is there to drop the reference taken by device_initialize().
Otherwise, device_add() has always documented:

 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up your
 * reference instead.

...so what am I missing?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
