Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5E20C923
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Jun 2020 19:09:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88A2411167BE0;
	Sun, 28 Jun 2020 10:09:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.67; helo=mail-ot1-f67.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF23111167BDE
	for <linux-nvdimm@lists.01.org>; Sun, 28 Jun 2020 10:09:19 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id d4so13375335otk.2
        for <linux-nvdimm@lists.01.org>; Sun, 28 Jun 2020 10:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHBo9wbaRoVXLY9NDJVIGwtnv5GehbPHBWMQ1wY/EhI=;
        b=nUV6wOWYhq8Cl2vyWYTE1WSouxCmaQqn3DRCHvmJz+eru8rixdfzzSzf1vX+sYcUt2
         aSE16GNvOejjtJ6kabq/Ua7ayRceNqOsZgOPoJHnFWyfxusMDGTSCemmeHv2AZfkYBgB
         +o1dl4XFGX8yqWCJRfuhztNpb39kY3k4U2/TaUCsxLbIxCF/AC3NmkILt/2jFPCPFHOF
         sDRua+/dCd9/DHIpUyvK4wrXuQ761L9CqY7U4wblJE74M4ALUPrCDIudrfvMSmA3jDvH
         tRVexGmIGqCjzPB5tjrDZssyG+OAqVHxu07Klk/FPdnqboWZAwFQy1ZvAz/S6eyW4xUO
         6zXQ==
X-Gm-Message-State: AOAM531bvxLAQB8h7PvJ2jlBM5zN9pdtKrJKRxYPg79G+3gGetm58V6B
	KNZgFOKXNyZsapbXV1uikDUt/50QvRiP+qQkKms=
X-Google-Smtp-Source: ABdhPJwaNxLa9utWgL4ulKbbgtv/kdZW4Bdg8bFZ+HQwwb00UUCEe4sYvKeUlGn7UPuAH99xcAgVC20KCp9+4PA8z0M=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr10130090otn.118.1593364158371;
 Sun, 28 Jun 2020 10:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher> <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
In-Reply-To: <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 28 Jun 2020 19:09:07 +0200
Message-ID: <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: CNM4FSCHJ3FARWFERR4RP4GOXJIKX444
X-Message-ID-Hash: CNM4FSCHJ3FARWFERR4RP4GOXJIKX444
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CNM4FSCHJ3FARWFERR4RP4GOXJIKX444/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > This series is to address the problem with RCU synchronization occurring,
> > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > when the namespace and interpreter mutexes are held.
> > >
> > > Like I said before, I had decided to change the approach used in the previous
> > > iteration of this series and to allow the unmap operations carried out by
> > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > which is done in patches [1-2/4].
> >
> > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > variant of unmapping.
> >
> > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > always defer the final unmapping and the only ACPICA change needed to support
> > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > of the unused mappings when leaving the interpreter (module the extra call in
> > the debug code for consistency).
> >
> > So patches [1-2/4] have been changed accordingly.
> >
> > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > range and so it is introduced by patches [3-4/4].
> >
> > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > after rebasing on top of the new [1-2/4].
> >
> > The below information is still valid, but it applies to the v3, of course.
> >
> > > For details, please refer to the patch changelogs.
> > >
> > > The series is available from the git branch at
> > >
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >  acpica-osl
> > >
> > > for easier testing.
> >
> > Also the series have been tested locally.
>
> Ok, I'm still trying to get the original reporter to confirm this
> reduces the execution time for ASL routines with a lot of OpRegion
> touches. Shall I rebuild that test kernel with these changes, or are
> the results from the original RFT still interesting?

I'm mostly interested in the results with the v3 applied.

Also it would be good to check the impact of the first two patches
alone relative to all four.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
