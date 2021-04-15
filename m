Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A53610B6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Apr 2021 19:04:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F848100EB348;
	Thu, 15 Apr 2021 10:04:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.208.49; helo=mail-ed1-f49.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 87A71100EF271
	for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 10:04:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id m3so28946250edv.5
        for <linux-nvdimm@lists.01.org>; Thu, 15 Apr 2021 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWKR5QoCIcgkYDJO1D3/EqsdlJKBzOvIE5uO8N845Ek=;
        b=HZB0G/8+VAIcrWGClRrfQCWPr57el7IDgxgRcXwWOy6oNrd1n+M5Yp75CJ5pDNkLVP
         MANBsbdEixpFE0goI87DwGpstnnho0ucVJzA9JreM9hxPEBG4uj/oKvoCNhJkqeDlkwl
         B2yZSKqxaFd60GFPdGczqSw8MAalifJKU0hZDoa+dYuksPLUv+UCs+JecOLcXeOoNwCJ
         MAjyCo69RQlZwfe9eQSK18o8lBbASE03gkAv5uA9Ew4hPg0f8SqCzzi0mDo/ACfwMIbX
         ErGeyVI2CFTrOrYQr3yrxeyYn/WeOSoFuNaYFQO/RzSIRvvneMA7tpJCo13tbDwD10SM
         GCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWKR5QoCIcgkYDJO1D3/EqsdlJKBzOvIE5uO8N845Ek=;
        b=Zi6CqvEHrPJ+dibTC+3VIh8q0Xy4WMNKv28TRo2qdREUO4M3AdDMk5zQa7N6okc8hu
         Mwe34zGQ855ZPV3nRmXjxb9RzUlrjF9ts/NeG4UieaJhug3jkOIGNOFratF/rJCyza7P
         ujBJbFijDKHMB93pxrog9UYPQ7BZPA6e5TcZNggeok3fhGT5BJgQu/FquZueO4Cp3zUV
         nLEKmefDA7UuJX+l6YSFQpVVXWKpNPhVpqPMsPh6l+zU3Jqlpj31FJ2pvc51cajbt5Hj
         pn6waqjfqDvDk4K/86TXxw0/ByoUT4XbxaVRSWEDrKXfbIhUxq3C07b2w88PAt5hUu3e
         HiSw==
X-Gm-Message-State: AOAM532TDy4kEyCJFJlNTlvXJqASUomBPf0ssyJnr2wHJjvxPIYGc8LY
	agcfc4Z1l1tOc+SkcynPQljPvCYTke6nQNcJIitfLQ==
X-Google-Smtp-Source: ABdhPJyPU+CaTe3k4CP9B3bfuHwuS9lp7EC/RLUzWOQqM1xC4OnYc59f5uCi8HFc83PLFmyhXo4PcPy4HtSIMIphfbI=
X-Received: by 2002:a05:6402:51d0:: with SMTP id r16mr2092696edd.52.1618506193479;
 Thu, 15 Apr 2021 10:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
 <CAPcyv4iU3cmjRsDevDJmJc72xo-QffUu3SGCwvRh5bitG-facw@mail.gmail.com> <87k0p3lqmq.fsf@vajain21.in.ibm.com>
In-Reply-To: <87k0p3lqmq.fsf@vajain21.in.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Apr 2021 10:03:01 -0700
Message-ID: <CAPcyv4g=YqcOxwS5Q=_Z=fx5WCwU1t0M3me5OFeQodckKSfm9A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats inaccessible
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: C4URHE3SYCCOKY3T2R32R4L2WP3C4X6Q
X-Message-ID-Hash: C4URHE3SYCCOKY3T2R32R4L2WP3C4X6Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C4URHE3SYCCOKY3T2R32R4L2WP3C4X6Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 15, 2021 at 4:44 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Thanks for looking into this Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, Apr 14, 2021 at 5:40 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
> >>
> >> Currently drc_pmem_qeury_stats() generates a dev_err in case
> >> "Enable Performance Information Collection" feature is disabled from
> >> HMC. The error is of the form below:
> >>
> >> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> >>          performance stats, Err:-10
> >>
> >> This error message confuses users as it implies a possible problem
> >> with the nvdimm even though its due to a disabled feature.
> >>
> >> So we fix this by explicitly handling the H_AUTHORITY error from the
> >> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
> >> error, saying that "Performance stats in-accessible".
> >>
> >> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> >> index 835163f54244..9216424f8be3 100644
> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
> >>                 dev_err(&p->pdev->dev,
> >>                         "Unknown performance stats, Err:0x%016lX\n", ret[0]);
> >>                 return -ENOENT;
> >> +       } else if (rc == H_AUTHORITY) {
> >> +               dev_warn(&p->pdev->dev, "Performance stats in-accessible");
> >> +               return -EPERM;
> >
> > So userspace can spam the kernel log? Why is kernel log message needed
> > at all? EPERM told the caller what happened.
> Currently this error message is only reported during probe of the
> nvdimm. So userspace cannot directly spam kernel log.

Oh, ok, I saw things like papr_pdsm_fuel_gauge() in the call stack and
thought this was reachable through an ioctl. Sorry for the noise.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
