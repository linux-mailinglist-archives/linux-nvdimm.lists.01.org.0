Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51C94B08
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 18:57:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF06820218C4B;
	Mon, 19 Aug 2019 09:58:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C21E820216B73
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 09:58:56 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w4so2297834ote.11
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 09:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pJz5TWO3HqyvAXE4n+BERy8lXD9ov5MYFtm7ShaG7iE=;
 b=W8kT6Fr/sEKxeSab1zBTk5JmxeNrMn3Y1y9/NC6skSJLvVLBpW2ELhqcqg2h/if0uo
 0e8cjTy1LAF1Gp91oUKURmAqKMUXzQV99WjzHQAckRWlWwZydwlX4OAE7w5BXV4Gck6w
 GiAIVZOWzO9pzIRCQsQGroFmdMWbCV+OXwt4Dr3D/b8p/Qgjbg1z1NnBqPE5Th27Iwbb
 i338YQEJW6ag0i7lkkgY8YnQ7DkrhkfUCVp03brb7sfSpLA7e1XuEBndRU1OztKXhSBQ
 fsd5RglSvHSgc9joGVk9HozoM7cGL+u/Hfjrw8aAZuNaWmcC4QRxznSAAWCjivAlSDZc
 DXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJz5TWO3HqyvAXE4n+BERy8lXD9ov5MYFtm7ShaG7iE=;
 b=fZhirVQ+H8SFBX/ciCyjtc/yrvvhH/x5UAitenxbnPByvCotK+Wr4o16h2VcDbABFG
 BsxpngvWIItsp4xq2qqVbfqU+fzOp1u9y51W3kQHBBwtrolhAEvDG22jjTnPBxCZj5En
 i9tr6qUnqnCnojMdq7w9T/s4lzx6YIjY6+ZQ5A43T9znVexxe0ujLLx/52wkQZMFO3+5
 w6ib+7ObFLAg8AGxaHVfY4NgH8dY+NzlGyO4tS9H0lFmXUEj9GAkGw/SW0fiYPepwAVM
 5B0kDr7cnnMOITYYMTaKeL9KRVnnxnj+dER6frUs31f+RjqHa9M/TqWsUkITjIvEYhub
 iFkw==
X-Gm-Message-State: APjAAAViRPz7d/e17VnCnonZr+PxYR0vg6CwLDsnLMcC/HVhalHDQ5OU
 pplSEp2mI2260SB8+5433IlwRGSssfmBNc6qiggvdA==
X-Google-Smtp-Source: APXvYqxvT1ZhKsDRbIwEX3IPiYRXr1CqtbSoNIsXLF0FOsAY+MiDfaUIE2LkS31VaEmcuGd2KBhyxsoTwTJiAVryN6M=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr19649081otq.363.1566233849670; 
 Mon, 19 Aug 2019 09:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190809074520.27115-1-aneesh.kumar@linux.ibm.com>
 <20190809074520.27115-2-aneesh.kumar@linux.ibm.com>
 <CAPcyv4jmxKPkTh0_Bbu2tRXm4vcBHonZJ6UcKrOBnPGCG2_i1A@mail.gmail.com>
 <CAPcyv4hxo4HvtqZ-B6JG5iATo_vEAKPzO5EU5Lugs2_edEbW7Q@mail.gmail.com>
 <87y2zp1vph.fsf@linux.ibm.com>
In-Reply-To: <87y2zp1vph.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 09:57:17 -0700
Message-ID: <CAPcyv4hWpFs6Q8VM35ip+DQ4thhzu6gaGxpdtkkMvj=xYb+eag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] nvdimm: Consider probe return -EOPNOTSUPP as
 success
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 19, 2019 at 12:07 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Tue, Aug 13, 2019 at 9:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >>
> >> Hi Aneesh, logic looks correct but there are some cleanups I'd like to
> >> see and a lead-in patch that I attached.
> >>
> >> I've started prefixing nvdimm patches with:
> >>
> >>     libnvdimm/$component:
> >>
> >> ...since this patch mostly impacts the pmem driver lets prefix it
> >> "libnvdimm/pmem: "
> >>
> >> On Fri, Aug 9, 2019 at 12:45 AM Aneesh Kumar K.V
> >> <aneesh.kumar@linux.ibm.com> wrote:
> >> >
> >> > This patch add -EOPNOTSUPP as return from probe callback to
> >>
> >> s/This patch add/Add/
> >>
> >> No need to say "this patch" it's obviously a patch.
> >>
> >> > indicate we were not able to initialize a namespace due to pfn superblock
> >> > feature/version mismatch. We want to consider this a probe success so that
> >> > we can create new namesapce seed and there by avoid marking the failed
> >> > namespace as the seed namespace.
> >>
> >> Please replace usage of "we" with the exact agent involved as which
> >> "we" is being referred to gets confusing for the reader.
> >>
> >> i.e. "indicate that the pmem driver was not..." "The nvdimm core wants
> >> to consider this...".
> >>
> >> >
> >> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> > ---
> >> >  drivers/nvdimm/bus.c  |  2 +-
> >> >  drivers/nvdimm/pmem.c | 26 ++++++++++++++++++++++----
> >> >  2 files changed, 23 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> >> > index 798c5c4aea9c..16c35e6446a7 100644
> >> > --- a/drivers/nvdimm/bus.c
> >> > +++ b/drivers/nvdimm/bus.c
> >> > @@ -95,7 +95,7 @@ static int nvdimm_bus_probe(struct device *dev)
> >> >         rc = nd_drv->probe(dev);
> >> >         debug_nvdimm_unlock(dev);
> >> >
> >> > -       if (rc == 0)
> >> > +       if (rc == 0 || rc == -EOPNOTSUPP)
> >> >                 nd_region_probe_success(nvdimm_bus, dev);
> >>
> >> This now makes the nd_region_probe_success() helper obviously misnamed
> >> since it now wants to take actions on non-probe success. I attached a
> >> lead-in cleanup that you can pull into your series that renames that
> >> routine to nd_region_advance_seeds().
> >>
> >> When you rebase this needs a comment about why EOPNOTSUPP has special handling.
> >>
> >> >         else
> >> >                 nd_region_disable(nvdimm_bus, dev);
> >> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> >> > index 4c121dd03dd9..3f498881dd28 100644
> >> > --- a/drivers/nvdimm/pmem.c
> >> > +++ b/drivers/nvdimm/pmem.c
> >> > @@ -490,6 +490,7 @@ static int pmem_attach_disk(struct device *dev,
> >> >
> >> >  static int nd_pmem_probe(struct device *dev)
> >> >  {
> >> > +       int ret;
> >> >         struct nd_namespace_common *ndns;
> >> >
> >> >         ndns = nvdimm_namespace_common_probe(dev);
> >> > @@ -505,12 +506,29 @@ static int nd_pmem_probe(struct device *dev)
> >> >         if (is_nd_pfn(dev))
> >> >                 return pmem_attach_disk(dev, ndns);
> >> >
> >> > -       /* if we find a valid info-block we'll come back as that personality */
> >> > -       if (nd_btt_probe(dev, ndns) == 0 || nd_pfn_probe(dev, ndns) == 0
> >> > -                       || nd_dax_probe(dev, ndns) == 0)
> >>
> >> Similar need for an updated comment here to explain the special
> >> translation of error codes.
> >>
> >> > +       ret = nd_btt_probe(dev, ndns);
> >> > +       if (ret == 0)
> >> >                 return -ENXIO;
> >> > +       else if (ret == -EOPNOTSUPP)
> >>
> >> Are there cases where the btt driver needs to return EOPNOTSUPP? I'd
> >> otherwise like to keep this special casing constrained to the pfn /
> >> dax info block cases.
> >
> > In fact I think EOPNOTSUPP is only something that the device-dax case
> > would be concerned with because that's the only interface that
> > attempts to guarantee a given mapping granularity.
>
> We need to do similar error handling w.r.t fsdax when the pfn superblock
> indicates different PAGE_SIZE and struct page size?

Only in the case where PAGE_SIZE is less than the pfn superblock page
size, the memmap is stored on pmem, and the reservation is too small.
Otherwise the PAGE_SIZE difference does not matter in practice for the
fsdax case... unless I'm overlooking another failure case?

> I don't think btt
> needs to support EOPNOTSUPP. But we can keep it for consistency?

That's not a sufficient argument in my mind. The comment about why
EOPNOTSUPP is treated specially should have a note about the known
usages, and since there is no BTT case for it lets leave it out.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
