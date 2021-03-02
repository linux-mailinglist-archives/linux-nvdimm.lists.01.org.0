Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F313295CF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 05:03:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BA63100EB825;
	Mon,  1 Mar 2021 20:03:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DBD73100EB825
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 20:03:19 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 729AAAED0;
	Tue,  2 Mar 2021 04:03:18 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	neilb@suse.de
Subject: [RFC PATCH v1 4/6] badblocks: improve badblocks_clear() for multiple ranges handling
Date: Tue,  2 Mar 2021 12:02:50 +0800
Message-Id: <20210302040252.103720-5-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302040252.103720-1-colyli@suse.de>
References: <20210302040252.103720-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: OATVWIAQ4GYOUKCZ3G5RWQMOOMN4RECV
X-Message-ID-Hash: OATVWIAQ4GYOUKCZ3G5RWQMOOMN4RECV
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: antlists@youngman.org.uk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OATVWIAQ4GYOUKCZ3G5RWQMOOMN4RECV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With the foundamental ideas and helper routines from badblocks_set()
improvement, clearing bad block for multiple ranges is much simpler.

With a similar idea from badblocks_set() improvement, this patch
simplifies bad block range clearing into 5 situations. No matter how
complicated the clearing condition is, we just look at the head part
of clearing range with relative already set bad block range from the
bad block table. The rested part will be handled in next run of the
while-loop.

Based on existing helpers addef from badblocks_set(), this patch adds
two more helpers,
- front_clear()
  Clear the bad block range from bad block table which is front
  overlapped with the clearing range.
- front_splitting_clear()
  Handle the condition that the clearing range hits middle of an
  already set bad block range from bad block table.

Similar as badblocks_set(), the first part of clearing range is handled
with relative bad block range which is find by prev_badblocks(). In most
cases a valid hint is provided to prev_badblocks() to avoid unnecessary
bad block table iteration.

This patch also explains the detail algorithm code comments at beginning
of badblocks.c, including which five simplified situations are categried
and how all the bad block range clearing conditions are handled by these
five situations.

Again, in order to make the code review easier and avoid the code
changes mixed together, this patch does not modify badblock_clear() and
implement another routine called _badblock_clear() for the improvement.
Later patch will delete current code of badblock_clear() and make it as
a wrapper to _badblock_clear(), so the code change can be much clear for
review.

Signed-off-by: Coly Li <colyli@suse.de>
---
 block/badblocks.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index b0a7780d75c2..4db6d1adff42 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -330,6 +330,123 @@
  * avoided. In my test with the hint to prev_badblocks(), except for the first
  * loop, all rested calls to prev_badblocks() can go into the fast path and
  * return correct bad blocks table index immediately.
+ *
+ *
+ * Clearing a bad blocks range from the bad block table has similar idea as
+ * setting does, but much more simpler. The only thing needs to be noticed is
+ * when the clearning range hits middle of a bad block range, the existing bad
+ * block range will split into two, and one more item should be added into the
+ * bad block table. The simplified situations to beconsidered are, (The already
+ * set bad blocks ranges in bad block table are naming with prefix E, and the
+ * clearing bad blocks range is naming with prefix C)
+ *
+ * 1) A clearing range is not overlapped to any already set ranges in bad block
+ *    table.
+ *    +-----+         |          +-----+         |          +-----+
+ *    |  C  |         |          |  C  |         |          |  C  |
+ *    +-----+         or         +-----+         or         +-----+
+ *            +---+   |   +----+         +----+  |  +---+
+ *            | E |   |   | E1 |         | E2 |  |  | E |
+ *            +---+   |   +----+         +----+  |  +---+
+ *    For the above situations, no bad block to be cleared and no failure
+ *    happens, simply returns 0.
+ * 2) The clearing range hits middle of an already setting bad blocks range in
+ *    the bad block table.
+ *            +---+
+ *            | C |
+ *            +---+
+ *     +-----------------+
+ *     |         E       |
+ *     +-----------------+
+ *    In this situation if the bad block table is not full, the range E will be
+ *    split into two ranges E1 and E2. The result is,
+ *     +------+   +------+
+ *     |  E1  |   |  E2  |
+ *     +------+   +------+
+ * 3) The clearing range starts exactly at same LBA as an already set bad block range
+ *    from the bad block table.
+ * 3.1) Partially covered at head part
+ *         +------------+
+ *         |     C      |
+ *         +------------+
+ *         +-----------------+
+ *         |         E       |
+ *         +-----------------+
+ *    For this situation, the overlapped already set range will update the
+ *    start LBA to end of C and shrink the range to BB_LEN(E) - BB_LEN(C). No
+ *    item deleted from bad block table. The result is,
+ *                      +----+
+ *                      | E1 |
+ *                      +----+
+ * 3.2) Exact fully covered
+ *         +-----------------+
+ *         |         C       |
+ *         +-----------------+
+ *         +-----------------+
+ *         |         E       |
+ *         +-----------------+
+ *    For this situation the whole bad blocks range E will be cleared and its
+ *    corresponded item is deleted from the bad block table.
+ * 4) The clearing range exactly ends at same LBA as an already set bad block
+ *    range.
+ *                   +-------+
+ *                   |   C   |
+ *                   +-------+
+ *         +-----------------+
+ *         |         E       |
+ *         +-----------------+
+ *    For the above situation, the already set range E is updated to shrink its
+ *    end to the start of C, and reduce its length to BB_LEN(E) - BB_LEN(C).
+ *    The result is,
+ *         +---------+
+ *         |    E    |
+ *         +---------+
+ * 5) The clearing range is partially overlapped with an already set bad block
+ *    range from the bad block table.
+ * 5.1) The already set bad block range is front overlapped with the clearing
+ *    range.
+ *         +----------+
+ *         |     C    |
+ *         +----------+
+ *              +------------+
+ *              |      E     |
+ *              +------------+
+ *   For such situation, the clearing range C can be treated as two parts. The
+ *   first part ends at the start LBA of range E, and the second part starts at
+ *   same LBA of range E.
+ *         +----+-----+               +----+   +-----+
+ *         | C1 | C2  |               | C1 |   | C2  |
+ *         +----+-----+         ===>  +----+   +-----+
+ *              +------------+                 +------------+
+ *              |      E     |                 |      E     |
+ *              +------------+                 +------------+
+ *   Now the first part C1 can be handled as condition 1), and the second part C2 can be
+ *   handled as condition 3.1) in next loop.
+ * 5.2) The already set bad block range is behind overlaopped with the clearing
+ *   range.
+ *                 +----------+
+ *                 |     C    |
+ *                 +----------+
+ *         +------------+
+ *         |      E     |
+ *         +------------+
+ *   For such situation, the clearing range C can be treated as two parts. The
+ *   first part C1 ends at same end LBA of range E, and the second part starts
+ *   at end LBA of range E.
+ *                 +----+-----+                 +----+    +-----+
+ *                 | C1 | C2  |                 | C1 |    | C2  |
+ *                 +----+-----+  ===>           +----+    +-----+
+ *         +------------+               +------------+
+ *         |      E     |               |      E     |
+ *         +------------+               +------------+
+ *   Now the first part clearing range C1 can be handled as condition 4), and
+ *   the second part clearing range C2 can be handled as condition 1) in next
+ *   loop.
+ *
+ *   All bad blocks range clearing can be simplified into the above 5 situations
+ *   by only handling the head part of the clearing range in each run of the
+ *   while-loop. The idea is similar to bad blocks range setting but much
+ *   simpler.
  */
 
 /*
@@ -931,6 +1048,208 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	return rv;
 }
 
+/*
+ * Clear the bad block range from bad block table which is front overlapped
+ * with the clearing range. The return value is how many sectors from an
+ * already set bad block range are cleared. If the whole bad block range is
+ * covered by the clearing range and fully cleared, 'delete' is set as 1 for
+ * the caller to reduce bb->count.
+ */
+static int front_clear(struct badblocks *bb, int prev,
+		       struct bad_context *bad, int *deleted)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+	int cleared = 0;
+
+	*deleted = 0;
+	if (s == BB_OFFSET(p[prev])) {
+		if (BB_LEN(p[prev]) > sectors) {
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]) + sectors,
+					  BB_LEN(p[prev]) - sectors,
+					  BB_ACK(p[prev]));
+			cleared = sectors;
+		} else {
+			/* BB_LEN(p[prev]) <= sectors */
+			cleared = BB_LEN(p[prev]);
+			if ((prev + 1) < bb->count)
+				memmove(p + prev, p + prev + 1,
+				       (bb->count - prev - 1) * 8);
+			*deleted = 1;
+		}
+	} else if (s > BB_OFFSET(p[prev])) {
+		if (BB_END(p[prev]) <= (s + sectors)) {
+			cleared = BB_END(p[prev]) - s;
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+					  s - BB_OFFSET(p[prev]),
+					  BB_ACK(p[prev]));
+		} else {
+			/* Splitting is handled in front_splitting_clear() */
+			BUG();
+		}
+	}
+
+	return cleared;
+}
+
+/*
+ * Handle the condition that the clearing range hits middle of an already set
+ * bad block range from bad block table. In this condition the existing bad
+ * block range is split into two after the middle part is cleared.
+ */
+static int front_splitting_clear(struct badblocks *bb, int prev,
+				  struct bad_context *bad)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	u64 *p = bb->page;
+	u64 end = BB_END(p[prev]);
+	int ack = BB_ACK(p[prev]);
+
+	p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+			  s - BB_OFFSET(p[prev]),
+			  ack);
+	memmove(p + prev + 2, p + prev + 1, (bb->count - prev - 1) * 8);
+	p[prev + 1] = BB_MAKE(s + sectors, end - s - sectors, ack);
+	return sectors;
+}
+
+/* Do the exact work to clear bad block range from the bad block table */
+static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
+{
+	u64 *p;
+	struct bad_context bad;
+	int prev = -1, hint = -1;
+	int len = 0, cleared = 0;
+	int rv = 0;
+
+	if (bb->shift < 0)
+		/* badblocks are disabled */
+		return 1;
+
+	if (sectors == 0)
+		/* Invalid sectors number */
+		return 1;
+
+	if (bb->shift) {
+		sector_t target;
+
+		/* When clearing we round the start up and the end down.
+		 * This should not matter as the shift should align with
+		 * the block size and no rounding should ever be needed.
+		 * However it is better the think a block is bad when it
+		 * isn't than to think a block is not bad when it is.
+		 */
+		target = s + sectors;
+		roundup(s, bb->shift);
+		rounddown(target, bb->shift);
+		sectors = target - s;
+	}
+
+	write_seqlock_irq(&bb->lock);
+
+	bad.orig_start = s;
+	bad.orig_len = sectors;
+	bad.ack = true;
+	p = bb->page;
+
+re_clear:
+	bad.start = s;
+	bad.len = sectors;
+
+	if (badblocks_empty(bb)) {
+		len = sectors;
+		cleared++;
+		goto update_sectors;
+	}
+
+
+	prev = prev_badblocks(bb, &bad, hint);
+
+	/* start before all badblocks */
+	if (prev < 0) {
+		if (overlap_behind(bb, &bad, 0)) {
+			len = BB_OFFSET(p[0]) - s;
+			hint = prev;
+		} else {
+			len = sectors;
+			cleared++;
+		}
+		goto update_sectors;
+	}
+
+	/* start after all badblocks */
+	if ((prev + 1) >= bb->count && !overlap_front(bb, prev, &bad)) {
+		len = sectors;
+		cleared++;
+		goto update_sectors;
+	}
+
+	/* Clear will split a bad record but the table is full */
+	if (badblocks_full(bb) && (BB_OFFSET(p[prev]) < bad.start) &&
+	    (BB_END(p[prev]) > (bad.start + sectors))) {
+		len = sectors;
+		goto update_sectors;
+	}
+
+	if (overlap_front(bb, prev, &bad)) {
+		if ((BB_OFFSET(p[prev]) < bad.start) &&
+		    (BB_END(p[prev]) > (bad.start + bad.len))) {
+			/* Splitting */
+			if ((bb->count + 1) < MAX_BADBLOCKS) {
+				len = front_splitting_clear(bb, prev, &bad);
+				bb->count += 1;
+				cleared++;
+			} else {
+				/* No space to split, give up */
+				len = sectors;
+			}
+		} else {
+			int deleted = 0;
+
+			len = front_clear(bb, prev, &bad, &deleted);
+			bb->count -= deleted;
+			cleared++;
+			hint = prev;
+		}
+
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
+		goto re_clear;
+
+	WARN_ON(sectors < 0);
+
+	if (cleared) {
+		badblocks_update_acked(bb);
+		set_changed(bb);
+	}
+
+	write_sequnlock_irq(&bb->lock);
+
+	if (!cleared)
+		rv = 1;
+
+	return rv;
+}
+
+
 /**
  * badblocks_check() - check a given range for bad sectors
  * @bb:		the badblocks structure that holds all badblock information
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
