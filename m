Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C110D30BEF0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 14:02:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 036BC100F2274;
	Tue,  2 Feb 2021 05:02:25 -0800 (PST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=139.138.61.252; helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=qi.fuli@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BAC4100EBB94
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 05:02:22 -0800 (PST)
IronPort-SDR: gX0UTXWKUnAjrtVLb0A4EwRp1tCX4KUXZC+b+Vgp+zvBusLPJpDbgYL4wKPl8TqGLT+lmL9RVH
 P2ZqaSPXP8D+QC6HEKpr+7QmE9gTbQy+CU58yZD7S1ntZLsV8K6UutFLWIuMskC2S8EluSX7ip
 qoa9QFJ5JkKzXrPCTKYdaI92iiABUfP6sRXwwf2xzsxFjc3nuBtyJS529LcBeaJGgzmFkHY66W
 s+1VEXY+iuPv4QMdSdcYj7QIOpS+tpMs53KEKa+9IwLoOruLVkB0lf9fDcPN1DMlG0XTym7ZvH
 88U=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="5713587"
X-IronPort-AV: E=Sophos;i="5.79,395,1602514800";
   d="scan'208";a="5713587"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 02 Feb 2021 22:02:20 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id DF9D825E0A1
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 22:02:19 +0900 (JST)
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 15E07B4E56
	for <linux-nvdimm@lists.01.org>; Tue,  2 Feb 2021 22:02:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.106])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id D4999179;
	Tue,  2 Feb 2021 22:02:18 +0900 (JST)
From: QI Fuli <qi.fuli@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] ndctl: update .gitignore
Date: Tue,  2 Feb 2021 22:02:06 +0900
Message-Id: <20210202130206.3761-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: 23KODZXIYAGHYY4IQWBUEGSXF6EQBEM5
X-Message-ID-Hash: 23KODZXIYAGHYY4IQWBUEGSXF6EQBEM5
X-MailFrom: qi.fuli@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/23KODZXIYAGHYY4IQWBUEGSXF6EQBEM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Documentation/ndctl/attrs.adoc and *.lo to .gitignore.

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 .gitignore | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3ef9ff7..53512b2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 *.o
+*.lo
 *.xml
 .deps/
 .libs/
@@ -15,13 +16,13 @@ Makefile.in
 *.1
 Documentation/daxctl/asciidoc.conf
 Documentation/ndctl/asciidoc.conf
+Documentation/ndctl/attrs.adoc
 Documentation/daxctl/asciidoctor-extensions.rb
 Documentation/ndctl/asciidoctor-extensions.rb
 .dirstamp
 daxctl/config.h
 daxctl/daxctl
 daxctl/lib/libdaxctl.la
-daxctl/lib/libdaxctl.lo
 daxctl/lib/libdaxctl.pc
 *.a
 ndctl/config.h
@@ -29,8 +30,6 @@ ndctl/lib/libndctl.pc
 ndctl/ndctl
 rhel/
 sles/ndctl.spec
-util/log.lo
-util/sysfs.lo
 version.m4
 *.swp
 cscope.files
--
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
