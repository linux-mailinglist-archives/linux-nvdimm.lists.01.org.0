Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D230D00C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 00:57:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECE78100EAB53;
	Tue,  2 Feb 2021 15:57:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83DE3100EAB51
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 15:57:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p20so13429619ejb.6
        for <linux-nvdimm@lists.01.org>; Tue, 02 Feb 2021 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ei7hzPsgvHgxY53PqUfsTxtC6XeuV2PKdJfigEzcdI=;
        b=mzBF5mEs8+7DFtT3HTRtRwBqdt+He1ge0SMWWG8XkrU4j3buin9RWxFI80NU1dbq/R
         /WLbqer0SbWlVjMvaJu8gx57DMPD9tzGQQF+a3hKcNHSjouwn82qB4ZWZcmbSuMgp9QE
         9S6NwSapDuZl2RcO5BNqKzDgJeGii59VEjCP8ylXYrcdeS2mK8609qBkeYKPEA85A/XM
         3Rd5vrV43Hxg2OmRr6UcKmh+9goio20mf2HCQz2M2p0H1sRaYgxs3Q/lCUojUG+I8kWT
         pxnhEpwitUxifLzlm2ksMzc+MnXqrZGtV0guUtXY0v4eLpikf6uL5iOMNfwyslLvg+36
         Ztvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ei7hzPsgvHgxY53PqUfsTxtC6XeuV2PKdJfigEzcdI=;
        b=ocIWz+v2wCaoj+tkMctmhGjKneKdsSpRkDenbAuOW6Nu4QCNIKBukZ5rH+g/UIqtyE
         2lKo/sf4Gz0f4fQ+8dJcFiIdtHratESFVMGhCA4/6qW/E009nNdjSA+qr/464a/V8FS9
         FCHrFpdqff+gAcoNQyNsVl4pfciC3xn9HVroTJUpBCPUHbNwWOdreUnVnP0YCEBf8geX
         TEaZH3Dbroprkg3Vsz0ZK0PMp506cN2wrwA+wx3CjnOChMWqDMG3d4wbMj+taCVZJICB
         jFw9yaGiKBu1WWemMlbl3Od0Az4cg/OtMeYOQaTodskBsGFzhnWyURXmEIlsc/cTY4jR
         Q7qQ==
X-Gm-Message-State: AOAM533HsM7TnFqEpKb+bRQulknJuhpLjidVBg7UlL7HiZStzP0QbK5D
	wEth6x4dZGy2FbJgeZqBf8fXRfp+xPooY2+OceIBdg==
X-Google-Smtp-Source: ABdhPJzuqtFYxd9D7t5y31bMs8ikTlJEE9y04BxTxSW9gyQdaL5YEXOIHpBRxrY3j9MA0Fe049i291NZnJ64txyck0M=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr440588ejb.523.1612310224889;
 Tue, 02 Feb 2021 15:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com> <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
In-Reply-To: <20210202235103.v36v3znh5tsi4g5x@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 2 Feb 2021 15:57:03 -0800
Message-ID: <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
To: Ben Widawsky <ben.widawsky@intel.com>
Message-ID-Hash: ZEDXRIDEV3VB7D6BZFBLZSCMM6ASZRDN
X-Message-ID-Hash: ZEDXRIDEV3VB7D6BZFBLZSCMM6ASZRDN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZEDXRIDEV3VB7D6BZFBLZSCMM6ASZRDN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > The Get Log command returns the actual log entries that are advertised
> > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > by UUID which is part of the CXL spec. Because the driver tries to
> > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > types of logs which can be accessed by userspace. For example, the
> > > vendor specific log might only be consumable by proprietary, or offline
> > > applications, and therefore a good candidate for userspace.
> > >
> > > The current driver infrastructure does allow basic validation for all
> > > commands, but doesn't inspect any of the payload data. Along with Get
> > > Log support comes new infrastructure to add a hook for payload
> > > validation. This infrastructure is used to filter out the CEL UUID,
> > > which the userspace driver doesn't have business knowing, and taints on
> > > invalid UUIDs being sent to hardware.
> >
> > Perhaps a better option is to reject invalid UUIDs?
> >
> > And if you really really want to use invalid UUIDs then:
> >
> > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> >
> > 2) Wrap it with lockdown code so that you can't do this at all
> >    when in LOCKDOWN_INTEGRITY or such?
> >
>
> The commit message needs update btw as CEL is allowed in the latest rev of the
> patches.
>
> We could potentially combine this with the now added (in a branch) CONFIG_RAW
> config option. Indeed I think that makes sense. Dan, thoughts?

Yeah, unknown UUIDs blocking is the same risk as raw commands as a
vendor can trigger any behavior they want. A "CONFIG_RAW depends on
!CONFIG_INTEGRITY" policy sounds reasonable as well.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
