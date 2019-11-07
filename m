Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A9F2E66
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 13:47:13 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 481DF100DC3F9;
	Thu,  7 Nov 2019 04:49:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.193; helo=mail-oi1-f193.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2B0B100EA61D
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 04:49:35 -0800 (PST)
Received: by mail-oi1-f193.google.com with SMTP id j7so1838455oib.3
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 04:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJ+XM7e35yl7YewLYP0iJjwmpEainWYQoTZVXoXrUd0=;
        b=dZ6mEJky1BtTMluAnkfvhnJKGwmLDe928bVI9EbU2fnhq4iaX/6anp8togN5c5ERlF
         vUEyTLaAZ66q7lhKnddrYAvDNoA5pX+tEbjA1b+I53F9SCc74aCeFB9vqg+yvs6NcxO0
         1/xykLbSts589RgwV+q0XPVEi2JLUVK0kM9zsTBYSaG6HZ4E0e0FV0YUlhFKzY4U1sma
         7S9xo9esO5LoxfgzRlSpehpndDq50U41DV1Po/iusxMK32IL1Gqn/s2I94wYtNMIGVI7
         t54J00QgIf3M0MfNG3JNWbVYKZm9krHRQVaM4lt4jdSniKCyM/Dqyrw8wBDjxaFOcv4K
         D0Hw==
X-Gm-Message-State: APjAAAXvTKJzdfMgafNq+sYiNFHxM+mbSCEQoOoZARSt1+stxJGKRX1b
	Ka3A5HU7h6b2lDSxU4SdLuR/ThkqC5C9RCiXOeo=
X-Google-Smtp-Source: APXvYqzlr7almGaTB4dbuD39z3gB6B3WnVS7o80LQ8cjmDZcFRCmiHdFTDSP/fLzfS2WS0wlNj1lXp3k4W0jsLB7Yc8=
X-Received: by 2002:aca:1101:: with SMTP id 1mr3414464oir.103.1573130827691;
 Thu, 07 Nov 2019 04:47:07 -0800 (PST)
MIME-Version: 1.0
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Nov 2019 13:46:54 +0100
Message-ID: <CAJZ5v0hDaxcPBwwx2FaxKKJGNOvY_+JuvF7CJ0tbX1TjEisvUQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] EFI Specific Purpose Memory Support
To: Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@redhat.com>
Message-ID-Hash: 2YEZVJKOHBBJELA5CKPDDKTKHH3SPH56
X-Message-ID-Hash: 2YEZVJKOHBBJELA5CKPDDKTKHH3SPH56
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Shevchenko <andy@infradead.org>, Borislav Petkov <bp@alien8.de>, Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, kbuild test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-efi <linux-efi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2YEZVJKOHBBJELA5CKPDDKTKHH3SPH56/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 2:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v7:
> - This is mostly a resend to get it refreshed in Ingo's inbox for v5.5
>   consideration. It picks up a Reviewed-by on patch4 from Ard, has a
>   minor cosmetic rebase on v5.4-rc6 with no other changes, it merges
>   cleanly with tip/master, and is still passing the test case described in
>   the final patch, but development is otherwise idle over the past 3
>   weeks.
>
> [1]: https://lkml.kernel.org/r/157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> ---
> Merge notes:
>
> Hi Ingo,
>
> This is ready to go as far as I'm concerned. Please consider merging, or
> acking for Rafael to take, or of course naking if something looks off.
> Rafael had threatened to start taking the standalone ACPI bits through
> his tree, but I have yet to any movement on that in his 'linux-next' or
> 'bleeding-edge' tree.

Indeed.

I have waited for comments on x86 bits from Thomas, but since they are
not coming, I have just decided to take patch [1/12] from this series,
which should be totally non-controversial,  as keeping it out of the
tree has become increasingly painful (material depending on it has
been piling up already for some time).

If need be, I can expose that commit in an immutable branch, so please
let me know if that's necessary.

BTW, Dan, I think that it was a mistake to make the rest of your
series depend on that patch.  The new directory could have been
created at any convenient time later.

Cheers,
Rafael
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
