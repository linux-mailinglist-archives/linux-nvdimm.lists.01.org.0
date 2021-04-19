Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DF364AC3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 21:49:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 015A0100EB845;
	Mon, 19 Apr 2021 12:49:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C987A100EB835
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 12:49:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd23so46117864ejb.12
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pRdHORbMnYGgpAEqFhWtNH9/sxU/zrFmn1etVSS8ec=;
        b=pbgttAEz2va7NMNY0DPCjAIrN3cvwgh1vLPTHCTYGogu5LS30biP0lrPVzo2ndKVug
         c910hP3lyskv2p9CsZZmtyPWoONAJwqaunWQvnjFhjIX0Q5yZ5SChmgdBzPdhSyUJoj1
         N3Sg+EygRrSverxWz+odjeJVoGWYQmzDyrbb4Xso5/JC8GcrmocAQUAI9cAzpzoQutzT
         2xRp+1GLcu4i3ZpQVcRvSUUEnMYkP6bhFS1FBvK2WyY2dmofMG+PRGN1HZzKDoVhs+od
         o9kzI7900pFwR78M2AFerahttXmuiaLedpc5P76RshFxO1Y3+hRfMsGLOUEcZgyZvF35
         hCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pRdHORbMnYGgpAEqFhWtNH9/sxU/zrFmn1etVSS8ec=;
        b=AtqCm1Xk7+OQ2kgRwlGtb1FVGBI/h7TUzXBugYEgKZvGxPTT55w23uYMqCUzIvbau8
         7oBoM5QpfJ7HoiYVn0PeRUQLjWcRB6vtSqzAs0LHj0BmreL/RH18/x2G49gr+zIjRllA
         85RTVHc0BYxpLDUK+4ewLnn4NLsSQb5CLH1rORrhVkmRyXG4ioLhiZ7me5AJrlShwXdZ
         hxeqOc0yi3EHy1ysXpx9pzOvIJUWLq79KXufLZl3ZC7QnFfGArNm4DZ9IvYlKi+TLWHQ
         8Q46wcDbcSKpwsS08e9qaXO0C3E4kKdgLXAy+ShN23dq/i2OMQ1dmKADAVPUFHbKkcGc
         YKHQ==
X-Gm-Message-State: AOAM530Nszh2PGRvTR6Fs62qWX9Rz7UDgcqtVy0PfZbY65MYzSu7fTQ0
	3hPCArkycqAqP5w12lpCmyasqDxNDpoZMHY864pNlg==
X-Google-Smtp-Source: ABdhPJw0kWSefwOb928/NEJy0zoj/ddLUSgM8SbRvl82iPLTA2/huvDl9OCcxhXSBS6EtSGZbyr13FXYLv8LlMcG2WM=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr23809461ejc.418.1618861748396;
 Mon, 19 Apr 2021 12:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210419184516.GC1472665@redhat.com>
In-Reply-To: <20210419184516.GC1472665@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 19 Apr 2021 12:48:58 -0700
Message-ID: <CAPcyv4jR5d+-99wVMm9SHxNBOsp0FUi7wzDNsefkZ1oqUZ7joQ@mail.gmail.com>
Subject: Re: [PATCH][v2] dax: Fix missed wakeup during dax entry invalidation
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: PCTASMSS475YYNBOBW4SBQFCD54VR52E
X-Message-ID-Hash: PCTASMSS475YYNBOBW4SBQFCD54VR52E
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, virtio-fs-list <virtio-fs@redhat.com>, Sergio Lopez <slp@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PCTASMSS475YYNBOBW4SBQFCD54VR52E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 19, 2021 at 11:45 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This is V2 of the patch. Posted V1 here.
>
> https://lore.kernel.org/linux-fsdevel/20210416173524.GA1379987@redhat.com/
>
> Based on feedback from Dan and Jan, modified the patch to wake up
> all waiters when dax entry is invalidated. This solves the issues
> of missed wakeups.

Care to send a formal patch with this commentary moved below the --- line?

One style fixup below...

>
> I am seeing missed wakeups which ultimately lead to a deadlock when I am
> using virtiofs with DAX enabled and running "make -j". I had to mount
> virtiofs as rootfs and also reduce to dax window size to 256M to reproduce
> the problem consistently.
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
> This patch fixes the issue by waking up all waiters when a dax entry
> has been invalidated. This seems to fix the deadlock I am facing
> and I can make forward progress.
>
> Reported-by: Sergio Lopez <slp@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Index: redhat-linux/fs/dax.c
> ===================================================================
> --- redhat-linux.orig/fs/dax.c  2021-04-16 14:16:44.332140543 -0400
> +++ redhat-linux/fs/dax.c       2021-04-19 11:24:11.465213474 -0400
> @@ -264,11 +264,11 @@ static void wait_entry_unlocked(struct x
>         finish_wait(wq, &ewait.wait);
>  }
>
> -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> +static void put_unlocked_entry(struct xa_state *xas, void *entry, bool wake_all)
>  {
>         /* If we were the only waiter woken, wake the next one */
>         if (entry && !dax_is_conflict(entry))
> -               dax_wake_entry(xas, entry, false);
> +               dax_wake_entry(xas, entry, wake_all);
>  }
>
>  /*
> @@ -622,7 +622,7 @@ struct page *dax_layout_busy_page_range(
>                         entry = get_unlocked_entry(&xas, 0);
>                 if (entry)
>                         page = dax_busy_page(entry);
> -               put_unlocked_entry(&xas, entry);
> +               put_unlocked_entry(&xas, entry, false);

I'm not a fan of raw true/false arguments because if you read this
line in isolation you need to go read put_unlocked_entry() to recall
what that argument means. So lets add something like:

/**
 * enum dax_entry_wake_mode: waitqueue wakeup toggle
 * @WAKE_NEXT: entry was not mutated
 * @WAKE_ALL: entry was invalidated, or resized
 */
enum dax_entry_wake_mode {
        WAKE_NEXT,
        WAKE_ALL,
}

...and use that as the arg for dax_wake_entry(). So I'd expect this to
be a 3 patch series, introduce dax_entry_wake_mode for
dax_wake_entry(), introduce the argument for put_unlocked_entry()
without changing the logic, and finally this bug fix. Feel free to add
'Fixes: ac401cc78242 ("dax: New fault locking")' in case you feel this
needs to be backported.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
