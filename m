Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1F16BA1A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 07:53:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE66110FC3632;
	Mon, 24 Feb 2020 22:54:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.128.242.43; helo=mgwym04.jp.fujitsu.com; envelope-from=fj5788hd@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwym04.jp.fujitsu.com (mgwym04.jp.fujitsu.com [211.128.242.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D56AC10FC362F
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 22:54:02 -0800 (PST)
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym04.jp.fujitsu.com with smtp
	 id 219a_9470_4f9130fc_8f78_4276_9e6a_709a94d3e1cf;
	Tue, 25 Feb 2020 15:53:06 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 20C23AC00F6
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 15:53:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.124.196.145])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 026A72FC;
	Tue, 25 Feb 2020 15:53:05 +0900 (JST)
From: Keisuke Sugita <fj5788hd@fujitsu.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl,RFC 0/3] Enable to run multiple monitor daemons as system services
Date: Tue, 25 Feb 2020 15:52:22 +0900
Message-Id: <20200225065225.121631-1-fj5788hd@fujitsu.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Message-ID-Hash: WJQVGDHM2EXIATIPBOG4TO3365ODXA5I
X-Message-ID-Hash: WJQVGDHM2EXIATIPBOG4TO3365ODXA5I
X-MailFrom: fj5788hd@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Keisuke Sugita <fj5788hd@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WJQVGDHM2EXIATIPBOG4TO3365ODXA5I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, this is my first OSS contribution!

This patch is to monitor specific dimms, regions, buses,
namespaces, or dimm-events where users set up to monitor
independently and concurrently by running multiple monitor
daemons as system services.

Users will be able to monitor multiple elements and check each log file
by this patch.

So far, users can only run a single monitor daemon because units name
is fixed to "ndctl-monitor.service" now, and then users cannot monitor
multiple elements concurrently. For example, users want to monitor
a specific bus and namespace, but they are not able to do now.

I solve this problem by instance name of systemd.

Keisuke Sugita (3):
  ndctl: Documentation: Write how to use multiple monitor daemon concullently
  ndctl: ndctl-monitor@.service: Add new unit file for multi daemon support
  ndctl: Makefile.am: make ndctl-monitor@.service in compiling

 Documentation/ndctl/ndctl-monitor.txt | 11 +++++++++++
 ndctl/Makefile.am                     |  1 +
 ndctl/ndctl-monitor@.service          |  9 +++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 ndctl/ndctl-monitor@.service

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
