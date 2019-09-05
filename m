Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE263AA7A2
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 17:46:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBEFA21962301;
	Thu,  5 Sep 2019 08:47:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EA92A20260CF7
 for <linux-nvdimm@lists.01.org>; Thu,  5 Sep 2019 08:47:37 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x85Fd1l6033194; Thu, 5 Sep 2019 11:46:31 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uu3mdcysg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 11:46:31 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85Fjgo4018754;
 Thu, 5 Sep 2019 15:46:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02dal.us.ibm.com with ESMTP id 2uqgh7jw83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 15:46:30 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x85FkTWr53805538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 15:46:29 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6172C136051;
 Thu,  5 Sep 2019 15:46:29 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B30F13604F;
 Thu,  5 Sep 2019 15:46:27 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.243])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 15:46:27 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v9 7/7] libnvdimm/dax: Pick the right alignment default when
 creating dax devices
Date: Thu,  5 Sep 2019 21:16:03 +0530
Message-Id: <20190905154603.10349-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905154603.10349-1-aneesh.kumar@linux.ibm.com>
References: <20190905154603.10349-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050147
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
Cc: linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Allow arch to provide the supported alignments and use hugepage alignment only
if we support hugepage. Right now we depend on compile time configs whereas this
patch switch this to runtime discovery.

Architectures like ppc64 can have THP enabled in code, but then can have
hugepage size disabled by the hypervisor. This allows us to create dax devices
with PAGE_SIZE alignment in this case.

Existing dax namespace with alignment larger than PAGE_SIZE will fail to
initialize in this specific case. We still allow fsdax namespace initialization.

With respect to identifying whether to enable hugepage fault for a dax device,
if THP is enabled during compile, we default to taking hugepage fault and in dax
fault handler if we find the fault size > alignment we retry with PAGE_SIZE
fault size.

This also addresses the below failure scenario on ppc64

ndctl create-namespace --mode=devdax  | grep align
 "align":16777216,
 "align":16777216

cat /sys/devices/ndbus0/region0/dax0.0/supported_alignments
 65536 16777216

daxio.static-debug  -z -o /dev/dax0.0
  Bus error (core dumped)

  $ dmesg | tail
   lpar: Failed hash pte insert with error -4
   hash-mmu: mm: Hashing failure ! EA=0x7fff17000000 access=0x8000000000000006 current=daxio
   hash-mmu:     trap=0x300 vsid=0x22cb7a3 ssize=1 base psize=2 psize 10 pte=0xc000000501002b86
   daxio[3860]: bus error (7) at 7fff17000000 nip 7fff973c007c lr 7fff973bff34 code 2 in libpmem.so.1.0.0[7fff973b0000+20000]
   daxio[3860]: code: 792945e4 7d494b78 e95f0098 7d494b78 f93f00a0 4800012c e93f0088 f93f0120
   daxio[3860]: code: e93f00a0 f93f0128 e93f0120 e95f0128 <f9490000> e93f0088 39290008 f93f0110

The failure was due to guest kernel using wrong page size.

The namespaces created with 16M alignment will appear as below on a config with
16M page size disabled.

$ ndctl list -Ni
[
  {
    "dev":"namespace0.1",
    "mode":"fsdax",
    "map":"dev",
    "size":5351931904,
    "uuid":"fc6e9667-461a-4718-82b4-69b24570bddb",
    "align":16777216,
    "blockdev":"pmem0.1",
    "supported_alignments":[
      65536
    ]
  },
  {
    "dev":"namespace0.0",
    "mode":"fsdax",    <==== devdax 16M alignment marked disabled.
    "map":"mem",
    "size":5368709120,
    "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
    "state":"disabled"
  }
]

Cc: linux-mm@kvack.org
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/nd.h       |  6 +---
 drivers/nvdimm/pfn_devs.c | 75 ++++++++++++++++++++++++++++-----------
 include/linux/huge_mm.h   |  7 +++-
 3 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index e89af4b2d8e9..ee5c04070ef9 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -289,11 +289,7 @@ static inline struct device *nd_btt_create(struct nd_region *nd_region)
 struct nd_pfn *to_nd_pfn(struct device *dev);
 #if IS_ENABLED(CONFIG_NVDIMM_PFN)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define PFN_DEFAULT_ALIGNMENT HPAGE_PMD_SIZE
-#else
-#define PFN_DEFAULT_ALIGNMENT PAGE_SIZE
-#endif
+#define MAX_NVDIMM_ALIGN	4
 
 int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns);
 bool is_nd_pfn(struct device *dev);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index ce9ef18282dd..934cdcaaae97 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -103,39 +103,42 @@ static ssize_t align_show(struct device *dev,
 	return sprintf(buf, "%ld\n", nd_pfn->align);
 }
 
-static const unsigned long *nd_pfn_supported_alignments(void)
+static unsigned long *nd_pfn_supported_alignments(unsigned long *alignments)
 {
-	/*
-	 * This needs to be a non-static variable because the *_SIZE
-	 * macros aren't always constants.
-	 */
-	const unsigned long supported_alignments[] = {
-		PAGE_SIZE,
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		HPAGE_PMD_SIZE,
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-		HPAGE_PUD_SIZE,
-#endif
-#endif
-		0,
-	};
-	static unsigned long data[ARRAY_SIZE(supported_alignments)];
 
-	memcpy(data, supported_alignments, sizeof(data));
+	alignments[0] = PAGE_SIZE;
+
+	if (has_transparent_hugepage()) {
+		alignments[1] = HPAGE_PMD_SIZE;
+		if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD))
+			alignments[2] = HPAGE_PUD_SIZE;
+	}
+
+	return alignments;
+}
+
+/*
+ * Use pmd mapping if supported as default alignment
+ */
+static unsigned long nd_pfn_default_alignment(void)
+{
 
-	return data;
+	if (has_transparent_hugepage())
+		return HPAGE_PMD_SIZE;
+	return PAGE_SIZE;
 }
 
 static ssize_t align_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
+	unsigned long aligns[MAX_NVDIMM_ALIGN] = { [0] = 0, };
 	ssize_t rc;
 
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	rc = nd_size_select_store(dev, buf, &nd_pfn->align,
-			nd_pfn_supported_alignments());
+			nd_pfn_supported_alignments(aligns));
 	dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
 			buf[len - 1] == '\n' ? "" : "\n");
 	nvdimm_bus_unlock(dev);
@@ -259,7 +262,10 @@ static DEVICE_ATTR_RO(size);
 static ssize_t supported_alignments_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return nd_size_select_show(0, nd_pfn_supported_alignments(), buf);
+	unsigned long aligns[MAX_NVDIMM_ALIGN] = { [0] = 0, };
+
+	return nd_size_select_show(0,
+			nd_pfn_supported_alignments(aligns), buf);
 }
 static DEVICE_ATTR_RO(supported_alignments);
 
@@ -302,7 +308,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
 		return NULL;
 
 	nd_pfn->mode = PFN_MODE_NONE;
-	nd_pfn->align = PFN_DEFAULT_ALIGNMENT;
+	nd_pfn->align = nd_pfn_default_alignment();
 	dev = &nd_pfn->dev;
 	device_initialize(&nd_pfn->dev);
 	if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
@@ -412,6 +418,21 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 	return 0;
 }
 
+static bool nd_supported_alignment(unsigned long align)
+{
+	int i;
+	unsigned long supported[MAX_NVDIMM_ALIGN] = { [0] = 0, };
+
+	if (align == 0)
+		return false;
+
+	nd_pfn_supported_alignments(supported);
+	for (i = 0; supported[i]; i++)
+		if (align == supported[i])
+			return true;
+	return false;
+}
+
 /**
  * nd_pfn_validate - read and validate info-block
  * @nd_pfn: fsdax namespace runtime state / properties
@@ -496,6 +517,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Check whether the we support the alignment. For Dax if the
+	 * superblock alignment is not matching, we won't initialize
+	 * the device.
+	 */
+	if (!nd_supported_alignment(align) &&
+			!memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
+		dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
+				"%ld:%ld\n", nd_pfn->align, align);
+		return -EOPNOTSUPP;
+	}
+
 	if (!nd_pfn->uuid) {
 		/*
 		 * When probing a namepace via nd_pfn_probe() the uuid
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 45ede62aa85b..376a81ff2c96 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -108,7 +108,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
-
+	/*
+	 * For dax vmas, try to always use hugepage mappings. If the kernel does
+	 * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
+	 * mappings, and device-dax namespaces, that try to guarantee a given
+	 * mapping size, will fail to enable
+	 */
 	if (vma_is_dax(vma))
 		return true;
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
