Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A12164F94
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 21:09:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF5BF10FC359F;
	Wed, 19 Feb 2020 12:10:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C99910113319
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 12:10:05 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p125so25076631oif.10
        for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHgYohbUawJ7bXpshNvsW1UeS3oW6CfB3PEQcMl4HkQ=;
        b=gfD9Q2Y6eK3kRQKzTR66ahl4HmPfXs1QH7siGm96Xcjc44TD6VF+c1nozCaezTZCV1
         S+LA0bvU7ZbR3zGpMJDvrVb9Xadfg1VYjiKkLGi+1TAq7B0tm9Y6g1l1Akxa8kVhPDW9
         KgIwUFxPdRADUnnkhS9EcNptzB9S+5toa/tn6F2JDBC3mYjY4vRfrAQqtTbSQZEffybC
         4pCl9j6GngA9vHsTUSRQRw2v9y4z3F+DcTwzVk7+khLwRot1nnb5QwodBDLAAf5/g3h/
         2Hkz93sjnTbCIB2NAnFdozfLMV1eFNtc5Y5r5Qcc6rtW4herTsBpasDRCFij6GM96HHE
         Dgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHgYohbUawJ7bXpshNvsW1UeS3oW6CfB3PEQcMl4HkQ=;
        b=SP0o03GUGRBLhKHUs0Dd4UjdA49VZnt+mneq3fnw7PCewN6AKZoraBe0OZ9qJ8hZJI
         0ouMDLHccRRmMY8Dji/kFGlUamX42VY/SqXWJw4kaxtgV+98bKCeEAXnI4iUcn2fymSe
         fqCQr99WP1SXFBkQrSJP2P8oPO+bGJxl3SD+aeFG4YB0Ny39IG2YMlL2J1afUevABgjr
         snVQAZX4IXNTRP4gvH7q2UZ9PuZbYwldI2RQ2ascZzVce9p+pT1xnxdk3J8db7N2SzM1
         zBk2Ce9wOfwtOZHhbeJzwHbtXH8Bk4vrK58P4HWg5f217WEh1LSNvAaMCIURxfW6Az29
         Je2g==
X-Gm-Message-State: APjAAAX0uE8tpqMjQ5y+P8rVFJB9FAyy4k3DiOe4uvtL6Djd/0dct1F9
	z4ckp+TNKexwL6YSaC9HMIPC+eQCZB/ghKIIikP+Dw==
X-Google-Smtp-Source: APXvYqy+PGhiEmQuSBWfgVDG7zF2MvuhVR2vYanrNyYrUEYmwJnAeX3sx8blQHyqY4EvIDYtKXro1Mwn7ooZvOrHJwo=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr5995154oie.149.1582142952034;
 Wed, 19 Feb 2020 12:09:12 -0800 (PST)
MIME-Version: 1.0
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgj6law0.fsf@segfault.boston.devel.redhat.com> <CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
 <x49k14ila4r.fsf@segfault.boston.devel.redhat.com> <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
 <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
In-Reply-To: <03b5da834f0be8bc7110c459f3172732b96e85fa.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Feb 2020 12:09:01 -0800
Message-ID: <CAPcyv4gVDEum7RiSMXug5fwNC04mEHo5MhAuUW37t4tN9y899A@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Message-ID-Hash: RERICYHVRSZ3FE5W4PWSQZYZCFWCBRF4
X-Message-ID-Hash: RERICYHVRSZ3FE5W4PWSQZYZCFWCBRF4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RERICYHVRSZ3FE5W4PWSQZYZCFWCBRF4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2020 at 12:01 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2020-02-19 at 10:53 -0800, Dan Williams wrote:
> >
> > > > > Will this break existing code that parses the javascript output?
> > > >
> > > > Always a potential for that. That said, I'd rather attempt to make it
> > > > symmetric and replace it if someone screams, rather than let this
> > > > quirk persist because it makes it impossible to ingest region data
> > > > with the same script across -R and -Rv.
> > >
> > > Yeah, I see where you're coming from.  However, script authors will
> > > still have to deal with older versions of ndctl in the wild (for many
> > > years).  If the decision was up to me, I'd live with the wart in favor
> > > of not breaking scripts when ndctl gets updated.  Users hate that.
> >
> > Let's do a compromise, because users also hate nonsensical legacy that
> > they can't avoid. How about an environment variable,
> > "NDCTL_LIST_LINT", that users can set to opt into the latest /
> > cleanest output format with the understanding that the clean up may
> > regress scripts that were dependent on the old bugs.
> >
> Hm, this sounds good in concept, but how about waiting for this cleanup
> to go in after the (yes, long pending) config rework. Then this can just
> be a global config setting, and we won't have config things coming from
> the environment as well (which this would be a first of).

That does make some sense, but I notice that git deals with "cosmetic"
environment variables (GIT_EDITOR, GIT_PAGER, etc) in addition to its
config file. So if we're borrowing from git, I'd also borrow that
config vs environment logic.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
