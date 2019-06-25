Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF393553E8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 18:03:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 183882129F046;
	Tue, 25 Jun 2019 09:03:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CD32F21295CA4
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 09:02:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t76so12956146oih.4
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rkiN5Ln+LPD0we4Kre4BOb+XjSLjDB1oXBvT5k6ZR+o=;
 b=tok9Ai+imw0ti/EcFot/UsIPStgqvfECCWrXyRjK/gRgacHLbWM7vCjubSkcj1Hpsj
 q+6uM5UosQJb4cV2Z0kOIVkvNlDiA4GuY+UOfIh+NIvou+4acoWvbM3mVlLOW+gBkEx5
 iZNWXcdrnv6kV2msgQkytXjMaUqWaoegxpAmM+2bBDZMnFi9D5H+LL+AVzVm3yhbJGEB
 +i+K29BA6nW5BhZgVYTThD5y+9csIQJ41ugBlnXeWxNE8Qb0OGiG+66mWYT2yCZQAgLA
 cSTx5fvaG5orxkvAzOaPtdrMPabY8gnQPqJbEwaTebYx2/hhPt+XMtWgxWi1dN4oE/lX
 LrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rkiN5Ln+LPD0we4Kre4BOb+XjSLjDB1oXBvT5k6ZR+o=;
 b=M6r6QlXFt+BR9OhAOfP5gndGyIR1xTOGg5IIXsdclebc7b+YhaLBvX2W/BH//Udxkn
 ZPtU0tHBDIyNIYQ8paJA1Tb8hJK23Zh7y8ompjsjmVRdeDyN3Tox++UkB8qPZMMWstmI
 Y6nDIs0kcpMMqXHHgqunuL3sKTcGq/Ac8rrKaqGlNn3gX5gOl4GtSBosSsXFudQ4DAzI
 MWhACwshMFn2RUmYZd33x0ZRKM4B2G4sLIWe4Oyivy2q1vYS9ccnJ0+5Yhd7OxCek+pC
 hDwvdnMG0dWZGXE0lXgRHPg1VNXxL0KnH+47zPpcrosg7Ut7O6UFagwOVLXglBBJyAkh
 J8eQ==
X-Gm-Message-State: APjAAAWqHOVRexwU1u1nEVixMA13i46BTCMamANur6zHsmDWbEjJfckG
 UmD00vf24vUALIWJnURmKgr3vrBetk3PwqV7UnQf5w==
X-Google-Smtp-Source: APXvYqzijRCdiCgtAS54hIkOnWrg0lv445xZzpHZwxTcEM+ri/YbV9SOX0mHFP5P3gGhqU5blgGoR/P8TmZa3pACDUE=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr14122051oih.73.1561478577981; 
 Tue, 25 Jun 2019 09:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190625155956.00002dc4@huawei.com>
In-Reply-To: <20190625155956.00002dc4@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Jun 2019 09:02:46 -0700
Message-ID: <CAPcyv4haG=Pu_-Se+CiGOXHuM1qZH8uLP-Pbr_KgDmL3GOf25g@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] acpi/numa: Establish a new drivers/acpi/numa/
 directory
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
Cc: X86 ML <x86@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Thomas Gleixner <tglx@linutronix.de>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 25, 2019 at 8:01 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 24 Jun 2019 11:19:32 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Currently hmat.c lives under an "hmat" directory which does not enhance
> > the description of the file. The initial motivation for giving hmat.c
> > its own directory was to delineate it as mm functionality in contrast to
> > ACPI device driver functionality.
> >
> > As ACPI continues to play an increasing role in conveying
> > memory location and performance topology information to the OS take the
> > opportunity to co-locate these NUMA relevant tables in a combined
> > directory.
> >
> > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > hmat.c.
>
> Hi Dan,
>
> srat.c now includes processing for the slit table which is a bit odd.
>
> Now we could split this up in to a top level numa.c and then
> srat.c, slit.c and hmat.c....
>
> Does feel rather silly though.  Perhaps better to just leave it as
> numa.c?

The srat and slit tables go hand in hand, I'm not too bothered by the
fact that the slit table does not get top billing with its own source
file name.

The "numa" term is already in the path name, and calling numa.c leaves
out hmat details which are also "numa".

> I don't really feel strongly about this though.

Understood, I just did not see the justification for HMAT being off in
its own directory when it is a direct extension of the existing
ACPI_NUMA functionality, the other renames were my best effort to
rationalize the code organization.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
