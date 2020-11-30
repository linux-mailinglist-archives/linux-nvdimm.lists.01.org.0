Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB42C8784
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Nov 2020 16:16:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9D7E100EC1FB;
	Mon, 30 Nov 2020 07:16:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2E05100EC1F2
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 07:16:52 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUF1vFU090033;
	Mon, 30 Nov 2020 10:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=u6UQQCSFzli0TWn+yzYEmnC3C0qwqphWWsK0dF1Jx48=;
 b=QM1t9vE4Y1/5BTWDJnHUC5e8Rh/cIFCpBvGEzUWG5uRb+Zjg0qBLNETyxixhulLwICka
 Kd3hW6DZIF9ajlEOS0jqWfAZhP1N/G7r3tkllz+Jk3OO/5Kv1F6sbh6J7JZy0Bl985uX
 gMdJow4dUGUC3lNzqNGIShQxtUVjLy/qBrLmpj9/SHQhT9Uzw2WZfGUndoxfDxVcjz1x
 JHeHqJcqx5kG2wj2CwCIciqSxd2jn9XvS+i3XURGC2+jz2y4zSWCOPV7yIeQUZRIpzRd
 fDqCigl2Jx56f2ZgODX4SIgACUqhEIfUoohLXHK8s7g32XYFjHS6QU1y2qTvNo+FP37u ag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 35512gbufa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:16:47 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AUF2IsG091756;
	Mon, 30 Nov 2020 10:16:46 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 35512gbuef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 10:16:46 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AUF92aJ007894;
	Mon, 30 Nov 2020 15:16:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 353e68374s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Nov 2020 15:16:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AUFGg5j43319778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Nov 2020 15:16:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CE65A405C;
	Mon, 30 Nov 2020 15:16:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 608F2A405B;
	Mon, 30 Nov 2020 15:16:40 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 30 Nov 2020 15:16:40 +0000 (GMT)
Subject: [RFC Qemu PATCH v2 1/2] spapr: drc: Add support for async hcalls at
 the drc level
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com,
        david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org
Date: Mon, 30 Nov 2020 09:16:39 -0600
Message-ID: 
 <160674938210.2492771.1728601884822491679.stgit@lep8c.aus.stglabs.ibm.com>
In-Reply-To: 
 <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
References: 
 <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_03:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 suspectscore=2 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300094
Message-ID-Hash: 7VTTZZUFRAXEFYFCHHPZJYE7BNQSGC3P
X-Message-ID-Hash: 7VTTZZUFRAXEFYFCHHPZJYE7BNQSGC3P
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com, linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, aneesh.kumar@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6X2DQ6UQQWR6MIULSXTOR2ESW5CSOM7X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch adds support for async hcalls at the DRC level for the
spapr devices. To be used by spapr-scm devices in the patch/es to follow.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_drc.c         |  149 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_drc.h |   25 +++++++
 2 files changed, 174 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 77718cde1f..4ecd04f686 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -15,6 +15,7 @@
 #include "qapi/qmp/qnull.h"
 #include "cpu.h"
 #include "qemu/cutils.h"
+#include "qemu/guest-random.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
 #include "migration/vmstate.h"
@@ -421,6 +422,148 @@ void spapr_drc_detach(SpaprDrc *drc)
     spapr_drc_release(drc);
 }
 
+
+/*
+ * @drc : device DRC targetting which the async hcalls to be made.
+ *
+ * All subsequent requests to run/query the status should use the
+ * unique token returned here.
+ */
+uint64_t spapr_drc_get_new_async_hcall_token(SpaprDrc *drc)
+{
+    Error *err = NULL;
+    uint64_t token;
+    SpaprDrcDeviceAsyncHCallState *tmp, *next, *state;
+
+    state = g_malloc0(sizeof(*state));
+    state->pending = true;
+
+    qemu_mutex_lock(&drc->async_hcall_states_lock);
+retry:
+    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {
+        error_report_err(err);
+        g_free(state);
+        qemu_mutex_unlock(&drc->async_hcall_states_lock);
+        return 0;
+    }
+
+    if (!token) /* Token should be non-zero */
+        goto retry;
+
+    if (!QLIST_EMPTY(&drc->async_hcall_states)) {
+        QLIST_FOREACH_SAFE(tmp, &drc->async_hcall_states, node, next) {
+            if (tmp->continue_token == token) {
+                /* If the token already in use, get a new one */
+                goto retry;
+            }
+        }
+    }
+
+    state->continue_token = token;
+    QLIST_INSERT_HEAD(&drc->async_hcall_states, state, node);
+
+    qemu_mutex_unlock(&drc->async_hcall_states_lock);
+
+    return state->continue_token;
+}
+
+static void *spapr_drc_async_hcall_runner(void *opaque)
+{
+    int response = -1;
+    SpaprDrcDeviceAsyncHCallState *state = opaque;
+
+    /*
+     * state is freed only after this thread finishes(after pthread_join()),
+     * don't worry about it becoming NULL.
+     */
+
+    response = state->func(state->data);
+
+    state->hcall_ret = response;
+    state->pending = 0;
+
+    return NULL;
+}
+
+/*
+ * @drc  : device DRC targetting which the async hcalls to be made.
+ * token : The continue token to be used for tracking as recived from
+ *         spapr_drc_get_new_async_hcall_token
+ * @func() : the worker function which needs to be executed asynchronously
+ * @data : data to be passed to the asynchronous function. Worker is supposed
+ *         to free/cleanup the data that is passed here
+ */
+void spapr_drc_run_async_hcall(SpaprDrc *drc, uint64_t token,
+                               SpaprDrcAsyncHcallWorkerFunc *func, void *data)
+{
+    SpaprDrcDeviceAsyncHCallState *state;
+
+    qemu_mutex_lock(&drc->async_hcall_states_lock);
+    QLIST_FOREACH(state, &drc->async_hcall_states, node) {
+        if (state->continue_token == token) {
+            state->func = func;
+            state->data = data;
+            qemu_thread_create(&state->thread, "sPAPR Async HCALL",
+                               spapr_drc_async_hcall_runner, state,
+                               QEMU_THREAD_JOINABLE);
+            break;
+        }
+    }
+    qemu_mutex_unlock(&drc->async_hcall_states_lock);
+}
+
+/*
+ * spapr_drc_finish_async_hcalls
+ *      Waits for all pending async requests to complete
+ *      thier execution and free the states
+ */
+static void spapr_drc_finish_async_hcalls(SpaprDrc *drc)
+{
+    SpaprDrcDeviceAsyncHCallState *state, *next;
+
+    if (QLIST_EMPTY(&drc->async_hcall_states)) {
+        return;
+    }
+
+    qemu_mutex_lock(&drc->async_hcall_states_lock);
+    QLIST_FOREACH_SAFE(state, &drc->async_hcall_states, node, next) {
+        qemu_thread_join(&state->thread);
+        QLIST_REMOVE(state, node);
+        g_free(state);
+    }
+    qemu_mutex_unlock(&drc->async_hcall_states_lock);
+}
+
+/*
+ * spapr_drc_get_async_hcall_status
+ *      Fetches the status of the hcall worker and returns H_BUSY
+ *      if the worker is still running.
+ */
+int spapr_drc_get_async_hcall_status(SpaprDrc *drc, uint64_t token)
+{
+    int ret = H_PARAMETER;
+    SpaprDrcDeviceAsyncHCallState *state, *node;
+
+    qemu_mutex_lock(&drc->async_hcall_states_lock);
+    QLIST_FOREACH_SAFE(state, &drc->async_hcall_states, node, node) {
+        if (state->continue_token == token) {
+            if (state->pending) {
+                ret = H_BUSY;
+                break;
+            } else {
+                ret = state->hcall_ret;
+                qemu_thread_join(&state->thread);
+                QLIST_REMOVE(state, node);
+                g_free(state);
+                break;
+            }
+        }
+    }
+    qemu_mutex_unlock(&drc->async_hcall_states_lock);
+
+    return ret;
+}
+
 void spapr_drc_reset(SpaprDrc *drc)
 {
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
@@ -448,6 +591,7 @@ void spapr_drc_reset(SpaprDrc *drc)
         drc->ccs_offset = -1;
         drc->ccs_depth = -1;
     }
+    spapr_drc_finish_async_hcalls(drc);
 }
 
 static bool spapr_drc_unplug_requested_needed(void *opaque)
@@ -558,6 +702,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
     drc->owner = owner;
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
+
     object_property_add_child(owner, prop_name, OBJECT(drc));
     object_unref(OBJECT(drc));
     qdev_realize(DEVICE(drc), NULL, NULL);
@@ -577,6 +722,10 @@ static void spapr_dr_connector_instance_init(Object *obj)
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL);
     drc->state = drck->empty_state;
+
+    qemu_mutex_init(&drc->async_hcall_states_lock);
+    QLIST_INIT(&drc->async_hcall_states);
+
 }
 
 static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 165b281496..77f6e4386c 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -18,6 +18,7 @@
 #include "sysemu/runstate.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
+#include "block/thread-pool.h"
 
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
 #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
@@ -168,6 +169,21 @@ typedef enum {
     SPAPR_DRC_STATE_PHYSICAL_CONFIGURED = 8,
 } SpaprDrcState;
 
+typedef struct SpaprDrc SpaprDrc;
+
+typedef int SpaprDrcAsyncHcallWorkerFunc(void *opaque);
+typedef struct SpaprDrcDeviceAsyncHCallState {
+    uint64_t continue_token;
+    bool pending;
+
+    int hcall_ret;
+    SpaprDrcAsyncHcallWorkerFunc *func;
+    void *data;
+
+    QemuThread thread;
+
+    QLIST_ENTRY(SpaprDrcDeviceAsyncHCallState) node;
+} SpaprDrcDeviceAsyncHCallState;
 typedef struct SpaprDrc {
     /*< private >*/
     DeviceState parent;
@@ -182,6 +198,10 @@ typedef struct SpaprDrc {
     int ccs_offset;
     int ccs_depth;
 
+    /* async hcall states */
+    QemuMutex async_hcall_states_lock;
+    QLIST_HEAD(, SpaprDrcDeviceAsyncHCallState) async_hcall_states;
+
     /* device pointer, via link property */
     DeviceState *dev;
     bool unplug_requested;
@@ -241,6 +261,11 @@ void spapr_drc_detach(SpaprDrc *drc);
 /* Returns true if a hot plug/unplug request is pending */
 bool spapr_drc_transient(SpaprDrc *drc);
 
+uint64_t spapr_drc_get_new_async_hcall_token(SpaprDrc *drc);
+void spapr_drc_run_async_hcall(SpaprDrc *drc, uint64_t token,
+                               SpaprDrcAsyncHcallWorkerFunc, void *data);
+int spapr_drc_get_async_hcall_status(SpaprDrc *drc, uint64_t token);
+
 static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
 {
     return drc->unplug_requested;

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
