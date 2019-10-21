Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E47EBDF597
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:04:10 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 114761007A2F6;
	Mon, 21 Oct 2019 12:04:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D00F10077F8F
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 07:46:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y39so11197371ota.7
        for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=A08jDv+Vol6PvOoXT/M++kzuwcxp91LiBFYVYM8EPNPJr69L5QUHqGuyp6zGv7tyF9
         6FX/3oF06Fh+suEw+xQCGVLXW/2yTptC75eQ4/Bbh3WX6Ds/b0M7cf50hvpynQ5ibr4v
         gyYdRFItY3w55CEltwtFaefj+WsgXARJ5YWtFuxW73BsZK0zpcCSH1MoB0rLRv8RqmVt
         qiaRQW1K0uEwRHT9/yan1nEhEFofsZXJYLXFQRs8G0Luo67GpvQH6OEE/XLvxxr7bbTv
         RWxGf3MhxbRyjvhxwa7eDi1zMvw+87+x9G1yJ+8txjhDZ6FYAZefo+3fNI8vS/AdDEne
         vqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=njh4t5ZzTkJ4to2/Q7JPFpZit/GElEDP+b7tKjtNPYZbB5+2krJPNndobuXC523KDK
         LuuoLO+eOJgFeCDUD/fe5wYFT//gcYlnkJA819b8QOS2UmRbIXRFWgA4DIpBCQyZWeRM
         dqC20r9wIGn7DYzHgAjvCkNWbwo0H3rTTQqAqJJBh4Fh+RxbPmJMHzzlvTo+PhhsjLhU
         7sUeGlsL20qdAh03aChzYT6+m2rBPSQY6QUSbjpM5NMa+x0aG9f384lKOhnybUxFp3+y
         o9HM9XKUYrTug8rpzs4C7tL3UGhOBAnxrsG721Mo/ioqemFvdtcKUOv3rycnjSjHGoNi
         mxzQ==
X-Gm-Message-State: APjAAAVoy77QT0d8eEKtDKaGA6GRK6Tfj1ecWjBozK/UpF3CHYFhR+ry
	ZkRc9fUNqaXZ2589mPlHWDiD2alq3uAZFbmdbbAX4A==
X-Google-Smtp-Source: APXvYqxBK0s4meOHW5S/bgvSxL00+aVLbFSn/xa462jwXlzSuPi3v0iK8imKwTC8RSn2iFmHXyu4Ls1dS51GrTPHPKE=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr19206153otn.363.1571669101455;
 Mon, 21 Oct 2019 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 21 Oct 2019 07:44:51 -0700
Message-ID: <CAPcyv4j66KoivrNRpOrqwrVtsOP5fSWKPqcHx_dDf1czy=f3qQ@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: WCV6SHOG6JHGUZYLD2BRBDCKQZ342RFS
X-Message-ID-Hash: WCV6SHOG6JHGUZYLD2BRBDCKQZ342RFS
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WCV6SHOG6JHGUZYLD2BRBDCKQZ342RFS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 21, 2019 at 5:07 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Check for NULL entries before checking the entry order, otherwise NULL
> > is misinterpreted as a present pte conflict. The 'order' check needs to
> > happen before the locked check as an unlocked entry at the wrong order
> > must fallback to lookup the correct order.
>
> Please include the user-visible effects of the problem in the changelog.
>

Yup, I noticed that right after sending.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
