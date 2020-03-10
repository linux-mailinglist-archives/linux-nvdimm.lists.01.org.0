Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD24180C38
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 00:19:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7CAC610FC363B;
	Tue, 10 Mar 2020 16:19:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=mcroce@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A53A810FC3633
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583882342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsEVgIb0FHCXJVxaEJkcHFE2l9+mdWsKDxZwEgCv+7g=;
	b=bNz9MuzGtI/DcubHgqE6LXtKPk+Kv/gCHI4kDvZ9hhPDMonMcDwNCvCXWnp+HHKM94ry+k
	Vve4y74cSHS4h7tuGlgy/ARfNoQjKwgUjMMo1kmQfc74essc2efgz+T/ud2UEwx8UU9DjA
	Nu0UkbZuDpy7XIZ1rdhQPjxPQvlJJt4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-TYQ_wpHlORqyvRMyHkXc5Q-1; Tue, 10 Mar 2020 19:18:58 -0400
X-MC-Unique: TYQ_wpHlORqyvRMyHkXc5Q-1
Received: by mail-ed1-f71.google.com with SMTP id b100so178639edf.15
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 16:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=bvQt8TtU9g3qbgZnOhC0/K9/OoLizjUWmnRjlZF7WNbv8qDb5VfHkLbVwimLdvQUY9
         tPjJL3Xlx0DLyTI7NFeTv0XPxAt0+Ke42UYF4+UvMT4uLNx6giaZOEsDnMgmI7wV3ftg
         CHI9wiPD/vAz0syJetQYJLbD/q0+o1VlWHKSQijp4nCB9z0HEV9wdJ2WUhGoEYnTDNXE
         hGl7cMz8msHIHmmARaB4s5YRAtG2yyhNPp1fdsc+uamvle2BIcu+ZMORBpD23rKau/QG
         dBo0GTx4uDPYKMuUkcy4SfPYzMTMAduyoJnhzApbAT1B5ciquwsR7kP835WO5TwpU0TU
         A0vQ==
X-Gm-Message-State: ANhLgQ1iYXS2HiwpYWvXDNjkFbdhqTT8wEK1zXAjz+6AhRqhOqUG8Jax
	APHgdlY5HwNGpl/ZZxpNI0pjs/IFiYENb0bVr6r0DoFbmGQeGdXHScyJVH5DiSYRfsPwoaIDLfh
	AsLxRu1GfisPp2M9+B7bZBAogkGdECBWhmUXG
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415663ejc.377.1583882337419;
        Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstjHqiZOF0xElis+31S7G0gY2aH73JLw/AluJvKeWmdJcJyHfoWoeERc+w0Ht0pyWZgseKXsqtbLAkFkQLxyM=
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415648ejc.377.1583882337100;
 Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310223516.102758-1-mcroce@redhat.com> <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
In-Reply-To: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
From: Matteo Croce <mcroce@redhat.com>
Date: Wed, 11 Mar 2020 00:18:21 +0100
Message-ID: <CAGnkfhwjXN_T09MsD1e6P95gUqxCbWL7BcOLSy16_QOZsZKbgQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: refactor duplicated macros
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: LSAKWNYGACNHZS6HYFDOZTRWQDPAQCY3
X-Message-ID-Hash: LSAKWNYGACNHZS6HYFDOZTRWQDPAQCY3
X-MailFrom: mcroce@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-mmc@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Anna Schumaker <anna.schumaker@netapp.com>, Song Liu <song@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LSAKWNYGACNHZS6HYFDOZTRWQDPAQCY3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 12:10 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 3/10/20 11:35 PM, Matteo Croce wrote:
> > +++ b/drivers/md/raid1.c
> > @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
> >       int vcnt;
> >
> >       /* Fix variable parts of all bios */
> > -     vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> > +     vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);
>
> Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.
>
> Thanks,
> Guoqing
>

Wow, there are a lot of them!

$ git grep -c 'PAGE_SHIFT - 9'
arch/ia64/include/asm/pgtable.h:2
block/blk-settings.c:2
block/partition-generic.c:1
drivers/md/dm-table.c:1
drivers/md/raid1.c:1
drivers/md/raid10.c:1
drivers/md/raid5-cache.c:5
drivers/md/raid5.h:1
drivers/nvme/host/fc.c:1
drivers/nvme/target/loop.c:1
fs/erofs/internal.h:1
fs/ext2/dir.c:1
fs/libfs.c:1
fs/nilfs2/dir.c:1
mm/page_io.c:2
mm/swapfile.c:6

-- 
Matteo Croce
per aspera ad upstream
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
