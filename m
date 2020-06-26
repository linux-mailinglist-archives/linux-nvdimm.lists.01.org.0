Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3220B380
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 16:23:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 814DA100A4626;
	Fri, 26 Jun 2020 07:23:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5AB7100AA7BA
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 07:23:40 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id h17so8213849oie.3
        for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 07:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s+jOM03Ys0L0H6keRcrjY2jkiJrGLbo1O0phZPezKY=;
        b=Ea/Oog4ixochq2AfMpYNSYYPnBdVRSArULN7NzTU3iUz/3jjwMhtqph8K9GxOOnx4F
         mwOoeR/XdJEh3k+KhKeXNvr9iNU/RR2pXUNYX1aU56jOPnPP4AxxFxKUGMxLvapJyeYj
         j5vYTgpHKIGC4xGqQk+JKfIbWNH5sWgQLFNEGCRHsM9jrZ4iVTNI+IXuTo+bYEG5Wo0o
         SCR9Xgv09U1vDV8xqs2uSX6ylukvI401LivggCxbto+AvboBbVI87c9lE0zXH0p4robc
         0jKHjllt3b7S34pStWuB/eDHltL7LwLaS/kgrFgdp4JXjgg0VLirlNHTer6iIlK1l2fy
         V0FQ==
X-Gm-Message-State: AOAM533ICOwt3YrYsc93yFnKizElK1utAuYCUP8jNUvqrQaBIEsWGm1H
	1YmhKemaXJYPJOr3wMr9amzlXX1BLiok7GQMTDU=
X-Google-Smtp-Source: ABdhPJz6ugoc6qjOUMHZbN/qVoA9N2ilGrzO14m64yxqaMJkzKgFIoX4Uv8A4Vz758e5B/07WM2QMXgtRst2wS7uixA=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2542048oic.68.1593181419856;
 Fri, 26 Jun 2020 07:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159312907937.1850128.15890323251117466770.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312907937.1850128.15890323251117466770.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jun 2020 16:23:29 +0200
Message-ID: <CAJZ5v0gL66d7fo8nmKFUm6dSBe8bSRymcOfW9YeePUJ9U=3p-g@mail.gmail.com>
Subject: Re: [PATCH 11/12] PM, libnvdimm: Add syscore_quiesced() callback for
 firmware activation
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: Z6UBTAFWGGNK7WG5AX3ITDIIZLWKBQZL
X-Message-ID-Hash: Z6UBTAFWGGNK7WG5AX3ITDIIZLWKBQZL
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z6UBTAFWGGNK7WG5AX3ITDIIZLWKBQZL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 26, 2020 at 2:07 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced" all suspend operations have
> completed successfully.
>
> Note that the placement of syscore_quiesced() before
> suspend_disable_secondary_cpus() and the "TEST_PLATFORM" early exit in
> suspend_enter():
>
>         if (suspend_test(TEST_PLATFORM))
>                 goto Platform_wake;
>
> ...is a deliberate tradeoff. suspend_disable_secondary_cpus() causes
> violence to drivers with many interrupts allocated (server-class network
> adapters for example). So, allow for triggering firmware-activation
> without requiring all irq vectors to be routed (oversubscribed) to a
> single CPU.

So while the other patches in the series look good to me, this is kind
of questionable for reasons described in my reply to the intro
message.

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
