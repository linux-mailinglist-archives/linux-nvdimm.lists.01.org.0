Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C13241483
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Aug 2020 03:20:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DACF312EDC536;
	Mon, 10 Aug 2020 18:20:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31EA312EDC534
	for <linux-nvdimm@lists.01.org>; Mon, 10 Aug 2020 18:20:51 -0700 (PDT)
IronPort-SDR: h7p5/HrMfw7rHZyADWAEHXB14QrX6mNK7IX0f7EKtMaLFMCkKQMExLeS8N0+FBru97FZtTFbfK
 zLoRNeaRy6fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="217979731"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800";
   d="scan'208";a="217979731"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 18:20:51 -0700
IronPort-SDR: sEOX4bI/r8aXHdgg/6lTaXEaCN3iQ8Df+2ZL5Xm9sg/v6x6vWXtlAep+wqNaH9zszGMKzK0O7M
 SA4hschtgq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800";
   d="scan'208";a="368806094"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2020 18:20:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Aug 2020 18:20:50 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Aug 2020 18:20:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 10 Aug 2020 18:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PucgYJvFcNFlr4PqT4G+I617NDAof4aC4/JPQqLS8QQ/DLx90p93i/BNCGja2AAjWCZP0UozwJc9CtdxO4NQ/GKPR6Xqq9hGXzk0CZQcJYspBNDoM1wMSh9Mo7BUgNm5EEZeJzB2prDLEcg0jKHnQGa+8fZMELT4b9wn+V/asJUkeuXEBhy/YSO07tqxvxHIdoQd9BMdlZqcCdvZM1A80TUT532e/I5fAbydWeWKbRXTsdOus1i/ixD00KPhBNqJ1aWbZJSKVeefULC9OiRXJ6Xg1NABoGN0sQChOYLN8mRZQq1QcIKhUFlwWZlaX1q0Lq6CotD5wvQhQTSUPxyX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UUaGg+yWefPgS0cZWMbpZN6nC1PmtR8+jUm968UhMA=;
 b=QOLorHnzg/L7n94vW47DjlMOTx8j3NBMVNH8t2qZlLCTO3L17xz3e/Q8dIV2oALqiuopIHVmDAqNrluYJPoADOsFQkTJRYV4caukbOBxH70phLf/wu3Yh19ILLVKlcvTP0VVPM/l6pT5mGSdutO1t/AmsmJMGZQLLbzzhR7V3quxkZSk3XhW2Xv0PMqdYm1yFlHIwykb7X1mVvrPOX4uY68WGT6iutezjw2m7bW9hJoeWivqp0RBkgJf/wAaAEpUF+KvAbAHcz0Sj9QF0IoldQMLqErxnGq0SsC0NuaT+Bg6A4Gk9GsPwXNOQC0EOX7duKApQsDAtmVREvCQNCttgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UUaGg+yWefPgS0cZWMbpZN6nC1PmtR8+jUm968UhMA=;
 b=ByP4ZaAAoSNge0VaAKAtJqrvAJm5nF99iZvQkjK/sSH9v99QBrb/fx7bMlXtNz7ZAQJsXLIWNa7SjmCppL8WwNIUe6hZ1rcirNFXF2RkKE1CuhLvXL3TLq122sem3/eg5PhCQXCNmrjh9UiExT0n0OtOldWUGbfYE54onSIYpag=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3608.namprd11.prod.outlook.com (2603:10b6:a03:b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 01:20:48 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::20c5:c870:d7c7:bfa0]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::20c5:c870:d7c7:bfa0%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 01:20:48 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: [GIT PULL] libnvdimm for v5.9
Thread-Topic: [GIT PULL] libnvdimm for v5.9
Thread-Index: AQHWb32lEU1Cwshp8U6uHR2jAz+0zg==
Date: Tue, 11 Aug 2020 01:20:48 +0000
Message-ID: <f44b21c38313fa8e19a3e70eb285e0dd319eb421.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb060faf-d3d6-4a58-abc4-08d83d94c7c8
x-ms-traffictypediagnostic: BYAPR11MB3608:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB360838569DE4116568823BFDC7450@BYAPR11MB3608.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4iavuQzqmd9n6DwjJV6IEgRHm6Lmud1emCy+q5Ft8KullPp3lr/hE26qGbL50Z42fWJyi2Sb3zQTeRDfkyzx/vfDhM6elkXlBCao6Wpc3GPo8+BJJ3TXECc2+Kn4rqn1czfsMaWiK01kKj85OEoa3/34rA+r++MOIk32xaK8pCDBHeRYVvKB6dO4VV7liOFGxGsYRusbx+oxbOvznmzvnfr2o6aKR4+cv/uee4pzv9iQbSpcjd8lMYZd8mr+pMdKigvEKdTDDn5x9JTYabK7bzYk3unfea6p9w9q7pSfnSPnA7ctwEEh+IeLmpIDRHU9ssPRZuL5pa2+V8yUosBQQNMCg9un81C4F28tLeZGIrMrGD+KyoAk8TsSruNALqvdlI0koLZsM1YdY2EEAa0BiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(8936002)(2616005)(4326008)(54906003)(6512007)(6506007)(83380400001)(71200400001)(8676002)(66556008)(64756008)(66446008)(6916009)(76116006)(66476007)(5660300002)(66946007)(186003)(86362001)(316002)(966005)(478600001)(36756003)(26005)(2906002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xPbArv8okOddMfrC2TCNZqw2CEnIXthmI0Dhs7JyWrBxNPEgqMuDsFNKBo2eIcW3h/5TFch5BB1evKC4Lwd2oknSaUtpjpNSetEcl5dvd/Nw970Uknb49BS9gsKaMpfkXxhR1u7L3YWl6c5HMr7uTBcgMIjIv1Ju41QefGA8X9mP1ATj4m6hsxRftVVS6NmG8tMESWjTmE/iW+iu5IS0be+SKFpP3NKrG5i2hdHk+XnUKiOXioaeTUCCU86Md+6oXR8bEQHkCxlspaiJxm4QwbnegclNvJaJxjhjFCTrD1HC7/ZsToMVtp/NNOz9Fea3AyFF7XrJIUnJ/r2S33cXFQsMjFA5ho5SqaK9LKpvR5PUufS3HHUoEYSxvJL6skNlq79r/l06B6u6p/DL6zRFvqbRZMCkADt+Mrx+cDkffXZXe0/jZLX23rq/eUZnLnRm/iKemM57+Uclg7IFQ0aALGD0NRAsp3T/ZWOSeevKOlVq6rE7vnlpqtWSdzHykkAGRICplkI9xGSOXjeeyG5rUSnZvtN7F/CHGn+sCDf3aaMQN2+AWde7+fY8kICYdvNu3P6sf52yLXgpVeYJ26dOpvdWX1//sCllWv6NJbnc6UcvBbpRmwwhz6g+Eh3ykDipd8WD7xySoiUVahYhUeppAw==
Content-ID: <903175290BBC314B898F91AA1CE7B528@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb060faf-d3d6-4a58-abc4-08d83d94c7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 01:20:48.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD34zEgJ0gQfVMJuGyPw7F4mw6udYAMkTUeJk532ymC4KpVEcBjQZv9A+5wlRKMmYAsmbDy5dIx7j3p7k6vMO6ucKayt1C8Iscc2Rg+gG4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3608
X-OriginatorOrg: intel.com
Message-ID-Hash: UXOYDGWXLUVBKJDXIQABA7R6TDDWM5W3
X-Message-ID-Hash: UXOYDGWXLUVBKJDXIQABA7R6TDDWM5W3
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UXOYDGWXLUVBKJDXIQABA7R6TDDWM5W3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/
tags/libnvdimm-for-5.9

...to receive a new feature in libnvdimm - 'Runtime Firmware
Activation', and a few small cleanups and fixes in libnvdimm and DAX.

You'd normally receive this pull request from Dan Williams, but he's
busy watching a newborn (Congrats Dan!), so I'm watching libnvdimm this
cycle.

I'd originally intended to make separate topic-based pull requests - one
for libnvdimm, and one for DAX, but some of the DAX material fell out
since it wasn't quite ready. I ended up merging the two branches into
one, and hence a couple of 'internal' merges - I hope these are ok. If
you prefer that I should've handled this differently please let me know!

I was also expecting a potential conflict - I was assuming Greg had
pulled in one of Dan's patches[1] through driver-core, but I don't see
it in his tree, and a test merge with the current master went through
cleanly.

There were a small handful of late fixes, but everything has had at
least a week of -next soak time without any reported issues. We've also
received a positive build notification from 0-day.

[1]: https://lore.kernel.org/linux-nvdimm/20200721104442.GF1676612@kroah.com/

---

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/ tags/libnvdimm-for-5.9

for you to fetch changes up to 7f674025d9f7321dea11b802cc0ab3f09cbe51c5:

  libnvdimm/security: ensure sysfs poll thread woke up and fetch updated attr (2020-08-03 18:54:13 -0600)

----------------------------------------------------------------
libnvdimm for 5.9

- Add 'Runtime Firmware Activation' support for NVDIMMs that advertise
  the relevant capability
- Misc libnvdimm and DAX cleanups

----------------------------------------------------------------
Coly Li (1):
      dax: print error message by pr_info() in __generic_fsdax_supported()

Dan Williams (12):
      libnvdimm: Validate command family indices
      ACPI: NFIT: Move bus_dsm_mask out of generic nvdimm_bus_descriptor
      ACPI: NFIT: Define runtime firmware activation commands
      tools/testing/nvdimm: Cleanup dimm index passing
      tools/testing/nvdimm: Add command debug messages
      tools/testing/nvdimm: Prepare nfit_ctl_test() for ND_CMD_CALL emulation
      tools/testing/nvdimm: Emulate firmware activation commands
      driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
      libnvdimm: Convert to DEVICE_ATTR_ADMIN_RO()
      PM, libnvdimm: Add runtime firmware activation support
      ACPI: NFIT: Add runtime firmware activate support
      ACPI: NFIT: Fix ARS zero-sized allocation

Hao Li (1):
      dax: Fix incorrect argument passed to xas_set_err()

Ira Weiny (2):
      fs/dax: Remove unused size parameter
      drivers/dax: Expand lock scope to cover the use of addresses

Jane Chu (3):
      libnvdimm/security: fix a typo
      libnvdimm/security: the 'security' attr never show 'overwrite' state
      libnvdimm/security: ensure sysfs poll thread woke up and fetch updated attr

Vishal Verma (2):
      Merge branch 'for-5.9/dax' into libnvdimm-for-next
      Merge branch 'for-5.9/firmware-activate' into libnvdimm-for-next

 Documentation/ABI/testing/sysfs-bus-nfit           |  19 +
 Documentation/ABI/testing/sysfs-bus-nvdimm         |   2 +
 .../driver-api/nvdimm/firmware-activate.rst        |  86 +++++
 drivers/acpi/nfit/core.c                           | 157 ++++++---
 drivers/acpi/nfit/intel.c                          | 386 +++++++++++++++++++++
 drivers/acpi/nfit/intel.h                          |  61 ++++
 drivers/acpi/nfit/nfit.h                           |  38 +-
 drivers/dax/super.c                                |  13 +-
 drivers/nvdimm/bus.c                               |  16 +
 drivers/nvdimm/core.c                              | 149 ++++++++
 drivers/nvdimm/dimm_devs.c                         | 123 ++++++-
 drivers/nvdimm/namespace_devs.c                    |   2 +-
 drivers/nvdimm/nd-core.h                           |   1 +
 drivers/nvdimm/pfn_devs.c                          |   2 +-
 drivers/nvdimm/region_devs.c                       |   2 +-
 drivers/nvdimm/security.c                          |  13 +-
 fs/dax.c                                           |  15 +-
 include/linux/device.h                             |   4 +
 include/linux/libnvdimm.h                          |  52 ++-
 include/linux/suspend.h                            |   6 +
 include/linux/sysfs.h                              |   7 +
 include/uapi/linux/ndctl.h                         |   5 +
 kernel/power/hibernate.c                           |  97 ++++++
 tools/testing/nvdimm/test/nfit.c                   | 367 ++++++++++++++++----
 24 files changed, 1486 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
 create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
