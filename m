Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E856336F24C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 23:49:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF577100EC1D4;
	Thu, 29 Apr 2021 14:49:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 918EE100ED4A0
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 14:49:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l4so102069026ejc.10
        for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFtRq0o7RuprUm0fy/T67jArYpo21Pztk91Azl3wjtg=;
        b=o/cixS4CRZbDd83SPuQAK5YD+6j6vn3+ZYtnu796vMPM6nom+Z1jgBXU4vyshs+v3f
         bDjNTCv01xfBDTyicwEtiODcRTWLY31i4RgME9kkxdGatHmND3jM21krUgJb78tqSdQs
         k2jTufyxLr7TxuvRfTEb9DVFx80f0EFkh7cZHFSWa2Dyc4M2JmT4m2ht72MhLtPDqdOJ
         HNy3RTIwTT8fEiBVrgz7XzpKdHsRWWroGMsvR7Wx1d+NjK0B1bBWQ4rNIHuIq5WPFxLF
         8XokTE/X6+yjnHYscZtoLGF1i2Du976C8nBBmdR43TMm7ZF8p9Qoq+m69mHnPgSuOYSG
         Avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFtRq0o7RuprUm0fy/T67jArYpo21Pztk91Azl3wjtg=;
        b=BZa6xvC1xmAK36OVliHooS9G7XBUHzHTMIFBkPHs5dL220yKB0Hv6KMLCIgGM/bNCJ
         g66q/Wxzq1qBjgQw5EPmNI+9+Aw8/dwuJZUSOuz8brUJT6AsDAvss3qnNlwbW4/MN/oI
         /2O8p/sMiAspkT5+VfKQWtEROrwsKqxqonCpJjZf+3ALH65Jgeuae9pskYZASau6id8Z
         tc95mRw04YoIUcCfF5OJHUzRSnej8iCcsXz2+krW5G3g/9R/EkuypelbVkj/WdyBLuo1
         JEMp3QhH3S/wUtR4ri7WNN/vsmSjOEQqJCQS/Y9pbq1qxJ4BUL3BbnO4TAb0wUmx5134
         6uOQ==
X-Gm-Message-State: AOAM533gGdgmRRtdLvmrmJjCFBnAhluvy0cDAZLIhlhsAz/sfQRri+E3
	heu2ltBhB62leVZtBTo1e29j9GyXXTtUh9Pxo4EByw==
X-Google-Smtp-Source: ABdhPJyQyU2O0jYpRlsyCFt2+GwglBHD3jjZ9N0ybhOUD/OLmiDsbhRN5TleXQ8e/c27SblrD1RT9jPTyfcx7blZeA8=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr589642ejf.341.1619732941590;
 Thu, 29 Apr 2021 14:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87sg3bd8iv.fsf@meer.lwn.net>
In-Reply-To: <87sg3bd8iv.fsf@meer.lwn.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Apr 2021 14:49:00 -0700
Message-ID: <CAPcyv4iDhrueShBUYMNAtUwMBmxtfrqOFjzoQ7KpN4aTTWrVpg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move nvdimm mailing list
To: Jonathan Corbet <corbet@lwn.net>
Message-ID-Hash: IOJ4USCCW2P6XUN5IOE2WII75FCLACHF
X-Message-ID-Hash: IOJ4USCCW2P6XUN5IOE2WII75FCLACHF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, nvdimm@lists.linux.dev, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IOJ4USCCW2P6XUN5IOE2WII75FCLACHF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 27, 2021 at 8:58 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > After seeing some users have subscription management trouble, more spam
> > than other Linux development lists, and considering some of the benefits
> > of kernel.org hosted lists, nvdimm and persistent memory development is
> > moving to nvdimm@lists.linux.dev.
> >
> > The old list will remain up until v5.14-rc1 and shutdown thereafter.
> >
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Oliver O'Halloran <oohall@gmail.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/obsolete/sysfs-class-dax    |    2 +
> >  Documentation/ABI/removed/sysfs-bus-nfit      |    2 +
> >  Documentation/ABI/testing/sysfs-bus-nfit      |   40 +++++++++++++------------
> >  Documentation/ABI/testing/sysfs-bus-papr-pmem |    4 +--
> >  Documentation/driver-api/nvdimm/nvdimm.rst    |    2 +
> >  MAINTAINERS                                   |   14 ++++-----
> >  6 files changed, 32 insertions(+), 32 deletions(-)
>
> Would you like me to take this through docs-next, or did you have
> another path in mind?

Thanks for the offer, I have a few other nvdimm related bits for this
cycle, so it can go through nvdimm.git.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
