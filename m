Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 686492C8786
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Nov 2020 16:17:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1504100EBBC8;
	Mon, 30 Nov 2020 07:17:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0AC49100EBBA2
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 07:17:36 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUF4XnE150160;
	Mon, 30 Nov 2020 10:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=q4qOxUv82Vlz1okT0uQaPo+5wm5xH7ihGdQ6JZq/NVw=;
 b=sa9B+85k6OQFdif2AXmPQXwYJKy5+Ga/GTAOIcy+eFImMsHzG3l3nY2p8SXe1VBossCi
 5/uwqEshKZ6DuS6XJ5av1Qco0O3y10AWOcfLZKs505nysh22BsxgZnjS54J9n7NwmHHq
 rH73XtLEaNmkTkqnhdVwSMvpf7uG6L3lcnRi7NPhjMkZVmupe1I5IXyXBz2vSYqnAoVF
 YHUpBzSt8ssqX4S7phPS2lMPbGOiSbsUpbFQrKGmiW666k5ehm46W8fBtYmCp8d83636
 bkejM1S4DbpuQwQVL1F5NJJm5FNQaS9ihZE+r0oS6Tahx+TFhFUTO9lyheBP+6UthzbB 7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3551674ekk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:17:32 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AUF4mRx151516;
	Mon, 30 Nov 2020 10:17:32 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3551674ejk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:17:32 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUF89Cp023688;
	Mon, 30 Nov 2020 15:17:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 353e6825cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 15:17:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUFHRZR6161056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Nov 2020 15:17:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F5A75204F;
	Mon, 30 Nov 2020 15:17:27 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9B45452051;
	Mon, 30 Nov 2020 15:17:25 +0000 (GMT)
Subject: [RFC Qemu PATCH v2 2/2] spapr: nvdimm: Implement async flush hcalls
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com,
        david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org
Date: Mon, 30 Nov 2020 09:17:24 -0600
Message-ID: 
 <160674940727.2492771.7855399693883710135.stgit@lep8c.aus.stglabs.ibm.com>
In-Reply-To: 
 <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
References: 
 <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_05:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=2 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300094
Message-ID-Hash: TO54GL4FMJCHJAUYNNOLF6YSDNFWKUXY
X-Message-ID-Hash: TO54GL4FMJCHJAUYNNOLF6YSDNFWKUXY
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, aneesh.kumar@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RWZYSQ354DFIYCKXDKOZCHKOF5ZL57TS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When the persistent memory beacked by a file, a cpu cache flush instruction
is not sufficient to ensure the stores are correctly flushed to the media.

The patch implements the async hcalls for flush operation on demand from the
guest kernel.

The device option sync-dax is by default off and enables explicit asynchronous
flush requests from guest. It can be disabled by setting syn-dax=on.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/mem/nvdimm.c         |    1 +
 hw/ppc/spapr_nvdimm.c   |   79 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h |   10 ++++++
 include/hw/ppc/spapr.h  |    3 +-
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 03c2201b56..37a4db0135 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -220,6 +220,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 
 static Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
+    DEFINE_PROP_BOOL(NVDIMM_SYNC_DAX_PROP, NVDIMMDevice, sync_dax, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index a833a63b5e..557e36aa98 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/ppc/spapr_nvdimm.h"
@@ -155,6 +156,11 @@ static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
                              "operating-system")));
     _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL, 0));
 
+    if (!nvdimm->sync_dax) {
+        _FDT(fdt_setprop(fdt, child_offset, "ibm,async-flush-required",
+                         NULL, 0));
+    }
+
     return child_offset;
 }
 
@@ -370,6 +376,78 @@ static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+typedef struct SCMAsyncFlushData {
+    int fd;
+    uint64_t token;
+} SCMAsyncFlushData;
+
+static int flush_worker_cb(void *opaque)
+{
+    int ret = H_SUCCESS;
+    SCMAsyncFlushData *req_data = opaque;
+
+    /* flush raw backing image */
+    if (qemu_fdatasync(req_data->fd) < 0) {
+        error_report("papr_scm: Could not sync nvdimm to backend file: %s",
+                     strerror(errno));
+        ret = H_HARDWARE;
+    }
+
+    g_free(req_data);
+
+    return ret;
+}
+
+static target_ulong h_scm_async_flush(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                      target_ulong opcode, target_ulong *args)
+{
+    int ret;
+    uint32_t drc_index = args[0];
+    uint64_t continue_token = args[1];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    PCDIMMDevice *dimm;
+    HostMemoryBackend *backend = NULL;
+    SCMAsyncFlushData *req_data = NULL;
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (continue_token != 0) {
+        ret = spapr_drc_get_async_hcall_status(drc, continue_token);
+        if (ret == H_BUSY) {
+            args[0] = continue_token;
+            return H_LONG_BUSY_ORDER_1_SEC;
+        }
+
+        return ret;
+    }
+
+    dimm = PC_DIMM(drc->dev);
+    backend = MEMORY_BACKEND(dimm->hostmem);
+
+    req_data = g_malloc0(sizeof(SCMAsyncFlushData));
+    req_data->fd = memory_region_get_fd(&backend->mr);
+
+    continue_token = spapr_drc_get_new_async_hcall_token(drc);
+    if (!continue_token) {
+        g_free(req_data);
+        return H_P2;
+    }
+    req_data->token = continue_token;
+
+    spapr_drc_run_async_hcall(drc, continue_token, &flush_worker_cb, req_data);
+
+    ret = spapr_drc_get_async_hcall_status(drc, continue_token);
+    if (ret == H_BUSY) {
+        args[0] = req_data->token;
+        return ret;
+    }
+
+    return ret;
+}
+
 static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                      target_ulong opcode, target_ulong *args)
 {
@@ -486,6 +564,7 @@ static void spapr_scm_register_types(void)
     spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
     spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
     spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
+    spapr_register_hypercall(H_SCM_ASYNC_FLUSH, h_scm_async_flush);
 }
 
 type_init(spapr_scm_register_types)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c699842dd0..9e8795766e 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -51,6 +51,7 @@ OBJECT_DECLARE_TYPE(NVDIMMDevice, NVDIMMClass, NVDIMM)
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
 #define NVDIMM_UUID_PROP       "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
+#define NVDIMM_SYNC_DAX_PROP    "sync-dax"
 
 struct NVDIMMDevice {
     /* private */
@@ -85,6 +86,15 @@ struct NVDIMMDevice {
      */
     bool unarmed;
 
+    /*
+     * On PPC64,
+     * The 'off' value results in the async-flush-required property set
+     * in the device tree for pseries machines. When 'off', the guest
+     * initiates explicity flush requests to the backend device ensuring
+     * write persistence.
+     */
+    bool sync_dax;
+
     /*
      * The PPC64 - spapr requires each nvdimm device have a uuid.
      */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2e89e36cfb..6d7110b7dc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -535,8 +535,9 @@ struct SpaprMachineState {
 #define H_SCM_BIND_MEM          0x3EC
 #define H_SCM_UNBIND_MEM        0x3F0
 #define H_SCM_UNBIND_ALL        0x3FC
+#define H_SCM_ASYNC_FLUSH       0x4A0
 
-#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
+#define MAX_HCALL_OPCODE        H_SCM_ASYNC_FLUSH
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
