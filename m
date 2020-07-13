Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5621DA48
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 17:40:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4A5C117FA595;
	Mon, 13 Jul 2020 08:40:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78D5D117E12B1
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 08:39:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so14075549edb.3
        for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=du57OarKMFj2//aqQNh8usAhJGOEHYQoIDCsSqzfRrA=;
        b=p5NtX2gb+X8NBTzJ3q4wi1YSieEG+HNt+0otz/H/s/4MmLGrJII8dW/W0UVEpeW0Hg
         qC3dEPnVuhhvBwHhOLmT0GIL1CYUYMo9ubUoSer6T64yW74mkvzKKDKlZDVr19K+cYri
         LtlbMnBKoOcwmDXe/2csa9LQ7/dQV+rttec6lQsYqYKQLaZDSoi1NaLa2MvaowwAoBYv
         FeI+RRFcbGjItkCjE4SunsxqoBYnRp76pca1wVuHw/7y67Q/sHjhAzl/ezQtIiTEEG4j
         yQVjwihttrowt+w804UNoet1fmlmsFKNkFYmUigdIXnkpiItEwYkP2N/ahsYzcyDUeNq
         Dsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=du57OarKMFj2//aqQNh8usAhJGOEHYQoIDCsSqzfRrA=;
        b=bv473GJGL1VIDUKhQM2cDsVy1MYE9P7tqaru/5P8QOIufjStdpSL7l4EQr1Osh7QWm
         KPGAguxpFW16FieDhcqRxjYaMFo9xq5J2h5PfpWaiFzlS6M1ASbfl0RCZj8/wMoHhzz/
         XKg0Op44EE2kzEb+4x3OsqqMSbwzbfXqmDo9s/HRU2pVZG6qY8b6UhqbgoaSI+9JMFfQ
         p1Hqc2wk+BpfQdlq+hs0bbQllg5M2uESfz1CmI3aC/eEGnq2Sa426zftTqyU2YBFhqas
         U5Zy2hiWh8IbjWg/kl6si89ZPiN6kYfhjxPF31V5M30Ly1LG102mnTndNvItAlmHL+hF
         NvEQ==
X-Gm-Message-State: AOAM5322SS5mHQbREOPnmQ/gnLDzD5160tXUWi5JPm6UHIw95cbU8Atd
	yEFtW1mHeM18Ge9+PO3H1QM6eZYwgb9XaJlW46qALQ==
X-Google-Smtp-Source: ABdhPJwvCxFFHwbU4mztcnMn5QN22D7JN5cZqYOUrLmDBOAdReDdsMY67wCR/9JL04AtkGrUTxK3CfgbBEbrs6JuO2k=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr95634335edo.123.1594654794604;
 Mon, 13 Jul 2020 08:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com>
In-Reply-To: <20200712170945.GA194499@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 Jul 2020 08:39:43 -0700
Message-ID: <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID-Hash: DAPPWPKQ6QRNSXK5TOTY7DBENHLHBXZR
X-Message-ID-Hash: DAPPWPKQ6QRNSXK5TOTY7DBENHLHBXZR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DAPPWPKQ6QRNSXK5TOTY7DBENHLHBXZR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > sysfs input string that might contain a trailing newline.
> >
> > The other "device by name" interfaces,
> > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > strings.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67d39a90b45c..5d31b962c898 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> >
> >       klist_iter_init(&parent->p->klist_children, &i);
> >       while ((child = next_device(&i)))
> > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
>
> Who wants to call this function with a name passed from userspace?
>
> Not objecting to it, just curious...
>

The series that incorporates this patch adds a partitioning mechanism
to "device-dax region" devices with an:
    "echo 1 > regionX/create" to create a new partition / sub-instance
of a region, and...
    "echo $devname > regionX/delete" to delete. Where $devname is
searched in the child devices of regionX to trigger device_del().

This arrangement avoids one of the design mistakes of libnvdimm which
uses a sysfs attribute of the device to delete itself. Parent-device
triggered deletion rather than self-deletion avoids those locking
entanglements.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
