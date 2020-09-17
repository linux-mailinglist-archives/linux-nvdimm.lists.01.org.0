Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042626DEDD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 16:57:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E2D814DF56C8;
	Thu, 17 Sep 2020 07:57:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1188814DF56C4
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 07:57:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so2046668qtj.11
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkWWW7uvH9M/3NMutwpknlXCtyfjYS2suxokJOZOOWM=;
        b=r29kD483fUNV4Xl2Z7RSUYhKdJvEd9WInTcor5LsyPkam/xLeorp2fpo66H/9+r4H6
         0/uAttgsV5n8PfVAYMHyXJuvoSdqGhnk1ylJ2XayczKOvrMZZwpYtf918K3Dee8hhSif
         CsH4exBTRlZ2a2zCNx6DFu3J2tu60JgU0gYs04qVYLAV+nB57h57kxsjEijMDa48JliN
         hIhiH5+5Ivnrl6JGnmMTWVX9VUfL0jNxpweaKGaxSTvjpNOfyr6kj+W4VmJvtYb1rWAI
         7MgIh+mPMfNzK44yJcIaVK6Pt68QB3OrDLkTFdjlr7p8Yr0kOUgBUpiDCTyJGORfwoNf
         ayDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkWWW7uvH9M/3NMutwpknlXCtyfjYS2suxokJOZOOWM=;
        b=sTCOBwL17UjHWbmT9mTmKYTYsdXMWvTmT/LLrVOlryWUamyR7ud4c6TkG22Kgv/WjD
         RzI5gtw11FjJ0zkeHzyXM5V2wtKc6GHi1qfT8v1Va7XorhzmiTdhbgC7gKKXaJr6BEqV
         gO9jPbALM8pMPzyEptX6Nrl7XzilOEN02wrYmlmfjgIgNVNiT/2utCpiUp2ZgTJ7QJZY
         fodRB7QHENoShTom2+sDWdPrR6zYcyzTa4/CH/CyFpa4BBuvy87bC2Bpop7luO6syZBn
         8T3LZiFJiHH9RMRfvWZ9UPXpBDL9TNzNd1QamSHxiXAyIvfmLvJaqKGrrxrpzXy6ggdj
         9PsQ==
X-Gm-Message-State: AOAM533GzChwqlproIOYgElm+zlJdF/2RkPy5oyxpvbt5tgQ0MfndzYQ
	F55Vjh9jkk/RxV9EgwhKY+EUu1+u4c0ijBwZqf0=
X-Google-Smtp-Source: ABdhPJxmiIOsPBPsxSPH5nawCReCIz8587tWn6K4qlyVqUFbpUpkR1T3o5YUYpN3kbnyNrmV+ItZd4zq3EpgKzerRyM=
X-Received: by 2002:aed:37a3:: with SMTP id j32mr9697617qtb.133.1600354646321;
 Thu, 17 Sep 2020 07:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz>
In-Reply-To: <20200917104216.GB16097@quack2.suse.cz>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 17 Sep 2020 22:57:15 +0800
Message-ID: <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: MNEFDWT52AH53DTDYKNWP4CIWIBWCDX3
X-Message-ID-Hash: MNEFDWT52AH53DTDYKNWP4CIWIBWCDX3
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MNEFDWT52AH53DTDYKNWP4CIWIBWCDX3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 6:42 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 17-09-20 02:28:57, Dan Williams wrote:
> > On Wed, Sep 16, 2020 at 8:15 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > DM was calling generic_fsdax_supported() to determine whether a device
> > > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > > they don't have to duplicate common generic checks. High level code
> > > should call dax_supported() helper which that calls into appropriate
> > > helper for the particular device. This problem manifested itself as
> > > kernel messages:
> > >
> > > dm-3: error: dax access failed (-95)
> > >
> > > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > > another DM device.
> > >
> > > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  drivers/dax/super.c   |  4 ++++
> > >  drivers/md/dm-table.c |  3 +--
> > >  include/linux/dax.h   | 11 +++++++++--
> > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > > This patch should go in together with Adrian's
> > > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> > >
> > > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > > index e5767c83ea23..b6284c5cae0a 100644
> > > --- a/drivers/dax/super.c
> > > +++ b/drivers/dax/super.c
> > > @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
> > >  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > >                 int blocksize, sector_t start, sector_t len)
> > >  {
> > > +       if (!dax_dev)
> > > +               return false;
> > > +
> >
> > Hi Jan, Thanks for this.
> >
> > >         if (!dax_alive(dax_dev))
> > >                 return false;
> >
> > One small fixup to quiet lockdep because dax_supported() calls
> > dax_alive() it expects that dax_read_lock() is held. So I'm testing
> > with this incremental change:
> >
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index bed1ff0744ec..229f461e7def 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -860,9 +860,14 @@ EXPORT_SYMBOL_GPL(dm_table_set_type);
> >  int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
> >                         sector_t start, sector_t len, void *data)
> >  {
> > -       int blocksize = *(int *) data;
> > +       int blocksize = *(int *) data, id;
> > +       bool rc;
> >
> > -       return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > +       id = dax_read_lock();
> > +       rc = dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > +       dax_read_unlock(id);
> > +
> > +       return rc;
> >  }
>
> Yeah, thanks for this! I was actually looking into this when writing the
> patch and somehow convinced myself we will always be called through
> bdev_dax_supported() which does dax_read_lock() for us. But apparently I
> was wrong...

Hold on. This patch hit another regression when I ran the full test of
the lvm2-testsuite tool today.

After checking the test log, the task was blocked for more than 120
seconds when running the command 'pvmove --abort' of the script
'pvmove-abort-all.sh'.

Note: Still no lock after applying Dan's fixup. It shows the same call
trace with/without Dan's fixup.

[  375.623646] INFO: task lvm:12573 blocked for more than 122 seconds.
[  375.630685]       Not tainted 5.9.0-rc5+ #25
[  375.635467] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  375.644223] task:lvm             state:D stack:    0 pid:12573
ppid:     1 flags:0x00000080
[  375.653561] Call Trace:
[  375.656342]  __schedule+0x278/0x740
[  375.660261]  ? ttwu_do_wakeup+0x19/0x150
[  375.664653]  schedule+0x40/0xb0
[  375.668173]  schedule_timeout+0x25f/0x300
[  375.672665]  ? __queue_work+0x13a/0x3e0
[  375.676950]  wait_for_completion+0x8d/0xf0
[  375.681538]  __synchronize_srcu.part.21+0x81/0xb0
[  375.686804]  ? __bpf_trace_rcu_utilization+0x10/0x10
[  375.692356]  ? synchronize_srcu+0x59/0xf0
[  375.696877]  __dm_suspend+0x56/0x1d0 [dm_mod]
[  375.701759]  ? table_load+0x2e0/0x2e0 [dm_mod]
[  375.706735]  dm_suspend+0xa5/0xd0 [dm_mod]
[  375.711324]  dev_suspend+0x14d/0x290 [dm_mod]
[  375.716202]  ctl_ioctl+0x1af/0x420 [dm_mod]
[  375.720892]  ? iomap_write_begin+0x4c0/0x4c0
[  375.725675]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[  375.730352]  __x64_sys_ioctl+0x84/0xb1
[  375.734551]  do_syscall_64+0x33/0x40
[  375.738557]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  375.744212] RIP: 0033:0x7f0106eee87b
[  375.748206] Code: Bad RIP value.
[  375.751822] RSP: 002b:00007ffe10ff4498 EFLAGS: 00000206 ORIG_RAX:
0000000000000010
[  375.760286] RAX: ffffffffffffffda RBX: 0000564c3aebb260 RCX: 00007f0106eee87b
[  375.768262] RDX: 0000564c3c4220c0 RSI: 00000000c138fd06 RDI: 0000000000000004
[  375.776237] RBP: 0000564c3af694fe R08: 0000564c3c3461f0 R09: 00007f0108cfd980
[  375.784206] R10: 000000000000000a R11: 0000000000000206 R12: 0000000000000000
[  375.792181] R13: 0000564c3c4220f0 R14: 0000564c3c4220c0 R15: 0000564c3c4148c0

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
