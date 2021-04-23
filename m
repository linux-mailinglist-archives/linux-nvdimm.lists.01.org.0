Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A514A3692B1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Apr 2021 15:07:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DD18100EAAEB;
	Fri, 23 Apr 2021 06:07:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48DA9100EAB5E
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619183270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrEvCjKrNvU8f2Kdeia0iPn8GHvkOfIv042jQr8u048=;
	b=MlYogAost8Ij70lyLqPWGGx0joZS4REWFQCUI8PZMnE9656B4FcR/KYueXD9Vs4LNtmYds
	7RrKt2GKU2O1D/YIfCjeY60Nht2pJeRgSwTscRYFXjyzrNne444wIkIIoYa0OU1dresB56
	i8+552DgpTNrdb4oHGWR5jnGoa2bRj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-p2aXp0xRN9iTLkrd4oJhkA-1; Fri, 23 Apr 2021 09:07:46 -0400
X-MC-Unique: p2aXp0xRN9iTLkrd4oJhkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269C61006C81;
	Fri, 23 Apr 2021 13:07:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-86.rdu2.redhat.com [10.10.115.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C37250DD2;
	Fri, 23 Apr 2021 13:07:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id A8368225FCD; Fri, 23 Apr 2021 09:07:37 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	dan.j.williams@intel.com
Subject: [PATCH v4 3/3] dax: Wake up all waiters after invalidating dax entry
Date: Fri, 23 Apr 2021 09:07:23 -0400
Message-Id: <20210423130723.1673919-4-vgoyal@redhat.com>
In-Reply-To: <20210423130723.1673919-1-vgoyal@redhat.com>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: PW4KL56FD2XYIZ76NOBC4TXXWPIV3BOG
X-Message-ID-Hash: PW4KL56FD2XYIZ76NOBC4TXXWPIV3BOG
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz, willy@infradead.org, slp@redhat.com, groug@kaod.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PW4KL56FD2XYIZ76NOBC4TXXWPIV3BOG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am seeing missed wakeups which ultimately lead to a deadlock when I am
using virtiofs with DAX enabled and running "make -j". I had to mount
virtiofs as rootfs and also reduce to dax window size to 256M to reproduce
the problem consistently.

So here is the problem. put_unlocked_entry() wakes up waiters only
if entry is not null as well as !dax_is_conflict(entry). But if I
call multiple instances of invalidate_inode_pages2() in parallel,
then I can run into a situation where there are waiters on
this index but nobody will wake these waiters.

invalidate_inode_pages2()
  invalidate_inode_pages2_range()
    invalidate_exceptional_entry2()
      dax_invalidate_mapping_entry_sync()
        __dax_invalidate_entry() {
                xas_lock_irq(&xas);
                entry = get_unlocked_entry(&xas, 0);
                ...
                ...
                dax_disassociate_entry(entry, mapping, trunc);
                xas_store(&xas, NULL);
                ...
                ...
                put_unlocked_entry(&xas, entry);
                xas_unlock_irq(&xas);
        }

Say a fault in in progress and it has locked entry at offset say "0x1c".
Now say three instances of invalidate_inode_pages2() are in progress
(A, B, C) and they all try to invalidate entry at offset "0x1c". Given
dax entry is locked, all tree instances A, B, C will wait in wait queue.

When dax fault finishes, say A is woken up. It will store NULL entry
at index "0x1c" and wake up B. When B comes along it will find "entry=0"
at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
this means put_unlocked_entry() will not wake up next waiter, given
the current code. And that means C continues to wait and is not woken
up.

This patch fixes the issue by waking up all waiters when a dax entry
has been invalidated. This seems to fix the deadlock I am facing
and I can make forward progress.

Reported-by: Sergio Lopez <slp@redhat.com>
Fixes: ac401cc78242 ("dax: New fault locking")
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 96e896de8f18..83daa57d37d3 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	mapping->nrexceptional--;
 	ret = 1;
 out:
-	put_unlocked_entry(&xas, entry, WAKE_NEXT);
+	put_unlocked_entry(&xas, entry, WAKE_ALL);
 	xas_unlock_irq(&xas);
 	return ret;
 }
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
