Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C5F3888
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 20:24:47 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05D38100EA622;
	Thu,  7 Nov 2019 11:27:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 251EB100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 11:27:06 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 22so3027053oip.7
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 11:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDmD+zaMiFRNqdOi0LoMJjqkzb2qnDhlH31Ew0K/t3M=;
        b=Ju5K48px/bEUcFhoApuHqhpxtaqaCl8eC/0lTWRC6m0x05zNzNkxn0O79hqDpkCz7u
         +neepugDy6vIyhKfDIivYltEpRJdZPulisdVlISmGkvk5TcbnrG9km3CEp0Zc2TN3MXs
         MZzwwKb9VH3dvdbsQc1E+a6J5LtqPfMLgcQd1tVQoJ/QT4LVRnmxl2wg8ziBNWOLE+Rj
         OQy+wIWymqNLnOZmq8ck/FBD+ROaoda7BZWYNVTBLcbRWIdQRRhFpNRHvifZgNRvqngG
         acL1UaStaSPyHWv+ZyLIQ7VM5az6yAFTtlzcqtZjdOiouE7vAgRoc3ZUiomU2+PIE7P5
         hHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDmD+zaMiFRNqdOi0LoMJjqkzb2qnDhlH31Ew0K/t3M=;
        b=WvfO3aiTRZaiOAQr2Xkq+zK4lhB/mTfqwk5ORe+JpayunuJ+qCiQEdcD+QWXta6o3J
         +SKIWH2Llq2BGb1esBgpTiSGW82x+g2XGY206j5C+ilwcD+hlqV2rX46Q/VSisE4i3Vn
         N8KNvwUaJuYMJ2/y2Go4TDNM9HZXs9eI29x6yBcVkUwus/W8pepwpTqat+nrK2t/VkrP
         gSVZEht+hf65woTWzhgdhyspw4WTxSdiPwwQtUHvoQsJopn4Wkhq6hzfZ2XdQePkaN2C
         kgB1bbZMfEFzURGIx1GBG+VzvFkypoS9TtwSFp1Yw+MJ1QkDZl/pu4vGEdllkFKBrLsL
         zm/A==
X-Gm-Message-State: APjAAAXL5UfPSf+yDuk1mh44s/n+j3S3fcyHP5oGU4tXuETWQdfiG55i
	MBXvH1/TJr3v+3+LiUOIHcFLHGHPzPZVb09u2tuMmcZZBgk=
X-Google-Smtp-Source: APXvYqx7f0wwkjoTwofPbeN5cLWkREQMNlj3Mx7Bh/wLBOWIQtHCndRc+E7aZPG84MZuRD606bn6lYO5MMCuuGEldy0=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr4220295oie.149.1573154681373;
 Thu, 07 Nov 2019 11:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20191107152952.GA2053@swarm07> <CAPcyv4j-rSy-T5Qv6GbcDcmUerhQQYsMKbUY7EaGHz-GecKDtQ@mail.gmail.com>
 <20191107190018.GB1912@swarm07>
In-Reply-To: <20191107190018.GB1912@swarm07>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Nov 2019 11:24:30 -0800
Message-ID: <CAPcyv4hNYZvXP+Cg+sHtes6qisrkxoMAf=oi0x3NqOHxWNG53w@mail.gmail.com>
Subject: Re: [QUESTION] Error on initializing dax by using different struct
 page size
To: Won-Kyo Choe <wkyo.choe@gmail.com>
Message-ID-Hash: LRITVNYFO5EOKMV6VP6HD6FZZTETFML2
X-Message-ID-Hash: LRITVNYFO5EOKMV6VP6HD6FZZTETFML2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LRITVNYFO5EOKMV6VP6HD6FZZTETFML2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 11:00 AM Won-Kyo Choe <wkyo.choe@gmail.com> wrote:
>
> On Thu, Nov 07, 2019 at 07:54:21AM -0800, Dan Williams wrote:
> > On Thu, Nov 7, 2019 at 7:30 AM Won-Kyo Choe <wkyo.choe@gmail.com> wrote:
> > >
> > > Hi, there. I'm using Opatne DC memory to use it a volatile memory. Recently,
> > > I found that if sizeof(struct page) is above 64 bytes (e.g. 128 byes),
> > > `device_dax` cannot be initialized when system boots. I am aware that
> > > for some reason there is a function, `__mm_zero_struct_page`, which limits
> > > the size of struct page when it exceeds 80 bytes. However, due to the
> > > research purpose, I do not use that constraint and I'm quite certain
> > > that using different page size is usable in main memory. So, I'm
> > > wondering why this is not possible in persistent memory and which
> > > patches are related to this problem.
> > >
> > > I will attach the system log for clarification. The test is run in
> > > linux-5.3.9 and linuxt-5.3-rc5
> >
> > How did you manage to build the kernel with a 128byte struct page
> > size? This build assert in drivers/nvdimm/pfn_devs.c
> >
> >                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
> >
> > ...will start to trigger in v5.4 to explicitly prevent this going
> > forward. See commit e96f0bf2ec92 "libnvdimm/pfn_dev: Add a build check
> > to make sure we notice when struct page size change" for more details.
> >
> Thanks for the related commit. The kernel that I am using (5.3.9 / 5.3-rc5) does
> not have the assert so that I was able to build it by little bit modifying lines
> in include/linux/mm.h
>
>         BUILD_BUG_ON(sizeof(struct page) > 80);
>         ...
>
> , which is quite similar with the assert you referred.
>
> > In general 64-bytes per page is already expensive 128 bytes is a
> > gigantic struct page.
> Yes. I am aware that issue. I just wanted to add hot-page tracking
> feature by inserting some data structure collecting it inside struct page
> but the size is matter. I should find another way to get that stat :)

For hot page tracking you may want to look at some of the discussion
around Memory Hierarchy support:

https://lore.kernel.org/linux-mm/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
