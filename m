Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15910A7B0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Nov 2019 01:56:29 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D177110113330;
	Tue, 26 Nov 2019 16:59:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 831CD1011332F
	for <linux-nvdimm@lists.01.org>; Tue, 26 Nov 2019 16:59:48 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 16:56:25 -0800
X-IronPort-AV: E=Sophos;i="5.69,247,1571727600";
   d="scan'208";a="199010102"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 16:56:24 -0800
Subject: [ndctl PATCH] ndctl/list: Drop named list objects from verbose
 listing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 26 Nov 2019 16:42:07 -0800
Message-ID: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: QBJL2XU4KVFLLJPO4VOC65S5WZA3SK6L
X-Message-ID-Hash: QBJL2XU4KVFLLJPO4VOC65S5WZA3SK6L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QBJL2XU4KVFLLJPO4VOC65S5WZA3SK6L/>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-list.txt |   46 ++++++++++++++++++++++++++++++++++++
 ndctl/list.c                       |   10 +++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/ndctl/ndctl-list.txt b/Documentation/ndctl/ndctl-list.txt
index f9c7434d3b0b..75fd11876395 100644
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
 
diff --git a/ndctl/list.c b/ndctl/list.c
index 607996a85784..125a9fe34cb8 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -507,12 +507,14 @@ int cmd_list(int argc, const char **argv, struct ndctl_ctx *ctx)
 		list.health = true;
 		list.capabilities = true;
 	case 2:
-		list.dimms = true;
-		list.buses = true;
-		list.regions = true;
+		if (num_list_flags() == 0) {
+			list.dimms = true;
+			list.buses = true;
+			list.regions = true;
+			list.namespaces = true;
+		}
 	case 1:
 		list.media_errors = true;
-		list.namespaces = true;
 		list.dax = true;
 	case 0:
 		break;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
