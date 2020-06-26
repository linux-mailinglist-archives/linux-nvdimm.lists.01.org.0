Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7457020B87D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 20:41:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B068210FE3541;
	Fri, 26 Jun 2020 11:41:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD23010FCC904
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 11:41:41 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d15so7659861edm.10
        for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K5VPNdmXZlTpEK22Z0aFSoTEURNY4RlCyiO1qXhgPg=;
        b=R11LKguwqjk59xIplUm8flq2KsUfM9ZSKQ+ue3XNEh3xaqcql/A1LqO8WqJ2Z0wMrV
         Ja9C3T76hLGzXQ6SEL9dPdb9+PQ0VpDbwayD/jWxW/g5k+HEXyjnmM+GXQqOQL6QrmHN
         80fH4SbcRIalhTYJvMKi+6WEIquUl4hGKjK3C9XqBwenis3qOqdrc1ThO/IggREuQAPh
         vibdjUr77+63gg0nZo76QAHi1mMjwWr3+xjUamopUOg+V3bzZH+axB565gDM3tcVybn9
         r7rWU4XpJuxXdpUBSDHlgtVca7Z5vuIkFCYvjvpWeWvJwehTcf10duJT2lsqPqEieNRr
         Xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K5VPNdmXZlTpEK22Z0aFSoTEURNY4RlCyiO1qXhgPg=;
        b=KTz5cV2NLmfg8lplkMl4W91BKqsSgg14usGtLNzG4UlxCwGXuLUteV2MSxql0goQf1
         ShVvEu59AF1cIrV4DmLmP6DbqFatKM+dAUf6pBAzM4LYoGUwOOfcId3Uzykap3q5w1Y0
         H/wseqrcZwKQR0sU9lo3HZs+RnDMcnSH+a3uedVLK2AO85K3EyCWt+CkMerZYiP7OD6Z
         zanPGUnp+y8/RPXE/hTZ9OdeVrrA1ahEDgS4aRmIGgjtJN1pYwhd/SYkTvhmJp/CPuX1
         XUjJPK0aPC+XuL7v0NuEJPjb2NLranAtBLfA1BIhepusmZhG/0C4mL2Dw8ZyHAcf59JT
         mdwg==
X-Gm-Message-State: AOAM530thVH06ciZ0wNVr9LZH4CNsRCyiVXkrHgwjnLe8/Qk53B9bG1B
	NZ26oJM+6fUxKkcS9go6I7lrktGqxcHl183pi6DByA==
X-Google-Smtp-Source: ABdhPJyot1xiFZLUjntQDRxbUfJEXI+PfIkPQ6MlPsJnQU2vuAcJyNfh4brPbGRTQjAQygy+GdtrpLfUUTnFVLC1nCI=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr4977457edo.123.1593196898995;
 Fri, 26 Jun 2020 11:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Jun 2020 11:41:27 -0700
Message-ID: <CAPcyv4hXkzpTr3bif7zyVx5EqoWTwLgYrt87Aj2=gVMo+jtUyg@mail.gmail.com>
Subject: Re: [RFT][PATCH v3 0/4] ACPI: ACPICA / OSL: Avoid unmapping ACPI
 memory inside of the AML interpreter
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: 7GFAOCMEJERW6XNHHLJJZ7D52CQ5NU2Q
X-Message-ID-Hash: 7GFAOCMEJERW6XNHHLJJZ7D52CQ5NU2Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Erik Kaneda <erik.kaneda@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7GFAOCMEJERW6XNHHLJJZ7D52CQ5NU2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 26, 2020 at 10:34 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> On Monday, June 22, 2020 3:50:42 PM CEST Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This series is to address the problem with RCU synchronization occurring,
> > possibly relatively often, inside of acpi_ex_system_memory_space_handler(),
> > when the namespace and interpreter mutexes are held.
> >
> > Like I said before, I had decided to change the approach used in the previous
> > iteration of this series and to allow the unmap operations carried out by
> > acpi_ex_system_memory_space_handler() to be deferred in the first place,
> > which is done in patches [1-2/4].
>
> In the meantime I realized that calling syncrhonize_rcu_expedited() under the
> "tables" mutex within ACPICA is not quite a good idea too and that there is no
> reason for any users of acpi_os_unmap_memory() in the tree to use the "sync"
> variant of unmapping.
>
> So, unless I'm missing something, acpi_os_unmap_memory() can be changed to
> always defer the final unmapping and the only ACPICA change needed to support
> that is the addition of the acpi_os_release_unused_mappings() call to get rid
> of the unused mappings when leaving the interpreter (module the extra call in
> the debug code for consistency).
>
> So patches [1-2/4] have been changed accordingly.
>
> > However, it turns out that the "fast-path" mapping is still useful on top of
> > the above to reduce the number of ioremap-iounmap cycles for the same address
> > range and so it is introduced by patches [3-4/4].
>
> Patches [3-4/4] still do what they did, but they have been simplified a bit
> after rebasing on top of the new [1-2/4].
>
> The below information is still valid, but it applies to the v3, of course.
>
> > For details, please refer to the patch changelogs.
> >
> > The series is available from the git branch at
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpica-osl
> >
> > for easier testing.
>
> Also the series have been tested locally.

Ok, I'm still trying to get the original reporter to confirm this
reduces the execution time for ASL routines with a lot of OpRegion
touches. Shall I rebuild that test kernel with these changes, or are
the results from the original RFT still interesting?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
