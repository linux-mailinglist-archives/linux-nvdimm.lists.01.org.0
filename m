Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52DA28D4B3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Oct 2020 21:41:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEC32159591AE;
	Tue, 13 Oct 2020 12:41:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::642; helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ADBD3159591AD
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 12:41:50 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so1403551ejb.12
        for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 12:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlOzF1QhqikCoQxsvfJV6M6Hjgbrow9dB9uNs1AoGLE=;
        b=kTjS5KS3nYcf/wrvTsuRt1BvzGw557kJOoPvyzYoBgiqb4b8bKtbI2/mMLiZYyRjFR
         J9ydTuu0x47x+MEvbUBFhFH3/2QgRWgMVRtg9k6OLuYDe131Mp/cuPa30fJMGhSFjepr
         cqBBXWNROTwzHkSN49lY/psarWhxU27El5EYWXEJaiWvhTqo66L6QK98x3Y0Yvi2nF9y
         UTW/CUag9LBP+VfPW+1mn8JfLpPCSXoAzeg5FBjWoJMu0+7UEW9Ka5T8iigFwOd+JDvR
         rrctnvxFOZW164mxjZq4IMmZGZxG4l2jAUbsCf6skOMzcKIRAwJ8OakZ/jL0rfexuXSd
         7ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlOzF1QhqikCoQxsvfJV6M6Hjgbrow9dB9uNs1AoGLE=;
        b=QIx+r+RiMTqFxZswSFr2wFQtebMt6S5pbBlodz7KIhLxeS1wapx7JH0iRZiswqnXbC
         UbxYM357/bfVw+czIxeBmcE9jcH6YiZWsU/BvBS3uWq/zKmHzLLVfDScVBlkYdI/Izgp
         /l/Y0+G2envWqmzqcuWxkeNx1V4bVkA1IYk5cvjTlsnJxyX+w6F1JVs9d5najOr1y0CQ
         CMcSoVydZc0lp1faPMJ+2t7xvC0+M147892aTRx9VgPEFQFCRUTI4qjCMPCKcvQKn/xG
         z2G/bvk7734a35q+/eQK+s2IK54HLZZV6YcJdA2xdU1/uFxskV8TXQ2OeCW+2WlMWiU0
         ti+Q==
X-Gm-Message-State: AOAM533xB10TnlitjCr+7i0s97JjM6b9irCfK7yioaz4DWUJ9azIy8O3
	Yi7Q8O9PD3I2uoH0wFHr9Hp/zQRhAh/sx+pp396Vmw==
X-Google-Smtp-Source: ABdhPJxGxhMZ7o2BYtIDXOupUr3pSHVXck0tIwC9HMZ0nIbp0pU6AQKRljKqMwVkoxmX0BYp74elTVEnpYvo3LWFH24=
X-Received: by 2002:a17:906:7e47:: with SMTP id z7mr1390518ejr.418.1602618108255;
 Tue, 13 Oct 2020 12:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201009195033.3208459-1-ira.weiny@intel.com> <20201009195033.3208459-34-ira.weiny@intel.com>
 <CAPcyv4gL3jfw4d+SJGPqAD3Dp4F_K=X3domuN4ndAA1FQDGcPg@mail.gmail.com> <20201013193643.GK20115@casper.infradead.org>
In-Reply-To: <20201013193643.GK20115@casper.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 13 Oct 2020 12:41:36 -0700
Message-ID: <CAPcyv4gL70FcLe8az7ezmpcZV=bG0Cka7daKWcCdmV4GoenSZw@mail.gmail.com>
Subject: Re: [PATCH RFC PKS/PMEM 33/58] fs/cramfs: Utilize new kmap_thread()
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: IUP7IBNBIWE4QDKXZ3QU5GQPWUTT22BE
X-Message-ID-Hash: IUP7IBNBIWE4QDKXZ3QU5GQPWUTT22BE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nico@fluxnic.net>, X86 ML <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi <linux-efi@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
  target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-afs@lists.infradead.org, linux-rdma <linux-rdma@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IUP7IBNBIWE4QDKXZ3QU5GQPWUTT22BE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 12:37 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 13, 2020 at 11:44:29AM -0700, Dan Williams wrote:
> > On Fri, Oct 9, 2020 at 12:52 PM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > The kmap() calls in this FS are localized to a single thread.  To avoid
> > > the over head of global PKRS updates use the new kmap_thread() call.
> > >
> > > Cc: Nicolas Pitre <nico@fluxnic.net>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/cramfs/inode.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> > > index 912308600d39..003c014a42ed 100644
> > > --- a/fs/cramfs/inode.c
> > > +++ b/fs/cramfs/inode.c
> > > @@ -247,8 +247,8 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
> > >                 struct page *page = pages[i];
> > >
> > >                 if (page) {
> > > -                       memcpy(data, kmap(page), PAGE_SIZE);
> > > -                       kunmap(page);
> > > +                       memcpy(data, kmap_thread(page), PAGE_SIZE);
> > > +                       kunmap_thread(page);
> >
> > Why does this need a sleepable kmap? This looks like a textbook
> > kmap_atomic() use case.
>
> There's a lot of code of this form.  Could we perhaps have:
>
> static inline void copy_to_highpage(struct page *to, void *vfrom, unsigned int size)
> {
>         char *vto = kmap_atomic(to);
>
>         memcpy(vto, vfrom, size);
>         kunmap_atomic(vto);
> }
>
> in linux/highmem.h ?

Nice, yes, that could also replace the local ones in lib/iov_iter.c
(memcpy_{to,from}_page())
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
