Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027592D39B1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 05:43:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41C93100EBB96;
	Tue,  8 Dec 2020 20:43:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04FFA100EC1F6
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 20:43:54 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so197058ejj.5
        for <linux-nvdimm@lists.01.org>; Tue, 08 Dec 2020 20:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUrmxEO3EocQCKBqXbu/B7dSx4PYVYZQ47UYqUANeRs=;
        b=lxQSr0ZvyGH7ZxNH0yVKwuB/dvBR7YHjknj+/jVPzPBnyMT+P8vmRYFE+fb1T7YHnn
         42eWfv02nUF6QlzlqqzdZmGWAJSVX9t6RAvw12wgBQHadrK+yJxZkh4eb7wt5KEqxRgh
         iWpHwkRl92j3SMHDjsWs/YgswLRO1LvRav1WalqiXkCuXSGlBYjWSeszQiD97JfuE+NG
         zHThTsnYUtaC4HWYLPOfUEfiDgadKRTPi2Y/mSZNM2YRymCcAsteY1dEYQpiO5X/Ww/7
         7jOQViTeqbd22j9dtssBQ89nwpCH9p3p1UnudqnudDa9n/V3YL8thTD96kuy6DyEOCb+
         M5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUrmxEO3EocQCKBqXbu/B7dSx4PYVYZQ47UYqUANeRs=;
        b=uM+WDEUvq+oYcRLOOzDWM91elN+r/AOpK9pe+MeKHHfT2ZqWxS/dFS86G0P/WJSjDE
         CTKBwyEDJ5lE2sOmKXEP1+pxWdzVWUixEIcv/NBlm3GNduWYNbujbV3JM9hYPgwT7lEu
         c9jNk3kX/bxJl7jE1JHP7i2nlcataCmlwZcxr+r1fgA68DrRK3lnGs+xPH0ODaSvpjlG
         jHQr87SpcpC/KMVkqFQhETBvann6jyJLfxq6RUqLS7CjJBXyT3wLC3/sBBIwbOiSZbSs
         IuOGDm0qe6EdJmdtMGwMz1WU1GpAr2iBtiQ9shLs1PzSpvi/vkiOklamS7Kv8kJa0E/N
         vJfw==
X-Gm-Message-State: AOAM530pKZz/1nqSDvrG3mZc96J4Ta5LE84jCMS6Af1iwg2UGk5d6c20
	3Wn4BEJ8efyyWk0QBA0at0NinHGSlquYBoJV/FzX1g==
X-Google-Smtp-Source: ABdhPJzYbTraD4idxG5ZzM47YKKfO5xV04/SVh2kbWiRas2FAbzSANABL3asY3bHLW8fNryKqlaqMfJG2Myi7VX50NU=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr537717ejz.45.1607489033347;
 Tue, 08 Dec 2020 20:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20201006010013.848302-1-santosh@fossix.org> <CAPcyv4jEpw2Yvj1eVNaW6z7D=pf31w1cQXuF9ymqxckhxANeCQ@mail.gmail.com>
 <50842a9b-2ff8-2623-fe00-7c91e9405131@linux.ibm.com>
In-Reply-To: <50842a9b-2ff8-2623-fe00-7c91e9405131@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 8 Dec 2020 20:43:51 -0800
Message-ID: <CAPcyv4isaiWqBPGymyAmbrAhH31C96wUsrRq5Oeuv7F=ko_hsg@mail.gmail.com>
Subject: Re: [PATCH RFC v3] testing/nvdimm: Add test module for non-nfit platforms
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: JSQSR2DVQLWVY6UL7P2ISV63BJUCD2M4
X-Message-ID-Hash: JSQSR2DVQLWVY6UL7P2ISV63BJUCD2M4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JSQSR2DVQLWVY6UL7P2ISV63BJUCD2M4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 8, 2020 at 8:17 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 12/8/20 3:30 AM, Dan Williams wrote:
> > On Mon, Oct 5, 2020 at 6:01 PM Santosh Sivaraj <santosh@fossix.org> wrote:
> >
>
> ...
>
> >> +static int ndtest_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
> >> +               void *iobuf, u64 len, int rw)
> >> +{
> >> +       struct ndtest_dimm *dimm = ndbr->blk_provider_data;
> >> +       struct ndtest_blk_mmio *mmio = dimm->mmio;
> >> +       struct nd_region *nd_region = &ndbr->nd_region;
> >> +       unsigned int lane;
> >> +
> >> +       lane = nd_region_acquire_lane(nd_region);
> >> +
> >> +       if (rw)
> >> +               memcpy(mmio->base + dpa, iobuf, len);
> >> +       else {
> >> +               memcpy(iobuf, mmio->base + dpa, len);
> >> +               arch_invalidate_pmem(mmio->base + dpa, len);
> >> +       }
> >> +
> >> +       nd_region_release_lane(nd_region, lane);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int ndtest_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
> >> +                                   struct device *dev)
> >> +{
> >> +       struct nd_blk_region *ndbr = to_nd_blk_region(dev);
> >> +       struct nvdimm *nvdimm;
> >> +       struct ndtest_dimm *p;
> >> +       struct ndtest_blk_mmio *mmio;
> >> +
> >> +       nvdimm = nd_blk_region_to_dimm(ndbr);
> >> +       p = nvdimm_provider_data(nvdimm);
> >> +
> >> +       nd_blk_region_set_provider_data(ndbr, p);
> >> +       p->region = to_nd_region(dev);
> >> +
> >> +       mmio = devm_kzalloc(dev, sizeof(struct ndtest_blk_mmio), GFP_KERNEL);
> >> +       if (!mmio)
> >> +               return -ENOMEM;
> >> +
> >> +       mmio->base = devm_nvdimm_memremap(dev, p->address, 12,
> >> +                                        nd_blk_memremap_flags(ndbr));
> >> +       if (!mmio->base) {
> >> +               dev_err(dev, "%s failed to map blk dimm\n", nvdimm_name(nvdimm));
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       p->mmio = mmio;
> >> +
> >> +       return 0;
> >> +}
> >
> > Are there any ppc nvdimm that will use BLK mode? As far as I know
> > BLK-mode is only an abandoned mechanism in the ACPI specification, not
> > anything that has made it into a shipping implementation. I'd prefer
> > to not extend it if it's not necessary.
> >
> That is correct. There is no BLK mode/type usage in ppc64. But IIUC, we
> also had difficulty in isolating the BLK test to ACPI systems. The test
> code had dependencies and splitting that out was making it complex.

I wouldn't be opposed to an "if (nfit_test)" gate for the BLK tests.
Whatever is easiest for you because I'm just thrilled to be able to
regression test the ppc infrastructure, i.e. no need to spend extra
effort making the tests perfect.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
