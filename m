Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AD418672F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Mar 2020 09:58:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B590E10077CE5;
	Mon, 16 Mar 2020 01:59:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 563DC1007B1C9
	for <linux-nvdimm@lists.01.org>; Mon, 16 Mar 2020 01:59:00 -0700 (PDT)
IronPort-SDR: 3RnX5h380KGzo02OJ26xfDW4XbX5hPM7WNohwRNvLKv4TxFqUMK6aV2Z7aS8m6YaMTYCjLOuM8
 Foh8wg61DT4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 01:58:09 -0700
IronPort-SDR: xxrmrBi/tXGtTKDknddrKZO54Z72tI01AkpLOFFKAlIlKklWlep2w2S824qJ7U8rhJ5mmitx96
 uR3KdcOH+A7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400";
   d="scan'208";a="443254712"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2020 01:58:09 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Mar 2020 01:58:08 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Mar 2020 01:58:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Mar 2020 01:58:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4TrI+Ot5xw94o5cpcZJMR7ujDaR9PnfEY+BbBqQpalQSBicLg4YbjwbdLOgpDjc6MxfPTYSXB9TKgpy4MBXZ42T4TDt6d4euF1tIKGTjXkmMZqAd1+iYWunfHQy76MZE2XaiRyFY2BB7/yGGWMSY7If3r+lfBcz9pllfKaiIk2iukAiFIJ2szCLWEHkK9npeI89dId3vBCmY6QYoHPkXgNwdLVMEEbECK7xFE89oJ35m/R7KgT3Ym8hOALDaraWPGSly2uo1cDJ0+YR9vdmF311SDK8CRMq5165YYLgNxst25yFNPxAEsB0/nugzumGN04Hevb0q5Tk6hck+42mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRSwnDn/hbjHPM2/H2MIA3Qwkxbpp4kMlA+RGEQuHYA=;
 b=JfCfwzm/4h04HeUkLV0tMGj4q88YXIBUxV1KLmboB9NqEv06kzytN4VRQFBIEUqPW5sSl8Dhh/MSrMvBXIMzlkPwpxwO7rwTeJFoY0RPGjqa3j0A4p8s/OoXHckPdLYFXklDwcnufOD0qf4C0CHlSO0EM6XesPq6QmsaepkGvVr2UBKT3UF1tIrkNd0WoS0M84s4saE9ZiNCXNiaCThlEaC8HkU1nJY7nFsrAhSPX/2xIHc4oCfMTIYWhfShbj0hsWST3dkyHwpaWW2OHHcjlm5uvtqI9c3Nd0ttXfgQ1XoI4ffD3McYGZv11W/P0JEtXk38PLlAfSp9dyolDIhi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRSwnDn/hbjHPM2/H2MIA3Qwkxbpp4kMlA+RGEQuHYA=;
 b=YA4s2W0fCFoaGj7FjoueotzYax358gP7z+ZNbcTrww/LYUqndKi9Zqtf4V4LvCWXEln1ySNnvVWlv1dUK1PUrjSxolPlz4oYSVhXa7lRi+vvn61DrGqXlU3HHHWEVXTvndA2RW+HwKeXittGXS84WRduZjDcgBo+9/RyySTT2oM=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 08:58:05 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2814.018; Mon, 16 Mar 2020
 08:58:05 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Topic: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Index: AdX4ff9vRi+83PXwTQC0PvRaS9yWHAAAVn9QAARgr4AAIv1AQAAMjuqAAIf1YgA=
Date: Mon, 16 Mar 2020 08:58:04 +0000
Message-ID: <SN6PR11MB28647B2D8B3C0729FE0CCDD696F90@SN6PR11MB2864.namprd11.prod.outlook.com>
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
 <SN6PR11MB286493B9A749705B8A107F4396FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4jOuTXdNzUTSj2EWBoKJ5V8FeEWo4cCA3e95jdT3=7XFQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jOuTXdNzUTSj2EWBoKJ5V8FeEWo4cCA3e95jdT3=7XFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lukasz.dorau@intel.com;
x-originating-ip: [134.191.221.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2f08027-34ad-4dc2-efaf-08d7c98823e3
x-ms-traffictypediagnostic: SN6PR11MB2829:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB282963E4E79F4EE0AE925F2296F90@SN6PR11MB2829.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(7696005)(86362001)(52536014)(478600001)(4326008)(107886003)(54906003)(316002)(6862004)(2906002)(8676002)(33656002)(81156014)(81166006)(8936002)(186003)(26005)(76116006)(55016002)(5660300002)(66446008)(64756008)(66476007)(66946007)(66556008)(6636002)(6506007)(53546011)(9686003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2829;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NvtGAGKOX9VYa3FrNzQjW7Jkc3imQlUoi7TCn9/XuXdAK7F666rFMJXtZ/SVMoH9l7XhxbiL7doc0QgSZL0ZHpHVFqEVWb0wIvg4kDaZw8EP7VvI6kAk4yB+4Q7gckbKHuQPKKAoGPlrEVgFTJM13mQSXGqBRRecdh/FLx2XsQoxw0xxj4rIagGxf3CXNFBSedupC6DVDFL3oelbZyNFVmYhd/4GA1JywqLnPy+r/UkCaqu5YUzMPkgNiXYS75mf33+Qpsn5y/GNuwRizBYVw8+dkgKTk0d/Z6IavDFWozVjnHNglO9t9LFHHvi3czDDrnfc/S10zngI8FR1i5BgO06ITCsXUgW/e+hPUJkhVtfYmDyswqd7BrlMV+w0lm62LbQmYiRBQS0A2LTa1xcLNbk9IFdpYhvEpYutuALvOTu7OVJyRYVSSOEqJsXWCi/h
x-ms-exchange-antispam-messagedata: ptcw66k7Fc/4LCwH13yT9t3smbGulk90pUuuovEf/BqDlqDUc9UJQH/Vkt7cGnMYmGuJzLCvn3V/m3SEO0QsIkKBTR89wEX46KGezmWpC7n0C3L64J0GI1EfhocNLMaQWIoNot0zGbwz17FaMwN4Kg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f08027-34ad-4dc2-efaf-08d7c98823e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 08:58:04.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2ycKUGqpyozvqEfxgc8PhM8T7b2MllcE5jZuQ7cZGwPIktrbX8xc0cv/tgEwnxCxHSOvKaO6FNz+9nYkUsiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-OriginatorOrg: intel.com
Message-ID-Hash: 33BA4D6NFWVFYWVMOKHKXZHUE6RB54XR
X-Message-ID-Hash: 33BA4D6NFWVFYWVMOKHKXZHUE6RB54XR
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/33BA4D6NFWVFYWVMOKHKXZHUE6RB54XR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday, March 13, 2020 4:50 PM Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Mar 13, 2020 at 3:06 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> >
> > The steps to reproduce:
> >
> > $ sudo modprobe -v nfit_test
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/char/hw_random/rng-core.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/char/tpm/tpm.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/security/keys/trusted-keys/trusted.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz
> > install /usr/bin/ndctl load-keys ; /sbin/modprobe --ignore-install libnvdimm
> $CMDLINE_OPTS
> > No TPM handle discovered.
> > failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> unknown parameter (see dmesg)
> >
> > $ dmesg | tail
> > [  102.769871] Key type encrypted registered
> > [  102.799289] nfit_test_iomap: loading out-of-tree module taints kernel.
> > [  102.804008] nfit_test: Unknown symbol libnvdimm_test (err -2)
> > [  102.804054] nfit_test: Unknown symbol acpi_nfit_test (err -2)
> > [  102.804118] nfit_test: Unknown symbol pmem_test (err -2)
> > [  102.804164] nfit_test: Unknown symbol dax_pmem_core_test (err -2)
> > [  102.804226] nfit_test: Unknown symbol dax_pmem_compat_test (err -2)
> > [  102.804273] nfit_test: Unknown symbol device_dax_test (err -2)
> > [  102.804308] nfit_test: Unknown symbol dax_pmem_test (err -2)
> >
> > Removing the wrong modules:
> >
> > $ sudo rmmod nfit
> > $ sudo rmmod libnvdimm
> >
> > Inserting the right modules manually:
> >
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/libnvdimm.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nd_btt.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/nd_pmem.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/dax_pmem_core.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/dax_pmem.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/device_dax.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/dax_pmem_compat.ko.xz
> > $ sudo insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/extra/test/nfit_test.ko.xz
> >
> > The 'nfit_test' module is successfully inserted with *NO ERRORS* now:
> >
> > $ dmesg | tail
> > [  464.439504] nfit_test: mcsafe_test: disabled, skip.
> > [  464.500439] nfit_test nfit_test.0: failed to evaluate _FIT
> > [  464.507964] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail
> restore_fail flush_fail not_armed
> > [  464.507990] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
> > [  464.508614] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-
> only
> > [  464.508729] pmem6: detected capacity change from 0 to 33554432
> > [  464.508737] pmem7: detected capacity change from 0 to 4194304
> >
> > $ lsmod | grep nfit
> > nfit_test              49152  8
> > dax_pmem_compat        20480  1 nfit_test
> > device_dax             20480  2 nfit_test,dax_pmem_compat
> > dax_pmem               20480  1 nfit_test
> > dax_pmem_core          20480  3 dax_pmem,nfit_test,dax_pmem_compat
> > nfit                   73728  1 nfit_test
> > nd_pmem                24576  1 nfit_test
> > libnvdimm             200704  8
> dax_pmem,nfit_test,dax_pmem_core,nd_btt,nd_pmem,dax_pmem_compat,nd_blk,
> nfit
> > nfit_test_iomap        24576  6
> nfit_test,dax_pmem_core,device_dax,nd_pmem,libnvdimm,nfit
> >
> > Trying to remove and reinsert the 'nfit_test' module:
> >
> > $ sudo ndctl disable-region all
> > disabled 8 regions
> >
> > $ sudo modprobe -v -r nfit_test
> > rmmod nfit_test
> > rmmod nfit
> >
> > $ sudo modprobe -v nfit_test
> > insmod /lib/modules/5.6.0-rc1-13504-
> g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
> > insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
> > modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or
> unknown parameter (see dmesg)
> >
> > $ dmesg | tail
> > [  919.861636] nfit_test: Unknown symbol acpi_nfit_test (err -2)
> 
> I'm still not sure how you are managing to hit "unknown symbol"
> errors, are you re-running depmod after creating the test modules?

The above error:
   "nfit_test: Unknown symbol acpi_nfit_test (err -2)"
I have hit after having removed the 'nfit_test' module:
   $ sudo modprobe -v -r nfit_test
and having tried to reinsert it:

$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz
modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

because 'modprobe' has inserted the production version of the 'nfit' driver (kernel/drivers/acpi/nfit/nfit.ko.xz)
instead of the test one (extra/nfit.ko.xz).

Regarding 'depmod' I have run the following commands to build and install the kernel and the modules:
$ make
$ make M=tools/testing/nvdimm
$ sudo make M=tools/testing/nvdimm  modules_install     # ---> it runs depmod
$ sudo make modules_install     # ---> it runs depmod
$ sudo make install

--
Lukasz

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
