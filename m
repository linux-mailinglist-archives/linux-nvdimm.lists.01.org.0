Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AA31949F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 21:41:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 838F5100EA2C3;
	Thu, 11 Feb 2021 12:40:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 88E6C100EA2C1
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 12:40:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id q2so8325671eds.11
        for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=coyflfwbCdbsJ3zzo0z6wSKT59iLTCQVdnZtGrbaNG8QIdR39uPo9V6tfCTRydcisL
         4k5JGnBJW2bwe/Y98Ay8kKjlpA7C1M7t5HKlvHlD2W0hs4hkrrX9jMaaFPooSlzZaqeb
         qnbKvbKvtFMP2Gcb2JhAqzQcRwHeCtf4BKRWIpIIHZen8wJEdzLIzoQePkCym3WVdGd/
         8amklPn5Y1DQDOGZ65J3q4g6AmlJfZBY5cUKedCA145v+34ax7wnmlls4kKFRLPdURDS
         HwZMs0P9MDREJORNNWoZRXavVtngNRUPbTJE6VBjR5mURUsu/qMEf25CUKIaBzJwIfJh
         67gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=QKAxTuCqGcXrv3tGn+LgYxf7o4hlWGmLxNmgVwyrCxrJibJ+uUzJUkA5cvi6l0VDif
         0pSfzDKFztN0WKR+pZDSMQ0gCgFwA4SMjuvyWDoNsvLQg6/prztJw+XozOSwmW37vfeC
         s7UA29r8BHrLl/KmxSD+SCMqNI+q4Z3UwFT6Kc446qFO4/aXhdvqKz5MxWm4sVEDgeie
         JvhD+U7WJKJiZUGg8WifKdb3x9HVdPVNv5eShCo0FK3/tQBZKlL1yio3b9al9JoWEANC
         tp+/mn3XgUbxtsIU9Epti80Wx+pewMlP5ncL1ALZkSW8SFSRBgiYn5kSaXq0T9C/zoGC
         Pjtw==
X-Gm-Message-State: AOAM531yq2Y+8phokwQh8TsnSOhmMm0BuGpGVjqS72ch6IrUpls0qnko
	j6wnbe2B/Y2dkGkykZBU6J4sXam0myI8oplTxOL9Jg==
X-Google-Smtp-Source: ABdhPJwUwoQIw5/TCL2CLB2ZlTQ8uewrH9tgE5Yw4rRMQ6jMgq9i5WT/KqL+JKgKKFkIg69ICnqn7QI9yjjwV0IjT0U=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr9870835edc.97.1613076055992;
 Thu, 11 Feb 2021 12:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-4-ben.widawsky@intel.com> <20210210181725.00007865@Huawei.com>
 <20210211101746.00005e8c@Huawei.com>
In-Reply-To: <20210211101746.00005e8c@Huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Feb 2021 12:40:45 -0800
Message-ID: <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID-Hash: J74EGGAFCMXYBECRY6M47RBJF3W35QX5
X-Message-ID-Hash: J74EGGAFCMXYBECRY6M47RBJF3W35QX5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J74EGGAFCMXYBECRY6M47RBJF3W35QX5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 2:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Feb 2021 18:17:25 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 9 Feb 2021 16:02:54 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Create the /sys/bus/cxl hierarchy to enumerate:
> > >
> > > * Memory Devices (per-endpoint control devices)
> > >
> > > * Memory Address Space Devices (platform address ranges with
> > >   interleaving, performance, and persistence attributes)
> > >
> > > * Memory Regions (active provisioned memory from an address space device
> > >   that is in use as System RAM or delegated to libnvdimm as Persistent
> > >   Memory regions).
> > >
> > > For now, only the per-endpoint control devices are registered on the
> > > 'cxl' bus. However, going forward it will provide a mechanism to
> > > coordinate cross-device interleave.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > One stray header, and a request for a tiny bit of reordering to
> > make it easier to chase through creation and destruction.
> >
> > Either way with the header move to earlier patch I'm fine with this one.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Actually thinking more on this, what is the justification for the
> complexity + overhead of a percpu_refcount vs a refcount

A typical refcount does not have the block and drain semantics of a
percpu_ref. I'm planning to circle back and make this a first class
facility of the cdev interface borrowing the debugfs approach [1], but
for now percpu_ref fits the bill locally.

> I don't think this is a high enough performance path for it to matter.
> Perhaps I'm missing a usecase where it does?

It's less about percpu_ref performance and more about the
percpu_ref_tryget_live() facility.

[1]: http://lore.kernel.org/r/CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
