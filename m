Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C885372593
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 May 2021 07:44:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54A60100EB847;
	Mon,  3 May 2021 22:44:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::136; helo=mail-il1-x136.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95F4A100EB83F
	for <linux-nvdimm@lists.01.org>; Mon,  3 May 2021 22:44:07 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p15so5457581iln.3
        for <linux-nvdimm@lists.01.org>; Mon, 03 May 2021 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9ESRXefOvFcFU8JizCeiw+vMSlHN+RPYh9AjhBOqb8=;
        b=G5DClEfzuTVYVNRsJKfQJ2Q1QTCN37SlLVFqqvhciqDzHPQ8XnFr/N9dHmw9TTfN0E
         VggOshctvx5Zzn4ijwk+NXVBCytTblKaq5629URM4CAT21Wbb2K9q3OQm/ndSud7R3pE
         8cgnqNtHpaIC1YNScouwr2wZWkYcGdwQZSsGoF6WGwomhGjRvhMdi/9TicMzEkGUDxc6
         zJ8OI1WwyGfzkvfPkukevttNOdxFfQwLEtQXFuzGhjhm5GOeN4+Hy6JHPr6Y4VolxemC
         tHlCiWuXhyS3cTMq8rUTYfA5+F1p+otPe2Ke3gKn0kOznsDMJABwwOg5LUijFQ8jZu7y
         Lsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9ESRXefOvFcFU8JizCeiw+vMSlHN+RPYh9AjhBOqb8=;
        b=C2jenmXh/f27RnCI0vto8CH7JKpIufnwW8yCwZRLp91pNhVXFURx0zqzfBVt9KQvzb
         cwN0sQyzVpAj5zdTG+KBzAR1yhK+5w/hIXQ5dakKaSihExKFD4XRCfX8Rq2kwDn287n5
         spkjyg8EImqMotm5NVnTOqEzHSQk0AH43+YDfYy9AGWVS4/aIexakjDfV5Wc4TYyiui+
         c784hmGx5H8rfe6yJuH5FbV/d6btilFcD7Pjws5X6Ysxhos41MMhwK6htmszGZVFu0ZL
         77l9QYjcKvg60bfu4qMkOXBfBBLjcN/n4IfV5tKFX0Dijvy2jdWPqICiknV6bAhHVxGK
         CIiw==
X-Gm-Message-State: AOAM532X3xxftghRIhQF3JbzBfh6UE+S3JK7+g+Qtkzcs/Lyoid8Bwjd
	x5jn8JTbNgWZUfmdEwZIpnf65v9VhoZVLkz+NlA=
X-Google-Smtp-Source: ABdhPJzC6alOzJqNjv57N04F4U3tHUEdbtp1zl/QgLQrapXHd+EvE5w35e9Iti1fnaIY0tTwULyBboMTw8lYepmsnxs=
X-Received: by 2002:a05:6e02:160d:: with SMTP id t13mr19821606ilu.85.1620107045748;
 Mon, 03 May 2021 22:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
 <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com> <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
 <d21fcac6-6a54-35fd-3088-6c56b85fbf25@linux.ibm.com>
In-Reply-To: <d21fcac6-6a54-35fd-3088-6c56b85fbf25@linux.ibm.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 4 May 2021 07:43:53 +0200
Message-ID: <CAM9Jb+g8bKF0Z7za4sZpc2tZ01Sp4c4FEaV65He8w1+QOL3_yw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: G6THHVJKETCZOELJQDNQHFJBUCBLUDQ5
X-Message-ID-Hash: G6THHVJKETCZOELJQDNQHFJBUCBLUDQ5
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G6THHVJKETCZOELJQDNQHFJBUCBLUDQ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > The proposal that "sync-dax=unsafe" for non-PPC architectures, is a
> > fundamental misrepresentation of how this is supposed to work. Rather
> > than make "sync-dax" a first class citizen of the device-description
> > interface I'm proposing that you make this a separate device-type.
> > This also solves the problem that "sync-dax" with an implicit
> > architecture backend assumption is not precise, but a new "non-nvdimm"
> > device type would make it explicit what the host is advertising to the
> > guest.
> >
>
> Currently, users can use a virtualized nvdimm support in Qemu to share
> host page cache to the guest via the below command
>
> -object memory-backend-file,id=memnvdimm1,mem-path=file_name_in_host_fs
> -device nvdimm,memdev=memnvdimm1
>
> Such usage can results in wrong application behavior because there is no
> hint to the application/guest OS that a cpu cache flush is not
> sufficient to ensure persistence.
>
> I understand that virio-pmem is suggested as an alternative for that.
> But why not fix virtualized nvdimm if platforms can express the details.
>
> ie, can ACPI indicate to the guest OS that the device need a flush
> mechanism to ensure persistence in the above case?
>
> What this patch series did was to express that property via a device
> tree node and guest driver enables a hypercall based flush mechanism to
> ensure persistence.

Would VIRTIO (entirely asynchronous, no trap at host side) based
mechanism is better
than hyper-call based? Registering memory can be done any way. We
implemented virtio-pmem
flush mechanisms with below considerations:

- Proper semantic for guest flush requests.
- Efficient mechanism for performance pov.

I am just asking myself if we have platform agnostic mechanism already
there, maybe
we can extend it to suit our needs? Maybe I am missing some points here.

> >> On PPC, the default is "sync-dax=writeback" - so the ND_REGION_ASYNC
> >>
> >> is set for the region and the guest makes hcalls to issue fsync on the host.
> >>
> >>
> >> Are you suggesting me to keep it "unsafe" as default for all architectures
> >>
> >> including PPC and a user can set it to "writeback" if desired.
> >
> > No, I am suggesting that "sync-dax" is insufficient to convey this
> > property. This behavior warrants its own device type, not an ambiguous
> > property of the memory-backend-file with implicit architecture
> > assumptions attached.
> >
>
> Why is it insufficient?  Is it because other architectures don't have an
> ability express this detail to guest OS? Isn't that an arch limitations?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
