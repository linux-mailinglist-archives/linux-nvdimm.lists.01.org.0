Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C633104C5E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Nov 2019 08:24:05 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DCB4100DC2BC;
	Wed, 20 Nov 2019 23:24:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B289100DC2BA
	for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 23:24:36 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b16so2045164otk.9
        for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=Aamx4FNUou5OK5b7p9ovqCkit0cIfdpUzoZz7zxKIrRXmGuxUroJEy8wgfnhc4LNO9
         /bAUGOCzZnxJ+6JvDwrn1hrSEejsJDm9addm6MgSJJndGvNXP5xKWYE3TXfKO3zT1XmE
         G+cfBCOAa0MLYBx0J8IOpV6ETGNBWcIcBSKsVmQ18T+Av5T94jpinvYdky3C2cfJCxww
         zAYPLQyi/BjZmHcmFpPXkMpAq93xJVnFAVyNIJ7wM77MNuYDPu5abIu18Pi9wC4fb9Ij
         LyRjFAPS051ir8jmoxV6RL/1LXpeCK7iPrM3gAOrGb89knq52X47y1B6UQk7Vc8JyaZJ
         Bxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=DBuiD+/iNv83tXWrUG4zNgR6dw+cgr44/ivl+skXkdo8LHArLxg9TV2voR3eX9/kJl
         5FFHSfRr8Mvpmt2LGqFc9HQFkicZ7Ny6rCyQNic34gYW4iZzDhbqNpMWTKbpQN4/tlQJ
         KbXbGbh2UWVl4iqBk8EWfBG1RBnWXwmyzu6+d237sld792bS4fk6Z3U0PqSAYALjEVqV
         xj6W4A8wnp4fwiwkpmQhjOrlok+J0rgxU7mC+9JVdOTbfbLH0m8Ej95hqDXsRZXCssST
         42/C5aenYfbJ836V6c9eVVVWnTAaKsFTSnipfPNzH933oBjbCTmE8qBI5cEO+MgrIIKi
         IxaQ==
X-Gm-Message-State: APjAAAWyVaXxjSIKL5yC8QHSw4SypR8MJ4V3cUAnpycSbwt3acHELuUO
	eLaVINM+7IJFdG9YjvCA/fA+veVe+xtoiIY3TWsyPw==
X-Google-Smtp-Source: APXvYqws9XkJQSLixl8sCxSf8KR7piXMbSGOHYMZNFTKMUrilxcOOTe8eFSPb/y5vtMhiXzk8SHG7lti/eziN7V7EtQ=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5394180otg.363.1574321038732;
 Wed, 20 Nov 2019 23:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Nov 2019 23:23:46 -0800
Message-ID: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: 6362S4NL5GIBMBH4GD7YRHIVG6AUXK74
X-Message-ID-Hash: 6362S4NL5GIBMBH4GD7YRHIVG6AUXK74
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6362S4NL5GIBMBH4GD7YRHIVG6AUXK74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Pankaj Gupta <pagupta@redhat.com> writes:
>
> >  Remove logic to create child bio in the async flush function which
> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >  data write request.
> >
> >  Instead we are performing flush from the parent bio to maintain the
> >  correct order. Also, returning from function 'pmem_make_request' if
> >  REQ_PREFLUSH returns an error.
> >
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> There's a slight change in behavior for the error path in the
> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> converted to -EIO.  Now, they are reported as-is.  I think this is
> actually an improvement.
>
> I'll also note that the current behavior can result in data corruption,
> so this should be tagged for stable.

I added that and was about to push this out, but what about the fact
that now the guest will synchronously wait for flushing to occur. The
goal of the child bio was to allow that to be an I/O wait with
overlapping I/O, or at least not blocking the submission thread. Does
the block layer synchronously wait for PREFLUSH requests? If not I
think a synchronous wait is going to be a significant performance
regression. Are there any numbers to accompany this change?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
