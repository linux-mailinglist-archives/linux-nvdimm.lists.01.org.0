Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF896B4C9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jul 2019 05:02:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30157212BF579;
	Tue, 16 Jul 2019 20:04:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDEFF2194EB75
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 20:04:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l15so23399564otn.9
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=moIcfOwT7Q28xvMfB1s79vLckwsn6mLmtlt9P80VoSI=;
 b=w7T5h8le8kar8GHbeuzqemVg7xntplejAU3LIpPoPxD5rDaA6mykcolHja7oxamFN+
 fcNJhXd4DetJySCJdhmgJKwbVMDKSXOWyUXGidrtJe3PTgBeA2og6iz5nw8EfAKyCAy6
 Zqj0eon0fp5aANLnzxF0AprfgdUTlPURq0NTh0A0VPAabeJKqJa0f82l0EF5e1m0pJmj
 OQjFnWnmI/ku6kLWxgppPmqjdvamNgPd3JVshYU1hb4KWI+pOcaeI0O2G+kPJcIYRliq
 M0SG+Nr6OPh0EAarDQanDv8ER7J0l7mWieCTBgxEmKozT8FVkUxiQXPrGbA2QGxio928
 qWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=moIcfOwT7Q28xvMfB1s79vLckwsn6mLmtlt9P80VoSI=;
 b=HEI+7bE4sIbPKz9atSYvr0v425VES09ZAhBypwe2wHjSz+/nxmjYkUzmHMt3JNHU2X
 s5u7L2bkWwwuV5lzsgZOp2TBHvdTlZqUlx51neCrX6bDrdBOyDnko5FRgibAutFJhci1
 rbIwAsF3drbYh4cvDXrOtJh0XTKtAYC/hXougvT7RaSfosOyo9plckd2gR+lGj3OCCfE
 hrzrVHKpUHHmjgJqGyJHNRxaVqY04e3QEWhyNy1uDSqQAMy2zLtkp2eJfe/EBpjA8/sc
 iaZd5JvXThrX69nMQLpjRoJoKNVcOcsnwgAg3/Xa4//uFx/A8fxNUdHFp48kJHt9E8l/
 baWQ==
X-Gm-Message-State: APjAAAVNt45ae3FTXCjdJuwdPjTzZqDqYYfGQtJaL29SSMgJywvS33iL
 Bp3J28HYwOmMwmP6jHS6kNoiDW0RBwoPLE7pCQDgQQ==
X-Google-Smtp-Source: APXvYqzJ8IMG8VXWy0kEMM/37hXScWIxxaMIJc4srMPsvxzwSqtji4irKjrqrN/DKpO/rDeJRWuz85fCgkFPrES4iVg=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr26992706otf.126.1563332531714; 
 Tue, 16 Jul 2019 20:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190712051610.15478-1-pagupta@redhat.com>
 <20190712101021-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190712101021-mutt-send-email-mst@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Jul 2019 20:02:00 -0700
Message-ID: <CAPcyv4joSgj7ok4DfW3tWQGavRDP8kp7oQRH8DgkG=0eWgNn1g@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: fix sparse warning
To: "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 yuval shaia <yuval.shaia@oracle.com>,
 virtualization@lists.linux-foundation.org, lcapitulino@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 12, 2019 at 7:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 10:46:10AM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> >
> > nd_virtio.c:56:28: warning: incorrect type in assignment
> >                                 (different base types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2
> >                                 (different base types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Pls merge - I assume nvdimm tree?

Yes, I'll push this with the rest to Linus tomorrow morning.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
