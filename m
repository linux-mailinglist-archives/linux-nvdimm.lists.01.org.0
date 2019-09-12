Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F04B0999
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 09:41:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E37D9202E2908;
	Thu, 12 Sep 2019 00:41:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 061AD202C80A0
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 00:41:41 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k20so16345947oih.3
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 00:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o8LTeC4govd1fNBJO0ioJqcSmCWQfNIKLUUZIaiAhHg=;
 b=r5iciw4g8aqTCdevxlX7Yl1qKRDD/phXv4v2oTTELHQGit1wxhO/OmSHjpMCzaPPrC
 Vr8pfrqAPKZP/QRditALJa3T7m3utIzI7knIH43NmnrLOYeWwUlpJTX+V+qEIHPXtDWk
 i+S3TBIunng9amNi6owpSMAwGYmTOzTOg39UCXWUFCAs9mW/cRdQ9TrieNsVwozqYGMY
 ud38gNVy7hASRzjURWmOVrK8Lm1bGKmNLt/QqIPlK0Zbi79sDGl94Y4HvgRcvzJv2owV
 GO/6yFDyIZBlsfIr5xvExb4PHDGHZscKuenTgOys/I73OMjRL8cbQsLrUCTP+Fo1/Uy7
 k13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8LTeC4govd1fNBJO0ioJqcSmCWQfNIKLUUZIaiAhHg=;
 b=N3bTKJL1Q0UZK8oJhyFi/v0dn6Mvnedf9n23gJRVqPTxjXk2zOCN9bwoWO8/x0FjA7
 chLcr19Kh9gwwj0oHh1X6r0WljLr5bg1n7cL89d4Sk3ZZHgMUwc6jXmNe5gNH4yVcDdb
 f1nAn1P4cG3yC5EHWNS+Hawcbrwr79LMrl07ie2AANLxpi1HFxSSaOO94dRj4qgSzPZO
 PVWhYL2aTIQ+X0ZSHfiBDO3cpJmEKzOImkkp8wbCn0OMGh6Uzyk75mUd77Nm264sSuNn
 1Oz6oEZjNTAwNwpnnRsAM/LRy79/dDyd/YIVhz2S/JyRIbmdWDqdiqZ/IDCdeGEsfpE4
 2ylw==
X-Gm-Message-State: APjAAAUzzsvketryK3Sp7LzalWqUrf3+CacPEAmU4OVDwzRpB7deHXAP
 wONZxC34/utDxRsAV/AS55TB+iFkFxLfrCEczX8L9w==
X-Google-Smtp-Source: APXvYqw0A8Lqk6qX7CD0ZjUAfqaCMtvOeZCnyqiVzGAx3LVFCio/Y9Fb+8rbJ3TzTxR704q9l8iceiToxbjJgcESn2g=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr7724558oih.105.1568274096350; 
 Thu, 12 Sep 2019 00:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
In-Reply-To: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Sep 2019 00:41:24 -0700
Message-ID: <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Jens Axboe <axboe@kernel.dk>
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
Cc: ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 11, 2019 at 3:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/11/19 12:43 PM, Dan Carpenter wrote:
> > On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
> >> +Coding Style Addendum
> >> +---------------------
> >> +libnvdimm expects multi-line statements to be double indented. I.e.
> >> +
> >> +        if (x...
> >> +                        && ...y) {
> >
> > That looks horrible and it causes a checkpatch warning.  :(  Why not
> > do it the same way that everyone else does it.
> >
> >       if (blah_blah_x && <-- && has to be on the first line for checkpatch
> >           blah_blah_y) { <-- [tab][space][space][space][space]blah
> >
> > Now all the conditions are aligned visually which makes it readable.
> > They aren't aligned with the indent block so it's easy to tell the
> > inside from the if condition.
> >
> > I kind of hate all this extra documentation because now everyone thinks
> > they can invent new hoops to jump through.
>
> FWIW, I completely agree with Dan (Carpenter) here. I absolutely
> dislike having these kinds of files, and with subsystems imposing weird
> restrictions on style (like the quoted example, yuck).
>
> Additionally, it would seem saner to standardize rules around when
> code is expected to hit the maintainers hands for kernel releases. Both
> yours and Martins deals with that, there really shouldn't be the need
> to have this specified in detail per sub-system.

So this is *the* point of the exercise.

I picked up this indentation habit a long while back in response to
review feedback on a patch to a subsystem that formatted code this
way. At the time CodingStyle did not contradict the maintainer's
preference, so I adopted it across the board.

Now I come to find that CodingStyle has settled on clang-format (in
the last 15 months) as the new standard which is a much better answer
to me than a manually specified style open to interpretation. I'll
take a look at getting libnvdimm converted over.

If we can take that further and standardize all of the places where
contributors see variations across subsystems on the fundamental
questions of style, timing, follow-up, and unit test invocation the
Maintainer Entry Profile can be superseded with common guidelines.

Otherwise, yes I completely agree with you that a "Maintainer Entry
Profile" is a sad comment on the state of what contributors need to
navigate, but that's today's reality that needs to be addressed.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
