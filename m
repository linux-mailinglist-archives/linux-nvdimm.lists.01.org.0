Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584F20B71A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 19:34:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D91D611022296;
	Fri, 26 Jun 2020 10:34:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36B4B11001AC1
	for <linux-nvdimm@lists.01.org>; Fri, 26 Jun 2020 10:34:17 -0700 (PDT)
Received: from 89-64-83-223.dynamic.chello.pl (89.64.83.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 8fbdec14a0a21657; Fri, 26 Jun 2020 19:34:15 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>, Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT][PATCH v3 1/4] ACPICA: Take deferred unmapping of memory into account
Date: Fri, 26 Jun 2020 19:31:16 +0200
Message-ID: <2545526.8MO9PuLXVt@kreacher>
In-Reply-To: <2788992.3K7huLjdjL@kreacher>
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com> <2713141.s8EVnczdoM@kreacher> <2788992.3K7huLjdjL@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 2N2DH5LOVBPFKAH2MDL2KKZHASYUFH5N
X-Message-ID-Hash: 2N2DH5LOVBPFKAH2MDL2KKZHASYUFH5N
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: rafael.j.wysocki@intel.com, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2N2DH5LOVBPFKAH2MDL2KKZHASYUFH5N/>
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

To address that, acpi_os_unmap_memory() provided by Linux can be
modified so as to avoid unmapping the memory region matching the
address range at hand right away and queue it up for later removal.

However, that requires the deferred unmapping of unused memory
regions to be carried out at least occasionally, so modify
ACPICA to do that by invoking a new OS layer function,
acpi_os_release_unused_mappings(), for this purpose every time
the AML interpreter is exited.

For completeness, also call that function from
acpi_db_test_all_objects() after all of the fields have been
tested.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/dbtest.c  | 4 ++++
 drivers/acpi/acpica/exutils.c | 2 ++
 include/acpi/acpiosxf.h       | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
index 6db44a5ac786..55931daa1779 100644
--- a/drivers/acpi/acpica/dbtest.c
+++ b/drivers/acpi/acpica/dbtest.c
@@ -220,6 +220,10 @@ static void acpi_db_test_all_objects(void)
 	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 				  ACPI_UINT32_MAX, acpi_db_test_one_object,
 				  NULL, NULL, NULL);
+
+	/* Release memory mappings that are not needed any more. */
+
+	acpi_os_release_unused_mappings();
 }
 
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 8fefa6feac2f..ae2030095b63 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -106,6 +106,8 @@ void acpi_ex_exit_interpreter(void)
 			    "Could not release AML Interpreter mutex"));
 	}
 
+	acpi_os_release_unused_mappings();
+
 	return_VOID;
 }
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 33bb8c9a089d..0efe2d1725e2 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -187,6 +187,10 @@ void *acpi_os_map_memory(acpi_physical_address where, acpi_size length);
 void acpi_os_unmap_memory(void *logical_address, acpi_size size);
 #endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_unused_mappings
+#define acpi_os_release_unused_mappings()	do { } while (FALSE)
+#endif
+
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_physical_address
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
-- 
2.26.2



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
