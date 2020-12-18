Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEE2DDD42
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 04:25:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC4FB100EB327;
	Thu, 17 Dec 2020 19:25:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BB8D100EB849
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 19:25:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g24so865350edw.9
        for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 19:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhUj1gglXZ8plw8ZF3ZHmuSToHFaNfIDtriAhPDEyBY=;
        b=eEmjQtLfa5k2PbDhM81GyqYafirdENOsX8DqJUjrSQ9/8TDcbUq8Edk7GvKegHrM14
         LlgroWfhdgAq3IIb8w9YYjiLGo+7gqURKctED9rbATgne/gGsgYMhMeM6DgQO/Jhxgvu
         /NnjTFr1lEasN3USV7Ou3/jHmXpmA+F8vReqT5r7jz+1U3y9a6ZEocs0TeI7gFL8AdI1
         dCVHEm4jUYfk6VxXFgRkoXOuFXEJUSJZHh1B5GhlY6yMRFLCS6YOOBPt0I6ekjVN4dcA
         CddJXFYmNQtWfQywNjuTWt/xVAwmb+BqdGIVnqOmQaZHyti1PKeFZUBhfdgIocA+37al
         gM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhUj1gglXZ8plw8ZF3ZHmuSToHFaNfIDtriAhPDEyBY=;
        b=XQsz/ZSjcATkvDqFYVjtjrECjLtgZzF8Yk5kCXAcS0U8o2hIY42kIiNnkQZlYxU1S9
         pjAuoBLmkcPQZJq2V5MKfJxIEqH4nRWSDRfAITGEJ5x2x27KrWQWK0k1caAxoffIkq84
         tqm5O0vQoxDiOKC70Z3f3ZezVPGjVBAcSU2jH/ueg+pfoHRLNzv8LfR3Cmqen7Xvt9ip
         Gf4C9kADJBKIjKrU1XEzR1vQDPmruiJSei41X1qAAPQZfGvmdlVJMIBVrV4dX5mHtxty
         Bc+YbLS156nhSOh5RgqhtPEfsmoN90o8mNipwAl/DGhx2/pZqTq5pP8DzuySdQEWbykP
         PQ6A==
X-Gm-Message-State: AOAM533jxlroydQ+LjMAcXxKg+uA8Rxb2j8DnbLWbWGEouWpLBT9MGAZ
	ePM2p6ZaMY5uq0Bg+l2O8M+ZCGuxdnj76+WvxVsx6k9R5C9eRA==
X-Google-Smtp-Source: ABdhPJxZJvTesamT0YBolgVHCjTCTD3hA7/y8Wk1BML7hvO196NDNWdKDU2pZ85kuQtAx5y2wIEUQas1uI6/DF6SqEk=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr2389017edr.97.1608261924948;
 Thu, 17 Dec 2020 19:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20201203171535.67715-1-colyli@suse.de>
In-Reply-To: <20201203171535.67715-1-colyli@suse.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Dec 2020 19:25:14 -0800
Message-ID: <CAPcyv4j6n-ZQMS3b3JoRGcr6kEFdHxtLqimyouMP93KXLZFamA@mail.gmail.com>
Subject: Re: [RFC PATCH] badblocks: Improvement badblocks_set() for handling
 multiple ranges
To: Coly Li <colyli@suse.de>
Message-ID-Hash: RLNKNOUR3Y6LRDQEBRPJNSSPY66PWPGT
X-Message-ID-Hash: RLNKNOUR3Y6LRDQEBRPJNSSPY66PWPGT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, NeilBrown <neilb@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RLNKNOUR3Y6LRDQEBRPJNSSPY66PWPGT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add Neil, original gooodguy who wrote badblocks ]


On Thu, Dec 3, 2020 at 9:16 AM Coly Li <colyli@suse.de> wrote:
>
> Recently I received a bug report that current badblocks code does not
> properly handle multiple ranges. For example,
>         badblocks_set(bb, 32, 1, true);
>         badblocks_set(bb, 34, 1, true);
>         badblocks_set(bb, 36, 1, true);
>         badblocks_set(bb, 32, 12, true);
> Then indeed badblocks_show() reports,
>         32 3
>         36 1
> But the expected bad blocks table should be,
>         32 12
> Obviously only the first 2 ranges are merged and badblocks_set() returns
> and ignores the rest setting range.
>
> This behavior is improper, if the caller of badblocks_set() wants to set
> a range of blocks into bad blocks table, all of the blocks in the range
> should be handled even the previous part encountering failure.
>
> The desired way to set bad blocks range by badblocks_set() is,
> - Set as many as blocks in the setting range into bad blocks table.
> - Merge the bad blocks ranges and occupy as less as slots in the bad
>   blocks table.
> - Fast.
>
> Indeed the above proposal is complicated, especially with the following
> restrictions,
> - The setting bad blocks range can be ackknowledged or not acknowledged.

s/ackknowledged/acknowledged/

I'd run checkpatch --codespell for future versions...

> - The bad blocks table size is limited.
> - Memory allocation should be avoided.
>
> This patch is an initial effort to improve badblocks_set() for setting
> bad blocks range when it covers multiple already set bad ranges in the
> bad blocks table, and to do it as fast as possible.
>
> The basic idea of the patch is to categorize all possible bad blocks
> range setting combinationsinto to much less simplified and more less
> special conditions. Inside badblocks_set() there is an implicit loop
> composed by jumping between labels 're_insert' and 'update_sectors'. No
> matter how large the setting bad blocks range is, in every loop just a
> minimized range from the head is handled by a pre-defined behavior from
> one of the categorized conditions. The logic is simple and code flow is
> manageable.
>
> This patch is unfinished yet, it only improves badblocks_set() and not
> touch badblocks_clear() and badblocks_show() yet. I post it earlier
> because this patch will be large (more then 1000 lines of change), I
> want more people to give me comments earlier before I go too far away.
>

I wonder if this isn't indication that the base data structure should
be replaced... but I have not had a chance to devote deeper thought to
this.


> The code logic is tested as user space programmer, this patch passes
> compiling but not tested in kernel mode yet. Right now it is only for
> RFC purpose. I will post tested patch in further versions.
>
> Thank you in advance for any review or comments on this patch.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  block/badblocks.c         | 1041 ++++++++++++++++++++++++++++++-------
>  include/linux/badblocks.h |   33 ++
>  2 files changed, 881 insertions(+), 193 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index d39056630d9c..04ccae95777d 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -5,6 +5,8 @@
>   * - Heavily based on MD badblocks code from Neil Brown
>   *
>   * Copyright (c) 2015, Intel Corporation.
> + *
> + * Improvement for handling multiple ranges by Coly Li <colyli@suse.de>
>   */
>
>  #include <linux/badblocks.h>
> @@ -16,114 +18,612 @@
>  #include <linux/types.h>
>  #include <linux/slab.h>
>
> -/**
> - * badblocks_check() - check a given range for bad sectors
> - * @bb:                the badblocks structure that holds all badblock information
> - * @s:         sector (start) at which to check for badblocks
> - * @sectors:   number of sectors to check for badblocks
> - * @first_bad: pointer to store location of the first badblock
> - * @bad_sectors: pointer to store number of badblocks after @first_bad
> +/*
> + * The purpose of badblocks set/clear is to manage bad blocks ranges which are
> + * identified by LBA addresses.
>   *
> - * We can record which blocks on each device are 'bad' and so just
> - * fail those blocks, or that stripe, rather than the whole device.
> - * Entries in the bad-block table are 64bits wide.  This comprises:
> - * Length of bad-range, in sectors: 0-511 for lengths 1-512
> - * Start of bad-range, sector offset, 54 bits (allows 8 exbibytes)
> - *  A 'shift' can be set so that larger blocks are tracked and
> - *  consequently larger devices can be covered.
> - * 'Acknowledged' flag - 1 bit. - the most significant bit.
> + * When the caller of badblocks_set() wants to set a range of bad blocks, the
> + * setting range can be acked or unacked. And the setting range may merge,
> + * overwrite, skip the overlaypped already set range, depends on who they are
> + * overlapped or adjacent, and the acknowledgment type of the ranges. It can be
> + * more complicated when the setting range covers multiple already set bad block
> + * ranges, with restritctions of maximum length of each bad range and the bad
> + * table space limitation.
>   *
> - * Locking of the bad-block table uses a seqlock so badblocks_check
> - * might need to retry if it is very unlucky.
> - * We will sometimes want to check for bad blocks in a bi_end_io function,
> - * so we use the write_seqlock_irq variant.
> + * It is difficut and unnecessary to take care of all the possible situations,
> + * for setting a large range of bad blocks, we can handle it by dividing the
> + * large range into smaller ones when encounter overlap, max range length or
> + * bad table full conditions. Every time only a smaller piece of the bad range
> + * is handled with a limited number of conditions how it is interacted with
> + * possible overlapped or adjacent already set bad block ranges. Then the hard
> + * complicated problem can be much simpler to habndle in proper way.
>   *
> - * When looking for a bad block we specify a range and want to
> - * know if any block in the range is bad.  So we binary-search
> - * to the last range that starts at-or-before the given endpoint,
> - * (or "before the sector after the target range")
> - * then see if it ends after the given start.
> + * When setting a range of bad blocks to the bad table, the simplified situations
> + * to be considered are, (The already set bad blocks ranges are naming with
> + *  prefix E, and the setting bad blocks range is naming with prefix S)
> + *
> + * 1) A setting range is not overlapped or adjacent to any other already set bad
> + *    block range.
> + *                         +--------+
> + *                         |    S   |
> + *                         +--------+
> + *        +-------------+               +-------------+
> + *        |      E1     |               |      E2     |
> + *        +-------------+               +-------------+
> + *    For this situation if the bad blocks table is not full, just allocate a
> + *    free slot from the bad blocks table to mark the setting range S. The
> + *    result is,
> + *        +-------------+  +--------+   +-------------+
> + *        |      E1     |  |    S   |   |      E2     |
> + *        +-------------+  +--------+   +-------------+
> + * 2) A setting range starts exactly at a start LBA of an already set bad blocks
> + *    range.
> + * 2.1) The setting range size < already set range size
> + *        +--------+
> + *        |    S   |
> + *        +--------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.1.1) If S and E are both acked or unacked range, the setting range S can
> + *    be merged into existing bad range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.1.2) If S is uncked setting and E is acked, the setting will be dinied, and
> + *    the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.1.3) If S is acked setting and E is unacked, range S can overwirte on E.
> + *    An extra slot from the bad blocks table will be allocated for S, and head
> + *    of E will move to end of the inserted range E. The result is,
> + *        +--------+----+
> + *        |    S   | E  |
> + *        +--------+----+
> + * 2.2) The setting range size == already set range size
> + * 2.2.1) If S and E are both acked or unacked range, the setting range S can
> + *    be merged into existing bad range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.2.2) If S is uncked setting and E is acked, the setting will be dinied, and
> + *    the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.2.3) If S is acked setting and E is unacked, range S can overwirte all of
> +      bad blocks range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.3) The setting range size > already set range size
> + *        +-------------------+
> + *        |          S        |
> + *        +-------------------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + *    For such situation, the setting range S can be treated as two parts, the
> + *    first part (S1) is as same size as the already set range E, the second
> + *    part (S2) is thre rest of setting range.
> + *        +-------------+-----+        +-------------+       +-----+
> + *        |    S1       | S2  |        |     S1      |       | S2  |
> + *        +-------------+-----+  ===>  +-------------+       +-----+
> + *        +-------------+              +-------------+
> + *        |      E      |              |      E      |
> + *        +-------------+              +-------------+
> + *    Now we only focus on how to handle the setting range S1 and already set
> + *    range E, which are already explained in 1.2), for the rest S2 it will be
> + *    handled later in next loop.
> + * 3) A setting range starts before the start LBA of an already set bad blocks
> + *    range.
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + *             +-------------+
> + *             |      E      |
> + *             +-------------+
> + *    For this situation, the setting range S can be divided into two parts, the
> + *    first (S1) ends at the start LBA of already set range E, the second part
> + *    (S2) starts exactly at a start LBA of the already set range E.
> + *        +----+---------+             +----+      +---------+
> + *        | S1 |    S2   |             | S1 |      |    S2   |
> + *        +----+---------+      ===>   +----+      +---------+
> + *             +-------------+                     +-------------+
> + *             |      E      |                     |      E      |
> + *             +-------------+                     +-------------+
> + *    Now only the first part S1 should be handled in this loop, which is in
> + *    similar condition as 1). The rest part S2 has exact same start LBA address
> + *    of the already set range E, they will be handled in next loop in one of
> + *    situations in 2).
> + * 4) A setting range starts after the start LBA of an already set bad blocks
> + *    range.
> + * 4.1) If the setting range S exactly matches the tail part of already set bad
> + *    blocks range E, like the folowing chart shows,
> + *            +---------+
> + *            |   S     |
> + *            +---------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 4.1.1) If range S and E have same ackknowledg value (both acked or unacked),
> + *    they will be merged into one, the result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 4.1.2) If range E is acked and the setting range S is unacked, the setting
> + *    request of S will be rejected, the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 4.1.3) If range E is unacked, and the setting range S is acked, then S may
> + *    overwrite the overlapped range of E, the result is,
> + *        +---+---------+
> + *        | E |    S    |
> + *        +---+---------+
> + * 4.2) If the setting range S stays in middle of an already set range E, like
> + *    the following chart shows,
> + *             +----+
> + *             | S  |
> + *             +----+
> + *        +--------------+
> + *        |       E      |
> + *        +--------------+
> + * 4.2.1) If range S and E have same ackknowledg value (both acked or unacked),
> + *    they will be merged into one, the result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 4.2.2) If range E is acked and the setting range S is unacked, the setting
> + *    request of S will be rejected, the result is also,
> + *        +--------------+
> + *        |       E      |
> + *        +--------------+
> + * 4.2.3) If range E is unacked, and the setting range S is acked, then S will
> + *    inserted into middle of E and split previous range E into twp parts (E1
> + *    and E2), the result is,
> + *        +----+----+----+
> + *        | E1 |  S | E2 |
> + *        +----+----+----+
> + * 4.3) If the setting bad blocks range S is overlapped with an already set bad
> + *    blocks range E. The range S starts after the start LBA of range E, and
> + *    ends after the end LBA of range E, as the following chart shows,
> + *            +-------------------+
> + *            |          S        |
> + *            +-------------------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + *    For this situation the range S can be divided into two parts, the first
> + *    part (S1) ends at end range E, and the second part (S2) has rest range of
> + *    origin S.
> + *            +---------+---------+            +---------+      +---------+
> + *            |    S1   |    S2   |            |    S1   |      |    S2   |
> + *            +---------+---------+  ===>      +---------+      +---------+
> + *        +-------------+                  +-------------+
> + *        |      E      |                  |      E      |
> + *        +-------------+                  +-------------+
> + *     Now in this loop the setting range S1 and already set range E can be
> + *     handled as the situations 4), the rest range S2 will be handled in next
> + *     loop and ignored in this loop.
> + * 5) A setting bad blocks range S is adjacent to one or more already set bad
> + *    blocks range(s), and they are all acked or unacked range.
> + * 5.1) Front merge: If the already set bad blocks range E is before setting
> + *    range S and they are adjacent,
> + *                +------+
> + *                |  S   |
> + *                +------+
> + *        +-------+
> + *        |   E   |
> + *        +-------+
> + * 5.1.1) When total size of range S and E <= BB_MAX_LEN, and their acknowledge
> + *    values are same, the setting range S can front merges into range E. The
> + *    result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 5.1.2) Otherwise these two ranges cannot merge, just insert the setting
> + *    range S right after already set range E into the bad blocks table. The
> + *    result is,
> + *        +--------+------+
> + *        |   E    |   S  |
> + *        +--------+------+
> + * 6) Special cases which above conditions cannot handle
> + * 6.1) Multiple already set ranges may merge into less ones in a full bad table
> + *        +-------------------------------------------------------+
> + *        |                           S                           |
> + *        +-------------------------------------------------------+
> + *        |<----- BB_MAX_LEN ----->|
> + *                                 +-----+     +-----+   +-----+
> + *                                 | E1  |     | E2  |   | E3  |
> + *                                 +-----+     +-----+   +-----+
> + *     In the above example, when the bad blocks table is full, inserting the
> + *     first part of setting range S will fail because no more available slot
> + *     can be allocated from bad blocks table. In this situation a proper
> + *     setting method should be go though all the setting bad blocks range and
> + *     look for chance to merge already set ranges into less ones. When there
> + *     is available slot from bad blocks table, re-try again to handle more
> + *     setting bad blocks ranges as many as possible.
> + *        +------------------------+
> + *        |          S3            |
> + *        +------------------------+
> + *        |<----- BB_MAX_LEN ----->|
> + *                                 +-----+-----+-----+---+-----+--+
> + *                                 |       S1        |     S2     |
> + *                                 +-----+-----+-----+---+-----+--+
> + *     The above chart shows although the first part (S3) cannot be inserted due
> + *     to no-space in bad blocks table, but the following E1, E2 and E3 ranges
> + *     can be merged with rest part of S into less range S1 and S2. Now there is
> + *     1 free slot in bad blocks table.
> + *        +------------------------+-----+-----+-----+---+-----+--+
> + *        |           S3           |       S1        |     S2     |
> + *        +------------------------+-----+-----+-----+---+-----+--+
> + *     Since the bad blocks table is not full anymore, re-try again for the
> + *     origin setting range S. Now the setting range S3 can be inserted into the
> + *     bad blocks table with previous freed slot from multiple ranges merge.
> + * 6.2) Front merge after overwrite
> + *    In the following example, in bad blocks table, E1 is an acked bad blocks
> + *    range and E2 is an unacked bad blocks range, therefore they are not able
> + *    to merge into a larger range. The setting bad blocks range S is acked,
> + *    therefore part of E2 can be overwritten by S.
> + *                      +--------+
> + *                      |    S   |                             acknowledged
> + *                      +--------+                         S:       1
> + *              +-------+-------------+                   E1:       1
> + *              |   E1  |    E2       |                   E2:       0
> + *              +-------+-------------+
> + *     With previosu simplified routines, after overwiting part of E2 with S,
> + *     the bad blocks table should be (E3 is remaining part of E2 which is not
> + *     overwritten by S),
> + *                                                             acknowledged
> + *              +-------+--------+----+                    S:       1
> + *              |   E1  |    S   | E3 |                   E1:       1
> + *              +-------+--------+----+                   E3:       0
> + *     The above result is correct but not perfect. Range E1 and S in the bad
> + *     blocks table are all acked, merging them into a larger one range may
> + *     occupy less bad blocks table space and make badblocks_check() faster.
> + *     Therefore in such situation, after overwiting range S, the previous range
> + *     E1 should be checked for possible front combination. Then the ideal
> + *     result can be,
> + *              +----------------+----+                        acknowledged
> + *              |       E1       | E3 |                   E1:       1
> + *              +----------------+----+                   E3:       0
> + * 6.3) Behind merge: If the already set bad blocks range E is behind the setting
> + *    range S and they are adjacent. Normally we don't need to care about this
> + *    because front merge handles this while going though range S from head to
> + *    tail, except for the tail part of range S. When the setting range S are
> + *    fully handled, all the above simplified routine doesn't check whether the
> + *    tail LBA of range S is adjacent to the next already set range and not able
> + *    to them if they are mergeable.
> + *        +------+
> + *        |  S   |
> + *        +------+
> + *               +-------+
> + *               |   E   |
> + *               +-------+
> + *    For the above special stiuation, when the setting range S are all handled
> + *    and the loop ends, an extra check is necessary for whether next already
> + *    set range E is right after S and mergeable.
> + * 6.2.1) When total size of range E and S <= BB_MAX_LEN, and their acknowledge
> + *    values are same, the setting range S can behind merges into range E. The
> + *    result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 6.2.2) Otherwise these two ranges cannot merge, just insert the setting range
> + *     S infront of the already set range E in the bad blocks table. The result
> + *     is,
> + *        +------+-------+
> + *        |  S   |   E   |
> + *        +------+-------+
> + *
> + * All the above 5 simplified situations and 3 special cases may cover 99%+ of
> + * the bad block range setting conditions. Maybe there is some rare corner case
> + * is not considered and optimized, it won't hurt if badblocks_set() fails due
> + * to no space, or some ranges are not merged to save bad blocks table space.
> + *
> + * Inside badblocks_set() each loop starts by jumping to re_insert label, every
> + * time for the new loop prev_badblocks() is called to find an already set range
> + * which starts before or at current setting range. Since the setting bad blocks
> + * range is handled from head to tail, most of the cases it is unnecessary to do
> + * the binary search inside prev_badblocks(), it is possible to provide a hint
> + * to prev_badblocks() for a fast path, then the expensive binary search can be
> + * avoided. In my test with the hint to prev_badblocks(), except for the first
> + * loop, all rested calls to prev_badblocks() can go into the fast path and
> + * return correct bad blocks table index immediately.
>   *
> - * Return:
> - *  0: there are no known bad blocks in the range
> - *  1: there are known bad block which are all acknowledged
> - * -1: there are bad blocks which have not yet been acknowledged in metadata.
> - * plus the start/length of the first bad section we overlap.
>   */
> -int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
> -                       sector_t *first_bad, int *bad_sectors)
> +
> +static int prev_by_hint(struct badblocks *bb, sector_t s, int hint)
>  {
> -       int hi;
> -       int lo;
>         u64 *p = bb->page;
> -       int rv;
> -       sector_t target = s + sectors;
> -       unsigned seq;
> +       int ret = -1;
> +       int hint_end = hint + 2;
>
> -       if (bb->shift > 0) {
> -               /* round the start down, and the end up */
> -               s >>= bb->shift;
> -               target += (1<<bb->shift) - 1;
> -               target >>= bb->shift;
> -               sectors = target - s;
> +       while ((hint < hint_end) && ((hint + 1) <= bb->count) &&
> +              (BB_OFFSET(p[hint]) <= s)) {
> +               if ((hint + 1) == bb->count || BB_OFFSET(p[hint + 1]) > s) {
> +                       ret = hint;
> +                       break;
> +               }
> +               hint++;
> +       }
> +
> +       return ret;
> +}
> +
> +/* find the range starts at-or-before bad->start */
> +static int prev_badblocks(struct badblocks *bb, struct bad_context *bad,
> +                         int hint)
> +{
> +       u64 *p;
> +       int lo, hi;
> +       sector_t s = bad->start;
> +       int ret = -1;
> +
> +       if (!bb->count)
> +               goto out;
> +
> +       if (hint >= 0) {
> +               ret = prev_by_hint(bb, s, hint);
> +               if (ret >= 0)
> +                       goto out;
>         }
> -       /* 'target' is now the first block after the bad range */
>
> -retry:
> -       seq = read_seqbegin(&bb->lock);
>         lo = 0;
> -       rv = 0;
>         hi = bb->count;
> +       p = bb->page;
>
> -       /* Binary search between lo and hi for 'target'
> -        * i.e. for the last range that starts before 'target'
> -        */
> -       /* INVARIANT: ranges before 'lo' and at-or-after 'hi'
> -        * are known not to be the last range before target.
> -        * VARIANT: hi-lo is the number of possible
> -        * ranges, and decreases until it reaches 1
> -        */
>         while (hi - lo > 1) {
> -               int mid = (lo + hi) / 2;
> +               int mid = (lo + hi)/2;
>                 sector_t a = BB_OFFSET(p[mid]);
>
> -               if (a < target)
> -                       /* This could still be the one, earlier ranges
> -                        * could not.
> -                        */
> +               if (a <= s)
>                         lo = mid;
>                 else
> -                       /* This and later ranges are definitely out. */
>                         hi = mid;
>         }
> -       /* 'lo' might be the last that started before target, but 'hi' isn't */
> -       if (hi > lo) {
> -               /* need to check all range that end after 's' to see if
> -                * any are unacknowledged.
> +
> +       if (BB_OFFSET(p[lo]) <= s)
> +               ret = lo;
> +out:
> +       return ret;
> +}
> +
> +static int can_merge_behind(struct badblocks *bb, struct bad_context *bad,
> +                           int behind)
> +{
> +       u64 *p = bb->page;
> +       sector_t s = bad->start;
> +       sector_t sectors = bad->len;
> +       int ack = bad->ack;
> +
> +       if ((s <= BB_OFFSET(p[behind])) &&
> +           ((s + sectors) >= BB_OFFSET(p[behind])) &&
> +           ((BB_END(p[behind]) - s) <= BB_MAX_LEN) &&
> +           BB_ACK(p[behind]) == ack)
> +               return true;
> +       return false;
> +}
> +
> +static int behind_merge(struct badblocks *bb, struct bad_context *bad,
> +                       int behind)
> +{
> +       u64 *p = bb->page;
> +       sector_t s = bad->start;
> +       sector_t sectors = bad->len;
> +       int ack = bad->ack;
> +       int merged = 0;
> +
> +       WARN_ON(s > BB_OFFSET(p[behind]));
> +       WARN_ON((s + sectors) < BB_OFFSET(p[behind]));
> +
> +       if (s < BB_OFFSET(p[behind])) {
> +               WARN_ON((BB_LEN(p[behind]) + merged) >= BB_MAX_LEN);
> +
> +               merged = min_t(sector_t, sectors, BB_OFFSET(p[behind]) - s);
> +               p[behind] =  BB_MAKE(s, BB_LEN(p[behind]) + merged, ack);
> +       } else {
> +               merged = min_t(sector_t, sectors, BB_LEN(p[behind]));
> +       }
> +
> +       WARN_ON(merged == 0);
> +
> +       return merged;
> +}
> +
> +static int can_merge_front(struct badblocks *bb, int prev,
> +                          struct bad_context *bad)
> +{
> +       u64 *p = bb->page;
> +       sector_t s = bad->start;
> +       int ack = bad->ack;
> +
> +       if (BB_ACK(p[prev]) == ack &&
> +           (s < BB_END(p[prev]) ||
> +            (s == BB_END(p[prev]) && (BB_LEN(p[prev]) < BB_MAX_LEN))))
> +               return true;
> +       return false;
> +}
> +
> +static int front_merge(struct badblocks *bb, int prev, struct bad_context *bad)
> +{
> +       int sectors = bad->len;
> +       int s = bad->start;
> +       int ack = bad->ack;
> +       u64 *p = bb->page;
> +       int merged = 0;
> +
> +       WARN_ON(s > BB_END(p[prev]));
> +
> +       if (s < BB_END(p[prev])) {
> +               merged = min_t(sector_t, sectors, BB_END(p[prev]) - s);
> +       } else {
> +               merged = min_t(sector_t, sectors, BB_MAX_LEN - BB_LEN(p[prev]));
> +               if ((prev + 1) < bb->count &&
> +                   merged > (BB_OFFSET(p[prev + 1]) - BB_END(p[prev]))) {
> +                       merged = BB_OFFSET(p[prev + 1]) - BB_END(p[prev]);
> +               }
> +
> +               p[prev] = BB_MAKE(BB_OFFSET(p[prev]), BB_LEN(p[prev]) + merged, ack);
> +       }
> +
> +       return merged;
> +}
> +
> +static int can_combine_front(struct badblocks *bb, int prev,
> +                            struct bad_context *bad)
> +{
> +       u64 *p = bb->page;
> +
> +       if ((BB_OFFSET(p[prev]) == bad->start) && (prev > 0) &&
> +           (BB_LEN(p[prev - 1]) + BB_LEN(p[prev]) <= BB_MAX_LEN) &&
> +           (BB_ACK(p[prev - 1]) == BB_ACK(p[prev])))
> +               return true;
> +       return false;
> +}
> +
> +static void front_combine(struct badblocks *bb, int prev)
> +{
> +       u64 *p = bb->page;
> +
> +       p[prev - 1] = BB_MAKE(BB_OFFSET(p[prev - 1]),
> +                             BB_LEN(p[prev - 1]) + BB_LEN(p[prev]),
> +                             BB_ACK(p[prev]));
> +       if ((prev + 1) < bb->count)
> +               memmove(p + prev, p + prev + 1, (bb->count - prev - 1) * 8);
> +}
> +
> +static int overlap_front(struct badblocks *bb, int front,
> +                         struct bad_context *bad)
> +{
> +       u64 *p = bb->page;
> +
> +       if (bad->start >= BB_OFFSET(p[front]) &&
> +           bad->start < BB_END(p[front]))
> +               return true;
> +       return false;
> +}
> +
> +static int can_front_overwrite(struct badblocks *bb, int prev,
> +                              struct bad_context *bad, int *extra)
> +{
> +       u64 *p = bb->page;
> +       int len;
> +
> +       WARN_ON(!overlap_front(bb, prev, bad));
> +
> +       if (BB_ACK(p[prev]) >= bad->ack)
> +               return false;
> +
> +       if (BB_END(p[prev]) <= (bad->start + bad->len)) {
> +               len = BB_END(p[prev]) - bad->start;
> +               if (BB_OFFSET(p[prev]) == bad->start)
> +                       *extra = 0;
> +               else
> +                       *extra = 1;
> +
> +               bad->len = len;
> +       } else {
> +               if (BB_OFFSET(p[prev]) == bad->start)
> +                       *extra = 1;
> +               else
> +               /*
> +                * prev range will be split into two, beside the overwritten
> +                * one, an extra slot needed from bad table.
>                  */
> -               while (lo >= 0 &&
> -                      BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
> -                       if (BB_OFFSET(p[lo]) < target) {
> -                               /* starts before the end, and finishes after
> -                                * the start, so they must overlap
> -                                */
> -                               if (rv != -1 && BB_ACK(p[lo]))
> -                                       rv = 1;
> -                               else
> -                                       rv = -1;
> -                               *first_bad = BB_OFFSET(p[lo]);
> -                               *bad_sectors = BB_LEN(p[lo]);
> -                       }
> -                       lo--;
> +                       *extra = 2;
> +       }
> +
> +       if ((bb->count + (*extra)) >= MAX_BADBLOCKS)
> +               return false;
> +
> +       return true;
> +}
> +
> +static int front_overwrite(struct badblocks *bb, int prev,
> +                          struct bad_context *bad, int extra)
> +{
> +       u64 *p = bb->page;
> +       int n = extra;
> +       sector_t orig_end = BB_END(p[prev]);
> +       int orig_ack = BB_ACK(p[prev]);
> +
> +       switch (extra) {
> +       case 0:
> +               p[prev] = BB_MAKE(BB_OFFSET(p[prev]), BB_LEN(p[prev]),
> +                                 bad->ack);
> +               break;
> +       case 1:
> +               if (BB_OFFSET(p[prev]) == bad->start) {
> +                       p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +                                         bad->len, bad->ack);
> +                       memmove(p + prev + 2, p + prev + 1,
> +                               (bb->count - prev - 1) * 8);
> +                       p[prev + 1] = BB_MAKE(bad->start + bad->len,
> +                                             orig_end - BB_END(p[prev]),
> +                                             orig_ack);
> +               } else {
> +                       p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +                                         BB_END(p[prev]) - bad->start,
> +                                         BB_ACK(p[prev]));
> +                       memmove(p + prev + 1 + n, p + prev + 1,
> +                               (bb->count - prev - 1) * 8);
> +                       p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
>                 }
> +               break;
> +       case 2:
> +               p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +                                 BB_END(p[prev]) - bad->start,
> +                                 BB_ACK(p[prev]));
> +               memmove(p + prev + 1 + n, p + prev + 1,
> +                       (bb->count - prev - 1) * 8);
> +               p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
> +               p[prev + 2] = BB_MAKE(BB_END(p[prev + 1]),
> +                                     orig_end - BB_END(p[prev + 1]),
> +                                     BB_ACK(p[prev]));
> +               break;
> +       default:
> +               break;
>         }
>
> -       if (read_seqretry(&bb->lock, seq))
> -               goto retry;
> +       return bad->len;
> +}
>
> -       return rv;
> +static int overlap_behind(struct badblocks *bb, struct bad_context *bad,
> +                         int behind)
> +{
> +       u64 *p = bb->page;
> +
> +       if (bad->start < BB_OFFSET(p[behind]) &&
> +           (bad->start + bad->len) > BB_OFFSET(p[behind]))
> +               return true;
> +
> +       if (bad->start >= BB_OFFSET(p[behind]) &&
> +           bad->start < BB_END(p[behind]))
> +               return true;
> +
> +       return false;
> +}
> +
> +static int insert_at(struct badblocks *bb, int at, struct bad_context *bad)
> +{
> +       u64 *p = bb->page;
> +       int sectors = bad->len;
> +       int s = bad->start;
> +       int ack = bad->ack;
> +       int len;
> +
> +       WARN_ON(badblocks_full(bb));
> +
> +       len = min_t(sector_t, sectors, BB_MAX_LEN);
> +       if (at < bb->count)
> +               memmove(p + at + 1, p + at, (bb->count - at) * 8);
> +       p[at] = BB_MAKE(s, len, ack);
> +
> +       return len;
>  }
> -EXPORT_SYMBOL_GPL(badblocks_check);
>
>  static void badblocks_update_acked(struct badblocks *bb)
>  {
> @@ -164,7 +664,10 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>                         int acknowledged)
>  {
>         u64 *p;
> -       int lo, hi;
> +       struct bad_context bad;
> +       int prev = -1, hint = -1;
> +       int len = 0, added = 0;
> +       int retried = 0, space_desired = 0;
>         int rv = 0;
>         unsigned long flags;
>
> @@ -172,144 +675,187 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>                 /* badblocks are disabled */
>                 return 1;
>
> +       if (sectors <= 0)
> +               /* Invalid sectors number */
> +               return 1;
> +
>         if (bb->shift) {
>                 /* round the start down, and the end up */
>                 sector_t next = s + sectors;
>
> -               s >>= bb->shift;
> -               next += (1<<bb->shift) - 1;
> -               next >>= bb->shift;
> +               rounddown(s, bb->shift);
> +               roundup(next, bb->shift);
>                 sectors = next - s;
>         }
>
>         write_seqlock_irqsave(&bb->lock, flags);
>
> +       bad.orig_start = s;
> +       bad.orig_len = sectors;
> +       bad.ack = acknowledged;
>         p = bb->page;
> -       lo = 0;
> -       hi = bb->count;
> -       /* Find the last range that starts at-or-before 's' */
> -       while (hi - lo > 1) {
> -               int mid = (lo + hi) / 2;
> -               sector_t a = BB_OFFSET(p[mid]);
>
> -               if (a <= s)
> -                       lo = mid;
> -               else
> -                       hi = mid;
> +re_insert:
> +       bad.start = s;
> +       bad.len = sectors;
> +       len = 0;
> +
> +       if (badblocks_empty(bb)) {
> +               len = insert_at(bb, 0, &bad);
> +               bb->count++;
> +               added++;
> +               goto update_sectors;
>         }
> -       if (hi > lo && BB_OFFSET(p[lo]) > s)
> -               hi = lo;
>
> -       if (hi > lo) {
> -               /* we found a range that might merge with the start
> -                * of our new range
> -                */
> -               sector_t a = BB_OFFSET(p[lo]);
> -               sector_t e = a + BB_LEN(p[lo]);
> -               int ack = BB_ACK(p[lo]);
> -
> -               if (e >= s) {
> -                       /* Yes, we can merge with a previous range */
> -                       if (s == a && s + sectors >= e)
> -                               /* new range covers old */
> -                               ack = acknowledged;
> -                       else
> -                               ack = ack && acknowledged;
> -
> -                       if (e < s + sectors)
> -                               e = s + sectors;
> -                       if (e - a <= BB_MAX_LEN) {
> -                               p[lo] = BB_MAKE(a, e-a, ack);
> -                               s = e;
> +       prev = prev_badblocks(bb, &bad, hint);
> +
> +       /* start before all badblocks */
> +       if (prev < 0) {
> +               if (!badblocks_full(bb)) {
> +                       /* insert on the first */
> +                       if (bad.len > (BB_OFFSET(p[0]) - bad.start))
> +                               bad.len = BB_OFFSET(p[0]) - bad.start;
> +                       len = insert_at(bb, 0, &bad);
> +                       bb->count++;
> +                       added++;
> +                       hint = 0;
> +                       goto update_sectors;
> +               }
> +
> +               /* No sapce, try to merge */
> +               if (overlap_behind(bb, &bad, 0)) {
> +                       if (can_merge_behind(bb, &bad, 0)) {
> +                               len = behind_merge(bb, &bad, 0);
> +                               added++;
>                         } else {
> -                               /* does not all fit in one range,
> -                                * make p[lo] maximal
> -                                */
> -                               if (BB_LEN(p[lo]) != BB_MAX_LEN)
> -                                       p[lo] = BB_MAKE(a, BB_MAX_LEN, ack);
> -                               s = a + BB_MAX_LEN;
> +                               len = min_t(sector_t, BB_OFFSET(p[0]) - s, sectors);
> +                               space_desired = 1;
>                         }
> -                       sectors = e - s;
> +                       hint = 0;
> +                       goto update_sectors;
>                 }
> +
> +               /* no table space and give up */
> +               goto out;
>         }
> -       if (sectors && hi < bb->count) {
> -               /* 'hi' points to the first range that starts after 's'.
> -                * Maybe we can merge with the start of that range
> -                */
> -               sector_t a = BB_OFFSET(p[hi]);
> -               sector_t e = a + BB_LEN(p[hi]);
> -               int ack = BB_ACK(p[hi]);
> -
> -               if (a <= s + sectors) {
> -                       /* merging is possible */
> -                       if (e <= s + sectors) {
> -                               /* full overlap */
> -                               e = s + sectors;
> -                               ack = acknowledged;
> -                       } else
> -                               ack = ack && acknowledged;
> -
> -                       a = s;
> -                       if (e - a <= BB_MAX_LEN) {
> -                               p[hi] = BB_MAKE(a, e-a, ack);
> -                               s = e;
> -                       } else {
> -                               p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
> -                               s = a + BB_MAX_LEN;
> +
> +       /* in case p[prev-1] can be merged with p[prev] */
> +       if (can_combine_front(bb, prev, &bad)) {
> +               front_combine(bb, prev);
> +               bb->count--;
> +               added++;
> +               hint = prev - 1;
> +               goto update_sectors;
> +       }
> +
> +       if (overlap_front(bb, prev, &bad)) {
> +               if (can_merge_front(bb, prev, &bad)) {
> +                       len = front_merge(bb, prev, &bad);
> +                       added++;
> +                       hint = prev - 1;
> +               } else {
> +                       int extra = 0;
> +
> +                       if (!can_front_overwrite(bb, prev, &bad, &extra)) {
> +                               len = min_t(sector_t, BB_END(p[prev]) - s, sectors);
> +                               hint = prev;
> +                               goto update_sectors;
> +                       }
> +
> +                       len = front_overwrite(bb, prev, &bad, extra);
> +                       added++;
> +                       bb->count += extra;
> +                       hint = prev;
> +
> +                       if (prev > 0 && can_combine_front(bb, prev, &bad)) {
> +                               front_combine(bb, prev);
> +                               bb->count--;
> +                               hint = prev - 1;
>                         }
> -                       sectors = e - s;
> -                       lo = hi;
> -                       hi++;
>                 }
> +               goto update_sectors;
> +       }
> +
> +       if (can_merge_front(bb, prev, &bad)) {
> +               len = front_merge(bb, prev, &bad);
> +               added++;
> +               hint = prev;
> +               goto update_sectors;
>         }
> -       if (sectors == 0 && hi < bb->count) {
> -               /* we might be able to combine lo and hi */
> -               /* Note: 's' is at the end of 'lo' */
> -               sector_t a = BB_OFFSET(p[hi]);
> -               int lolen = BB_LEN(p[lo]);
> -               int hilen = BB_LEN(p[hi]);
> -               int newlen = lolen + hilen - (s - a);
> -
> -               if (s >= a && newlen < BB_MAX_LEN) {
> -                       /* yes, we can combine them */
> -                       int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
> -
> -                       p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
> -                       memmove(p + hi, p + hi + 1,
> -                               (bb->count - hi - 1) * 8);
> -                       bb->count--;
> +
> +       /* if no space in table, still try to merge in the covered range */
> +       if (badblocks_full(bb)) {
> +               /* skip the cannot-merge range */
> +               if (((prev + 1) < bb->count) &&
> +                   overlap_behind(bb, &bad, prev + 1) &&
> +                   ((s + sectors) >= BB_END(p[prev + 1]))) {
> +                       len = BB_END(p[prev + 1]) - s;
> +                       hint = prev + 1;
> +                       goto update_sectors;
>                 }
> +
> +               /* no retry any more */
> +               len = sectors;
> +               space_desired = 1;
> +               hint = -1;
> +               goto update_sectors;
>         }
> -       while (sectors) {
> -               /* didn't merge (it all).
> -                * Need to add a range just before 'hi'
> -                */
> -               if (bb->count >= MAX_BADBLOCKS) {
> -                       /* No room for more */
> -                       rv = 1;
> -                       break;
> -               } else {
> -                       int this_sectors = sectors;
>
> -                       memmove(p + hi + 1, p + hi,
> -                               (bb->count - hi) * 8);
> -                       bb->count++;
> +       /* cannot merge and there is space in bad table */
> +       if (overlap_behind(bb, &bad, prev + 1))
> +               bad.len = min_t(sector_t, bad.len, BB_OFFSET(p[prev + 1]) - bad.start);
>
> -                       if (this_sectors > BB_MAX_LEN)
> -                               this_sectors = BB_MAX_LEN;
> -                       p[hi] = BB_MAKE(s, this_sectors, acknowledged);
> -                       sectors -= this_sectors;
> -                       s += this_sectors;
> -               }
> +       len = insert_at(bb, prev + 1, &bad);
> +       bb->count++;
> +       added++;
> +       hint = prev + 1;
> +
> +update_sectors:
> +       s += len;
> +       sectors -= len;
> +
> +       if (sectors > 0)
> +               goto re_insert;
> +
> +       WARN_ON(sectors < 0);
> +
> +       /* Check whether the following already set range can be merged */
> +       if ((prev + 1) < bb->count &&
> +           BB_END(p[prev]) == BB_OFFSET(p[prev + 1]) &&
> +           (BB_LEN(p[prev]) + BB_LEN(p[prev + 1])) <= BB_MAX_LEN &&
> +           BB_ACK(p[prev]) == BB_ACK(p[prev + 1])) {
> +               p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +                                 BB_LEN(p[prev]) + BB_LEN(p[prev + 1]),
> +                                 BB_ACK(p[prev]));
> +
> +               if ((prev + 2) < bb->count)
> +                       memmove(p + prev + 1, p + prev + 2,
> +                               (bb->count -  (prev + 2)) * 8);
> +               bb->count--;
> +       }
> +
> +       if (space_desired && !badblocks_full(bb)) {
> +               s = bad.orig_start;
> +               sectors = bad.orig_len;
> +               if (retried++ < 3)
> +                       goto re_insert;
> +       }
> +
> +out:
> +       if (added) {
> +               set_changed(bb);
> +
> +               if (!acknowledged)
> +                       bb->unacked_exist = 1;
> +               else
> +                       badblocks_update_acked(bb);
>         }
>
> -       bb->changed = 1;
> -       if (!acknowledged)
> -               bb->unacked_exist = 1;
> -       else
> -               badblocks_update_acked(bb);
>         write_sequnlock_irqrestore(&bb->lock, flags);
>
> +       if (!added)
> +               rv = 1;
> +
>         return rv;
>  }
>  EXPORT_SYMBOL_GPL(badblocks_set);
> @@ -423,6 +969,115 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>  }
>  EXPORT_SYMBOL_GPL(badblocks_clear);
>
> +/**
> + * badblocks_check() - check a given range for bad sectors
> + * @bb:                the badblocks structure that holds all badblock information
> + * @s:         sector (start) at which to check for badblocks
> + * @sectors:   number of sectors to check for badblocks
> + * @first_bad: pointer to store location of the first badblock
> + * @bad_sectors: pointer to store number of badblocks after @first_bad
> + *
> + * We can record which blocks on each device are 'bad' and so just
> + * fail those blocks, or that stripe, rather than the whole device.
> + * Entries in the bad-block table are 64bits wide.  This comprises:
> + * Length of bad-range, in sectors: 0-511 for lengths 1-512
> + * Start of bad-range, sector offset, 54 bits (allows 8 exbibytes)
> + *  A 'shift' can be set so that larger blocks are tracked and
> + *  consequently larger devices can be covered.
> + * 'Acknowledged' flag - 1 bit. - the most significant bit.
> + *
> + * Locking of the bad-block table uses a seqlock so badblocks_check
> + * might need to retry if it is very unlucky.
> + * We will sometimes want to check for bad blocks in a bi_end_io function,
> + * so we use the write_seqlock_irq variant.
> + *
> + * When looking for a bad block we specify a range and want to
> + * know if any block in the range is bad.  So we binary-search
> + * to the last range that starts at-or-before the given endpoint,
> + * (or "before the sector after the target range")
> + * then see if it ends after the given start.
> + *
> + * Return:
> + *  0: there are no known bad blocks in the range
> + *  1: there are known bad block which are all acknowledged
> + * -1: there are bad blocks which have not yet been acknowledged in metadata.
> + * plus the start/length of the first bad section we overlap.
> + */
> +int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
> +                       sector_t *first_bad, int *bad_sectors)
> +{
> +       int hi;
> +       int lo;
> +       u64 *p = bb->page;
> +       int rv;
> +       sector_t target = s + sectors;
> +       unsigned seq;
> +
> +       if (bb->shift > 0) {
> +               /* round the start down, and the end up */
> +               s >>= bb->shift;
> +               target += (1<<bb->shift) - 1;
> +               target >>= bb->shift;
> +               sectors = target - s;
> +       }
> +       /* 'target' is now the first block after the bad range */
> +
> +retry:
> +       seq = read_seqbegin(&bb->lock);
> +       lo = 0;
> +       rv = 0;
> +       hi = bb->count;
> +
> +       /* Binary search between lo and hi for 'target'
> +        * i.e. for the last range that starts before 'target'
> +        */
> +       /* INVARIANT: ranges before 'lo' and at-or-after 'hi'
> +        * are known not to be the last range before target.
> +        * VARIANT: hi-lo is the number of possible
> +        * ranges, and decreases until it reaches 1
> +        */
> +       while (hi - lo > 1) {
> +               int mid = (lo + hi) / 2;
> +               sector_t a = BB_OFFSET(p[mid]);
> +
> +               if (a < target)
> +                       /* This could still be the one, earlier ranges
> +                        * could not.
> +                        */
> +                       lo = mid;
> +               else
> +                       /* This and later ranges are definitely out. */
> +                       hi = mid;
> +       }
> +       /* 'lo' might be the last that started before target, but 'hi' isn't */
> +       if (hi > lo) {
> +               /* need to check all range that end after 's' to see if
> +                * any are unacknowledged.
> +                */
> +               while (lo >= 0 &&
> +                      BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
> +                       if (BB_OFFSET(p[lo]) < target) {
> +                               /* starts before the end, and finishes after
> +                                * the start, so they must overlap
> +                                */
> +                               if (rv != -1 && BB_ACK(p[lo]))
> +                                       rv = 1;
> +                               else
> +                                       rv = -1;
> +                               *first_bad = BB_OFFSET(p[lo]);
> +                               *bad_sectors = BB_LEN(p[lo]);
> +                       }
> +                       lo--;
> +               }
> +       }
> +
> +       if (read_seqretry(&bb->lock, seq))
> +               goto retry;
> +
> +       return rv;
> +}
> +EXPORT_SYMBOL_GPL(badblocks_check);
> +
>  /**
>   * ack_all_badblocks() - Acknowledge all bad blocks in a list.
>   * @bb:                the badblocks structure that holds all badblock information
> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
> index 2426276b9bd3..b4bd997a53a4 100644
> --- a/include/linux/badblocks.h
> +++ b/include/linux/badblocks.h
> @@ -15,6 +15,7 @@
>  #define BB_OFFSET(x)   (((x) & BB_OFFSET_MASK) >> 9)
>  #define BB_LEN(x)      (((x) & BB_LEN_MASK) + 1)
>  #define BB_ACK(x)      (!!((x) & BB_ACK_MASK))
> +#define BB_END(x)      (BB_OFFSET(x) + BB_LEN(x))
>  #define BB_MAKE(a, l, ack) (((a)<<9) | ((l)-1) | ((u64)(!!(ack)) << 63))
>
>  /* Bad block numbers are stored sorted in a single page.
> @@ -41,6 +42,14 @@ struct badblocks {
>         sector_t size;          /* in sectors */
>  };
>
> +struct bad_context {
> +       sector_t        start;
> +       sector_t        len;
> +       int             ack;
> +       sector_t        orig_start;
> +       sector_t        orig_len;
> +};
> +
>  int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>                    sector_t *first_bad, int *bad_sectors);
>  int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
> @@ -54,6 +63,7 @@ int badblocks_init(struct badblocks *bb, int enable);
>  void badblocks_exit(struct badblocks *bb);
>  struct device;
>  int devm_init_badblocks(struct device *dev, struct badblocks *bb);
> +
>  static inline void devm_exit_badblocks(struct device *dev, struct badblocks *bb)
>  {
>         if (bb->dev != dev) {
> @@ -63,4 +73,27 @@ static inline void devm_exit_badblocks(struct device *dev, struct badblocks *bb)
>         }
>         badblocks_exit(bb);
>  }
> +
> +static inline int badblocks_full(struct badblocks *bb)
> +{
> +       return (bb->count >= MAX_BADBLOCKS);
> +}
> +
> +static inline int badblocks_empty(struct badblocks *bb)
> +{
> +       return (bb->count == 0);
> +}
> +
> +static inline void set_changed(struct badblocks *bb)
> +{
> +       if (bb->changed != 1)
> +               bb->changed = 1;
> +}
> +
> +static inline void clear_changed(struct badblocks *bb)
> +{
> +       if (bb->changed != 0)
> +               bb->changed = 0;
> +}
> +
>  #endif
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
