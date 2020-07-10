Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1321B76D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jul 2020 16:00:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 370E41104D610;
	Fri, 10 Jul 2020 07:00:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 910BB10FEAAB9
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 07:00:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so4413920qtm.10
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jul 2020 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeBGSFa6JpLDSEOobydkMfjCm7xXfWYBIoiGgmJvsiY=;
        b=xtDwzbDKceDPrdb2OHoramfVkpsxDADJ71nfnkU/U11ey7QyoCDreWzdTySdP3Bf95
         ko7FnPp1/f2cIaGMh3ZNzsz0Tk0c89dEXFz4xGd5qoKP5aeVtETNGjgveKn8G+bB5ZCU
         qyeoRvjQsFDUXwssBBeR5gc17mrpKDHaW6DNckwXSdhPayaI4sq6JiGfGAg/1e2NR2+K
         w6m5jVpJb5U2aiGes5SDDt8L5Ld6vOLLHfwgmQEAIJsjgIr3JCFEvBQidjQjLrOvLaeG
         nuz08QDD1+u1/1rB2NI5RZsufXulW3Zf9eAmgXzpRcA2d94ETiaosy+RpJuCDqUAnBzH
         1skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeBGSFa6JpLDSEOobydkMfjCm7xXfWYBIoiGgmJvsiY=;
        b=HZ4CgJWBWKPDutssWrk/cqrf2lgJQYYcjvbZTXNxfGY6yNY9txH+JsZwwUfPt5eH6v
         NnnKR9d7s4chI/x4MQpJmUdCXbNA9t7MMc5ptNEiEsjJHixj7WIiNJTOPTAZv9XTyNI5
         ryuLoer4ZaYrcFYGbAhwTGSgv3aOZ8fIkSpqdHnB+XZwHbKkVQC8mJeDMspeALDDQNKa
         zkeGHSfNJLg4JxDkwbmbWv73DgSsLv5n8+OkEyHZVz6j8x64FWlPgYe7N9f8+Ub79j29
         Uz2VVYIAP+DRRG2eVLMHxrJ19lZvB4IexrnqAjfBaw9gnT5sh9Nxo0fWlxLTN+QhdsYy
         K9zQ==
X-Gm-Message-State: AOAM533nRYKSSrt8BIZvtsL2jzozQBNA+fXuSN9ij03f2IydE8Vb8jw7
	PXFn+eSKy2brcOjQtYO2e+iwyAjifJx40R0lTYZA+w==
X-Google-Smtp-Source: ABdhPJyl6xq9PxhonQS0J3Dx+J5gbm1PIhxGa1brPjByYujkui0S6cvVgDWfdJGYhmVAV084h8/4qpdI7H3iU+5xBUo=
X-Received: by 2002:ac8:396c:: with SMTP id t41mr71181576qtb.45.1594389627173;
 Fri, 10 Jul 2020 07:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200710031619.18762-1-justin.he@arm.com>
In-Reply-To: <20200710031619.18762-1-justin.he@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jul 2020 07:00:15 -0700
Message-ID: <CAPcyv4izHex9W0m3voSXM5J69gFWhHj_a-XsmJ4HF01Uh4jp6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix and enable pmem as RAM device on arm64
To: Jia He <justin.he@arm.com>
Message-ID-Hash: 35JJTTUW4CJJPOZWJM3UG6YSQDVGBP7W
X-Message-ID-Hash: 35JJTTUW4CJJPOZWJM3UG6YSQDVGBP7W
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org
 >, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/35JJTTUW4CJJPOZWJM3UG6YSQDVGBP7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 9, 2020 at 8:17 PM Jia He <justin.he@arm.com> wrote:
>
> This fixies a few issues when I tried to enable pmem as RAM device on arm64.
>
> To use memory_add_physaddr_to_nid as a fallback nid, it would be better
> implement a general version (__weak) in mm/memory_hotplug. After that, arm64/
> sh/s390 can simply use the general version, and PowerPC/ia64/x86 will use
> arch specific version.
>
> Tested on ThunderX2 host/qemu "-M virt" guest with a nvdimm device. The
> memblocks from the dax pmem device can be either hot-added or hot-removed
> on arm64 guest. Also passed the compilation test on x86.
>
> Changes:
> v4: - remove "device-dax: use fallback nid when numa_node is invalid", wait
>       for Dan Williams' phys_addr_to_target_node() patch

FWIW, I put these patches through a 0-day run overnight and will be
posting them today.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
