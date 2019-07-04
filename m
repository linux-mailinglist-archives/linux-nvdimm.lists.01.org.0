Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CEF5F19D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 04:52:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DBFA0212AF0B5;
	Wed,  3 Jul 2019 19:52:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C27BF212AD5B3
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 19:52:00 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x642pgYF175198
 for <linux-nvdimm@lists.01.org>; Wed, 3 Jul 2019 22:51:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2th8yfg5ef-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 22:51:59 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
 Thu, 4 Jul 2019 03:51:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 4 Jul 2019 03:51:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x642psRC37290002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jul 2019 02:51:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A49DAE045;
 Thu,  4 Jul 2019 02:51:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7898FAE04D;
 Thu,  4 Jul 2019 02:51:52 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.85.70.162])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  4 Jul 2019 02:51:52 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] ndctl,
 check: Ensure mmap of BTT sections work with 64K page-size
Date: Thu,  4 Jul 2019 08:21:43 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19070402-0016-0000-0000-0000028F031F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070402-0017-0000-0000-000032EC9FB7
Message-Id: <20190704025143.22856-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-04_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040037
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
Cc: harish@linux.ibm.com, Vaibhav Jain <vaibhav@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Presently on PPC64 which uses a 64K page-size, ndtl-check command
fails on a BTT device with following error:

$sudo ndctl check-namespace namespace0.0 -vv
namespace0.0: namespace_check: checking namespace0.0
namespace0.0: btt_discover_arenas: found 1 BTT arena
namespace0.0: btt_create_mappings: mmap arena[0].info [sz = 0x1000, off = 0x1000] failed: Invalid argument
error checking namespaces: Invalid argument
checked 0 namespaces

Error happens when btt_create_mappings() tries to mmap the sections of
the BTT device which are usually 4K offset aligned. However the mmap()
syscall expects the 'offset' argument to be in multiples of page-size,
hence it returns EINVAL causing the btt_create_mappings() to error
out.

As a fix for the issue this patch proposes addition of two new
functions to 'check.c' namely btt_mmap/btt_unmap that can be used to
map/unmap parts of BTT device to ndctl process address-space. The
functions tweaks the requested 'offset' argument to mmap() ensuring
that its page-size aligned and then fix-ups the returned pointer such
that it points to the requested offset within m-mapped region.

Reported-by: harish@linux.ibm.com
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/check.c | 71 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/ndctl/check.c b/ndctl/check.c
index 8a7125053865..18d259048616 100644
--- a/ndctl/check.c
+++ b/ndctl/check.c
@@ -907,6 +907,47 @@ static int btt_discover_arenas(struct btt_chk *bttc)
 	return ret;
 }
 
+/* Mmap requested btt region so it works with non 4-K page sizes */
+static void *btt_mmap(struct btt_chk *bttc, void *addr, size_t length,
+		      int prot, int flags, off_t offset)
+{
+	off_t shift;
+
+	/* Calculate the shift back needed to make offset page aligned */
+	shift = offset - rounddown(offset, bttc->sys_page_size);
+
+	/* Update the offset and length with the shift calculated above */
+	offset -= shift;
+	length += shift;
+
+	addr = mmap(addr, length, prot, flags, bttc->fd, offset);
+
+	/* If needed fixup the return pointer to correct offset request */
+	if (addr != MAP_FAILED)
+		addr = (void *) ((uintptr_t)addr + shift);
+
+	dbg(bttc, "mmap: addr=%p length=0x%lx offset=0x%lx shift=0x%lx\n",
+	    addr, length, offset, shift);
+
+	return addr;
+}
+
+static void btt_unmap(struct btt_chk *bttc, void *ptr, size_t length)
+{
+	uintptr_t addr = ptr;
+	off_t shift;
+
+	/* Calculate the shift back needed to make offset page aligned */
+	shift = addr - rounddown(addr, bttc->sys_page_size);
+
+	addr -= shift;
+	length += shift;
+
+	munmap((void *)addr, length);
+	dbg(bttc, "unmap: addr=%p length=0x%lx shift=0x%lx\n",
+	    addr, length, shift);
+}
+
 static int btt_create_mappings(struct btt_chk *bttc)
 {
 	struct arena_info *a;
@@ -921,8 +962,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
 	for (i = 0; i < bttc->num_arenas; i++) {
 		a = &bttc->arena[i];
 		a->map.info_len = BTT_INFO_SIZE;
-		a->map.info = mmap(NULL, a->map.info_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->infooff);
+		a->map.info = btt_mmap(bttc, NULL, a->map.info_len, mmap_flags,
+				       MAP_SHARED, a->infooff);
 		if (a->map.info == MAP_FAILED) {
 			err(bttc, "mmap arena[%d].info [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.info_len, a->infooff, strerror(errno));
@@ -930,8 +971,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
 		}
 
 		a->map.data_len = a->mapoff - a->dataoff;
-		a->map.data = mmap(NULL, a->map.data_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->dataoff);
+		a->map.data = btt_mmap(bttc, NULL, a->map.data_len, mmap_flags,
+				       MAP_SHARED, a->dataoff);
 		if (a->map.data == MAP_FAILED) {
 			err(bttc, "mmap arena[%d].data [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.data_len, a->dataoff, strerror(errno));
@@ -939,8 +980,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
 		}
 
 		a->map.map_len = a->logoff - a->mapoff;
-		a->map.map = mmap(NULL, a->map.map_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->mapoff);
+		a->map.map = btt_mmap(bttc, NULL, a->map.map_len, mmap_flags,
+				      MAP_SHARED, a->mapoff);
 		if (a->map.map == MAP_FAILED) {
 			err(bttc, "mmap arena[%d].map [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.map_len, a->mapoff, strerror(errno));
@@ -948,8 +989,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
 		}
 
 		a->map.log_len = a->info2off - a->logoff;
-		a->map.log = mmap(NULL, a->map.log_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->logoff);
+		a->map.log = btt_mmap(bttc, NULL, a->map.log_len, mmap_flags,
+				  MAP_SHARED, a->logoff);
 		if (a->map.log == MAP_FAILED) {
 			err(bttc, "mmap arena[%d].log [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.log_len, a->logoff, strerror(errno));
@@ -957,8 +998,8 @@ static int btt_create_mappings(struct btt_chk *bttc)
 		}
 
 		a->map.info2_len = BTT_INFO_SIZE;
-		a->map.info2 = mmap(NULL, a->map.info2_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->info2off);
+		a->map.info2 = btt_mmap(bttc, NULL, a->map.info2_len,
+					mmap_flags, MAP_SHARED, a->info2off);
 		if (a->map.info2 == MAP_FAILED) {
 			err(bttc, "mmap arena[%d].info2 [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.info2_len, a->info2off, strerror(errno));
@@ -977,15 +1018,15 @@ static void btt_remove_mappings(struct btt_chk *bttc)
 	for (i = 0; i < bttc->num_arenas; i++) {
 		a = &bttc->arena[i];
 		if (a->map.info)
-			munmap(a->map.info, a->map.info_len);
+			btt_unmap(bttc, a->map.info, a->map.info_len);
 		if (a->map.data)
-			munmap(a->map.data, a->map.data_len);
+			btt_unmap(bttc, a->map.data, a->map.data_len);
 		if (a->map.map)
-			munmap(a->map.map, a->map.map_len);
+			btt_unmap(bttc, a->map.map, a->map.map_len);
 		if (a->map.log)
-			munmap(a->map.log, a->map.log_len);
+			btt_unmap(bttc, a->map.log, a->map.log_len);
 		if (a->map.info2)
-			munmap(a->map.info2, a->map.info2_len);
+			btt_unmap(bttc, a->map.info2, a->map.info2_len);
 	}
 }
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
