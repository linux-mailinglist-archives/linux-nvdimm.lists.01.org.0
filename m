Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78230B253
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 22:53:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB27D100EA90C;
	Mon,  1 Feb 2021 13:53:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECFC8100EA908
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 13:53:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 8so5480032plc.10
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 13:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=N6tU/hkqNUMYsHM0IUqTnCXIZDB8nb2QJ5YhEZMP+tE=;
        b=WZi+UCs9TIbCUorANOZIg1lacKJyrLAcxNgjqYv2hNfd0YCcWVUr7BGsWFb1LJIeln
         UelOikGZSyHtnr85jilxjPtGr9ZrM138I2fxLqj7VzG8BUYH/s6nx67rVjthtycndIQX
         L3fGAZD1a7UEf5TUkzE8WDjRzAznsbPZomOWfxve4P0qqnIX7Kb2xvvbK6O5gtVEHUqw
         vBxXHHfsMMe0vFxzNCHdspQP6sYm6XDirkDgPU/KcOLz+prvZoNhzG2Py/aSLNALyU/E
         3RqDEnEBvUa0+i2+s4SRsa3p3nhYWglPsFE5vBFTZtM/lOExGpoLoTxaNVZstQlDpviD
         6EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=N6tU/hkqNUMYsHM0IUqTnCXIZDB8nb2QJ5YhEZMP+tE=;
        b=m4tEjIW9t6k2Se9u+hUN7F7XFM9/uMmnhEteow9I8TWBstctF90PIYPNknl4/nnJig
         B3gBTMKdz0J9nHmx07Ijix/mYp1nnIC7wdCVcGtgwyFevVa7amiu1rzTUQIEj1PC8ZSW
         zOYjLh4LyteN2A/5ZrIHzo08fuuOOxidN8UgsVsCBatfyiKGwyr0PY+0T136G/+rvIRn
         8d5Bf5LsZO+4up3w7s0z6pZ+Dkn1PBtVCExPt/OikchnNA54ARKbHjpSezemNCRa7GEe
         +B7dO229MCXG06+lt9ajI+sEd3yu9rJAm/hsVpdCJ43Svezpy2zTRtSXH47HFSfjxfRP
         BXWg==
X-Gm-Message-State: AOAM532Xs0B10GQr69Z/EQijrFq9o+YMqq67iSRnLXBEvNzG6Tj8dz3P
	d3tq+fdNcNQIS9mMwJyn5SvOuw==
X-Google-Smtp-Source: ABdhPJycALujIbA4WvZUkZggYo0Ocv7rTw3rYtZTgJzBXpeooffmD1f4WnTwFRQBCWLZpToH49e2uA==
X-Received: by 2002:a17:902:c106:b029:de:af88:80ed with SMTP id 6-20020a170902c106b02900deaf8880edmr19001691pli.35.1612216386313;
        Mon, 01 Feb 2021 13:53:06 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id k128sm18715106pfd.137.2021.02.01.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:53:05 -0800 (PST)
Date: Mon, 1 Feb 2021 13:53:03 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
In-Reply-To: <20210201171051.m3cbr3udczxwghqh@intel.com>
Message-ID: <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com> <ecd93422-b272-2b76-1ec-cf6af744ae@google.com> <20210201171051.m3cbr3udczxwghqh@intel.com>
MIME-Version: 1.0
Message-ID-Hash: ZU44DKZLYVMCNO2ZL765HO4UUMVEVJT3
X-Message-ID-Hash: ZU44DKZLYVMCNO2ZL765HO4UUMVEVJT3
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZU44DKZLYVMCNO2ZL765HO4UUMVEVJT3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > new file mode 100644
> > > index 000000000000..fe7b87eba988
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -0,0 +1,26 @@
> > > +What:		/sys/bus/cxl/devices/memX/firmware_version
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "FW Revision" string as reported by the Identify
> > > +		Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/ram/size
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "Volatile Only Capacity" as reported by the
> > > +		Identify Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/pmem/size
> > > +Date:		December, 2020
> > > +KernelVersion:	v5.12
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(RO) "Persistent Only Capacity" as reported by the
> > > +		Identify Memory Device Output Payload in the CXL-2.0
> > > +		specification.
> > 
> > Aren't volatile and persistent capacities expressed in multiples of 256MB?
> 
> As of the spec today, volatile and persistent capacities are required to be
> in multiples of 256MB, however, future specs may not have such a requirement and
> I think keeping sysfs ABI easily forward portable makes sense.
> 

Makes sense, can we add that these are expressed in bytes or is that 
already implied?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
