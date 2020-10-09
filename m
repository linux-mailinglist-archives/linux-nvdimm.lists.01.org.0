Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15E28916A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 20:49:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BC6C1594851B;
	Fri,  9 Oct 2020 11:49:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2BF781594851A
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 11:49:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so10429571eds.1
        for <linux-nvdimm@lists.01.org>; Fri, 09 Oct 2020 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCV6S1HyAN5XArKAUV7/fo64BD6KTJE5/ZG14qnHALs=;
        b=Dlr+Vz8yhr8fKTsibtOTAmulle2ZOZ9aqZhcQozdfBtg1/IYb65k85Ngq/8NmnvLpS
         fSkkI2YuXXVi4jkTzVNoH8bc2lZQf6X8iUFjx8LvI9gjdXSoisHs0LioLEoxPgW5gGYF
         gaM91Qw+MFZFN6pOEvzEK6j2Y7Bo1cbM/mOcQfaMzAm5apbJtfWvbqbFPixBNTS9DkF8
         z/Fc1kdHKgr9f2bnopZyvyalCJ/WRT2fAJBEl4F9tdoCwJlRmO5Sji7rgXO18jj/FJAd
         GLeKvoq6Ep1iloKp/B3AQ/puk0QMM6cchXXt/sh6IjarFbGvWZ36NVH1q7ImC6ACRCtZ
         7FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCV6S1HyAN5XArKAUV7/fo64BD6KTJE5/ZG14qnHALs=;
        b=XAVLr0ZUPztjgbphcKsgttF2/37yzLqVr3ardflpa+Bnx2H279OtktgCegpsTAeOjV
         cl4O69JUQP0bF6rA5fHcDglpGgbeNmBD7ZoKEzcbg15Oxqaq+ELVvECqUXX/tAOSMWFq
         QA8R/QY3CM3k81DgZk5Mxc7QoVarwlv+Kz1fZRZ+ff6ugPU5O9NQ7hoHMkWKcPqUR8ch
         5KXhs/7o7ckdo60l3C6kDpy1PlZhXz2jQn3L8gn51NcCWk9K82Dbe+oLm4s0FuViOjfm
         bPDdnBk16Zixn/zqniLa/kujAHhjHVWXt1b7+tXBYUc9vl4EbuDP3V8SDW/NHYvupAvn
         EIRA==
X-Gm-Message-State: AOAM5327Ap1AD7MRqzBdKS9q2nlQMC7DWX9BKwLT9AqJH5qkUcBqCLZA
	sfuJqZ7q/lEx4pfHg4lVg0L+wC7F1f8nzRzJCUPcU4BDXGw=
X-Google-Smtp-Source: ABdhPJyypl2Y4O3MUWcL9YonD1uYrWzIHozYyM6NDMoHyLnu8mls0BNgV9kQwuLRr2vO9l9fKf/hDblecLLRf3IjULE=
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr645033edb.210.1602269364054;
 Fri, 09 Oct 2020 11:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201009120009.243108-1-vaibhav@linux.ibm.com> <145db3d86fa6bddf55c0e7c4aa149984676cd723.camel@intel.com>
In-Reply-To: <145db3d86fa6bddf55c0e7c4aa149984676cd723.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Oct 2020 11:49:12 -0700
Message-ID: <CAPcyv4j89a_Nevq1y92UPGedm74VUYCunkf62T5S3UeXzW6vKg@mail.gmail.com>
Subject: Re: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: IMIDD3TQOESYNPHCIXOUBO3BPV65ATKZ
X-Message-ID-Hash: IMIDD3TQOESYNPHCIXOUBO3BPV65ATKZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>, "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IMIDD3TQOESYNPHCIXOUBO3BPV65ATKZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 9, 2020 at 11:36 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Fri, 2020-10-09 at 17:30 +0530, Vaibhav Jain wrote:
> > commit 107a24ff429f ("ndctl/list: Add firmware activation
> > enumeration") introduced changes in add_dimm() to enumerate the status
> > of firmware activation. However a branch added in that commit broke
> > the probe for non-nfit nvdimms like one provided by papr-scm. This
> > cause an error reported when listing namespaces like below:
> >
> > $ sudo ndctl list
> > libndctl: add_dimm: nmem0: probe failed: No such device
> > libndctl: __sysfs_device_parse: nmem0: add_dev() failed
> >
> > Do a fix for this by removing the offending branch in the add_dimm()
> > patch. This continues the flow of add_dimm() probe even if the nfit is
> > not detected on the associated bus.
> >
> > Fixes: 107a24ff429fa("ndctl/list: Add firmware activation enumeration")
> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  ndctl/lib/libndctl.c | 3 ---
> >  1 file changed, 3 deletions(-)
>
> Ah apologies - this snuck in when I reflowed Dan's patches on top of the
> papr work for v70.
>
> I expect you'd like a point release with this fix asap?
>
> Is there a way for me to incorporate some papr unit tests into my
> release workflow so I can avoid breaking things like this again?
>
> I'll also try to do a better job of pushing things out to the pending
> branch more frequently so if you're monitoring that branch, hopefully
> things like this will get caught before a release happens :)

Would be nice to have something like a papr_test next to nfit_test for
such regression testing. These kinds of mistakes are really only
avoidable with regression tests.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
