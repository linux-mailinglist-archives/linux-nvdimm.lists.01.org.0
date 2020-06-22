Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377D2038AB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 16:03:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C54C610FCC6C8;
	Mon, 22 Jun 2020 07:03:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4304F10FCBAA8
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 07:03:23 -0700 (PDT)
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 43d1fddb106f0010; Mon, 22 Jun 2020 16:03:21 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH v2 1/4] ACPICA: Defer unmapping of opregion memory if supported by OS
Date: Mon, 22 Jun 2020 15:52:34 +0200
Message-ID: <1905235.LigdQVVlvn@kreacher>
In-Reply-To: <2713141.s8EVnczdoM@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: HHIYGYZWUE5ABGBBQLZBCR4765FVPCEC
X-Message-ID-Hash: HHIYGYZWUE5ABGBBQLZBCR4765FVPCEC
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HHIYGYZWUE5ABGBBQLZBCR4765FVPCEC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The ACPI OS layer in Linux uses RCU to protect the walkers of the
list of ACPI memory mappings from seeing an inconsistent state
while it is being updated.  Among other situations, that list can
be walked in (NMI and non-NMI) interrupt context, so using a
sleeping lock to protect it is not an option.

However, performance issues related to the RCU usage in there
appear, as described by Dan Williams:

"Recently a performance problem was reported for a process invoking
a non-trival ASL program. The method call in this case ends up
repetitively triggering a call path like:

    acpi_ex_store
    acpi_ex_store_object_to_node
    acpi_ex_write_data_to_field
    acpi_ex_insert_into_field
    acpi_ex_write_with_update_rule
    acpi_ex_field_datum_io
    acpi_ex_access_region
    acpi_ev_address_space_dispatch
    acpi_ex_system_memory_space_handler
    acpi_os_map_cleanup.part.14
    _synchronize_rcu_expedited.constprop.89
    schedule

The end result of frequent synchronize_rcu_expedited() invocation is
tiny sub-millisecond spurts of execution where the scheduler freely
migrates this apparently sleepy task. The overhead of frequent
scheduler invocation multiplies the execution time by a factor
of 2-3X."

The source of this is that acpi_ex_system_memory_space_handler()
unmaps the memory mapping currently cached by it at the access time
if that mapping doesn't cover the memory area being accessed.
Consequently, if there is a memory opregion with two fields
separated from each other by an unused chunk of address space that
is large enough for not being covered by a single mapping, and they
happen to be used in an alternating pattern, the unmapping will
occur on every acpi_ex_system_memory_space_handler() invocation for
that memory opregion and that will lead to significant overhead.

However, if the OS supports deferred unmapping of ACPI memory,
such that the unused mappings will not be unmapped immediately,
but collected for unmapping when directly requested later,
acpi_ex_system_memory_space_handler() can be optimized to avoid
the above issue.

Namely, if ACPI_USE_DEFERRED_UNMAPPING is set for the given OS,
it is expected to provide acpi_os_unmap_deferred(), for dropping
references to memory mapping and queuing up the unused ones for
later unmapping, and acpi_os_release_unused_mappings(), for the
eventual unmapping of the unused mappings queued up earlier.

Accordingly, if ACPI_USE_DEFERRED_UNMAPPING is set,
acpi_ex_system_memory_space_handler() can use
acpi_os_unmap_deferred() to unmap memory ranges mapped by it,
so they are not unmapped right away, which addresses the issue
described above, and the unused mappings queued up by it for
removal can be unmapped later via acpi_os_release_unused_mappings().

Implement the ACPICA side of the described mechanism so as to
avoid the RCU-related performance issues with memory opregions.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acinterp.h |  2 ++
 drivers/acpi/acpica/dbtest.c   |  2 ++
 drivers/acpi/acpica/evrgnini.c |  5 +----
 drivers/acpi/acpica/exregion.c | 29 +++++++++++++++++++++++++++--
 drivers/acpi/acpica/exutils.c  |  2 ++
 drivers/acpi/acpica/utxface.c  | 24 ++++++++++++++++++++++++
 include/acpi/acpixf.h          |  1 +
 7 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index a6d896cda2a5..1f1026fb06e9 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -479,6 +479,8 @@ void acpi_ex_pci_cls_to_string(char *dest, u8 class_code[3]);
 
 u8 acpi_is_valid_space_id(u8 space_id);
 
+void acpi_ex_unmap_region_memory(struct acpi_mem_space_context *mem_info);
+
 /*
  * exregion - default op_region handlers
  */
diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
index 6db44a5ac786..a3d119bb2857 100644
--- a/drivers/acpi/acpica/dbtest.c
+++ b/drivers/acpi/acpica/dbtest.c
@@ -768,6 +768,8 @@ acpi_db_test_field_unit_type(union acpi_operand_object *obj_desc)
 		acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 		acpi_ut_release_mutex(ACPI_MTX_INTERPRETER);
 
+		acpi_release_unused_memory_mappings();
+
 		bit_length = obj_desc->common_field.bit_length;
 		byte_length = ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
 
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index aefc0145e583..9f33114a74ca 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -49,10 +49,7 @@ acpi_ev_system_memory_region_setup(acpi_handle handle,
 			/* Delete a cached mapping if present */
 
 			if (local_region_context->mapped_length) {
-				acpi_os_unmap_memory(local_region_context->
-						     mapped_logical_address,
-						     local_region_context->
-						     mapped_length);
+				acpi_ex_unmap_region_memory(local_region_context);
 			}
 			ACPI_FREE(local_region_context);
 			*region_context = NULL;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index d15a66de26c0..af777b7fccb0 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -14,6 +14,32 @@
 #define _COMPONENT          ACPI_EXECUTER
 ACPI_MODULE_NAME("exregion")
 
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_ex_unmap_region_memory
+ *
+ * PARAMETERS:  mem_info            - Region specific context
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Unmap memory associated with a memory operation region.
+ *
+ ****************************************************************************/
+void acpi_ex_unmap_region_memory(struct acpi_mem_space_context *mem_info)
+{
+	ACPI_FUNCTION_TRACE(acpi_ex_unmap_region_memory);
+
+#ifdef ACPI_USE_DEFERRED_UNMAPPING
+	acpi_os_unmap_deferred(mem_info->mapped_logical_address,
+			       mem_info->mapped_length);
+#else
+	acpi_os_unmap_memory(mem_info->mapped_logical_address,
+			     mem_info->mapped_length);
+#endif
+
+	return_VOID;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_system_memory_space_handler
@@ -108,8 +134,7 @@ acpi_ex_system_memory_space_handler(u32 function,
 
 			/* Valid mapping, delete it */
 
-			acpi_os_unmap_memory(mem_info->mapped_logical_address,
-					     mem_info->mapped_length);
+			acpi_ex_unmap_region_memory(mem_info);
 		}
 
 		/*
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 8fefa6feac2f..9597baf33eb4 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -106,6 +106,8 @@ void acpi_ex_exit_interpreter(void)
 			    "Could not release AML Interpreter mutex"));
 	}
 
+	acpi_release_unused_memory_mappings();
+
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index ca7c9f0144ef..a70ac19a207b 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -244,6 +244,30 @@ acpi_status acpi_purge_cached_objects(void)
 
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
+#ifdef ACPI_USE_DEFERRED_UNMAPPING
+	acpi_os_release_unused_mappings();
+#endif
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
index 459d6981ca96..068ed92f5e28 100644
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
