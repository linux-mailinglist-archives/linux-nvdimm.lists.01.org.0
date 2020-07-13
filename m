Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B597221DACD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 17:52:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0EFC6117FA5B5;
	Mon, 13 Jul 2020 08:52:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC60F117E12BC
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 08:52:22 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id BE59D20663;
	Mon, 13 Jul 2020 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594655542;
	bh=Hcixoq4GgPe0VCO4s6wUL8CqrZev3dIhKbWRkkOIrHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wl1NZRBGSi7cAVo8NztdIgBUgTQWNZEa4wL/fa93EpRcWtMHAVzi3ljykDEsPT7wY
	 BSBmd7lLUo8a3wfMaWGkV93gEjLWGvbSbLjl6M/KlXZmAT7YEM7cfQHpIRkS5IlY1V
	 vqCxN5LtjDOFOi7FWjtCOOK9yB+Z9NghG6kRstTs=
Date: Mon, 13 Jul 2020 17:52:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 17/22] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
Message-ID: <20200713155222.GB267581@kroah.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457125753.754248.6000936585361264069.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200712170945.GA194499@kroah.com>
 <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4h=7oB+PHEUa6otkoXYx+r_8GFbmuF-j_kOmHjpGB-=eg@mail.gmail.com>
Message-ID-Hash: LT3MFOAKVLVWPTY2EA7XLWARZBMKGLMA
X-Message-ID-Hash: LT3MFOAKVLVWPTY2EA7XLWARZBMKGLMA
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LT3MFOAKVLVWPTY2EA7XLWARZBMKGLMA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2020 at 08:39:43AM -0700, Dan Williams wrote:
> On Sun, Jul 12, 2020 at 10:09 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jul 12, 2020 at 09:27:37AM -0700, Dan Williams wrote:
> > > Use sysfs_streq() in device_find_child_by_name() to allow it to use a
> > > sysfs input string that might contain a trailing newline.
> > >
> > > The other "device by name" interfaces,
> > > {bus,driver,class}_find_device_by_name(), already account for sysfs
> > > strings.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/base/core.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 67d39a90b45c..5d31b962c898 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -3078,7 +3078,7 @@ struct device *device_find_child_by_name(struct device *parent,
> > >
> > >       klist_iter_init(&parent->p->klist_children, &i);
> > >       while ((child = next_device(&i)))
> > > -             if (!strcmp(dev_name(child), name) && get_device(child))
> > > +             if (sysfs_streq(dev_name(child), name) && get_device(child))
> >
> > Who wants to call this function with a name passed from userspace?
> >
> > Not objecting to it, just curious...
> >
> 
> The series that incorporates this patch adds a partitioning mechanism
> to "device-dax region" devices with an:
>     "echo 1 > regionX/create" to create a new partition / sub-instance
> of a region, and...
>     "echo $devname > regionX/delete" to delete. Where $devname is
> searched in the child devices of regionX to trigger device_del().

Shouldn't that be done in configfs, not sysfs?

> This arrangement avoids one of the design mistakes of libnvdimm which
> uses a sysfs attribute of the device to delete itself. Parent-device
> triggered deletion rather than self-deletion avoids those locking
> entanglements.

Ugh, yeah, getting rid of that would be great, it's a mess.  I think
scsi still does that :(

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
