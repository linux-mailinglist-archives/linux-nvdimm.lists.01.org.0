Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D885630B25B
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 22:55:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25326100EA911;
	Mon,  1 Feb 2021 13:55:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB93A100EA90C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 13:55:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b9so7159812ejy.12
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZDofSxjQfRvCD9og+/lS0h09No2LY/OIRXR8uXND+Y=;
        b=n/z8H83/8L7uutAMt7vBH/0PM6mOT4y6pk0N26xWUl6K+PVgCDp+YXxmyzAL/MNeYh
         FhyEJ+t3PDTgPqvNYAwrmu/2KJ3RSWWl25QxaeD/NM47uE2zcoMu8RcyoSL8izErXY6l
         E3EJtJY7XxeoodByW/FBN5conQMjdj+7X+ZWMb1sp1jVzYgjowklKOspBFlhffuWjaUF
         k1lqgo0WuzZ8ko2jjsDPMOV1KCcBrq7Nvugt5PiU7GKEa+IweAe0Eyy2Ee1Y28XzLmQf
         LczqNPRsAkEeW5JyJaL57yMfWD/dMourQswAGFX+THDobxnkQn4fgT0unLYSJSgoQfCN
         Owbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZDofSxjQfRvCD9og+/lS0h09No2LY/OIRXR8uXND+Y=;
        b=NjkzyHxRkteoOpH+qWAM/xWC1AfB7hjGNlwSC/1TDsljR6dCmHWp8KuccHAQr7973B
         +GWslCy3xV/HyNWntb9GIVgIjFM1UqBz5TWQnZMRNWAXnS4xmMb0/bp8zuDhxQG1WgCq
         v8r3bLFBRKfNZJF2WLkJOGEEteBSqI+jASGPq5pNrBHfPnLX5T9UBq03ecfk6cZUmgeM
         J7+tcUfaooZ2+/0r8rQW3nO9Hy8yU0rUTNK9XD5mhrggrHpoBRYW2gbyZVzlSEU5AAls
         qt2zjKEQPE0i2RssI+dF//QRM1n0bK8Uqngs9EeNhWMd0uui+OjkKg09pyRL4sUUr42m
         y4VQ==
X-Gm-Message-State: AOAM5329yKSNTLPNWB2SrGhjH89MIt+hswx89vaQ2akxCAKuR+V79m6A
	Hdlnpva/xp2dh6Bng+uZxv1wFIGJ8YpnBn/kc3qvQrR2UlE=
X-Google-Smtp-Source: ABdhPJyxAL1XKv5D2YhZQKaxNMuYpOLaoo1o74ufOqhfWO37NIhZqqr71tGZugmaHwjESA7U8g36q/2EI+yerB5qhlw=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr20233700ejb.323.1612216523281;
 Mon, 01 Feb 2021 13:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-6-ben.widawsky@intel.com> <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
 <20210201171051.m3cbr3udczxwghqh@intel.com> <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
In-Reply-To: <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 13:55:20 -0800
Message-ID: <CAPcyv4jCsv-5TpOFtc6zNG5y4ZSRBnXOuurMx-hkm7AhYZ2b+g@mail.gmail.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
To: David Rientjes <rientjes@google.com>
Message-ID-Hash: WY62E5RRSEKVSZMKPGR2EIGUCTX36DDQ
X-Message-ID-Hash: WY62E5RRSEKVSZMKPGR2EIGUCTX36DDQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WY62E5RRSEKVSZMKPGR2EIGUCTX36DDQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 1:53 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > new file mode 100644
> > > > index 000000000000..fe7b87eba988
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > @@ -0,0 +1,26 @@
> > > > +What:            /sys/bus/cxl/devices/memX/firmware_version
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "FW Revision" string as reported by the Identify
> > > > +         Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > > > +
> > > > +What:            /sys/bus/cxl/devices/memX/ram/size
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "Volatile Only Capacity" as reported by the
> > > > +         Identify Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > > > +
> > > > +What:            /sys/bus/cxl/devices/memX/pmem/size
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "Persistent Only Capacity" as reported by the
> > > > +         Identify Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > >
> > > Aren't volatile and persistent capacities expressed in multiples of 256MB?
> >
> > As of the spec today, volatile and persistent capacities are required to be
> > in multiples of 256MB, however, future specs may not have such a requirement and
> > I think keeping sysfs ABI easily forward portable makes sense.
> >
>
> Makes sense, can we add that these are expressed in bytes or is that
> already implied?

Makes sense to declare units here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
