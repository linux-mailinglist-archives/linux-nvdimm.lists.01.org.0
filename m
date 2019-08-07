Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4485562
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Aug 2019 23:43:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40BE62130D7F9;
	Wed,  7 Aug 2019 14:45:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2762B2130D7C5
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 14:39:32 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o101so110274255ota.8
 for <linux-nvdimm@lists.01.org>; Wed, 07 Aug 2019 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ui4rLo9gpVRZ78lcWW4F1q/0UPzN75Hp3TwiQD9KZlg=;
 b=Jz9k6I2DJOx8WsCZqv6LFANwhAYfC1SdJF1xTVWL5V5TGDhpCX7uZh6SQ0OLk1ql0J
 EYQVy7+JaleGvrIVJckrjydIDXMGBl1uvONiMjJ9ERV+q80As6pxMlpZd2+0U05Xvaml
 L/NVnEN597yYDf7Xq2tJoBc5NifrxFH9Q/XmqYsFjwCKm6fhUPRcoC08WtQoen0tBoKK
 vDSLBhuocv2AMV9Fc5p6Pf+uIqINvsjbnCUuWMzkgV/7smik3ss8db6d1bVrpH8ykAJW
 NaN2u0ZZ4+0QA8TnT/vOiaUPcvfm46Y09cQkiHGeui/mWw1PZN4oz+yCv/DmK+jA9DIw
 kPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ui4rLo9gpVRZ78lcWW4F1q/0UPzN75Hp3TwiQD9KZlg=;
 b=MMxpzkt6mFTgUphSl2XtQVBI+vVqvaRZGAoxCSz2eBoo6swx9U2GeZFqnf1rGLdoRU
 ornmeXmtSqp5w7xBjnfkGbUsXB63dDR41VDk2O9QLHUuWxuhMyFTLbb1nTmNefj73jER
 Pt0BKesvtqzpTlByk93Asjt5RsYud3p6AgwRR6LvqryWpTRW6Pqn8jrFiYFYeA4Typm+
 jaZWdaQfWIlE6qscdh0Cvu5WaW8+mOUlV8bxfZBAOQaBpIEuazbdJ4k38OZfd7ZcdqzM
 ll51eD2B3xloS1JDcWZ3dItiZvaY3xf1ch3Fm/LYJN/LpShX4nx8ZAdT+gzaml3RwQNW
 pvTA==
X-Gm-Message-State: APjAAAXLvcpKv78z0Sdgl25JaKyBcYmH/+hIbIzl6yl8tpyQIftj0sPK
 xcRKwoflhLAINZD7T30SGJOtd38KUvTfjkaLHiARJg==
X-Google-Smtp-Source: APXvYqyhOXnn9fM09GmNN9H+pkIkpEs1Xdb9ffmlgsUpy6GrG9yc6CVgab21CdQIMlPDEJBTal6pcL2TbclLGPBJYkE=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr163902oig.105.1565213821206; 
 Wed, 07 Aug 2019 14:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Aug 2019 14:36:50 -0700
Message-ID: <CAPcyv4js-dZWFyRM7=JgC31uJUyxVzuwrderFrWf5p=z82E+WA@mail.gmail.com>
Subject: Re: [patch] nfit: report frozen security state
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

On Thu, Aug 1, 2019 at 2:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> If a dimm is frozen, it is currently reported as being "locked".  While
> that's not technically wrong, it is misleading as the dimm can't be
> unlocked.  Fix the confusion.

This looks ok, but now I wonder about the case where the DIMM is
unlocked, but frozen? I think it makes more sense to show "frozen"
when the DIMM is frozen-locked, and show "unlocked" when
frozen-unlocked. I.e. if the DIMM is frozen the user should assume
it's disabled for general purpose operation, and if it's unlocked the
fact that it will fail some security operations is a constrained error
case. Thoughts?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
