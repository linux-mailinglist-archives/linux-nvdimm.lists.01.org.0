Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F0174A9A
	for <lists+linux-nvdimm@lfdr.de>; Sun,  1 Mar 2020 01:53:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EBA3C10FC340C;
	Sat, 29 Feb 2020 16:54:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8A2910FC3405
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 16:54:04 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id a22so6760240oid.13
        for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 16:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vG5vKAngWN33ruKiQuTpYlNArSL1q2CIczuy2BXBfuE=;
        b=EVi4QsCCZqdsO8jd42lKporuaZWmTGpqfIMnjxCebFY1LWoQBpvsJde3zsB8GpxnBt
         zw4aJI2i9+UOBEhxpyIu55VAY1xuv9Ag0Y3eU7wTricIZszIxXYZE4fn5pAsYOrQP3UE
         u+FMEGRsfhU/ecS+9x/87ShXW2Rhtg7ETsP1y4ObvCMTl62DpePlNTwWJPpBh9iKVFfU
         Ux+Ccie/MIu1m1YMRSBahPdPTuVkoc7d6KZHCa1049ULEC/MLoxTYHlF7b+gO+CkG7zL
         0l6Cy7fgfvdIUY/VJ44n1/GSKscbwmiZb2s0uxWcW0WFZVZxJVnVSja9gdLPJrjaCeYi
         yfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vG5vKAngWN33ruKiQuTpYlNArSL1q2CIczuy2BXBfuE=;
        b=kARD9uwkaEMssodzeVYVQ9jyDrjSt1n7mTkB2QqdWDtWbh8E4K0th6IqyM6BxAm8bk
         KAbAc+X7r5QCJInB7nsugkmS69OrhYl2htQ6vetUqCwyXav9HLLwlOucdG2Qm8yni7p3
         myfvMnN/zkPoucaQDLG4A+x61VAMm6zWoHQBdyHeGs/8ujAfKEZ5hbTByYIDvLCOWHRB
         WctUIF+RTUO8Tnz3O1Lw67Kp6QAforZzK+6DexGwA1r5XsZzxpRxSq326oKHECLBxo01
         EF/7B9sXmHmrrh0P/7TWbAic1PAagOCaMMBDbDhkZmLoKuskjzUfTILElV4qJTp44m3x
         Muuw==
X-Gm-Message-State: APjAAAXPu0BR5Ya55yH6VhXK+z89Ir1cPPLFtv2GLkQQMShZrIJtBpkK
	oAFZNphXvgscE8UyiyLU45KcAd90YSUwB6Zsjdav2A==
X-Google-Smtp-Source: APXvYqxQUskahAUriWcdS5qGOWflBUlwfbNwzYextBzEpd0SD71vKrl0tWRo484a4970WvsZinC6zCJ5UkXvhnIXo7Y=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr7998258oij.0.1583023992112;
 Sat, 29 Feb 2020 16:53:12 -0800 (PST)
MIME-Version: 1.0
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com> <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com> <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
 <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
 <CAPcyv4gVDEum7RiSMXug5fwNC04mEHo5MhAuUW37t4tN9y899A@mail.gmail.com>
 <00abe72085e75c1c54b87635c81352b628211707.camel@intel.com> <149112cd-0ae4-02b8-84ba-f13cce5aa45d@jp.fujitsu.com>
In-Reply-To: <149112cd-0ae4-02b8-84ba-f13cce5aa45d@jp.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Feb 2020 16:53:01 -0800
Message-ID: <CAPcyv4gyxSYKXFdkr2M646sEMYGNRTBq6SMzAJz+iuuk0XoC7w@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
To: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Message-ID-Hash: C7JWGLRTT3VID6YZL2EESJ7UJ3WVKH26
X-Message-ID-Hash: C7JWGLRTT3VID6YZL2EESJ7UJ3WVKH26
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7JWGLRTT3VID6YZL2EESJ7UJ3WVKH26/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2020 at 2:21 AM qi.fuli@fujitsu.com <qi.fuli@fujitsu.com> wrote:
>
>
>
> On 2/20/20 5:28 AM, Verma, Vishal L wrote:
> > On Wed, 2020-02-19 at 12:09 -0800, Dan Williams wrote:
> >>>>
> >>>> Let's do a compromise, because users also hate nonsensical legacy that
> >>>> they can't avoid. How about an environment variable,
> >>>> "NDCTL_LIST_LINT", that users can set to opt into the latest /
> >>>> cleanest output format with the understanding that the clean up may
> >>>> regress scripts that were dependent on the old bugs.
> >>>>
> >>> Hm, this sounds good in concept, but how about waiting for this cleanup
> >>> to go in after the (yes, long pending) config rework. Then this can just
> >>> be a global config setting, and we won't have config things coming from
> >>> the environment as well (which this would be a first of).
> >>
> >> That does make some sense, but I notice that git deals with "cosmetic"
> >> environment variables (GIT_EDITOR, GIT_PAGER, etc) in addition to its
> >> config file. So if we're borrowing from git, I'd also borrow that
> >> config vs environment logic.
> >
> > True, that's reasonable. I guess I was hoping to avoid, if we can,
> > suddenly having a multitude of config sources, but env variables are
> > pretty standard and it should be fine to add them.
>
> Hi,
>
> I am sorry for suspending the ndctl global config patch for such a long
> time. If it is not urgent, I would like to implement it.

It's getting more and more urgent, especially as more people are
trying to use the DIMM security features and finding it difficult to
contend with the command-line interface.

The goal is to import  the git config system. Specifically one of the
features of the git config syntax that are useful for DIMM security
(and in the future Namespace security) is the ability to have named
sub-sections. From the git config man page:

       Sections can be further divided into subsections. To begin a
subsection put its name in double
       quotes, separated by space from the section name, in the
section header, like in the example
       below:

                   [section "subsection"]

With that capability policy can be established by a named object
instance. dimm.<dimm_id>.<attribute>, or namespace.<uuid>.<attribute>.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
