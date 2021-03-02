Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B227E3295D1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 05:03:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56EDA100EB825;
	Mon,  1 Mar 2021 20:03:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15555100EB825
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 20:03:29 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9FF02AED8;
	Tue,  2 Mar 2021 04:03:27 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	neilb@suse.de
Subject: [RFC PATCH v1 6/6] badblocks: switch to the improved badblock handling code
Date: Tue,  2 Mar 2021 12:02:52 +0800
Message-Id: <20210302040252.103720-7-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210302040252.103720-1-colyli@suse.de>
References: <20210302040252.103720-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: QQ2ZECZ4RGFJ5WFPXIMZGK6AYK2QQA6O
X-Message-ID-Hash: QQ2ZECZ4RGFJ5WFPXIMZGK6AYK2QQA6O
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: antlists@youngman.org.uk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QQ2ZECZ4RGFJ5WFPXIMZGK6AYK2QQA6O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes old code of badblocks_set(), badblocks_clear() and
badblocks_check(), and make them as wrappers to call _badblocks_set(),
_badblocks_clear() and _badblocks_check().

By this change now the badblock handing switch to the improved algorithm
in  _badblocks_set(), _badblocks_clear() and _badblocks_check().

This patch only contains the changes of old code deletion, new added
code for the improved algorithms are in previous patches.

Signed-off-by: Coly Li <colyli@suse.de>
---
 block/badblocks.c | 310 +---------------------------------------------
 1 file changed, 3 insertions(+), 307 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 304b91159a42..904c6ed0de6d 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1386,75 +1386,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 			sector_t *first_bad, int *bad_sectors)
 {
-	int hi;
-	int lo;
-	u64 *p = bb->page;
-	int rv;
-	sector_t target = s + sectors;
-	unsigned seq;
-
-	if (bb->shift > 0) {
-		/* round the start down, and the end up */
-		s >>= bb->shift;
-		target += (1<<bb->shift) - 1;
-		target >>= bb->shift;
-		sectors = target - s;
-	}
-	/* 'target' is now the first block after the bad range */
-
-retry:
-	seq = read_seqbegin(&bb->lock);
-	lo = 0;
-	rv = 0;
-	hi = bb->count;
-
-	/* Binary search between lo and hi for 'target'
-	 * i.e. for the last range that starts before 'target'
-	 */
-	/* INVARIANT: ranges before 'lo' and at-or-after 'hi'
-	 * are known not to be the last range before target.
-	 * VARIANT: hi-lo is the number of possible
-	 * ranges, and decreases until it reaches 1
-	 */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a < target)
-			/* This could still be the one, earlier ranges
-			 * could not.
-			 */
-			lo = mid;
-		else
-			/* This and later ranges are definitely out. */
-			hi = mid;
-	}
-	/* 'lo' might be the last that started before target, but 'hi' isn't */
-	if (hi > lo) {
-		/* need to check all range that end after 's' to see if
-		 * any are unacknowledged.
-		 */
-		while (lo >= 0 &&
-		       BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
-			if (BB_OFFSET(p[lo]) < target) {
-				/* starts before the end, and finishes after
-				 * the start, so they must overlap
-				 */
-				if (rv != -1 && BB_ACK(p[lo]))
-					rv = 1;
-				else
-					rv = -1;
-				*first_bad = BB_OFFSET(p[lo]);
-				*bad_sectors = BB_LEN(p[lo]);
-			}
-			lo--;
-		}
-	}
-
-	if (read_seqretry(&bb->lock, seq))
-		goto retry;
-
-	return rv;
+	return _badblocks_check(bb, s, sectors, first_bad, bad_sectors);
 }
 EXPORT_SYMBOL_GPL(badblocks_check);
 
@@ -1476,154 +1408,7 @@ EXPORT_SYMBOL_GPL(badblocks_check);
 int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			int acknowledged)
 {
-	u64 *p;
-	int lo, hi;
-	int rv = 0;
-	unsigned long flags;
-
-	if (bb->shift < 0)
-		/* badblocks are disabled */
-		return 1;
-
-	if (bb->shift) {
-		/* round the start down, and the end up */
-		sector_t next = s + sectors;
-
-		s >>= bb->shift;
-		next += (1<<bb->shift) - 1;
-		next >>= bb->shift;
-		sectors = next - s;
-	}
-
-	write_seqlock_irqsave(&bb->lock, flags);
-
-	p = bb->page;
-	lo = 0;
-	hi = bb->count;
-	/* Find the last range that starts at-or-before 's' */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a <= s)
-			lo = mid;
-		else
-			hi = mid;
-	}
-	if (hi > lo && BB_OFFSET(p[lo]) > s)
-		hi = lo;
-
-	if (hi > lo) {
-		/* we found a range that might merge with the start
-		 * of our new range
-		 */
-		sector_t a = BB_OFFSET(p[lo]);
-		sector_t e = a + BB_LEN(p[lo]);
-		int ack = BB_ACK(p[lo]);
-
-		if (e >= s) {
-			/* Yes, we can merge with a previous range */
-			if (s == a && s + sectors >= e)
-				/* new range covers old */
-				ack = acknowledged;
-			else
-				ack = ack && acknowledged;
-
-			if (e < s + sectors)
-				e = s + sectors;
-			if (e - a <= BB_MAX_LEN) {
-				p[lo] = BB_MAKE(a, e-a, ack);
-				s = e;
-			} else {
-				/* does not all fit in one range,
-				 * make p[lo] maximal
-				 */
-				if (BB_LEN(p[lo]) != BB_MAX_LEN)
-					p[lo] = BB_MAKE(a, BB_MAX_LEN, ack);
-				s = a + BB_MAX_LEN;
-			}
-			sectors = e - s;
-		}
-	}
-	if (sectors && hi < bb->count) {
-		/* 'hi' points to the first range that starts after 's'.
-		 * Maybe we can merge with the start of that range
-		 */
-		sector_t a = BB_OFFSET(p[hi]);
-		sector_t e = a + BB_LEN(p[hi]);
-		int ack = BB_ACK(p[hi]);
-
-		if (a <= s + sectors) {
-			/* merging is possible */
-			if (e <= s + sectors) {
-				/* full overlap */
-				e = s + sectors;
-				ack = acknowledged;
-			} else
-				ack = ack && acknowledged;
-
-			a = s;
-			if (e - a <= BB_MAX_LEN) {
-				p[hi] = BB_MAKE(a, e-a, ack);
-				s = e;
-			} else {
-				p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
-				s = a + BB_MAX_LEN;
-			}
-			sectors = e - s;
-			lo = hi;
-			hi++;
-		}
-	}
-	if (sectors == 0 && hi < bb->count) {
-		/* we might be able to combine lo and hi */
-		/* Note: 's' is at the end of 'lo' */
-		sector_t a = BB_OFFSET(p[hi]);
-		int lolen = BB_LEN(p[lo]);
-		int hilen = BB_LEN(p[hi]);
-		int newlen = lolen + hilen - (s - a);
-
-		if (s >= a && newlen < BB_MAX_LEN) {
-			/* yes, we can combine them */
-			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
-
-			p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
-			memmove(p + hi, p + hi + 1,
-				(bb->count - hi - 1) * 8);
-			bb->count--;
-		}
-	}
-	while (sectors) {
-		/* didn't merge (it all).
-		 * Need to add a range just before 'hi'
-		 */
-		if (bb->count >= MAX_BADBLOCKS) {
-			/* No room for more */
-			rv = 1;
-			break;
-		} else {
-			int this_sectors = sectors;
-
-			memmove(p + hi + 1, p + hi,
-				(bb->count - hi) * 8);
-			bb->count++;
-
-			if (this_sectors > BB_MAX_LEN)
-				this_sectors = BB_MAX_LEN;
-			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
-			sectors -= this_sectors;
-			s += this_sectors;
-		}
-	}
-
-	bb->changed = 1;
-	if (!acknowledged)
-		bb->unacked_exist = 1;
-	else
-		badblocks_update_acked(bb);
-	write_sequnlock_irqrestore(&bb->lock, flags);
-
-	return rv;
+	return _badblocks_set(bb, s, sectors, acknowledged);
 }
 EXPORT_SYMBOL_GPL(badblocks_set);
 
@@ -1643,96 +1428,7 @@ EXPORT_SYMBOL_GPL(badblocks_set);
  */
 int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 {
-	u64 *p;
-	int lo, hi;
-	sector_t target = s + sectors;
-	int rv = 0;
-
-	if (bb->shift > 0) {
-		/* When clearing we round the start up and the end down.
-		 * This should not matter as the shift should align with
-		 * the block size and no rounding should ever be needed.
-		 * However it is better the think a block is bad when it
-		 * isn't than to think a block is not bad when it is.
-		 */
-		s += (1<<bb->shift) - 1;
-		s >>= bb->shift;
-		target >>= bb->shift;
-		sectors = target - s;
-	}
-
-	write_seqlock_irq(&bb->lock);
-
-	p = bb->page;
-	lo = 0;
-	hi = bb->count;
-	/* Find the last range that starts before 'target' */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a < target)
-			lo = mid;
-		else
-			hi = mid;
-	}
-	if (hi > lo) {
-		/* p[lo] is the last range that could overlap the
-		 * current range.  Earlier ranges could also overlap,
-		 * but only this one can overlap the end of the range.
-		 */
-		if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
-		    (BB_OFFSET(p[lo]) < target)) {
-			/* Partial overlap, leave the tail of this range */
-			int ack = BB_ACK(p[lo]);
-			sector_t a = BB_OFFSET(p[lo]);
-			sector_t end = a + BB_LEN(p[lo]);
-
-			if (a < s) {
-				/* we need to split this range */
-				if (bb->count >= MAX_BADBLOCKS) {
-					rv = -ENOSPC;
-					goto out;
-				}
-				memmove(p+lo+1, p+lo, (bb->count - lo) * 8);
-				bb->count++;
-				p[lo] = BB_MAKE(a, s-a, ack);
-				lo++;
-			}
-			p[lo] = BB_MAKE(target, end - target, ack);
-			/* there is no longer an overlap */
-			hi = lo;
-			lo--;
-		}
-		while (lo >= 0 &&
-		       (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
-		       (BB_OFFSET(p[lo]) < target)) {
-			/* This range does overlap */
-			if (BB_OFFSET(p[lo]) < s) {
-				/* Keep the early parts of this range. */
-				int ack = BB_ACK(p[lo]);
-				sector_t start = BB_OFFSET(p[lo]);
-
-				p[lo] = BB_MAKE(start, s - start, ack);
-				/* now low doesn't overlap, so.. */
-				break;
-			}
-			lo--;
-		}
-		/* 'lo' is strictly before, 'hi' is strictly after,
-		 * anything between needs to be discarded
-		 */
-		if (hi - lo > 1) {
-			memmove(p+lo+1, p+hi, (bb->count - hi) * 8);
-			bb->count -= (hi - lo - 1);
-		}
-	}
-
-	badblocks_update_acked(bb);
-	bb->changed = 1;
-out:
-	write_sequnlock_irq(&bb->lock);
-	return rv;
+	return _badblocks_clear(bb, s, sectors);
 }
 EXPORT_SYMBOL_GPL(badblocks_clear);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
