Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1E16BA1E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 07:53:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2685410FC363C;
	Mon, 24 Feb 2020 22:54:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.128.242.42; helo=mgwym03.jp.fujitsu.com; envelope-from=fj5788hd@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwym03.jp.fujitsu.com (mgwym03.jp.fujitsu.com [211.128.242.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D59410FC3636
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 22:54:18 -0800 (PST)
Received: from yt-mxauth.gw.nic.fujitsu.com (unknown [192.168.229.68]) by mgwym03.jp.fujitsu.com with smtp
	 id 4ef9_11d8_b33c3aa7_4f1c_4c58_a8b7_338a116ecffa;
	Tue, 25 Feb 2020 15:53:19 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 55E34AC00F5
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:53:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.124.196.145])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 38F742FC;
	Tue, 25 Feb 2020 15:53:19 +0900 (JST)
From: Keisuke Sugita <fj5788hd@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl,RFC 2/3] ndctl: ndctl-monitor@.service: Add new unit file for multi daemon support
Date: Tue, 25 Feb 2020 15:52:24 +0900
Message-Id: <20200225065225.121631-3-fj5788hd@fujitsu.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225065225.121631-1-fj5788hd@fujitsu.com>
References: <20200225065225.121631-1-fj5788hd@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: SNW56HVK7QLEI3QTQOLNV6VZICIWTQA3
X-Message-ID-Hash: SNW56HVK7QLEI3QTQOLNV6VZICIWTQA3
X-MailFrom: fj5788hd@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Keisuke Sugita <fj5788hd@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNW56HVK7QLEI3QTQOLNV6VZICIWTQA3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Users cannot run multiple monitor daemon because units name of
monitor daemon is now fixed to "ndctl-monitor.service" and users cannnot
change this name.

This patch is new unit file which reffers a single argument and change
their config file or service name. This is to run multiple monitor
daemon.

Units name can be parameterized by a single argument called the instance
name. The name of the full units is formed by inserting the instance
name between "@" and ".service", like "ndctl-moniter@foo.service".

In the unit file itself, the instance parameter may be referred to using
"%I". And each daemon reads each config file, like "monitor-foo.conf".
Same name as instance name must be used in config file between
"monitor" and ".conf".

Signed-off-by: Keisuke Sugita <fj5788hd@fujitsu.com>
---
 ndctl/ndctl-monitor@.service | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 ndctl/ndctl-monitor@.service

diff --git a/ndctl/ndctl-monitor@.service b/ndctl/ndctl-monitor@.service
new file mode 100644
index 0000000..eb10702
--- /dev/null
+++ b/ndctl/ndctl-monitor@.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=Ndctl Monitor Daemon
+
+[Service]
+Type=simple
+ExecStart=/usr/bin/ndctl monitor --config-file=/etc/ndctl/monitor-%I.conf
+
+[Install]
+WantedBy=multi-user.target
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
