Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D726B1DE9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 14:56:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A4C8202E843A;
	Fri, 13 Sep 2019 05:56:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=willy6545@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 70A25202E8435
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 05:56:36 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w6so2088466oie.11
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8w1ysR+wKpbP5Oo9e6xp++MMpq/UiUZZRYfK99iTqSo=;
 b=vXu3Te5ir/RrYRsNP+j+MX0GuoEHjnK86cV7WqhTaN6dNnS0G73XEwMsPZifLcmtY6
 N7NLCIhX3tY3GKfaofeCuaUK01/P7JDNLlqoWM0v+Szc1VynuucjW9OICXFxJJSB6pFn
 Wo9d/37ZMptyxOkZUh+s5GJiDSkzMmSzLtgHWLMWTOwIgLAe+VsBV+q0MlP85+mM4ES9
 ngqh2a4Roh0d+6SocrZA3Fs0QLtJ8bGxPUVwS9tUAXKue+V7Ry114MqXKY4v+7PMZ0TE
 57phprVczaneg8BWw0O4P00fZhLCYAPFSlZ1xrjrnHhxs8ZR0p2D0WrQfesS+EkRXmEH
 6rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8w1ysR+wKpbP5Oo9e6xp++MMpq/UiUZZRYfK99iTqSo=;
 b=n2DQAh41QZOCj+T2/uBKXHHc2x94nm8yCJdANW93eq9k8kHirs9xdk6GE3stLd264q
 qFZKdTFkacXj95Q2QLT3vB2xzrzznF8J04m7PNvXYDWeX0V6ygs7gEkBsalSmJqV/VNF
 +TrWgjVv2nhJyqynA46g5Dh4oeK12a5XQEao7lxsQImLFdK8umfccXFRdxwJ38gEuOuQ
 v8N9j4QwlYzgwF3y3IfrfT0170nrQHzh8WYtHYZeJZnwhJPkzfdTy3YayQTeSJTdF/v6
 ALYpX6SNZm7CMlH3QIRjEpXyFna6DrhrJ+B5Xa2N+hcZPDZzu1c2RTVUZJYHegcDuU/m
 /v+A==
X-Gm-Message-State: APjAAAV8OVJTm+BajkCp/AzaqwRuBE3APLsiBQAGhUuFVJR2PFUaiG+5
 RpRerCzjOhSKAodxa7B3qp2JO6qTNKd4yz2D5WE=
X-Google-Smtp-Source: APXvYqw/RRoaPKsSxB8nuXKGBm6Gt3hs3WhTN5hWg0lXBnUFAD/wgLlXfkEjQ+EzKqXLvpm8114+NJcxTJtfMOsICQs=
X-Received: by 2002:aca:d485:: with SMTP id l127mr2933827oig.162.1568379400666; 
 Fri, 13 Sep 2019 05:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
In-Reply-To: <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
From: Matthew Wilcox <willy6545@gmail.com>
Date: Fri, 13 Sep 2019 08:56:30 -0400
Message-ID: <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To: Bart Van Assche <bvanassche@acm.org>
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, Joe Perches <joe@perches.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

It's easy enough to move the kernel-doc warnings out from under W=1. I only
out them there to avoid overwhelming us with new warnings. If they're
mostly fixed now, let's make checking them the default.

On Thu., Sep. 12, 2019, 16:01 Bart Van Assche, <bvanassche@acm.org> wrote:

> On 9/12/19 8:34 AM, Joe Perches wrote:
> > On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:
> >> On 9/11/19 5:40 PM, Martin K. Petersen wrote:
> >>> * The patch must compile without warnings (make C=1
> CF="-D__CHECK_ENDIAN__")
> >>>   and does not incur any zeroday test robot complaints.
> >>
> >> How about adding W=1 to that make command?
> >
> > That's rather too compiler version dependent and new
> > warnings frequently get introduced by new compiler versions.
>
> I've never observed this myself. If a new compiler warning is added to
> gcc and if it produces warnings that are not useful for kernel code
> usually Linus or someone else is quick to suppress that warning.
>
> Another argument in favor of W=1 is that the formatting of kernel-doc
> headers is checked only if W=1 is passed to make.
>
> Bart.
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
