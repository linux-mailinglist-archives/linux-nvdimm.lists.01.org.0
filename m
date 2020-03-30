Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8311984F9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 21:55:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ABC3210077D1D;
	Mon, 30 Mar 2020 12:56:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3B201007A83C
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 12:56:01 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id de14so22292169edb.4
        for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m2AnfIRcCHRpZW6PDeIax9gdSThqigcANOhQSHQQRM=;
        b=l9UrcbgGyZHpzzpXZ0ao5T6qmamT4bwpPo9Q1ZImIf8A7LLg6hVilR0KrN4O3gamsX
         TTDYIQCaPyZJm/VklimIRgeNaVSOlkAPYBcWC6u4lLFVoKVG3GvRC4sgvM5WwLN230cR
         NqacKnMDiHYRg5NxBw2W+fdR/djzIb+BwQuL5HGUnGcaGsEKVpBQA6Ibaza1SI8dNSo4
         1wCRpauHNIBwEuVetbcLpEdV1LxzYnn6SincBoe4V3EhF3iBRM/JOpP5Gm6ettn+PyeR
         kd8ucX/kUEddGzeLrJ8AcsMIcaAHlPDS+29wJSZpBltd4kvSmndVWXZiizq1H4clGtmK
         Zjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m2AnfIRcCHRpZW6PDeIax9gdSThqigcANOhQSHQQRM=;
        b=G2bfomvyDHd4NBGTx4hJwp3IVsDb8TdKBEOy9Xj1L7IP1fEUHdPV27RTQ9/4hTqM3k
         KujR24jiELbGSieqI2FYxLkWvJnAWi5R0C3ngsOkwW+w54fZAjKxpK9CDCoqSM5xWO4w
         13a8W4rkrGGRAiwoVXwA/1cYVoY4S2v5VgZgGcBvBvB41cKRa/4m9llsG+kL7y+cR797
         W29cVqY+0nMJ42tJCselAj6R85XmqpgXkur8G7eeNaNpzpLu8dbepgQMDNVHUMd5qv2m
         nRK9DqG/h3yrQinBpUdddQEcQxKxLYUk30Nvo1tw3TEVEE0RVE9F7IXYLZsemeLNCePq
         j6Lg==
X-Gm-Message-State: ANhLgQ1ptkuDOuogh+xjTkoPVvf1qk+DrXrH7Pavc6m0BSbzzdLkxQwP
	jQ4U4gmQ8w/L6rLtoRnJk+1/FrWT30eXiUKZCjyhwA==
X-Google-Smtp-Source: ADFU+vuRYf2PNGMfKGMR9APzvmfg1zGeVpB4kVz6LrQE2pYYEguvqYB2rhx1GF+WePdck7GQUX3jq1SI88VCcV1b6Hc=
X-Received: by 2002:a17:906:1697:: with SMTP id s23mr12715702ejd.211.1585598108932;
 Mon, 30 Mar 2020 12:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319195046.GA452@embeddedor.com> <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Mar 2020 12:54:57 -0700
Message-ID: <CAPcyv4icgZEn9r9-+-R+rBQKebq+QcpYGQ-dvCiqhkO8XmDmEA@mail.gmail.com>
Subject: Re: [PATCH][next] acpi: nfit.h: Replace zero-length array with
 flexible-array member
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: QKWACDS5MT5XIHIK5D3ZQQLES6OCKHC4
X-Message-ID-Hash: QKWACDS5MT5XIHIK5D3ZQQLES6OCKHC4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QKWACDS5MT5XIHIK5D3ZQQLES6OCKHC4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 25, 2020 at 3:06 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 9:15 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> >
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> >
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> >
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> >
> > This issue was found with the help of Coccinelle.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Dan,
>
> I'm assuming that you will take care of this one or please let me know
> otherwise.

Yes, this one and the other 2 related libnvdimm fixups are in my queue.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
