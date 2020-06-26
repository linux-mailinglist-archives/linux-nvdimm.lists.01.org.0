Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475320ABB6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 07:09:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0B3211022326;
	Thu, 25 Jun 2020 22:09:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33F2311022323
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 22:09:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so8107901ejc.8
        for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 22:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KG6mHyc0pQ6LpydjXYySS5Bs9KvIV7RYbzUJYenScI=;
        b=MK5JsoBT/Fc9UOrTmeD5yT7TMj/v6lrHC1bxrjpT4cDBo31ad6A65Vm9Mk+JEluVx0
         9A86No4Ca02+k88TSPORiykbjsJ0rx1o77TD6JEtvhHTG2NFlkTSALFiq4XpeL86qnc6
         bXiugoNq+Xdu7DUmuy9LEzVvRjNpE1pzWcnonkIsDXbhGIOye8ruIaSOwMlQyKzvtrAh
         Ylck2Gh0x37RXnTYh+uMGHwGSayIidDUhOSJjZ7faq6zCwn5Y/z3NYhtqEqFdDBQsT4U
         v7nn0dFGx++qOYVZ1QYnFElMoy4dbJEq3P+TiaXrInYV6XkZ5OECd0Mm6QIe/PVAu4gY
         17BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KG6mHyc0pQ6LpydjXYySS5Bs9KvIV7RYbzUJYenScI=;
        b=pOajvI0XduWvnsccaYwIjzHFXSirlNhPvCQyYrQBIkJn5+WDkbgYSOQZgVyIpWDYU0
         qIcAsgs/VAVkjnCTK/d3P/FPYR1c2RAvTG8xvcKpbwcLHW7xvwA8pXpU103B0tyaOAxP
         M7nynpk110+noRqrxoSPewbGtb776/A4b7C9Vv+qFI6cG9IKFBAesXwFDRqH7wiRedcR
         S9JssaH8gOuosbE3eFUXGNTP0z15TnqqXiwwlOyuf/z1Rxq+ZCbNS0dYUEtXH7sQW47U
         KYQfI8fytyzavTHzwKZl3xBSooNBKA+12JEXNM5SbvDb4J0+gH/nk/3iFNy5LBPSVtFg
         hGWA==
X-Gm-Message-State: AOAM530tFXHxGoP8VnKj3n1NIITR5onXkV4oxHnjH98qKPsqynegJ2Tw
	ovxS9oiOmm++SP/cE5aWGXu603QgdS28mgZMcL6pzg==
X-Google-Smtp-Source: ABdhPJwSbUQKE9HrD+ejpOvoP1YzH7aH7vlAXTl/tKcNEZckOJ+kb52supggo9Px3oqhAR6MhjzRF0GDnLRcdkRcIzA=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr1067109ejt.440.1593148151705;
 Thu, 25 Jun 2020 22:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159312906372.1850128.11611897078988158727.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200626050611.GA223424@kroah.com>
In-Reply-To: <20200626050611.GA223424@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Jun 2020 22:09:00 -0700
Message-ID: <CAPcyv4jeFTWVYEx74AOhHjbgCJpYwcR7waTDx90artGKBvaKrw@mail.gmail.com>
Subject: Re: [PATCH 08/12] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID-Hash: A3UUOLYLRETT4FDVAHGHXLI5HYMTFIPQ
X-Message-ID-Hash: A3UUOLYLRETT4FDVAHGHXLI5HYMTFIPQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3UUOLYLRETT4FDVAHGHXLI5HYMTFIPQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 25, 2020 at 10:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 25, 2020 at 04:51:03PM -0700, Dan Williams wrote:
> > A common pattern for using plain DEVICE_ATTR() instead of
> > DEVICE_ATTR_RO() and DEVICE_ATTR_RW() is for attributes that want to
> > limit read to only root.  I.e. many users of DEVICE_ATTR() are
> > specifying 0400 or 0600 for permissions.
> >
> > Given the expectation that CAP_SYS_ADMIN is needed to access these
> > sensitive attributes and an explicit helper with the _ADMIN_ identifier
> > for DEVICE_ATTR_ADMIN_{RO,RW}.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  include/linux/device.h |    4 ++++
> >  include/linux/sysfs.h  |    7 +++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 15460a5ac024..d7c2570368fa 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -128,8 +128,12 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
> >               __ATTR_PREALLOC(_name, _mode, _show, _store)
> >  #define DEVICE_ATTR_RW(_name) \
> >       struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
> > +#define DEVICE_ATTR_ADMIN_RW(_name) \
> > +     struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
> >  #define DEVICE_ATTR_RO(_name) \
> >       struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
> > +#define DEVICE_ATTR_ADMIN_RO(_name) \
> > +     struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
> >  #define DEVICE_ATTR_WO(_name) \
> >       struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
> >  #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
> > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > index 86067dbe7745..34e84122f635 100644
> > --- a/include/linux/sysfs.h
> > +++ b/include/linux/sysfs.h
> > @@ -123,6 +123,13 @@ struct attribute_group {
> >       .show   = _name##_show,                                         \
> >  }
> >
> > +#define __ATTR_RW_MODE(_name, _mode) {                                       \
> > +     .attr   = { .name = __stringify(_name),                         \
> > +                 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },          \
> > +     .show   = _name##_show,                                         \
> > +     .store  = _name##_store,                                        \
> > +}
> > +
> >  #define __ATTR_WO(_name) {                                           \
> >       .attr   = { .name = __stringify(_name), .mode = 0200 },         \
> >       .store  = _name##_store,                                        \
> >
>
> Nice!  Want me to take this now, I know of many other places that could
> be cleaned up to use this (like the raw device bug that I just fixed...)

Sure, that'd be great.

> If not:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 Thanks Greg.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
