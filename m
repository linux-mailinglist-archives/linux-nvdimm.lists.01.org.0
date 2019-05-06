Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D515377
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 May 2019 20:13:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18F4F21250C98;
	Mon,  6 May 2019 11:13:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C12B021214958
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 11:13:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n17so16247182edb.0
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RF+CoYsepNrGbmmwc3BrcU2vzqm7V7BSod886VJiwv0=;
 b=iAd6JRjOX6cXS5y0FNW2XJ6WvvRPKYhT/6IvHlZ2418SFSqTjnGNEmEfufAH09uPtF
 49VkxpuxGKXyan9FEqMBuwApcLYmGUGixrOhtESpdlpABUMPZ7N8/UovTdziIhU88upK
 j4WE0SwVaZhfG1gNDqVLDDmhA75SiFdXba4UCXOJGgDdqfP1rS3rfmw/9d7SoRbMsGOM
 PO6LGgs5u/jSx2+y8jIHm9f8s43JUgyO4ndaBY82kSijPJK1XE4OCuAAhpxnGmqOtRBv
 IjlfDhj0TrBziM4BsbBli4RPSM49bmx3HScLhwrnqbvdsDMNlfsUYv5y2TfjyWFjkoIM
 dR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RF+CoYsepNrGbmmwc3BrcU2vzqm7V7BSod886VJiwv0=;
 b=Kf+UZvQHDxlm5A1/8utAEKj4sHe1CkGVtnKg3CkrE1CkD5VCIBMJiV43+7E/QrCyhU
 9swGCobRVckOmmLh6xXyQe0Sy8qGskqsh/a0QHBMIh0rcI9bjOlWSZx6umFrGviY8P4P
 Q6lr+9kzhYMvhpjIpi5UR3vVJ+CQwYdiVdPsFcFW92O4ITBGpj1r4cGMuvStXV315M0U
 +fy99EgS2qEXjMUpAMMP/5CjOqhqQgBGsDvtHsrS1xFHlJM84SiPxfUvfWUTnG3iIBcJ
 UcW7pDkfW/SduCbYiLlryN7RFE3Yz/QXD4pvqLVqBAYzcbAyUUiEBlOHUcIsGwV/4O6n
 7i/Q==
X-Gm-Message-State: APjAAAWurzfjO7HfDbYh5cgJZ1tchSNOToUGQpmr/7GRtGy4GGK/U0uL
 Db0ThjHucoXY8MaZFWdN3c2DLjkvrGPx5kI9bbAJ0g==
X-Google-Smtp-Source: APXvYqxFqK4/B5vwBsKri7IYoVOdJaYycRBVOH6nocLuB6+vjdSKCdwCa1fH59QgHqbrELc7DYS3V2Z28fw5LXRcLWU=
X-Received: by 2002:a50:a951:: with SMTP id m17mr26721424edc.79.1557166429629; 
 Mon, 06 May 2019 11:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com>
 <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
In-Reply-To: <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 May 2019 14:13:38 -0400
Message-ID: <CA+CK2bAeU7LOSBt7EZ3Cverpgg-0KYgOsJfSakD3aR7NWvxBzg@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To: Dave Hansen <dave.hansen@intel.com>
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
 linux-mm <linux-mm@kvack.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, James Morris <jmorris@namei.org>,
 "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 6, 2019 at 1:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > +{
> > +     return -EBUSY;
> > +}
>
> This seems like an appropriate place for a WARN_ONCE(), if someone
> manages to call remove_memory() with hotplug disabled.
>
> BTW, I looked and can't think of a better errno, but -EBUSY probably
> isn't the best error code, right?

Same here, I looked and did not find any better then -EBUSY. Also, it
is close to check_cpu_on_node() in the same file.

>
> > -void remove_memory(int nid, u64 start, u64 size)
> > +/**
> > + * remove_memory
> > + * @nid: the node ID
> > + * @start: physical address of the region to remove
> > + * @size: size of the region to remove
> > + *
> > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > + * and online/offline operations before this call, as required by
> > + * try_offline_node().
> > + */
> > +void __remove_memory(int nid, u64 start, u64 size)
> >  {
> > +
> > +     /*
> > +      * trigger BUG() is some memory is not offlined prior to calling this
> > +      * function
> > +      */
> > +     if (try_remove_memory(nid, start, size))
> > +             BUG();
> > +}
>
> Could we call this remove_offline_memory()?  That way, it makes _some_
> sense why we would BUG() if the memory isn't offline.

Sure, I will rename this function.

Thank you,
Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
