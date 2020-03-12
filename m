Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E518334F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 15:38:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A69110FC3785;
	Thu, 12 Mar 2020 07:39:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42C2610FC3784
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 07:39:32 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400";
   d="scan'208";a="443950874"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2020 07:38:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 07:38:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 07:38:25 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 07:38:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 07:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX0/cMXs/a0Krh6THdShXUuBljjFch+VmpzN00STzgRnusaOUZDZpSJPVpzjnHsIAYlJw6a4ihNKLgZpa5UM4PobRfsu+KTI8MuBQkMimPumqSp+UkDIB615uomZsidfWf3FwW0DPutqLMBjbwKiiFJQ9SGMGuEJ4qtTFAGZqdpWCZz5Sh3J6OkcQI7hQmqy7e9c4GEUSNB24M7iLXLqxB4MO3VwE/vWUt/5uOIg7rW9mpNoKeDiXw/tG1oDEZ3WgErmCuu90uzlxeWDA8yYeLRKCxlRx/MwqAbpUJI7KIBVgiiBS9e8OZ9FlgYYU9G2pI2hiGZFvNZdkJrOAUlYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL3BQQDOmeAZ4uxVAqICF0APk/JOJ2UML4TZ86JvTGo=;
 b=nY9tffB8UN+fcZ39MslEZXeiqZsc71BVkxOAoSs5GGAeBv+FT1DKIW8DVVeOjMvmwRQnUDoN8V/UdfUJynCWGzo2TRpN5piFQFaMas7JNFND3uD6/4sW/m/Y2fGcpU5XQt3EhO+JvIFI8mnb2mnehBLUWLJhMGmWs24GFLqUr627Xt+b2XQa0AsQj5IcODHAkAlAGjeb9gf4bNhsxO0lT9dIq8WiXxDv6fSPGSwE4yU+gUPSTp0w1fz/MUHUAG6MC6HMN40Bkg4eoRJQ0j3IApTAWXAGbAGn6s0OE52b9MZvsT9cx9FdM16tw/+6FBl478VW5Q7P/wcSNEKYTSNjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL3BQQDOmeAZ4uxVAqICF0APk/JOJ2UML4TZ86JvTGo=;
 b=JxcNu7IHG83LC66h9jyxSQpk/Zf/YGNJuHR3zjiAfh11NVADRC62N/KSqJcaGIU0oXCYcTEb/HMphbfwzQIrE2hEmAMZQgujUCft/Jpbh77DDNUrYk1A3fu/3IRf6QFjF6EWutdgsITFeTwriyS6Lcq5MuuEMMHA1QyF5XQlrIA=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB2990.namprd11.prod.outlook.com (2603:10b6:805:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 14:38:21 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 14:38:21 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: nfit_test: issue #2: modprobe: ERROR: could not insert 'nfit_test':
 Unknown symbol in module, or unknown parameter
Thread-Topic: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
Thread-Index: AdX4eeu8S4UKpcXxQVyul9RQ8BWIzA==
Date: Thu, 12 Mar 2020 14:38:21 +0000
Message-ID: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6e3af14f-756c-4e2f-c2ca-08d7c6930383
x-ms-traffictypediagnostic: SN6PR11MB2990:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB299006199B8E290B4040AF5896FD0@SN6PR11MB2990.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(7696005)(54906003)(52536014)(2906002)(186003)(6916009)(107886003)(6506007)(71200400001)(66946007)(478600001)(64756008)(86362001)(66476007)(66446008)(66556008)(76116006)(5660300002)(4326008)(26005)(316002)(8936002)(8676002)(33656002)(55016002)(9686003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2990;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8Cc/WaIxadyJ8MQ0xgiuNjGK+5Qazf4Qn+uwoGZCgVaJm2Eh8Az/kmTFl1rCMkZ0raYBWYm1kT9BZ7kAt8PNjJGMIZVT5xctgn8Tr2g+TTMz4vzgub8dIc8e1BYDnzM73Ak3AVdrB+2LR+X5Mdn2oMKpi93V1Pul1F/MB0eQkRwI12436V+FwqF2NNySRANTJoMi/C0gJ4bfll0Pgy3yzEOyENLRQrRNFTFEYudDbQsIoC/JznQ4/7pl4JktVD7QCFa4WLEodzLUeIBTdbO5pI9pnnjXxucX6t5/H/JdAOaiWTKCJ59ODnke91XnwO2ENep/M3d0udfNUFwAinrVB15J2I4gYcmUr3Pewd0P+FOdcVvPZqyup9O91f36fUVcKXeC0EkupkFzHbZYcclTqI8aEyQwwDJGQ4clS+o3V+Ds6OZmtM9GHElpEqLlGbT
x-ms-exchange-antispam-messagedata: 6zK5oZ5Ndp/nqR53z4nfaM2wJrbQQnz1l0+0sP4CHaCSMyh1exuTX7cHSSASLE+AqguH98WkKCGJNbew+vXXKTDSiu2c3H451q0d/0gC9xGlWp9s3ZUbX1szMYuhk3xaLqkLhRdaGiy5zU2yzGRH3Q==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3af14f-756c-4e2f-c2ca-08d7c6930383
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 14:38:21.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/U3ZiKpN1MXN6XWe7ABQGOxPOpRIia4ooFWOCYpK3Wu3cZGAhUElaWWiPZArkXThrhiwjQ/h/IPoMj3M2Am5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2990
X-OriginatorOrg: intel.com
Message-ID-Hash: QDFPRM5C3UQJKPQ6OKA6PO57Z55S67RF
X-Message-ID-Hash: QDFPRM5C3UQJKPQ6OKA6PO57Z55S67RF
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QDFPRM5C3UQJKPQ6OKA6PO57Z55S67RF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi,

Inserting the 'nfit_test' module in a natural way fails with the following error:

$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/char/hw_random/rng-core.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/char/tpm/tpm.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/security/keys/trusted-keys/trusted.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/security/keys/encrypted-keys/encrypted-keys.ko.xz 
install /usr/bin/ndctl load-keys ; /sbin/modprobe --ignore-install libnvdimm $CMDLINE_OPTS 
No TPM handle discovered.
failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 
modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

$ dmesg | tail
[  659.295461] Key type encrypted registered
[  659.337971] nfit_test: Unknown symbol libnvdimm_test (err -2)
[  659.337997] nfit_test: Unknown symbol acpi_nfit_test (err -2)
[  659.338035] nfit_test: Unknown symbol pmem_test (err -2)
[  659.338061] nfit_test: Unknown symbol dax_pmem_core_test (err -2)
[  659.338097] nfit_test: Unknown symbol dax_pmem_compat_test (err -2)
[  659.338125] nfit_test: Unknown symbol device_dax_test (err -2)
[  659.338144] nfit_test: Unknown symbol dax_pmem_test (err -2)

It is because the standard versions of the 'libnvdimm' and 'nfit' modules were inserted instead of the mocked ones from the 'extra' subdirectory as you can see above and below:

$ sudo modinfo nfit | grep -e filename
filename:       /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz
$ sudo modinfo libnvdimm | grep -e filename
filename:       /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/nvdimm/libnvdimm.ko.xz

There is a workaround - it can be done manually in the following way....

$ sudo rmmod nfit
$ sudo rmmod libnvdimm

Only /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test_iomap.ko.xz is inserted now.

$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/libnvdimm.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/nd_btt.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/nd_pmem.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/nfit.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/dax_pmem_core.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/dax_pmem.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/device_dax.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/dax_pmem_compat.ko.xz
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz

$ dmesg | tail
[ 1214.908974] nfit_test: mcsafe_test: disabled, skip.
[ 1214.968913] nfit_test nfit_test.0: failed to evaluate _FIT
[ 1214.976728] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail restore_fail flush_fail not_armed
[ 1214.976740] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
[ 1214.977745] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[ 1214.977906] pmem6: detected capacity change from 0 to 33554432
[ 1214.977915] pmem7: detected capacity change from 0 to 4194304

Let's try to remove the 'nfit_test' module:

$ sudo ndctl disable-region all
disabled 8 regions

$ sudo modprobe -v -r nfit_test
rmmod nfit_test
rmmod nfit

... and insert it again:

$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/kernel/drivers/acpi/nfit/nfit.ko.xz 
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 
modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter (see dmesg)

$ dmesg | tail
[ 1486.193503] nfit_test: Unknown symbol acpi_nfit_test (err -2)

And now the wrong version of the 'nfit' module was inserted ... 
The only way is to do it  manualy again:

$ sudo rmmod -v nfit 
$ sudo insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/nfit.ko.xz
$ sudo modprobe -v nfit_test
insmod /lib/modules/5.6.0-rc1-bb-13504-g7b27a8622f80/extra/test/nfit_test.ko.xz 

Does anyone know how it can be fixed? Any suggestions?

--
Lukasz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
