Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C804A0C6B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 23:32:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BE212021B6F9;
	Wed, 28 Aug 2019 14:34:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8EEE12020F956
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 14:34:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k18so1343279otr.3
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PGK53GE3La7GqhCtWCnEW/XK7atEYtoMDBe1Jr3m4VI=;
 b=sKslKkPIJyVJYNmw4dENw+kJVu5JrP1SyduVmpzdatYEO1l/VxsOjtmqkWsZY525uS
 FsClyRxXolhhfH+q6mgl8KgW1VO18X7B9SpEnn1VvxXD3YSb5ovqOzOf4D6rTudwOHf8
 p8hKfSKyUdFszXpr3jpHXrRm8GGKxXsEgG+YoEFSH2vlkyeMbsKenMDbULNT06qk3AQH
 trQ/B3PTk/sBidQIfIAq6vMKK+miv7sLuLIpT/YrbbGaXd9e2mukSB19yVyfUd2VNzZz
 30uDpIeNvPAkjc2KCz4xOdbQqCKMDCrJ4USfHF7eTx25/BWS5B7Iv2nJZ4KZaeSwqHUD
 R6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PGK53GE3La7GqhCtWCnEW/XK7atEYtoMDBe1Jr3m4VI=;
 b=W3xo9EUyEO9K3LmLiQj/H0dO70gEediV8VtKW+PEfyRyl0MW/depWIL4cWRQ2H7x8v
 3ZNDzulpK4qKT0sTnZxFEAzihGS5Dzb3sogmCanEtxkUFi+JjvQjY4NtdORafB83CGWS
 +725qmohbx9LoPa4dOjkrj6WdeAUvOlF5CNw+42twrreu/OQ12AUyFzfboyOzg8qcC4O
 buSNl+AtU5PSfPXnmJNVMBH7Y6Qgx4i8otjEDwtsRqtKXqwN+OPxYMGZ90ndPQlFO8pd
 KxJBcvuOd7jPQcIFbPsyPZUka7sX4L53rSQAhOdzDfHzakxtXpkjf21k/PecSxuZFlDY
 aO7A==
X-Gm-Message-State: APjAAAVUg7xD8iFe3a2dIcb7XTUbvKsdn6HV3CqAXF09IP5wVPzIX+dA
 rSOlclWGlJBfjRlPnbtNkzuiFXf5FO+Wgn2+9aoy2XYt
X-Google-Smtp-Source: APXvYqws0TL8tHkPJFZvq6lQwqNMWOkL6kM9PKfOSDRYr90+tu2iHIKmgsK/IjBC7FXjaWcu3ow3s5th7e10je6PIB8=
X-Received: by 2002:a9d:77cc:: with SMTP id w12mr4984880otl.207.1567027943570; 
 Wed, 28 Aug 2019 14:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190828200204.21750-1-vishal.l.verma@intel.com>
 <x49y2zd6obc.fsf@segfault.boston.devel.redhat.com>
 <507921D13093A64EAF066075F3F6ED13076E485E@ORSMSX111.amr.corp.intel.com>
 <1ac1bafeaf3253fb9396c22db334b51deb653f0a.camel@intel.com>
 <ce15fdbdee2135a1b1d698f46d3cc7c9856bb381.camel@intel.com>
In-Reply-To: <ce15fdbdee2135a1b1d698f46d3cc7c9856bb381.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 28 Aug 2019 14:32:12 -0700
Message-ID: <CAPcyv4gnfRv3uKAFj7gctLpZHphCc_3gPc7MzjbYmndK0aZE_w@mail.gmail.com>
Subject: Re: [ndctl RFC PATCH] ndctl/namespace: create namespaces greedily
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
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 2:22 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-08-28 at 21:16 +0000, Verma, Vishal L wrote:
> > On Wed, 2019-08-28 at 13:47 -0700, Scargall, Steve wrote:
> > > Hi Jeff,
> > >
> > > The issue is more of repetition.   On an 8-socket system,  should a
> > > user really be expected to type 'ndctl create-namespace' eight times
> > > vs. running 'ndctl create-namespace --region=all' once?   SAP HANA is
> > > an example app the requires one namespace per region.  Scripting is a
> > > viable solution, but that requires somebody to write the script and do
> > > all the error checking & handling.  Each OEM/ISV/SysAdmin would have
> > > their own script.  Pushing the logic to ndctl seems to be a reasonable
> > > approach and let the user handle any errors returned by ndctl.
> >
> > A scripted solution can indeed be really simple - e.g.:
> >
> > # while read -r region; do  ndctl create-namespace --region="$region";
> > done < <(ndctl list --bus=nfit_test.0 -R  | jq -r '.[].dev')
> >
> > {
> >   "dev":"namespace5.0",
> >   "mode":"fsdax",
> >   "map":"dev",
> >   "size":"62.00 MiB (65.01 MB)",
> >   "uuid":"c8014457-c268-4f22-8eae-6386fbf08ceb",
> >   "sector_size":512,
> >   "align":2097152,
> >   "blockdev":"pmem5"
> > }
> > {
> >   "dev":"namespace4.0",
> >   "mode":"fsdax",
> >   "map":"dev",
> >   "size":"30.00 MiB (31.46 MB)",
> >   "uuid":"f9498ef6-cdd6-46c7-95f1-86469546ecb9",
> >   "sector_size":512,
> >   "align":2097152,
> >   "blockdev":"pmem4"
> > }
> >
> > > The ndctl-man-page implies the 'ndctl create-namespace --region=all'
> > > feature exists today:
> > >
> > >        -r, --region=
> > >
> > >            A regionX device name, or a region id number. The keyword
> > > all can be specified to carry out the operation on every region in the
> > > system, optionally filtered by bus id (see --bus=  option).
> > >
> >
> > This is true, but unfortunately, the implementation has treated create-
> > namespace as an exception to this since the start, and I agree with Jeff
> > that changing its behavior now can cause other Hyrum's law-esqe [1]
> > breakage.
> >
> > I think however it should be easy to make a compromise, and retain the
> > legacy behavior of create-namespace, while creating a new create-
> > namespace-greedy command with the new semantics.
> >
> .. And it doesn't even need to be a new command, a simple --greedy
> option to create-namespace should be sufficient.

Perhaps "--continue" to proceed with creating namespace after the
first successful invocation. I agree with Jeff that changing the
default semantics would be surprising. The man page can also be fixed
up to make it clear that it's the "singleton region capacity search",
not "all possible namespaces" that "-r all" implies.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
