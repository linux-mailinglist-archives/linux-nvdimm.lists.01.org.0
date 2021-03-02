Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E555F3295CD
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 05:03:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1B02100EB822;
	Mon,  1 Mar 2021 20:03:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 421FA100EBB9F
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 20:03:10 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B5B85AEB3;
	Tue,  2 Mar 2021 04:03:08 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	neilb@suse.de
Subject: [RFC PATCH v1 2/6] badblocks: add helper routines for badblock ranges handling
Date: Tue,  2 Mar 2021 12:02:48 +0800
Message-Id: <20210302040252.103720-3-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302040252.103720-1-colyli@suse.de>
References: <20210302040252.103720-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: 6X3FKQXPNFG53PTPRY4W4CJ23ZYSE5VH
X-Message-ID-Hash: 6X3FKQXPNFG53PTPRY4W4CJ23ZYSE5VH
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: antlists@youngman.org.uk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6X3FKQXPNFG53PTPRY4W4CJ23ZYSE5VH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds several helper routines to improve badblock ranges
handling. These helper routines will be used later in the improved
version of badblocks_set()/badblocks_clear()/badblocks_check().

- Helpers prev_by_hint() and prev_badblocks() are used to find the bad
  range from bad table which the searching range starts at or after.

- The following helpers are to decide the relative layout between the
  manipulating range and existing bad block range from bad table.
  - can_merge_behind()
    Return 'true' if the manipulating range can backward merge with the
    bad block range.
  - can_merge_front()
    Return 'true' if the manipulating range can forward merge with the
    bad block range.
  - can_combine_front()
    Return 'true' if two adjacent bad block ranges before the
    manipulating range can be merged.
  - overlap_front()
    Return 'true' if the manipulating range exactly overlaps with the
    bad block range in front of its range.
  - overlap_behind()
    Return 'true' if the manipulating range exactly overlaps with the
    bad block range behind its range.
  - can_front_overwrite()
    Return 'true' if the manipulating range can forward overwrite the
    bad block range in front of its range.

- The following helpers are to add the manipulating range into the bad
  block table. Different routine is called with the specific relative
  layout between the maniplating range and other bad block range in the
  bad block table.
  - behind_merge()
    Merge the maniplating range with the bad block range behind its
    range, and return the number of merged length in unit of sector.
  - front_merge()
    Merge the maniplating range with the bad block range in front of
    its range, and return the number of merged length in unit of sector.
  - front_combine()
    Combine the two adjacent bad block ranges before the manipulating
    range into a larger one.
  - front_overwrite()
    Overwrite partial of whole bad block range which is in front of the
    manipulating range. The overwrite may split existing bad block range
    and generate more bad block ranges into the bad block table.
  - insert_at()
    Insert the manipulating range at a specific location in the bad
    block table.

All the above helpers are used in later patches to improve the bad block
ranges handling for badblocks_set()/badblocks_clear()/badblocks_check().

Signed-off-by: Coly Li <colyli@suse.de>
---
 block/badblocks.c | 374 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 374 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index d39056630d9c..fd76bbe7b5a2 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -16,6 +16,380 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+/*
+ * Find the range starts at-or-before 's' from bad table. The search
+ * starts from index 'hint' and stops at index 'hint_end' from the bad
+ * table.
+ */
+static int prev_by_hint(struct badblocks *bb, sector_t s, int hint)
+{
+	u64 *p = bb->page;
+	int ret = -1;
+	int hint_end = hint + 2;
+
+	while ((hint < hint_end) && ((hint + 1) <= bb->count) &&
+	       (BB_OFFSET(p[hint]) <= s)) {
+		if ((hint + 1) == bb->count || BB_OFFSET(p[hint + 1]) > s) {
+			ret = hint;
+			break;
+		}
+		hint++;
+	}
+
+	return ret;
+}
+
+/*
+ * Find the range starts at-or-before bad->start. If 'hint' is provided
+ * (hint >= 0) then search in the bad table from hint firstly. It is
+ * very probably the wanted bad range can be found from the hint index,
+ * then the unnecessary while-loop iteration can be avoided.
+ */
+static int prev_badblocks(struct badblocks *bb, struct bad_context *bad,
+			  int hint)
+{
+	u64 *p;
+	int lo, hi;
+	sector_t s = bad->start;
+	int ret = -1;
+
+	if (!bb->count)
+		goto out;
+
+	if (hint >= 0) {
+		ret = prev_by_hint(bb, s, hint);
+		if (ret >= 0)
+			goto out;
+	}
+
+	lo = 0;
+	hi = bb->count;
+	p = bb->page;
+
+	while (hi - lo > 1) {
+		int mid = (lo + hi)/2;
+		sector_t a = BB_OFFSET(p[mid]);
+
+		if (a <= s)
+			lo = mid;
+		else
+			hi = mid;
+	}
+
+	if (BB_OFFSET(p[lo]) <= s)
+		ret = lo;
+out:
+	return ret;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can be backward merged
+ * with the bad range (from the bad table) index by 'behind'.
+ */
+static bool can_merge_behind(struct badblocks *bb, struct bad_context *bad,
+			     int behind)
+{
+	u64 *p = bb->page;
+	sector_t s = bad->start;
+	sector_t sectors = bad->len;
+	int ack = bad->ack;
+
+	if ((s <= BB_OFFSET(p[behind])) &&
+	    ((s + sectors) >= BB_OFFSET(p[behind])) &&
+	    ((BB_END(p[behind]) - s) <= BB_MAX_LEN) &&
+	    BB_ACK(p[behind]) == ack)
+		return true;
+	return false;
+}
+
+/*
+ * Do backward merge for range indicated by 'bad' and the bad range
+ * (from the bad table) indexed by 'behind'. The return value is merged
+ * sectors from bad->len.
+ */
+static int behind_merge(struct badblocks *bb, struct bad_context *bad,
+			int behind)
+{
+	u64 *p = bb->page;
+	sector_t s = bad->start;
+	sector_t sectors = bad->len;
+	int ack = bad->ack;
+	int merged = 0;
+
+	WARN_ON(s > BB_OFFSET(p[behind]));
+	WARN_ON((s + sectors) < BB_OFFSET(p[behind]));
+
+	if (s < BB_OFFSET(p[behind])) {
+		WARN_ON((BB_LEN(p[behind]) + merged) >= BB_MAX_LEN);
+
+		merged = min_t(sector_t, sectors, BB_OFFSET(p[behind]) - s);
+		p[behind] =  BB_MAKE(s, BB_LEN(p[behind]) + merged, ack);
+	} else {
+		merged = min_t(sector_t, sectors, BB_LEN(p[behind]));
+	}
+
+	WARN_ON(merged == 0);
+
+	return merged;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can be forward
+ * merged with the bad range (from the bad table) indexed by 'prev'.
+ */
+static bool can_merge_front(struct badblocks *bb, int prev,
+			    struct bad_context *bad)
+{
+	u64 *p = bb->page;
+	sector_t s = bad->start;
+	int ack = bad->ack;
+
+	if (BB_ACK(p[prev]) == ack &&
+	    (s < BB_END(p[prev]) ||
+	     (s == BB_END(p[prev]) && (BB_LEN(p[prev]) < BB_MAX_LEN))))
+		return true;
+	return false;
+}
+
+/*
+ * Do forward merge for range indicated by 'bad' and the bad range
+ * (from bad table) indexed by 'prev'. The return value is sectors
+ * merged from bad->len.
+ */
+static int front_merge(struct badblocks *bb, int prev, struct bad_context *bad)
+{
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	int ack = bad->ack;
+	u64 *p = bb->page;
+	int merged = 0;
+
+	WARN_ON(s > BB_END(p[prev]));
+
+	if (s < BB_END(p[prev])) {
+		merged = min_t(sector_t, sectors, BB_END(p[prev]) - s);
+	} else {
+		merged = min_t(sector_t, sectors, BB_MAX_LEN - BB_LEN(p[prev]));
+		if ((prev + 1) < bb->count &&
+		    merged > (BB_OFFSET(p[prev + 1]) - BB_END(p[prev]))) {
+			merged = BB_OFFSET(p[prev + 1]) - BB_END(p[prev]);
+		}
+
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+				  BB_LEN(p[prev]) + merged, ack);
+	}
+
+	return merged;
+}
+
+/*
+ * 'Combine' is a special case which can_merge_front() is not able to
+ * handle: If a bad range (indexed by 'prev' from bad table) exactly
+ * starts as bad->start, and the bad range ahead of 'prev' (indexed by
+ * 'prev - 1' from bad table) exactly ends at where 'prev' starts, and
+ * the sum of their lengths does not exceed BB_MAX_LEN limitation, then
+ * these two bad range (from bad table) can be combined.
+ *
+ * Return 'true' if bad ranges indexed by 'prev' and 'prev - 1' from bad
+ * table can be combined.
+ */
+static bool can_combine_front(struct badblocks *bb, int prev,
+			      struct bad_context *bad)
+{
+	u64 *p = bb->page;
+
+	if ((prev > 0) &&
+	    (BB_OFFSET(p[prev]) == bad->start) &&
+	    (BB_END(p[prev - 1]) == BB_OFFSET(p[prev])) &&
+	    (BB_LEN(p[prev - 1]) + BB_LEN(p[prev]) <= BB_MAX_LEN) &&
+	    (BB_ACK(p[prev - 1]) == BB_ACK(p[prev])))
+		return true;
+	return false;
+}
+
+/*
+ * Combine the bad ranges indexed by 'prev' and 'prev - 1' (from bad
+ * table) into one larger bad range, and the new range is indexed by
+ * 'prev - 1'.
+ */
+static void front_combine(struct badblocks *bb, int prev)
+{
+	u64 *p = bb->page;
+
+	p[prev - 1] = BB_MAKE(BB_OFFSET(p[prev - 1]),
+			      BB_LEN(p[prev - 1]) + BB_LEN(p[prev]),
+			      BB_ACK(p[prev]));
+	if ((prev + 1) < bb->count)
+		memmove(p + prev, p + prev + 1, (bb->count - prev - 1) * 8);
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' is exactly forward
+ * overlapped with the bad range (from bad table) indexed by 'front'.
+ * Exactly forward overlap means the bad range (from bad table) indexed
+ * by 'prev' does not cover the whole range indicated by 'bad'.
+ */
+static bool overlap_front(struct badblocks *bb, int front,
+			  struct bad_context *bad)
+{
+	u64 *p = bb->page;
+
+	if (bad->start >= BB_OFFSET(p[front]) &&
+	    bad->start < BB_END(p[front]))
+		return true;
+	return false;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' is exactly backward
+ * overlapped with the bad range (from bad table) indexed by 'behind'.
+ */
+static bool overlap_behind(struct badblocks *bb, struct bad_context *bad,
+			   int behind)
+{
+	u64 *p = bb->page;
+
+	if (bad->start < BB_OFFSET(p[behind]) &&
+	    (bad->start + bad->len) > BB_OFFSET(p[behind]))
+		return true;
+	return false;
+}
+
+/*
+ * Return 'true' if the range indicated by 'bad' can overwrite the bad
+ * range (from bad table) indexed by 'prev'.
+ *
+ * The range indicated by 'bad' can overwrite the bad range indexed by
+ * 'prev' when,
+ * 1) The whole range indicated by 'bad' can cover partial or whole bad
+ *    range (from bad table) indexed by 'prev'.
+ * 2) The ack value of 'bad' is larger or equal to the ack value of bad
+ *    range 'prev'.
+ *
+ * If the overwriting doesn't cover the whole bad range (from bad table)
+ * indexed by 'prev', new range might be split from existing bad range,
+ * 1) The overwrite covers head or tail part of existing bad range, 1
+ *    extra bad range will be split and added into the bad table.
+ * 2) The overwrite covers middle of existing bad range, 2 extra bad
+ *    ranges will be split (ahead and after the overwritten range) and
+ *    added into the bad table.
+ * The number of extra split ranges of the overwriting is stored in
+ * 'extra' and returned for the caller.
+ */
+static bool can_front_overwrite(struct badblocks *bb, int prev,
+				struct bad_context *bad, int *extra)
+{
+	u64 *p = bb->page;
+	int len;
+
+	WARN_ON(!overlap_front(bb, prev, bad));
+
+	if (BB_ACK(p[prev]) >= bad->ack)
+		return false;
+
+	if (BB_END(p[prev]) <= (bad->start + bad->len)) {
+		len = BB_END(p[prev]) - bad->start;
+		if (BB_OFFSET(p[prev]) == bad->start)
+			*extra = 0;
+		else
+			*extra = 1;
+
+		bad->len = len;
+	} else {
+		if (BB_OFFSET(p[prev]) == bad->start)
+			*extra = 1;
+		else
+		/*
+		 * prev range will be split into two, beside the overwritten
+		 * one, an extra slot needed from bad table.
+		 */
+			*extra = 2;
+	}
+
+	if ((bb->count + (*extra)) >= MAX_BADBLOCKS)
+		return false;
+
+	return true;
+}
+
+/*
+ * Do the overwrite from the range indicated by 'bad' to the bad range
+ * (from bad table) indexed by 'prev'.
+ * The previously called can_front_overwrite() will provide how many
+ * extra bad range(s) might be split and added into the bad table. All
+ * the splitting cases in the bad table will be handled here.
+ */
+static int front_overwrite(struct badblocks *bb, int prev,
+			   struct bad_context *bad, int extra)
+{
+	u64 *p = bb->page;
+	int n = extra;
+	sector_t orig_end = BB_END(p[prev]);
+	int orig_ack = BB_ACK(p[prev]);
+
+	switch (extra) {
+	case 0:
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]), BB_LEN(p[prev]),
+				  bad->ack);
+		break;
+	case 1:
+		if (BB_OFFSET(p[prev]) == bad->start) {
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+					  bad->len, bad->ack);
+			memmove(p + prev + 2, p + prev + 1,
+				(bb->count - prev - 1) * 8);
+			p[prev + 1] = BB_MAKE(bad->start + bad->len,
+					      orig_end - BB_END(p[prev]),
+					      orig_ack);
+		} else {
+			p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+					  BB_END(p[prev]) - bad->start,
+					  BB_ACK(p[prev]));
+			memmove(p + prev + 1 + n, p + prev + 1,
+				(bb->count - prev - 1) * 8);
+			p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
+		}
+		break;
+	case 2:
+		p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
+				  BB_END(p[prev]) - bad->start,
+				  BB_ACK(p[prev]));
+		memmove(p + prev + 1 + n, p + prev + 1,
+			(bb->count - prev - 1) * 8);
+		p[prev + 1] = BB_MAKE(bad->start, bad->len, bad->ack);
+		p[prev + 2] = BB_MAKE(BB_END(p[prev + 1]),
+				      orig_end - BB_END(p[prev + 1]),
+				      BB_ACK(p[prev]));
+		break;
+	default:
+		break;
+	}
+
+	return bad->len;
+}
+
+/*
+ * Explicitly insert a range indicated by 'bad' to the bad table, where
+ * the location is indexed by 'at'.
+ */
+static int insert_at(struct badblocks *bb, int at, struct bad_context *bad)
+{
+	u64 *p = bb->page;
+	sector_t sectors = bad->len;
+	sector_t s = bad->start;
+	int ack = bad->ack;
+	int len;
+
+	WARN_ON(badblocks_full(bb));
+
+	len = min_t(sector_t, sectors, BB_MAX_LEN);
+	if (at < bb->count)
+		memmove(p + at + 1, p + at, (bb->count - at) * 8);
+	p[at] = BB_MAKE(s, len, ack);
+
+	return len;
+}
+
 /**
  * badblocks_check() - check a given range for bad sectors
  * @bb:		the badblocks structure that holds all badblock information
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
