Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652C210336
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 07:09:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C8E411202ACD;
	Tue, 30 Jun 2020 22:09:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA49511022291
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 22:09:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so9150540ejx.0
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsHporRflsSRBonyyCx9KMzLNZb5MKP0RDdeZPzTvew=;
        b=odRJ1geKdCr/so3QsY4B8TGj56/Srlu/ti+PE9rh3/JHMvnyVBG5rOxeHPmd2ffloP
         nEI4qJXYBdSbwZk+oh0v6Vc1MvSu/eEybSc2hrnDANuP3FLxgff7Uy+9M8coTj7uQalx
         A8kVfM3dpBpY5BjJ7t3UK7Rf4vabwOfmj3t0Xfr9qRkGjqcM7NmLtjs7J+YaQUxfayVb
         /toHGxYlIRKe+FJ+7ZjG+Y7VKEgcuzsvoLelDK0KdGXbT4PHPCh0ERdKgJY7ZvPqFNtj
         7qjw+wPxkOmiS45d82AyPBGwUgiymUrMrMgNVgYZI8D5vy1ZLxAcf/qqfPj2Nn1JHzfn
         ZIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsHporRflsSRBonyyCx9KMzLNZb5MKP0RDdeZPzTvew=;
        b=tRR2kqCHWRLOyzMOohcRTZAdYe424flGpmA4OJiGMu5iolXypv5/Xq4w9GwQpQTwCW
         lLsKR3+pARIDE6AhCxiZB8RCIMJAQ/m3bwVVbZMVBSyk1nbTojY0yqCw0xKkppIFI2yO
         pVkpEAkTKNHqbwlvsWvcfi4rF9Ym9zwdViVQtYYNP0snlKa7qm2KjD4ETFq37mUW3z1Z
         RUCwklNIr0Q3Y27Eg7n/Gb77XwdLe0t4eDxG+uH9DooBPvbhC/UUESI4JHgI3Mc46vix
         uuvKPiSaaXgsAcyYBrd1AR/l8i3tanXmlf66cR2SUJH3bZKELjvWx3h4ryIWY1don6tr
         5FIg==
X-Gm-Message-State: AOAM532iYb/VEJOFBz1RYmbtlwpkCaC1s6TWUa+TUFHycwDF+EQJ3+sM
	Sq80hW8u9JhveFb6LXeCx6/45Iw8cEokia4Xmr201g==
X-Google-Smtp-Source: ABdhPJwJOUTc68//QiDCG08PMgx7ieaUctYogS8mUX7/cGgUdFfY8MKvtQb1iznwXD5atkhWEeKYCcb5XLNiqxnpLPQ=
X-Received: by 2002:a17:907:20af:: with SMTP id pw15mr22296111ejb.204.1593580139878;
 Tue, 30 Jun 2020 22:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com> <20200629160940.GU21462@kitsune.suse.cz>
 <87lfk5hahc.fsf@linux.ibm.com> <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
 <20200630085413.GW21462@kitsune.suse.cz> <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
 <CAPcyv4gHHjifQcLMdVgo9CyixHxe6OkCYdQ7Jfu2YB7tBqpDNg@mail.gmail.com> <4a7bf5c8-a5c7-4292-c7ad-89bcefd7b22d@linux.ibm.com>
In-Reply-To: <4a7bf5c8-a5c7-4292-c7ad-89bcefd7b22d@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jun 2020 22:08:48 -0700
Message-ID: <CAPcyv4jHy=jQVdfFJTN=o3=wgCeLXd3Q29e+qoMUtZDA9KWZGw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: PFVEICXTN5GGCPGLD3RNX52DPAHEERIL
X-Message-ID-Hash: PFVEICXTN5GGCPGLD3RNX52DPAHEERIL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PFVEICXTN5GGCPGLD3RNX52DPAHEERIL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2020 at 8:09 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 7/1/20 1:15 AM, Dan Williams wrote:
> > On Tue, Jun 30, 2020 at 2:21 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > [..]
> >>>> The bio argument isn't for range based flushing, it is for flush
> >>>> operations that need to complete asynchronously.
> >>> How does the block layer determine that the pmem device needs
> >>> asynchronous fushing?
> >>>
> >>
> >>          set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >>
> >> and dax_synchronous(dev)
> >
> > Yes, but I think it is overkill to have an indirect function call just
> > for a single instruction.
> >
> > How about something like this instead, to share a common pmem_wmb()
> > across x86 and powerpc.
> >
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index 20ff30c2ab93..b14009060c83 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1180,6 +1180,13 @@ int nvdimm_flush(struct nd_region *nd_region,
> > struct bio *bio)
> >   {
> >          int rc = 0;
> >
> > +       /*
> > +        * pmem_wmb() is needed to 'sfence' all previous writes such
> > +        * that they are architecturally visible for the platform buffer
> > +        * flush.
> > +        */
> > +       pmem_wmb();
> > +
> >          if (!nd_region->flush)
> >                  rc = generic_nvdimm_flush(nd_region);
> >          else {
> > @@ -1206,17 +1213,14 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
> >          idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));
> >
> >          /*
> > -        * The first wmb() is needed to 'sfence' all previous writes
> > -        * such that they are architecturally visible for the platform
> > -        * buffer flush.  Note that we've already arranged for pmem
> > -        * writes to avoid the cache via memcpy_flushcache().  The final
> > -        * wmb() ensures ordering for the NVDIMM flush write.
> > +        * Note that we've already arranged for pmem writes to avoid the
> > +        * cache via memcpy_flushcache().  The final wmb() ensures
> > +        * ordering for the NVDIMM flush write.
> >           */
> > -       wmb();
>
>
> The series already convert this to pmem_wmb().
>
> >          for (i = 0; i < nd_region->ndr_mappings; i++)
> >                  if (ndrd_get_flush_wpq(ndrd, i, 0))
> >                          writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> > -       wmb();
> > +       pmem_wmb();
>
>
> Should this be pmem_wmb()? This is ordering the above writeq() right?

Correct, this can just be wmb().

>
> >
> >          return 0;
> >   }
> >
>
> This still results in two pmem_wmb() on platforms that doesn't have
> flush_wpq. I was trying to avoid that by adding a nd_region->flush call
> back.

How about skip or exit early out of generic_nvdimm_flush if
ndrd->flush_wpq is NULL? That still saves an indirect branch at the
cost of another conditional, but that should still be worth it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
