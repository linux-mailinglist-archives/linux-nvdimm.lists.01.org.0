Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB21CFD0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 21:24:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6C2C21275467;
	Tue, 14 May 2019 12:24:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1487821275442
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 12:24:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i8so16330892oth.10
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dgq3UM6Fy7t89KBsWPa/dNwubJ5x9NhFBR3nKkdGxBQ=;
 b=F54v5r3Q2UY3p0fjMipKOr0SMEZcrmYQxQ6eq9lQTgFwD5XGRo7ab2Bz8ptu15lqGi
 KZME0yohwroLEHCqjTihL6T8ZzRNmzMX7XD8jv7Z+22fnjT4CvamuDPDwm9ZqC92NFbL
 psOyeN7hAWl/ayAPPh+L4sKlmOR9e4FXsgXAFcGuaBankMius3erJ5ABRCntGuZtIkgO
 9jeDxqXQHS2OhoN7nFNVwmCrmTOEL+tP7bKNE5KCXPZpUqEb8Q3ZSOO0v0EPUhAncVKX
 R8ZR5TfBmbtgDvjr2jF88CVkbM+5tHyeeTNmn91CplwgR3mz7BuLfoQZwny3cygAJMrY
 Lw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dgq3UM6Fy7t89KBsWPa/dNwubJ5x9NhFBR3nKkdGxBQ=;
 b=FtNZijQDQlH1oGmPfgPe95SIe8m6rBsZbzyocF8Gf+zqegPgiG5lsX+uzDtUw1C1c2
 ztXO2oIEI+bTOTElw/lB4YasYb3ytgZeyZ/ZXRlBX+3NxvWayWAP1lKtF+MhEZ4bPxnp
 Nj85LXaxcR6oKXNTFG6qdDahVfNBGpZC3Nw6y7/O4XfyOajp9SIwm5uWkbXhqMhCqhGJ
 NBMw4kGHKh9ZiB8HnxJ53Bf94H4ph3FYflyzh9z1F5KgtBN3XJ3gF+FKFRg2BzOIdNu0
 DTFC2z0RxC8B19giLaPuYeQ7sTfJlHW3fEaG0teG56cL0KPY9FDc+Et/UUvDIwByswYl
 3dmw==
X-Gm-Message-State: APjAAAW9gZG6aBrYLJev6XbJZpyJHLaViFFEVSvFdW19vFrOSxbD6zzJ
 zqI+m6qUzg9Z0GYakrpxuYRTeYG37AemNysXHrkmvQ==
X-Google-Smtp-Source: APXvYqwKrS+xjnV2C39v/K43aWh/ONuM204U4eBm/zYWLBvQbW5tmknEyf9ZYMNzmmuNbTGmVFMfdvg9LHWShr9lgv0=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr21177381otq.197.1557861873856; 
 Tue, 14 May 2019 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190514191243.GA17226@kroah.com>
In-Reply-To: <20190514191243.GA17226@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 May 2019 12:24:23 -0700
Message-ID: <CAPcyv4jO5KA4ddvBx6PFTgv2D+PfJ4Znzt5RFP4ry9NUDZ+eSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] drivers/base/devres: Introduce
 devm_release_action()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 12:12 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 07, 2019 at 04:56:05PM -0700, Dan Williams wrote:
> > The devm_add_action() facility allows a resource allocation routine to
> > add custom devm semantics. One such user is devm_memremap_pages().
> >
> > There is now a need to manually trigger devm_memremap_pages_release().
> > Introduce devm_release_action() so the release action can be triggered
> > via a new devm_memunmap_pages() api in a follow-on change.
> >
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/base/devres.c  |   24 +++++++++++++++++++++++-
> >  include/linux/device.h |    1 +
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index e038e2b3b7ea..0bbb328bd17f 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -755,10 +755,32 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
> >
> >       WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
> >                              &devres));
> > -
> >  }
> >  EXPORT_SYMBOL_GPL(devm_remove_action);
> >
> > +/**
> > + * devm_release_action() - release previously added custom action
> > + * @dev: Device that owns the action
> > + * @action: Function implementing the action
> > + * @data: Pointer to data passed to @action implementation
> > + *
> > + * Releases and removes instance of @action previously added by
> > + * devm_add_action().  Both action and data should match one of the
> > + * existing entries.
> > + */
> > +void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> > +{
> > +     struct action_devres devres = {
> > +             .data = data,
> > +             .action = action,
> > +     };
> > +
> > +     WARN_ON(devres_release(dev, devm_action_release, devm_action_match,
> > +                            &devres));
>
> What does WARN_ON help here?  are we going to start getting syzbot
> reports of this happening?

Hopefully, yes, if developers misuse the api they get a loud
notification similar to devm_remove_action() misuse.

> How can this fail?

It's a catch to make sure that @dev actually has a live devres
resource that can be found via @action and @data.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
