Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3020DCF4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 22:46:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5724E111FF492;
	Mon, 29 Jun 2020 13:46:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 594FA111F92BA
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 13:46:17 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so18214201ejc.3
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=048/aux/uWIN5e9D0xFyVGaUP4nryXDLfPyRWaH72Ek=;
        b=zD6ga5emxtpmlIRAVfIT7c+0qmIa0JmJoiG9wTiBB3xtmmIy4qLmkRaMU4kRXvIQIa
         E83S8YIz7Tm0zhdu5czEB7Hln5/zBfAUh5P3RXjn5dpGJjPvlpteL/5yHDA4MrunZty8
         SERNEQQciNzdZGDaWJlKmCkPqtQVKg6u1W+ITBhcA6VIARJxNSIYoOBIhTb6FYMn1Wfz
         3h+U76ciDZZ+skAq1/OiIChJFBHAsTQFdkshuLB8hKyKewfGtGmRnNutNjYbPtDaaIfa
         Rs1pLnKujXyjWtD10YwTIaIE2NUaTA/V7kGdHd6AtMopwEmEJMRacTA40mLgLoY1u2lC
         qlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=048/aux/uWIN5e9D0xFyVGaUP4nryXDLfPyRWaH72Ek=;
        b=WLyKVEVXxf14k4qEdj/T2WbezwapCn2HpZVCvRPjg7wII8dsgZ22RvRPEgwNZ3RnqR
         LK/55qBPSOmmMDALqVRz0GXuAvLQWIQPvkvtHiadgGlcrpxupykLyEOHpgqDn+Saf3ie
         hs2qq8S2HjppJmNZX4LWCfRo0Y0IfAu9/ysTn1+TP/C3T8bWJAr7QPR2GYxMBmn2Tb5Z
         c3gJxxfXvGn2B6h37pscJ/Ti/Ybq5Z3BH8D5+qLFLTAz3q0FsNvsayJJZsIau4AJra4Y
         10aW8KLNnvMbsrGHcpvEOTCO+MEqW+gSWlZHydLn+HBnAo3JgvKor6tEYN3J941SXQuv
         McKw==
X-Gm-Message-State: AOAM531X0Ntbp2a8jJjPNYIP2J30kN0SF/qza+kjuBSHbkfjUAeIc+I3
	s6R4NfMAyHjaxql2Wq3qgznMlxDdgzu56LgoHAf1lA==
X-Google-Smtp-Source: ABdhPJxzX+kvJW1oBz/LQoASVcNYo3f670EC1zMCzFjhu4hr60/3iDTMlcp5vk8mgfPRkD9fqyFOWjpkBHEw5m0Eu48=
X-Received: by 2002:a17:906:da0f:: with SMTP id fi15mr15169748ejb.237.1593463574870;
 Mon, 29 Jun 2020 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
 <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com> <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jun 2020 13:46:03 -0700
Message-ID: <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: 4X434PN4AOSQWMUIMGFG75D7W7GNHUIT
X-Message-ID-Hash: 4X434PN4AOSQWMUIMGFG75D7W7GNHUIT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4X434PN4AOSQWMUIMGFG75D7W7GNHUIT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jun 28, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi All,
> > >
> > > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > This series is to address the problem with RCU synchronization occurring,
> > > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > > when the namespace and interpreter mutexes are held.
> > > >
> > > > Like I said before, I had decided to change the approach used in the previous
> > > > iteration of this series and to allow the unmap operations carried out by
> > > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > > which is done in patches [1-2/4].
> > >
> > > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > > variant of unmapping.
> > >
> > > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > > always defer the final unmapping and the only ACPICA change needed to support
> > > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > > of the unused mappings when leaving the interpreter (module the extra call in
> > > the debug code for consistency).
> > >
> > > So patches [1-2/4] have been changed accordingly.
> > >
> > > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > > range and so it is introduced by patches [3-4/4].
> > >
> > > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > > after rebasing on top of the new [1-2/4].
> > >
> > > The below information is still valid, but it applies to the v3, of course.
> > >
> > > > For details, please refer to the patch changelogs.
> > > >
> > > > The series is available from the git branch at
> > > >
> > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > >  acpica-osl
> > > >
> > > > for easier testing.
> > >
> > > Also the series have been tested locally.
> >
> > Ok, I'm still trying to get the original reporter to confirm this
> > reduces the execution time for ASL routines with a lot of OpRegion
> > touches. Shall I rebuild that test kernel with these changes, or are
> > the results from the original RFT still interesting?
>
> I'm mostly interested in the results with the v3 applied.
>

Ok, I just got feedback on v2 and it still showed the 30 minute
execution time where 7 minutes was achieved previously.

> Also it would be good to check the impact of the first two patches
> alone relative to all four.

I'll start with the full set and see if they can also support the
"first 2" experiment.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
