Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC750A2899
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 23:05:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A27D62021DD5A;
	Thu, 29 Aug 2019 14:06:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2544120216B78
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 14:06:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id r20so4850715ota.5
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zz/IcpIogQHwbVO/Egjox/eu8Ruvdetizg0QLnWTWdk=;
 b=UDZgtwo0oFSbwbrZ20aRDIUOHVsOZ4QNSGS9i2xZYwSshsp9/Rx+od4w9K5/fI1EzL
 eEvX6n3R9d2FJVEF/ormhBdNO3FTcnJ99qUXUA0bDjdR3Gp9nMHV2syoniOtQtaYaS5Z
 MNrBmcnP1DaiX6cIsQXCAqc9cHw+47E4+lynszEsdDZgQMhRT18vNUKfnoOLNfWCJ3H6
 otegJ/kpPCyGYA7EFiNveGSds+xkWRS2fdfac0KqCIZy2zD4yjAD0x7bgEPgjT9b3bz4
 foAf/nd5dDoGc/34WbE2eWjhELAHjT4DjLyy0jbCfYxqLwBu7REDoKgzCC+NTu7a/XbV
 dc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zz/IcpIogQHwbVO/Egjox/eu8Ruvdetizg0QLnWTWdk=;
 b=fWaWwvI/nIhDyLHXw0kzBpF2Z47nBl+2dN7ABQhPw9sjHL5knMk3RkoStd0N6rzwvJ
 XJxJDduDbnGuXDPKbqJEvCOSqUkZVYMR685Tycoh5DMaN3VERgu+OrVU/avaiVrgHFpM
 fsIX3TUgSWL6MBaDLGJ4dvacy0KdkPO6hoKyRekiherta10MOI8SE8HdLR5pN0MRhTxc
 p1sao4Tn6sykop18eUa1uMYpsxd2KTKSpFZfA1M5gzftvD3PL/uhByg+gp5K/NPZsMA1
 xNqB3SV+WeVmGiyHA3HeH/vQx1GauVUWCSPGF1Qt8d4OYTC42caTDB6TFgcggqQ8JCqS
 uIiw==
X-Gm-Message-State: APjAAAUESVmj2ys1mHOZR6PX1SlgmsqL9scPdrWuiUBSPNC2M42FSv2u
 RQOHPmVpxvlvMfoP9wNV1R1zs+DrzMKqdpmh7fIrGg==
X-Google-Smtp-Source: APXvYqyn5q3lBZI9Iea0wDtzH+/TmKJyq6/LhQkuOWmqohDbqlvPKPAPMzwMoHf1pVkA9pIvBmHIiTMv/SrZiOA0wyg=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr9855859otq.363.1567112701542; 
 Thu, 29 Aug 2019 14:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190610210613.GA21989@embeddedor>
 <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
 <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com>
 <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
In-Reply-To: <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Aug 2019 14:04:49 -0700
Message-ID: <CAPcyv4jEgk3Nsax0_KxDEsOPY91_py5NTyh2F58zVcoxaO0_Tw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 1:24 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-08-28 at 14:36 -0500, Gustavo A. R. Silva wrote:
>
> > struct_size() does not apply to those scenarios. See below...
> >
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n1030
> >
> > struct_size() only applies to structures of the following kind:
> >
> > struct foo {
> >    int stuff;
> >    struct boo entry[];
> > };
> >
> > and this scenario includes two different structures:
> >
> > struct nd_region {
> >       ...
> >         struct nd_mapping mapping[0];
> > };
> >
> > struct nd_blk_region {
> >       ...
> >         struct nd_region nd_region;
> > };
>
> Yep - I neglected to actually look at the structures involved - you're
> right, it doesn't apply here.
>
> >
> > > [2]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n96
> > >
> >
> > In this scenario struct_size() does not apply directly because of the
> > following
> > logic before the call to devm_kzalloc():
>
> Agreed, I missed that the calculation was more involved here.
>
> Thanks for the clarifications, you can add:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks, applied.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
