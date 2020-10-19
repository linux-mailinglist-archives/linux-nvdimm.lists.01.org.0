Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85410292E94
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Oct 2020 21:42:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7653A15BF03F1;
	Mon, 19 Oct 2020 12:42:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B01CC159BD098
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 12:42:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lw2so370056pjb.3
        for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
        b=vqIoQqfPtCUD7ceHGEmbvFqqUZd/9dE0IpLQQ4p4nyONBXQMSFxBG5OzgCaJfT8eu8
         Ez0DMwUntzcU9c2WJzs/WqMvxG3bzlj0mstlcz+E4fW0gt02sZNjrL1HdU6SHVwmCE5R
         WFeHYzJRJuPZspqj8YJ2wlUmUN4Mc8MNrI6kLekCJ8yejCepkvkgEUeb7TbpDze1NnEh
         TP2SjhqdakZDUedR00qYjd62k5W2m7FgfHIpcuS/rhjqMGxVL3Apppn+UDRO/ftdIfoh
         duvoKavmXDacw9mysFV+xdp1Tg4QxCPiDxNSeCeZyO+34Y2S1kYSdX61NJzSKhmGsX5T
         HLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
        b=af3Jy7mbnke/cvYVY1AD5QkvwuaoHOOawxxHRkinTB/pfkcbjaUeMARdY/ucqRQHhI
         Cw4yUgC5o+LSr6AQFJSaGKT6Oty9nijOYi8XPgFZ7hSb48d9RLW0yBQCYXfIcgIl8ttl
         Clf9rVvmVNy6X6cuoj+VpktyLgBhqTwnTY3DxF5SrHpaqSjg8AUzXsIrvLdY5PUXRijW
         b0+9l9GsvKA75QdJ40T8+INqHGb4oqOVfC/Rj7ZBZaEiFItZxnytnbfpNsXscmhP7jvI
         EfVvtuDVbI6mlhhziUAvUXTBacwxS8BfIppyjpAghiPi339h31uPKa69P9D8JZ2O/yIW
         8icg==
X-Gm-Message-State: AOAM532KY65Q+R/266m3O3fqKu6hJFmz/urin/UKLA6f1UDH745nqLtf
	pckIU1UCHUCufqL7FlftKD+NWva5vNDmP6s1V8YXVg==
X-Google-Smtp-Source: ABdhPJxy4K+2uRaBuhFTeTSlHPetqrP1uAAP7dKvm6UBZz10SCa23PJUxb54E5JJmlle9J/y892Qp+TTrKvO4GeNXIk=
X-Received: by 2002:a17:90a:ee87:: with SMTP id i7mr921476pjz.25.1603136546933;
 Mon, 19 Oct 2020 12:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com> <20201018054332.GB593954@kroah.com>
In-Reply-To: <20201018054332.GB593954@kroah.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 19 Oct 2020 12:42:15 -0700
Message-ID: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Tom Rix <trix@redhat.com>
Message-ID-Hash: F74YGQO55KY2J5O7XTQQ45GW7YH3EXVR
X-Message-ID-Hash: F74YGQO55KY2J5O7XTQQ45GW7YH3EXVR
X-MailFrom: ndesaulniers@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, openipmi-developer@lists.sourceforge.net, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, industrypack-devel@lists.sourceforge.net, linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>, intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org, linux-wireless <linu
 x-wireless@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com, storagedev@microchip.com, devel@driverdev.osuosl.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com, bpf <bpf@vger.kernel.org>, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, alsa-devel@alsa-project.org, clang-built-linux <clang-built-linux@googlegroups.com>, Greg KH <gregkh@linuxfoundation.org>, George Burgess <gbiv@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F74YGQO55KY2J5O7XTQQ45GW7YH3EXVR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2020 at 10:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > This is a upcoming change to clean up a new warning treewide.
> > I am wondering if the change could be one mega patch (see below) or
> > normal patch per file about 100 patches or somewhere half way by collecting
> > early acks.
>
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.
>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...

Tom,
If you're able to automate this cleanup, I suggest checking in a
script that can be run on a directory.  Then for each subsystem you
can say in your commit "I ran scripts/fix_whatever.py on this subdir."
 Then others can help you drive the tree wide cleanup.  Then we can
enable -Wunreachable-code-break either by default, or W=2 right now
might be a good idea.

Ah, George (gbiv@, cc'ed), did an analysis recently of
`-Wunreachable-code-loop-increment`, `-Wunreachable-code-break`, and
`-Wunreachable-code-return` for Android userspace.  From the review:
```
Spoilers: of these, it seems useful to turn on
-Wunreachable-code-loop-increment and -Wunreachable-code-return by
default for Android
...
While these conventions about always having break arguably became
obsolete when we enabled -Wfallthrough, my sample turned up zero
potential bugs caught by this warning, and we'd need to put a lot of
effort into getting a clean tree. So this warning doesn't seem to be
worth it.
```
Looks like there's an order of magnitude of `-Wunreachable-code-break`
than the other two.

We probably should add all 3 to W=2 builds (wrapped in cc-option).
I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
follow up on.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
