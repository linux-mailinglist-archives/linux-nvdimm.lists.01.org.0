Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0630B1FC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 22:20:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B0C7100EA903;
	Mon,  1 Feb 2021 13:20:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E53FA100EA900
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 13:20:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kg20so26658386ejc.4
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 13:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKV8tfXM/P2yr23U8IrmSV+OjOgK46IvUPsK7p0jMgk=;
        b=jZLlF1BLcZiQNvZuriBZtAzF6XOXuBz6zZN01Lb11NP+6NRYwxYB0ZMdTbEIExzDKb
         r/gC0LbZUA18tkBHhoxigMtqVYDxB4j+RWtLlmqHfDvcPVcvDdr3AUlNiqW2LxbOfb3O
         +V+GSB9O1BjCxxSnLTCxG8gvlUz2B5Itq3vnR+d9KT98zWWMdBnlW1/DAzbz4ulPCc4G
         nq+Wrn51F//JFhDa2w3l398dovOGhgDJhWKfhYV/ofnLxv7doKXgn3rI+ESCn2v5Ofq9
         ZecFkI5v7FgvOkds/8sJojnO2M7YKnUAbPpdVdFqGTVqquOyo2GU3ijaFXNzoa5HRNf0
         nLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKV8tfXM/P2yr23U8IrmSV+OjOgK46IvUPsK7p0jMgk=;
        b=MDnRVMh84tYP1qgxsNkmtoyTXcaczxdAaEJhOybhyIFSvfXkxqYvRnP4kZS3sm7Ga4
         oqVQhXp3PVZ35p7c7Lt8QBf81bmEIX5htxS3SdY5m/y2BcBCpZgC21P5zTun+jVL/DpT
         PwdKNkwMKq/bBSxy3BECPEj4K1sDOI8RXOFENMUBxnk/+OvxMWjySsjDC0Cl+fMdHDQ5
         3BdXKPByVqPuIoHIw6iVgxGugZOsOf7N5nfm0EPIvLnDu5nYQsOc8KEEVtjU7gEFJSPc
         ZOIvzoch2T1iShfQsBBKVsr2UFpDaaj8JJOlfyMhXR4nsAwct/VO4Cx7ThmP87PyW9Gy
         0UHQ==
X-Gm-Message-State: AOAM533e0yw7YaaVW8/+2rI8IHhFJZID8LbnwrENYywFuM9Md9IDC+qJ
	HEAOL1GE/NlLpnRzTSaSxMldnZRipzvjKh59lJBmMA==
X-Google-Smtp-Source: ABdhPJwA3l0e3MUGip6gEtrbLA1M+onIFo5pqjzQ23LyigVAMvz9JEe/SBsagHRrDaseCVuas2GfBzS5C8qSA8H7dF0=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr20142627ejb.323.1612214417615;
 Mon, 01 Feb 2021 13:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-10-ben.widawsky@intel.com> <20210201182400.GK197521@fedora>
 <20210201192708.5cvyecbcdrwx77de@intel.com> <20210201193453.GA308086@fedora>
In-Reply-To: <20210201193453.GA308086@fedora>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Feb 2021 13:20:14 -0800
Message-ID: <CAPcyv4hivzQh=rresymO+fRP2g1LLJzEr2d7Or6Pha7V_1L6Pg@mail.gmail.com>
Subject: Re: [PATCH 09/14] cxl/mem: Add a "RAW" send command
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID-Hash: Q46AC5NB4KPW7SP66CK3VWEUMUJUHHIM
X-Message-ID-Hash: Q46AC5NB4KPW7SP66CK3VWEUMUJUHHIM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q46AC5NB4KPW7SP66CK3VWEUMUJUHHIM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 1, 2021 at 11:36 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Mon, Feb 01, 2021 at 11:27:08AM -0800, Ben Widawsky wrote:
> > On 21-02-01 13:24:00, Konrad Rzeszutek Wilk wrote:
> > > On Fri, Jan 29, 2021 at 04:24:33PM -0800, Ben Widawsky wrote:
> > > > The CXL memory device send interface will have a number of supported
> > > > commands. The raw command is not such a command. Raw commands allow
> > > > userspace to send a specified opcode to the underlying hardware and
> > > > bypass all driver checks on the command. This is useful for a couple of
> > > > usecases, mainly:
> > > > 1. Undocumented vendor specific hardware commands
> > > > 2. Prototyping new hardware commands not yet supported by the driver
> > >
> > > This sounds like a recipe for ..
> > >
> > > In case you really really want this may I recommend you do two things:
> > >
> > > - Wrap this whole thing with #ifdef
> > >   CONFIG_CXL_DEBUG_THIS_WILL_DESTROY_YOUR_LIFE
> > >
> > >  (or something equivalant to make it clear this should never be
> > >   enabled in production kernels).
> > >
> > >  - Add a nice big fat printk in dmesg telling the user that they
> > >    are creating a unstable parallel universe that will lead to their
> > >    blood pressure going sky-high, or perhaps something more professional
> > >    sounding.
> > >
> > > - Rethink this. Do you really really want to encourage vendors
> > >   to use this raw API instead of them using the proper APIs?
> >
> > Again, the ideal is proper APIs. Barring that they get a WARN, and a taint if
> > they use the raw commands.
>
> Linux upstream is all about proper APIs. Just don't do this.
> >
> > >
> > > >
> > > > While this all sounds very powerful it comes with a couple of caveats:
> > > > 1. Bug reports using raw commands will not get the same level of
> > > >    attention as bug reports using supported commands (via taint).
> > > > 2. Supported commands will be rejected by the RAW command.
> > > >
> > > > With this comes new debugfs knob to allow full access to your toes with
> > > > your weapon of choice.
> > >
> > > Problem is that debugfs is no longer "debug" but is enabled in
> > > production kernel.
> >
> > I don't see this as my problem. Again, they've been WARNed and tainted. If they
>
> Right not your problem, nice.
>
> But it is going to be the problem of vendor kernel engineers who don't have this luxury.
>
> > want to do this, that's their business. They will be asked to reproduce without
> > RAW if they file a bug report.
>
>
> This is not how customers see the world. "If it is there, then it is
> there to used right? Why else would someone give me the keys to this?"
>
> Just kill this. Or better yet, make it a seperate set of patches for
> folks developing code but not have it as part of this patchset.

In the ACPI NFIT driver, the only protection against vendor
shenanigans is the requirement that any and all DSM functions be
described in a public specification, so there is no unfettered access
to the DSM interface However, multiple vendors just went ahead and
included a "vendor passthrough" as a DSM sub-command in their
implementation. The driver does have the "disable_vendor_specific"
module parameter, however that does not amount to much more than a
stern look from the kernel at vendors shipping functionality through
that path rather than proper functions. It has been a source of bugs.

The RAW command proposal Ben has here is a significant improvement on
that status quo. It's built on the observation that customers pick up
the phone whenever their kernel backtraces, and makes it is easy to
spot broken tooling. That said, I think it is reasonable to place the
RAW interface behind a configuration option and let distribution
policy decide the availability.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
