Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76C291466
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 22:54:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E21941583520D;
	Sat, 17 Oct 2020 13:54:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 544F51583520B
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 13:54:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l16so6303245eds.3
        for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gclTxwgudwqILxx80qh3Opdjv1pTyPGDlalzB4e0NIE=;
        b=D194yODEDSY0phYrBqB+rZxx9oGs8Hp7A9sbiuVFcSN+RnhgTHu0oFXSq1PMsvdHpC
         S6+pj86MinFH8hl2xfjg/AuHQAjXOvcPG9u8WPVHjNa3wAcTi72GZYTTGqfEUMyZWZnY
         srqrqCRKrb1gdkGeZWW/nDEY0x+v5GNjUN0nDiIri3yYA7+zzk54plnEn8q/vz9d13Kr
         /3C6vvgjxsDgPtqEvlhrFWv//kA0Y3CMFi0MDnvs+z8Kd9PQWVlqY94Ko6d9UvcYy/WD
         JB/oTzDiTakpOBakbuXcw/h9bturE2wPt8qAxpKoLQASk8wHFrcqfxrPHaz5ar8pj5uW
         WKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gclTxwgudwqILxx80qh3Opdjv1pTyPGDlalzB4e0NIE=;
        b=X/0fMutrETCcGg6OoQYUYlpyQVVn3A8G7XUwkSI7ATacyx4bjezCHhF8q/tHJ9COBi
         WA2dFFmKQCb9yrU6ubvRQyjjrH+WqUUpbr/PIFLGBybl5fKlanbbWtIn/h0UX9lEhzvs
         Xe1YSaS2sa8Sm2GeOABd1cjUlPNv8koD8zkNuxsUIVC9w9L+8KElh9mHJ3CCe7GXdov3
         pUdiNabJDDEIKpXjH7gmX/oNgr6u/fMI/vmz53Xi7tqQoVcp76/QTaCp+uOXwq9EYApB
         9+gnh1o1C7pKyi0dd4pb4ozRxeX/DCYCFxbUCKBrbk2aDoCHVKP73NWmauTDaDNaj3DQ
         6QAQ==
X-Gm-Message-State: AOAM532JBaaZPw/+HUGO6Zbi+l1und7ogucVQ6w4uzOW6kU9fEE0awBB
	XMG1K0HPKzpK+03z92KL7TKpjQ2NRTdlr/MuuB2Xrw==
X-Google-Smtp-Source: ABdhPJxKTe02sV/xjDNzwUaiGFr+iX0TTarUAS7vSx3ygOAUPxPR7uFn+/0xFWsW1q35MvXTJeV+lFjdSEMySCrnXkM=
X-Received: by 2002:a05:6402:31b3:: with SMTP id dj19mr10956568edb.210.1602968058286;
 Sat, 17 Oct 2020 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <160288261564.3242821.6055291930923876456.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg_HafvgLvyHcYk=K-gJFdj9aqap4At7DCFyroLVC04LQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 17 Oct 2020 13:54:08 -0700
Message-ID: <CAPcyv4jSji5KvLuouqSt-O_-iuKnCu4pXL1cEUqd1Ws+gjxqHw@mail.gmail.com>
Subject: Re: [PATCH] device-dax/kmem: Use struct_size()
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: 7UX6E3MZ3AVKVDWT37NNQ47WN2GT4P47
X-Message-ID-Hash: 7UX6E3MZ3AVKVDWT37NNQ47WN2GT4P47
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7UX6E3MZ3AVKVDWT37NNQ47WN2GT4P47/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2020 at 11:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 16, 2020 at 2:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Link: http://lore.kernel.org/r/CAHk-=wgNTLbvAD8mNTvh+GQyapNWeX20PXhU_+frqEvVq4298w@mail.gmail.com
>
> Does that link work for you?
>
> Because I can't see it.
>
> In fact, I don't see my email at all on lore, even if I see Andrew's
> email that I answered to:
>
>     https://lore.kernel.org/mm-commits/20201016024059.Ycwm4GmQ8%25akpm@linux-foundation.org/
>
> but your link gives me "Not Found", and when I search for emails from
> me on mm-commits I don't see them either.
>
> Adding Konstantin just to solve the mystery. Some odd mirroring
> problem, perhaps?

The link did not, and still does not work for me. I was hoping that
was a temporary condition until the thread made it out to the
mm-commits@ archive on lore, but it never seemed to resolve.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
