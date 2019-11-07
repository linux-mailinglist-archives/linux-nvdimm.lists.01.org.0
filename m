Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06612F30EA
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 15:12:19 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DB05100DC3F9;
	Thu,  7 Nov 2019 06:14:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.67; helo=mail-ot1-f67.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B8469100EA61D
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 06:14:40 -0800 (PST)
Received: by mail-ot1-f67.google.com with SMTP id f10so2125151oto.3
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 06:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWWfquVvfscWRLHvr28HN8i4Fy/KkuUnhhq0FcZYb0E=;
        b=NM9HeROIwfDOni0zHOLJXOajVGnBu4/saKuMH8kkteFHWY6jsnaj0DtFceIUmA7LjN
         5caoyGuHIVPkJcE59J4+kdbK4JRrrDQ7MHOrrVUjsn7o+fU4jwBNJPLmWeuIjWZ44QE5
         /4iz3FdM40RulRh+/mn4ZXaUlKg939HewuUBDZFpJySEb/oHsKc6XMvZdBKegl/Lsj3z
         Ril3lVFAhDHUyoSg2AqVHyagiTJChgFCly8Mr9fkJar27XA6SI3HVgKEI79cTV+1hWKH
         6kojkvZ75GHOxi02H8DWPI+XYuwXTL+1nA+3SeJtczu0M3GL8AZYJJz+CGM9N4c7LWvh
         Hwlw==
X-Gm-Message-State: APjAAAUXEJww9Y2NId4XVz93CiQRgR6hGR2w5fZXNfQx2raqWquo5yMs
	RDrsqaQ2LTBg4++zu2qYysJfCIql87JjwBndQno=
X-Google-Smtp-Source: APXvYqxu6udHOvBSW/xwAJQXHKIOXHGoAa2IhEo7XpAgPdk3s2N7Ce8so1jz9m3xm7wa8ZRiIeEm/HJSABKwmeMR68s=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr3026793otn.167.1573135933257;
 Thu, 07 Nov 2019 06:12:13 -0800 (PST)
MIME-Version: 1.0
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0hDaxcPBwwx2FaxKKJGNOvY_+JuvF7CJ0tbX1TjEisvUQ@mail.gmail.com> <alpine.DEB.2.21.1911071447090.4256@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911071447090.4256@nanos.tec.linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Nov 2019 15:12:02 +0100
Message-ID: <CAJZ5v0g2PySxpYg_94aFiz+FBdZOvAw8DwR-B47Lx-H50hR2hw@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] EFI Specific Purpose Memory Support
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: 56AJN66WHXAI77PYFDDPQDX375XUQNTH
X-Message-ID-Hash: 56AJN66WHXAI77PYFDDPQDX375XUQNTH
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Shevchenko <andy@infradead.org>, Borislav Petkov <bp@alien8.de>, Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, kbuild test robot <lkp@intel.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-efi <linux-efi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/56AJN66WHXAI77PYFDDPQDX375XUQNTH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 7, 2019 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 7 Nov 2019, Rafael J. Wysocki wrote:
> > On Thu, Nov 7, 2019 at 2:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Indeed.
> >
> > I have waited for comments on x86 bits from Thomas, but since they are
> > not coming, I have just decided to take patch [1/12] from this series,
> > which should be totally non-controversial,  as keeping it out of the
> > tree has become increasingly painful (material depending on it has
> > been piling up already for some time).
>
> Sorry for letting this slip through the cracks.
>
> From x86 side I don't see any issues. It's mostly EFI stuff which Ard has
> looked at already. So feel free to pick up the lot
>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

I will, thank you!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
