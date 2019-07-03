Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4595ECFD
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 21:53:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25FFA212AD58A;
	Wed,  3 Jul 2019 12:53:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5331C21276BA6
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vqmc8HmxSdsdZnmxVteLD7yTFn26ShwrILrKMFB1/Tc=; b=rbCs6946skmxDkFEn5TfgPylE
 laGOaLKGnO9S5VL454/xNsm3WwPwWIxPnLXto3FC4YWiMtUACCGPfVKtUUu7ZQEoCcvzVCPYexAVn
 j6GiW1iesIW/RVOjEEwWjG0FX6M/rb/g8ZbhSnfDEJTwS1Tui7BejMq18AjlomFkn364bPFv9jm2V
 DmW58ErGlBOZjRgk8n1ehE3LmaSBh6IVZ7624NgU0HPj5ow+CdVOVaf8EKci5a924fPxNz34M9wlr
 KZ4LJPC2P98XGM/fucAuOVB/0lObjFzajE9o4w2Jcca+TuXZFrFGFP4hUs7MhuGrqTADdnBUaR1PD
 FfDHBxtWQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hilJO-0006Fu-TK; Wed, 03 Jul 2019 19:53:02 +0000
Date: Wed, 3 Jul 2019 12:53:02 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190703195302.GJ1729@bombadil.infradead.org>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 03, 2019 at 10:01:37AM -0700, Dan Williams wrote:
> On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > > This fix may increase waitqueue contention, but a fix for that is saved
> > > for a larger rework. In the meantime this fix is suitable for -stable
> > > backports.
> >
> > I think this is too big for what it is; just the two-line patch to stop
> > incorporating the low bits of the PTE would be more appropriate.
> 
> Sufficient, yes, "appropriate", not so sure. All those comments about
> pmd entry size are stale after this change.

But then they'll have to be put back in again.  This seems to be working
for me, although I doubt I'm actually hitting the edge case that rocksdb
hits:

diff --git a/fs/dax.c b/fs/dax.c
index 2e48c7ebb973..e77bd6aef10c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -198,6 +198,10 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
  * if it did.
  *
  * Must be called with the i_pages lock held.
+ *
+ * If the xa_state refers to a larger entry, then it may return a locked
+ * smaller entry (eg a PTE entry) without waiting for the smaller entry
+ * to be unlocked.
  */
 static void *get_unlocked_entry(struct xa_state *xas)
 {
@@ -211,7 +215,8 @@ static void *get_unlocked_entry(struct xa_state *xas)
 	for (;;) {
 		entry = xas_find_conflict(xas);
 		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
-				!dax_is_locked(entry))
+				!dax_is_locked(entry) ||
+				dax_entry_order(entry) < xas_get_order(xas))
 			return entry;
 
 		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
@@ -253,8 +258,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 
 static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
-	/* If we were the only waiter woken, wake the next one */
-	if (entry)
+	/*
+	 * If we were the only waiter woken, wake the next one.
+	 * Do not wake anybody if the entry is locked; that indicates
+	 * we weren't woken.
+	 */
+	if (entry && !dax_is_locked(entry))
 		dax_wake_entry(xas, entry, false);
 }
 
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 052e06ff4c36..b17289d92af4 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1529,6 +1529,27 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
 #endif
 }
 
+/**
+ * xas_get_order() - Get the order of the entry being operated on.
+ * @xas: XArray operation state.
+ *
+ * Return: The order of the entry.
+ */
+static inline unsigned int xas_get_order(const struct xa_state *xas)
+{
+	unsigned int order = xas->xa_shift;
+
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int sibs = xas->xa_sibs;
+
+	while (sibs) {
+		order++;
+		sibs /= 2;
+	}
+#endif
+	return order;
+}
+
 /**
  * xas_set_update() - Set up XArray operation state for a callback.
  * @xas: XArray operation state.
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 7df4f7f395bf..af024477ec93 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -95,6 +95,17 @@ static noinline void check_xa_err(struct xarray *xa)
 //	XA_BUG_ON(xa, xa_err(xa_store(xa, 0, xa_mk_internal(0), 0)) != -EINVAL);
 }
 
+static noinline void check_xas_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+	unsigned int i;
+
+	for (i = 0; i < sizeof(long) * 8; i++) {
+		xas_set_order(&xas, 0, i);
+		XA_BUG_ON(xa, xas_get_order(&xas) != i);
+	}
+}
+
 static noinline void check_xas_retry(struct xarray *xa)
 {
 	XA_STATE(xas, xa, 0);
@@ -1583,6 +1594,7 @@ static DEFINE_XARRAY(array);
 static int xarray_checks(void)
 {
 	check_xa_err(&array);
+	check_xas_order(&array);
 	check_xas_retry(&array);
 	check_xa_load(&array);
 	check_xa_mark(&array);
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
