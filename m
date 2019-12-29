Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B670812C100
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Dec 2019 08:54:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE38810097F30;
	Sat, 28 Dec 2019 23:57:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B3BF10097F2D
	for <linux-nvdimm@lists.01.org>; Sat, 28 Dec 2019 23:57:47 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2019 23:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,370,1571727600";
   d="scan'208";a="215115651"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 28 Dec 2019 23:54:26 -0800
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Dec 2019 23:54:26 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Dec 2019 23:54:26 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 28 Dec 2019 23:54:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg1UtUa6ImlFvmjIVLp5qIxvBJk9ciVSF5vxJm0E9wEwxYdvsALCkz2xVaA8JeBoz9sSfM6WLQ1YYwARRM/cZEZua+yEFG4N4yig2A8MSTiYzNmAJz5rfDvtjhR4+WQrj0aCk0iZuq2wOvz00BMRWALsitmCTmp8deEiSkQAF52xNynDmq68eG+mltuoyuMNUeIPng9CbahlJyqsV2Gwebjd1S8RA4+kygqCNLs+msUiWpRswqKLHI9Pe+AfcQ83NlRyBWEV4hBVbHvRbpYkFSYLMHeGzflG5rgwW2hqkGtG7HUTETIJLTEuej2ccTHJKPU8hidUq6sywzQHXD+hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hihvft/lTDYyhM9lngSMM5a9fKcavWb7tipbQ5C7qVI=;
 b=auMtLrVLcuhs14OCS7fH8mu6adX/6v04MqNEEMASBGD5fOz4ohGqOGXv9yyhn4KRFkMA7i/EdrvQjVZO83cJVkioCTcRMyYi7+QB7GTFnmisjqU2h0iJTDozIUwrZ0XAYy0A+dJMnCWCODXrCC+CkFv4Ir5Txn0nngwnZhpGzVKQ772+wi9fV23G/xE/0iEfxySIa6YNaKWAFo0G9IBhJXhKk2Z0J8c1i7MP3Bl+ebBQ7xPgJKzuxw6yLdKtmhzvd3IOB7S+Lortg9OeDevS69TumvkzlcWUFiW7Al1Y2evdAP/1cz1K7cQ0KyGLXRXT/KEiA4SD0ObIN0OoPXxo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hihvft/lTDYyhM9lngSMM5a9fKcavWb7tipbQ5C7qVI=;
 b=qA16MZq1J0bc5wiDCGOQ/XntxIwRR9QGSq5zvbOXMvAJQ4g/AXWsVfCbAWn+j4aLHeI1weW8k4NVfoi4ROZd2c+dWFDw8eeykCyU5pjxe0RTzgPDHUSqR/ipbWo7xA/+4PDD5DPMzKWwQua7k+rQK/D4oGFy78G2xQHPJbFLhoU=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB3071.namprd11.prod.outlook.com (52.135.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Sun, 29 Dec 2019 07:54:11 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019
 07:54:11 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A//9ohUD//saYwP/8kCQA//bGW3A=
Date: Sun, 29 Dec 2019 07:54:10 +0000
Message-ID: <SN6PR11MB32643D4FCE4E828182CB78AF92240@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iU2xt9L1U7JXLoM1ex__KFHQ--6wdJeD2RNz6yfb87OQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iU2xt9L1U7JXLoM1ex__KFHQ--6wdJeD2RNz6yfb87OQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTU4OGE5NmEtYjQ1Yy00NmM3LTg4N2EtZmRkZGU0NjBmMDU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVGU3OXQ3MURqYVpLNjk0TjVcLzZBTDMyeFpjaUdmZGR1bzZLbDBsUFZlazJtcFFLUFhuMnFqa2NhOEVxSkZOUWIifQ==
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [36.230.42.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 369f67eb-0d43-4190-8998-08d78c344a6e
x-ms-traffictypediagnostic: SN6PR11MB3071:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3071A334EF30B0F14717F97792240@SN6PR11MB3071.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:192;
x-forefront-prvs: 0266491E90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(13464003)(20264003)(81156014)(81166006)(53546011)(5660300002)(8676002)(4326008)(6862004)(6506007)(6636002)(52536014)(7696005)(478600001)(8936002)(26005)(186003)(66556008)(64756008)(66476007)(66446008)(66946007)(33656002)(55016002)(316002)(76116006)(9686003)(71200400001)(86362001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3071;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFVQ9v3BkECpvEPcwXl/wa+qXqbpmOi5V3PLiysrBDMtQy97UlNFZN3eYx5Bo8Oof4CnAX53HkDIzh55a05DEOjcxBZ23Yk8INpytXq0tnFpiegekSjdmw2S4gqDrEshzpmxMK4qQZmTMnZORoblBAVc70PoBkC59458WYl9kWm5LCZpirJtoY2QQACt1y25r2i7QqXO3pGZaLQMBWFtjpec3q0IPCpcws5hdavi3wGOPjnoXIEbrvXN1DqsI6r01ehF347DLfOYftp14bZaJpgDE4eeXKt5WfycFbMS3TN36TEptSekMVLa0fT3yqgp9YbM97XBK04uY3YLsPfu9XkTCJ748Dkxs14bjFt6SQmI/8EifitAHhTqHPlr0e5UAA0zd3YG77ZpnVplp8Jbds+8Yk5p8EaWtSGomCmFG3ztj3UkGtWiXmUsz20TvpZU03EqZ1RB7W0e1SPPhvvb9ZwYANGifGBqlo9NKQxXiXBkmUtJeeEYK8ru/pdv5AnCqiK5MTc8c8zUxT1vO9/o5w==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 369f67eb-0d43-4190-8998-08d78c344a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2019 07:54:10.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gl68x15UY2j9l66CqST97rmh+ofFSZttW5sgvqhuaHSCWObUavgNfhMpbL2Y6HxijttyjkArG4bGAmATjPeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3071
X-OriginatorOrg: intel.com
Message-ID-Hash: 26G5SFV5HNSIFRPXVNZTUUGC7IXMYJ2Q
X-Message-ID-Hash: 26G5SFV5HNSIFRPXVNZTUUGC7IXMYJ2Q
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/26G5SFV5HNSIFRPXVNZTUUGC7IXMYJ2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

OK, got it.
I have figured out the problem.
I pass wrong parameter to util_daxctl_region_filter.

But I found two other problems before I apply my patch.

1. DAX device already online after reconfigure it to system-ram.

"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"

If daxctl-device.sh do online-memory again,
it makes FAIL daxctl-devices.sh (exit status: 1) even I add --no-online when reconfigure-device

+ ../daxctl/daxctl reconfigure-device -N -m system-ram --no-online dax0.0
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
reconfigured 1 device
[
  {
    "chardev":"dax0.0",
    "size":262144000,
    "target_node":0,
    "mode":"system-ram",
    "movable":false
  }
]
++ daxctl_get_mode dax0.0
++ ../daxctl/daxctl list -d dax0.0
++ jq -er '.[].mode'
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
+ [[ system-ram == \s\y\s\t\e\m\-\r\a\m ]]
+ ../daxctl/daxctl online-memory dax0.0
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
dax0.0:
  WARNING: detected a race while onlining memory
  Some memory may not be in the expected zone. It is
  recommended to disable any other onlining mechanisms,
  and retry. If onlining is to be left to other agents,
  use the --no-online option to suppress this warning
dax0.0: all memory sections (1) already online
onlined memory for 0 devices
++ cleanup 76
++ printf 'Error at line %d\n' 76
Error at line 76
++ [[ -n namespace0.0 ]]
++ reset_dev
++ ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace0.0
libndctl: ndctl_namespace_enable: namespace0.0: failed to enable
destroyed 1 namespace
++ exit 1
FAIL daxctl-devices.sh (exit status: 1)


2.  2 nvdimm will make daxctl-devices.sh FAIL
+ testbus=ACPI.NFIT
++ ../ndctl/ndctl list -b ACPI.NFIT -Ni
++ jq -er '.[0].dev | .//""'
+ testdev=namespace1.0
+ [[ ! -n namespace1.0 ]]
+ printf 'Found victim dev: %s on bus: %s\n' namespace1.0 ACPI.NFIT
Found victim dev: namespace1.0 on bus: ACPI.NFIT
+ setup_dev
+ test -n ACPI.NFIT
+ test -n namespace1.0
+ ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace1.0
destroyed 1 namespace
++ ../ndctl/ndctl create-namespace -b ACPI.NFIT -m devdax -fe namespace1.0 -s 256M
++ jq -er .dev
+ testdev=namespace1.0
+ test -n namespace1.0
+ rc=1
+ daxctl_test
+ local daxdev
++ daxctl_get_dev namespace1.0
++ ../ndctl/ndctl list -n namespace1.0 -X
++ jq -er '.[].daxregion.devices[0].chardev'
+ daxdev=dax1.0
+ test -n dax1.0
+ ../daxctl/daxctl reconfigure-device -N -m system-ram dax1.0
libdaxctl: daxctl_dev_enable: dax1.0: failed to enable
error reconfiguring devices: No such device
reconfigured 0 devices
++ cleanup 74
++ printf 'Error at line %d\n' 74
Error at line 74
++ [[ -n namespace1.0 ]]
++ reset_dev
++ ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace1.0
destroyed 1 namespace
++ exit 1
FAIL daxctl-devices.sh (exit status: 1)

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Friday, December 27, 2019 1:54 AM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

The way to fix this is mentioned in the log, see below...

On Wed, Dec 25, 2019 at 8:01 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> I saw daxctl-devices.sh is still failed before I apply my patch.
>
> root@ubuntu-red:~/git/ndctl# vi test/test-suite.log 
> =========================================
>    ndctl 67.dirty: test/test-suite.log 
> =========================================
>
> # TOTAL: 1
> # PASS:  0
> # SKIP:  0
> # XFAIL: 0
> # FAIL:  1
> # XPASS: 0
> # ERROR: 0
>
> .. contents:: :depth: 2
>
> FAIL: daxctl-devices.sh
> =======================
>
> + rc=77
> + . ./common
> ++ '[' -f ../ndctl/ndctl ']'
> ++ '[' -x ../ndctl/ndctl ']'
> ++ export NDCTL=../ndctl/ndctl
> ++ NDCTL=../ndctl/ndctl
> ++ '[' -f ../daxctl/daxctl ']'
> ++ '[' -x ../daxctl/daxctl ']'
> ++ export DAXCTL=../daxctl/daxctl
> ++ DAXCTL=../daxctl/daxctl
> ++ NFIT_TEST_BUS0=nfit_test.0
> ++ NFIT_TEST_BUS1=nfit_test.1
> ++ ACPI_BUS=ACPI.NFIT
> ++ E820_BUS=e820
> + trap 'cleanup $LINENO' ERR
> + find_testdev
> + local rc=77
> + modinfo kmem
> filename:       /lib/modules/5.4.0-rc5_red_ndctltest_VM/kernel/drivers/dax/kmem.ko
> alias:          dax:t0*
> license:        GPL v2
> author:         Intel Corporation
> srcversion:     A0712EA9D9E63723E6B4CDA
> depends:
> retpoline:      Y
> intree:         Y
> name:           kmem
> vermagic:       5.4.0-rc5_red_ndctltest_VM SMP mod_unload
> signat:         PKCS#7
> signer:
> sig_key:
> sig_hashalgo:   md4
> + testbus=ACPI.NFIT
> ++ ../ndctl/ndctl list -b ACPI.NFIT -Ni jq -er '.[0].dev | .//""'
> + testdev=namespace0.0
> + [[ ! -n namespace0.0 ]]
> + printf 'Found victim dev: %s on bus: %s\n' namespace0.0 ACPI.NFIT
> Found victim dev: namespace0.0 on bus: ACPI.NFIT
> + setup_dev
> + test -n ACPI.NFIT
> + test -n namespace0.0
> + ../ndctl/ndctl destroy-namespace -f -b ACPI.NFIT namespace0.0
> destroyed 1 namespace
> ++ ../ndctl/ndctl create-namespace -b ACPI.NFIT -m devdax -fe 
> ++ namespace0.0 -s 256M jq -er .dev
> + testdev=namespace0.0
> + test -n namespace0.0
> + rc=1
> + daxctl_test
> + local daxdev
> ++ daxctl_get_dev namespace0.0
> ++ ../ndctl/ndctl list -n namespace0.0 -X jq -er 
> ++ '.[].daxregion.devices[0].chardev'
> + daxdev=dax0.0
> + test -n dax0.0
> + ../daxctl/daxctl reconfigure-device -N -m system-ram dax0.0
> libdaxctl: daxctl_dev_disable: dax0.0: error: device model is 
> dax-class
> libdaxctl: daxctl_dev_disable: dax0.0: see man 
> daxctl-migrate-device-model

If you run:

    daxctl migrate-device-model

...and reboot the test should start working. The explanation for why this migrate-device-model step is needed is detailed in the man page.

    daxctl migrate-device-model --help
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
