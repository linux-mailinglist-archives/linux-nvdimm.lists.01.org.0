Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FA231E76
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 14:21:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4F38126B7ADD;
	Wed, 29 Jul 2020 05:21:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49409126B4C1A
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 05:21:51 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id v21so10056445otj.9
        for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 05:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mnnHyWC547JExbWvUCq+tIdDHLBBpQ7TBTnFeNVHVU=;
        b=Fml2tb3zkW50USukTO2/Fydzhj1gMDatvn/ahVrsq2UtKOszbt7di+L76R9wBXOilZ
         Xb+WDjMkQiyKh00QLwj52QMx82aUseJHbCwjI6qjw18zsJ8IXkshUMTY2IsKczYoDSh2
         MwLFBzAucDWnp/kDD0oDgiM47mvZJdkEXFdraUFYYYHMGVDhkRnAue04ZgqHs5VGeEuc
         Wq14cishbcFtbjcsWJ9EQs7AB6Xr8yhaBus5skYaUxjrBmpdlLsYu8D6XjvHJcd9scZD
         5ztJZ1JF8fK5NxpVI3GgWHtJGxVqTpUhtLLMP1smM3L9Q9eJFY60NjVIwEKn2ujD9AqR
         sNMA==
X-Gm-Message-State: AOAM53300nPoEuoVqPiBOB7C/fdyk4yYLIpcSIe/1wsNfhIFUcR/Q7iC
	6vBd5WZ7oTP4WVb15UB/L/3caUpTqcaZkR06Z5g=
X-Google-Smtp-Source: ABdhPJwuvKQsPSVhOzwdYxBYA7KiJ/wJpm+ub0Wy7vHkExajp6uOO58dSKNk4G5BNIH2CvVx7N1UP9PNTCbrk72CpIw=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr9763613otj.118.1596025308833;
 Wed, 29 Jul 2020 05:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com> <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
In-Reply-To: <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jul 2020 14:21:35 +0200
Message-ID: <CAJZ5v0h3=xkSjZ3tWjK3NEJjtBw5KpfNOrHJ1yQ8nXpSG=SBBg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: JXWINLK6NXAUBM4BW66MZAWQINEEO4CU
X-Message-ID-Hash: JXWINLK6NXAUBM4BW66MZAWQINEEO4CU
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JXWINLK6NXAUBM4BW66MZAWQINEEO4CU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 29, 2020 at 3:35 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> On Mon, 2020-07-27 at 14:37 +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 21, 2020 at 12:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Abstract platform specific mechanics for nvdimm firmware activation
> > > behind a handful of generic ops. At the bus level ->activate_state()
> > > indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> > > and ->capability() indicates the system state expectations for activate.
> > > At the DIMM level ->activate_state() indicates the per-DIMM state,
> > > ->activate_result() indicates the outcome of the last activation
> > > attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> > > 'armed'.
> > >
> > > A new hibernate_quiet_exec() facility is added to support firmware
> > > activation in an OS defined system quiesce state. It leverages the fact
> > > that the hibernate-freeze state wants to assert that a memory
> > > hibernation snapshot can be taken. This is in contrast to a platform
> > > firmware defined quiesce state that may forcefully quiet the memory
> > > controller independent of whether an individual device-driver properly
> > > supports hibernate-freeze.
> > >
> > > The libnvdimm sysfs interface is extended to support detection of a
> > > firmware activate capability. The mechanism supports enumeration and
> > > triggering of firmware activate, optionally in the
> > > hibernate_quiet_exec() context.
> > >
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > [rafael: hibernate_quiet_exec() proposal]
> > > Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > IMO it's better to change this to
> >
> > Co-developed-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > and please to add
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > to it as per the development process documentation.
>
> Thanks Rafael, I've fixed this up in the branch I've prepared for the pull
> request:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-for-next

LGTM, thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
