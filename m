Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746F2A136A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Oct 2020 05:45:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E60015FBB961;
	Fri, 30 Oct 2020 21:45:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9739515FBB960
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 21:45:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dn5so8724613edb.10
        for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 21:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9X1WqmxkNGgLr0no2uxW3O0tvO6XEpLaiL7FhfDS8k=;
        b=10Y9BHkDFhUqDS8P5MP7q9c4WvYMApR2mn9m7W9epocW1vhyy9HU4G2Ze5hdk/Bb9+
         vA41cR0s+I0Oc79BQX5cGbFMFkiAaybEFsAT6Zo9FpL90Tv4ma9klYs0j4i1Fbuvv46D
         5owE0F6JtNbs6ZWb1RbHPQxAuVXPa9o1KoJ06JBMpNAEdJPzFwVd8VRVKMHA9N/u7QiE
         n6TBwmcbhdcQBTbo0esZt5DnPDMGY0zpLrc5OmPnApYeYjdzoVq7WvZKTbkrWlV58oQ5
         lRoyMeQ5WAHnZvyZHXxJevkoBsTYrdB3Zmh8nLrFh+IInWxHPIBrBVZ1RnN6Fiy1e5ms
         keXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9X1WqmxkNGgLr0no2uxW3O0tvO6XEpLaiL7FhfDS8k=;
        b=lGliXyIK/xCKnBkrbz4vaVJjMCvD3QOHeGgvqkeB9N4Cvi4GUAJSJJQMm0iowhbioP
         nF0yK/WcmiljTt1yiMuFOvJ+vc3q1rDpD0TZ2B4M686IZSziu//8zGMNqtxskJsa8YJh
         f85Cz9uQqpo4RpTdr3xYB6BxrqdyZ0a56rAz+ASy/zDGcGHPuWVjKNjIKD4AhzGeYva4
         AjzsnAIW76iegFBVkXASbJKIVnYYLWKnp2Gs73OhbLyHVMiKrA4hH2giLzQieZBkc3C2
         X6gjGsyi4//5fcIT4gWta7CGYAIvwUtPrItn5cl0vzeRJ8Q2R4y+rSm63w+54/184RFi
         e3QQ==
X-Gm-Message-State: AOAM533D9P/8lcLvwFQEBhHOeotVjof+eUx6z8hkQWEYNpLqWBhL3Ker
	bg07KhXyPp5X/FXxV8Ac6VnDJmnJNptUbhxwVwBptw==
X-Google-Smtp-Source: ABdhPJw7OUNE7e1apeBw5NBPwhJYIxLYnSUrhtCHXZMKQIDl7KvVGKS8grzd6aBm7nBnZR707egjt1Tb8Le7L2Cv8rA=
X-Received: by 2002:aa7:ce04:: with SMTP id d4mr5875995edv.18.1604119524822;
 Fri, 30 Oct 2020 21:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iw_ZuHdhrGHUPh+iBYuO7sN_omEGb8RMmOKVzSCpbT0g@mail.gmail.com> <87blgjksio.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blgjksio.fsf@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 30 Oct 2020 21:45:10 -0700
Message-ID: <CAPcyv4j+k9LQjeJ07waH25oYMaivP95aNcwvVNrDcW9UW21ZYg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: 2I6UO4FDW6YEULGVWLBXPM27JOH76YKK
X-Message-ID-Hash: 2I6UO4FDW6YEULGVWLBXPM27JOH76YKK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2I6UO4FDW6YEULGVWLBXPM27JOH76YKK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 30, 2020 at 8:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Oct 30 2020 at 18:54, Dan Williams wrote:
> > Thomas, do you want to ack this so Andrew can pick it up, or I can
> > take it through as a device-dax update, but either way the diffstat
> > warrants x86 + mm acks.
>
> It's butt ugly but I couldn't come up with anything better right
> away. So, FWIW:
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Thomas Gleixner <tglx@linutronix.de>

Almost-threw-up-in-my-mouth-a-little-bit-by?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
