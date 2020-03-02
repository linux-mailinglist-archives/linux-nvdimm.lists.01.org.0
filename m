Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C61762FF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 19:45:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC1A610FC3601;
	Mon,  2 Mar 2020 10:46:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A124F10FC35BF
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 10:46:12 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id b3so301217otp.4
        for <linux-nvdimm@lists.01.org>; Mon, 02 Mar 2020 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12/rZ6fsx6hBmJEsqbaXJ5G4NKHwEaEIjFun4ithZOM=;
        b=FApU1YJ4AMLXq6gY4yHZy3O3+YQ5rdZ5ZXtB0qHwnZX4Zfv9rcvGBWmEEXeh1cIk+R
         O3RAZT+sZiS6aJFDSqID8K2KjsZ5ee6JeF+wNPQ4Li/7/rjV11J3yf74iOnlP29XF4eg
         Addovy0Cstcl8eyhFKS8xN+HiWCsCkxoFiKLt2k1Ip0hB2nBJv6QY5ZlLPxZQQFKel1S
         tJoEoB7Ta1hjI+LOFRh3repS8VSztYx53SMC81+8CXByV+mlX5P1wqmTk/olWBpb/4VK
         +yK4MXqGHyice3ICXPAlzn21iVarNr7dAanM2VZM2xLLxlTUVg+HqW4oyDDcNcNHe9rO
         IWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12/rZ6fsx6hBmJEsqbaXJ5G4NKHwEaEIjFun4ithZOM=;
        b=cOg+CejGrrr+LVd9XMOKtKrYEFYwsdbTN236Jx+4MfVVpJWy6WtT2kssJVbZ+yQRB9
         +CE+wfAuNs5vEPLgEjX8sbcVSyNxwpN+YEnJgZdRehVWW5mCjhKMhIip43+CCMeT+cLF
         PdXWXFWu2SrE+hLbFPPrTAZ+hfJOQbrw4uU4Gl2+g7YjjqvueuYORDeYHhLVp94kNUs5
         pDVqNN6IChof1p7zWByHjz9POj6v1KOWrCz5m5+agf6tC7KNHZkw7SmEdoNAxbDZPr5a
         bNrm4s0ZO+fMFPRuoBsW8/ii2VyF1K7nJwGi1m55S+8v0Ow4vN00Rv4wZP9fL4pOUIUQ
         63MA==
X-Gm-Message-State: ANhLgQ1BoMmC7WcghvmTyAZNEsYQsfG7M6gHf8vNa5YPswiiYyP3csX7
	Beqz83QC3Mhd0N61m7mdWAR5X7dmo23O7uUA5LpI8A==
X-Google-Smtp-Source: ADFU+vuU2dswAMVUqhHfW4STg+g4kMHqpDxE1Gsd02iItsqjS4OmcfgkKZdArJ5AdrGU2vikXDbnmbWZAPG7/HJQYj8=
X-Received: by 2002:a9d:5d09:: with SMTP id b9mr409956oti.207.1583174720075;
 Mon, 02 Mar 2020 10:45:20 -0800 (PST)
MIME-Version: 1.0
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158291748226.1609624.8971922874557923784.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87fterrmau.fsf@linux.ibm.com>
In-Reply-To: <87fterrmau.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 2 Mar 2020 10:45:09 -0800
Message-ID: <CAPcyv4iQR=e5AneCshT9xqWfKdG_oHBorahLqnNxYC3pz40D_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] libnvdimm/namespace: Enforce memremap_compat_align()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: YEAROAFV6WBNQUXYQRGFPK35Z6NUU7EJ
X-Message-ID-Hash: YEAROAFV6WBNQUXYQRGFPK35Z6NUU7EJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YEAROAFV6WBNQUXYQRGFPK35Z6NUU7EJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 2, 2020 at 4:09 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The pmem driver on PowerPC crashes with the following signature when
> > instantiating misaligned namespaces that map their capacity via
> > memremap_pages().
> >
> >     BUG: Unable to handle kernel data access at 0xc001000406000000
> >     Faulting instruction address: 0xc000000000090790
> >     NIP [c000000000090790] arch_add_memory+0xc0/0x130
> >     LR [c000000000090744] arch_add_memory+0x74/0x130
> >     Call Trace:
> >      arch_add_memory+0x74/0x130 (unreliable)
> >      memremap_pages+0x74c/0xa30
> >      devm_memremap_pages+0x3c/0xa0
> >      pmem_attach_disk+0x188/0x770
> >      nvdimm_bus_probe+0xd8/0x470
> >
> > With the assumption that only memremap_pages() has alignment
> > constraints, enforce memremap_compat_align() for
> > pmem_should_map_pages(), nd_pfn, and nd_dax cases. This includes
> > preventing the creation of namespaces where the base address is
> > misaligned and cases there infoblock padding parameters are invalid.
> >
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Fixes: a3619190d62e ("libnvdimm/pfn: stop padding pmem namespaces to section alignment")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c |   12 ++++++++++++
> >  drivers/nvdimm/pfn_devs.c       |   26 +++++++++++++++++++++++---
> >  2 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> > index 032dc61725ff..68e89855f779 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/nd.h>
> >  #include "nd-core.h"
> >  #include "pmem.h"
> > +#include "pfn.h"
> >  #include "nd.h"
> >
> >  static void namespace_io_release(struct device *dev)
> > @@ -1739,6 +1740,17 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
> >               return ERR_PTR(-ENODEV);
> >       }
>
> May be add a comment here that both dax/fsdax namespace details are
> checked in nd_pfn_validate() so that we look at start_pad and end_trunc
> while validating the namespace?
>
> >
> > +     if (pmem_should_map_pages(dev)) {
> > +             struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
> > +             struct resource *res = &nsio->res;
> > +
> > +             if (!IS_ALIGNED(res->start | (res->end + 1),
> > +                                     memremap_compat_align())) {
> > +                     dev_err(&ndns->dev, "%pr misaligned, unable to map\n", res);
> > +                     return ERR_PTR(-EOPNOTSUPP);
> > +             }
> > +     }
> > +
> >       if (is_namespace_pmem(&ndns->dev)) {
> >               struct nd_namespace_pmem *nspm;
> >
> > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > index 79fe02d6f657..3bdd4b883d05 100644
> > --- a/drivers/nvdimm/pfn_devs.c
> > +++ b/drivers/nvdimm/pfn_devs.c
> > @@ -446,6 +446,7 @@ static bool nd_supported_alignment(unsigned long align)
> >  int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >  {
> >       u64 checksum, offset;
> > +     struct resource *res;
> >       enum nd_pfn_mode mode;
> >       struct nd_namespace_io *nsio;
> >       unsigned long align, start_pad;
> > @@ -578,13 +579,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >        * established.
> >        */
> >       nsio = to_nd_namespace_io(&ndns->dev);
> > -     if (offset >= resource_size(&nsio->res)) {
> > +     res = &nsio->res;
> > +     if (offset >= resource_size(res)) {
> >               dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
> >                               dev_name(&ndns->dev));
> >               return -EOPNOTSUPP;
> >       }
> >
> > -     if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
> > +     if ((align && !IS_ALIGNED(res->start + offset + start_pad, align))
> >                       || !IS_ALIGNED(offset, PAGE_SIZE)) {
> >               dev_err(&nd_pfn->dev,
> >                               "bad offset: %#llx dax disabled align: %#lx\n",
> > @@ -592,6 +594,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
> >               return -EOPNOTSUPP;
> >       }
> >
> > +     if (!IS_ALIGNED(res->start + le32_to_cpu(pfn_sb->start_pad),
> > +                             memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "resource start misaligned\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     if (!IS_ALIGNED(res->end + 1 - le32_to_cpu(pfn_sb->end_trunc),
> > +                             memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "resource end misaligned\n");
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(nd_pfn_validate);
> > @@ -750,7 +764,13 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >       start = nsio->res.start;
> >       size = resource_size(&nsio->res);
> >       npfns = PHYS_PFN(size - SZ_8K);
> > -     align = max(nd_pfn->align, SUBSECTION_SIZE);
> > +     align = max(nd_pfn->align, memremap_compat_align());
> > +     if (!IS_ALIGNED(start, memremap_compat_align())) {
> > +             dev_err(&nd_pfn->dev, "%s: start %pa misaligned to %#lx\n",
> > +                             dev_name(&ndns->dev), &start,
> > +                             memremap_compat_align());
> > +             return -EINVAL;
> > +     }
>
> This validates start in case of a new namespace creation where the user
> updated nd_region->align value? A comment there would help when looking
> at the code later?

Yeah, sounds good will respin with those updates.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
