Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44143628FA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 21:57:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BB6E100EAB72;
	Fri, 16 Apr 2021 12:57:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.46; helo=mail-ej1-f46.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6F16100EBBC1
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 12:57:17 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id sd23so35143241ejb.12
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l12BmPzjPGQPhOVAK1+pGnVg6YOohJn2PXow4I2KCwo=;
        b=nQnk4fUrtR73OTn0Bked0GsH77E4CU2Aryt7NrztyQzLtex0tRik3lEi7dybmcBzRH
         imUnySkDeWbLpm1SmLfQ939xsEAUlHIlrHZFouijtfVnEwwG/v4ZQfXaj+HSc8sr43j+
         v+8FG6MhnCm6G5B8vHIVVyp4FpcXRY7PYCkB9DDvlM+eVLprbZBp++dJAbMAVMCt5SYF
         q/qG9Xpz56IlrdEJbFFzzSPDCCvk4OjPw1eqpC1um+tl/xs3BG0Rvpm0vl3JBc7b9mtP
         P0H2tUoAEcqxONVhFCzFwaQG92PxbLWuDF0PKMf+1CmUgDTeVky9AKb8XU42U9NOfxiW
         nrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l12BmPzjPGQPhOVAK1+pGnVg6YOohJn2PXow4I2KCwo=;
        b=R6EgH5ZpMuenQw0DQWhsadSqdfJB6D9aV9iEx1Yx1CyYiE1/Yrz6bqIZOA5Np33qfF
         xGM2uUBn3YxRfoJeTtYeqL5vvWEt5b5+YWEZQ9YRtnnfUygiBDJsUFzlQcBu9Nyaahzf
         dAYhdIpUgGTu2+UHBNJUpZxy6OJjWPXXw7/5dhtlsqnSfTL2KxVyx0oV5/Vdrko/dkYC
         1avxhIrH7C/Oz7K0FhC0bqyxD2uWXzBRzufjIDZfjA5SNJq30EbsFEFWqVCaPC6eKpP3
         yQAdK96qaGnUBq2jUXB5Y99lIgRMbvvSgQYb6Q34QD0/HRJGmted9Vl3YNcYs54aFt2l
         C6Ww==
X-Gm-Message-State: AOAM530t9ejDiDe9V3WGqleXnR1t3/dHho8eOyERha3JACausU0qQbPa
	GxUFMXl/Ih1B3qQycaoWr+f32WsXjDaFdo0eO5PARQ==
X-Google-Smtp-Source: ABdhPJyQvyIq/sIJGlqAF2MfMI37oI2jAKdM4rT3dS8JIUJ3W5auOyWaYVKZc/Khipbuc/aofSL7uwOHc1OwxgnwwFo=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr9952113ejc.418.1618602976235;
 Fri, 16 Apr 2021 12:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210416173524.GA1379987@redhat.com>
In-Reply-To: <20210416173524.GA1379987@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 12:56:05 -0700
Message-ID: <CAPcyv4h77oTMBQ50wg6eHLpkFMQ16oAHg2+D=d5zshT6iWgAfw@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed wakeup in put_unlocked_entry()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: 2APO3ZSWPTCWFDC5F4FZFTSSZ77YYSRJ
X-Message-ID-Hash: 2APO3ZSWPTCWFDC5F4FZFTSSZ77YYSRJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, virtio-fs-list <virtio-fs@redhat.com>, Sergio Lopez <slp@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2APO3ZSWPTCWFDC5F4FZFTSSZ77YYSRJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 10:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> I am seeing missed wakeups which ultimately lead to a deadlock when I am
> using virtiofs with DAX enabled and running "make -j". I had to mount
> virtiofs as rootfs and also reduce to dax window size to 32M to reproduce
> the problem consistently.
>
> This is not a complete patch. I am just proposing this partial fix to
> highlight the issue and trying to figure out how it should be fixed.
> Should it be fixed in generic dax code or should filesystem (fuse/virtiofs)
> take care of this.
>
> So here is the problem. put_unlocked_entry() wakes up waiters only
> if entry is not null as well as !dax_is_conflict(entry). But if I
> call multiple instances of invalidate_inode_pages2() in parallel,
> then I can run into a situation where there are waiters on
> this index but nobody will wait these.
>
> invalidate_inode_pages2()
>   invalidate_inode_pages2_range()
>     invalidate_exceptional_entry2()
>       dax_invalidate_mapping_entry_sync()
>         __dax_invalidate_entry() {
>                 xas_lock_irq(&xas);
>                 entry = get_unlocked_entry(&xas, 0);
>                 ...
>                 ...
>                 dax_disassociate_entry(entry, mapping, trunc);
>                 xas_store(&xas, NULL);
>                 ...
>                 ...
>                 put_unlocked_entry(&xas, entry);
>                 xas_unlock_irq(&xas);
>         }
>
> Say a fault in in progress and it has locked entry at offset say "0x1c".
> Now say three instances of invalidate_inode_pages2() are in progress
> (A, B, C) and they all try to invalidate entry at offset "0x1c". Given
> dax entry is locked, all tree instances A, B, C will wait in wait queue.
>
> When dax fault finishes, say A is woken up. It will store NULL entry
> at index "0x1c" and wake up B. When B comes along it will find "entry=0"
> at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
> this means put_unlocked_entry() will not wake up next waiter, given
> the current code. And that means C continues to wait and is not woken
> up.
>
> In my case I am seeing that dax page fault path itself is waiting
> on grab_mapping_entry() and also invalidate_inode_page2() is
> waiting in get_unlocked_entry() but entry has already been cleaned
> up and nobody woke up these processes. Atleast I think that's what
> is happening.
>
> This patch wakes up a process even if entry=0. And deadlock does not
> happen. I am running into some OOM issues, that will debug.
>
> So my question is that is it a dax issue and should it be fixed in
> dax layer. Or should it be handled in fuse to make sure that
> multiple instances of invalidate_inode_pages2() on same inode
> don't make progress in parallel and introduce enough locking
> around it.
>
> Right now fuse_finish_open() calls invalidate_inode_pages2() without
> any locking. That allows it to make progress in parallel to dax
> fault path as well as allows multiple instances of invalidate_inode_pages2()
> to run in parallel.
>
> Not-yet-signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c  2021-04-16 12:50:40.141363317 -0400
> +++ redhat-linux/fs/dax.c       2021-04-16 12:51:42.385926390 -0400
> @@ -266,9 +266,10 @@ static void wait_entry_unlocked(struct x
>
>  static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
> -       /* If we were the only waiter woken, wake the next one */
> -       if (entry && !dax_is_conflict(entry))
> -               dax_wake_entry(xas, entry, false);
> +       if (dax_is_conflict(entry))
> +               return;
> +
> +       dax_wake_entry(xas, entry, false);

How does this work if entry is NULL? dax_entry_waitqueue() will not
know if it needs to adjust the index. I think the fix might be to
specify that put_unlocked_entry() in the invalidate path needs to do a
wake_up_all().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
