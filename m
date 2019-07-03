Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D45E9DF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 19:01:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D3CE212ACEC8;
	Wed,  3 Jul 2019 10:01:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 393C5212AB4E6
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 10:01:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r6so3113376oti.3
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
 b=wNUY8V/mhFuU37yp/ZiCDNP/H5W230TbjZb/97Elz40NFzQaPClxobNSgEuk/f3fsc
 KAsS1YqM5g5FH4s1vA63O4LG1jBHrjJk4+vd6uDPabBVuDZihDUD9S0urvnYPszj/0V7
 K3GtQXRnQlXcSKL2AyAP/XyoqqAcN/eugW+0Q5+IDzc1779CIDToxE4AjArrBzIAjzzq
 Q/pmhuRmYDByH0oTkD8u1Po/Dr97GukMF3RPS45sTrwZMCPuUPVZ7/af6ttu3XmQfaUC
 k9omAOSsVODfgBm0uvi0QAClbSTpv8GcLOOgeFCzj/fCCrb3D7mDtnKte0e0X0QHsNvy
 4Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
 b=TaiR9020GZd+0Q6tW/o2Ab1kgamsKJwc/p3l7agGzl7heANe0bZWm5yHsJq/julxRX
 2+I1pjaPDX2/wzd7RnG/JrxsatLdV821U3SdDApSiKafH/cD0MVJloasOQ+b8K/7cMga
 cN/qfZn5Ju3oSzhp6XeFT3+2gAtmZUy0N9EW0IKTnG4A3EJ0Fn6RU/cZere4gZdfX+Pk
 bxaJXC+mU1vfCvNhWqzCmNgUAjy+QqUE4i9PJggB1t6EGCNzr0P+17MOsa+s0tIpJVbD
 xbdIxXgDQeN7tFHVDIW852yORZ9uNE9L9tFj/sswgLyjGdxl/l/dQU3vTxZ84qehJgyg
 l3Bg==
X-Gm-Message-State: APjAAAWH+7xUlBxZBR3fbXOp6YqQR7gdDhARbjl99fIUHvQu3Hd185YX
 dC506notm/7bll6mcRExuaui9K646+Rm5a00cQBG4g==
X-Google-Smtp-Source: APXvYqzUjYaojSiF9PThGytBdcW3gjnOn4fcnoQwduNIvsAmCsZm45nhyVZ2Fow2YVOBy+g16od/O247MvqVqqVrRTo=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr29298148oto.207.1562173309283; 
 Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
In-Reply-To: <20190703121743.GH1729@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 3 Jul 2019 10:01:37 -0700
Message-ID: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Matthew Wilcox <willy@infradead.org>
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > This fix may increase waitqueue contention, but a fix for that is saved
> > for a larger rework. In the meantime this fix is suitable for -stable
> > backports.
>
> I think this is too big for what it is; just the two-line patch to stop
> incorporating the low bits of the PTE would be more appropriate.

Sufficient, yes, "appropriate", not so sure. All those comments about
pmd entry size are stale after this change.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
