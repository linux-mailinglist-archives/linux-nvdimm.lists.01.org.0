Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB32CB2CC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Dec 2020 03:28:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1002C100EBBBA;
	Tue,  1 Dec 2020 18:28:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84EFF100EBBB9
	for <linux-nvdimm@lists.01.org>; Tue,  1 Dec 2020 18:28:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm17so717809edb.4
        for <linux-nvdimm@lists.01.org>; Tue, 01 Dec 2020 18:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM9A+3KaaiPpvWPDXTsVYgKekaxWNn0Vy+5ecqlGLPk=;
        b=UcWU6mPHePQD7oxZyJ3QI8EBVRLqdLckOHec4/9GUNtNJH3fJzfnc9+ztdoEZjCkFw
         pYdz6h215kR81M6/JrHPGGE5mAfzQQMgD1i9mIi8EJGhb/u1CYqH6160qHQ3b5goL1aM
         vGHkaj29vjmNYeeFbHudC+HBE9Y4xixArtOHYpdFMqBwTEWbj33jt/2nmtRqLgDNYV2j
         nk9h/P1PBU8VbP7vQVb/h77TvTier9YybxSyjIZYgDPtcCIRqAEwiwv0JSdcyRBwvwtp
         Jw6Pf7YqjvpAz7aDt6cfCQtF6Qt89Z0FDXZ9FlhlIdwAc8bOCefJLS/+H9ccZuhUBswZ
         pWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM9A+3KaaiPpvWPDXTsVYgKekaxWNn0Vy+5ecqlGLPk=;
        b=eCZd/jc8Pi0dguV7kyOJ2zU562u37aU9LTwhndoo0JgDjZbGW7sSF78eEdfPxCaIe2
         SiBnMTN34tJy9Smv+52OgJMjQy4r+jjd05oN1mTKep1k3qC/VoHDvthU6N5bIChlm9Zu
         nqiENndev5EFk8c+pnR7yAs5AYnLtA8gs39E8TPStHTontY2tHmKU8hGMuDhq8Pix6Sz
         Fo/9E2HUpRYuA8G7aFI+zSupQwGmHVDbo/sr+kvKhDJr5c96ua/ymEjMM7gvuSBDyQ5H
         LEjDf9SxnuriUqFZ7mDrv6DKHFyN59k/Q8s64758SEXI2UdSDHty5G+X8hrFdUocgK/a
         LOlA==
X-Gm-Message-State: AOAM531QO8WBHSNXslEyviQoOv78DLFESXgGnFhtRJFgjilbEib//v01
	DMz8JvGg24WkT2E0J3Ya5nFzMEdGSRH/ZqWktjGjgQ==
X-Google-Smtp-Source: ABdhPJxxdgVGhyjxYPVa1iHrBXTrpKmswqz6i0GnJFbV69X4wbpncFo9Iyek+7pIGpd5QudB/5mxTjUf/+DRUG+1QUI=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr584892edl.210.1606876129090;
 Tue, 01 Dec 2020 18:28:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
 <20201201022412.GG4327@casper.infradead.org> <CAPcyv4j7wtjOSg8vL5q0PPjWdaknY-PC7m9x-Q1R_YL5dhE+bQ@mail.gmail.com>
 <20201201204900.GC11935@casper.infradead.org>
In-Reply-To: <20201201204900.GC11935@casper.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 1 Dec 2020 18:28:45 -0800
Message-ID: <CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com>
Subject: Re: mapcount corruption regression
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: BRZI7SBOJN2GZXQDZB5YODHQUZQ57DEE
X-Message-ID-Hash: BRZI7SBOJN2GZXQDZB5YODHQUZQ57DEE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vlastimil Babka <vbabka@suse.cz>, Yi Zhang <yi.zhang@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BRZI7SBOJN2GZXQDZB5YODHQUZQ57DEE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 1, 2020 at 12:49 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 01, 2020 at 12:42:39PM -0800, Dan Williams wrote:
> > On Mon, Nov 30, 2020 at 6:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> > > > Kirill, Willy, compound page experts,
> > > >
> > > > I am seeking some debug ideas about the following splat:
> > > >
> > > > BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> > > > page:0000000051ef73f7 refcount:0 mapcount:-1024
> > > > mapping:0000000000000000 index:0x0 pfn:0x121a12
> > >
> > > Mapcount of -1024 is the signature of:
> > >
> > > #define PG_guard        0x00000400
> >
> > Oh, thanks for that. I overlooked how mapcount is overloaded. Although
> > in v5.10-rc4 that value is:
> >
> > #define PG_table        0x00000400
>
> Ah, I was looking at -next, where Roman renumbered it.
>
> I know UML had a problem where it was not clearing PG_table, but you
> seem to be running on bare metal.  SuperH did too, but again, you're
> not using SuperH.
>
> > >
> > > (the bits are inverted, so this turns into 0xfffffbff which is reported
> > > as -1024)
> > >
> > > I assume you have debug_pagealloc enabled?
> >
> > Added it, but no extra spew. I'll dig a bit more on how PG_table is
> > not being cleared in this case.
>
> I only asked about debug_pagealloc because that sets PG_guard.  Since
> the problem is actually PG_table, it's not relevant.

As a shot in the dark I reverted:

    b2b29d6d0119 mm: account PMD tables like PTE tables

...and the test passed.

Yi, do you see the same?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
