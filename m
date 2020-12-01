Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0452C94D4
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 02:48:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5731A100ED4BA;
	Mon, 30 Nov 2020 17:48:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 307B8100ED4AC
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:48:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l5so577802edq.11
        for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+5BnXN0m77zeqbV9n5TCbwnpu1hY0RqzGtMEds/qCk=;
        b=rWNSLZccHLQMDZM511qECtn11KzmY9V1pm3NFzbNx9FNIAvMfbJZ5PhH7y7RJpOQFh
         NkY3FA5HR5Hf5mnziwzJM9svdIja4C0kx6z3oxGLOS+IWW7J2arI2VO2kc+FMAzkt1h2
         n3Fu6rpF2T9mB3i+lPu0V5lqbvqCIRttoYP6vG3JP3T1bZe9839Cf9PCkUMZa/6GKJLR
         11hBNNHNXJjNQ6JpUlNcuCZpCATMj4pAhtQHYEEhiz06MWPMl+cm1R7IUOpdNJnRcS7M
         ji5eScauaoh3xBsM9+ys81gjfuZGq+OdTLnNHeiZB9TB+mVemzSANEyYFu7dJH/1++BW
         tZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+5BnXN0m77zeqbV9n5TCbwnpu1hY0RqzGtMEds/qCk=;
        b=CZrR7E751+yCsoFN1iNNaGLMmwdJKg3L+zAJtMt4EbkrWO5o3cJNcdwcw1vTu3UBYn
         wQ1aCKorxu/UedC9tsI1xDxwHXUbOUoZuXoqtmLvHIOUEf+PJ74f3oKpDG3R0WFfz9Id
         CGF3EcTUwQGBZo68vSo0rOmGzuMfk1YZGqWQZ4uNgQepnKsldt1dEWdaleOgeR6pP/90
         IlHucPp8UlHvWRORPUwUwI+uzNYLj3JidXxWInFAM6Yk71a2xRvi3m2aCIoGBOEhNxir
         VGK7Oei8BV6QCb17HlmcvFn/9PqIYTSqCg1PinNxglgl5PGAf3w8lkJXPuWkDZCdWgwI
         c4Rw==
X-Gm-Message-State: AOAM533YKGQxCFRuCav6mnAbynwxNYvYUr4j6Y+8AgQKWhxc+9KHwSNl
	5NiBhIADiMH/suDZ8e5ANjBmjbRIFWyyNN/CnGy04w==
X-Google-Smtp-Source: ABdhPJyE+VpI66Bcq/qfk08x/yZj1ODh2sqzTbdACmS4BeDJH4RaasYLVZ8GxiVk5NOYT/7J2KzzyDhHSnpV/Yf3Gmo=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr697382edl.18.1606787185958;
 Mon, 30 Nov 2020 17:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
In-Reply-To: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Nov 2020 17:46:22 -0800
Message-ID: <CAPcyv4i0ek7znehtJD25VHNsGeKNVdxjL+S1y3M-uqiQOyF0-A@mail.gmail.com>
Subject: Re: mapcount corruption regression
To: "Shutemov, Kirill" <kirill.shutemov@intel.com>, Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: GCFRIIIU4RTMAUX63V6W2UTJ3DIV6XYO
X-Message-ID-Hash: GCFRIIIU4RTMAUX63V6W2UTJ3DIV6XYO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Yi Zhang <yi.zhang@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GCFRIIIU4RTMAUX63V6W2UTJ3DIV6XYO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 30, 2020 at 5:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Kirill, Willy, compound page experts,
>
> I am seeking some debug ideas about the following splat:
>
> BUG: Bad page state in process lt-pmem-ns  pfn:121a12

Looks to be a similar signature that Yi Zhang is seeing:

http://lore.kernel.org/r/51e938d1-aff7-0fa4-1a79-f77ac8bb2f8b@redhat.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
