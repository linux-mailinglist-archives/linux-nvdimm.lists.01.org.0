Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F129812A636
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Dec 2019 06:42:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D001610113665;
	Tue, 24 Dec 2019 21:45:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=jencce.kernel@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDC6C10113626
	for <linux-nvdimm@lists.01.org>; Tue, 24 Dec 2019 21:45:55 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c23so9176083plz.4
        for <linux-nvdimm@lists.01.org>; Tue, 24 Dec 2019 21:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=vZ3NYrSCzgo4HJpQcBtECC9sAEHZ55b1fDu80MI+EHU=;
        b=LDFZ1xtTzheBra1AHGZu9osWLqaLfwBtQnnQ/8RsX0HjTHX3phwz4iDkDHTRZC7bDN
         okvkuXD+AKdT7f4d85JaDXFM/T6Id2iWt94OgHYOLgH3wnCJ9SflAykVpEN3mqonzeKr
         ru+/oy1m9mZLwNn0wgfAq+4/HNarg1QKM0nQmP/xXdK8Fjq0FXiQSu6AOa7Qkm3FHaic
         e1kpC0QLSfoA+R2hVCQ0VIh9vJuOqSUFqgPMs5+RWLz/umAKAc1fHKc/zRtSA5tgPTrS
         A23cKgus7ibU7DaCcUDcpnt+O7X4koUyAbuSlYTJZHXlrVjmjn5cfYHEitupchKRVRAh
         xP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=vZ3NYrSCzgo4HJpQcBtECC9sAEHZ55b1fDu80MI+EHU=;
        b=pTwwGVn5xqhvPQ+oWuikCvz5Ij5xwbmkjgIQJ/+9caZ576sNdx7O7Ph5g6WUK9JAAG
         pXQ9vqs9fClOWc/lWMkW24DBcnRrgVEikkEa1WHp1VMP3wxxrBSAanLiPbjuJW0j9O5X
         kAgunhsE6PI+F6z16ONI+erWH563y7pZDvtVZCpzVDSMa7aGksD73EBroqZbHj6DlCEB
         bZrUVj5R9ukVg74+J4PqNz3RTGL1sOYu6lSTsI27uhKQ+msLtfLu3duFx2plFSTeeFJx
         gQVvxpSJuT8yDs92f4VEWWGIOaMZm3gTqazl3Tt/XZTJ3HStxII7HDVlLOETTIQbAeMA
         QQ0g==
X-Gm-Message-State: APjAAAX5u9hNqhYjJ+kV9RckMkg3HCz4HcBdSXoZErh0Clbgz47OIDcG
	YF1pl6dWC0ja04pLjMUgXo5r8p9F
X-Google-Smtp-Source: APXvYqzVlY3LVQ2AncRH/id5VRs4nbLUCYfDt0azCNpqbUC65sDk1h46F6J5BhbTNgW4qsgO6+iiLg==
X-Received: by 2002:a17:902:b104:: with SMTP id q4mr29465720plr.132.1577252554964;
        Tue, 24 Dec 2019 21:42:34 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w187sm13341979pfw.62.2019.12.24.21.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 21:42:34 -0800 (PST)
Date: Wed, 25 Dec 2019 13:42:27 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: linux-nvdimm@lists.01.org, Jia He <justin.he@arm.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH] mm: get rid of WARN if failed to cow user pages
Message-ID: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-ID-Hash: C5PKGEDABCGAPJNGZAB5KRW5WZR57KIZ
X-Message-ID-Hash: C5PKGEDABCGAPJNGZAB5KRW5WZR57KIZ
X-MailFrom: jencce.kernel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C5PKGEDABCGAPJNGZAB5KRW5WZR57KIZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

By running xfstests with fsdax enabled, generic/437 always hits this
warning[1] since this commit:

commit 83d116c53058d505ddef051e90ab27f57015b025
Author: Jia He <justin.he@arm.com>
Date:   Fri Oct 11 22:09:39 2019 +0800

    mm: fix double page fault on arm64 if PTE_AF is cleared

Looking at the test program[2] generic/437 uses, it's pretty easy
to hit this warning. Remove this WARN as it seems not necessary.

[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/t_mmap_cow_race.c
[1] warning message:
-----------------------------------------------------------------------
[   97.344077] WARNING: CPU: 0 PID: 2486 at mm/memory.c:2281 wp_page_copy+0x687/0x6e0
[   97.348354] Modules linked in: nf_tables nfnetlink rfkill sunrpc snd_hda_codec_generic ledtrig_audio qxl snd_hda_intel snd_intel_dspcfg drm_ttm_helper snd_hda_codec ttm snd_hda_core drm_kms_helper snd_hwdep snd_seq syscopyarea sysfillrect sysimgblt snd_seq_device fb_sys_fops snd_pcm drm snd_timer crc32_pclmul snd soundcore dax_pmem_compat i2c_piix4 device_dax virtio_balloon pcspkr joydev dax_pmem_core ip_tables xfs libcrc32c crct10dif_pclmul crc32c_intel sd_mod sg ata_generic 8139too ata_piix libata ghash_clmulni_intel 8139cp virtio_console serio_raw nd_pmem mii dm_mirror dm_region_hash dm_log dm_mod
[   97.382176] CPU: 0 PID: 2486 Comm: t_mmap_cow_race Tainted: G        W         5.5.0-rc3-v5.5-rc3 #1
[   97.387804] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   97.392228] RIP: 0010:wp_page_copy+0x687/0x6e0
[   97.396572] Code: 95 f5 00 48 81 e6 00 f0 ff ff ba 00 10 00 00 49 c1 ff 06 49 c1 e7 0c 4c 03 3d 35 95 f5 00 4c 89 ff e8 8d 85 6a 00 85 c0 74 0a <0f> 0b 4c 89 ff e8 8f 80 6a 00 65 48 8b 04 25 40 7f 01 00 83 a8 d8
[   97.413487] RSP: 0000:ffffb882493afd28 EFLAGS: 00010206
[   97.417520] RAX: 0000000000001000 RBX: ffffb882493afdf8 RCX: 0000000000001000
[   97.422295] RDX: 0000000000001000 RSI: 00007f1d20c00000 RDI: ffff976384d1f000
[   97.426914] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000ca308
[   97.431746] R10: 0000000000000000 R11: ffffe0cd4c1347c0 R12: ffffe0cd4c1347c0
[   97.436371] R13: ffff9763b46ba190 R14: ffff9763a963d0c0 R15: ffff976384d1f000
[   97.441085] FS:  00007f1d203fe700(0000) GS:ffff9763b8a00000(0000) knlGS:0000000000000000
[   97.445500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.448393] CR2: 00007f1d20c00000 CR3: 0000000333dfc000 CR4: 00000000000006f0
[   97.452346] Call Trace:
[   97.453681]  ? __switch_to_asm+0x34/0x70
[   97.455566]  ? __switch_to_asm+0x40/0x70
[   97.457418]  ? __switch_to_asm+0x34/0x70
[   97.459197]  ? __switch_to_asm+0x40/0x70
[   97.460971]  ? __switch_to_asm+0x34/0x70
[   97.462746]  ? __switch_to_asm+0x40/0x70
[   97.464561]  ? __switch_to_asm+0x34/0x70
[   97.466342]  ? __switch_to_asm+0x40/0x70
[   97.468141]  do_wp_page+0x8c/0x640
[   97.469818]  ? finish_task_switch+0x77/0x2a0
[   97.471631]  __handle_mm_fault+0xa06/0x1420
[   97.473517]  handle_mm_fault+0xae/0x1d0
[   97.475168]  __do_page_fault+0x27f/0x4e0
[   97.476947]  do_page_fault+0x30/0x110
[   97.478490]  async_page_fault+0x39/0x40
[   97.480275] RIP: 0033:0x400d68
[   97.481587] Code: 53 48 89 fb 48 83 ec 10 66 2e 0f 1f 84 00 00 00 00 00 0f b6 03 ba 04 00 00 00 be 00 00 20 00 48 89 df 89 44 24 0c 8b 44 24 0c <88> 03 e8 71 fc ff ff 85 c0 78 30 e8 b8 fc ff ff 89 c7 41 f7 ec 89
[   97.489326] RSP: 002b:00007f1d203fded0 EFLAGS: 00010202
[   97.491336] RAX: 0000000000000001 RBX: 00007f1d20c00000 RCX: 0000000000000000
[   97.494080] RDX: 0000000000000004 RSI: 0000000000200000 RDI: 00007f1d20c00000
[   97.497244] RBP: 0000000000000002 R08: 00007f1d2138d230 R09: 00007f1d2138d260
[   97.500028] R10: 00007f1d203fe9d0 R11: 0000000000000000 R12: 0000000051eb851f
[   97.502785] R13: 00007fff01d5607f R14: 0000000000000000 R15: 00007f1d203fdfc0
[   97.505546] ---[ end trace 18f1c94bd7c3d1e1 ]---

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 mm/memory.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 45442d9..e3a1dce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2269,18 +2269,12 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 
 	/*
 	 * This really shouldn't fail, because the page is there
-	 * in the page tables. But it might just be unreadable,
-	 * in which case we just give up and fill the result with
-	 * zeroes.
+	 * in the page tables. But it could happen during races,
+	 * or it might just be unreadable, in which cases we
+	 * just give up and fill the result with zeroes.
 	 */
-	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
-		/*
-		 * Give a warn in case there can be some obscure
-		 * use-case
-		 */
-		WARN_ON_ONCE(1);
+	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
 		clear_page(kaddr);
-	}
 
 	ret = true;
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
