Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95C362579
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 18:16:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0CD7100EAB64;
	Fri, 16 Apr 2021 09:16:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.44; helo=mail-ej1-f44.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 91CFD100EBB7F
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 09:16:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id n2so42903931ejy.7
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dght6t2pyQRseqLb+lVrCX02nFkhCRTaAH41zfKcecM=;
        b=u7wanB8F6bCPCqjo1mmYJiBBZNtX2jw3FB+isUTy9l1h4n3idyqjUbdcD+V2z9q+46
         j6PszlzUe7vhdE0rcfHy3WAgCElEf4YEr0XyzZVKzldzCuEgMUN1D6O+sQenSJpg/2db
         g1AkNA5TJ4Tl9pIAMT6z8az648EMAHB1zhHxcSOQzuYwrmk7zatzsHPk7q27Gt1Jvi4P
         V1hkeiobgr/aGiYpf1kpo9tuSWeiwifYzUj8K+X1XS659n8mCKVuc14K0C5yESgO9fSE
         NDcINVSA2Hq//2HStl2+7sPJVy1sVaiA2kQzSEbkCbd7QQ4LFd62WC6+AmxQWBVCJno1
         sDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dght6t2pyQRseqLb+lVrCX02nFkhCRTaAH41zfKcecM=;
        b=rY8lcIyzdJvqQoPyFXr7+ubFERX08PAa+a1XhFDz8v8HE6N9Rldliv9LT4xBrbrNMz
         h0NGeI/q+/lL1Bf/OC3dAaN8oLr40/3xmRwbatvnam+ffKVoR+jQRSthxmCVoL08bADY
         MbPARLfAGDFyObcCdN1hDkJH9NOAa7DHJZvwqGNT/MbwcfcwYvcXKoPKTOcdJ7pMSJk7
         xnmoivw2MFvs8XxGas499FUFJXCf1Zw4L87R2G0dKCB3SiSJeHhun8v5/3zYeAQ+QyAf
         NF704tEPvPkDWV1TNup4CJ7+9hgKVlg0OW3YekzhsRr7gNadtklBUVDb3oyJOoxkO13+
         T92w==
X-Gm-Message-State: AOAM530921jEbGmRkFZjMbFMlKwZRE7L/dc1zibbzoGD1UY1hd7t9a+H
	5/4W5rAErNewz06c93ddzz3apbwb/GnnbE9j84/KUw==
X-Google-Smtp-Source: ABdhPJwj2vAvYOe63/DPsEm6y2cjiOfb+/u6lZjT0ubYCymFcdqXfUxqTqmSJW45RL33s8fRQUkr+b4nOGvpv8WyzdI=
X-Received: by 2002:a17:907:20e9:: with SMTP id rh9mr9284048ejb.523.1618589744375;
 Fri, 16 Apr 2021 09:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com> <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
In-Reply-To: <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 09:15:34 -0700
Message-ID: <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID-Hash: WKDL7BEI3FPHUG52VO5V6H25ZEDAJPND
X-Message-ID-Hash: WKDL7BEI3FPHUG52VO5V6H25ZEDAJPND
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WKDL7BEI3FPHUG52VO5V6H25ZEDAJPND/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Strictly speaking the comparison between guid_t and raw buffer
> > > is not correct. Import GUID to variable of guid_t type and then
> > > compare.
> >
> > Hmm, what about something like the following instead, because it adds
> > safety. Any concerns about evaluating x twice in a macro should be
> > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > not an array.
>
> ARRAY_SIZE doesn't check type.

See __must_be_array.

> I don't like hiding ugly casts like this.

See PTR_ERR, ERR_PTR, ERR_CAST.

There's nothing broken about the way the code currently stands, so I'd
rather try to find something to move the implementation forward than
sideways.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
