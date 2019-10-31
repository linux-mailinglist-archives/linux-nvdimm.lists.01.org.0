Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E05EB6A3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 19:10:36 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D489100DC40A;
	Thu, 31 Oct 2019 11:11:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35F08100DC409
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:10:58 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so6017425oib.3
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVdtcBRZCD2vENykWCS+6pWx1ip+EghwbnD+9MtcvjQ=;
        b=FvVmb/fSHKImaafJ9elIRSzRmrMYZhJcyUbXEJufmuVrq9cnQKBddyy7CD/zaP3HKv
         rQumhPkiOp3RAsBwrfbYKlhKjFPOh0RpBbkAnEhWArmuiyVcUamJam6n8BIZlt0ADdK0
         tiY+UfkG9DYINaxpuhGnApOWpirr9w+pBp45uUVyNvIsNg/54imgslL6wj8XuLHtN7/i
         KL6bu+5+3Z4Ilj2dtHZ9Vh9ppJLaZHPiqcTyeHXfCMFG2BwWMkZ0ve7k+wGu2XNdvtOR
         4PL0e6pESwEyv458yuY/nRSh6Q4hsxjZG5XzeBnnwYGP0w/EEu3+CSj4NQPxwSBX069u
         I4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVdtcBRZCD2vENykWCS+6pWx1ip+EghwbnD+9MtcvjQ=;
        b=TW3OXZaFFLIyY72URGAZNsDulyHtFglUBH+K54w+MpyGNpaR5UfhPPIucCGzeJJj0Y
         xtY9e92465E2ShrySOrMiFjvTJNs3Epu218u7nflJp86uVBxHUrxUBiHd3TFL5UJNSNh
         V2x25tCfETq9OoCPzQ6MuR7Mlvy824NQq9+VqhIgnNhFeldAAJ9ZqdPE96hPV+RmqMe5
         xo2rAU3JglhM2L9flJ+Il9zcOkmYUw6nsZOpAtDkujCczKDvQcANzsU/YggppPje6cY1
         eGHnxEv1bpfk+U6RX2DUoANpjHAISND0jmpLKjFaXwJYZy/gJ/IDO0q+06nUa8xv/CPn
         J+dw==
X-Gm-Message-State: APjAAAU3cOiaLkCG3ZMNmsarBk+8W04O5CLcAGhe0hHcHwL6MgNJdo3O
	Gp6OTDc/iH3ZHqalj6KzlqSS3yKHyrN5g+H0Rxfzpg==
X-Google-Smtp-Source: APXvYqyrxR+CetGwVTtHCGbPoaHFfTxy1l5R0oZtyNANw9n+amQaf0An8efFhqdBpQPlshcTcx8d8RcTUv6xjlzqHGo=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr703151oie.149.1572545430720;
 Thu, 31 Oct 2019 11:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190807043915.30239-1-aneesh.kumar@linux.ibm.com>
 <73abe6519435d3c0cfab32633c969b5efe16c0e4.camel@intel.com>
 <269a4c1c-f1c5-6b18-3482-a9640d0a816b@linux.ibm.com> <211de3f5c7eafcdd64301954db2382888b7e9982.camel@intel.com>
In-Reply-To: <211de3f5c7eafcdd64301954db2382888b7e9982.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 31 Oct 2019 11:10:19 -0700
Message-ID: <CAPcyv4g01PKnRHn8uv_GKVGg=-ww89tkoEXqE0W0x5PdiCteGw@mail.gmail.com>
Subject: Re: [PATCH] Consider namespace with size as active namespace
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: 57X6NX6HOASUNAXUKEIWUKYX742RQ22C
X-Message-ID-Hash: 57X6NX6HOASUNAXUKEIWUKYX742RQ22C
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/57X6NX6HOASUNAXUKEIWUKYX742RQ22C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 30, 2019 at 4:39 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2019-10-17 at 08:35 +0530, Aneesh Kumar K.V wrote:
> >
> > > > ---
> > > >   ndctl/namespace.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> > > > index 58a9e3c53474..1f212a2b3a9b 100644
> > > > --- a/ndctl/namespace.c
> > > > +++ b/ndctl/namespace.c
> > > > @@ -455,7 +455,8 @@ static int is_namespace_active(struct ndctl_namespace *ndns)
> > > >           return ndns && (ndctl_namespace_is_enabled(ndns)
> > > >                   || ndctl_namespace_get_pfn(ndns)
> > > >                   || ndctl_namespace_get_dax(ndns)
> > > > -         || ndctl_namespace_get_btt(ndns));
> > > > +         || ndctl_namespace_get_btt(ndns)
> > > > +         || ndctl_namespace_get_size(ndns));
> > > >   }
> > > >
> > > >   /*
> [..]
> >
> > > The failing unit tests are sector-mode.sh and dax.sh
> > >
> >
> > I will see if i can run them on ppc64. We still had issues in getting
> > ndctl check to be running on ppc64.
> >
>
> I dug into this a bit more.
>
> The failure happens on 'legacy' namespaces (ND_DEVICE_NAMESPACE_IO).
>
> There is an assumption that legacy namespaces cannot be fully deleted,
> so as part of a reconfigure, when it comes time to delete the namespace
> (ndctl_namespace_delete()), we refuse to do that, and bail, before
> setting the size to zero.
>
> libndctl.c:4467
>
>         case ND_DEVICE_NAMESPACE_BLK:
>                 break;
>         default:
>                 dbg(ctx, "%s: nstype: %d not deletable\n",
>                                 ndctl_namespace_get_devname(ndns),
>                                 ndctl_namespace_get_type(ndns));
>                 return 0;
>         }
>
>         rc = namespace_set_size(ndns, 0);
> ...
>
> Indeed, destroy namespace wouldn't even get to that point, because that
> assumption is repeated in namespace_destroy(), where we switch on
> namespace type, and potentially skip over the ndctl_namespace_destroy
> call entirely.
>
> If setting the size to zero is now significant we'd need to rework both
> of these sites. In destroy_namespace(), delay the did_zero checking
> until after ndctl_namespace_delete(), and in ndctl_namespace_delete(),
> set the size to zero before the type check.
>
> Dan, does the above make sense - was there reason to refrain from
> touching the size on legacy namespaces?

It's because the size is read-only on legacy namespaces, so writes
will always fail so the assumption is that ndctl_namespace_delete() is
a nop. Hmm, but that makes me think that size == read-only might be a
good gate for this idle check, i.e.:

if (size_is_writable(ndns) && size(ndns) != 0)
    return not_idle;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
