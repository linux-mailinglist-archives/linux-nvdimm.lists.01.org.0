Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DA291480
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Oct 2020 23:01:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98D8F1583F6A6;
	Sat, 17 Oct 2020 14:01:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 894A01583F6A4
	for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 14:01:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u8so8477736ejg.1
        for <linux-nvdimm@lists.01.org>; Sat, 17 Oct 2020 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QU5tUnKrk3cCgEOM6DUuSpHohPcIoidzngrqxPrVqlg=;
        b=ntIAxdfj5B3UZZJPAO3W3zqpuYJdxZe6wmMN+Cg5+tfh5QjsxLbXR5o2amfdJQ2J48
         +r9G2vZiMs4S/e6t6kNU+/1RisTXP2Yspklt8lksB4PhSQjsUISEYusYJeN2p0XCHoqr
         5tX/QI+fZe3GQZJaviemAIYQlGxoIFC7s6aX8R5MJQLi2SOYJ/keQbrc62HNUeJ8pCOI
         7WYztP0OE4axPIRoGDfVK4aq4k9dPY6fZ69Y4fL3/a70qb0GrKtNhloBSbp9yIhwtpgg
         UECkhdkcAFyI2jUc3qFZfU7NKoc+E1dZJHZxhONiRQFFV//aVnbaYjp+hfJUaNjfh3TU
         ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QU5tUnKrk3cCgEOM6DUuSpHohPcIoidzngrqxPrVqlg=;
        b=MAp9iTOBP68YLgtCPEs4dcWpr/5VpFtM7V6kGSwgIPkmVScn7vPXXQPDwvCyvtjrsn
         NYAw4zRhO34hpElbEDMXUCCBZfmK04Ku+OB/0Uzig9G5uuXfBfKUaTUpXO85IfXK6cCM
         tQCqw0x/tQlLK3bIyG6AU0+Ngt3GZmakInzmU/sMy+NzaQv56SCsHCaocvDPMcfnX7uC
         YAG2tk5OELy3onbW/nwlF87YtD7c3KKK50dxOMF65pHXAGcQwseKMWI5/9w/ZSDujV8v
         60NT2IklyaHzS8ho87qfobOz1jtbeBWWeDQr130KEymm3AzLijUnDtyENH9S3fcQWb3s
         a83g==
X-Gm-Message-State: AOAM530ks6+1VTLgo5EygwvHlBsqPcI+M449whTmxPMjIGuKDvc0m9Xn
	qotQQ5gqBCMwtxcHurHDNaSAEAVQFQxIvMQNNO/FGA==
X-Google-Smtp-Source: ABdhPJzde2s6j/g/ekBLPPrgSH2EJqfd3KSDRuhe3Mnzr9w98lVRa6HniOngGCyhNuV4q/eDk1HFvyy/v8IqyEanGTA=
X-Received: by 2002:a17:906:1a19:: with SMTP id i25mr9957370ejf.323.1602968492144;
 Sat, 17 Oct 2020 14:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com>
In-Reply-To: <20201017160928.12698-1-trix@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 17 Oct 2020 14:01:22 -0700
Message-ID: <CAPcyv4jkSFxMXgMABX7sDbwmq8zJO=rLX2ww3Y9Tc0VAANY8xQ@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: trix@redhat.com
Message-ID-Hash: EP4YWZN247LRPNH6LXEBSBPSRBP25P7G
X-Message-ID-Hash: EP4YWZN247LRPNH6LXEBSBPSRBP25P7G
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, linux-block@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-crypto <linux-crypto@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, industrypack-devel@lists.sourceforge.net, "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, MPT-FusionLinux.pdl@broadcom.com, linux-scsi <linux-scsi@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>
 , intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org, Linux Wireless List <linux-wireless@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com, storagedev@microchip.com, devel@driverdev.osuosl.org, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, usb-storage@lists.one-eyed-alien.net, linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com, bpf@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, alsa-devel@alsa-project.org, clang-built-linux <clang-built-linux@googlegroups.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EP4YWZN247LRPNH6LXEBSBPSRBP25P7G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Oct 17, 2020 at 9:10 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> This is a upcoming change to clean up a new warning treewide.
> I am wondering if the change could be one mega patch (see below) or
> normal patch per file about 100 patches or somewhere half way by collecting
> early acks.
>
> clang has a number of useful, new warnings see
> https://clang.llvm.org/docs/DiagnosticsReference.html
>
> This change cleans up -Wunreachable-code-break
> https://clang.llvm.org/docs/DiagnosticsReference.html#wunreachable-code-break
> for 266 of 485 warnings in this week's linux-next, allyesconfig on x86_64.
>
> The method of fixing was to look for warnings where the preceding statement
> was a simple statement and by inspection made the subsequent break unneeded.
> In order of frequency these look like
>
> return and break
>
>         switch (c->x86_vendor) {
>         case X86_VENDOR_INTEL:
>                 intel_p5_mcheck_init(c);
>                 return 1;
> -               break;
>
> goto and break
>
>         default:
>                 operation = 0; /* make gcc happy */
>                 goto fail_response;
> -               break;
>
> break and break
>                 case COLOR_SPACE_SRGB:
>                         /* by pass */
>                         REG_SET(OUTPUT_CSC_CONTROL, 0,
>                                 OUTPUT_CSC_GRPH_MODE, 0);
>                         break;
> -                       break;
>
> The exception to the simple statement, is a switch case with a block
> and the end of block is a return
>
>                         struct obj_buffer *buff = r->ptr;
>                         return scnprintf(str, PRIV_STR_SIZE,
>                                         "size=%u\naddr=0x%X\n", buff->size,
>                                         buff->addr);
>                 }
> -               break;
>
> Not considered obvious and excluded, breaks after
> multi level switches
> complicated if-else if-else blocks
> panic() or similar calls
>
> And there is an odd addition of a 'fallthrough' in drivers/tty/nozomi.c
[..]
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 5a7c80053c62..2f250874b1a4 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -200,11 +200,10 @@ ssize_t nd_namespace_store(struct device *dev,
>                 }
>                 break;
>         default:
>                 len = -EBUSY;
>                 goto out_attach;
> -               break;
>         }

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
