Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3534600D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Mar 2021 14:48:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58016100EBB9F;
	Tue, 23 Mar 2021 06:48:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB65E100EBBB9
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 06:47:57 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NDYCSS108959;
	Tue, 23 Mar 2021 09:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=aJD4wevKg02KmRoNo8/InqD0KSxVjlpO/CGCFh4lyy0=;
 b=PxgNPdgY9yXj6uUrrwdgt8b31u1hNsiH1N8QNPSMxACi2RexkanFdHDtvPUD/0vTMUYV
 ubElMoxlw4iLltCGuoY4B3p+ndkN9dbYMjNvhHUAJ2eOG9/XvXvYYLLU1ULB+sdHhrdT
 6cBMQSgiQevxETVHT0Ivg7Mv7DEuB6wbdFE5YRIHyycId2Fo7t9BLU3/JsKKam21uWJ+
 MGGZbE1Eyz6oi5TbYNfLo7WOxN4ErXTL0Jcs7FvompL965eeOsRWXIHQ/bkSU5tV7rY3
 SFV+v3hwok+0vbGkojc02K5ei6TRElkF02NOKCYPwyeeoLbI8qYh8jThjmrlLXaos0cZ 4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37e024jnbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 09:47:46 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12NDYEeI109175;
	Tue, 23 Mar 2021 09:47:46 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0b-001b2d01.pphosted.com with ESMTP id 37e024jn9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 09:47:46 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NDlhK6020301;
	Tue, 23 Mar 2021 13:47:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma01fra.de.ibm.com with ESMTP id 37d99xhsa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Mar 2021 13:47:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NDlNth32309550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Mar 2021 13:47:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADAD11C05C;
	Tue, 23 Mar 2021 13:47:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32AA511C050;
	Tue, 23 Mar 2021 13:47:39 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.40.192.207])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 23 Mar 2021 13:47:39 +0000 (GMT)
Subject: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: sbhat@linux.vnet.ibm.com, david@gibson.dropbear.id.au, groug@kaod.org,
        qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
        mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Date: Tue, 23 Mar 2021 09:47:38 -0400
Message-ID: <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
In-Reply-To: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230100
Message-ID-Hash: AENACDHYPPVJ7VKNS5PONPM7E2MUYOWM
X-Message-ID-Hash: AENACDHYPPVJ7VKNS5PONPM7E2MUYOWM
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AENACDHYPPVJ7VKNS5PONPM7E2MUYOWM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch adds support for the SCM flush hcall for the nvdimm devices.
To be available for exploitation by guest through the next patch.

The hcall expects the semantics such that the flush to return
with H_BUSY when the operation is expected to take longer time along
with a continue_token. The hcall to be called again providing the
continue_token to get the status. So, all fresh requsts are put into
a 'pending' list and flush worker is submitted to the thread pool.
The thread pool completion callbacks move the requests to 'completed'
list, which are cleaned up after reporting to guest in subsequent
hcalls to get the status.

The semantics makes it necessary to preserve the continue_tokens
and their return status even across migrations. So, the pre_save
handler for the device waits for the flush worker to complete and
collects all the hcall states from 'completed' list. The necessary
nvdimm flush specific vmstate structures are added to the spapr
machine vmstate.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr.c                |    6 +
 hw/ppc/spapr_nvdimm.c         |  240 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   11 ++
 include/hw/ppc/spapr_nvdimm.h |   12 ++
 4 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d56418ca29..fdb0c73a2c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1607,6 +1607,8 @@ static void spapr_machine_reset(MachineState *machine)
         spapr->ov5_cas = spapr_ovec_clone(spapr->ov5);
     }
 
+    spapr_nvdimm_finish_flushes();
+
     /* DRC reset may cause a device to be unplugged. This will cause troubles
      * if this device is used by another device (eg, a running vhost backend
      * will crash QEMU if the DIMM holding the vring goes away). To avoid such
@@ -2003,6 +2005,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_ccf_assist,
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
+        &vmstate_spapr_nvdimm_flush_states,
         NULL
     }
 };
@@ -2997,6 +3000,9 @@ static void spapr_machine_init(MachineState *machine)
     }
 
     qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
+    qemu_mutex_init(&spapr->spapr_nvdimm_flush_states_lock);
+    QLIST_INIT(&spapr->pending_flush_states);
+    QLIST_INIT(&spapr->completed_flush_states);
 }
 
 #define DEFAULT_KVM_TYPE "auto"
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 8cf3fb2ffb..883317c1ed 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -22,14 +22,17 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/ppc/spapr_drc.h"
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/mem/nvdimm.h"
+#include "qemu/guest-random.h"
 #include "qemu/nvdimm-utils.h"
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
 #include "hw/ppc/spapr_numa.h"
+#include "block/thread-pool.h"
 
 /*
  * The nvdimm size should be aligned to SCM block size.
@@ -371,6 +374,242 @@ static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static const VMStateDescription vmstate_spapr_nvdimm_entry = {
+     .name = "spapr_nvdimm_states",
+     .version_id = 1,
+     .minimum_version_id = 1,
+     .fields = (VMStateField[]) {
+         VMSTATE_UINT64(continue_token, SpaprNVDIMMDeviceFlushState),
+         VMSTATE_INT64(hcall_ret, SpaprNVDIMMDeviceFlushState),
+         VMSTATE_END_OF_LIST()
+     },
+};
+
+static bool spapr_nvdimm_states_needed(void *opaque)
+{
+     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+
+     return (!QLIST_EMPTY(&spapr->pending_flush_states) ||
+             !QLIST_EMPTY(&spapr->completed_flush_states));
+}
+
+static int spapr_nvdimm_pre_save(void *opaque)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+
+    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
+    return 0;
+}
+
+const VMStateDescription vmstate_spapr_nvdimm_flush_states = {
+    .name = "spapr_nvdimm_hcall_states",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_nvdimm_states_needed,
+    .pre_save = spapr_nvdimm_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_QLIST_V(completed_flush_states, SpaprMachineState, 1,
+                        vmstate_spapr_nvdimm_entry,
+                        SpaprNVDIMMDeviceFlushState, node),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+/*
+ * Acquire a unique token and reserve it for the new flush state.
+ */
+static SpaprNVDIMMDeviceFlushState *spapr_nvdimm_init_new_flush_state(void)
+{
+    Error *err = NULL;
+    uint64_t token;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprNVDIMMDeviceFlushState *tmp, *next, *state;
+
+    state = g_malloc0(sizeof(*state));
+
+    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
+retry:
+    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {
+        error_report_err(err);
+        g_free(state);
+        qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
+        return NULL;
+    }
+
+    if (!token) /* Token should be non-zero */
+        goto retry;
+
+    /* If the token already in use, get a new one */
+    QLIST_FOREACH_SAFE(tmp, &(spapr->pending_flush_states), node, next) {
+        if (tmp->continue_token == token) {
+            goto retry;
+        }
+    }
+    QLIST_FOREACH_SAFE(tmp, &(spapr->completed_flush_states), node, next) {
+        if (tmp->continue_token == token) {
+            goto retry;
+        }
+    }
+
+    state->continue_token = token;
+    QLIST_INSERT_HEAD(&spapr->pending_flush_states, state, node);
+
+    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
+
+    return state;
+}
+
+/*
+ * spapr_nvdimm_finish_flushes
+ *      Waits for all pending flush requests to complete
+ *      their execution and free the states
+ */
+void spapr_nvdimm_finish_flushes(void)
+{
+    SpaprNVDIMMDeviceFlushState *state, *next;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+
+    /*
+     * No contention here when called on reset path, the main loop thread
+     * which calls the pending BHs has gotten out running in the reset path,
+     * finally reaching here. Other code path being guest
+     * h_client_architecture_support, thats early boot up.
+     */
+
+    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
+        aio_poll(qemu_get_aio_context(), true);
+    }
+
+    QLIST_FOREACH_SAFE(state, &spapr->completed_flush_states, node, next) {
+        QLIST_REMOVE(state, node);
+        g_free(state);
+    }
+}
+
+/*
+ * spapr_nvdimm_get_hcall_status
+ *      Fetches the status of the hcall worker and returns H_BUSY
+ *      if the worker is still running.
+ */
+static int spapr_nvdimm_get_flush_status(uint64_t token)
+{
+    int ret = H_LONG_BUSY_ORDER_10_MSEC;
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprNVDIMMDeviceFlushState *state, *node;
+
+    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
+    QLIST_FOREACH_SAFE(state, &spapr->pending_flush_states, node, node) {
+        if (state->continue_token == token) {
+            goto exit;
+        }
+    }
+    ret = H_P2; /* If not found in complete list too, invalid token */
+    QLIST_FOREACH_SAFE(state, &spapr->completed_flush_states, node, node) {
+        if (state->continue_token == token) {
+            ret = state->hcall_ret;
+            QLIST_REMOVE(state, node);
+            g_free(state);
+            break;
+        }
+    }
+exit:
+    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
+
+    return ret;
+}
+
+static int flush_worker_cb(void *opaque)
+{
+    int ret = H_SUCCESS;
+    SpaprNVDIMMDeviceFlushState *state = opaque;
+
+    /* flush raw backing image */
+    if (qemu_fdatasync(state->backend_fd) < 0) {
+        error_report("papr_scm: Could not sync nvdimm to backend file: %s",
+                     strerror(errno));
+        ret = H_HARDWARE;
+    }
+
+    return ret;
+}
+
+static void spapr_nvdimm_flush_completion_cb(void *opaque, int hcall_ret)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprNVDIMMDeviceFlushState *state = opaque;
+
+    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
+
+    state->hcall_ret = hcall_ret;
+    QLIST_REMOVE(state, node);
+    QLIST_INSERT_HEAD(&spapr->completed_flush_states, state, node);
+
+    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
+}
+
+/*
+ * H_SCM_FLUSH
+ * Input: drc_index, continue-token
+ * Out: continue-token
+ * Return Value: H_SUCCESS, H_Parameter, H_P2, H_BUSY
+ *
+ * Given a DRC Index Flush the data to backend NVDIMM device.
+ * The hcall returns H_BUSY when the flush takes longer time and the hcall
+ * needs to be issued multiple times in order to be completely serviced.
+ * The continue-token from the output to be passed in the argument list of
+ * subsequent hcalls until the hcall is completely serviced at which
+ * point H_SUCCESS or other error is returned.
+ */
+static target_ulong h_scm_flush(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                      target_ulong opcode, target_ulong *args)
+{
+    int ret;
+    uint32_t drc_index = args[0];
+    uint64_t continue_token = args[1];
+    SpaprDrc *drc = spapr_drc_by_index(drc_index);
+    PCDIMMDevice *dimm;
+    HostMemoryBackend *backend = NULL;
+    SpaprNVDIMMDeviceFlushState *state;
+    ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (continue_token != 0) {
+        ret = spapr_nvdimm_get_flush_status(continue_token);
+        if (H_IS_LONG_BUSY(ret)) {
+            args[0] = continue_token;
+        }
+
+        return ret;
+    }
+
+    dimm = PC_DIMM(drc->dev);
+    backend = MEMORY_BACKEND(dimm->hostmem);
+
+    state = spapr_nvdimm_init_new_flush_state();
+    if (!state) {
+        return H_P2;
+    }
+
+    state->backend_fd = memory_region_get_fd(&backend->mr);
+
+    thread_pool_submit_aio(pool, flush_worker_cb, state,
+                           spapr_nvdimm_flush_completion_cb, state);
+
+    ret = spapr_nvdimm_get_flush_status(state->continue_token);
+    if (H_IS_LONG_BUSY(ret)) {
+        args[0] = state->continue_token;
+    }
+
+    return ret;
+}
+
 static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                      target_ulong opcode, target_ulong *args)
 {
@@ -487,6 +726,7 @@ static void spapr_scm_register_types(void)
     spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
     spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
     spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
+    spapr_register_hypercall(H_SCM_FLUSH, h_scm_flush);
 }
 
 type_init(spapr_scm_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 47cebaf3ac..7c27fb3e2d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,10 +12,12 @@
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nvdimm.h"
 
 struct SpaprVioBus;
 struct SpaprPhbState;
 struct SpaprNvram;
+struct SpaprNVDIMMDeviceFlushState;
 
 typedef struct SpaprEventLogEntry SpaprEventLogEntry;
 typedef struct SpaprEventSource SpaprEventSource;
@@ -245,6 +247,12 @@ struct SpaprMachineState {
     uint32_t numa_assoc_array[MAX_NODES + NVGPU_MAX_NUM][NUMA_ASSOC_SIZE];
 
     Error *fwnmi_migration_blocker;
+
+    /* nvdimm flush states */
+    QemuMutex spapr_nvdimm_flush_states_lock;
+    QLIST_HEAD(, SpaprNVDIMMDeviceFlushState) pending_flush_states;
+    QLIST_HEAD(, SpaprNVDIMMDeviceFlushState) completed_flush_states;
+
 };
 
 #define H_SUCCESS         0
@@ -538,8 +546,9 @@ struct SpaprMachineState {
 #define H_SCM_BIND_MEM          0x3EC
 #define H_SCM_UNBIND_MEM        0x3F0
 #define H_SCM_UNBIND_ALL        0x3FC
+#define H_SCM_FLUSH             0x44C
 
-#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
+#define MAX_HCALL_OPCODE        H_SCM_FLUSH
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
index abcacda5d7..c88df2c590 100644
--- a/include/hw/ppc/spapr_nvdimm.h
+++ b/include/hw/ppc/spapr_nvdimm.h
@@ -11,6 +11,7 @@
 #define HW_SPAPR_NVDIMM_H
 
 #include "hw/mem/nvdimm.h"
+#include "migration/vmstate.h"
 
 struct SpaprDrc;
 struct SpaprMachineState;
@@ -22,5 +23,16 @@ void spapr_dt_persistent_memory(struct SpaprMachineState *spapr, void *fdt);
 bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp);
 void spapr_add_nvdimm(DeviceState *dev, uint64_t slot);
+void spapr_nvdimm_finish_flushes(void);
+
+typedef struct SpaprNVDIMMDeviceFlushState {
+    uint64_t continue_token;
+    int64_t hcall_ret;
+    int backend_fd;
+
+    QLIST_ENTRY(SpaprNVDIMMDeviceFlushState) node;
+} SpaprNVDIMMDeviceFlushState;
+
+extern const VMStateDescription vmstate_spapr_nvdimm_flush_states;
 
 #endif

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
