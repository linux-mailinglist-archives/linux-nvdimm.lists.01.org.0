Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBAA16BA1F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 07:53:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DCE910FC363F;
	Mon, 24 Feb 2020 22:54:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.219.69.169; helo=mgwkm02.jp.fujitsu.com; envelope-from=fj5788hd@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwkm02.jp.fujitsu.com (mgwkm02.jp.fujitsu.com [202.219.69.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99FCE10FC36C0
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 22:54:21 -0800 (PST)
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by mgwkm02.jp.fujitsu.com with smtp
	 id 2e61_1db9_8948fcf5_797a_4cda_b513_ca76592f5bd4;
	Tue, 25 Feb 2020 15:53:21 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id A23ABAC00D8
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:53:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.124.196.145])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 79823301;
	Tue, 25 Feb 2020 15:53:20 +0900 (JST)
From: Keisuke Sugita <fj5788hd@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl,RFC 3/3] ndctl: Makefile.am: make ndctl-monitor@.service in compiling
Date: Tue, 25 Feb 2020 15:52:25 +0900
Message-Id: <20200225065225.121631-4-fj5788hd@fujitsu.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225065225.121631-1-fj5788hd@fujitsu.com>
References: <20200225065225.121631-1-fj5788hd@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: RANIHNKTXVCTK76LZAWOTHDPPZLREWFU
X-Message-ID-Hash: RANIHNKTXVCTK76LZAWOTHDPPZLREWFU
X-MailFrom: fj5788hd@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Keisuke Sugita <fj5788hd@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RANIHNKTXVCTK76LZAWOTHDPPZLREWFU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch is to make the new unit file "ndctl-moniotr@.service"
in the directory "/usr/lib/systemd/system/".

Signed-off-by: Keisuke Sugita <fj5788hd@fujitsu.com>
---
 ndctl/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
index 03c9bcc..74bf493 100644
--- a/ndctl/Makefile.am
+++ b/ndctl/Makefile.am
@@ -69,4 +69,5 @@ monitor_config_DATA = $(ndctl_monitorconf)
 
 if ENABLE_SYSTEMD_UNITS
 systemd_unit_DATA = ndctl-monitor.service
+systemd_unit_DATA = ndctl-monitor@.service
 endif
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
