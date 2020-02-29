Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF58174938
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4BB7610FC33F7;
	Sat, 29 Feb 2020 12:37:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C58D510FC33F6
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:17 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:25 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="411766668"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:25 -0800
Subject: [ndctl PATCH 03/36] ndctl/list: Drop named list objects from
 verbose listing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:20:20 -0800
Message-ID: <158300762015.2141307.366599346193388777.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 4BTGSYDUF34AKZH3NM4INXRGZFD3MPTQ
X-Message-ID-Hash: 4BTGSYDUF34AKZH3NM4INXRGZFD3MPTQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4BTGSYDUF34AKZH3NM4INXRGZFD3MPTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The only expected difference between "ndctl list -R" and "ndctl list
-Rv" is some additional output fields. Instead it currently results in
the region array being contained in a named "regions" list object.

# ndctl list -R -r 0
[
  {
    "dev":"region0",
    "size":4294967296,
    "available_size":0,
    "max_available_extent":0,
    "type":"pmem",
    "persistence_domain":"unknown"
  }
]

# ndctl list -Rv -r 0
{
  "regions":[
    {
      "dev":"region0",
      "size":4294967296,
      "available_size":0,
      "max_available_extent":0,
      "type":"pmem",
      "numa_node":0,
      "target_node":2,
      "persistence_domain":"unknown",
      "namespaces":[
        {
          "dev":"namespace0.0",
          "mode":"fsdax",
          "map":"mem",
          "size":4294967296,
          "sector_size":512,
          "blockdev":"pmem0",
          "numa_node":0,
          "target_node":2
        }
      ]
    }
  ]
}

Drop the named list, by not including namespaces in the listing. Extra
objects only appear at the -vv level. "ndctl list -v" and "ndctl list
-Nv" are synonyms and behave as expected.

# export NDCTL_LIST_LINT=1
# ndctl list -Rv -r 0
[
  {
    "dev":"region0",
    "size":4294967296,
    "available_size":0,
    "max_available_extent":0,
    "type":"pmem",
    "numa_node":0,
    "target_node":2,
    "persistence_domain":"unknown"
  }
]

Another side effect of this change is that it allows for:

    ndctl list -Rvvv

...to only show the verbose region details vs assuming that namespaces
and dimms etc also need to be added.

Note that a new NDCTL_LIST_LINT environment variable is added to limit
this output cleanup to environments that were not dependent on the
legacy behavior.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-list.txt |   58 ++++++++++++++++++++++++++++++++++++
 ndctl/list.c                       |   17 ++++++++---
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index f9c7434d3b0b..bc725baa6656 100644
--- a/Documentation/ndctl/ndctl-list.txt
+++ b/Documentation/ndctl/ndctl-list.txt
@@ -234,6 +234,52 @@ include::xable-bus-options.txt[]
 	- *-vvv*
 	  Everything '-vv' provides, plus --health, --capabilities,
 	  --idle, and --firmware.
+::
+	The verbosity can also be scoped by the object type. For example
+	to just list regions with capabilities and media error info.
+----
+# ndctl list -Ru -vvv -r 0
+{
+  "dev":"region0",
+  "size":"4.00 GiB (4.29 GB)",
+  "available_size":0,
+  "max_available_extent":0,
+  "type":"pmem",
+  "numa_node":0,
+  "target_node":2,
+  "capabilities":[
+    {
+      "mode":"sector",
+      "sector_sizes":[
+        512,
+        520,
+        528,
+        4096,
+        4104,
+        4160,
+        4224
+      ]
+    },
+    {
+      "mode":"fsdax",
+      "alignments":[
+        4096,
+        2097152,
+        1073741824
+      ]
+    },
+    {
+      "mode":"devdax",
+      "alignments":[
+        4096,
+        2097152,
+        1073741824
+      ]
+    }
+  ],
+  "persistence_domain":"unknown"
+}
+----
 
 include::human-option.txt[]
 
@@ -261,6 +307,18 @@ include::human-option.txt[]
 }
 ----
 
+ENVIRONMENT VARIABLES
+---------------------
+'NDCTL_LIST_LINT'::
+	A bug in the "ndctl list" output needs to be fixed with care for
+	other tooling that may have developed a dependency on the buggy
+	behavior. The NDCTL_LIST_LINT variable is an opt-in to apply
+	fixes, and not regress previously shipped behavior by default.
+	This environment variable applies the following fixups:
+	- Fix "ndctl list -Rv" to only show region objects and not include
+	  namespace objects.
+::
+
 include::../copyright.txt[]
 
 SEE ALSO
diff --git a/ndctl/list.c b/ndctl/list.c
index 86ffbcfe8560..7d7835247005 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -481,6 +481,7 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		"ndctl list [<options>]",
 		NULL
 	};
+	bool lint = !!secure_getenv("NDCTL_LIST_LINT");
 	struct util_filter_ctx fctx = { 0 };
 	struct list_filter_arg lfa = { 0 };
 	int i, rc;
@@ -507,12 +508,20 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		list.health = true;
 		list.capabilities = true;
 	case 2:
-		list.dimms = true;
-		list.buses = true;
-		list.regions = true;
+		if (!lint) {
+			list.dimms = true;
+			list.buses = true;
+			list.regions = true;
+		} else if (num_list_flags() == 0) {
+			list.dimms = true;
+			list.buses = true;
+			list.regions = true;
+			list.namespaces = true;
+		}
 	case 1:
 		list.media_errors = true;
-		list.namespaces = true;
+		if (!lint)
+			list.namespaces = true;
 		list.dax = true;
 	case 0:
 		break;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
