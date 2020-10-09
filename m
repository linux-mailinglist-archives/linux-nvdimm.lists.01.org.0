Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C60289293
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:51:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D978159A2852;
	Fri,  9 Oct 2020 12:51:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DEF52159A284B
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:51:24 -0700 (PDT)
IronPort-SDR: Ja2WcpDfFlP2AJEcpGYYj02ezvWmuX7cXOM0Kw62bd1fMXfVBSjnmLMPiMxqHqHye1oYWgXEQG
 BwdgpsOtD6+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="250225959"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="250225959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:24 -0700
IronPort-SDR: XjNk9w0mzDhi5BMigEI5d3C8W/iIq4vdRrLZr3Ki7urqpxKKtyqLLY7j1Bq5ukpJe/vk25ySpH
 cq+qGeUOhHow==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="355862741"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:51:22 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 10/58] drivers/rdma: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:49:45 -0700
Message-Id: <20201009195033.3208459-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XSCPF7BWGFOGEARU4J2XUG75KBFCL7US
X-Message-ID-Hash: XSCPF7BWGFOGEARU4J2XUG75KBFCL7US
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Faisal Latif <faisal.latif@intel.com>, Shiraz Saleem <shiraz.saleem@intel.com>, Bernard Metzler <bmt@zurich.ibm.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kerne
 l.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XSCPF7BWGFOGEARU4J2XUG75KBFCL7US/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The kmap() calls in these drivers are localized to a single thread.  To
avoid the over head of global PKRS updates use the new kmap_thread()
call.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/hw/hfi1/sdma.c      |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 10 +++++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c  | 14 +++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 04575c9afd61..09d206e3229a 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3130,7 +3130,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 		}
 
 		if (type == SDMA_MAP_PAGE) {
-			kvaddr = kmap(page);
+			kvaddr = kmap_thread(page);
 			kvaddr += offset;
 		} else if (WARN_ON(!kvaddr)) {
 			__sdma_txclean(dd, tx);
@@ -3140,7 +3140,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 		memcpy(tx->coalesce_buf + tx->coalesce_idx, kvaddr, len);
 		tx->coalesce_idx += len;
 		if (type == SDMA_MAP_PAGE)
-			kunmap(page);
+			kunmap_thread(page);
 
 		/* If there is more data, return */
 		if (tx->tlen - tx->coalesce_idx)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index a3b95805c154..122d7a5642a1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -3721,7 +3721,7 @@ int i40iw_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 		ibmr->device = iwpd->ibpd.device;
 		iwqp->lsmm_mr = ibmr;
 		if (iwqp->page)
-			iwqp->sc_qp.qp_uk.sq_base = kmap(iwqp->page);
+			iwqp->sc_qp.qp_uk.sq_base = kmap_thread(iwqp->page);
 		dev->iw_priv_qp_ops->qp_send_lsmm(&iwqp->sc_qp,
 							iwqp->ietf_mem.va,
 							(accept.size + conn_param->private_data_len),
@@ -3729,12 +3729,12 @@ int i40iw_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 
 	} else {
 		if (iwqp->page)
-			iwqp->sc_qp.qp_uk.sq_base = kmap(iwqp->page);
+			iwqp->sc_qp.qp_uk.sq_base = kmap_thread(iwqp->page);
 		dev->iw_priv_qp_ops->qp_send_lsmm(&iwqp->sc_qp, NULL, 0, 0);
 	}
 
 	if (iwqp->page)
-		kunmap(iwqp->page);
+		kunmap_thread(iwqp->page);
 
 	iwqp->cm_id = cm_id;
 	cm_node->cm_id = cm_id;
@@ -4102,10 +4102,10 @@ static void i40iw_cm_event_connected(struct i40iw_cm_event *event)
 	i40iw_cm_init_tsa_conn(iwqp, cm_node);
 	read0 = (cm_node->send_rdma0_op == SEND_RDMA_READ_ZERO);
 	if (iwqp->page)
-		iwqp->sc_qp.qp_uk.sq_base = kmap(iwqp->page);
+		iwqp->sc_qp.qp_uk.sq_base = kmap_thread(iwqp->page);
 	dev->iw_priv_qp_ops->qp_send_rtt(&iwqp->sc_qp, read0);
 	if (iwqp->page)
-		kunmap(iwqp->page);
+		kunmap_thread(iwqp->page);
 
 	memset(&attr, 0, sizeof(attr));
 	attr.qp_state = IB_QPS_RTS;
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index d19d8325588b..4ed37c328d02 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -76,7 +76,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 			if (unlikely(!p))
 				return -EFAULT;
 
-			buffer = kmap(p);
+			buffer = kmap_thread(p);
 
 			if (likely(PAGE_SIZE - off >= bytes)) {
 				memcpy(paddr, buffer + off, bytes);
@@ -84,7 +84,7 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				unsigned long part = bytes - (PAGE_SIZE - off);
 
 				memcpy(paddr, buffer + off, part);
-				kunmap(p);
+				kunmap_thread(p);
 
 				if (!mem->is_pbl)
 					p = siw_get_upage(mem->umem,
@@ -96,10 +96,10 @@ static int siw_try_1seg(struct siw_iwarp_tx *c_tx, void *paddr)
 				if (unlikely(!p))
 					return -EFAULT;
 
-				buffer = kmap(p);
+				buffer = kmap_thread(p);
 				memcpy(paddr + part, buffer, bytes - part);
 			}
-			kunmap(p);
+			kunmap_thread(p);
 		}
 	}
 	return (int)bytes;
@@ -505,7 +505,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				page_array[seg] = p;
 
 				if (!c_tx->use_sendpage) {
-					iov[seg].iov_base = kmap(p) + fp_off;
+					iov[seg].iov_base = kmap_thread(p) + fp_off;
 					iov[seg].iov_len = plen;
 
 					/* Remember for later kunmap() */
@@ -518,9 +518,9 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 							plen);
 				} else if (do_crc) {
 					crypto_shash_update(c_tx->mpa_crc_hd,
-							    kmap(p) + fp_off,
+							    kmap_thread(p) + fp_off,
 							    plen);
-					kunmap(p);
+					kunmap_thread(p);
 				}
 			} else {
 				u64 va = sge->laddr + sge_off;
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
