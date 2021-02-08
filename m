Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18BC3143E6
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 00:36:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE260100EC1FA;
	Mon,  8 Feb 2021 15:36:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0B51C100EC1F5
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 15:36:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so21247783eds.12
        for <linux-nvdimm@lists.01.org>; Mon, 08 Feb 2021 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGGcKAyTzmY7XmHqKjg37Fb2afx54tMCqzIlqIxaU7M=;
        b=E5dDhWELy3490cipw2qXqX2bxpHoPiVzQRaR2X4dSFiRqOjLee56yC4S848SYQ7DHE
         TdW2iX6wSAayi8M7TQ5MMi4LhfUPROW4AZ6ZZOqjJFTYTE5q5E4sV/GibnBSH8lySu0y
         Uyvf6SQAxXS7uRrtKj3agOmXXQYr2c5xv+HgO5WxwAvRmw/+0NiQSSyWhVntPGknaeyA
         2q042JtRZZZYrxE5qrQYldeSgOlG0x2U0IaHs3AwcLCd7L5nOVh3ATxC4Zkpls71QW8X
         iF7cHXO4b5hDGaLJSd8+KCt2uoywgyj2XpoqdNsGqaqAxuWIKViVqb100OOjUtUyje0Z
         k2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGGcKAyTzmY7XmHqKjg37Fb2afx54tMCqzIlqIxaU7M=;
        b=G/IVd1o/THJBLz1b5d0NEGAZVGLg0JRf6csQQNc1d3cbcNbt50lbxxCfAqRMut6bkm
         8V9BrRaMP+l2hr6xp7h5RubPUhn8fTHqvV5+4zXx4srhU5x0jrjAN0MgPO0bGVi7JPBx
         v6tUtgc9RML1PrNeTX4K5Jp8HnOuJ8bOF0xQuLSyvqMbvxgcVGzGNpiY5kqS3D76sGxs
         iTraQ96wg9LwMCCVAGHlE76hkK1xBmARScZ+XukB0Iie91cMmNiMkzq/1CU2k+SQtMIs
         HFHnnL7IXkAzMUlDl1RE5lkC0aCOw13J3Omh11bK1ptsAvVY3E0ZjbCDPDK96rT2IkJ7
         s/1w==
X-Gm-Message-State: AOAM53370YwmkkVHDyx3YExzR/m/1hc4wFruqf8fLTqCDv2ROleJM0Tq
	KtE54lb2q9HFypt+40dKv68LR/XxqoqutcOeWJsFKQ==
X-Google-Smtp-Source: ABdhPJy9ZjJZRXDvIzBmNSGdGKMoO79oPi5SonIYHgHcEcFwYmkhh/wOyEJYChGVMiInUvinect2p135EQFvnomUZL4=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr20441251edv.210.1612827408336;
 Mon, 08 Feb 2021 15:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com> <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
 <202102081406.CDE33FB8@keescook>
In-Reply-To: <202102081406.CDE33FB8@keescook>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 8 Feb 2021 15:36:35 -0800
Message-ID: <CAPcyv4ix=zmQdb5sFKN-9wOZFnitHN0sSwHZJgQeaEM+=6+W1w@mail.gmail.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
To: Kees Cook <keescook@chromium.org>
Message-ID-Hash: UWEXI4GAOVRBO2X4TK4HF4YWZPFAJIT4
X-Message-ID-Hash: UWEXI4GAOVRBO2X4TK4HF4YWZPFAJIT4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UWEXI4GAOVRBO2X4TK4HF4YWZPFAJIT4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 8, 2021 at 2:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 08, 2021 at 02:00:33PM -0800, Dan Williams wrote:
> > [ add Jon Corbet as I'd expect him to be Cc'd on anything that
> > generically touches Documentation/ like this, and add Kees as the last
> > person who added a taint (tag you're it) ]
> >
> > Jon, Kees, are either of you willing to ack this concept?
> >
> > Top-posting to add more context for the below:
> >
> > This taint is proposed because it has implications for
> > CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
> > implement memory like DDR would, but unlike DDR there are
> > administrative / configuration commands that demand kernel
> > coordination before they can be sent. The posture taken with this
> > taint is "guilty until proven innocent" for commands that have yet to
> > be explicitly allowed by the driver. This is different than NVME for
> > example where an errant vendor-defined command could destroy data on
> > the device, but there is no wider threat to system integrity. The
> > taint allows a pressure release valve for any and all commands to be
> > sent, but flagged with WARN_TAINT_ONCE if the driver has not
> > explicitly enabled it on an allowed list of known-good / kernel
> > coordinated commands.
> >
> > On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > For drivers that moderate access to the underlying hardware it is
> > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > userspace has done this, the driver can no longer guarantee the sanctity
> > > of either the OS or the hardware. When in this state, it is helpful for
> > > kernel developers to be made aware (via this taint flag) of this fact
> > > for subsequent bug reports.
> > >
> > > Example usage:
> > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > - quux is convinced they really need the fred command.
> > > - xyzzy driver allows quux to frob hardware to initiate fred.
> > >   - kernel gets tainted.
> > > - turns out fred command is borked, and scribbles over memory.
> > > - developers laugh while closing quux's subsequent bug report.
>
> But a taint flag only lasts for the current boot. If this is a drive, it
> could still be compromised after reboot. It sounds like this taint is
> really only for ephemeral things? "vendor shenanigans" is a pretty giant
> scope ...
>

That is true. This is more about preventing an ecosystem / cottage
industry of tooling built around bypassing the kernel. So the kernel
complains loudly and hopefully prevents vendor tooling from
propagating and instead directs that development effort back to the
native tooling. However for the rare "I know what I'm doing" cases,
this tainted kernel bypass lets some experimentation and debug happen,
but the kernel is transparent that when the capability ships in
production it needs to be a native implementation.

So it's less, "the system integrity is compromised" and more like
"you're bypassing the development process that ensures sanity for CXL
implementations that may take down a system if implemented
incorrectly". For example, NVME reset is a non-invent, CXL reset can
be like surprise removing DDR DIMM.

Should this be more tightly scoped to CXL? I had hoped to use this in
other places in LIBNVDIMM, but I'm ok to lose some generality for the
specific concerns that make CXL devices different than other PCI
endpoints.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
