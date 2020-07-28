Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0822FF32
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Jul 2020 04:00:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A72C12486D4A;
	Mon, 27 Jul 2020 19:00:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=lihao2018.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 100B312486D2B
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 19:00:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.75,404,1589212800";
   d="scan'208";a="96964965"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Jul 2020 10:00:09 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 261524CE5076;
	Tue, 28 Jul 2020 10:00:09 +0800 (CST)
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Jul 2020 10:00:08 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local ([fe80::5ce6:5645:817a:34a4])
 by G08CNEXMBPEKD04.g08.fujitsu.local ([fe80::5ce6:5645:817a:34a4%14]) with
 mapi id 15.00.1497.006; Tue, 28 Jul 2020 10:00:08 +0800
From: "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
Thread-Topic: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
Thread-Index: AdZkgkZYa39eKDGBSXGgU6Kg+bZxog==
Date: Tue, 28 Jul 2020 02:00:08 +0000
Message-ID: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.225.206]
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 261524CE5076.A95B8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 5MSVD4BFSR3NXHC5CIT6R5PXZZZC27AF
X-Message-ID-Hash: 5MSVD4BFSR3NXHC5CIT6R5PXZZZC27AF
X-MailFrom: lihao2018.fnst@cn.fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5MSVD4BFSR3NXHC5CIT6R5PXZZZC27AF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I have noticed that we have to drop caches to make the changing of S_DAX
flag take effect after using chattr +x to turn on DAX for a existing
regular file. The related function is xfs_diflags_to_iflags, whose
second parameter determines whether we should set S_DAX immediately.

I can't figure out why we do this. Is this because the page caches in
address_space->i_pages are hard to deal with? I also wonder what will
happen if we set S_DAX unconditionally. Thanks!

Regards,
Hao Li


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
