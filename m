Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104248A94A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:28:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18E6721311C02;
	Mon, 12 Aug 2019 14:30:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A0A3F2130309C
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:30:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b7so114312843otl.11
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6BXze2z6BanLk6QU9Dq1GB3jJ68OiMsyyCe9AHPK+B0=;
 b=BRV6BaGiWOazhCi8sCGZEQDlnAFHEqRgQxhHnKoc8dWfOcNcO6MrkGfw7KQKOmxaGU
 4QFKkUhvJHEweiFJGFL2FCj5HIMW/f4cgYqnThnqtdx7PV7CHDWDUGyzLPEG/DUk3m1S
 Og27cm24G/guHv7zFz814xyDh2HXLyjAkpTchkQBCsCznBKXI7AZNCYc23C12SfO+/52
 P90AkPvskXK1q1PkEbsVmucgLN3Qp0CMeU8ImYj/yUnzBuLWle5wondkwgvHah0Q7H+j
 eIj1EpTVXS2U7A8uUAhZRvZDWiDzoxy/bc4VdA1ZyA68Nt6265h6PpnCwIumS2/E3TCS
 H97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6BXze2z6BanLk6QU9Dq1GB3jJ68OiMsyyCe9AHPK+B0=;
 b=AmfwG9S9EDyq3Jrv5wDaqc82QOdWOpYNnYaeS0jSKshPIz2X2G1JQF2sMc6/PDlcGp
 i8WEoEHwRW2sBcPRZFwr8zmfGPjS0a2z1NtmxK2QmJSivCohdDoYNpvdddl9SARS37nk
 7nt5v9eVMtUSPQTAtT1asC5Av/HcfdikWyVuOyNXTri2dTZ9/ijl4qz/DULhX/RO4qrs
 XR/zWX8PYHHFqv4jW2bGikINKB90JeOvKi68VdpC+6UePch7czZ0FX2zRzfQyKMugtMY
 FsZ4V+VFzm7HeXY9HNysKXwGjqUnTmqoTwxmH7lEiIIrPm433lmDDS0Kk9nAOsThRUrJ
 Xj8g==
X-Gm-Message-State: APjAAAUa+f0HEraiPQd58JduM0jzo2B1wfN5a06OO8CQcR4BAQDa79dI
 VKq/1mn9TPD+ndQm7UiFAvASD54PXypcOwILI/WQlQ==
X-Google-Smtp-Source: APXvYqwEIUu844ZsNYSh7DZb8WFBwqgGKw9CffrEMGDjkSQf2yfeXmqcH69odHNy0e0HGZ0qJgLW7rhJf/F/v48r0XE=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr5051641otc.126.1565645310314; 
 Mon, 12 Aug 2019 14:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <156531368648.2136155.13013612862545053331.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49pnlagljr.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49pnlagljr.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 12 Aug 2019 14:28:18 -0700
Message-ID: <CAPcyv4jbLNzF3-v6n5m4gmi-WDK5WWW2K_5We+9CX147v89Bcg@mail.gmail.com>
Subject: Re: [ndctl PATCH] daxctl/test: Skip daxctl-devices.sh on older kernels
To: Jeff Moyer <jmoyer@redhat.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 1:45 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > If the 'kmem' module is missing skip the test to support running the
> > unit tests on older -stable kernels pre-v5.1.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Note that the kernel module could also just not be configured.

Yes, but then the test would still report "SKIP" and the developer
could take a deeper look if they expected to see all "PASS".

>
> > ---
> >  test/daxctl-devices.sh |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/test/daxctl-devices.sh b/test/daxctl-devices.sh
> > index 04f53f7b13ab..4102fb6990ae 100755
> > --- a/test/daxctl-devices.sh
> > +++ b/test/daxctl-devices.sh
> > @@ -18,6 +18,13 @@ find_testdev()
> >  {
> >       local rc=77
> >
> > +     # The kmem driver is needed to change the device mode, only
> > +     # kernels >= v5.1 might have it available. Skip if not.
> > +     if ! modinfo kmem; then
> > +             "Unable to find kmem module"
>
> I think you need a printf, there.

Whoops, yes.

> Also, do you want the modinfo output in the test log?

Don't think it matters either way since it all ends up in the log.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
