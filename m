Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75E2851DC
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 20:45:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7975915843999;
	Tue,  6 Oct 2020 11:45:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 041081563495F
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 11:45:21 -0700 (PDT)
IronPort-SDR: Ldv3/tfzcn/xhGOH5KNYXYDeD/ybxo78U/iK+H7eOmiP3GcSAlU0E7pVyti8w5E5KH/b8TKbNh
 47sHNQnCQMrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151557916"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400";
   d="scan'208";a="151557916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:45:12 -0700
IronPort-SDR: 5IzpBvPAi+d4BhetHMLMrS1PeL+edlvNzWeA2HqZyGrTyquwpcGkwhgGkRud9DvZoLNbOXK4P8
 nEXrTMSWYZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400";
   d="scan'208";a="418326714"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2020 11:45:08 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:45:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Oct 2020 11:45:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 6 Oct 2020 11:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ1gSetD0z/fNqekrWXIzb9BLvkZ6JXpJUyunTR9H+yb2vWG5f4mSHIlrK+Xhod8ra0e3piWjAbJL0Im1P+mFDq6hSLrPnuLPUqigWIiWNge1AfGotZX/BMS9Rmc1/3veA4/HNnBXWuV/ZK839fQEGiV0/vqfwSbk3TzDr6u/C/Ct3/mGRAenmZYoSKX7XTQZL/XGlxrZaDyZWDK3Tmiqy4ajwVQoXXA3VxZH6cV957WAA2V97O+4zNq4kXaLu4ChrqO15f+/R2L9AeGG7D4khPD5XPY7tlzYl4CsthtP61KWY3jt9hPCHvhktW+JNyN3eDNapUvk7ShVdwHWhNkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0dfJOYQD+cXeFa5xaZO77Jnhz5OMhlxYSXxNIhCs8s=;
 b=QraYJMFul0T2qH75xd94rltPz9rFxdNnxd9m1SGIkY90YdKEIt057o4KdXpPNXOfnzj3Tc+UFFanCSmpagBFr9NibmEP2LyfwS7EFBF5NSEvlHYlD0qYrT9xHMB3nZiua3DHbfI6dsqZpaCeZ4YD96nlg+ITOKwRgwxjKgv4O3w4NLGzHNMeWBxHw+4DK3O25zqjMWfO+9J1T+vVdHv/s93x9soeoBEX8k/Hy76446wVVDvbNEpti8r2kveQ8lSAD1slOUz4jt1Qaiql2mPqOTiI8fmHHoVXZR4Yh9BuZmJciT9wxkKS3brou1riWwJnUbVuc8VyvB+tIyBkIxXjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0dfJOYQD+cXeFa5xaZO77Jnhz5OMhlxYSXxNIhCs8s=;
 b=zAetu25t3tbkuOuR2P1yBrC0TUk0E33Vi/kYZ46oFeb5ZuD06qZiYiNEJJUhH0vJbs9g9rHBHwujRiumsKTMGehwmWLrhFhI+bTR92Cg65G6lLBbxGI2+XgC6vSxrZHmrNZ6nVcQG6XIxtimM4vyeuDCebVMlnJqoQg1Hc+PkhQ=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3478.namprd11.prod.outlook.com (2603:10b6:a03:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Tue, 6 Oct
 2020 18:45:00 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::ecd4:8f8f:fa3d:f63d%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 18:45:00 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [ANNOUNCE] ndctl v70
Thread-Topic: [ANNOUNCE] ndctl v70
Thread-Index: AQHWnBDLOHe/GJj360qr9+hCNfkQMw==
Date: Tue, 6 Oct 2020 18:45:00 +0000
Message-ID: <f95de7e3efb2aeb0fbb924a17c2dc5404bdc9101.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc64b3aa-b7a7-4abe-bcfa-08d86a27ee59
x-ms-traffictypediagnostic: BYAPR11MB3478:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3478EFF5F53B916221B181CDC70D0@BYAPR11MB3478.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEUGOcwSYEIVc2qMINkFuej5J5dwUjbZm/cIF2DiAxrjc9nw2kpi0PxugjfI6knro3ik/mK2K7Y3bglwha+GdeiChs9QH4GwpMbuaiF2maLXS67WPMkX+YUDPACuZ4TBg5VbbHlevH0wgs7xpwxmjyogFYvsQpwRJha1UXkA5r6OpHzt67Muhzil8XbI9KH0FeM/Kf3Li+g0Xn3L7AhuLBLYZQfJWETgDG2PkADnxAaY4oTPmv/R0RHkciNvZAQ4IAPpjKQVd1UQr9eW+ZVQNzOrIf4wbhnqfchC1fh1e0VXszbxD69RoWEEdIzNFnoKulSBAIJyqDzM3Mo4g8StTIKuqIs6mSalOnS8QKZQhkzOnfgTIncMxlCYGj+JbR/+fAz6Q7MaU611Ft2OiR4YCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(8936002)(316002)(2616005)(8676002)(6486002)(4326008)(71200400001)(186003)(83080400001)(6506007)(6512007)(2906002)(86362001)(5660300002)(36756003)(26005)(478600001)(76116006)(83380400001)(6916009)(66946007)(66446008)(64756008)(66556008)(966005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fIr3lT79KJ1QEibDNefGyGtaxMAQj7EomitPOzG4seUqsHgYia+WrGUa8dBt+VHKNB4lE0DrxCmUZno8ju4SyjVJ2cU3NjeN0Sz6VTRAUZ7hqh0D8vwOysvvAljaskeN6/ofoscP1DwQtSYnOeA+6BLb4CqoglW7XEhAkjZ3FfVJNoF2SD4KTy0A+m+6ptIwfqVMcj5Qzj5W+s4Lv0J3wMWKw9cnpMfBTP/Yr+sVh0/c0j+T29KvZ6AOAGLambsskMeBl8ZnjUrJONVVMxtiFPUcVZBwQwnddVaqZJg7/tZ9RpupK15lV9Zp4qNp4bsjHZ0zGaHDeuEINvfylUoBGAa1Snq6PFks9nNcaY6kinRXvdP2AUb/bt7mZngjtVSUcPqeQkXdxgdL0wRbJYOXU+6ckcQD7bP8mwxhSvPSzMbb1/ACPh9h0RIzwC4qmw+MILQ7m/4MALJZ3QNfn0quRfEFkMb76gXncI6QTY9PK29xYxxpc368TtpbKQEUD/1wGJO1sLaLbinTY0NDZ2TIFqXi9F3IPQjewWDOSA24/RCRW8AGMxGTOa4PwdqG76qGLNT5YcZmTKKXAIDMz9YZc/EKA7ixE27p8wlZqkLW3n3hham5fEuHJNTva/K2dW08Ji6zzQxYbQGWZ2c30ZVElA==
Content-ID: <19A5246D3E00F944AFF4C7DB9DD97402@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc64b3aa-b7a7-4abe-bcfa-08d86a27ee59
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 18:45:00.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSgQtdOnLCDuHiBfcDOHR/uw1rOQQhGkU5W4Ism9utI5iQdO7rR8G84G1Dn17xiHFjQBfk75/VmFygOYk8Rn+wwMMgnZyZTyQVdKn8k9zFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3478
X-OriginatorOrg: intel.com
Message-ID-Hash: TZMMC2CKQ4762CTN7INQLKOK5ERAOSB3
X-Message-ID-Hash: TZMMC2CKQ4762CTN7INQLKOK5ERAOSB3
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TZMMC2CKQ4762CTN7INQLKOK5ERAOSB3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A new release of ndctl is available [1].

Highlights include support for the new firmware activation facility, a
new 'split-acpi' command in 'daxctl'to aid testing and debugging, and
other minor fixes.

A shortlog is appended below.

[1]: https://github.com/pmem/ndctl/releases/tag/v70


Dan Williams (15):
      ndctl/dimm: Fix chatty status messages
      ndctl/list: Indicate firmware update capability
      ndctl/dimm: Detect firmware-update vs ARS conflict
      ndctl/dimm: Improve firmware-update failure message
      ndctl/dimm: Prepare to emit dimm json object after firmware update
      ndctl/dimm: Emit dimm firmware details after update
      ndctl/list: Add firmware activation enumeration
      ndctl/dimm: Auto-arm firmware activation
      ndctl/bus: Add 'activate-firmware' command
      ndctl/test: Test firmware-activation interface
      ndctl/docs: Update copyright date
      test: Validate strict iomem protections of pmem
      ndctl: Refactor nfit.h to acpi.h
      daxctl: Add 'split-acpi' command to generate custom ACPI tables
      test/ndctl: mremap pmd confusion

Santosh Sivaraj (1):
      test: Remove a redundant ndctl_namespace_foreach

Vishal Verma (3):
      ndctl/contrib: update 'prepare-release' for merge workflow
      libndctl: fix a potential buffer overflow
      ndctl/inject-error: remove logically dead code
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
