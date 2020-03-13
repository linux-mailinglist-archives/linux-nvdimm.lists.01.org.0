Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F7184455
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 11:06:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C35210FC3587;
	Fri, 13 Mar 2020 03:07:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 126F310FC3587
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 03:07:00 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400";
   d="scan'208";a="278163961"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2020 03:06:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 03:06:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 03:06:08 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 03:06:08 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 13 Mar 2020 03:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWtUwmhg7xjG50CPlHzWtylK4YbLtp1ENjiwwV9K4AUORodwmnGJsjliJ0y5fHFwg3TUSUXTABMSweTiVTHIqe2p0Ix8X2Fud2Yg2VmLiAJo+0kvecy0dQN5ddL/ZyIYGWpRwWReFRF7akAtRjXYXDxK1a8bsI3hkEn6Cu2mtNZr7Qn3HJiRK8D613SfjIBDuLiDFQIsFTWN6oYBiOZsRSML9aXJ+BJvWKh2gf2NqFjT5pIuWqIn6248SD1H2vxIIZKGxt40BeClamcJ5awthLxsyFbth3xv13CKJJsRn/y7HgrVIgSgpqZzr11C+0qtcSMCm4y19SGwZ2n3VHpGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJElOGAgbgJlZTF3UyYeaBLUuj4Jp6k3BurkQGUcKk=;
 b=g6XT/4ZVbYY0onsS1C77gKtQ6uPzWdBiq/xZLKUVIm6NI6/yxN0E+Lt5QS/H8PZ3nczKQhoM9eJilBhjTSDIc99ERe5vW6KqApIa1F9GNdyecNv6bymf+7Hu72LCjVI+Smz5PIRs9l7n7JhpgCps9nGPVhTIGU9b5F1PMvedws8BkYtruTWgEPpV6yLYCVzumhnsUnqakGLlIy0ZceQOiYbhMb6Ui/ROvxE7uob+WqP6uRWU5IZ49ST63kN5PeUjONIXaVdXWX56hvqvhD/nqgLE+Dz36QndneRzqse8asUdpKN0kBUBplmMvKUvB72FTG7GShDGlRWkfZOYZc+6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbJElOGAgbgJlZTF3UyYeaBLUuj4Jp6k3BurkQGUcKk=;
 b=gez18luyIgQkUQYc/H2YybMVeNYcQSsfluRGJXAV49c1MekcdBPH2Ysqn5zUB8V0jva86GI1yeCkGnF8qveXFYo3QHDmGHvn+d/r1B6W7sYoAuaaJ9+LsoN8z5eZGTESy4Ux/+850LmhMaFOL3m4FDfMQcF4SSR8YzkuEkKbIB8=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB2862.namprd11.prod.outlook.com (2603:10b6:805:5b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 13 Mar
 2020 10:06:04 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 10:06:04 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Topic: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Index: AdX4ff9vRi+83PXwTQC0PvRaS9yWHAAAVn9QAARgr4AAIv1AQA==
Date: Fri, 13 Mar 2020 10:06:04 +0000
Message-ID: <SN6PR11MB286493B9A749705B8A107F4396FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
References: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <SN6PR11MB2864BBFAA6EC62A7747F9E5D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
In-Reply-To: <CAPcyv4gXZKPyqu+9JmWuivw4Yuc05_Q+bbcjRAsHK2PWKtjwjg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 440f9b4c-6a5a-46dd-6d37-08d7c7362472
x-ms-traffictypediagnostic: SN6PR11MB2862:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB286241C2CC76977C1918601E96FA0@SN6PR11MB2862.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(2906002)(45080400002)(5660300002)(52536014)(54906003)(966005)(30864003)(81156014)(316002)(8936002)(86362001)(478600001)(81166006)(186003)(6862004)(8676002)(107886003)(26005)(7696005)(76116006)(4326008)(66556008)(55016002)(64756008)(9686003)(53546011)(66476007)(66946007)(71200400001)(66446008)(6506007)(33656002)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2862;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTMz7zb3PpPoOcs/Yf1f7X5wV2dTRoTkotmOknFsNV96MWL+On8WwpSOnvW6mZToUXDypdMPB0hR4lNa779afz8TdN9tckIj3kYFSH0Vg96XqdS2bBbBF8qJhMFdJryhL2ClSInEult03yOcawX4Lelsmv3TQl03mLNSDGs66rZ1/wEb0l6dRUUxCtDmA5P65iUfNrYo3IJv5HXtBIoJDfgeXI2PS3bDhQbSMa0i5H+HbQ/acagNO6SU7rlC8r87VOjFXDd79PlWk2PF9CwpCSAUVx/wx7e7uJmbcIFLfRhhMTIdGFoK+iSPfD1npQLg4ovqxoDOQ2G/beYWe5eqb3VP4qaMRjHeLg63QdpydtYldhvv9WMyzskHKQ0QAv6FntdxwaVuFMhF8fp604ZSkTOijPSNGocbBlumK98vENP6ILzftBbWxtmX/HoD6RHOZeHeeAkfFvncKUbvbCK0KDVTfVQkl2gn9WngWhcA/FHx6+Vd4ACZKgMyLowkJbJWd1EhhJrYoIn2NL8SqswRFg==
x-ms-exchange-antispam-messagedata: J/pLHeq91F4j2skYOYxHNN5muTNLD1Ii8hnAdeO+37C96dMbCT6XVyZ8v3BOIJSr8nWbOCiE2aH/ssI1D7SJsWff+HXARQkQyuW59bvUzQdu1dr4K8tMIGud32A+clGlwO14O3zTOj91oTeBh0G2aA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f9b4c-6a5a-46dd-6d37-08d7c7362472
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 10:06:04.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiddKfcO35h/PADZXrDTmXVA6ZIF8YbDrqERfBZJZCyhs8REItI53mn3iRdEpfHTPhnuh0Yc9A0s/OvnPb/3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2862
X-OriginatorOrg: intel.com
Message-ID-Hash: 3GVHMPBXA3W5LLA63S3T2FL6JKQT7N6U
X-Message-ID-Hash: 3GVHMPBXA3W5LLA63S3T2FL6JKQT7N6U
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3GVHMPBXA3W5LLA63S3T2FL6JKQT7N6U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday, March 12, 2020 6:09 PM Dan Williams <dan.j.williams@intel.com> wrote:
> 
> If you force loaded a module with unresolved symbols all bets are off,
> lets get "make TESTS=libndctl check" running cleanly before trying to
> debug this report.

My experiments with "make TESTS=libndctl check" I have described in the separate thread "nfit_test: issue #2":
https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/QDFPRM5C3UQJKPQ6OKA6PO57Z55S67RF/

I have *NOT* force loaded a module with unresolved symbols. I have loaded the 'nfit_test' module manually (using 'insmod') without any errors.
I have repeated those steps below for the latest
git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
kernel from the ' libnvdimm-for-next' branch and the oops occurred again:

[ 1559.560169] BUG: kernel NULL pointer dereference, address: 0000000000000018
[ 1559.560177] #PF: supervisor read access in kernel mode
[ 1559.560180] #PF: error_code(0x0000) - not-present page
[ 1559.560182] PGD 80000003886b7067 P4D 80000003886b7067 PUD 3f53af067 PMD 0 
[ 1559.560190] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1559.560196] CPU: 0 PID: 79767 Comm: pmempool Tainted: G           O      5.6.0-rc1-13504-g7b27a8622f80 #1
[ 1559.560199] Hardware name: System manufacturer System Product Name/RAMPAGE IV EXTREME, BIOS 4701 11/18/2013
[ 1559.560207] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]

The steps to reproduce:

$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/char/hw_random/rng-core.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/char/tpm/tpm.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/security/keys/trusted-keys/trusted.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz 
install /usr/bin/ndctl load-keys ; /sbin/modprobe --ignore-install libnvdimm $CMDLINE_OPTS 
No TPM handle discovered.
failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 
modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

$ dmesg | tail
[  102.769871] Key type encrypted registered
[  102.799289] nfit_test_iomap: loading out-of-tree module taints kernel.
[  102.804008] nfit_test: Unknown symbol libnvdimm_test (err -2)
[  102.804054] nfit_test: Unknown symbol acpi_nfit_test (err -2)
[  102.804118] nfit_test: Unknown symbol pmem_test (err -2)
[  102.804164] nfit_test: Unknown symbol dax_pmem_core_test (err -2)
[  102.804226] nfit_test: Unknown symbol dax_pmem_compat_test (err -2)
[  102.804273] nfit_test: Unknown symbol device_dax_test (err -2)
[  102.804308] nfit_test: Unknown symbol dax_pmem_test (err -2)

Removing the wrong modules:

$ sudo rmmod nfit
$ sudo rmmod libnvdimm

Inserting the right modules manually:

$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/libnvdimm.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nd_btt.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nd_pmem.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/dax_pmem_core.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/dax_pmem.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/device_dax.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/dax_pmem_compat.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 

The 'nfit_test' module is successfully inserted with *NO ERRORS* now:

$ dmesg | tail
[  464.439504] nfit_test: mcsafe_test: disabled, skip.
[  464.500439] nfit_test nfit_test.0: failed to evaluate _FIT
[  464.507964] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail restore_fail flush_fail not_armed
[  464.507990] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
[  464.508614] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[  464.508729] pmem6: detected capacity change from 0 to 33554432
[  464.508737] pmem7: detected capacity change from 0 to 4194304

$ lsmod | grep nfit
nfit_test              49152  8
dax_pmem_compat        20480  1 nfit_test
device_dax             20480  2 nfit_test,dax_pmem_compat
dax_pmem               20480  1 nfit_test
dax_pmem_core          20480  3 dax_pmem,nfit_test,dax_pmem_compat
nfit                   73728  1 nfit_test
nd_pmem                24576  1 nfit_test
libnvdimm             200704  8 dax_pmem,nfit_test,dax_pmem_core,nd_btt,nd_pmem,dax_pmem_compat,nd_blk,nfit
nfit_test_iomap        24576  6 nfit_test,dax_pmem_core,device_dax,nd_pmem,libnvdimm,nfit

Trying to remove and reinsert the 'nfit_test' module:

$ sudo ndctl disable-region all
disabled 8 regions

$ sudo modprobe -v -r nfit_test
rmmod nfit_test
rmmod nfit

$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz 
insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 
modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

$ dmesg | tail
[  919.861636] nfit_test: Unknown symbol acpi_nfit_test (err -2)

Removing the wrong module:

$ sudo rmmod nfit

Reinserting manually:

$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/nfit.ko.xz 
$ sudo insmod /lib/modules/5.6.0-rc1-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 

The 'nfit_test' module is successfully inserted with *NO ERRORS* again.

$ lsmod | grep nfit
nfit_test              49152  8
nfit                   73728  1 nfit_test
dax_pmem_compat        20480  1 nfit_test
device_dax             20480  2 nfit_test,dax_pmem_compat
dax_pmem               20480  1 nfit_test
dax_pmem_core          20480  3 dax_pmem,nfit_test,dax_pmem_compat
nd_pmem                24576  1 nfit_test
libnvdimm             200704  8 dax_pmem,nfit_test,dax_pmem_core,nd_btt,nd_pmem,dax_pmem_compat,nd_blk,nfit
nfit_test_iomap        24576  6 nfit_test,dax_pmem_core,device_dax,nd_pmem,libnvdimm,nfit

Run PMDK pmempool_sync tests:

$ cd ~/pmdk/src/test
[~/pmdk/src/test]$ ./RUNTESTS pmempool_sync
pmempool_sync/TEST27: SETUP (check/pmem/debug)
pmempool_sync/TEST27: PASS			[15.603 s]
pmempool_sync/TEST27: SETUP (check/pmem/nondebug)
pmempool_sync/TEST27: PASS			[14.988 s]
pmempool_sync/TEST28: SETUP (check/pmem/debug)
../unittest/unittest.sh: line 866: 79767 Killed                  ../../tools/pmempool/pmempool rm /tmp//test_pmempool_sync28/testset1
pmempool_sync/TEST28 crashed (signal 9).

$ dmesg | tail
[ 1543.234929] EXT4-fs (pmem0): mounted filesystem with ordered data mode. Opts: (null)
[ 1543.234943] ext4 filesystem being mounted at /tmp/test_pmempool_sync27/mnt-pmem supports timestamps until 2038 (0x7fffffff)
[ 1558.910001] nfit_test: mcsafe_test: disabled, skip.
[ 1558.966718] nfit_test nfit_test.0: failed to evaluate _FIT
[ 1558.974772] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail restore_fail flush_fail not_armed
[ 1558.974783] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
[ 1558.975247] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[ 1558.975376] pmem7: detected capacity change from 0 to 4194304
[ 1558.975380] pmem6: detected capacity change from 0 to 33554432
[ 1559.147912] pmem7: detected capacity change from 0 to 4194304
[ 1559.152775] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[ 1559.152852] pmem6: detected capacity change from 0 to 33554432
[ 1559.560169] BUG: kernel NULL pointer dereference, address: 0000000000000018
[ 1559.560177] #PF: supervisor read access in kernel mode
[ 1559.560180] #PF: error_code(0x0000) - not-present page
[ 1559.560182] PGD 80000003886b7067 P4D 80000003886b7067 PUD 3f53af067 PMD 0 
[ 1559.560190] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1559.560196] CPU: 0 PID: 79767 Comm: pmempool Tainted: G           O      5.6.0-rc1-13504-g7b27a8622f80 #1
[ 1559.560199] Hardware name: System manufacturer System Product Name/RAMPAGE IV EXTREME, BIOS 4701 11/18/2013
[ 1559.560207] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]
[ 1559.560211] Code: 37 48 c1 ee 0c 48 01 f0 48 ba ff ff ff ff ff ff 0f 00 49 c1 ef 0c 48 21 d3 49 01 c7 48 c1 e3 06 48 03 1d 58 bf 86 ea 48 89 da <48> 83 7a 18 00 75 10 49 8b 8c 24 f0 00 00 00 48 89 42 20 48 89 4a
[ 1559.560215] RSP: 0000:ffffad85816f7db0 EFLAGS: 00010247
[ 1559.560218] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1559.560220] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff964e4c0eb000
[ 1559.560223] RBP: ffffad85816f7e28 R08: 0005f6e000000000 R09: 0000000000251901
[ 1559.560226] R10: ffff964effffc000 R11: 0000000000033160 R12: ffff964eea06a100
[ 1559.560228] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000001
[ 1559.560232] FS:  00007f6957dfe600(0000) GS:ffff964eefa00000(0000) knlGS:0000000000000000
[ 1559.560235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1559.560237] CR2: 0000000000000018 CR3: 000000039118e004 CR4: 00000000000606f0
[ 1559.560240] Call Trace:
[ 1559.560257]  __do_fault+0x38/0x120
[ 1559.560263]  __handle_mm_fault+0xfe9/0x1570
[ 1559.560269]  ? security_mmap_file+0x7a/0xe0
[ 1559.560277]  handle_mm_fault+0xce/0x200
[ 1559.560284]  do_user_addr_fault+0x1ef/0x470
[ 1559.560293]  page_fault+0x34/0x40
[ 1559.560298] RIP: 0033:0x7f69582d1f5c
[ 1559.560302] Code: c3 48 81 fa 00 08 00 00 77 a1 48 83 fa 40 77 16 f3 0f 7f 07 f3 0f 7f 47 10 f3 0f 7f 44 17 f0 f3 0f 7f 44 17 e0 c3 48 8d 4f 40 <f3> 0f 7f 07 48 83 e1 c0 f3 0f 7f 44 17 f0 f3 0f 7f 47 10 f3 0f 7f
[ 1559.560304] RSP: 002b:00007fffb0512278 EFLAGS: 00010206
[ 1559.560307] RAX: 00007f6955c00000 RBX: 0000000000000000 RCX: 00007f6955c00040
[ 1559.560310] RDX: 0000000000200000 RSI: 0000000000000000 RDI: 00007f6955c00000
[ 1559.560312] RBP: 0000000001e00000 R08: 000000000000000a R09: 0000000000000000
[ 1559.560315] R10: 0000000000000001 R11: 0000000000000206 R12: 000000000000000a
[ 1559.560317] R13: 0000000000000000 R14: 00007f6955c00000 R15: 0000000000000000
[ 1559.560324] Modules linked in: kmem nfit_test(O) nfit(O) nd_blk dax_pmem_compat(O) device_dax(O) dax_pmem(O) dax_pmem_core(O) nd_pmem(O) nd_btt(O) libnvdimm(O) nfit_test_iomap(O) encrypted_keys trusted tpm rng_core uinput rfcomm xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT xt_tcpudp ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bnep sunrpc nls_iso8859_1 nls_cp437 vfat fat dm_mirror dm_region_hash dm_log intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio btus
 b
[ 1559.560377]  snd_hda_intel btrtl crct10dif_pclmul iTCO_wdt btbcm snd_intel_dspcfg iTCO_vendor_support btintel crc32_pclmul ghash_clmulni_intel snd_hda_codec bluetooth aesni_intel snd_hda_core crypto_simd cryptd glue_helper snd_hwdep intel_cstate snd_seq snd_seq_device mousedev snd_pcm input_leds eeepc_wmi intel_uncore asus_wmi joydev battery ecdh_generic intel_rapl_perf sparse_keymap wmi_bmof pcspkr i2c_i801 lpc_ich ecc snd_timer mei_me snd mei soundcore evdev mac_hid ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 rfkill hid_generic usbhid hid sr_mod cdrom sd_mod nouveau i2c_algo_bit drm_kms_helper mxm_wmi syscopyarea sysfillrect sysimgblt ahci fb_sys_fops cec libahci ttm libata crc32c_intel drm xhci_pci scsi_mod e1000e xhci_hcd ehci_pci ehci_hcd agpgart wmi dm_mod fuse [last unloaded: nfit]
[ 1559.560435] CR2: 0000000000000018
[ 1559.560439] ---[ end trace b60c468cd995d984 ]---
[ 1559.560446] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]
[ 1559.560450] Code: 37 48 c1 ee 0c 48 01 f0 48 ba ff ff ff ff ff ff 0f 00 49 c1 ef 0c 48 21 d3 49 01 c7 48 c1 e3 06 48 03 1d 58 bf 86 ea 48 89 da <48> 83 7a 18 00 75 10 49 8b 8c 24 f0 00 00 00 48 89 42 20 48 89 4a
[ 1559.560453] RSP: 0000:ffffad85816f7db0 EFLAGS: 00010247
[ 1559.560456] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 1559.560458] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff964e4c0eb000
[ 1559.560461] RBP: ffffad85816f7e28 R08: 0005f6e000000000 R09: 0000000000251901
[ 1559.560463] R10: ffff964effffc000 R11: 0000000000033160 R12: ffff964eea06a100
[ 1559.560466] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000001
[ 1559.560469] FS:  00007f6957dfe600(0000) GS:ffff964eefa00000(0000) knlGS:0000000000000000
[ 1559.560472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1559.560475] CR2: 0000000000000018 CR3: 000000039118e004 CR4: 00000000000606f0

$ $ ps aux | grep -e 'D+' | grep -v grep
root       80616  0.0  0.0   7240  4020 pts/2    D+   09:44   0:00 ndctl disable-region all
root       81004  0.0  0.0   7240  2112 pts/2    D+   09:47   0:00 ndctl disable-region all
ldorau     81291  0.0  0.0  34572  5676 pts/2    D+   09:50   0:00 ../../tools/pmempool/pmempool create obj --layout pmempool /tmp//test_pmempool_sync32/testset1

$ sudo cat /proc/80616/stack
[<0>] __synchronize_srcu.part.0+0x78/0xa0
[<0>] kill_dax+0x22/0x70
[<0>] pmem_release_disk+0x12/0x40 [nd_pmem]
[<0>] release_nodes+0x19c/0x1e0
[<0>] device_release_driver_internal+0xf4/0x1c0
[<0>] unbind_store+0xef/0x120
[<0>] kernfs_fop_write+0xce/0x1b0
[<0>] vfs_write+0xb6/0x1a0
[<0>] ksys_write+0x5f/0xe0
[<0>] do_syscall_64+0x4e/0x150
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ sudo cat /proc/81004/stack
[<0>] flush_namespaces+0x15/0x30 [libnvdimm]
[<0>] device_for_each_child+0x58/0x90
[<0>] flush_regions_dimms+0x33/0x40 [libnvdimm]
[<0>] device_for_each_child+0x58/0x90
[<0>] wait_probe_show+0x3d/0x60 [libnvdimm]
[<0>] dev_attr_show+0x19/0x40
[<0>] sysfs_kf_seq_show+0x9b/0xf0
[<0>] seq_read+0xcd/0x440
[<0>] vfs_read+0x9d/0x150
[<0>] ksys_read+0x5f/0xe0
[<0>] do_syscall_64+0x4e/0x150
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ sudo cat /proc/81291/stack
[<0>] flush_namespaces+0x15/0x30 [libnvdimm]
[<0>] device_for_each_child+0x58/0x90
[<0>] flush_regions_dimms+0x33/0x40 [libnvdimm]
[<0>] device_for_each_child+0x58/0x90
[<0>] wait_probe_show+0x3d/0x60 [libnvdimm]
[<0>] dev_attr_show+0x19/0x40
[<0>] sysfs_kf_seq_show+0x9b/0xf0
[<0>] seq_read+0xcd/0x440
[<0>] vfs_read+0x9d/0x150
[<0>] ksys_read+0x5f/0xe0
[<0>] do_syscall_64+0x4e/0x150
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

--
Lukasz

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
