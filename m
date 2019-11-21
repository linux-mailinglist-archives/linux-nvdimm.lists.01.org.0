Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C42104F0C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Nov 2019 10:18:33 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EED04100DC3D5;
	Thu, 21 Nov 2019 01:19:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D17F7100DC3D4
	for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 01:19:05 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 01:18:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600";
   d="scan'208,217,223";a="290260013"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2019 01:18:26 -0800
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.197]) by
 PGSMSX108.gar.corp.intel.com ([10.221.44.103]) with mapi id 14.03.0439.000;
 Thu, 21 Nov 2019 17:18:26 +0800
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWgS+HioQKQhQkFRMaZk8EtSuhX4g==
Date: Thu, 21 Nov 2019 09:18:25 +0000
Message-ID: <2369E669066F8E42A79A3DF0E43B9E643AC95A81@pgsmsx114.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzY3NmJiYmYtYjM2OC00NDM1LWExNWMtMTUzZDFiY2JjYmEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUmMrNDVpdUV6WTV6Y3pHRlNNYytzOUdScEN1SFdHVXFyc2JDRkdUbEFtVFF0TzhaYjFETkd1NkVjcVlUeHd5TiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
MIME-Version: 1.0
Message-ID-Hash: AUKMB3I7IEGZDMBI7BM7HK2W5R4W5OOI
X-Message-ID-Hash: AUKMB3I7IEGZDMBI7BM7HK2W5R4W5OOI
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AUKMB3I7IEGZDMBI7BM7HK2W5R4W5OOI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit


SHA-1: 66f34cdc26c58143fb8f11813dae98257b19ddc5

* daxctl: Change region input type from INTEGER to STRING.

daxctl use STRING to be region input type. It makes daxctl can accept both <region-id> and region name as region parameter
eg.
daxctl list -r region5
daxctl list -r 5

Link: https://github.com/pmem/ndctl/issues/109
Signed-off-by: Redhairer Li <redhairer.li@intel.com>

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
