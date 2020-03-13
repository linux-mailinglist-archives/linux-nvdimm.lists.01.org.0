Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EB184413
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 10:49:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FD7510FC3587;
	Fri, 13 Mar 2020 02:50:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 371751007B1E3
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 02:50:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 02:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400";
   d="scan'208";a="354334268"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2020 02:49:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 02:49:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 02:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h18HNW0aqwRlNvn0WwjdQKK9Wpc7wgM9X2H2Zm53UqfQDdt1W6tjEP99BHFenYXiDYLGuFnDurUjY6YxKrmwDyIMRRmUljgFNAA7uiWRvLrYGhYwi8jOBPe8b5svzWuGCXnofodrMrX267l3Q94kiCGiq8HyzMQdkWDgf13t9QapWeVvDvAZyLTk9E2JlGkcDRR0PotA+FLDQxV2aZrqNcRNNFDyULTJob/N+dy7Z6buBMp252HfuxESh1aHmsJUN4rBF5GUFcuNsMV9ZubUfW4DiTLtWb7esZC0u+eQ28DaygIr0PJEkqRtUuPzW/ycQ1B9IYj8bAp/M0BL2HhHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXbD6lyzdh4uQH1OI7aT9L5nkRGcIo+8B2jFQO+e21I=;
 b=ILAW/0z3p8bkkoA2hPovNoN41VPZiIScNjsRe3q5FiDMdSHZFN5fnpPz6kMxRIPZ+hKamlXLMrlq27vVKNrwzpFntOYOAutvDwl19MIMACl6DBvLWO2nVRI8KWOPC+eamO5Hh7IVgEzkBjbJVhmO2IZtjK3BZicqZ2Mzd72ZSnZtw3At1O/xf+QPMLuVoOiZFiPYQFVjkpaaPjgR82AYSCzTpdZjEIu/x7b/jmU83c63X6IBc6CX7yipncZrqBa+2p4n7t5OxYYUMHPdu0BYJncDPCAM7+9tZCPF7pQOrsXXOuIxJadCmouvdoEwoVLc4B6fdNXP9IndRNt9asAlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXbD6lyzdh4uQH1OI7aT9L5nkRGcIo+8B2jFQO+e21I=;
 b=ZX9iBiAf8nyu1O3LOY7+YzexKd51i473AdtU3sYbSeETJfKLilV4V4UUj52BAs8Lk6r25GqpRkYSK/ayGKNTbHTEKl26TLCt1Hm66riJHjraTEzTLd351Ps7Y6dr9yruNjckK4ZO72YlAfMFx15wFVdCgcU1zLOL9VvoaeStY6Y=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB3519.namprd11.prod.outlook.com (2603:10b6:805:d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 13 Mar
 2020 09:49:50 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 09:49:49 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
Thread-Topic: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
Thread-Index: AdX4eeu8S4UKpcXxQVyul9RQ8BWIzAAFpEOAACLglpA=
Date: Fri, 13 Mar 2020 09:49:49 +0000
Message-ID: <SN6PR11MB28647C6C4DE888D1B74A903B96FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
References: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4hX5D6G6uSCoeV78NfJtNj8cvk5=ouLJ+EL2SXvqi-d_Q@mail.gmail.com>
In-Reply-To: <CAPcyv4hX5D6G6uSCoeV78NfJtNj8cvk5=ouLJ+EL2SXvqi-d_Q@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 061e3e6c-1b60-42fb-5c13-08d7c733df3d
x-ms-traffictypediagnostic: SN6PR11MB3519:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB351981A5E2F08F6213779C2896FA0@SN6PR11MB3519.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(2906002)(4326008)(6636002)(33656002)(64756008)(316002)(66556008)(66446008)(66476007)(52536014)(66946007)(966005)(478600001)(53546011)(107886003)(6506007)(6862004)(9686003)(26005)(54906003)(81166006)(55016002)(81156014)(86362001)(186003)(71200400001)(8676002)(7696005)(8936002)(76116006)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3519;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Z0pKR3SBgVvldOKpsIzKpp35Y5YZrQqr9KHjfh1NIPz7ss49L9WBfNLFlNrKbSkBZVq+2OhHqecwGvIlAeox1nfcM0UKkuCOBbZOBJCSmXQGOguibIewxPjV8HpVMEUAmaCHhbd1/c5Y5mNZiCJ5CB4Fnup+8yrlWlZyUaBZ+XLZIrSZwwo4Aack+2mK9jlL9FFbzZPzP0lrBj6bMgWZtOY0qBQM6VvRLWlRCqXFhdwXcJ7A81T6Go2dEM8sBGdz6SmrXNkgKk0rQJYEI4WwLz+uwKF3z+7gG4fgbALXP3bkThqUwk1N0RIkXdvsidZWROdoKMfOpSkGn/zVNjXwcURrlG85bU5Q/9WtYd+0tgvqwvVD4mp6hv/v7kiuouYKBhn8J3Dx76oUAmCdkcEg7P5jd2i7R50EIxtG/6N6zXtdio2hFEJDgeZsRcrcchIIgxoV6qQhMr5WCuCZhluLvDt+WWQFvP/Ry/rQFy7hooe0qgGn38h1EWoX2nb+QJOyrBWvHepNodr9XnPWEM6Aw==
x-ms-exchange-antispam-messagedata: Ca6Q6kfJd7XMYWYP2WAuklvkTLCybecWnm89FHy8GQ+IRO1bQVeR7cdtoLuOmh/C5tm6A0Q57YAyS5pIj5YHTr6b8/lMNZp7vceXoR2o/ikftl9enpG4w73tXVkr0R1zN7RF9GmQJvxH9o7o1Ce29w==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 061e3e6c-1b60-42fb-5c13-08d7c733df3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 09:49:49.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 725iX0A++3KBlxDpLIfOjId5+O4h1+SMR4WaxvNjCUS4SyMjf0Pk05HRIBcHydmXyWaeNUxaT5/ZNB3l8g1aeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3519
X-OriginatorOrg: intel.com
Message-ID-Hash: XKMZAQXLL7Z3C6WHE7EEVI6O4G6O3QZY
X-Message-ID-Hash: XKMZAQXLL7Z3C6WHE7EEVI6O4G6O3QZY
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XKMZAQXLL7Z3C6WHE7EEVI6O4G6O3QZY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday, March 12, 2020 6:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
> 
> Yes, you're environment is not being careful to exclude the production
> version of the modules from being loaded. The ndctl unit test core
> also sanity checks nfit_Test and reports the collisions before running
> tests. See nfit_test_init():
> 
>     https://github.com/pmem/ndctl/blob/master/test/core.c#L119
> 
> I'd recommend at least running:
> 
>     make TESTS=libndctl check
> 
> ...from latest ndctl.git to sanity check your nfit_test module
> dependencies before trying to load it manually.
> 
> See the troubleshooting document:
> 
>     https://github.com/pmem/ndctl#troubleshooting
> 
> ...for other tips about how to prevent the production modules from loading.

Thanks for tips! I have followed those instructions and it did not help:

$ cat /etc/depmod.d/nvdimm-extra
override nfit * extra
override device_dax * extra
override dax_pmem * extra
override dax_pmem_core * extra
override dax_pmem_compat * extra
override libnvdimm * extra
override nd_blk * extra
override nd_btt * extra
override nd_e820 * extra
override nd_pmem * extra

$ find /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/ -name "*nfit*"
/lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit
/lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
/lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz
/lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
/lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz

$ make TESTS=libndctl check
[...]
make --no-print-directory check-TESTS
SKIP: libndctl
============================================================================
Testsuite summary for ndctl 67
============================================================================
# TOTAL: 1
# PASS:  0
# SKIP:  1
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================

$ cat test/test-suite.log
[...]
.. contents:: :depth: 2

SKIP: libndctl
==============

test/init: nfit_test_init: nfit.ko: appears to be production version: /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
__ndctl_test_skip: explicit skip test_libndctl:2695
nfit_test unavailable skipping tests
libdaxctl: daxctl_unref: context 0xe02a00 released
libndctl: ndctl_unref: context 0xe05f20 released
attempted: 1 skipped: 1
SKIP libndctl (exit status: 77)

As you can see 'ndctl' also cannot load the extra test version of the modules even if there is the following file:

$ cat /etc/depmod.d/nvdimm-extra
override nfit * extra
override device_dax * extra
override dax_pmem * extra
override dax_pmem_core * extra
override dax_pmem_compat * extra
override libnvdimm * extra
override nd_blk * extra
override nd_btt * extra
override nd_e820 * extra
override nd_pmem * extra

Can I try anything else? Do you have any suggestions?

--
Lukasz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
