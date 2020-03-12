Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AFA183031
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 13:29:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2707510FC3411;
	Thu, 12 Mar 2020 05:30:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9258D10FC3166
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 05:30:12 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 05:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400";
   d="scan'208";a="236814851"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 12 Mar 2020 05:29:20 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 05:29:20 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 05:29:20 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 05:29:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 05:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvdtj0rIA1+Mq8MWeok1+KA9jX86RjbiZiXL/JrtY8YlIoyKnlOdkEjb0XG2Z5z9cGvXjVGAWF0JNhnAImOcNoTea7WHQ53Uhuk0YY97vMAzTi6tHbKIejG2ignjFbXFzlkhi5BL4pTxy+4tsIO0f6v+tCWdUnUx8kO3cnSaZu3gAdDR2K8PhelBWGSrHbPayfXcaQmLWTsjBIqv6NBvtWntcYmmrZjtqz8Bi1DUlk8RwjVjBrTbCujYDMKEqRF3KBCP6uNEzgpwLzQIdaEBF8YodVLiTujMPd7DLkvDrabGLd5EjNGrKwkCwPkfp5qRcglB69nu1HnItwCgu8vgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQp0NvJ876wAtXZE4AEa89WhgUiKGjKRGKB9PsnbtnI=;
 b=aAhj63qXTgXVOYFFily8fyRdlaP/5hq/W8el2sFKUS/OLMfNOvqa/nVr1Nzjjh/vUEr4sj8DwRVZEpW8yaUWYDshzeynIlcSJxFJ2Ejvz9Eil8+8b6P7+C0xxjmdBIBtQ8lPcVfK04cG6nYllbWgxNBpDEK+X5oja02tWJmFnfgG6Euc57Jdh6xmbAuVC6Z8nRTGLmrmDT6UX9FEFIne6JoDKUVl/XZs4oCzlDFuNanU6sEJCXkv9fzMDAvDmNXpDJ5EgKfhzSJKml9TqSrwnJl7uMJVySx01Mzdu+mpO/06neeAf7BgkqEef5m2PFZnTyIUYcpEFRv9jqiBY8lbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQp0NvJ876wAtXZE4AEa89WhgUiKGjKRGKB9PsnbtnI=;
 b=h2z/Zx0M9f9FhariiKB1ZS9b7H2IMcIixv9oJ8CFD2EV0d/g131VcnUEtwpq6o+5AsaxYbrZVI1j4oukvfdd/IVFy4E9Ncq9mZMmXEyvJ2pqmN7FhmGcA5aX8fL6zyYQIf3M/CEHRh8KcrDSmCmanVo1C+rF7xMjVGJd2Ht23Ok=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB3424.namprd11.prod.outlook.com (2603:10b6:805:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 12:29:15 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 12:29:15 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: nfit_test: issue #1: depmod: WARNING: extra/test/nfit_test.ko.xz
 needs unknown symbols libnvdimm_test ...
Thread-Topic: nfit_test: issue #1: depmod: WARNING: extra/test/nfit_test.ko.xz
 needs unknown symbols libnvdimm_test ...
Thread-Index: AdX4Z0Lxn8kvPZDZQwSwk80ODinF5w==
Date: Thu, 12 Mar 2020 12:29:15 +0000
Message-ID: <SN6PR11MB2864AF4F3C6C9ECC6FE89EFD96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lukasz.dorau@intel.com;
x-originating-ip: [134.191.221.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1040d6b9-e63d-42e6-af24-08d7c680fa7f
x-ms-traffictypediagnostic: SN6PR11MB3424:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB34243209C9721056EF16EF5E96FD0@SN6PR11MB3424.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(86362001)(64756008)(66446008)(66556008)(5660300002)(6506007)(76116006)(66946007)(7696005)(4326008)(33656002)(26005)(54906003)(186003)(316002)(966005)(478600001)(52536014)(71200400001)(66476007)(107886003)(2906002)(55016002)(9686003)(8676002)(81156014)(8936002)(6916009)(81166006)(17413003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3424;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4MUqUtGqvn60W5Cg3VAOCEaXIhOiF3j4W7jkd+yvCPDQJTUkjvp5p1+s3wXdsnTObFhlZD6HKxrNctxx6Ia1PSx7z2D2SquWXUA07l038zF4sj9vlnR1IAFqAIdwDMKcuTlTosKDL6p6IlER7oO2wSUsgMso4jtRhQuTWbMmSa58YbrediYN7K6qQ7mpnrQeWIUV3HiYT3TF2BBl9axNg6Wgbdrlx+g5q2inT1qPEW++HxS2bLzzxLEenftz9XPt+3cisSYqmCbnV3dZ1hQUdqmI/ZmXN4xHEg8x3BOolyMkfi6UTmI5AZgNrehY1aI6Nx1OY1i1ZxcTskXEqcceWxFcuWPajF6UIw/G7aa7gtv4igA5iqb3nANsdmgbiE8VVvlFJnM4SCEk1EZqbHWWFgWb/YRxM0MmQONBNYaw6nDmJef6JqRg3xhvfCtvf02uVdq2nSxhfEFoD8pFZIXHSNnZhVw+BbIRQwwIDJ26fYx4OIbAHNo+/g/fU7MMH8HrWzt5NrsWac9hcpEslqFXl17lMSN++VwqzvzLvHBL0l3Lh/gZy/P5p4soUUlAT4B
x-ms-exchange-antispam-messagedata: iStJM8aBvZBqkCO/wm9JWTftpUnwprqhxBlbS3a7wrv5W7va5+bbl6hZEL3mMD9LxfXEPNrhUWMBbxlokN3ZpG7gfbbhcJVj+MUcr49dOUf1nsoapsVmjXYaCbnqY9LxGbV2qSzV8b7qGr8GKCB0bw==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1040d6b9-e63d-42e6-af24-08d7c680fa7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 12:29:15.5021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdqNCol1WU13Ol0Fc45u1X8VuXoDj/DEutkGl6CpQiv0uKPOEDnXHXYN6tzFffRjS118hlayKKlgbV0IN4zk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3424
X-OriginatorOrg: intel.com
Message-ID-Hash: KHMFJX25WB5WQ2BSE5IUJ67QJ2RMHAQZ
X-Message-ID-Hash: KHMFJX25WB5WQ2BSE5IUJ67QJ2RMHAQZ
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KHMFJX25WB5WQ2BSE5IUJ67QJ2RMHAQZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi

It seems that the 'nfit_test' module has some issues from more than 1 year and 4 months...
https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/JMTYTZYKFZ73ZNXTLB4FQZ3CMDHDLD24/?sort=date

It looks the same now...
I have followed the instructions listed in https://github.com/pmem/ndctl/blob/master/README.md

$ git clone -b libnvdimm-for-next git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git linux-nvdimm
$ cd linux-nvdimm
$ make menuconfig
$ make
$ ls -l /lib/modules
total 12
drwxr-xr-x 4 root root 4096 Mar 12 08:14 5.5.8-arch1-1

$ sudo make M=tools/testing/nvdimm modules_install
  INSTALL tools/testing/nvdimm/dax_pmem.ko
  INSTALL tools/testing/nvdimm/dax_pmem_compat.ko
  INSTALL tools/testing/nvdimm/dax_pmem_core.ko
  INSTALL tools/testing/nvdimm/device_dax.ko
  INSTALL tools/testing/nvdimm/libnvdimm.ko
  INSTALL tools/testing/nvdimm/nd_blk.ko
  INSTALL tools/testing/nvdimm/nd_btt.ko
  INSTALL tools/testing/nvdimm/nd_e820.ko
  INSTALL tools/testing/nvdimm/nd_pmem.ko
  INSTALL tools/testing/nvdimm/nfit.ko
  INSTALL tools/testing/nvdimm/test/nfit_test.ko
  INSTALL tools/testing/nvdimm/test/nfit_test_iomap.ko
  DEPMOD  5.6.0-rc1-bb-13504-g7b27a8622f80
depmod: WARNING: could not open modules.order at /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80: No such file or directory
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/libnvdimm.ko.xz needs unknown symbol key_type_encrypted
depmod: WARNING: could not open modules.builtin at /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80: No such file or directory

$ sudo make modules_install
  INSTALL arch/x86/crypto/aegis128-aesni.ko
  ...
  INSTALL sound/xen/snd_xen_front.ko
  INSTALL virt/lib/irqbypass.ko
  DEPMOD  5.6.0-rc1-bb-13504-g7b27a8622f80
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol libnvdimm_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol acpi_nfit_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol pmem_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_core_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_compat_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol device_dax_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_test

$ sudo make M=tools/testing/nvdimm modules_install
  INSTALL tools/testing/nvdimm/dax_pmem.ko
  INSTALL tools/testing/nvdimm/dax_pmem_compat.ko
  INSTALL tools/testing/nvdimm/dax_pmem_core.ko
  INSTALL tools/testing/nvdimm/device_dax.ko
  INSTALL tools/testing/nvdimm/libnvdimm.ko
  INSTALL tools/testing/nvdimm/nd_blk.ko
  INSTALL tools/testing/nvdimm/nd_btt.ko
  INSTALL tools/testing/nvdimm/nd_e820.ko
  INSTALL tools/testing/nvdimm/nd_pmem.ko
  INSTALL tools/testing/nvdimm/nfit.ko
  INSTALL tools/testing/nvdimm/test/nfit_test.ko
  INSTALL tools/testing/nvdimm/test/nfit_test_iomap.ko
  DEPMOD  5.6.0-rc1-bb-13504-g7b27a8622f80
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol libnvdimm_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol acpi_nfit_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol pmem_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_core_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_compat_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol device_dax_test
depmod: WARNING: /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz needs unknown symbol dax_pmem_test

Does anyone know what is wrong here and how it can be fixed? Any suggestions?

--
Lukasz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
