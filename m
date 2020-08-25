Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5651C250DF3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 02:57:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 001D7136F07B4;
	Mon, 24 Aug 2020 17:57:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A310012693ECA
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 17:57:15 -0700 (PDT)
IronPort-SDR: +Hha7LUfTmhNfgZ9i3zBO69jJd0bUDaBguCYltoBup/7kjuwwFcW3aySgqBWy9X3HfweFKwe0v
 lxXJjJzmdNIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156009197"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600";
   d="scan'208";a="156009197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:57:14 -0700
IronPort-SDR: 4HhPG9uBEMu2PFDYD4vZg+wVImuZDtynHGu/7sMj5kl9pY0PLDwhFQH65Bpm0qdWinymQjCsFn
 hHeNtgaRnPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600";
   d="scan'208";a="312386452"
Received: from orsmsx603-2.jf.intel.com (HELO ORSMSX603.amr.corp.intel.com) ([10.22.229.83])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 17:57:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 17:57:14 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Aug 2020 17:57:14 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Aug 2020 17:57:14 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 24 Aug 2020 17:57:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRob54H4muidgygZuwhyiaBWCkFeRLj55ULUEQCF3URE+ZuTuRRNpZxFzbr2cGuKPxV0QZ2ob9LyDtl5Y9vcaUUBwQ460WWfz7MBftCfvAtHyKyU3XuYZyC2kiV9AGlGMQRZ+bF2aV39PQAi8JXlrHoMqT/sO6kQI2NHyuam37sPGB8hHSo+cN1SNtnFtOF1bXzqdbTebNrKplZa+KtZ6UyCVKwHBF2UbPd1UAtkEfmT026vnP3Of9q3b1t6TNGJnAV+USHNFBrSWz1o5LJ69iYczoVVFm2LOwLv4W1SIbuiu++qmCt6lUkKWswuBlX153M4oaXxXOJwJjRX+C0Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3K2i5trnlwoXhbFH4YRBhD/65O9njFyXSiZE8oSQpg=;
 b=bElT+E/a/0/4RYsfh0yFWQNb+jpPqseVHCcMAPH8ySEHyNRV28CMQAD4RcCSXcQV5fAydovgcAhqflN83l/BoJR1263ZN4ayLbgUIaxugbvKyHBvGrTbdgoe0MUfobpm5E698EzGvIzTrYD6ynMm7QCpzrCI25qrRdlVHTgkYmjPMzjuSRNjT4RwSDcHVFc+8QqD3h6+j7K/SP+Fl2FY+USwil8Z4GMIIxyMlc8aHM/kJsCn9VHCvFXs/QFmsL8b6pSzVuZwrdj93kJcHZ3SoXvPFpEaa+QNK4Gf5zcSXay6UetCYR/+lg7KewxJxrZ2K90aMU+FQQ+rGnkSq2+3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3K2i5trnlwoXhbFH4YRBhD/65O9njFyXSiZE8oSQpg=;
 b=cuPgd/V+ww8zLmp3yUU1YV+oTvONDmJq5ndmwOIeWWBhnFZX6KfBqml+b9nOFbEkkBfOW0U9XMx9a/YPgqBKH+nDIJkvfTbj1lYCw3yaO2olOkjVKsDqUjy8li0OYEWkPRFUCXt4gxV0baGrapGV+hneJ4Zobc0k+YDa4iYQz88=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3031.namprd11.prod.outlook.com (2603:10b6:a03:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 00:57:12 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 00:57:12 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: [GIT PULL] libnvdimm fixes for v5.9-rc3
Thread-Topic: [GIT PULL] libnvdimm fixes for v5.9-rc3
Thread-Index: AQHWenqqqJZ8PrwLrEypxrPcYT2tmA==
Date: Tue, 25 Aug 2020 00:57:12 +0000
Message-ID: <7d850f417b20bfa559e6ef3eb133d336fb2eda3f.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee6311d-9e51-4615-4257-08d84891cd56
x-ms-traffictypediagnostic: BYAPR11MB3031:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3031E89B83F98627769474C7C7570@BYAPR11MB3031.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyFA/FJPJBAqBOaLhTsQmpAAdWl6yojL1QP1y9Vcrypfz/WwzfNhRSYKyPP3HgmqVoHgAaYJwEMHq+AKWy3QIFMzUJKSfINkpkDu80aoMfbX5ma+xrS1WaYmsPooHyF8Y0AbKvb3SbjEJ9HlM9YSI6bS1IGLZfCxrqD+HShc7KYxB8/0aSDbWMTshBUAs0RQUwvodHAaLiS/ludib0Q/8OwUpcXr4wASbMkHSarDxyyogNE/o9MWYOXpOW3uW5wGM9mzZoWxO21FhzxKz3yo1sZwPx+mPQT+gsN45ua31loo7FlU9FaWjXrF88UuzAh0O4t5JcsoJBWbDSohZA7VPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(2616005)(5660300002)(71200400001)(66476007)(64756008)(66946007)(2906002)(76116006)(66446008)(478600001)(66556008)(83380400001)(4326008)(6916009)(6512007)(8936002)(6486002)(6506007)(54906003)(86362001)(316002)(26005)(186003)(8676002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O6M2mbpdJRaby91xWZfI8qqHlcifHdCxuofiVzVBcUdMaZI73ypsoDMxisQHC6Azk1eGM2qfoZU9hOOz4QAzg5bcoPF5Iju1+7zI8DAjUEi79etBVRU5fI/9yArPIa5GoIa5NQXbFR38jHuB4otdTHUCCvEDs9vsTxX/cOPgTuFRhQUiWOCCl6z9nCvuZRVtYR2798PtAAINoS23cdz2FKeJqA5/WmISd+gpGn/5K5NS2T5Xw3OArqAJKmGXHIl2PtebRRAgfDIoSowOo6hTafU3cZJXaBg/6zVico75e6JG//dkcLMkpMIXCBzT9LJfyl7n1b+iDbUDoOOyWMtxCjlqCVguE89eTRgxDwMnlnsTHxCsZn1JyQEuFQvEi6TBC+rznyrNYYhhKQ83P6h2y3RzfvUeFWdaWWQu0XWj1zPsRYmTCjHnQkgwL/J11xLhIjuuj5tUwfxJc447qdmndq5ljF0duIR+M5Z4dT/lvzC7eUBh0H5l4+d4B2a8nfwof0l/C5DvPYWixdwIlViPiaRanN5XSBFZqwgcANiNgNcK2o3y2o5gcKPOgo9e5GfwuBmX/66jhiL4R/5/JpgcXNRxnUDPIAf5W0oHnfCTUMoh7lxCTp+k0HhkB6liBlQqKNH8Kdzz1vctV6xvgLlEog==
Content-ID: <5E9B7956718CF14FA9FF7F1AD7DE926B@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6311d-9e51-4615-4257-08d84891cd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 00:57:12.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ifsuz/OLZAybJLOjOwjaQ6+8JppJrHWsEhCDOgf7KIqKdGWwrWmEqmgF4pR940JkxOyq+OIfozq/lEjZ9kgNiYu5WWdrt6htjXWhk9sRzc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3031
X-OriginatorOrg: intel.com
Message-ID-Hash: TRWVOWECJGBQ6IVKYBNSQOTBKYTUKWLE
X-Message-ID-Hash: TRWVOWECJGBQ6IVKYBNSQOTBKYTUKWLE
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ahuang12@lenovo.com" <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TRWVOWECJGBQ6IVKYBNSQOTBKYTUKWLE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
tags/libnvdimm-fix-v5.9-rc3

...to receive a couple of minor fixes for things merged in 5.9-rc1. One
is an out-of-bounds access caught by KASAN, and the second is a tweak to
some overzealous logging about dax support even for traditional block
devices which was unnecessary. These have appeared in -next without any
problems.

---

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fix-v5.9-rc3

for you to fetch changes up to c2affe920b0e0669650943ac086215cf6519be34:

  dax: do not print error message for non-persistent memory block device (2020-08-20 11:43:18 -0600)

----------------------------------------------------------------
libnvdimm fixes for v5.9-rc3

Fix an out-of-bounds access introduced in libnvdimm v5.9-rc1
dax: do not print error message for non-persistent memory block device

----------------------------------------------------------------
Adrian Huang (1):
      dax: do not print error message for non-persistent memory block device

Zqiang (1):
      libnvdimm: KASAN: global-out-of-bounds Read in internal_create_group

 drivers/dax/super.c        | 6 ++++++
 drivers/nvdimm/dimm_devs.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c82cbcb64202..32642634c1bb 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -100,6 +100,12 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
+	if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
+		pr_debug("%s: error: dax unsupported by block device\n",
+				bdevname(bdev, buf));
+		return false;
+	}
+
 	id = dax_read_lock();
 	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 61374def5155..b59032e0859b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 static struct attribute *nvdimm_firmware_attributes[] = {
 	&dev_attr_activate.attr,
 	&dev_attr_result.attr,
+	NULL,
 };
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
