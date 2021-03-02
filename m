Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7173295D0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 05:03:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A5F1100EB82B;
	Mon,  1 Mar 2021 20:03:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E016100EBB9C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 20:03:25 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A00BFAD21;
	Tue,  2 Mar 2021 04:03:23 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	neilb@suse.de
Subject: [RFC PATCH v1 5/6] badblocks: improve badblocks_check() for multiple ranges handling
Date: Tue,  2 Mar 2021 12:02:51 +0800
Message-Id: <20210302040252.103720-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302040252.103720-1-colyli@suse.de>
References: <20210302040252.103720-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: 2QH44LSKHWJTYG4EZL4DKCPVELF3XINY
X-Message-ID-Hash: 2QH44LSKHWJTYG4EZL4DKCPVELF3XINY
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: antlists@youngman.org.uk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2QH44LSKHWJTYG4EZL4DKCPVELF3XINY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch rewrites badblocks_check() with similar coding style as
_badblocks_set() and _badblocks_clear(). The only difference is bad
blocks checking may handle multiple ranges in bad tables now.

If a checking range covers multiple bad blocks range in bad block table,
like the following condition (C is the checking range, E1, E2, E3 are
three bad block ranges in bad block table),
  +------------------------------------+
  |                C                   |
  +------------------------------------+
    +----+      +----+      +----+
    | E1 |      | E2 |      | E3 |
    +----+      +----+      +----+
The improved badblocks_check() algorithm will divid checking range C
into multiple parts, and handle them in 7 runs of a while-loop,
  +--+ +----+ +----+ +----+ +----+ +----+ +----+
  |C1| | C2 | | C3 | | C4 | | C5 | | C6 | | C7 |
  +--+ +----+ +----+ +----+ +----+ +----+ +----+
       +----+        +----+        +----+
       | E1 |        | E2 |        | E3 |
       +----+        +----+        +----+
And the start LBA and length of range E1 will be set as first_bad and
bad_sectors for the caller.

The return value rule is consistent for multiple ranges. For example if
there are following bad block ranges in bad block table,
   Index No.     Start        Len         Ack
       0          400          20          1
       1          500          50          1
       2          650          20          0
the return value, first_bad, bad_sectors by calling badblocks_set() with
different checking range can be the following values,
    Checking Start, Len     Return Value   first_bad    bad_sectors
               100, 100          0           N/A           N/A
               100, 310          1           400           10
               100, 440          1           400           10
               100, 540          1           400           10
               100, 600         -1           400           10
               100, 800         -1           400           10

In order to make code review easier, this patch names the improved bad
block range checking routine as _badblocks_check() and does not change
existing badblock_check() code yet. Later patch will delete old code of
badblocks_check() and make it as a wrapper to call _badblocks_check().
Then the new added code won't mess up with the old deleted code, it will
be more clear and easier for code review.

Signed-off-by: Coly Li <colyli@suse.de>
---
 block/badblocks.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index 4db6d1adff42..304b91159a42 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1249,6 +1249,105 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 	return rv;
 }
 
+/* Do the exact work to check bad blocks range from the bad block table */
+static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
+			    sector_t *first_bad, int *bad_sectors)
+{
+	u64 *p;
+	struct bad_context bad;
+	int prev = -1, hint = -1, set = 0;
+	int unacked_badblocks, acked_badblocks;
+	int len, rv;
+	unsigned int seq;
+
+	WARN_ON(bb->shift < 0 || sectors == 0);
+
+	if (bb->shift > 0) {
+		sector_t target;
+
+		/* round the start down, and the end up */
+		target = s + sectors;
+		rounddown(s, bb->shift);
+		roundup(target, bb->shift);
+		sectors = target - s;
+	}
+
+retry:
+	seq = read_seqbegin(&bb->lock);
+
+	bad.orig_start = s;
+	bad.orig_len = sectors;
+	p = bb->page;
+	unacked_badblocks = 0;
+	acked_badblocks = 0;
+
+re_check:
+	bad.start = s;
+	bad.len = sectors;
+
+	if (badblocks_empty(bb)) {
+		len = sectors;
+		goto update_sectors;
+	}
+
+	prev = prev_badblocks(bb, &bad, hint);
+
+	/* start after all badblocks */
+	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
+		len = sectors;
+		goto update_sectors;
+	}
+
+	if (overlap_front(bb, prev, &bad)) {
+		if (BB_ACK(p[prev]))
+			acked_badblocks++;
+		else
+			unacked_badblocks++;
+
+		if (BB_END(p[prev]) >= (s + sectors))
+			len = sectors;
+		else
+			len = BB_END(p[prev]) - s;
+
+		if (set == 0) {
+			*first_bad = BB_OFFSET(p[prev]);
+			*bad_sectors = BB_LEN(p[prev]);
+			set = 1;
+		}
+		goto update_sectors;
+	}
+
+	/* Not front overlap, but behind overlap */
+	if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
+		len = BB_OFFSET(p[prev + 1]) - bad.start;
+		hint = prev + 1;
+		goto update_sectors;
+	}
+
+	/* not cover any badblocks range in the table */
+	len = sectors;
+
+update_sectors:
+	s += len;
+	sectors -= len;
+
+	if (sectors > 0)
+		goto re_check;
+
+	WARN_ON(sectors < 0);
+
+	if (unacked_badblocks > 0)
+		rv = -1;
+	else if (acked_badblocks > 0)
+		rv = 1;
+	else
+		rv = 0;
+
+	if (read_seqretry(&bb->lock, seq))
+		goto retry;
+
+	return rv;
+}
 
 /**
  * badblocks_check() - check a given range for bad sectors
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
