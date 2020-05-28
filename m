Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1241E6F48
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 00:40:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29277122DCD3E;
	Thu, 28 May 2020 15:36:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67787122F144E
	for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 15:35:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g9so186422edr.8
        for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj7A6R3t5vYVQH1AYdusNsvmuch5nd+84dKo2RoCBgI=;
        b=ApW11aLoJ0QAG2tZcmN+rdwgoaIAg9hW1Ok1EWmH8gaAfe+1SisQoi+eMmGOKDQU5O
         Kqveu+xqkduvnPbdglT33vDs/0DRUIGkxbYKvQQNnQBZ1j/FzFJxN9Ncqsw94yS5kRzg
         QsK9obyyTGqh+oV87+qYzt+tWZsCzUgxkBeDtRZ91NLc0iVJdQELPa1FhuejruEOk+cG
         vP6h8qZP8yRz6GDzLSC4IVWeZuDj6mpO2NMRfbh88HrtS4nMREyS2FFkgSJr6QEpGvaY
         7R47VD6GGODGNT+MkKA8AkUBKoTV6lsLLy/YBd1/xXb1/hGX1Y5O83z1qtXQwQe8IRhK
         1ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj7A6R3t5vYVQH1AYdusNsvmuch5nd+84dKo2RoCBgI=;
        b=hf2q3+cZ0PBIQspdzNmg8fAJvju9oexP88+u3LURDJURzqqA81YBAAGoay6gufEIe5
         ouBDDIYuFZTNOocbHq1nV2dy+AgT0kZk7UslcLk6eQjlCuJHQOSRpYSEZ3hu8tmvLu08
         HZ/m9R06S/zsG2sTZRvrELuxUxCTmBaJfUoFENdcOBcwUXgoqFmVWyk3eyF7vYAKcLc4
         w8EstjUXh18qsQLPy8+es+59KK3CyIvvm8kKP9+VZWnEs/7tucXT6gw/hlLaGZDzYHUZ
         VG1fde5yHmSwkl1c8q92jZMzeIvAlLRz9knsShwD1IytmbxqDHXD970RwCslCVtq/fd3
         jKfA==
X-Gm-Message-State: AOAM531u/6AMnKtfbXoSN69Nm4TNIV6fWw3/JPJzxtl20+hBbymetLQM
	NRHeJtxdsWu92KqMDrOA3AxsMlj98CXpQbKYemcP+g==
X-Google-Smtp-Source: ABdhPJw6BYgPdSobVXqMuZZp5bdAAMKth8ZeJ4tESICsJihuKfQu9XXyHux3QcEckTMVfgluJA1kCniEYKpie6M0Hs4=
X-Received: by 2002:a50:eb0c:: with SMTP id y12mr5383529edp.165.1590705617704;
 Thu, 28 May 2020 15:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <87d06swfr4.fsf@linux.ibm.com> <CAPcyv4jQmQceE_eptnfnrORfAUnikHConhchYLEUPARYRFOcbA@mail.gmail.com>
 <CAPcyv4iTNK1ixzBRkm=09mHfrWzmd97HE4v-M2K5Uz0cKKT=3Q@mail.gmail.com> <87r1v3lwcn.fsf@linux.ibm.com>
In-Reply-To: <87r1v3lwcn.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 28 May 2020 15:40:06 -0700
Message-ID: <CAPcyv4jjH3=Zah1vmQyVFUwbTaiRovcUwSiVD0eJ08DVJ_DZCw@mail.gmail.com>
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a
 generic way
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: WDS3DD4H5KU6JHJIXDDIP7WCCC3PF5RS
X-Message-ID-Hash: WDS3DD4H5KU6JHJIXDDIP7WCCC3PF5RS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@d-silva.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WDS3DD4H5KU6JHJIXDDIP7WCCC3PF5RS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 28, 2020 at 11:59 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Thanks for this taking time to look into this Dan,
>
> Agree with the points you have made earlier that I am summarizing below:
>
> * This is better done in ndctl rather than ipmctl.
> * Should only expose general performance metrics and not performance
>   counters. Performance counter should be exposed via perf
> * Vendor specific metrics to be separated from generic performance
>   metrics.
>
> One way to split generic and vendor specific metrics might be to report
> generic performance metrics together with dimm health metrics such as
> "temprature_celsius" or "spares_percentage" that are already reported in
> by dimm health output.
>
> Vendor specific performance metrics can be reported as a seperate object
> in the json output. Something similar to output below:
>
> # ndctl list -DH --stats --vendor-stats
> [
>   {
>     "dev":"nmem0",
>     "health":{
>       "health_state":"ok",
>       "shutdown_state":"clean",
>       "temperature_celsius":48.00,
>       "spares_percentage":10,
>
>       /* Generic performance metrics/stats */
>       "TotalMediaReads": 18929,
>       "TotalMediaWrites": 0,
>       ....
>     }
>
>     /* Vendor specific stats for the dimm */
>     "vendor-stats": {
>     "Controller Reset Count":10
>     "Controller Reset Elapsed Time": 3600
>     "Power-on Seconds": 3600

Looks reasonable, although I think I want to maintain the
"Linux-style" format for the keys i.e. lowercase + underbars. If only
for consistency, but it also simplifies parsers that have this far
have assumed no whitespace in the key names.

>     }
>   }
> ]
>
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Wed, May 27, 2020 at 12:24 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > [..]
> >> > This was done by adding two new dimm-ops callbacks that were
> >> > implemented by the papr_scm implementation within libndctl. These
> >> > callbacks are invoked by newly introduce code in 'util/json-smart.c'
> >> > that format the returned stats from these new dimm-ops and transform
> >> > them into a json-object to later presentation. I would request you to
> >> > look at RFC patch-set[2] to understand the implementation details.
> >>
> >> I'm ok to add some stats to ndctl, but I want ndctl to be limited to
> >> general statistics and not performance counters. Performance counters
> >> and performance events should be abstracted through perf where
> >> possible.
> >
> > Another aspect that helps common statistics is to expose them in
> > sysfs. I'm going to go review your proposed ioctl mechanism, but I
> > would hope that is reserved for multi-field command payloads that need
> > to be sent as a unit rather than statistics retrieval that is amenable
> > to a sysfs interface.
>
> The patchset is using a machenism similar to GET_CONFIG_SIZE/DATA to
> retrive a struct composed of tuples of (stat-id, stat-value) from
> papr_scm and then exposes them to ndctl via some new dimm-ops.

I think sysfs is a better fit for this. Yes, we could make this work
as you have identified, but I think it was a mistake that I did this
for health properties especially the static ones.

See commit:

     0ead11181fe0 acpi, nfit: Collect shutdown status

That started as data which was only available via ioctl, but It
simplified userspace to have a sysfs attribute. In addition to the
built-in enumeration / capability detection that sysfs affords, it
also allows for the kernel to cache this property once that many
different userspace agents might want to read. Between perf for
dynamic peformance properties, and sysfs for static / health data,
what's left for the ioctl path?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
