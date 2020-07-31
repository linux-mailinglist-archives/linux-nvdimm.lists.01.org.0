Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66899234879
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 17:29:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AC0B12905FC8;
	Fri, 31 Jul 2020 08:29:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A71ED118D2A43
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 08:29:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v22so11849214edy.0
        for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k2Qozw9K7T3ULHctZF2uRyGbKqkev5Yvd3i8BwLL6Q=;
        b=rU/7m59TNeq5RpPtiUF/ooEfv7y67ob0BFihzDNxqzyOmEpsLDWpdRWM7a1Ta8diX9
         7/KmEpDzjGcJg/Pwvj5CJyOTsZLukJCMCLa8+AoMszs4qJ2ovqLeTB8tvugBUABNICT+
         eDx8T4FKQBB7a3AF6wXJM4aILfpBArYOrJuEN4lkQy4uwl9e0jQGD8SXyeGbMZNORy2L
         yAShufuKVBs3/3TERLOxaa0ePPEogNjB9YElAimeP98Z0X7DEawjgep2fVgs0yc7Su75
         36fuiJkQisHXPKWkagRGrmyt7j/f6VdTzQ17F84MaIPjL3U9bAoqmxQ5O1LyXMSuNHUw
         J1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k2Qozw9K7T3ULHctZF2uRyGbKqkev5Yvd3i8BwLL6Q=;
        b=QVdWVNJJBSmtqlCeFD7aklnYBHl7MeDQRa3wnZct0aW8hTDkbflkr0QIevws11LX0V
         A8Oel+ga0HYnmPm/pe757h590kUk9KK1B4c5yFnrRuRzItUW1SFoBstwpeXGTnMrCkqV
         0AJps8/D4WrHyr2LJ+mI4JGYSTOtLYKrEpUgLmzY5wNHytMPTBwv5O2q8te+BG9kBMym
         P8HLLO7w8ynTeMMswRP4dJGdn7UUcm6p2w+6/q8bqXKUK1g3Py7C4d2rCz8/eBSYzQ6o
         bYx3zm1jsPAMeJefNVewVGp3SL/3s46lO+omc/jcKVWkUXDAcXcehwplM1wwxFdwvLYO
         E9mA==
X-Gm-Message-State: AOAM5319QUpA9eHVv1SXCKAR40EuXeEOTrTv+2TzsUWBVZAZPYHhGMBL
	kzcB9G5lqFJt9QTkt4Bpm+c+EU3EludUfJC15BeasQ==
X-Google-Smtp-Source: ABdhPJz0P/lPp3nduBpCI463CmMAzDxLqlASXNACZIK8CQVQjVPCG9CcO/+9HjqSM/KyFs+VY+csHhR3WhxQTYkaNqE=
X-Received: by 2002:a50:d51e:: with SMTP id u30mr2058575edi.296.1596209349842;
 Fri, 31 Jul 2020 08:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 Jul 2020 08:28:58 -0700
Message-ID: <CAPcyv4iqkuzyU_u+VW1nsaK7tiy+HJtUxLtgAxtfX0aXXcKhfA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix and enable pmem as RAM device on arm64
To: Jia He <justin.he@arm.com>
Message-ID-Hash: J75AIHLD65GQRTYWQM7DDUU65H4S4A3X
X-Message-ID-Hash: J75AIHLD65GQRTYWQM7DDUU65H4S4A3X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org
 >, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J75AIHLD65GQRTYWQM7DDUU65H4S4A3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2020 at 7:06 PM Jia He <justin.he@arm.com> wrote:
>
> This fixies a few issues when I tried to enable pmem as RAM device on arm64.

What NVDIMM bus driver is being used in this case? The ACPI NFIT
driver? I'm just looking to see if currently deployed
phys_to_target_node() is sufficient, or if this is coming in a new
driver?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
