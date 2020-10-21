Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A893929520E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Oct 2020 20:18:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0BF315F384F3;
	Wed, 21 Oct 2020 11:18:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7839915F384EF
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 11:18:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t20so3506699edr.11
        for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBAipX6TcsGHUUwoOb+GAqip7teUB0SGQSkyDxyC1gs=;
        b=XAOo5Jq2jx+pjinIp6W/j4WMIppRlBls2T2UtaNWf6C6rxdXwNqnvvCfeujW+bAm8R
         lo0Pu6r0hPW8KHlfWj9zZxa9aW8L68TMkpmBu9LjAgb0/WgdOlKmiaFdgb8zpc9swRa/
         tCRuriK0IOv3JLGjCAMgDPvu9Q6LKkkYYx+gxi+t+tEkhglXhAwqHR0liPIDAoGoiGmC
         kc4Edw/gMXzwlV+ojHq8kZMyYnUBzIUwqLfy4+PWAe/mEIUimMtWlAJDdC4ouPfmIALW
         QvjC6dJTdWdbum1QbvBiJtkUb3yiYusV40EH18iDzBcSH/pmyMZYXKXVYHpS8wZR7g1p
         w1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBAipX6TcsGHUUwoOb+GAqip7teUB0SGQSkyDxyC1gs=;
        b=c4isMH0sk1j5mL47WZqfHZfXK6emPbmZFi34URZPWXupPT4vrvclgOuPD9fuZKXGkF
         1d4aynWEffyuLXVFwpY2A9hKaoeNmCkMzyCiH5Lz9MCwlT2G6V3pD/mz3nEdoDz8+P6U
         zBo2pt1Ki8bOCiPjXR3KhNPUSppsvX/w755bLH5j3v0TmjhdeZmwDOfy3IRPlXngLpEY
         k1rbQLKMHh8Brz+kvfijKp2QWA4VOTfPkkszW0DMYRTX2RQ/x1UmLKgHMOlkquhBoqAy
         eRATi4mCJRNnu3jYHLtVkLAP44ANnNOY6VqhIhhOGT4Y39pCggmFAwd3I8M5QgM02R0u
         0pKw==
X-Gm-Message-State: AOAM531/xa8u/dnZTv7iBB2QxXPBBL2SaS+fFXeGyDEVM3HcLMKifCWf
	PkScgbAMhPfwpktl3t1tjwY+1IjifWgRR5tK67jheA==
X-Google-Smtp-Source: ABdhPJwFv1vEpgBjqYY0mUD82Q7IPIdLR5dvMyvYhC1peIW682ciZIrOUy8jSAINdGc+hq2w+U3i5AaFLr9SS8798tg=
X-Received: by 2002:a50:f404:: with SMTP id r4mr4510255edm.354.1603304293186;
 Wed, 21 Oct 2020 11:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <160321640031.3386448.4879860972349220888.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20201021174252.GB165907@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201021174252.GB165907@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 11:18:02 -0700
Message-ID: <CAPcyv4gd+ywfS7gRsGtr5Wzazh3n5wZqcA_dcd99w=xGP8Ct_Q@mail.gmail.com>
Subject: Re: [ndctl PATCH] Rework license identification
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: BDNTKMJNVYLEZ2BNP4FOHPL5ADMZRNSW
X-Message-ID-Hash: BDNTKMJNVYLEZ2BNP4FOHPL5ADMZRNSW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BDNTKMJNVYLEZ2BNP4FOHPL5ADMZRNSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2020 at 10:43 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, Oct 20, 2020 at 10:53:20AM -0700, Dan Williams wrote:
> > Convert to the LICENSES/ directory format for COPYING from the Linux
> > kernel, and switch all remaining files over to SPDX annotations.
> >
> > Reported-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
>
> [snip]
>
> > diff --git a/ndctl/lib/hpe1.h b/ndctl/lib/hpe1.h
> > index 1afa54f127a6..acf82af7bb87 100644
> > --- a/ndctl/lib/hpe1.h
> > +++ b/ndctl/lib/hpe1.h
> > @@ -1,16 +1,5 @@
> > -/*
> > - * Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> > - * Copyright (c) 2014-2015, Intel Corporation.
> > - *
> > - * This program is free software; you can redistribute it and/or modify it
> > - * under the terms and conditions of the GNU Lesser General Public License,
> > - * version 2.1, as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> > - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> > - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> > - * more details.
> > - */
> > +// Copyright (C) 2016 Hewlett Packard Enterprise Development LP
> > +// SPDX-License-Identifier: LGPL-2.1
>
> Why drop the Intel copyright here but not elsewhere?

Oversight, good catch.

>
> >  #ifndef __NDCTL_HPE1_H__
> >  #define __NDCTL_HPE1_H__
> >
> > diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
> > index 815f254308c6..00ef0a4d1d28 100644
> > --- a/ndctl/lib/inject.c
> > +++ b/ndctl/lib/inject.c
> > @@ -1,15 +1,5 @@
> > -/*
> > - * Copyright (c) 2014-2017, Intel Corporation.
> > - *
> > - * This program is free software; you can redistribute it and/or modify it
> > - * under the terms and conditions of the GNU Lesser General Public License,
> > - * version 2.1, as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope it will be useful, but WITHOUT ANY
> > - * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> > - * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> > - * more details.
> > - */
> > +// Copyright (c) 2014-2017, Intel Corporation. All rights reserved.
> > +// SPDX-License-Identifier: LGPL-2.1
>
> And I'm not sure why some of the copyrights are extended to 2020 while others
> are not.  I would think they would all be?  But this is more of a curious
> questions.

The intent was to update all Intel copyright dates to 2020 on the
files I touched. So, another good catch, thanks Ira!

I'll leave it to other copyright holders to update their dates when
they touch the files.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
