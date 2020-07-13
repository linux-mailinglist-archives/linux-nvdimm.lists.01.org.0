Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1121DB45
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 154E21181290D;
	Mon, 13 Jul 2020 09:09:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16E47118128FB
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so14127687edb.11
        for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=r7ELJ2cBdTaQzo9pqUPojaVz6tHhKqoH2KZY2zuAlJN0hbnOqbT4c12Oy38pcBR/Nj
         utOjvomkH01KnV48ustA657XHya8dxhiC4zKoTXDfmRE5M9q3CaTL/2f1Ttg6runvIq7
         RWnzutbQaMQZuQkbRYM6KLs9dYVs2pWP8m2YSi7TYPnwA2kYkHbV3zTVnZD3+aGspwQv
         visTBbIeQ8KXGdQAzK/GZmGnfQOSTPpyx1Y/65IykomzQzj2jp7TFsb05AzbD0WDujBa
         O7/7Q4OI36y4JCe9b58Hkm5W/23aJBSWmta1Co+BkMqTd+7t5uECfERRweordez+CtHr
         OHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPX1344KqFXDG152MSs7m1f71nuvQxMI0VbbfK01bWI=;
        b=aQy+RAP3Yp73dW3FS5PIU3oeuQQHL1Gud4+ZPU+w8XKnI3EFyl2G4lwLTCkoALLJCT
         DJCWBfDPwls1k2LG+KvXPc6+npuGZ+yOg8eL7oAOeZvdPkZpOfuqI67Ks4T87c5dc1ae
         RP3ktShAMjntfffwyGxA+YtdXgnxyA59DzS2j0AD9l68aopCDKERwDwnuYhTYlqPdi+m
         uL4Ci8AvQE/8bIFHxQUov4aEFwakT8HXHsR9lGRRFb8LepplBP/pjxpt/InylSG5aJQA
         UwhEgZcRoSgz2+psr2xXgGQcWbIx6CJOvopEhIbSY+OPpWlKZw8veb5EP2ISzNgP7onz
         XIOg==
X-Gm-Message-State: AOAM533wI1WDGcNtgUUYwiOlfAGITMg1YDMQng78jcZkqBuGq1jfxIy8
	J5KxiZGdXAzkClTI1HDV1TGk9fyVNd/B1X27SstuNA==
X-Google-Smtp-Source: ABdhPJzkfFp48TgN6o9u+tichXDgD3w2nI1pgUIrildgifHznsxd6AynKdQoAl6SqJnCRUpI/mZg24+ERLg8WLos9MU=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr95726edr.383.1594656569387;
 Mon, 13 Jul 2020 09:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com> <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
 <20200713155222.GB267581@kroah.com>
In-Reply-To: <20200713155222.GB267581@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 Jul 2020 09:09:18 -0700
Message-ID: <CAPcyv4ijb3nS3WuO38Yn3epBec8uQqw+UfimqFByqRT9QXCpLw@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID-Hash: WA2XNDJZBZL537BTVWFKTJJRSGUE7C6S
X-Message-ID-Hash: WA2XNDJZBZL537BTVWFKTJJRSGUE7C6S
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WA2XNDJZBZL537BTVWFKTJJRSGUE7C6S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2020 at 8:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> > On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > > sysfs input string that might contain a trailing newline.
> > > >
> > > > The other "device by name" interfaces,
> > > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > > strings.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/base/core.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 67d39a90b45c..5d31b962c898 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > > >
> > > >       klist_iter_init(&parent->p->klist_children, &i);
> > > >       while ((child = next_device(&i)))
> > > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> > >
> > > Who wants to call this function with a name passed from userspace?
> > >
> > > Not objecting to it, just curious...
> > >
> >
> > The series that incorporates this patch adds a partitioning mechanism
> > to "device-dax region" devices with an:
> >     "echo 1 > regionX/create" to create a new partition / sub-instance
> > of a region, and...
> >     "echo $devname > regionX/delete" to delete. Where $devname is
> > searched in the child devices of regionX to trigger device_del().
>
> Shouldn't that be done in configfs, not sysfs?

I see configfs as an awkward fit for this situation. configfs wants to
software define kernel objects whereas this facility wants to augment
existing kernel enumerated device objects. The region device is
created by firmware policy and is optionally partitioned, configfs
objects don't exist at all until created. So for this I see sysfs +
'scheme to trigger child device creation' as just enough mechanism
that does not warrant full blown configfs.

I believe it was debates like this [1] that have led me to the camp of
sysfs being capable of some device creation dynamism and leave
configfs for purely software constructed objects.

[1]: https://lore.kernel.org/lkml/17377.42813.479466.690408@cse.unsw.edu.au/

> > This arrangement avoids one of the design mistakes of libnvdimm which
> > uses a sysfs attribute of the device to delete itself. Parent-device
> > triggered deletion rather than self-deletion avoids those locking
> > entanglements.
>
> Ugh, yeah, getting rid of that would be great, it's a mess.  I think
> scsi still does that :(

Yeah, both nvdimm and scsi both end up need to delay device deletion
to its own thread, and it has led to bugs in the nvdimm case.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
