Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F115FA2F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 15 Feb 2020 00:05:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B076410FC341C;
	Fri, 14 Feb 2020 15:08:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE6141007A841
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 15:08:40 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i6so10731875otr.7
        for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFbGjBAZ9jJ0epeJ8+efVvoWM9zaa3+GyCDFwE2/leM=;
        b=JMTUKbWTyneQpCu5P7I6UY4sjbtgcldSXd8L6n24Ux/t41POpIteMsP3aa4eebSYZl
         puBtNSopjm55AOT7X1FSnUU4whwN+YFgMC9PCjzgxdcA5tNBbmDW1XPp4uYbNM75J1Gl
         +6wP4N0b//tq9VMwWxGNNCKfxpvP9+eiqoIGuiMRRza2HJaZEeQ4isuHO7iYlwmw6zR8
         5NJfOBLW0bd+vnwxwOKAMtiZ0HDb91pCHTz9sqX+VJBKT0Q9aEnm1QgJy5aGqk71HIuF
         LJwai3h5GTbqhdXGkMACukn4Zknw283nV1VHgNb/33G68/BRUNMw2ertvirUBT8Kng3e
         li5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFbGjBAZ9jJ0epeJ8+efVvoWM9zaa3+GyCDFwE2/leM=;
        b=Eo86fOjbDnMEFIk9x7rIU4zDhrOWs6TN/Q+iDiY3PkeK0qtKLxPcMlDlxRnfaC88ie
         4N3qzITja2TdelSbf7CfYLdJ3zw7fDvvKJVNZWfbfkFwU2VnD/DCp9WH+cNLC20md3Up
         NK8OtO559zTceoNBef8ukFKeCOosecaCNsEeG4zvg4iyVR9lLtUHIc4z6LM5Qr+K83Iw
         tl/20fmtyc5vdisADp2QQ1C3COQ1YrKONl/FT89NyU80R4MMA44dFJQlpGzfe8y797gM
         Hwf2CrhTcKtooX+ZDnrP9J4oOFOm9QtLHADWumdElNqTCrO3XfJPlx79ZmjnZ5oSgcMd
         5h2Q==
X-Gm-Message-State: APjAAAVGB+XQWCypIoVYUbFxwHOo2RdGWuf3UQaL68lHeiPGj4LcCqki
	l9lQDj5teVhEqcs9EjcqsJPWUojZRvC7mHcmN4kkeQ==
X-Google-Smtp-Source: APXvYqyiTvPjMMOcsUvKfqz6iMQdR7SXgorFNb7wdpVGvSunO+Nl0vivaI37jSYP7UU4tRj9jLKbuUD42j/eENCmZ7c=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr3938798otm.247.1581721522180;
 Fri, 14 Feb 2020 15:05:22 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x498sl677cf.fsf@segfault.boston.devel.redhat.com> <CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
 <x49k14odgwz.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k14odgwz.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Feb 2020 15:05:09 -0800
Message-ID: <CAPcyv4hc2ZOyymas1svXYQFa49tziC2ZkVLfgKVV64bu4gTTEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce memremap_compat_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: IWT7Y3DS2VXXLUSC3COJBV7UPBAGBFFF
X-Message-ID-Hash: IWT7Y3DS2VXXLUSC3COJBV7UPBAGBFFF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IWT7Y3DS2VXXLUSC3COJBV7UPBAGBFFF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 14, 2020 at 12:59 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> >> I have just a couple of questions.
> >>
> >> First, can you please add a comment above the generic implementation of
> >> memremap_compat_align describing its purpose, and why a platform might
> >> want to override it?
> >
> > Sure, how about:
> >
> > /*
> >  * The memremap() and memremap_pages() interfaces are alternately used
> >  * to map persistent memory namespaces. These interfaces place different
> >  * constraints on the alignment and size of the mapping (namespace).
> >  * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
> >  * only map subsections (2MB), and at least one architecture (PowerPC)
> >  * the minimum mapping granularity of memremap_pages() is 16MB.
> >  *
> >  * The role of memremap_compat_align() is to communicate the minimum
> >  * arch supported alignment of a namespace such that it can freely
> >  * switch modes without violating the arch constraint. Namely, do not
> >  * allow a namespace to be PAGE_SIZE aligned since that namespace may be
> >  * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
> >  */
>
> Well, if we modify the x86 variant to be PAGE_SIZE, I think that text
> won't work.  How about:

...but I'm not looking to change it to PAGE_SIZE, I'm going to fix the
alignment check to skip if the namespace has "inner" alignment
padding, i.e. "start_pad" and/or "end_trunc" are non-zero.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
