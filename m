Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBFB319035
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 17:43:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5996A100EA92F;
	Thu, 11 Feb 2021 08:43:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55196100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 08:43:28 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id n28so4578196qtv.12
        for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TnTqaJo6o1YbIsxOlUU5El2AYFoCRaTMv2k74gwpYCk=;
        b=j7wENnRNfYfPWqF0G9QGfDUzZk153Z4UQUmIveNotABQDwPIRR70vxmq35a7doUKCZ
         /HcvOQ86RpZiIANzXlYIfy+cAgGoUtdPhMADXIwhA2mdI+cZmuULVLbyvajkEAzTFDUD
         HlQENYNoYVeOG5qtbcqxQm6f93n6rMe0lE2Q/7B1Q0BVTLr+Tv6TXhbb4QBf/RUGDOIL
         jvNkGUYiXZOX9S7SYbN6U7aMi36Jvs+F6dKWmArqhvay3h5S4R8nxzeejQBYTIaCr8Lu
         7ak3Pb8RxDoS2+C/OcgfbO/o40kFyaZsGykValmew5XF14xbnK46yn5yPxRz3jn4yz/o
         OW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TnTqaJo6o1YbIsxOlUU5El2AYFoCRaTMv2k74gwpYCk=;
        b=Sl6gFXaETn/HW+e8Uttd0ccEjgfFrJPdQrAVOA7bJU81mcPDjK1AKB71XH4Hhx6343
         os8Am9cylIapx4SZk+NT2Vy7d7eslCNeT4z2SEE8sQCFYeGXnASQ3FzALJr1YXg/LByA
         OFa1v6xEKkksnD+De3Ce5ZsSB3tRfc1BkUqiaR9cdgYYjcUWo3l91zq7/5YMEoLle4dm
         lJEwu1amvcG1nJcjTe4C4Sop6eBGF60O+yiGkWXZMivzQkYArEVWzRMHEx+0yznOB+gv
         UTluIbIjufRAqMvVlSp56S+w4wivX6RdW+I2YG2th/202IV8CTx55J8bUU51xZr4DX8S
         eOJQ==
X-Gm-Message-State: AOAM530ci0KCGY4XCBwvf72d9Wx16pW9pLrsGw43yAVxgW1ITHnym/lh
	UXNNTXoqj9OG653AUqQBWHtvJvKIvJvCc0gNgtXwgw==
X-Google-Smtp-Source: ABdhPJyIzcNVaFrr0OmiD16y+FCSfW1u7IpTJXN6zk3LpMSJgVXwchFQE+2/kSNg4CVmCoH61WURtiFXXMwaao4ZUhM=
X-Received: by 2002:ac8:59d6:: with SMTP id f22mr8369890qtf.230.1613061807236;
 Thu, 11 Feb 2021 08:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-6-ben.widawsky@intel.com> <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB36455574E25237635D3F9CC0888D9@MN2PR11MB3645.namprd11.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Feb 2021 08:43:16 -0800
Message-ID: <CAPcyv4i9q8CaOehPDe2m7gSWVmRtSxX37G8+D8RdCgiL6jt1JA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] cxl/mem: Add a "RAW" send command
To: Ariel.Sibley@microchip.com
Message-ID-Hash: XVQTDSRCZUBAEVV6AIHIZAY3OMH62TGF
X-Message-ID-Hash: XVQTDSRCZUBAEVV6AIHIZAY3OMH62TGF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, Sean V Kelley <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 10, 2021 at 7:27 AM <Ariel.Sibley@microchip.com> wrote:
>
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index c4ba3aa0a05d..08eaa8e52083 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -33,6 +33,24 @@ config CXL_MEM
> >
> >           If unsure say 'm'.
> >
> > +config CXL_MEM_RAW_COMMANDS
> > +       bool "RAW Command Interface for Memory Devices"
> > +       depends on CXL_MEM
> > +       help
> > +         Enable CXL RAW command interface.
> > +
> > +         The CXL driver ioctl interface may assign a kernel ioctl command
> > +         number for each specification defined opcode. At any given point in
> > +         time the number of opcodes that the specification defines and a device
> > +         may implement may exceed the kernel's set of associated ioctl function
> > +         numbers. The mismatch is either by omission, specification is too new,
> > +         or by design. When prototyping new hardware, or developing /
> > debugging
> > +         the driver it is useful to be able to submit any possible command to
> > +         the hardware, even commands that may crash the kernel due to their
> > +         potential impact to memory currently in use by the kernel.
> > +
> > +         If developing CXL hardware or the driver say Y, otherwise say N.
>
> Blocking RAW commands by default will prevent vendors from developing user space tools that utilize vendor specific commands. Vendors of CXL.mem devices should take ownership of ensuring any vendor defined commands that could cause user data to be exposed or corrupted are disabled at the device level for shipping configurations.

What follows is my personal opinion as a Linux kernel developer, not
necessarily the opinion of my employer...

Aside from the convention that new functionality is always default N
it is the Linux distributor that decides the configuration. In an
environment where the kernel is developing features like
CONFIG_SECURITY_LOCKDOWN_LSM that limit the ability of the kernel to
subvert platform features like secure boot, it is incumbent upon
drivers to evaluate what they must do to protect platform integrity.
See the ongoing tightening of /dev/mem like interfaces for an example
of the shrinking ability of root to have unfettered access to all
platform/hardware capabilities.

CXL is unique in that it impacts "System RAM" resources and that it
interleaves multiple devices. Compare this to NVME where the blast
radius of misbehavior is contained to an endpoint and is behind an
IOMMU. The larger impact to me increases the responsibility of CXL
enabling to review system impacts and vendor specific functionality is
typically unreviewable.

There are 2 proposals I can see to improve the unreviewable problem.
First, of course, get commands into the standard proper. One strawman
proposal is to take the "Code First" process that seems to be working
well for the ACPI and UEFI working groups and apply it to CXL command
definitions. That vastly shortens the time between proposal and Linux
enabling. The second proposal is to define a mechanism for de-facto
standards to develop. That need I believe was the motivation for
"designated vendor-specific" in the first instance? I.e. to share
implementations across vendors pre-standardization.

So, allocate a public id for the command space, publish a public
specification, and then send kernel patches. This was the process for
accepting command sets outside of ACPI into the LIBNVDIMM subsystem.
See drivers/acpi/nfit/nfit.h for the reference to the public command
sets.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
