Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE46273328
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 21:50:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04CC414E1A442;
	Mon, 21 Sep 2020 12:50:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D97D14E1A440
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 12:50:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so10210652pfi.4
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfum0xk/RZI5/Ob/LotdK/fUqBVcECeLZPhlAXF7GSA=;
        b=MzlFGtZxMRR3IzQFO78/27PAi9Tln8PEKmg4AWR1bn4Yo/X9UINdsoC9HczWeOPzK7
         QNTmfcvvkJG792tUX68D4WrnSFP9CgJoYPCVFNR3GKZ+FyLm9t8ZFvvG1E2VbgZ5QAOS
         +fB2gXbEHSaAuwNmKSv0Pd9zLHo+Oakazz/3+sTuhR7vJmpMwG3RSQFWLIHrAFmxsCGF
         rqx+I3MNILJxZtgM/ON8s9FbFBrflmYiKAX23PoTz6WxO8eG+V87SwM9NqDKQlik6d31
         oPGbYOdDpITjhl+sn2utDDkLbhUp7n/Am/HwVzM1DY93mI1ZfI1r1BvJTjtfivUMY2U6
         ZKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfum0xk/RZI5/Ob/LotdK/fUqBVcECeLZPhlAXF7GSA=;
        b=kuBAY4ewDRCLUulbLPJE3f5vfmshMc7P660F3lMEDvApbOhF0iCy3QkEO7cK4+0Za4
         XRQi/MY+roZYbIqDa7f6lVwgjnhUbtjOIx0QHNK8Nt7DTd7iKf5pi6rjiImmTdZ6Q+Pz
         4MGBK9pi03YsHsF98P0r/izxRC4+iZtvFnBAwLQPFQd1pNu3C6aRiY4BTRVCARuXioU9
         uM3RHum8hX4KLSLNOsNMpIw8Nh9xG6E9NLDHywwKW9PnJFGuOSICjvrsBb7gpFrK6qzN
         cJuRK+cmmPvA2wfaYC0biB/PeojPDnhjZYbMqVtqXSYg043TX92gNITTM6yaHHB6Rnvl
         ReFQ==
X-Gm-Message-State: AOAM532CAk8PBRZWRGxJ8e29ekIf9BJJwc1nwMOZVo2+kBKcBUK9HkZg
	n878eCF3Wa5vgQ6Ka4rIpb2UCX754kWrVSYQdDgUCA==
X-Google-Smtp-Source: ABdhPJz0K7J9Kcn11+9meMrf3vRxVrLQJR4W3Bic2SiC1mK4LkwttbXKUrEWzTmF/9m2Ua801TzhyzK2CS2WC7W1H4g=
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a108 with SMTP id
 j128-20020a6255860000b029013ed13da108mr1208250pfb.36.1600717828686; Mon, 21
 Sep 2020 12:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
 <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
In-Reply-To: <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 21 Sep 2020 12:50:17 -0700
Message-ID: <CAKwvOdnVeAFu_Zb2KNuCUcVRWcqsX9r855uyKAMR4+FM8LTdoQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmQ==?=
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: MD72TCLU5ZHK23XYJGMSFIBVSMIT75S6
X-Message-ID-Hash: MD72TCLU5ZHK23XYJGMSFIBVSMIT75S6
X-MailFrom: ndesaulniers@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, clang-built-linux <clang-built-linux@googlegroups.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "kernelci.org bot" <bot@kernelci.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MD72TCLU5ZHK23XYJGMSFIBVSMIT75S6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2020 at 11:47 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Sep 21, 2020 at 11:35 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Hello DAX maintainers,
> > I noticed our PPC64LE builds failing last night:
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
> > https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
> > and looking on lore, I see a fresh report from KernelCI against arm:
> > https://lore.kernel.org/linux-next/?q=dax_supported
> >
> > Can you all please take a look?  More concerning is that I see this
> > failure on mainline.  It may be interesting to consider how this was
> > not spotted on -next.
>
> The failure is fixed with commit 88b67edd7247 ("dax: Fix compilation
> for CONFIG_DAX && !CONFIG_FS_DAX"). I rushed the fixes that led to
> this regression with insufficient exposure because it was crashing all
> users. I thought the 2 kbuild-robot reports I squashed covered all the
> config combinations, but there was a straggling report after I sent my
> -rc6 pull request.
>
> The baseline process escape for all of this was allowing a unit test
> triggerable insta-crash upstream in the first instance necessitating
> an urgent fix.

No worries; just checking that failures are root-caused.  I see it on
top of v5.9-rc6:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/.
I don't see it on -next today, but assume it will be there tomorrow.
Thanks for the info.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
