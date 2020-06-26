Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B020B37B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 16:22:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A87E10FE0425;
	Fri, 26 Jun 2020 07:22:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.65; helo=mail-ot1-f65.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C378210FE0421
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 07:22:26 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id n24so6516768otr.13
        for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 07:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zylLUqnkdMrer9YoBeoJCoYKdCDB3D8ttj9vwr5OJtU=;
        b=Sc4MIjuCHD6RuzOxKnjYXV5A0PuYswsP+I7GK2EgcjENVYJzD+2f04ODN6gip0m0gu
         fiwXYGjMW6f39BQOyBCfdmUk2fsC6bfgK/g1j+gXEa/uLn/OMc7RBR2/0Zw4gvTbLKr8
         shB5SCyu0qon6Gj28y/KxKKNwGtqJpGm9qoGmFZawKhqAajULHmnmm4sFetz3znNAeLH
         Zcc6hA7eIi4t2yK2pEtURcf4LjfbleI8dqW52BG3UtP4ZQKO1uYnk9NsECBGz/qxRuCH
         I4E54GceArwd4crbkxWZtTf4ys6QIcFxP/Uhb+y3iz86h6BYBGmiNEIWJNuygJFhy3ge
         ublA==
X-Gm-Message-State: AOAM533xXyZXJRc+4oxDIr4F+AIawaVWWqlugX04kuvE4v5MQrvgJkIK
	4e7NBVkj7h5kSS5EQC2ebgWm96qkHdCMFwEZ7Ug=
X-Google-Smtp-Source: ABdhPJwlqOmcvg/6oi2GQiPpb1emiKe3h/g+UPnIZRd8AgaCMf8EtxE5eGtW9wxjDO0n2al1FmoCDRJ0clqbo+lCNqY=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr2546864otn.118.1593181345873;
 Fri, 26 Jun 2020 07:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jun 2020 16:22:14 +0200
Message-ID: <CAJZ5v0h8Eg5_FVxz0COLDMK8cy72xxDk_2nFnXDJNUY-MvdBEQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] ACPI/NVDIMM: Runtime Firmware Activation
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: CRNEZN4RHG4QKGL2S7C7XG5F6PFPUXQW
X-Message-ID-Hash: CRNEZN4RHG4QKGL2S7C7XG5F6PFPUXQW
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Stable <stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CRNEZN4RHG4QKGL2S7C7XG5F6PFPUXQW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 26, 2020 at 2:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Quoting the documentation:
>
>     Some persistent memory devices run a firmware locally on the device /
>     "DIMM" to perform tasks like media management, capacity provisioning,
>     and health monitoring. The process of updating that firmware typically
>     involves a reboot because it has implications for in-flight memory
>     transactions. However, reboots are disruptive and at least the Intel
>     persistent memory platform implementation, described by the Intel ACPI
>     DSM specification [1], has added support for activating firmware at
>     runtime.
>
>     [1]: https://docs.pmem.io/persistent-memory/
>
> The approach taken is to abstract the Intel platform specific mechanism
> behind a libnvdimm-generic sysfs interface. The interface could support
> runtime-firmware-activation on another architecture without need to
> change userspace tooling.
>
> The ACPI NFIT implementation involves a set of device-specific-methods
> (DSMs) to 'arm' individual devices for activation and bus-level
> 'trigger' method to execute the activation. Informational / enumeration
> methods are also provided at the bus and device level.
>
> One complicating aspect of the memory device firmware activation is that
> the memory controller may need to be quiesced, no memory cycles, during
> the activation. While the platform has mechanisms to support holding off
> in-flight DMA during the activation, the device response to that delay
> is potentially undefined. The platform may reject a runtime firmware
> update if, for example a PCI-E device does not support its completion
> timeout value being increased to meet the activation time. Outside of
> device timeouts the quiesce period may also violate application
> timeouts.
>
> Given the above device and application timeout considerations the
> implementation defaults to hooking into the suspend path to trigger the
> activation, i.e. that a suspend-resume cycle (at least up to the syscore
> suspend point) is required.

Well, that doesn't work if the suspend method for the system is set to
suspend-to-idle (for example, via /sys/power/mem_sleep), because the
syscore callbacks are not invoked in that case.

Also you probably don't need the device power state toggling that
happens during regular suspend/resume (you may not want it even for
some devices).

The hibernation freeze/thaw may be a better match and there is some
test support in there already that may be kind of co-opted for your
use case.

Cheers!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
