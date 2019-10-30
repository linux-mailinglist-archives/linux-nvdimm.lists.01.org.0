Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32884EA7D3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 00:33:41 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D86F0100EA553;
	Wed, 30 Oct 2019 16:34:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E55E100EEBB6
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 16:34:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n16so3593954oig.2
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfcI6bVYMrrg8FJrCK1TjQBrZjcLKCAyxkaa40xQRv8=;
        b=fSxlP1s3mBvm34yEF7dteE64YxEKiyCaO/rJI+ULpnI16Acpfp2WakVYaFcpEBVpsL
         t4Nc0/BZKTWEBm5ooQknzTo97NACmzRYr1nuDB9UKTE8JIDaWdmlgleMwoBBQwR/tHHS
         sB1Wt2ZAUBsF6WtAM/hYaDJD/+l1ilNnU3bMCn9fPdy/eAlJyH3pB0DOtJEICyBYyvmc
         EpO2Cz+Wbv9Xhg4E4FlLJa0BfKhmla3ZM2xdf3/4rHHQiSuuMEGnyZxpxqG5gkNxpKI2
         ik08BXGYXCN9HMXHObLVzB7echnop3MgrmOAeZU5X6FkGX6KnGN5kNf3UOFaAp1F0Ejx
         S1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfcI6bVYMrrg8FJrCK1TjQBrZjcLKCAyxkaa40xQRv8=;
        b=VKYQnLIXGFPhzt+HRGpaynbStqrEYNNk9u/pnG7rCfQtBqwOfXEXJqarzjSt6y9eTz
         8R7zTi7KoZzXTNxaWtgvHLlX/Mr84q/rD4DrcibVqzvOsFoBwzCUKkfimL+Yj5RwdjBS
         iaQOWegDehdrcq68T5pDEmDZq/JG1lfb1i86Td2RPeyTYVsMge29I+CUuz3328mD+Fos
         a8N+n4D9FEVIyz1VS5TrLGjKIUyxDf5dT4QiH/U3vmIV39gE3cVvpyavO9ZeM6ehR5t7
         RVYxz7t8YqlEXvXpOODHnd35PVuZ32hsR5R7IrdiUvFGt60RfppL8PLlTUeqa+qYXW+p
         rHzg==
X-Gm-Message-State: APjAAAVltpr+/qNzWteG0vD61An4zk55C7q6iIIRlQ8Ewxr/pLgMN6tr
	53dfQcR+k9K2nADvKOkVirg/HoGQEoS7Z4uDsBazUQ==
X-Google-Smtp-Source: APXvYqxpkXMfQA4l08Xp1woMW5IUUqKLvo2yzOtvx/H1IBOPKyA1Bj2bKJqN3aJjY/fGks9PPn9zrllkfGlWjyxcjhA=
X-Received: by 2002:aca:3c44:: with SMTP id j65mr1488181oia.70.1572478413671;
 Wed, 30 Oct 2019 16:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191017073308.32645-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4ix9Ld6NgN=6u3yBJc1A81U-nkY3EFHjBUTMNoxAxth1g@mail.gmail.com> <49c98556-5c57-b8fc-ef50-fa0ed679e094@linux.ibm.com>
In-Reply-To: <49c98556-5c57-b8fc-ef50-fa0ed679e094@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Oct 2019 16:33:22 -0700
Message-ID: <CAPcyv4i9SsPH-auGrS3qWPYEXzkDKtR7CjxN1eeocrwiWYcCxw@mail.gmail.com>
Subject: Re: [PATCH v3] libnvdimm/nsio: differentiate between probe mapping
 and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: A7RZXOWV5AEIURTYV5ZBLG43FRIP7CCG
X-Message-ID-Hash: A7RZXOWV5AEIURTYV5ZBLG43FRIP7CCG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A7RZXOWV5AEIURTYV5ZBLG43FRIP7CCG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 24, 2019 at 2:07 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 10/24/19 7:36 AM, Dan Williams wrote:
> > On Thu, Oct 17, 2019 at 12:33 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> nvdimm core currently maps the full namespace to an ioremap range
> >> while probing the namespace mode. This can result in probe failures
> >> on architectures that have limited ioremap space.
> >>
> >> For example, with a large btt namespace that consumes most of I/O remap
> >> range, depending on the sequence of namespace initialization, the user can find
> >> a pfn namespace initialization failure due to unavailable I/O remap space
> >> which nvdimm core uses for temporary mapping.
> >>
> >> nvdimm core can avoid this failure by only mapping the reserver block area to
> >
> > s/reserver/reserved/
>
> Will fix
>
>
> >
> >> check for pfn superblock type and map the full namespace resource only before
> >> using the namespace.
> >
> > Are you going to follow up with the BTT patch that uses this new facility?
> >
>
> I am not yet sure about that. ioremap/vmap area is the way we get a
> kernel mapping without struct page backing. What we are suggesting hee
> is the ability to have a direct mapped mapping without struct page. I
> need to look at closely about what that imply.
>
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >> Changes from v2:
> >> * update changelog
> >>
> >> Changes from V1:
> >> * update changelog
> >> * update patch based on review feedback.
> >>
> >>   drivers/dax/pmem/core.c   |  2 +-
> >>   drivers/nvdimm/claim.c    |  7 +++----
> >>   drivers/nvdimm/nd.h       |  4 ++--
> >>   drivers/nvdimm/pfn.h      |  6 ++++++
> >>   drivers/nvdimm/pfn_devs.c |  5 -----
> >>   drivers/nvdimm/pmem.c     | 15 ++++++++++++---
> >>   6 files changed, 24 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
> >> index 6eb6dfdf19bf..f174dbfbe1c4 100644
> >> --- a/drivers/dax/pmem/core.c
> >> +++ b/drivers/dax/pmem/core.c
> >> @@ -28,7 +28,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
> >>          nsio = to_nd_namespace_io(&ndns->dev);
> >>
> >>          /* parse the 'pfn' info block via ->rw_bytes */
> >> -       rc = devm_nsio_enable(dev, nsio);
> >> +       rc = devm_nsio_enable(dev, nsio, info_block_reserve());
> >>          if (rc)
> >>                  return ERR_PTR(rc);
> >>          rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
> >> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> >> index 2985ca949912..d89d2c039e25 100644
> >> --- a/drivers/nvdimm/claim.c
> >> +++ b/drivers/nvdimm/claim.c
> >> @@ -300,12 +300,12 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
> >>          return rc;
> >>   }
> >>
> >> -int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
> >> +int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio, unsigned long size)
> >>   {
> >>          struct resource *res = &nsio->res;
> >>          struct nd_namespace_common *ndns = &nsio->common;
> >>
> >> -       nsio->size = resource_size(res);
> >> +       nsio->size = size;
> >
> > This needs a:
> >
> > if (nsio->size)
> >     devm_memunmap(dev, nsio->addr);
>
>
> Why ? we should not be calling devm_nsio_enable twice now.
>
> >
> >
> >>          if (!devm_request_mem_region(dev, res->start, resource_size(res),
> >>                                  dev_name(&ndns->dev))) {
> >
> > Also don't repeat the devm_request_mem_region() if one was already done.
> >
> > Another thing to check is if nsio->size gets cleared when the
> > namespace is disabled, if not that well need to be added in the
> > shutdown path.
> >
>
>
> Not sure I understand that. So with this patch when we probe we always
> use info_block_reserve() size irrespective of the device. This probe
> will result in us adding a btt/pfn/dax device and we return -ENXIO after
> this probe. This return value will cause us to destroy the I/O remap
> mmapping we did with info_block_reserve() size. Also the nsio data
> structure is also freed.
>
> nd_pmem_probe is then again called with btt device type and in that case
> we do  devm_memremap again.
>
> if (btt)
>      remap the full namespace size.
> else
>     remap the info_block_reserve_size.
>
>
> This infor block reserve mapping is unmapped in pmem_attach_disk()
>
>
> Anything i am missing in the above flow?

Oh no, you're right, this does make the implementation only call
devm_nsio_enable() once. However, now that I look I want to suggest
some small reorganizations of where devm_nsio_enable() is called. I'll
take a stab at folding some changes on top of your patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
