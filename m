Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B05AF94F4E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Aug 2019 22:48:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E75320214B59;
	Mon, 19 Aug 2019 13:49:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3D85220213F06
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 13:49:22 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so2384941oiw.11
 for <linux-nvdimm@lists.01.org>; Mon, 19 Aug 2019 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sB+/yyvxHmnkdFDCUbYW0gEnOIERyulKZUPjBGLVWPc=;
 b=dM/DNWCh1D0mlnCkKjZFhohyqLsGPI+c86mguiWp9z6o3naVWOZTLPFtPceclfVE6v
 lGRrgwOeTLPI4VFxdFSY3VXJogXS855wCJ92LJr8pXxSpAOCllZEH6vuRlwn4430BtCK
 MYs16h0AI3sng+Yn3v62P/wcPiHIqoXLz6h6p1Vk3t/+gG1L3GouYX5yIpgnBihiM9z9
 tnGBmt656XiU9Wtj+BMHBYed2oi3soSjKxkDskHVccCLGfRB0vmX0hKHESAjvdqEt9vN
 VSzVh5UiRO+PukwFz2E2WS4UsedjbBm6spRod1TNtA53Vbqv4N3FPznMAlCLeNNyV8zQ
 N2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sB+/yyvxHmnkdFDCUbYW0gEnOIERyulKZUPjBGLVWPc=;
 b=c/avWJOoyiOPbcXgJRWQUR3NQ4Tzh5HXVeowscnYUNpaR2b82lR0IyBlkc69IL3VQZ
 CFi2u0mqQRHj1vJFKQU3cSCmhLkMt8pu7HEogyTveE+qiFIEJbGvK8e2ld3uLhBzjiYq
 NdewOUiYfzuHvTbMj1C9MX3ikPe6eDg0DyHWeoCopQGId+Fr89F9PuvBfVHTRzAok/w0
 XAHYK0s+hGsT59cxEqgCfkOrvf6kqBBk7v5A2Dx1ctopyz0mg13Ub1bB8vzhbcOE2Cbr
 EqHN4G6JDRBU/KHAW+TvU/O8UDKH6zRvsFxP7ANrfZhGqSrCAa0VRqs3qCJoAoB9fi14
 DK7A==
X-Gm-Message-State: APjAAAUTc/hKCGHK+knHtb2aHh3sVw6/byZ9LOaKQzRPD7AHi5Krx1nm
 +JePhEGg2lVNl97RN7ADp3Uy4ZR3BVsdCDlpuo7JMg==
X-Google-Smtp-Source: APXvYqw9gFLvTehp4WYIU5GUyP+1wYqo/12Fd6IeeTSqxobJIrHVEYk8hiDB0fRdBlHzsESyyd/fVOAut/TfU7oaeec=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr13899247oif.70.1566247678004; 
 Mon, 19 Aug 2019 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <156583219134.2816070.2537582454969393648.stgit@dwillia2-desk3.amr.corp.intel.com>
 <84f53b69683feec6d0cca8003522a51d22a53fbd.camel@intel.com>
In-Reply-To: <84f53b69683feec6d0cca8003522a51d22a53fbd.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Aug 2019 13:47:47 -0700
Message-ID: <CAPcyv4huax8ou+qbN3hJ-mXkLFsqFuUSj2_NFmjn08U_jpvf9w@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl/dimm: Add support for separate
 security-frozen attribute
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 19, 2019 at 1:26 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-08-14 at 18:23 -0700, Dan Williams wrote:
> > Given the discovery that the original libnvdimm-security implementation
> > is unable to communicate both the 'freeze' status and the 'lock' status
> > simultaneously, newer kernels deploy a new 'frozen' attribute for this
> > purpose.
> >
> > Add a new api and update the tests for this new capability. The old test
> > will fail on newer kernels, but hopefully there were no other
> > applications depending on the 'security' attribute to communicate the
> > 'freeze' status. It was likely only ever a debug / enumeration aid, not
> > an application dependency.
> >
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ndctl/ndctl-freeze-security.txt |    8 +++++---
> >  ndctl/dimm.c                                  |    2 +-
> >  ndctl/lib/dimm.c                              |   25 +++++++++++++++++++++++++
> >  ndctl/lib/libndctl.sym                        |    4 ++++
> >  ndctl/libndctl.h                              |    1 +
> >  test/security.sh                              |   18 ++++++++++++------
> >  util/json.c                                   |    6 ++++++
> >  7 files changed, 54 insertions(+), 10 deletions(-)
> >
> [..]
>
> > @@ -262,6 +267,7 @@ test_4_security_unlock
> >  # not impact any key management testing via libkeyctl.
> >  echo "Test 5, freeze security"
> >  test_5_security_freeze
> > +exit 1
>
> Is this a leftover from local development/testing?

Yes, whoops. Just trying to keep you on your toes.

> Otherwise the patch looks good to me.

Thanks! Will resend.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
