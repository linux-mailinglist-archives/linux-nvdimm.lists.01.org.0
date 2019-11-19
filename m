Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8926100FA8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Nov 2019 01:04:23 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36768100DC431;
	Mon, 18 Nov 2019 16:05:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B7128100DC42F
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 16:05:14 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o12so7033266oic.9
        for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 16:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtbvKjjnscKy4A6MuNeD3a3NFthr68OtKoL8RB+WxNo=;
        b=OwqIclI3keeY7VHTJMp42XcFMnSTpvkqGJgi1VHbv9P05zsqk7I4qEew1vlPCtyxE6
         NtIAzveBsEu4kp70hWM+c+0r8DFE2JfAuqsFbN0yMpKcYrac8GPNaBuUxFR2EypImxtG
         TbR3Gp8qoV/FATMkEKzlAggAnAqeHJJgJMZccBlQX3YSC1H5g1ptRg934gVSvL4odkQm
         wN0l/Z3VtNzyskVviilqa+8hpfN1DGw5KiJZiWyXEP/sX3mSW9PujfWr8BAiH/OJoUMU
         BEXRq1HBY8xK18/ZQAcIxHS4HLunPih16a070i5KPwuvbR2SMnxCy8MdUDiXvgBRovMR
         2nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtbvKjjnscKy4A6MuNeD3a3NFthr68OtKoL8RB+WxNo=;
        b=ttwGqT2YHmOsFbDyWnKmKjGHn/0AgD1qcZRKLg600lL4LsU8JaFYv15M/qxVwhQME/
         HdEqJregxMWc4pmlRhEKNLtIYIh0B//EV526K0mtNWZh3CGcU+WfRCoQgXV+91LYRtEe
         /UaaAL4AJcuxDHPg/ZBPrFVZMWOWFz9TY4ZwayHNP/tI8kh8ITG4SxIN8Jj3qSeCYrhB
         ynXQk5EJ/xOmhAvVPZVmx+lFTxmzT6f8mLuqpd3z/FeOpDjokDjgrjEVj8P8ldp/UKbR
         nNHVxVwhsHWctfStJnixnb5tlBtzVRY7vRq19WPRFRNPPPIRRtMOpwwUmqSHB2Gmmx8G
         V7aA==
X-Gm-Message-State: APjAAAWg0pNtT7bFy1aJU315gVyF/n7JAwblMIJjUC6pzxrBOWKoWZym
	xUBTNty0mKifTdxxlrgW56Myt5XDukKA2IgsAGJ9Vw==
X-Google-Smtp-Source: APXvYqyHTRHOCdWxsyyF+07+0YV81ecwmO5E2eDEN7/DauYrZtLt+iJnkG3Op6xVtOT1jIhYYt8wSLdsK2pfoAPRMRw=
X-Received: by 2002:aca:ea57:: with SMTP id i84mr1382576oih.73.1574121858711;
 Mon, 18 Nov 2019 16:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com> <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
 <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
In-Reply-To: <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 Nov 2019 16:04:07 -0800
Message-ID: <CAPcyv4hDxeJo-i9FG=JBhaK3awjm3cN_MNvdO_7Z=9bJT9wsGw@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To: Andrew Donnellan <ajd@linux.ibm.com>
Message-ID-Hash: KQGGFTXYZUOLHUYDGC5WGCCIJWZUER4L
X-Message-ID-Hash: KQGGFTXYZUOLHUYDGC5WGCCIJWZUER4L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Frederic Barrat <fbarrat@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@lin
 ux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KQGGFTXYZUOLHUYDGC5WGCCIJWZUER4L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2019 at 3:48 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>
> On 15/11/19 3:35 am, Dan Williams wrote:
> >> Have you discussed with the directory owner if it's ok to split the
> >> driver over several files?
> >
> > My thought is to establish drivers/opencapi/ and move this and the
> > existing drivers/misc/ocxl/ bits there.
>
> Is there any other justification for this we can think of apart from not
> wanting to put this driver in the nvdimm directory? OpenCAPI drivers
> aren't really a category of driver unto themselves.

The concern is less about adding to drivers/nvdimm/ and more about the
proper location to house opencapi specific transport and enumeration
details. The organization I'm looking for is to group platform
transport and enumeration code together similar to how drivers/pci/
exists independent of all pci drivers that use that common core. For
libnvdimm the enumeration is platform specific and calls into the
nvdimm core. This is why the x86 platform persistent memory bus driver
lives under drivers/acpi/nfit/ instead of drivers/nvdimm/. The nfit
driver is an ACPI extension that translates ACPI details into
libnvdimm core objects.

The usage of "ocxl" in the source leads me to think part of this
driver belongs in a directory that has other opencapi specific
considerations.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
