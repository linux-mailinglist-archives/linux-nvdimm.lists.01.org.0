Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6477316BA1D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 07:53:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1117610FC3637;
	Mon, 24 Feb 2020 22:54:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.128.242.42; helo=mgwym03.jp.fujitsu.com; envelope-from=fj5788hd@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwym03.jp.fujitsu.com (mgwym03.jp.fujitsu.com [211.128.242.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D5D710FC3406
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 22:54:18 -0800 (PST)
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by mgwym03.jp.fujitsu.com with smtp
	 id 7c8e_deee_ca3222d6_459c_44e0_bf57_2a2263b04b8b;
	Tue, 25 Feb 2020 15:53:18 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 4036FAC00A2
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:53:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.124.196.145])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 23C402FC;
	Tue, 25 Feb 2020 15:53:17 +0900 (JST)
From: Keisuke Sugita <fj5788hd@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl,RFC 1/3] ndctl: ndctl-monitor.txt: Write how to use multiple monitor daemon concullently
Date: Tue, 25 Feb 2020 15:52:23 +0900
Message-Id: <20200225065225.121631-2-fj5788hd@fujitsu.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225065225.121631-1-fj5788hd@fujitsu.com>
References: <20200225065225.121631-1-fj5788hd@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: RXFMGQQYC2RYNIRGDJOO5UZ4H4MNN3LX
X-Message-ID-Hash: RXFMGQQYC2RYNIRGDJOO5UZ4H4MNN3LX
X-MailFrom: fj5788hd@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Keisuke Sugita <fj5788hd@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RXFMGQQYC2RYNIRGDJOO5UZ4H4MNN3LX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add how to use multiple monitor concullently into monitor-conf.txt.

Here is a simple example of how to use,

1. copy and edit a config file
$ cp /etc/ndctl/monitor.conf /etc/ndctl/monitor-dimm.conf
$ vi /etc/ndctl/monitor-dimm.conf

2. start sytsem services
$ systemctl start ndctl-monitor@dimm

Signed-off-by: Keisuke Sugita <fj5788hd@fujitsu.com>
---
 Documentation/ndctl/ndctl-monitor.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ndctl/ndctl-monitor.txt b/Documentation/ndctl/ndctl-monitor.txt
index 2239f04..ccca2f0 100644
--- a/Documentation/ndctl/ndctl-monitor.txt
+++ b/Documentation/ndctl/ndctl-monitor.txt
@@ -45,6 +45,17 @@ Run a monitor daemon as a system service
 [verse]
 systemctl start ndctl-monitor.service
 
+Run multiple monitor daemon concurrently as system services to monitor
+multiple bus, dimm, region, namespace or dimm-event independently.
+Same name as the single argument must be used with config file,
+like "ndctl-monitor@foo.service" and "moniter-foo.conf".
+
+For example, when you want to monitor a specific dimm,
+[verse]
+cp /etc/ndctl/monitor.conf /etc/ndctl/monitor-dimm.conf
+vi /etc/ndctl/monitor-dimm.conf  #Edit a file as you need
+systemctl start ndctl-monitor@dimm.service
+
 OPTIONS
 -------
 -b::
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
