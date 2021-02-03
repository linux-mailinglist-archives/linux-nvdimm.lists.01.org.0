Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC730DAF5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Feb 2021 14:21:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C608F100EAB78;
	Wed,  3 Feb 2021 05:21:29 -0800 (PST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=139.138.61.252; helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8FF0100F2274
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 05:21:26 -0800 (PST)
IronPort-SDR: swwhVgFn9bV35gKRNapmG16CXqn4vpg042aNO/LQpG/O+rPSSTexx3PLFYx+8OXDnpA+vkTLUs
 XMTFLFZwtNWkPPvQK3ihEPf8gvRjuV6B0uSG8/oLvpymB3wAb+ysNqg8JN7TnkojfoWhpA0qwQ
 WZK27RyK0jHxlH47K2lyhBqPNwvUu1NamWTNVFwSt+Gl7uZQfKrUIJAJJu0F9KH0dcPlWVcge2
 kcI2JJMQGN5G37sDaeEeO76n2cig63/gTGruZ3Lq2tEP0X2RK2qDPv0II+2CVqZjecspFcTIgZ
 vKQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="5878553"
X-IronPort-AV: E=Sophos;i="5.79,398,1602514800";
   d="scan'208";a="5878553"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 03 Feb 2021 22:21:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F1826DE515
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 22:21:22 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 54E9515599
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 22:21:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.106])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 4250D2DF;
	Wed,  3 Feb 2021 22:21:22 +0900 (JST)
From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] ndctl/test: add checking the presence of jq command ahead
Date: Wed,  3 Feb 2021 22:21:08 +0900
Message-Id: <20210203132108.6246-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: WHMK45PP4FMQLHE5BI5VXIKQAJDG35TT
X-Message-ID-Hash: WHMK45PP4FMQLHE5BI5VXIKQAJDG35TT
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WHMK45PP4FMQLHE5BI5VXIKQAJDG35TT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Due to the lack of jq command, the result of the test will be 'fail'.
This patch adds checking the presence of jq commmand ahead.
If there is no jq command in the system, the test will be marked as 'skip'.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
Link: https://github.com/pmem/ndctl/issues/141
---
 test/daxdev-errors.sh           | 1 +
 test/inject-error.sh            | 2 ++
 test/inject-smart.sh            | 1 +
 test/label-compat.sh            | 1 +
 test/max_available_extent_ns.sh | 1 +
 test/monitor.sh                 | 2 ++
 test/multi-dax.sh               | 1 +
 test/sector-mode.sh             | 2 ++
 8 files changed, 11 insertions(+)

diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
index 6281f32..9547d78 100755
--- a/test/daxdev-errors.sh
+++ b/test/daxdev-errors.sh
@@ -9,6 +9,7 @@ rc=77
 . $(dirname $0)/common

 check_min_kver "4.12" || do_skip "lacks dax dev error handling"
+check_prereq "jq"

 trap 'err $LINENO' ERR

diff --git a/test/inject-error.sh b/test/inject-error.sh
index c636033..7d0b826 100755
--- a/test/inject-error.sh
+++ b/test/inject-error.sh
@@ -11,6 +11,8 @@ err_count=8

 . $(dirname $0)/common

+check_prereq "jq"
+
 trap 'err $LINENO' ERR

 # sample json:
diff --git a/test/inject-smart.sh b/test/inject-smart.sh
index 94705df..4ca83b8 100755
--- a/test/inject-smart.sh
+++ b/test/inject-smart.sh
@@ -166,6 +166,7 @@ do_tests()
 }

 check_min_kver "4.19" || do_skip "kernel $KVER may not support smart (un)injection"
+check_prereq "jq"
 modprobe nfit_test
 rc=1

diff --git a/test/label-compat.sh b/test/label-compat.sh
index 340b93d..8ab2858 100755
--- a/test/label-compat.sh
+++ b/test/label-compat.sh
@@ -10,6 +10,7 @@ BASE=$(dirname $0)
 . $BASE/common

 check_min_kver "4.11" || do_skip "may not provide reliable isetcookie values"
+check_prereq "jq"

 trap 'err $LINENO' ERR

diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
index 14d741d..343f3c9 100755
--- a/test/max_available_extent_ns.sh
+++ b/test/max_available_extent_ns.sh
@@ -9,6 +9,7 @@ rc=77
 trap 'err $LINENO' ERR

 check_min_kver "4.19" || do_skip "kernel $KVER may not support max_available_size"
+check_prereq "jq"

 init()
 {
diff --git a/test/monitor.sh b/test/monitor.sh
index cdab5e1..28c5541 100755
--- a/test/monitor.sh
+++ b/test/monitor.sh
@@ -13,6 +13,8 @@ smart_supported_bus=""

 . $(dirname $0)/common

+check_prereq "jq"
+
 trap 'err $LINENO' ERR

 check_min_kver "4.15" || do_skip "kernel $KVER may not support monitor service"
diff --git a/test/multi-dax.sh b/test/multi-dax.sh
index e932569..8496619 100755
--- a/test/multi-dax.sh
+++ b/test/multi-dax.sh
@@ -9,6 +9,7 @@ rc=77
 . $(dirname $0)/common

 check_min_kver "4.13" || do_skip "may lack multi-dax support"
+check_prereq "jq"

 trap 'err $LINENO' ERR

diff --git a/test/sector-mode.sh b/test/sector-mode.sh
index dd7013e..54fa806 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -6,6 +6,8 @@ rc=77

 . $(dirname $0)/common

+check_prereq "jq"
+
 set -e
 trap 'err $LINENO' ERR

--
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
