Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F372421D23
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 20:10:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10DA12126CFB5;
	Fri, 17 May 2019 11:10:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 97FD821250447
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 11:10:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j12so11781682eds.7
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0RAJ8dFkgMXY5OQlUUJ6T1gPWQG4AjdkRmpcqOy8B8o=;
 b=N6AVNHwED44tjfNeBflxf/4LK+NXnqWsv17JWf6m0n56Z8TxPCSc5PmhLfxKM9WFrq
 YbKovej0m6JAq0uY+V0fukul3/8snNc7VVGW3uaJCYOv9kESzesDs34u+v4WAStgHP3c
 sBeltk1m46EU7g2kMwLBL1Xlc9O9R/OxZjl/+/qkgn3IyGRlBAhWR9BgYqAdPvWtybzJ
 IgFGR1LpSroJPjuo0A0Qc1QBzB29kPQIib6uBuK0f/3Wx8viB4rvGm7IMOZPK6bLo+in
 ON8O8uP2Me8M1QHTOgHYyJqE46rojKl0mOXRMk3JP5y+xtGruIDjYea+Vte5dqNdk7pj
 Jbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0RAJ8dFkgMXY5OQlUUJ6T1gPWQG4AjdkRmpcqOy8B8o=;
 b=CaQmbEKv+cZ5QsHHgN7+JaPkMflH3FmdtmWefZJqPHDqf5I9+NQjQMpFiMaJsyS9B3
 Ouj2yLxEwubSh31SqS1nziVXC0sGy5RhpHxL65qo2XIcXHriGYbim1roRkLKuFHBfz0q
 JlDQCaq6OVCcEU2gJeHp1799Idv5LRCcpLr6yu6bMMvQm1CPO/ebxqihCR68Ie90FY6g
 CH1zpm84ZCR+wDLuVzaqHT/BCKKG5dOUKxELTDcnNZ4VcLlDmi3+WA+TgrhLTMoPyHTF
 4wRLoubKXz6sr/sfqUG1fkoC3x+72rLmr5TFH03X2h9GJxuYHD/SvbNBj3m9Sqf7CmOH
 1e7Q==
X-Gm-Message-State: APjAAAXug2AjNdRWJPpyGmC96eJ34XsD6Ow71BhWEplPpQ5v+PnnXM8c
 4I39eyLOgKQqGJjX3e+KPqMW766c7vzO632A38lqKw==
X-Google-Smtp-Source: APXvYqy265H8YTRxW0fmCC2I6ZxM8EIDTEHONdgksak2H40jR89a0QYHQFohoS/iSUfnFLtzqxC5+RMenGd+voNYkNc=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr58841265eds.263.1558116615828; 
 Fri, 17 May 2019 11:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com>
 <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
 <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
In-Reply-To: <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 14:10:04 -0400
Message-ID: <CA+CK2bAeLJFRDTNnUrz_JCP5DVqM2N8+09q1TX7+OCE7b5v+1A@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linux MM <linux-mm@kvack.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, James Morris <jmorris@namei.org>,
 "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Dan,

Thank you very much for your review, my comments below:

On Mon, May 6, 2019 at 2:01 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, May 6, 2019 at 10:57 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > > +{
> > > +     return -EBUSY;
> > > +}
> >
> > This seems like an appropriate place for a WARN_ONCE(), if someone
> > manages to call remove_memory() with hotplug disabled.

I decided not to do WARN_ONCE(), in all likelihood compiler will
simply optimize this function out, but with WARN_ONCE() some traces of
it will remain.

> >
> > BTW, I looked and can't think of a better errno, but -EBUSY probably
> > isn't the best error code, right?

-EBUSY is the only error that is returned in case of error by real
remove_memory(), so I think it is OK to keep it here.

> >
> > > -void remove_memory(int nid, u64 start, u64 size)
> > > +/**
> > > + * remove_memory
> > > + * @nid: the node ID
> > > + * @start: physical address of the region to remove
> > > + * @size: size of the region to remove
> > > + *
> > > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > > + * and online/offline operations before this call, as required by
> > > + * try_offline_node().
> > > + */
> > > +void __remove_memory(int nid, u64 start, u64 size)
> > >  {
> > > +
> > > +     /*
> > > +      * trigger BUG() is some memory is not offlined prior to calling this
> > > +      * function
> > > +      */
> > > +     if (try_remove_memory(nid, start, size))
> > > +             BUG();
> > > +}
> >
> > Could we call this remove_offline_memory()?  That way, it makes _some_
> > sense why we would BUG() if the memory isn't offline.

It is this particular code path, the second one: remove_memory(),
actually tries to remove memory and returns failure if it can't. So, I
think the current name is OK.

>
> Please WARN() instead of BUG() because failing to remove memory should
> not be system fatal.

As mentioned earlier, I will keep BUG(), because existing code does
that, and there is no good handling of this code to return on error.

Thank you,
Pavel
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
