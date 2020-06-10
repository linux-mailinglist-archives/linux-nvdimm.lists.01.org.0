Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68A1F5492
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jun 2020 14:23:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A60C3100A302B;
	Wed, 10 Jun 2020 05:23:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0EBAF100A457E
	for <linux-nvdimm@lists.01.org>; Wed, 10 Jun 2020 05:23:38 -0700 (PDT)
Received: from 89-64-83-71.dynamic.chello.pl (89.64.83.71) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id c86131f5cc9a7435; Wed, 10 Jun 2020 14:23:37 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on interpreter exit
Date: Wed, 10 Jun 2020 14:21:48 +0200
Message-ID: <3974162.pZLctmZ5Iv@kreacher>
In-Reply-To: <318372766.6LKUBsbRXE@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <318372766.6LKUBsbRXE@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: JSKEI3GOM2VHJV4TBFGJE3M4U54E3XSM
X-Message-ID-Hash: JSKEI3GOM2VHJV4TBFGJE3M4U54E3XSM
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Erik Kaneda <erik.kaneda@intel.com>, rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JSKEI3GOM2VHJV4TBFGJE3M4U54E3XSM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

For transient memory opregions that are created dynamically under
the namespace and interpreter mutexes and go away quickly, there
still is the problem that removing their memory mappings may take
significant time and so doing that while holding the mutexes should
be avoided.

For example, unmapping a chunk of memory associated with a memory
opregion in Linux involves running synchronize_rcu_expedited()
which really should not be done with the namespace mutex held.

To address that problem, notice that the unused memory mappings left
behind by the "dynamic" opregions that went away need not be unmapped
right away when the opregion is deactivated.  Instead, they may be
unmapped when exiting the interpreter, after the namespace and
interpreter mutexes have been dropped (there's one more place dealing
with opregions in the debug code that can be treated analogously).

Accordingly, change acpi_ev_system_memory_region_setup() to put
the unused mappings into a global list instead of unmapping them
right away and add acpi_ev_system_release_memory_mappings() to
be called when leaving the interpreter in order to unmap the
unused memory mappings in the global list (which is protected
by the namespace mutex).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acevents.h |  2 ++
 drivers/acpi/acpica/dbtest.c   |  3 ++
 drivers/acpi/acpica/evrgnini.c | 51 ++++++++++++++++++++++++++++++++--
 drivers/acpi/acpica/exutils.c  |  3 ++
 drivers/acpi/acpica/utxface.c  | 23 +++++++++++++++
 include/acpi/acpixf.h          |  1 +
 6 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 79f292687bd6..463eb9124765 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -197,6 +197,8 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
 /*
  * evregini - Region initialization and setup
  */
+void acpi_ev_system_release_memory_mappings(void);
+
 acpi_status
 acpi_ev_system_memory_region_setup(acpi_handle handle,
 				   u32 function,
diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
index 6db44a5ac786..7dac6dae5c48 100644
--- a/drivers/acpi/acpica/dbtest.c
+++ b/drivers/acpi/acpica/dbtest.c
@@ -8,6 +8,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acdebug.h"
+#include "acevents.h"
 #include "acnamesp.h"
 #include "acpredef.h"
 #include "acinterp.h"
@@ -768,6 +769,8 @@ acpi_db_test_field_unit_type(union acpi_operand_object *obj_desc)
 		acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 
+		acpi_ev_system_release_memory_mappings();
+
 		bit_length = obj_desc->common_field.bit_length;
 		byte_length = ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 48a5e6eaf9b9..946c4eef054d 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -16,6 +16,52 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evrgnini")
 
+#ifdef ACPI_OS_MAP_MEMORY_FAST_PATH
+static struct acpi_mem_mapping *unused_memory_mappings;
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_system_release_memory_mappings
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Release all of the unused memory mappings in the queue
+ *              under the interpreter mutex.
+ *
+ ******************************************************************************/
+void acpi_ev_system_release_memory_mappings(void)
+{
+	struct acpi_mem_mapping *mapping;
+
+	ACPI_FUNCTION_TRACE(acpi_ev_system_release_memory_mappings);
+
+	acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+
+	while (unused_memory_mappings) {
+		mapping = unused_memory_mappings;
+		unused_memory_mappings = mapping->next;
+
+		acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+		acpi_os_unmap_memory(mapping->logical_address, mapping->length);
+		ACPI_FREE(mapping);
+
+		acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	}
+
+	acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+
+	return_VOID;
+}
+#else /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
+void acpi_ev_system_release_memory_mappings(void)
+{
+	return_VOID;
+}
+#endif /* !ACPI_OS_MAP_MEMORY_FAST_PATH */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_system_memory_region_setup
@@ -60,9 +106,8 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 				while (local_region_context->first_mapping) {
 					mapping = local_region_context->first_mapping;
 					local_region_context->first_mapping = mapping->next;
-					acpi_os_unmap_memory(mapping->logical_address,
-							     mapping->length);
-					ACPI_FREE(mapping);
+					mapping->next = unused_memory_mappings;
+					unused_memory_mappings = mapping;
 				}
 #endif
 			}
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 8fefa6feac2f..516d67664392 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -25,6 +25,7 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
+#include "acevents.h"
 #include "acinterp.h"
 #include "amlcode.h"
 
@@ -106,6 +107,8 @@ void acpi_ex_exit_interpreter(void)
 			    "Could not release AML Interpreter mutex"));
 	}
 
+	acpi_ev_system_release_memory_mappings();
+
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index ca7c9f0144ef..d972696be846 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -11,6 +11,7 @@
 
 #include <acpi/acpi.h>
 #include "accommon.h"
+#include "acevents.h"
 #include "acdebug.h"
 
 #define _COMPONENT          ACPI_UTILITIES
@@ -244,6 +245,28 @@ acpi_status acpi_purge_cached_objects(void)
 
 ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
 
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_release_unused_memory_mappings
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Remove memory mappings that are not used any more.
+ *
+ ****************************************************************************/
+void acpi_release_unused_memory_mappings(void)
+{
+	ACPI_FUNCTION_TRACE(acpi_release_unused_memory_mappings);
+
+	acpi_ev_system_release_memory_mappings();
+
+	return_VOID;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_release_unused_memory_mappings)
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_install_interface
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1dc8d262035b..8d2cc02257ed 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -449,6 +449,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 						    acpi_size length,
 						    struct acpi_pld_info
 						    **return_buffer))
+ACPI_EXTERNAL_RETURN_VOID(void acpi_release_unused_memory_mappings(void))
 
 /*
  * ACPI table load/unload interfaces
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
