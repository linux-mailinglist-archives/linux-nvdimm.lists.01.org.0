Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7BEA9CA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 04:55:34 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DA0D100EA55B;
	Wed, 30 Oct 2019 20:56:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9B6C100EA554
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 20:56:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 53so4189044otv.4
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NV6K7ZR4dGe7Xk1/kokI/AdvBb/BVY+nZysghqN1EPY=;
        b=ehx2WWD7dbyP4cKUHEG2oxXnt3uQYoJjp5KElHbk7RKPQ/C2vidv50DtRG5NQ/zZ4s
         lp09X1itTEY6+EbmPv+zbO+MdnEU0LDI93bFVtR3K4nR6BMW12VOZv4/29sgztKsL9h3
         ImBdtZjFLF0Cp3XdjEEspARGxfBPvTECmU2C6Ic9h2ozRka3kfE9B7ypDbfOIcVOQmqS
         sG9QUJ9nUV+jT2sSiz7d5DsugR7CUmPG4hRe4CbB4KIkK7jIqTWNc4nJMBPm2WxbT02/
         RrVNA/VzxDGuneSilpiesRN7bMPvFd6V1mVVtW9lm8P8lkIdN1bCh9SPlThKdE7iGqHD
         xetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV6K7ZR4dGe7Xk1/kokI/AdvBb/BVY+nZysghqN1EPY=;
        b=jZTOc5J1pOBW7GkR1cEaAfI6r6JcqJar43XNa6MUud8yI9nLlAXXal4fLF9wbl5qwc
         sMvJiUqXl4TI0LFJMQEfD/UoMgqUuAtisGWNy0SM62R3xj6vrnYcb2QUlMWK8c2dN2Wk
         N57yKHm9N6Iki2diMedPEZkxFYOfXa6a1AsOK5KaYWd3F9oCgfxFsSMpAjRMLPsHsz6R
         CHDVk2KGtAzDXta2MZdet71vFohaLu7rgGBColkZYa01p8KCQDBC5tyzGpXiRaPz11FH
         VdlO6qJw25ymfgqhtscezoEnbGQRzZZeGze6BFXpVb6MWzj27VWTqLiThPe+N8wTkSwp
         DZXw==
X-Gm-Message-State: APjAAAUFksot1B1+/bvnsH2DE/dpkhWPATlMhUkDFPiJnif1y34XOFji
	QXOQ/Ie5Qf2EAWiqKC4amsoYKn8oAWZdOByQB2jh9A==
X-Google-Smtp-Source: APXvYqzC2QoZRkbxPAMrh3gyDb+XbJifiorCj6KxPF+nV2mTZgQTeOdPpKl2GRceTEI5ppwhuFNba9zclapNTW0SJLE=
X-Received: by 2002:a05:6830:1af7:: with SMTP id c23mr2607815otd.247.1572494128305;
 Wed, 30 Oct 2019 20:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com>
 <49c98556-5c57-b8fc-ef50-fa0ed679e094@linux.ibm.com> <CAPcyv4i9SsPH-auGrS3qWPYEXzkDKtR7CjxN1eeocrwiWYcCxw@mail.gmail.com>
In-Reply-To: <CAPcyv4i9SsPH-auGrS3qWPYEXzkDKtR7CjxN1eeocrwiWYcCxw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Oct 2019 20:55:17 -0700
Message-ID: <CAPcyv4g9bU+E6JuOT34gUjQGP4LBYg7w6Y+5ei5pxD3frFXcaw@mail.gmail.com>
Subject: Re: [PATCH v3] libnvdimm/nsio: differentiate between probe mapping
 and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: EHOQ7B66BUS4CSHYD57A2FUPQUQXZSMB
X-Message-ID-Hash: EHOQ7B66BUS4CSHYD57A2FUPQUQXZSMB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EHOQ7B66BUS4CSHYD57A2FUPQUQXZSMB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 30, 2019 at 4:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Oct 24, 2019 at 2:07 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> >
> > On 10/24/19 7:36 AM, Dan Williams wrote:
> > > On Thu, Oct 17, 2019 at 12:33 AM Aneesh Kumar K.V
> > > <aneesh.kumar@linux.ibm.com> wrote:
> > >>
> > >> nvdimm core currently maps the full namespace to an ioremap range
> > >> while probing the namespace mode. This can result in probe failures
> > >> on architectures that have limited ioremap space.
> > >>
> > >> For example, with a large btt namespace that consumes most of I/O remap
> > >> range, depending on the sequence of namespace initialization, the user can find
> > >> a pfn namespace initialization failure due to unavailable I/O remap space
> > >> which nvdimm core uses for temporary mapping.
> > >>
> > >> nvdimm core can avoid this failure by only mapping the reserver block area to
> > >
> > > s/reserver/reserved/
> >
> > Will fix
> >
> >
> > >
> > >> check for pfn superblock type and map the full namespace resource only before
> > >> using the namespace.
> > >
> > > Are you going to follow up with the BTT patch that uses this new facility?
> > >
> >
> > I am not yet sure about that. ioremap/vmap area is the way we get a
> > kernel mapping without struct page backing. What we are suggesting hee
> > is the ability to have a direct mapped mapping without struct page. I
> > need to look at closely about what that imply.
> >
> > >>
> > >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > >> ---
> > >> Changes from v2:
> > >> * update changelog
> > >>
> > >> Changes from V1:
> > >> * update changelog
> > >> * update patch based on review feedback.
> > >>
> > >>   drivers/dax/pmem/core.c   |  2 +-
> > >>   drivers/nvdimm/claim.c    |  7 +++----
> > >>   drivers/nvdimm/nd.h       |  4 ++--
> > >>   drivers/nvdimm/pfn.h      |  6 ++++++
> > >>   drivers/nvdimm/pfn_devs.c |  5 -----
> > >>   drivers/nvdimm/pmem.c     | 15 ++++++++++++---
> > >>   6 files changed, 24 insertions(+), 15 deletions(-)
> > >>
> > >> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
> > >> index 6eb6dfdf19bf..f174dbfbe1c4 100644
> > >> --- a/drivers/dax/pmem/core.c
> > >> +++ b/drivers/dax/pmem/core.c
> > >> @@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
> > >>          nsio = to_nd_namespace_io(&ndns->dev);
> > >>
> > >>          /* parse the 'pfn' info block via ->rw_bytes */
> > >> -       rc = devm_nsio_enable(dev, nsio);
> > >> +       rc = devm_nsio_enable(dev, nsio, info_block_reserve());
> > >>          if (rc)
> > >>                  return ERR_PTR(rc);
> > >>          rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
> > >> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> > >> index 2985ca949912..d89d2c039e25 100644
> > >> --- a/drivers/nvdimm/claim.c
> > >> +++ b/drivers/nvdimm/claim.c
> > >> @@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
> > >>          return rc;
> > >>   }
> > >>
> > >> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
> > >> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
> > >>   {
> > >>          struct resource *res = &nsio->res;
> > >>          struct nd_namespace_common *ndns = &nsio->common;
> > >>
> > >> -       nsio->size = resource_size(res);
> > >> +       nsio->size = size;
> > >
> > > This needs a:
> > >
> > > if (nsio->size)
> > >     devm_memunmap(dev, nsio->addr);
> >
> >
> > Why ? we should not be calling devm_nsio_enable twice now.
> >
> > >
> > >
> > >>          if (!devm_request_mem_region(dev, res->start, resource_size(res),
> > >>                                  dev_name(&ndns->dev))) {
> > >
> > > Also don't repeat the devm_request_mem_region() if one was already done.
> > >
> > > Another thing to check is if nsio->size gets cleared when the
> > > namespace is disabled, if not that well need to be added in the
> > > shutdown path.
> > >
> >
> >
> > Not sure I understand that. So with this patch when we probe we always
> > use info_block_reserve() size irrespective of the device. This probe
> > will result in us adding a btt/pfn/dax device and we return -ENXIO after
> > this probe. This return value will cause us to destroy the I/O remap
> > mmapping we did with info_block_reserve() size. Also the nsio data
> > structure is also freed.
> >
> > nd_pmem_probe is then again called with btt device type and in that case
> > we do  devm_memremap again.
> >
> > if (btt)
> >      remap the full namespace size.
> > else
> >     remap the info_block_reserve_size.
> >
> >
> > This infor block reserve mapping is unmapped in pmem_attach_disk()
> >
> >
> > Anything i am missing in the above flow?
>
> Oh no, you're right, this does make the implementation only call
> devm_nsio_enable() once. However, now that I look I want to suggest
> some small reorganizations of where devm_nsio_enable() is called. I'll
> take a stab at folding some changes on top of your patch.

This change is causing the "pfn-meta-errors.sh" test to fail. It is
due to the fact the info_block_reserve() is not a sufficient
reservation for errors in the page metadata area.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
