Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E077544
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 01:45:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C33E212E15A0;
	Fri, 26 Jul 2019 16:47:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 844FE212E159A
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 16:47:38 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u15so41456234oiv.0
 for <linux-nvdimm@lists.01.org>; Fri, 26 Jul 2019 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aHa1TimnnAfLiDfmcVi6ma2k6mpqPoOiWSMQBbuPj4g=;
 b=f5hWgZyTZsnnQEdUJTBrBdb1OiDkh1oHem+vJZK+SfmpYnZHYQLlsJkvpAX7j1x9tY
 w7HpUSkrZMJyZyjE6m7TlO3mSTCC0sKx8OXuYnSCitpzbiHttBaCO+hM3ZuPs92362yK
 IxIX4HENPxZJNn3r7MlWV8GTxONBTFb9m06xvYwRv2l2zdnPEMGqDk1DIBfQfVkD8uj/
 qL55x4nwOd/3C6ruf+uSsB8IBA+pgR2m8Oppm+FMuciQj+wlm8FbrcyFbLorcxtnhJLQ
 zbz7zbH0m5w3iGfXtCfEm29r2KthD4aEnwXVg9XctBuqycME8bo1bVryrbV4h+xq1g00
 pxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aHa1TimnnAfLiDfmcVi6ma2k6mpqPoOiWSMQBbuPj4g=;
 b=Tb2qq0hzM9iULHM/6yS0MKzgWNO9qY4xHnnhKwbx9V5OSc+by5PbNidWmfykqbrFTp
 gvsjVWq72aQrJ4JJc3YlZWesIqFA6QpUxJ9BqSeNxBW/xquSg+l14COtLMHH4kS9HJe+
 BoDgJkkfcvknLeJMvGd2QsMY1L6R4rVfqwpKknVbtM3PN9LqiNQ+y4za5IR4Ef6fj4LX
 O9PD9NgL9+kcsE1BefmnzXO3Ic6DE0hVK/2AhQsl+bHtiR0QVsHDUksCBKiZIxYKZeMl
 hpa/LsvSTooH5iJHEazucb/Qtf1Om0EnjCmDeooDSDGU74mztIC87V6si9dfN2FgwtV+
 SA4Q==
X-Gm-Message-State: APjAAAU1E7Z8FJ302M03Y6ohNW0Mx0Q56QU/zGO6aPYH01uwJ42m5ZG8
 s+k5bla20OGYzBg82eyJ5HCEPtuIUMkZ2CWeCnowQA==
X-Google-Smtp-Source: APXvYqwbQzyosdkzD2INkUlYcAoImVOsQe0Ck8T39N/ERLlrxdL4rOCCDBzHixrPDgufYckgN1OeTfq2WVNBWqF1Vr0=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr43788527oih.73.1564184710685; 
 Fri, 26 Jul 2019 16:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-12-vishal.l.verma@intel.com>
 <CAPcyv4g82poaqSNZh+Q_QpdWVqjmz3C=BM74Guoe_Wj7bv6kwQ@mail.gmail.com>
 <a6ca723887fab20429929217baa08ae26513eb26.camel@intel.com>
In-Reply-To: <a6ca723887fab20429929217baa08ae26513eb26.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Jul 2019 16:44:58 -0700
Message-ID: <CAPcyv4gO=mOkW1b8_MLqs=AuYgopNA1njtaFikvKuNh1-uLb8Q@mail.gmail.com>
Subject: Re: [ndctl PATCH v7 11/13] contrib/ndctl: fix region-id completions
 for daxctl
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 26, 2019 at 4:30 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
>
> On Thu, 2019-07-25 at 19:55 -0700, Dan Williams wrote:
> > On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com
> > > wrote:
> > > The completion helpers for daxctl assumed the region arguments for
> > > specifying daxctl regions were the same as ndctl regions, i.e.
> > > "regionX". This is not true - daxctl region arguments are a simple
> > > numeric 'id'.
> >
> > Oh, that's an unfortunate difference, but too late to change now I
> > think, good find.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> Yep - though I think I like --region=0 better than --region=region0,
> less redundancy.  But agreed, probably too late to change.

We could teach it to allow both. Something for the backlog, but at
least the kernel is using a common number allocator for pmem regions
and hmem regions.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
