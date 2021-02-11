Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D424231948A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 21:34:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EBA82100EAAF0;
	Thu, 11 Feb 2021 12:34:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF125100EB82D
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 12:34:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so12113125ejc.1
        for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgwnKmmGdWDCxHejoZP0bKZIVRKg9fBvIThmjXyQsEw=;
        b=T4khnwoqjyVlyFJZe9yf1Hqe4YwtQNZKtdD3iNfNqQ3nG8ihJ93iGi2kdceUV+6WzP
         U30lqWYAoU4mnF/BTzmNiDn4M6OkmoL/HSgxMTpuO8yxCwt9b20YfLoT23FpwzW1dGZV
         bJ9zVra/TCEhEZSE2YLcmboDfhtC1K936PkyqsjxzXjp6koe4GNl9qeIo5TqD11dyDhQ
         rl8C6iPZN9DWwkPlmqnfjSZEIMNUIg8irYR1gK33qxg7+RjyMrbSLaErpObkBK/eVVOw
         as5S3Ag8QkadmDt6w065AidBrxpozcVJ5kcqol0urwlsmpCou6dwkfgMj5QHHlihU880
         k99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgwnKmmGdWDCxHejoZP0bKZIVRKg9fBvIThmjXyQsEw=;
        b=OaxPelKc0aG7hDbY0VGv7nL9SQTizhc4Vnj5eS+YH4hg/EfnvlZLS7nX6rhJBcvfH3
         wOMzXfK1PJzhMFCyqB6bqc5/iwUcS1QJlNd/CCJgNKfCp6V1F2F5LHXMKd+ualP+/sHM
         LP1S/xY6/Ki1x59XxcBwvUr+OPMy4N5Jn5xXFDL3ry1Ni1vjf+F4pA1B8FQpfHZEBlPp
         E9kWgO+WCALi5xalv6UE4l9uzvkcA+8uFliJ6trCsik0GncMG4hm2HOdyR89Ox0jfv5O
         vfaz2vZ+r2IKgLLhjOsC1Wm8a4/ouQKsT1sloGaHZcVCyXxKmTzrB/tJeDbsj+9bJOOb
         i9mw==
X-Gm-Message-State: AOAM533px0mmhb6fZXGC8JUB87sjckDcmFsLtfLiBcjAiceZ0vxFg6nY
	LGfETV+Tc/JL92EypNiVi87V8US3RWNLsqrAHTalEg==
X-Google-Smtp-Source: ABdhPJyw5zAj09pkfw9O4vZ91q761XWqJWsJYNmylmwXEAFa0RMljdC5RPj7aoX4jj2C6VUAHgj24Ehk/wHibuXDiBo=
X-Received: by 2002:a17:906:36cc:: with SMTP id b12mr10342308ejc.323.1613075685691;
 Thu, 11 Feb 2021 12:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-7-ben.widawsky@intel.com> <20210211120215.00007d3d@Huawei.com>
 <20210211174502.72thmdqlh2q5tdu3@intel.com>
In-Reply-To: <20210211174502.72thmdqlh2q5tdu3@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Feb 2021 12:34:35 -0800
Message-ID: <CAPcyv4iXYxTc5uu7Jq0=X9C0+5QW8ZbnwebhWAw5c2DhwqY72Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cxl/mem: Enable commands via CEL
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: RGFR7QHS3LOXKVZRDRJQGLQ56BNXBSNK
X-Message-ID-Hash: RGFR7QHS3LOXKVZRDRJQGLQ56BNXBSNK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RGFR7QHS3LOXKVZRDRJQGLQ56BNXBSNK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 9:45 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > +   if (mbox_cmd.size_out > sizeof(gsl)) {
> > > +           dev_warn(dev, "%zu excess logs\n",
> > > +                    (mbox_cmd.size_out - sizeof(gsl)) /
> > > +                            sizeof(struct gsl_entry));
> >
> > This could well happen given spec seems to allow for other
> > entries defined by other specs.
>
> Interesting. When I read the spec before (multiple times) I was certain it said
> other UUIDs aren't allowed. You're correct though that the way it is worded,
> this is a bad check. AIUI, the spec permits any UUID and as such I think we
> should remove tainting for unknown UUIDs. Let me put the exact words:
>
> Table 169 & 170
> "Log Identifier: UUID representing the log to retrieve data for. The following
>  Log Identifier UUIDs are defined in this specification"
>
> To me this implies UUIDs from other (not "this") specifications are permitted.
>
> Dan, I'd like your opinion here. I'm tempted to change the current WARN to a
> dev_dbg or somesuch.

Yeah, sounds ok, and the command is well defined to be a read-only,
zero-side-effect affair. If a vendor did really want to sneak in a
proprietary protocol over this interface it would be quite awkward.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
