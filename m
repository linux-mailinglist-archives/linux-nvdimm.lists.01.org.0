Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 935D035AAE9
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Apr 2021 06:52:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01DD3100EBBBB;
	Fri,  9 Apr 2021 21:52:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.49; helo=mail-ej1-f49.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61D86100ED4A4
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 21:52:22 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id u21so11718648ejo.13
        for <linux-nvdimm@lists.01.org>; Fri, 09 Apr 2021 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAJ7BDyNzJFE80ia1nfwW0DyhQjOtgG+kMB+/93FCcc=;
        b=TXQw70WRvs1dKcO9zJN9l2e3zZMxRNOSa5sC6ZOG/iw9mt1kmZhHRwyawcVbvex8dI
         z/zd4+xqrH90fw985a+2oDjIgVICpwDbDvVz1eijJBWIdwmw7RFTaSZLNFF+L4BrKbK4
         svzPndixrdkxbSjuzZbBr6NktizfGyJLMNy4yQ1st7ybKcW61+oMLklTKt5k/skTLRD+
         PfNy6VL7c1ukP8ZxRSGobH64Pj+DpgsKvF1zD/OnB9JZs6lDwq7j9ZWiq8sQ1zkBd1Y6
         bpO4dS+dZtIQN92zt1GNRfKK6+RAqX9Sp74zUSHvQMHyHrDy/WhZI4UxXyA5WF+05aPI
         HS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAJ7BDyNzJFE80ia1nfwW0DyhQjOtgG+kMB+/93FCcc=;
        b=oPHiUGZ08+wsf/MRfqnAkiEY+kpd6ffqL7qzB01hFTlKRU/Q1AJ0DKoVhwSvPmnwZy
         Ayon9JJ+BsCZGnaawiAwZv0LGXENbDX5UnWTPSfznUbKvcOe2n8cbM7ETrDeZpr4Jiuv
         a1CYeSo9Tqo6VaYDkyUfhKr1W5xuVVTiqrk4KtRlXzJlbDSNrd/hr1U4lxuIVyf+KLMh
         dReFXxzSUToLBjO1dmbEpr0xvhdYUpPjQSUTaK9NCkUlosV0z1BID9io0evNkDOQPKjX
         sW/Xdx+d/AVZZ4jJBN9H7v9hS1kHGQQCv4X5NG6t+JE1nvX+uUAAlHIFmcnPe2uCiXXx
         3JEA==
X-Gm-Message-State: AOAM531pr+zFmt0N/1CSSGYtOT+xO2r0oAFj757+N3AW0i6Z3Fb1ncrL
	r4gcM2MfaWHdJbCvAWZTPMA355yNevRmITEwMqZ3Mw==
X-Google-Smtp-Source: ABdhPJyHRumKTWKdOoyr9jZhMCm0+zzhUk1m7yy699Xx1vnwnvQW5Obmn3IUu2KD8Km8WrngoIG++98gatVyhCc71a8=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr19302282eji.323.1618030281039;
 Fri, 09 Apr 2021 21:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210402092555.208590-1-vaibhav@linux.ibm.com> <87a6qd6k8x.fsf@linux.ibm.com>
In-Reply-To: <87a6qd6k8x.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Apr 2021 21:51:13 -0700
Message-ID: <CAPcyv4jqa8WBO6oOaFoCPFqudv7-_OFwXs8ZiRqKaafvMmAtCQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Update nvdimm_has_flush() to handle ND_REGION_ASYNC
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: KWPLEYWUQSEEJL5WRMWBHDVGJSFPT7VM
X-Message-ID-Hash: KWPLEYWUQSEEJL5WRMWBHDVGJSFPT7VM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KWPLEYWUQSEEJL5WRMWBHDVGJSFPT7VM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 5, 2021 at 4:31 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
> > In case a platform doesn't provide explicit flush-hints but provides an
> > explicit flush callback via ND_REGION_ASYNC region flag, then
> > nvdimm_has_flush() still returns '0' indicating that writes do not
> > require flushing. This happens on PPC64 with patch at [1] applied,
> > where 'deep_flush' of a region was denied even though an explicit
> > flush function was provided.
> >
> > Fix this by adding a condition to nvdimm_has_flush() to test for the
> > ND_REGION_ASYNC flag on the region and see if a 'region->flush'
> > callback is assigned.
> >
>
> May be this should have
> Fixes: c5d4355d10d4 ("libnvdimm: nd_region flush callback support")

Yes, thanks for that.

>
> Without this we will mark the pmem disk not having FUA support?

Yes.

>
>
> > References:
> > [1] "powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall"
> > https://lore.kernel.org/linux-nvdimm/161703936121.36.7260632399       582101498.stgit@e1fbed493c87
> >
> > Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  drivers/nvdimm/region_devs.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index ef23119db574..e05cc9f8a9fd 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1239,6 +1239,11 @@ int nvdimm_has_flush(struct nd_region *nd_region)
> >                       || !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
> >               return -ENXIO;
> >
> > +     /* Test if an explicit flush function is defined */
> > +     if (test_bit(ND_REGION_ASYNC, &nd_region->flags) && nd_region->flush)
> > +             return 1;
>
> > +
> > +     /* Test if any flush hints for the region are available */
> >       for (i = 0; i < nd_region->ndr_mappings; i++) {
> >               struct nd_mapping *nd_mapping = &nd_region->mapping[i];
> >               struct nvdimm *nvdimm = nd_mapping->nvdimm;
> > @@ -1249,8 +1254,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
> >       }
> >
> >       /*
> > -      * The platform defines dimm devices without hints, assume
> > -      * platform persistence mechanism like ADR
> > +      * The platform defines dimm devices without hints nor explicit flush,
> > +      * assume platform persistence mechanism like ADR
> >        */
> >       return 0;
> >  }
> > --
> > 2.30.2
> > _______________________________________________
> > Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> > To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
