Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD676825E6
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 22:12:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A555F2131D56C;
	Mon,  5 Aug 2019 13:14:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D63142131D566
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 13:14:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z23so58557821ote.13
 for <linux-nvdimm@lists.01.org>; Mon, 05 Aug 2019 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w1iVLzk9vdxhakLt5F7vFH14/nHwewgaD6R8shprF8Y=;
 b=lUU7ngMfKIxRpqeMXeZclDK9g9/hMD5XSGU26fhPwOSAnWHP28jDnAB7VLeEhmLc0W
 EJcOWgGW8KmRbY4WbwlL7Z7fgueFFYyptqeSlONYAvUVK1pzz20Bk6L2vIW7tuSEPbuG
 DeM8MYGXvNF7fTD/DS5fX20aunJlpW+/ULWiQt6wjmx/FJ1pk5vSqm7qnoOcaD6zlEB5
 8GYsZzn75CdOM0Lid4lZIDcAEuBn+7yyz/flFiin3rISCkpnr/snk1FwWQhcoLP2WtNi
 3UIrpUAwQZ6RUqhcJtZEYD9Wi4bPabnLXTFtvFQUYHbVjlhTLNi5O3kLpyuWS0JX+2LZ
 JCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w1iVLzk9vdxhakLt5F7vFH14/nHwewgaD6R8shprF8Y=;
 b=CLbmTHJdmYrgb1J61xtsKgtyglbD8uiugoRpiiVJgx5ctGHjJiTpK7rWuFGcKvkipl
 F+oCSgh9JFHjB6nXlID+k/vPHyWbn4tL8EZMudXSKj2B1jD7etZ/oOLVOj7Zj3aJklYj
 lmoz5w0836ByXpXWnpk+mMEpY8d7qRIux7WslyOWipEfn8Qlv5Tq/FF+l9bAex8abUL5
 IaJ17z2JLXgpzl10aN1v8XPqLQqFSPB+ig9EP4kml3INpM4RTbzl0Vkdhaq8k43mfN4x
 0KZHaKaqb7a6WN82ARZrY4iby8APfuAzAe4tCjgQRL43zRNiI8KdEzOMDQmkDJPnSjzL
 aB8w==
X-Gm-Message-State: APjAAAWLgYxU8cFKrKcP8eGbPQKk84Kn8quZdURhc//QJfORzFgMn/i6
 7Ce4sL0iN/HN/ZUycJaTSn/FJm7u6DP9tztTqya4/aES
X-Google-Smtp-Source: APXvYqyOsIEn7+bvZhgUKfEZADHCCFBqCBS8MHT3WovRCjfXjpjbZcIjOSxo9BQ0deAQj/wMkT9mBjFOQez1p5Z+GEA=
X-Received: by 2002:a9d:7248:: with SMTP id a8mr52478967otk.363.1565035919639; 
 Mon, 05 Aug 2019 13:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190802192956.GA3032@redhat.com>
 <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
 <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
 <20190805184951.GC13994@redhat.com>
 <9c0ec951-01e7-7ae0-2d69-1b26f3450d65@plexistor.com>
In-Reply-To: <9c0ec951-01e7-7ae0-2d69-1b26f3450d65@plexistor.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Aug 2019 13:11:48 -0700
Message-ID: <CAPcyv4jgxTNbGBy9cQjS_mEzeuaXa6PQSQ+C5xBgy0mpxUmNzg@mail.gmail.com>
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
To: Boaz Harrosh <boaz@plexistor.com>
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
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, virtio-fs@redhat.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 5, 2019 at 12:17 PM Boaz Harrosh <boaz@plexistor.com> wrote:
>
> On 05/08/2019 21:49, Vivek Goyal wrote:
> > On Mon, Aug 05, 2019 at 02:53:06PM +0300, Boaz Harrosh wrote:
> <>
> >> So as I understand the man page:
> >> fallocate(FL_PUNCH_HOLE); means user is asking to get rid also of COW pages.
> >> On the other way fallocate(FL_ZERO_RANGE) only the pmem portion is zeroed and COW (private pages) stays
> >
> > I tested fallocate(FL_PUNCH_HOLE) on xfs (non-dax) and it does not seem to
> > get rid of COW pages and my test case still can read the data it wrote
> > in private pages.
> >
>
> It seems you are right and I am wrong. This is what the Kernel code has to say about it:
>
>         /*
>          * Unlike in truncate_pagecache, unmap_mapping_range is called only
>          * once (before truncating pagecache), and without "even_cows" flag:
>          * hole-punching should not remove private COWed pages from the hole.
>          */
>
> For me this is confusing but that is what it is. So remove private COWed pages
> is only done when we do an setattr(ATTR_SIZE).
>
> >>
> >> Just saying I have not followed the above code path
> >> (We should have an xfstest for this?)
> >
> > I don't know either. It indeed is interesting to figure out what's the
> > expected behavior with fallocate() and truncate() for COW pages and cover
> > that using xfstest (if not already done).
> >
>
> I could not find any test for the COW positive FL_PUNCH_HOLE (I have that bug)
> could be nice to make one, and let FSs like mine fail.
> Any way very nice catch.
>

Yes, and this bug is worse because it affects COW pages that are not
the direct target of the truncate / hole punch. This unmap in
dax_layout_busy_page() is only there to allow the fs to synchronize
against get_user_pages_fast() which might otherwise race to grab a
page reference and prevent the fs from making forward progress. The
unmap_mapping_range() that addresses COW pages in the truncated range
occurs later after the filesystem has regained control of the extent
layout (i.e. break layouts has succeeded).
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
