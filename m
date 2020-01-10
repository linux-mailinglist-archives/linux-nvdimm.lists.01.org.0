Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD88137688
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 20:05:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85C3410097DD6;
	Fri, 10 Jan 2020 11:08:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F0BD10097DD5
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 11:08:53 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ4GGE101455;
	Fri, 10 Jan 2020 19:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=MHgz05oZOaycJTUzvHe+/2r6D+V+CAPUNuF1+l0RUqk=;
 b=akuQOJ4oyrHAWCsm1Qeez7Nv1vtW+9n8sxvrA44yFKWjM07BtIuB9c9UCV2ceeiIfhD5
 fcXALB3yW5Ym7HofN0nVLwDzwkAhDMLQa2lH+WiYpMQxdXMIiPgKDgKF2nt8IwqmyXfn
 jx6DbzVey39Sm9YdfSUM77U3azh8MRz7Ru89NkhyOw92HIKtlfX4s48NMcSAFrERCkJQ
 BzbvVZuCAeFo6IuoNGxV20zPc7LJ5AIxAvRZRuIfyx+8gJASy4gPQ2BL8oaYunc1dQ8J
 svR8Gbn6/CRGg3c5y0py2nYZycHMISPY5mlPhfDCDB/p3Sx0QvtaowAlxYgcZi9kUGDr mw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 2xajnqm1d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:05:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ3t1e183573;
	Fri, 10 Jan 2020 19:05:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2xedhypum9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:05:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00AJ59wD014700;
	Fri, 10 Jan 2020 19:05:09 GMT
Received: from paddy.uk.oracle.com (/10.175.192.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 10 Jan 2020 11:05:08 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH RFC 06/10] device-dax: Introduce pfn_flags helper
Date: Fri, 10 Jan 2020 19:03:09 +0000
Message-Id: <20200110190313.17144-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110190313.17144-1-joao.m.martins@oracle.com>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=800
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=865 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100154
Message-ID-Hash: 2O2UXM2B2HYB6JHA6TEUOPFW5TT72TBN
X-Message-ID-Hash: 2O2UXM2B2HYB6JHA6TEUOPFW5TT72TBN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2O2UXM2B2HYB6JHA6TEUOPFW5TT72TBN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace PFN_DEV|PFN_MAP check call sites with two helper functions
dax_is_pfn_dev() and dax_is_pfn_map().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/device.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index c6a7f5e12c54..113a554de3ee 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -14,6 +14,17 @@
 #include "dax-private.h"
 #include "bus.h"
 
+static int dax_is_pfn_dev(struct dev_dax *dev_dax)
+{
+	return (dev_dax->region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV;
+}
+
+static int dax_is_pfn_map(struct dev_dax *dev_dax)
+{
+	return (dev_dax->region->pfn_flags &
+		(PFN_DEV|PFN_MAP)) == (PFN_DEV|PFN_MAP);
+}
+
 static int check_vma_mmap(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
@@ -60,8 +71,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	if (rc < 0)
 		return rc;
 
-	if ((dev_dax->region->pfn_flags & (PFN_DEV|PFN_MAP)) == PFN_DEV
-			&& (vma->vm_flags & VM_DONTCOPY) == 0) {
+	if (dax_is_pfn_dev(dev_dax) && (vma->vm_flags & VM_DONTCOPY) == 0) {
 		dev_info_ratelimited(&dev_dax->dev,
 				"%s: %s: fail, dax range requires MADV_DONTFORK\n",
 				current->comm, func);
@@ -140,7 +150,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	}
 
 	/* dax pmd mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
+	if (!dax_is_pfn_map(dev_dax)) {
 		dev_dbg(dev, "region lacks devmap flags\n");
 		return VM_FAULT_SIGBUS;
 	}
@@ -190,7 +200,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	}
 
 	/* dax pud mappings require pfn_t_devmap() */
-	if ((dax_region->pfn_flags & (PFN_DEV|PFN_MAP)) != (PFN_DEV|PFN_MAP)) {
+	if (!dax_is_pfn_map(dev_dax)) {
 		dev_dbg(dev, "region lacks devmap flags\n");
 		return VM_FAULT_SIGBUS;
 	}
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
