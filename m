Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930C20F356
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 13:04:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B79DA111FF492;
	Tue, 30 Jun 2020 04:04:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 62255111F92B6
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 04:04:34 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id k6so13193495oij.11
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXIRIHHncqo0zBLK3dtMRuMsQ9p5Az0FH+7MVXNOGgk=;
        b=OZC+7OPxVp2ZtdyRvv0e+f3t3QHM1IijL3IeTCdryYuN4PxxALwjh3MB5mKBAW2xR6
         Zzm/ATQY+y191VfC9capZD4iXRZ1sXpA2W0AOy1UUKjTuWOZ3+fjmm8JL0L8H/7HQZ9q
         zxLOKV2+B+yxVAD0zXSr88FzR+j2NVWLumeaQv5viRmR8Tqpx4c0flUvGKfvYQVYV1l6
         i+hnLi7q+dZwv9dEqzB6Mv9ruuZ3dj69RLevbXy4FKBrIFfG/5nOdb1ke1ZXsKDzrih6
         r1UmIw6FTBcTtBzWkcZM6JvfDxYh0PhbAs9lXOqJCpgQ13rZME1MmgAnlLUJgeVRgcpA
         pUnA==
X-Gm-Message-State: AOAM532jPgDjb75qmqRHdlR1XdpSCKM4JdmZ5zaMKO6q4UBw6ncyiedj
	WRHl2WvjtQcuqgh5YA7l3tVWh7ecdyQicEi5rnQ=
X-Google-Smtp-Source: ABdhPJyrXV+odnKMMsJSNg1252EbQtYugp1MCGhfn0n9yvdE0dCa6B3S5wf96DbBHiDa3tUn2DkDotITWi/UNHXvnXk=
X-Received: by 2002:a54:4585:: with SMTP id z5mr16015967oib.110.1593515073282;
 Tue, 30 Jun 2020 04:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
 <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
 <CAJZ5v0h4Hj4ax1mmMJn3z3VGtVWkoXzO0kOQ7CYnFKJV2cUGzw@mail.gmail.com> <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iZA6hHH=sh=CZPJ-6skJfeuAVRVAuMeTdD5LYVPRrTqQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jun 2020 13:04:21 +0200
Message-ID: <CAJZ5v0g8=tXU8HHkoXSOwSmRhTgwb5rW8N8QQga6AU91kp1dVw@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: HH3Q6UPRBSZVV5DGAN3UUVKYJL2QEYAO
X-Message-ID-Hash: HH3Q6UPRBSZVV5DGAN3UUVKYJL2QEYAO
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HH3Q6UPRBSZVV5DGAN3UUVKYJL2QEYAO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 10:46 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Jun 28, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 8:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > > > > Hi All,
> > > > >
> > > > > This series is to address the problem with RCU synchronization occurring,
> > > > > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > > > > when the namespace and interpreter mutexes are held.
> > > > >
> > > > > Like I said before, I had decided to change the approach used in the previous
> > > > > iteration of this series and to allow the unmap operations carried out by
> > > > > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > > > > which is done in patches [1-2/4].
> > > >
> > > > In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> > > > "tables" mutex within ACPICA is not quite a good idea too and that there is no
> > > > reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> > > > variant of unmapping.
> > > >
> > > > So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> > > > always defer the final unmapping and the only ACPICA change needed to support
> > > > that is the addition of the acpi_os_release_unused_mappings() call to get rid
> > > > of the unused mappings when leaving the interpreter (module the extra call in
> > > > the debug code for consistency).
> > > >
> > > > So patches [1-2/4] have been changed accordingly.
> > > >
> > > > > However, it turns out that the "fast-path" mapping is still useful on top of
> > > > > the above to reduce the number of ioremap-iounmap cycles for the same address
> > > > > range and so it is introduced by patches [3-4/4].
> > > >
> > > > Patches [3-4/4] still do what they did, but they have been simplified a bit
> > > > after rebasing on top of the new [1-2/4].
> > > >
> > > > The below information is still valid, but it applies to the v3, of course.
> > > >
> > > > > For details, please refer to the patch changelogs.
> > > > >
> > > > > The series is available from the git branch at
> > > > >
> > > > >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > > >  acpica-osl
> > > > >
> > > > > for easier testing.
> > > >
> > > > Also the series have been tested locally.
> > >
> > > Ok, I'm still trying to get the original reporter to confirm this
> > > reduces the execution time for ASL routines with a lot of OpRegion
> > > touches. Shall I rebuild that test kernel with these changes, or are
> > > the results from the original RFT still interesting?
> >
> > I'm mostly interested in the results with the v3 applied.
> >
>
> Ok, I just got feedback on v2 and it still showed the 30 minute
> execution time where 7 minutes was achieved previously.

This probably means that "transient" memory opregions, which appear
and go away during the AML execution, are involved and so moving the
RCU synchronization outside of the interpreter and namespace locks is
not enough to cover this case.

It should be covered by the v4
(https://lore.kernel.org/linux-acpi/1666722.UopIai5n7p@kreacher/T/#u),
though, because the unmapping is completely asynchronous in there and
it doesn't add any significant latency to the interpreter exit path.
So I would expect to see much better results with the v4, so I'd
recommend testing this one next.

> > Also it would be good to check the impact of the first two patches
> > alone relative to all four.
>
> I'll start with the full set and see if they can also support the
> "first 2" experiment.

In the v4 there are just two patches, so it should be straightforward
enough to test with and without the top-most one. :-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
