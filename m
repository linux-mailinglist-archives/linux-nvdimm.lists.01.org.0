Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A373D8300C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 12:50:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B5EC21306CD6;
	Tue,  6 Aug 2019 03:52:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7929C212FD404
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 03:52:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x76AgUmB039306
 for <linux-nvdimm@lists.01.org>; Tue, 6 Aug 2019 06:50:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u780t8b6f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 06:50:24 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
 Tue, 6 Aug 2019 11:50:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 6 Aug 2019 11:50:21 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x76AoJej56819952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2019 10:50:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FF5711C058;
 Tue,  6 Aug 2019 10:50:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0536011C04A;
 Tue,  6 Aug 2019 10:50:18 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.109.208.157])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2019 10:50:17 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org, "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: [PATCH v3] ndctl,
 check: Ensure mmap of BTT sections work with 64K page-sizes
Date: Tue,  6 Aug 2019 16:20:12 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19080610-0020-0000-0000-0000035B7EB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080610-0021-0000-0000-000021AF9D79
Message-Id: <20190806105012.15170-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060112
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
Cc: Harish Sriram <harish@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On PPC64 which uses a 64K page-size, ndtl-check command fails on a BTT
namespace with following error:

$ sudo ndctl check-namespace namespace0.0 -vv
  namespace0.0: namespace_check: checking namespace0.0
  namespace0.0: btt_discover_arenas: found 1 BTT arena
  namespace0.0: btt_create_mappings: mmap arena[0].info [sz = 0x1000, off = 0x1000] failed: Invalid argument
  error checking namespaces: Invalid argument
  checked 0 namespaces

An error happens when btt_create_mappings() tries to mmap the sections
of the BTT device which are usually 4K offset aligned. However the
mmap() syscall expects the 'offset' argument to be in multiples of
page-size, hence it returns EINVAL causing the btt_create_mappings()
to error out.

As a fix for the issue this patch proposes addition of two new
functions to 'check.c' namely btt_mmap/btt_unmap that can be used to
map/unmap parts of BTT device to ndctl process address-space. The
functions tweaks the requested 'offset' argument to mmap() ensuring
that its page-size aligned and then fix-ups the returned pointer such
that it points to the requested offset within mmapped region.

With these newly introduced functions the patch updates the call-sites
in 'check.c' to use these functions instead of mmap/unmap syscalls.
Also since btt_mmap returns NULL if mmap operation fails, the
error check call-sites can be made against NULL instead of MAP_FAILED.

Reported-by: Harish Sriram <harish@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:
v3:
* Fixed a log string that was splitted across multiple lines [Vishal]

v2:
* Updated patch description to include canonical email address of bug
  reporter. [Vishal]
* Improved the comment describing function btt_mmap() in 'check.c'
  [Vishal]
* Simplified the argument list for btt_mmap() to just accept bttc,
  length and offset. Other arguments for mmap() are derived from these
  args. [Vishal]
* Renamed 'shift' variable in btt_mmap()/unmap() to 'page_offset'
  [Vishal]
* Improved the dbg() messages logged inside
  btt_mmap()/unmap(). [Vishal]
* Return NULL from btt_mmap() in case of an error. [Vishal]
* Changed the all sites to btt_mmap() to perform error check against
  NULL return value instead of MAP_FAILED. [Vishal]
---
 ndctl/check.c | 93 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/ndctl/check.c b/ndctl/check.c
index 8a7125053865..5969012eba84 100644
--- a/ndctl/check.c
+++ b/ndctl/check.c
@@ -907,59 +907,100 @@ static int btt_discover_arenas(struct btt_chk *bttc)
 	return ret;
 }
 
-static int btt_create_mappings(struct btt_chk *bttc)
+/*
+ * Wrap call to mmap(2) to work with btt device offsets that are not aligned
+ * to system page boundary. It works by rounding down the requested offset
+ * to sys_page_size when calling mmap(2) and then returning a fixed-up pointer
+ * to the correct offset in the mmaped region.
+ */
+static void *btt_mmap(struct btt_chk *bttc, size_t length, off_t offset)
 {
-	struct arena_info *a;
-	int mmap_flags;
-	int i;
+	off_t page_offset;
+	int prot_flags;
+	uint8_t *addr;
 
 	if (!bttc->opts->repair)
-		mmap_flags = PROT_READ;
+		prot_flags = PROT_READ;
 	else
-		mmap_flags = PROT_READ|PROT_WRITE;
+		prot_flags = PROT_READ|PROT_WRITE;
+
+	/* Calculate the page_offset from the system page boundary */
+	page_offset = offset - rounddown(offset, bttc->sys_page_size);
+
+	/* Update the offset and length with the page_offset calculated above */
+	offset -= page_offset;
+	length += page_offset;
+
+	addr = mmap(NULL, length, prot_flags, MAP_SHARED, bttc->fd, offset);
+
+	/* If needed fixup the return pointer to correct offset requested */
+	if (addr != MAP_FAILED)
+		addr += page_offset;
+
+	dbg(bttc, "addr = %p, length = %#lx, offset = %#lx, page_offset = %#lx\n",
+	    (void *) addr, length, offset, page_offset);
+
+	return addr == MAP_FAILED ? NULL : addr;
+}
+
+static void btt_unmap(struct btt_chk *bttc, void *ptr, size_t length)
+{
+	off_t page_offset;
+	uintptr_t addr = (uintptr_t) ptr;
+
+	/* Calculate the page_offset from system page boundary */
+	page_offset = addr - rounddown(addr, bttc->sys_page_size);
+
+	addr -= page_offset;
+	length += page_offset;
+
+	munmap((void *) addr, length);
+	dbg(bttc, "addr = %p, length = %#lx, page_offset = %#lx\n",
+	    (void *) addr, length, page_offset);
+}
+
+static int btt_create_mappings(struct btt_chk *bttc)
+{
+	struct arena_info *a;
+	int i;
 
 	for (i = 0; i < bttc->num_arenas; i++) {
 		a = &bttc->arena[i];
 		a->map.info_len = BTT_INFO_SIZE;
-		a->map.info = mmap(NULL, a->map.info_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->infooff);
-		if (a->map.info == MAP_FAILED) {
+		a->map.info = btt_mmap(bttc, a->map.info_len, a->infooff);
+		if (!a->map.info) {
 			err(bttc, "mmap arena[%d].info [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.info_len, a->infooff, strerror(errno));
 			return -errno;
 		}
 
 		a->map.data_len = a->mapoff - a->dataoff;
-		a->map.data = mmap(NULL, a->map.data_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->dataoff);
-		if (a->map.data == MAP_FAILED) {
+		a->map.data = btt_mmap(bttc, a->map.data_len, a->dataoff);
+		if (!a->map.data) {
 			err(bttc, "mmap arena[%d].data [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.data_len, a->dataoff, strerror(errno));
 			return -errno;
 		}
 
 		a->map.map_len = a->logoff - a->mapoff;
-		a->map.map = mmap(NULL, a->map.map_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->mapoff);
-		if (a->map.map == MAP_FAILED) {
+		a->map.map = btt_mmap(bttc, a->map.map_len, a->mapoff);
+		if (!a->map.map) {
 			err(bttc, "mmap arena[%d].map [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.map_len, a->mapoff, strerror(errno));
 			return -errno;
 		}
 
 		a->map.log_len = a->info2off - a->logoff;
-		a->map.log = mmap(NULL, a->map.log_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->logoff);
-		if (a->map.log == MAP_FAILED) {
+		a->map.log = btt_mmap(bttc, a->map.log_len, a->logoff);
+		if (!a->map.log) {
 			err(bttc, "mmap arena[%d].log [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.log_len, a->logoff, strerror(errno));
 			return -errno;
 		}
 
 		a->map.info2_len = BTT_INFO_SIZE;
-		a->map.info2 = mmap(NULL, a->map.info2_len, mmap_flags,
-			MAP_SHARED, bttc->fd, a->info2off);
-		if (a->map.info2 == MAP_FAILED) {
+		a->map.info2 = btt_mmap(bttc, a->map.info2_len, a->info2off);
+		if (!a->map.info2) {
 			err(bttc, "mmap arena[%d].info2 [sz = %#lx, off = %#lx] failed: %s\n",
 				i, a->map.info2_len, a->info2off, strerror(errno));
 			return -errno;
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
