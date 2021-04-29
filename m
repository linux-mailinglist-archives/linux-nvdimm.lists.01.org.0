Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8D36E3CE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 05:49:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 15B78100EB325;
	Wed, 28 Apr 2021 20:49:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E289C100EB325
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 20:49:31 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13T3Y2P7004598;
	Wed, 28 Apr 2021 23:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=1+Hl9csVO7jPeFzAFQ1Zx9afiJ6i34856r88Bn4qweg=;
 b=K1BeiXYyeTSiguRC9bcXf4lUNVC+DT6lvWTN9sYjfdcZha768Kqy8BXonwcoCwSQb4LB
 I2bzh17n6KIF71BWjbfjTvJlrfUHG1OeXuFlj2RojjMccOc0iC7YrZvMYMmpns2BRdMB
 TcVTt2OYA9T/g8igPz7rWErWJfZwkO8p30CjCJgD6pmwKzYllJvcolTovDQkGW1j/py2
 VZYL7842eLCa2/5UMi/y0FULQYiQD1turFKcuj38QUdYxaEuJUjMqeWM8/syKOqWDMVb
 uam1A2edGjSxIupe/vfYU7Hy3nTP4vgY8ODNHW/vR9fRwtwuXzjY6w840+/PNgHZzXIS 4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 387n00r716-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Apr 2021 23:49:15 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13T3mRtN049423;
	Wed, 28 Apr 2021 23:49:15 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 387n00r70f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Apr 2021 23:49:14 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13T3nBNj016772;
	Thu, 29 Apr 2021 03:49:11 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 384gjxs660-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Apr 2021 03:49:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13T3n8v923200238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Apr 2021 03:49:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03CA24C046;
	Thu, 29 Apr 2021 03:49:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4A94C040;
	Thu, 29 Apr 2021 03:49:04 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.40.192.207])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 29 Apr 2021 03:49:04 +0000 (GMT)
Subject: [PATCH v4 3/3] nvdimm: Enable sync-dax device property for nvdimm
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: david@gibson.dropbear.id.au, groug@kaod.org, qemu-ppc@nongnu.org,
        ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
        imammedo@redhat.com, xiaoguangrong.eric@gmail.com,
        peter.maydell@linaro.org, eblake@redhat.com, qemu-arm@nongnu.org,
        richard.henderson@linaro.org, pbonzini@redhat.com,
        marcel.apfelbaum@gmail.com, stefanha@redhat.com,
        haozhong.zhang@intel.com, shameerali.kolothum.thodi@huawei.com,
        kwangwoo.lee@sk.com, armbru@redhat.com
Date: Wed, 28 Apr 2021 23:49:03 -0400
Message-ID: <161966813983.652.5749368609701495826.stgit@17be908f7c1c>
In-Reply-To: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tdrzgzZ0tvoI-RrZVFpPsIiBw154En2S
X-Proofpoint-GUID: xNI7P45zBEqmB5bjEKEi8ho9x_3JUEfk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_02:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290025
Message-ID-Hash: IPHPB2H3EUNRUPYNR4CR5KSNDZXBKWB7
X-Message-ID-Hash: IPHPB2H3EUNRUPYNR4CR5KSNDZXBKWB7
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IPHPB2H3EUNRUPYNR4CR5KSNDZXBKWB7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch adds the 'sync-dax' property to the nvdimm device.

When the sync-dax is 'direct' indicates the backend is synchronous DAX
capable and no explicit flush requests are required. When the mode is
set to 'writeback' it indicates the backend is not synhronous DAX
capable and explicit flushes to Hypervisor are required.

On PPC where the flush requests from guest can be honoured by the qemu,
the 'writeback' mode is supported and set as the default. The device
tree property "hcall-flush-required" is added to the nvdimm node which
makes the guest to issue H_SCM_FLUSH hcalls to request for flushes
explicitly. This would be the default behaviour without sync-dax
property set for the nvdimm device. For old pSeries machine, the
default is 'unsafe'.

For non-PPC platforms, the mode is set to 'unsafe' as the default.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/arm/virt.c           |   28 +++++++++++++++++++++++--
 hw/i386/pc.c            |   28 +++++++++++++++++++++++--
 hw/mem/nvdimm.c         |   52 +++++++++++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr.c          |   10 +++++++++
 hw/ppc/spapr_nvdimm.c   |   39 +++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h |   11 ++++++++++
 include/hw/ppc/spapr.h  |    1 +
 qapi/common.json        |   20 ++++++++++++++++++
 8 files changed, 179 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f01d9041b..f32e3e4010 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2358,6 +2358,27 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static bool virt_nvdimm_validate(const MachineState *ms, NVDIMMDevice *nvdimm,
+                                 Error **errp)
+{
+    NvdimmSyncModes sync;
+
+    if (!ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
+        return false;
+    }
+
+    sync = object_property_get_enum(OBJECT(nvdimm), NVDIMM_SYNC_DAX_PROP,
+                                    "NvdimmSyncModes", &error_abort);
+    if (sync == NVDIMM_SYNC_MODES_WRITEBACK) {
+        error_setg(errp, "NVDIMM device " NVDIMM_SYNC_DAX_PROP
+                         "=%s mode unsupported", NvdimmSyncModes_str(sync));
+        return false;
+    }
+
+    return true;
+}
+
 static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
@@ -2376,9 +2397,10 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
-        error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
-        return;
+    if (is_nvdimm) {
+        if (!virt_nvdimm_validate(ms, NVDIMM(dev), errp)) {
+            return;
+        }
     }
 
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8a84b25a03..2d5151462c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1211,6 +1211,27 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     g_free(i8259);
 }
 
+static bool pc_nvdimm_validate(const MachineState *ms, NVDIMMDevice *nvdimm,
+                               Error **errp)
+{
+    NvdimmSyncModes sync;
+
+    if (!ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
+        return false;
+    }
+
+    sync = object_property_get_enum(OBJECT(nvdimm), NVDIMM_SYNC_DAX_PROP,
+                                    "NvdimmSyncModes", &error_abort);
+    if (sync == NVDIMM_SYNC_MODES_WRITEBACK) {
+        error_setg(errp, "NVDIMM device " NVDIMM_SYNC_DAX_PROP
+                   "=%s mode unsupported", NvdimmSyncModes_str(sync));
+        return false;
+    }
+
+    return true;
+}
+
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
@@ -1233,9 +1254,10 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
-        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
-        return;
+    if (is_nvdimm) {
+        if (!pc_nvdimm_validate(ms, NVDIMM(dev), errp)) {
+            return;
+        }
     }
 
     hotplug_handler_pre_plug(x86ms->acpi_dev, dev, &local_err);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 7397b67156..56b4527362 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -96,6 +96,19 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
     g_free(value);
 }
 
+static int nvdimm_get_sync_mode(Object *obj, Error **errp G_GNUC_UNUSED)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+
+    return nvdimm->sync_dax;
+}
+
+static void nvdimm_set_sync_mode(Object *obj, int mode, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+
+    nvdimm->sync_dax = mode;
+}
 
 static void nvdimm_init(Object *obj)
 {
@@ -105,6 +118,13 @@ static void nvdimm_init(Object *obj)
 
     object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
                         nvdimm_set_uuid, NULL, NULL);
+
+    object_property_add_enum(obj, NVDIMM_SYNC_DAX_PROP, "NvdimmSyncModes",
+                             &NvdimmSyncModes_lookup, nvdimm_get_sync_mode,
+                             nvdimm_set_sync_mode);
+    object_property_set_description(obj, NVDIMM_SYNC_DAX_PROP,
+                                    "Set the Synchronus DAX mode");
+
 }
 
 static void nvdimm_finalize(Object *obj)
@@ -119,6 +139,9 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
     PCDIMMDevice *dimm = PC_DIMM(nvdimm);
     uint64_t align, pmem_size, size;
     MemoryRegion *mr;
+    HostMemoryBackend *hostmem;
+    bool is_file_backed;
+    bool __attribute__((unused)) is_pmem = false;
 
     g_assert(!nvdimm->nvdimm_mr);
 
@@ -135,9 +158,8 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
     nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
     pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
 
+    hostmem = dimm->hostmem;
     if (size <= nvdimm->label_size || !pmem_size) {
-        HostMemoryBackend *hostmem = dimm->hostmem;
-
         error_setg(errp, "the size of memdev %s (0x%" PRIx64 ") is too "
                    "small to contain nvdimm label (0x%" PRIx64 ") and "
                    "aligned PMEM (0x%" PRIx64 ")",
@@ -147,14 +169,36 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
     }
 
     if (!nvdimm->unarmed && memory_region_is_rom(mr)) {
-        HostMemoryBackend *hostmem = dimm->hostmem;
-
         error_setg(errp, "'unarmed' property must be off since memdev %s "
                    "is read-only",
                    object_get_canonical_path_component(OBJECT(hostmem)));
         return;
     }
 
+    is_file_backed = (memory_region_get_fd(mr) > 0);
+    if (nvdimm->sync_dax == NVDIMM_SYNC_MODES_WRITEBACK && !is_file_backed) {
+        error_setg(errp, NVDIMM_SYNC_DAX_PROP"='%s' mode requires the "
+                   "memdev %s to be file backed",
+                   NvdimmSyncModes_str(nvdimm->sync_dax),
+                   object_get_canonical_path_component(OBJECT(hostmem)));
+        return;
+    }
+
+#ifdef CONFIG_LIBPMEM
+    if (is_file_backed) {
+        is_pmem = object_property_get_bool(OBJECT(hostmem), "pmem",
+                                           &error_abort);
+    }
+
+    if (nvdimm->sync_dax == NVDIMM_SYNC_MODES_DIRECT && !is_pmem) {
+        error_setg(errp, "NVDIMM device "NVDIMM_SYNC_DAX_PROP"=%s mode requires"
+                   " the memory backend device to be synchronous DAX capable. "
+                   "Indicate it so with pmem=yes for the corresponding "
+                   "memory-backend-file.",
+                   NvdimmSyncModes_str(nvdimm->sync_dax));
+    }
+#endif
+
     nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
     memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
                              "nvdimm-memory", mr, 0, pmem_size);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 80957f9188..d0058bc13b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4616,6 +4616,11 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 static void spapr_machine_6_0_class_options(MachineClass *mc)
 {
     /* Defaults for the latest behaviour inherited from the base class */
+    static GlobalProperty compat[] = {
+        { "nvdimm", "sync-dax", "writeback" },
+    };
+
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
 DEFINE_SPAPR_MACHINE(6_0, "6.0", true);
@@ -4625,8 +4630,13 @@ DEFINE_SPAPR_MACHINE(6_0, "6.0", true);
  */
 static void spapr_machine_5_2_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { "nvdimm", "sync-dax", "unsafe" },
+    };
+
     spapr_machine_6_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 
 DEFINE_SPAPR_MACHINE(5_2, "5.2", false);
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 77eb7e1293..615439391c 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -50,6 +50,10 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
 {
     const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     const MachineState *ms = MACHINE(hotplug_dev);
+    PCDIMMDevice __attribute__((unused)) *dimm = PC_DIMM(nvdimm);
+    MemoryRegion __attribute__((unused)) *mr;
+    bool __attribute__((unused)) is_pmem = false;
+    NvdimmSyncModes __attribute__((unused)) sync;
     g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
@@ -77,6 +81,24 @@ bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
         return false;
     }
 
+#ifdef CONFIG_LIBPMEM
+    sync = object_property_get_enum(OBJECT(nvdimm), NVDIMM_SYNC_DAX_PROP,
+                                    "NvdimmSyncModes", &error_abort);
+
+    mr = host_memory_backend_get_memory(dimm->hostmem);
+    if (memory_region_get_fd(mr) > 0) { /* memor-backend-file */
+        HostMemoryBackend *backend = MEMORY_BACKEND(dimm->hostmem);
+        is_pmem = object_property_get_bool(OBJECT(backend), "pmem",
+                                           &error_abort);
+    }
+
+    if (sync == NVDIMM_SYNC_MODES_WRITEBACK && is_pmem) {
+        warn_report("The NVDIMM backing device being Synchronous DAX capable, "
+                    NVDIMM_SYNC_DAX_PROP"='%s' is unnecessary as the backend "
+                    "ensures the safety already.", NvdimmSyncModes_str(sync));
+    }
+#endif
+
     uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP,
                                       &error_abort);
     ret = qemu_uuid_parse(uuidstr, &uuid);
@@ -124,6 +146,9 @@ static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
     uint64_t lsize = nvdimm->label_size;
     uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
                                             NULL);
+    NvdimmSyncModes sync_dax = object_property_get_enum(OBJECT(nvdimm),
+                                         NVDIMM_SYNC_DAX_PROP,
+                                         "NvdimmSyncModes", &error_abort);
 
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
     g_assert(drc);
@@ -158,6 +183,11 @@ static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
                              "operating-system")));
     _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL, 0));
 
+    if (sync_dax == NVDIMM_SYNC_MODES_WRITEBACK) {
+        _FDT(fdt_setprop(fdt, child_offset, "ibm,hcall-flush-required",
+                         NULL, 0));
+    }
+
     return child_offset;
 }
 
@@ -566,6 +596,8 @@ static target_ulong h_scm_flush(PowerPCCPU *cpu, SpaprMachineState *spapr,
     uint64_t continue_token = args[1];
     SpaprDrc *drc = spapr_drc_by_index(drc_index);
     PCDIMMDevice *dimm;
+    NVDIMMDevice *nvdimm;
+    NvdimmSyncModes sync_dax;
     HostMemoryBackend *backend = NULL;
     SpaprNVDIMMDeviceFlushState *state;
     ThreadPool *pool = aio_get_thread_pool(qemu_get_aio_context());
@@ -575,6 +607,13 @@ static target_ulong h_scm_flush(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return H_PARAMETER;
     }
 
+    nvdimm = NVDIMM(drc->dev);
+    sync_dax = object_property_get_enum(OBJECT(nvdimm), NVDIMM_SYNC_DAX_PROP,
+                                    "NvdimmSyncModes", &error_abort);
+    if (sync_dax != NVDIMM_SYNC_MODES_WRITEBACK) {
+        return H_UNSUPPORTED;
+    }
+
     if (continue_token != 0) {
         goto get_status;
     }
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index bcf62f825c..ef30bdeca4 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -28,6 +28,7 @@
 #include "qemu/uuid.h"
 #include "hw/acpi/aml-build.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-machine.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -51,6 +52,7 @@ OBJECT_DECLARE_TYPE(NVDIMMDevice, NVDIMMClass, NVDIMM)
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
 #define NVDIMM_UUID_PROP       "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
+#define NVDIMM_SYNC_DAX_PROP   "sync-dax"
 
 struct NVDIMMDevice {
     /* private */
@@ -85,6 +87,15 @@ struct NVDIMMDevice {
      */
     bool unarmed;
 
+    /*
+     * The 'writeback' value would indicate the guest to make explicit
+     * flush requests to hypervisor. When 'direct', the device is
+     * assumed to be synchronous DAX capable and no explicit flush
+     * is required. 'unsafe' indicates flush semantics unimplemented
+     * and the data persistence not guaranteed in power failure scenarios.
+     */
+    NvdimmSyncModes sync_dax;
+
     /*
      * The PPC64 - spapr requires each nvdimm device have a uuid.
      */
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 478c031396..ddde87e2b6 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -332,6 +332,7 @@ struct SpaprMachineState {
 #define H_P7              -60
 #define H_P8              -61
 #define H_P9              -62
+#define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
diff --git a/qapi/common.json b/qapi/common.json
index 7c976296f0..bec1b45b09 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -197,3 +197,23 @@
 { 'enum': 'GrabToggleKeys',
   'data': [ 'ctrl-ctrl', 'alt-alt', 'shift-shift','meta-meta', 'scrolllock',
             'ctrl-scrolllock' ] }
+
+##
+# @NvdimmSyncModes:
+#
+# Indicates the mode of flush to be used to ensure persistence in case
+# of power failures.
+#
+# @unsafe: This is to indicate, the data on the backend device not be
+#          consistent in power failure scenarios.
+# @direct: This is to indicate the backend device supports synchronous DAX
+#          and no explicit flush requests from the guest is required.
+# @writeback: To be used when the backend device doesn't support synchronous
+#             DAX. The hypervisor issues flushes to the disk when requested
+#             by the guest.
+# Since: 6.0
+#
+##
+{ 'enum': 'NvdimmSyncModes',
+  'data': [ 'unsafe', 'writeback',
+            { 'name': 'direct', 'if': 'defined(CONFIG_LIBPMEM)' } ] }

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
