Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E435A187BBB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Mar 2020 10:09:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B313E10FC35A0;
	Tue, 17 Mar 2020 02:10:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 032E610FC3599
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 02:10:00 -0700 (PDT)
IronPort-SDR: JPMErz+S8/nJTaz2t90jGKxgxRqynjewG9LZ6hLCCEGrBWI0l/QzTEhV9+h8SgnItjQM/cKG1G
 72bdRqjgaoVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:09:09 -0700
IronPort-SDR: KO3D3SvHFfNY+NKkjqMiW2VXSI8ZBQip7rbzc+9ZgYiHyqRHHqJvxHXXZ0Bl3Ee1zzfsOsVnHf
 aDfjpRnHrmHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400";
   d="scan'208";a="445431384"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2020 02:09:09 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Mar 2020 02:09:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Mar 2020 02:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKWykSa2HQV3L8qe/bJPcmurbqn0GjQekegpKSNil0hmmnDYFT86WXBlOSDogEqKp0J03nmEXLFAAUqJpUL53p4mHWeGmbqwo8mTBaMDCTFRauSjt3/iI9Iqq117PLo/Aa2pVEe5yRLho0moi2rgnK60RArHth5vRf6/w01aUp9nD0ECD6uitFLgG8BGJX4WynScmmykoW8jFzJbiB7v2RmfTHiOakrD4/Wnd0n1z+3h6nJ9q5/sqD8p7m9FYnxv7uxh3DCWbCdjQyCcZqJY1ypUlLRl9M5qtoBgRnQYwlxGPCXMt6+6qOOYZrthx6XOXMT6Y70X82Yij/ILsaQq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbgWXzHHi3dUUolhqg+WZujLXqUpICpNO0Szx249MPc=;
 b=KSMgGAEtaR49NaCeXV+LJ77z3SE3xMG3dMd58q+pu1x74MIjWBBGmgV2sQuzHbldip0fwI0ahPRDcFu8GMlUsHbsd6pigS7GBJFyotiErqhPWBPYjMWtqJkzhRtVPGa2T8Aq+nAXFjC8dlNc0LLUbb7cJkDOM8x8luqTI7D+1r6Yy48tFg62LAj5noj3dSE98pS/XiXpdf21iYHn2z2jjZ4qfnHSdm/EiJn6lUqgw99BguBV/5dWaWwJenGUXs6NAjb8gx/ebCSUD9EeZiykXzMexmnNxF6C6BXWQJeFjANU875vLvURkGF6bEQrmubcNW03JKOY10rs/5JJmFRsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbgWXzHHi3dUUolhqg+WZujLXqUpICpNO0Szx249MPc=;
 b=vwlES9SR7JavWhXGXCGXkjNtpk18yiHoN1sYJoD0bQA7pLonn2JsDUrAB/CCpFO5CcpmCPGyIvBAD8FjNGda7K/KBLhHW9Cz8jw6KGibbNSNsPxEga/dWNL+eLBERVHRT/dIWc3zSvyep/nxzR3fcnhtN++P553LBOXxWicr8+8=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB2720.namprd11.prod.outlook.com (2603:10b6:805:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Tue, 17 Mar
 2020 09:09:08 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 09:09:08 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Topic: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Index: AdX4ff9vRi+83PXwTQC0PvRaS9yWHAAAVn9QAARgr4AAIv1AQAAMjuqAAIf1YgAAMbS0AAABFJ/Q
Date: Tue, 17 Mar 2020 09:09:07 +0000
Message-ID: <SN6PR11MB286403BE843E5B13813825E396F60@SN6PR11MB2864.namprd11.prod.outlook.com>
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
 <SN6PR11MB286493B9A749705B8A107F4396FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4jOuTXdNzUTSj2EWBoKJ5V8FeEWo4cCA3e95jdT3=7XFQ@mail.gmail.com>
 <SN6PR11MB28647B2D8B3C0729FE0CCDD696F90@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4iAJbZpKYzA5SgGcH+dkPQyHkxgGgufTd_YnSZ5bF_X7A@mail.gmail.com>
In-Reply-To: <CAPcyv4iAJbZpKYzA5SgGcH+dkPQyHkxgGgufTd_YnSZ5bF_X7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lukasz.dorau@intel.com;
x-originating-ip: [134.191.221.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64ed1919-702c-4838-0904-08d7ca52d96f
x-ms-traffictypediagnostic: SN6PR11MB2720:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2720DDB9A8005DBF852F7FC396F60@SN6PR11MB2720.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(8936002)(478600001)(7696005)(186003)(71200400001)(26005)(6506007)(53546011)(8676002)(6636002)(54906003)(81156014)(81166006)(316002)(5660300002)(52536014)(64756008)(66556008)(66476007)(76116006)(66946007)(86362001)(2906002)(66446008)(55016002)(33656002)(107886003)(6862004)(4326008)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2720;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONbcyWXuPC44XIjMyfe0w8w07k6lj6pa6QmcV824qaK09/cA7f+qRtmGwuV/Weqm1JsCCLSXQMafFRcMqo1ZLcAcf77u/ps6QEVF5TO6haZYWSXhxDwC4hm1hWyxSBF3byTHZwPNy0oGY/V2qXaiYceiQQyMbmRiabzuBvELwkJ/0Q+OPNvvefnsXDRqbD22jhOYxk/Qs5KbRoZKwL4+7yfSxnSXKDED+FyiFFSN78eI3ZfMgOJlOa8dus31kLIDl/QbXuzPBQSkbvvxOWvtSIwMX7YG4MSE8pvlNiAdg3y8s08nNpvelF6qeUSYfVrVOiTt7oTvj4BlDelU+DXsatffke5VoeS4kBYDMHHl5yBEGTBnJ391/v0TGRkF0SHaBR6GrmQdOIM7JJ+Cf8vd2Rm7M5+W31Vtp2xtF1l+4Lhvs++ucRvS9yYrjp0QcdGS
x-ms-exchange-antispam-messagedata: h9wc8oZ+FGLwrbZr9cfvJ38XsiFB+AHGDNB6pV7ngu7yzPdlxLfmiM1nA0rmnwPmU+CW18Nhf1lTgDSMNp1sjGDZ0KOyDDO0MjsiVF9DNjoBzPcK8avAN6IpJnGiF5RtF55dta41NP/DHlnYh46LpA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ed1919-702c-4838-0904-08d7ca52d96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 09:09:07.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUtITHIuKJn2Fedgna55QW8H7+mE0bjPHqq7EIGUTRcQl1+u8D2liBGMwxV77eNEeLF4W54UgdL+HfPakLHjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2720
X-OriginatorOrg: intel.com
Message-ID-Hash: MGLQRGQ76LHWXIGRHPPJSWBVYRLQHE5C
X-Message-ID-Hash: MGLQRGQ76LHWXIGRHPPJSWBVYRLQHE5C
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MGLQRGQ76LHWXIGRHPPJSWBVYRLQHE5C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tuesday, March 17, 2020 9:26 AM Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Mar 16, 2020 at 1:58 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> > The above error:
> >    "nfit_test: Unknown symbol acpi_nfit_test (err -2)"
> > I have hit after having removed the 'nfit_test' module:
> >    $ sudo modprobe -v -r nfit_test
> > and having tried to reinsert it:
> >
> > $ sudo modprobe -v nfit_test
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> unknown parameter (see dmesg)
> >
> > because 'modprobe' has inserted the production version of the 'nfit' driver
> (kernel/drivers/acpi/nfit/nfit.ko.xz)
> > instead of the test one (extra/nfit.ko.xz).
> 
> Right, that's broken, but I'm not sure why.
> 
> >
> > Regarding 'depmod' I have run the following commands to build and install the
> kernel and the modules:
> > $ make
> > $ make M=tools/testing/nvdimm
> > $ sudo make M=tools/testing/nvdimm  modules_install     # ---> it runs depmod
> > $ sudo make modules_install     # ---> it runs depmod
> > $ sudo make install
> 
> What distro? On Fedora rawhide I'm doing the same steps and end up with:

Fedora release 31 (Thirty One)

> 
> # cat /lib/modules/$(uname -r)/modules.dep | grep nfit_test.ko
> extra/test/nfit_test.ko: extra/dax_pmem.ko extra/dax_pmem_core.ko
> extra/device_dax.ko extra/nd_pmem.ko extra/nd_btt.ko extra/nfit.ko
> extra/libnvdimm.ko
> kernel/security/keys/encrypted-keys/encrypted-keys.ko
> kernel/security/keys/trusted-keys/trusted.ko
> extra/test/nfit_test_iomap.ko kernel/drivers/char/tpm/tpm.ko
> 
> ...i.e. the test version "extra/nfit.ko" in the dependency chain.

On Fedora release 31 (Thirty One) I have the production version ("kernel/drivers/acpi/nfit/nfit.ko.xz") in the dependency chain:

$ cat /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/modules.dep | grep nfit_test.ko
extra/test/nfit_test.ko.xz: extra/test/nfit_test_iomap.ko.xz kernel/drivers/acpi/nfit/nfit.ko.xz kernel/drivers/nvdimm/libnvdimm.ko.xz kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz kernel/security/keys/trusted-keys/trusted.ko.xz kernel/drivers/char/tpm/tpm.ko.xz kernel/drivers/char/hw_random/rng-core.ko.xz

I do not want to use Fedora rawhide, because AFAIK ndctl does not compile on it.
All I need now is to know the distro & kernel the 'nfit_test' module works well with.
Do you know them? 

--
Lukasz

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
