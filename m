Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA8A9864
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 04:36:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA5FA21962301;
	Wed,  4 Sep 2019 19:37:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B40D920260CF9
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 19:37:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id g128so553995oib.1
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fKZiymb/WBRosOWSQ10kuOA32VjNVMh77QN9xQAoa08=;
 b=I3DRtgipt+BFVUAI19iNFMrpxC1yESc9P1GKFe5CFLfoowR5JlEGIGr6IYJNdFw/Bx
 QoH7m1KTQcHoYopMrM7LoHbGnpIRlxs5wg6mDIsTpNh6pm4YoMsNpcOYY5fxcbQEKxKy
 JyP28Wz7yaFtQdUwfH1SoyNBKDSfWT11xD3URnohJgUylX3LD7PWiIDaJTRyCLkRKou2
 bZKpY6gKZbgdPUkbdFeu/eYO54Pm24dQ05lcvooB8OWmmkQflA/F1MVrenA8S3VA5ZpN
 qiCuCLEMcanUwpmtIXvyT1mGis6ant8m/h4jRTQBVtmua4VhfZsVlmnbCImEg29tDnge
 7f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fKZiymb/WBRosOWSQ10kuOA32VjNVMh77QN9xQAoa08=;
 b=J8QhTQ4fMjxd5B7OYThkcwoASIdGw2hsdROuliaVeYYun0+hTOsQId9JkLdORGXapz
 aPVeeLWasv0c2vzGkLYad18r5LA0uIVXJQy/d97mNCS0OgV1sSIb4da4r6kNiM3duxVt
 E/ZncmKwgvvq02lsvNpaTg/bphoj/DXP3MxdXftExHuiqwhxRD9WFf695qJcTqqRXy0y
 mCPn2tptMF05UgLBO4SoKf0UG80+g/1HI6FkVdhsaG95O8Iq9BxrAJ/xGCTMc/KWo9Is
 01OuO2y9/TAkP7Ug4V7cr7GJpyyri01VOp5Z6jedCzP6dOs6/KUR1BQlhPyHLnl8hlkN
 swww==
X-Gm-Message-State: APjAAAUk54aQOXNbLYWqJ95G2Mtudz6KfNIbPCmkTWFFZueVdSBZQCom
 8VSYHa+yoO+IjQoEkalSeJgZcv/vhecfk9y6QYYlTQ==
X-Google-Smtp-Source: APXvYqzICLNEtoZCEdYIUsURU82VTiDaF7tdfWIhRZZ1y6KGOyWuVmNQcRq6ghFkoupRpIYm7tBP8XrDCWHMGjt8OUY=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr836463oia.70.1567651006676;
 Wed, 04 Sep 2019 19:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190905011314.18610-1-vishal.l.verma@intel.com>
 <20190905011314.18610-2-vishal.l.verma@intel.com>
In-Reply-To: <20190905011314.18610-2-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 19:36:34 -0700
Message-ID: <CAPcyv4hMbPAf8yNMfz0ByRKPxZFT-14b-7zvZphStFnwgjVKeA@mail.gmail.com>
Subject: Re: [ndctl PATCH v2 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Brice Goglin <Brice.Goglin@inria.fr>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 4, 2019 at 6:13 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> When the driver of a given reconfiguration mode is builtin, libdaxctl
> isn't able to build a module lookup list using kmod. However, it doesn't
> need to fail in this case, as it is acceptable for a driver to be
> builtin.
>
> Indeed, since even with a modalias lookup list, we still have to resolve
> the target driver based on the mode using the module name, so relying on
> the modalias lookup to keep us impervious to module name changes is
> already flawed.
>
> Simplify module loading greatly by removing the modalias lookups, and
> directly getting the module from a named lookup. This transparently
> fixes the problem when the driver may be builtin instead of being a
> module.
>
> Link: https://github.com/pmem/ndctl/issues/108
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>
> v2:
>  - Remove modalias lookup lists entirely, and perform a simple name
>    based lookup (Dan)
>  - Fix the module expectation in the daxctl-devices unit test.
>
>  daxctl/lib/libdaxctl-private.h |  1 -
>  daxctl/lib/libdaxctl.c         | 75 ++++++++--------------------------
>  test/daxctl-devices.sh         |  7 +++-
>  3 files changed, 23 insertions(+), 60 deletions(-)

Mmm, that's nice.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
