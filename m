Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64798855C6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Aug 2019 00:27:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B88B2131D581;
	Wed,  7 Aug 2019 15:30:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DA5522131D576
 for <linux-nvdimm@lists.01.org>; Wed,  7 Aug 2019 15:30:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id b7so60519298otl.11
 for <linux-nvdimm@lists.01.org>; Wed, 07 Aug 2019 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jJnFqPU4Rz4sV+ete8DTdZ7Vkj0R8LcsjQTwOdFRf6E=;
 b=g/gKp2/kOB4g3kAHHfMfassGz3yd+pbSG8pUJOyCNbehqlUHZ0tu02CqK28X7NxvpF
 QuY1KUHX6d+3TwjdBI3iv8UutFQX96TFc9jK11krswjivOqvoLuHTuWkRwMMNBpXmvjA
 wA0ZJcmsvn2njVz/c9knnnsY4uMaYhj+yehf/98JsaGkaTbkWMMEfZX6tk4+tvB52vFY
 hiAonqDeK4Gns4TfiubBl+Ug34Cdr5bnmscJUzvAlS35Nz81xV5E1BhSCjKT+vUmy4sf
 V2hJIJi5RUur9/wKux0WUnX2LQ1buhHt2TwiDg695dUTlg6DU8iHB2h4fDHmKJCz7Qna
 0tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jJnFqPU4Rz4sV+ete8DTdZ7Vkj0R8LcsjQTwOdFRf6E=;
 b=ejzb7eWDjV1Tn5g0uAmMHn0Y42yCX6PuVpz5WOrI+Qy7Ycs0Vm/fXnGaVYVQjUpRwQ
 zbRoY68ui5KKkrUX7XizD0qsLUg336cOjxDm253Kky9i+nmUfPmjCx1mloVrZOqE/fNA
 Bm23wgmLITYeRElmZberhceq6bO8ismMYRlz40czOJS814scmgt7Wft5gEjmDNGM5o3n
 UEeC2slMxEPq7pvuHNMfPF9QXpwOSL20xKHP9DieUP3ApACylzLac4KXjQsbYyU+rl8e
 /9Bjf/TQITVGHTAlv49op3+W4qeYyLVuKvLx2s7xg9IPNxu7Jb7m09Gy5Cj8wch2TfnT
 DrCQ==
X-Gm-Message-State: APjAAAXSGiwXNVxwdblgiGtBGM8GHV4tAIYcNvFzKe30QGXS4gqDGTv/
 Wizui0JI6bATNbu9KSUQOYafNKvgg38izz9FCO8TKg==
X-Google-Smtp-Source: APXvYqxv7BvGXFey07YWiH7sV0Zo/ud3AvawK9TqkZCIF5jqd8af5jDXwo0VNDqOytsT38wf04zmJtfcGOTlXgD6pso=
X-Received: by 2002:aca:1304:: with SMTP id e4mr290244oii.149.1565216866875;
 Wed, 07 Aug 2019 15:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <x49k1bw7dqn.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4js-dZWFyRM7=JgC31uJUyxVzuwrderFrWf5p=z82E+WA@mail.gmail.com>
 <x49ef1whcjq.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ef1whcjq.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 7 Aug 2019 15:27:35 -0700
Message-ID: <CAPcyv4hUsbFP3=7RFLuHWWnZ+jkUfNFq9YRPKVGk22O7NuP8pA@mail.gmail.com>
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

On Wed, Aug 7, 2019 at 2:48 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Thu, Aug 1, 2019 at 2:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >>
> >> If a dimm is frozen, it is currently reported as being "locked".  While
> >> that's not technically wrong, it is misleading as the dimm can't be
> >> unlocked.  Fix the confusion.
> >
> > This looks ok, but now I wonder about the case where the DIMM is
> > unlocked, but frozen?
>
> Hah, forgot that was even a possibility.  :)
>
> > I think it makes more sense to show "frozen" when the DIMM is
> > frozen-locked, and show "unlocked" when frozen-unlocked. I.e. if the
> > DIMM is frozen the user should assume it's disabled for general
> > purpose operation, and if it's unlocked the fact that it will fail
> > some security operations is a constrained error case. Thoughts?
>
> I think that adds confusion.

It does...

>  I think we should print out both whether
> or not it's locked and whether or not it's frozen.  Maybe:
>
> unlocked, not frozen:  "unlocked"
> locked, not frozen:    "locked"
> unlocked, frozen:      "unlocked (frozen)"
> locked, frozen:        "locked (frozen)"
>
> Something like that?  I think nvdimm_security_state should be a bitmask,
> not an enum.  That may be a part of the problem.

It should...


...but ABIs are forever, and ndctl has shipped:

        if (strcmp(buf, "disabled") == 0)
                return NDCTL_SECURITY_DISABLED;
        else if (strcmp(buf, "unlocked") == 0)
                return NDCTL_SECURITY_UNLOCKED;
        else if (strcmp(buf, "locked") == 0)
                return NDCTL_SECURITY_LOCKED;
        else if (strcmp(buf, "frozen") == 0)
                return NDCTL_SECURITY_FROZEN;
        else if (strcmp(buf, "overwrite") == 0)
                return NDCTL_SECURITY_OVERWRITE;
        return NDCTL_SECURITY_INVALID;


I think we could break out the frozen state to its own new attribute
and leave security state to only show "locked" / "unlocked". Then go
teach new ndctl to go somewhere else to report frozen.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
