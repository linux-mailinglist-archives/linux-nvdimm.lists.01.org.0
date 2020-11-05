Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B32A7531
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Nov 2020 03:06:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7EE716651BA5;
	Wed,  4 Nov 2020 18:06:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=luzmaximilian@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D90716651BA4
	for <linux-nvdimm@lists.01.org>; Wed,  4 Nov 2020 18:06:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p5so333713ejj.2
        for <linux-nvdimm@lists.01.org>; Wed, 04 Nov 2020 18:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSMHgP1Jnch4n10EFclrFTbEXiLElLRzLCVmmZ3TMoQ=;
        b=KUe13mZXZiayWXF+T959NLo5KC/8ZgQZ6/KdJ7hgUePbHfny4dceCAytix/j+avi3z
         YGsxXIcvmP9ol+K3wDCGyykaCUk4ein6+EOCko/DJvGAFMXtTUk7fbkxsAaZrI8kGmqH
         LD1LseH3z0IUXf1T08d+iIUIaXBNBATCrcxfCgAZ6OssJNgUDtj+qmGRfYkYuObj+f36
         aNIF2nAJcnexbVUorgWTItWoTaCqbdn1W7jVcBAef1wP1gNdL4mt8SZhPZaUjDJQ7Zok
         s0FqH64/NdL59A5NTYYi4q91hdAqLE9SzljEY2LgqwItgooFlxtWAXVCq/vzNIZhc/4C
         VqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSMHgP1Jnch4n10EFclrFTbEXiLElLRzLCVmmZ3TMoQ=;
        b=SsU6BJhIS/B1Z42/xRDTJG/SzvakRDTsvFkXhYg6626bkcNlDc8ue6J5UstR+AUmHQ
         wKf6HnbJpJuamfRdBVXm7ZA3z/hDCyPzZQWEY9pk91MNAOjLLuud7pmfBNzqKyICWd+/
         FqsHpm4vIjHU6PRTeWMGl+v3OZL0Kbo8v4JyhTT6XIv81K2C3NbGnLTiY24s5yT4QI3l
         5a2k5I2aZNwwwVrUioCEyxOMrMDLYkcj5A9hrPt9ZV6Tk0sGA9QGI7cJzzNR8YEQcaDI
         MeBWjdJbfKdqSCyYxa7EP4yDc7020k3zsKZdBriHckWH9r1p3tTm9MU8rYBERMPWxN6G
         zsKQ==
X-Gm-Message-State: AOAM5329jkmTPS5s/1HDH7N1HaqsWV8jojG3nbCTtS954YVIWKmDX7AW
	EbO26lfBJmT2XqMcQHRZg5g=
X-Google-Smtp-Source: ABdhPJxnv+7azspYA47MO2v8N1xMOTTCawWk+YJ5Juxxih2ksFyN7PHehyT2X00TScoEnvsWYRHJng==
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr105984eji.400.1604541968322;
        Wed, 04 Nov 2020 18:06:08 -0800 (PST)
Received: from xws.fritz.box (pd9e5a482.dip0.t-ipconnect.de. [217.229.164.130])
        by smtp.gmail.com with ESMTPSA id p18sm48144edt.23.2020.11.04.18.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 18:06:07 -0800 (PST)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: Fix whitespace inconsistencies
Date: Thu,  5 Nov 2020 03:06:00 +0100
Message-Id: <20201105020600.90443-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: NUTURL66FSG73FA4YI7LVPEVGRQ4NFHJ
X-Message-ID-Hash: NUTURL66FSG73FA4YI7LVPEVGRQ4NFHJ
X-MailFrom: luzmaximilian@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Maximilian Luz <luzmaximilian@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>, linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NUTURL66FSG73FA4YI7LVPEVGRQ4NFHJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replaces spaces with tabs where spaces have been (inconsistently) used
for indentation and removes trailing whitespaces.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Was previously: ACPI: Remove trailing whitespace

Changes in v2:
 - Use checkpatch to scan for inconsistent indentations and fix them
   too, i.e. replace spaces with tabs where appropriate.

---
 drivers/acpi/acpi_video.c        |  6 +++---
 drivers/acpi/battery.c           |  2 +-
 drivers/acpi/event.c             |  2 +-
 drivers/acpi/internal.h          |  2 +-
 drivers/acpi/nfit/core.c         | 10 +++++-----
 drivers/acpi/pci_irq.c           |  2 +-
 drivers/acpi/pci_link.c          | 12 ++++++------
 drivers/acpi/pci_mcfg.c          |  2 +-
 drivers/acpi/power.c             |  6 +++---
 drivers/acpi/processor_perflib.c |  6 +++---
 drivers/acpi/sbs.c               |  2 +-
 drivers/acpi/sbshc.c             |  2 +-
 drivers/acpi/sbshc.h             |  6 +++---
 drivers/acpi/video_detect.c      | 16 ++++++++--------
 drivers/acpi/wakeup.c            |  4 ++--
 15 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bc96457c9e25..a322a7bd286b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -578,7 +578,7 @@ acpi_video_bqc_value_to_level(struct acpi_video_device *device,
 				ACPI_VIDEO_FIRST_LEVEL - 1 - bqc_value;
 
 		level = device->brightness->levels[bqc_value +
-		                                   ACPI_VIDEO_FIRST_LEVEL];
+						   ACPI_VIDEO_FIRST_LEVEL];
 	} else {
 		level = bqc_value;
 	}
@@ -990,8 +990,8 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		goto out_free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-	                  "found %d brightness levels\n",
-	                  br->count - ACPI_VIDEO_FIRST_LEVEL));
+			  "found %d brightness levels\n",
+			  br->count - ACPI_VIDEO_FIRST_LEVEL));
 	return 0;
 
 out_free_levels:
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cab4af532f36..08ee1c7b12e0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -987,7 +987,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 */
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-            (battery->capacity_now <= battery->alarm)))
+	     (battery->capacity_now <= battery->alarm)))
 		acpi_pm_wakeup_event(&battery->device->dev);
 
 	return result;
diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 170643927044..92e59f45329b 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -31,7 +31,7 @@ int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
 	event.type = type;
 	event.data = data;
 	return (blocking_notifier_call_chain(&acpi_chain_head, 0, (void *)&event)
-                        == NOTIFY_BAD) ? -EINVAL : 0;
+			== NOTIFY_BAD) ? -EINVAL : 0;
 }
 EXPORT_SYMBOL(acpi_notifier_call_chain);
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 43411a7457cd..e3638bafb941 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -134,7 +134,7 @@ int acpi_add_power_resource(acpi_handle handle);
 void acpi_power_add_remove_device(struct acpi_device *adev, bool add);
 int acpi_power_wakeup_list_init(struct list_head *list, int *system_level);
 int acpi_device_sleep_wake(struct acpi_device *dev,
-                           int enable, int sleep_state, int dev_state);
+			   int enable, int sleep_state, int dev_state);
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3a3c209ed3d3..442608220b5c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2175,10 +2175,10 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
  * these commands.
  */
 enum nfit_aux_cmds {
-        NFIT_CMD_TRANSLATE_SPA = 5,
-        NFIT_CMD_ARS_INJECT_SET = 7,
-        NFIT_CMD_ARS_INJECT_CLEAR = 8,
-        NFIT_CMD_ARS_INJECT_GET = 9,
+	NFIT_CMD_TRANSLATE_SPA = 5,
+	NFIT_CMD_ARS_INJECT_SET = 7,
+	NFIT_CMD_ARS_INJECT_CLEAR = 8,
+	NFIT_CMD_ARS_INJECT_GET = 9,
 };
 
 static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
@@ -2632,7 +2632,7 @@ static int acpi_nfit_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
 	nfit_blk->bdw_offset = nfit_mem->bdw->offset;
 	mmio = &nfit_blk->mmio[BDW];
 	mmio->addr.base = devm_nvdimm_memremap(dev, nfit_mem->spa_bdw->address,
-                        nfit_mem->spa_bdw->length, nd_blk_memremap_flags(ndbr));
+			nfit_mem->spa_bdw->length, nd_blk_memremap_flags(ndbr));
 	if (!mmio->addr.base) {
 		dev_dbg(dev, "%s failed to map bdw\n",
 				nvdimm_name(nvdimm));
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index dea8a60e18a4..14ee631cb7cf 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -175,7 +175,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
 	 * configure the IRQ assigned to this slot|dev|pin.  The 'source_index'
 	 * indicates which resource descriptor in the resource template (of
 	 * the link device) this interrupt is allocated from.
-	 * 
+	 *
 	 * NOTE: Don't query the Link Device for IRQ information at this time
 	 *       because Link Device enumeration may not have occurred yet
 	 *       (e.g. exists somewhere 'below' this _PRT entry in the ACPI
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 606da5d77ad3..fb4c5632a232 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -6,8 +6,8 @@
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
  *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
  *
- * TBD: 
- *      1. Support more than one IRQ resource entry per link device (index).
+ * TBD:
+ *	1. Support more than one IRQ resource entry per link device (index).
  *	2. Implement start/stop mechanism and use ACPI Bus Driver facilities
  *	   for IRQ management (e.g. start()->_SRS).
  */
@@ -249,8 +249,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 		}
 	}
 
-	/* 
-	 * Query and parse _CRS to get the current IRQ assignment. 
+	/*
+	 * Query and parse _CRS to get the current IRQ assignment.
 	 */
 
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
@@ -396,7 +396,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 /*
  * "acpi_irq_balance" (default in APIC mode) enables ACPI to use PIC Interrupt
  * Link Devices to move the PIRQs around to minimize sharing.
- * 
+ *
  * "acpi_irq_nobalance" (default in PIC mode) tells ACPI not to move any PIC IRQs
  * that the BIOS has already set to active.  This is necessary because
  * ACPI has no automatic means of knowing what ISA IRQs are used.  Note that
@@ -414,7 +414,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
  *
  * Note that PCI IRQ routers have a list of possible IRQs,
  * which may not include the IRQs this table says are available.
- * 
+ *
  * Since this heuristic can't tell the difference between a link
  * that no device will attach to, vs. a link which may be shared
  * by multiple active devices -- it is not optimal.
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 7ddd57abadd1..95f23acd5b80 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -173,7 +173,7 @@ static int pci_mcfg_quirk_matches(struct mcfg_fixup *f, u16 segment,
 {
 	if (!memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
 	    !memcmp(f->oem_table_id, mcfg_oem_table_id,
-	            ACPI_OEM_TABLE_ID_SIZE) &&
+		    ACPI_OEM_TABLE_ID_SIZE) &&
 	    f->oem_revision == mcfg_oem_revision &&
 	    f->segment == segment &&
 	    resource_contains(&f->bus_range, bus_range))
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 837b875d075e..8048da85b7e0 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -13,7 +13,7 @@
  * 1. via "Device Specific (D-State) Control"
  * 2. via "Power Resource Control".
  * The code below deals with ACPI Power Resources control.
- * 
+ *
  * An ACPI "power resource object" represents a software controllable power
  * plane, clock plane, or other resource depended on by a device.
  *
@@ -645,7 +645,7 @@ int acpi_power_wakeup_list_init(struct list_head *list, int *system_level_p)
  * -ENODEV if the execution of either _DSW or _PSW has failed
  */
 int acpi_device_sleep_wake(struct acpi_device *dev,
-                           int enable, int sleep_state, int dev_state)
+			   int enable, int sleep_state, int dev_state)
 {
 	union acpi_object in_arg[3];
 	struct acpi_object_list arg_list = { 3, in_arg };
@@ -690,7 +690,7 @@ int acpi_device_sleep_wake(struct acpi_device *dev,
 
 /*
  * Prepare a wakeup device, two steps (Ref ACPI 2.0:P229):
- * 1. Power on the power resources required for the wakeup device 
+ * 1. Power on the power resources required for the wakeup device
  * 2. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
  *    State Wake) for the device, if present
  */
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8fa4013..b04a68950ff1 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -354,7 +354,7 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 				  (u32) px->control, (u32) px->status));
 
 		/*
- 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
+		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
 		 */
 		if (!px->core_frequency ||
 		    ((u32)(px->core_frequency * 1000) !=
@@ -627,7 +627,7 @@ int acpi_processor_preregister_performance(
 		goto err_ret;
 
 	/*
-	 * Now that we have _PSD data from all CPUs, lets setup P-state 
+	 * Now that we have _PSD data from all CPUs, lets setup P-state
 	 * domain info.
 	 */
 	for_each_possible_cpu(i) {
@@ -693,7 +693,7 @@ int acpi_processor_preregister_performance(
 			if (match_pdomain->domain != pdomain->domain)
 				continue;
 
-			match_pr->performance->shared_type = 
+			match_pr->performance->shared_type =
 					pr->performance->shared_type;
 			cpumask_copy(match_pr->performance->shared_cpu_map,
 				     pr->performance->shared_cpu_map);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f158b8c30113..e6d9f4de2800 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -366,7 +366,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 					 state_readers[i].mode,
 					 ACPI_SBS_BATTERY,
 					 state_readers[i].command,
-				         (u8 *)battery +
+					 (u8 *)battery +
 						state_readers[i].offset);
 		if (result)
 			goto end;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 87b74e9015e5..53c2862c4c75 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -176,7 +176,7 @@ int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 address,
 EXPORT_SYMBOL_GPL(acpi_smbus_write);
 
 int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
-			         smbus_alarm_callback callback, void *context)
+				 smbus_alarm_callback callback, void *context)
 {
 	mutex_lock(&hc->lock);
 	hc->callback = callback;
diff --git a/drivers/acpi/sbshc.h b/drivers/acpi/sbshc.h
index c3522bb82792..695c390e2884 100644
--- a/drivers/acpi/sbshc.h
+++ b/drivers/acpi/sbshc.h
@@ -24,9 +24,9 @@ enum acpi_sbs_device_addr {
 typedef void (*smbus_alarm_callback)(void *context);
 
 extern int acpi_smbus_read(struct acpi_smb_hc *hc, u8 protocol, u8 address,
-	       u8 command, u8 * data);
+		u8 command, u8 *data);
 extern int acpi_smbus_write(struct acpi_smb_hc *hc, u8 protocol, u8 slave_address,
-		u8 command, u8 * data, u8 length);
+		u8 command, u8 *data, u8 length);
 extern int acpi_smbus_register_callback(struct acpi_smb_hc *hc,
-			         smbus_alarm_callback callback, void *context);
+		smbus_alarm_callback callback, void *context);
 extern int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc);
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 3a032afd9d05..4f5463b2a217 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -178,14 +178,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
 		},
 	},
-        {
-         .callback = video_detect_force_video,
-         .ident = "ThinkPad X201T",
-         .matches = {
-                DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-                DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
-                },
-        },
+	{
+	 .callback = video_detect_force_video,
+	 .ident = "ThinkPad X201T",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
+		},
+	},
 
 	/* The native backlight controls do not work on some older machines */
 	{
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index f89dd9a99e6e..b02bf770aead 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -44,7 +44,7 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
-		        || dev->wakeup.prepare_count))
+			 || dev->wakeup.prepare_count))
 			continue;
 
 		if (device_may_wakeup(&dev->dev))
@@ -69,7 +69,7 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
-		        || dev->wakeup.prepare_count))
+			 || dev->wakeup.prepare_count))
 			continue;
 
 		acpi_set_gpe_wake_mask(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
