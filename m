Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74E12DF08
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jan 2020 14:36:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AACB610097F2C;
	Wed,  1 Jan 2020 05:39:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D1F110097F01
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jan 2020 05:39:33 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 05:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600";
   d="scan'208";a="231577057"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga002.jf.intel.com with ESMTP; 01 Jan 2020 05:36:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jan 2020 05:36:13 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Jan 2020 05:36:13 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Jan 2020 05:36:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Jan 2020 05:36:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwIh7vzGyJ5p10czs5lxN2sBhuWQIXE6whyqAidyeiOpSDtmQoFRCmVMglgSZeu19ojbXG3vE44tY6+/HfAc1ctlT/Fvaio2sLrR5uoInhAcQIMGT2eREVvgysAvhcxb5EdM2TWFsQM+YcXPDpEM9Lv6JhdDAFHs68Lrw8x/zHhpiZ4WF+Fg5ciX/QJo7sqaSCcoz0LQTbJC1AMBDlnD92Z5h89XzyXDincnDyHgUoQq7EHd47aAl6zTn0OHqVwSyPYSN3AfAzNL+GWB7Z+HVWuTgIkMRtF9xk39rNG7UpOXfSppcltaieYNBJj+pOC3OMbeNy1b0lAQMSvpT5HZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUb9Q9Xx7XASkX/iztEft4EZori+jfDanaj2YqqiERo=;
 b=JXcbcuIgQZ0/Bx+HDDZv9o/+8v6EE27aqPo9VlOhBH+ybDbh79kV75hy3e9YA5ZiHXYV4yHnNWgCodPr2ll9zUifbrv01lnrVEKcYI9cBX+7A4Gi+CL9SWMtRqeeJSh/Kd7v+jz7PAV/rD3PwvgRtdTzWRSikoGvTlCZ2ZR7F17JtafDYTTSDgbfdLow5VD31A7MkBvaEt0/g2dQq4oGvpAORxEkjtylkAK+MQBFYl+U2BJkRokcMstEhOJcHEff8talTb7xkrCWgeoEG8iBgSYz1OWXMgY06jmus3fCHmWlBcWD85mYSoUu7sFeCMiNDHFy/th3mAHngBMkVxquTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUb9Q9Xx7XASkX/iztEft4EZori+jfDanaj2YqqiERo=;
 b=AxxDkxIwx+pTNuxmp5Yfu6xu3g+xh+bdPRjk1TzyDSEDMlpLX9iojp9TPuC2xI1DjOVUIgYOyjvYXaNvQ6hb/BXrKj0LXiAowKjIvR3qcf0MM4xKglZ+JhtQNDNiLG3c/RrG0VxT3Sl9swgIdHCZsLpdv8LIUYdCb7T3IbwWHOQ=
Received: from SN6PR11MB3264.namprd11.prod.outlook.com (52.135.111.80) by
 SN6PR11MB2864.namprd11.prod.outlook.com (52.135.97.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 1 Jan 2020 13:36:11 +0000
Received: from SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c]) by SN6PR11MB3264.namprd11.prod.outlook.com
 ([fe80::78f3:73f9:eaff:d25c%7]) with mapi id 15.20.2581.007; Wed, 1 Jan 2020
 13:36:10 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Topic: [PATCH] daxctl: Change region input type from INTEGER to STRING.
Thread-Index: AdWqSy7tSheIw9IbRFeymChi7Sx2XP//fIUA/99j/4CAQ1rRAP//ul5A//9ohUD//saYwP/8kCQA//bGW3D/6mQogP/RJpaQ
Date: Wed, 1 Jan 2020 13:36:10 +0000
Message-ID: <SN6PR11MB326460D023E14E878619690092210@SN6PR11MB3264.namprd11.prod.outlook.com>
References: <2369E669066F8E42A79A3DF0E43B9E643AC9EB31@pgsmsx114.gar.corp.intel.com>
 <CAPcyv4jTS+JcmH=Oe3Js0dw+Ovu+P6yBKHDZp8xxUT6Rbhpaqw@mail.gmail.com>
 <SN6PR11MB3264D981A619065F1A4EFFB992280@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iP1NK=2funtr6yp9VhedntKvzkvBsXDkLLXt6FBZYO=A@mail.gmail.com>
 <SN6PR11MB3264C140FEB5C66679095AFF922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB3264617D4EA3C3C4706C7C6D922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <SN6PR11MB32647968C27C92C1D3A5B7D8922B0@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4iU2xt9L1U7JXLoM1ex__KFHQ--6wdJeD2RNz6yfb87OQ@mail.gmail.com>
 <SN6PR11MB32643D4FCE4E828182CB78AF92240@SN6PR11MB3264.namprd11.prod.outlook.com>
 <CAPcyv4jEEKjpc8_Y0EBFH=4uHcTGGVpnSEOt425ARdTY3nuMqQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jEEKjpc8_Y0EBFH=4uHcTGGVpnSEOt425ARdTY3nuMqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjk0ODRiMmItMDNkNC00OWY3LTllZDMtNmRlODU0N2UxNzRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQzdUYTRzY0Q4bWM3R2xMOEY2XC9ta3daMkxCYzh2RFJjZitNbVUyMnc2SWFiWElScjlHalV6aDJ0Wlwvb2wrbCtqIn0=
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=redhairer.li@intel.com;
x-originating-ip: [192.198.147.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffddb1d4-34b6-4270-bd4d-08d78ebf9062
x-ms-traffictypediagnostic: SN6PR11MB2864:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2864995F3F311E984E82E5AA92210@SN6PR11MB2864.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(366004)(136003)(13464003)(189003)(199004)(8936002)(5660300002)(52536014)(6636002)(66446008)(66946007)(66556008)(64756008)(26005)(76116006)(66476007)(186003)(55016002)(6862004)(33656002)(4326008)(53546011)(2906002)(9686003)(6506007)(81156014)(81166006)(86362001)(71200400001)(316002)(7696005)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2864;H:SN6PR11MB3264.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2oI9iyljmkNab9jVRFU4xygWg25GRcR0WvFFLwUr81fh1FQ9QYzhsYtnmHnn6rt4xbgODoLpxG2wF79m/k5dGuWqbHdsbmC2D2eeWkfLosfeTwsZx1QSQlETtGBtazcELPOhFjUPaRDizuHvyC3JzwZBTMnywVnzVXobo9vNNG1V5fCyD4C8vFUiPEiyihUPHWBS5VO3O9acRDLlYxSx5mtDasAD7JU9shLYa/qCbFRTBJrAJUOads7ZedJ8boI2Py30NeMLrkYg81miAfRR7fm55DTs3MXQtJQsmXpohsX8nwqZt3hw4GQuDA+T93yYxutYLUxPr0v/WeGHpxo7u+1VroiXlQ2+YJAPnM/TXOdnQsKt8VPWsxdHaaI7QdWsvobQWbW4u5Wj7ALlWXypt2rZvsQ50G3+Ynwrm/wPXGVANyYuEnAw7Oyot/igwX7Svauqm6rKRRSi82Uv0k62XHFhOIebYu9nZNaC3DGDl+xsEc03v/bm8Gx+7IKXC8m
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ffddb1d4-34b6-4270-bd4d-08d78ebf9062
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 13:36:10.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9DBZdoUbjIptMNJosBBqR7oykUUjD6WrkhGcvCyvUkTaUJDdq9ehPVqMO6Xrd0n7J3vexFJzeMrZ1Gjh/RIJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2864
X-OriginatorOrg: intel.com
Message-ID-Hash: 2ADE6B52BPLWOB5SM35BJXARFW2OZL65
X-Message-ID-Hash: 2ADE6B52BPLWOB5SM35BJXARFW2OZL65
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ADE6B52BPLWOB5SM35BJXARFW2OZL65/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 2.  2 nvdimm will make daxctl-devices.sh FAIL

Do you mean a system with real nvdimms makes daxctl-devices.sh fail?
=>
No, I mean daxctl-devices.sh FAIL happen if I have mem1(nv1) and mem2(nv2) with following cmd.
If ONLY have mem1(nv1), daxctl-devices.sh will PASS.

qemu-system-x86_64 /root/vm/ubuntu-red_ndctltest_VM.img \
-m 16G,slots=4,maxmem=512G \
-smp 40 \
-machine pc,accel=kvm,nvdimm=on \
-enable-kvm \
-cpu kvm64 \
-object memory-backend-file,id=mem1,share,mem-path=/root/vm/tmp/nvdimm0,size=2G \
-device nvdimm,memdev=mem1,id=nv1,label-size=2M \
-object memory-backend-file,id=mem2,share,mem-path=/root/vm/tmp/nvdimm1,size=2G \
-device nvdimm,memdev=mem2,id=nv2,label-size=2M \
-numa node,mem=4G,cpus=0-19,nodeid=0 \
-numa node,mem=4G,cpus=20-39,nodeid=1 \
-numa node,mem=4G,nodeid=2 \
-numa node,mem=4G,nodeid=3 \

-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Monday, December 30, 2019 2:03 PM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm@lists.01.org
Subject: Re: [PATCH] daxctl: Change region input type from INTEGER to STRING.

On Sat, Dec 28, 2019 at 11:54 PM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> OK, got it.
> I have figured out the problem.
> I pass wrong parameter to util_daxctl_region_filter.
>
> But I found two other problems before I apply my patch.
>
> 1. DAX device already online after reconfigure it to system-ram.
>
> "$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
>
> If daxctl-device.sh do online-memory again, it makes FAIL 
> daxctl-devices.sh (exit status: 1) even I add --no-online when 
> reconfigure-device
>
> + ../daxctl/daxctl reconfigure-device -N -m system-ram --no-online 
> + dax0.0
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine 
> phys_index: Success reconfigured 1 device [
>   {
>     "chardev":"dax0.0",
>     "size":262144000,
>     "target_node":0,
>     "mode":"system-ram",
>     "movable":false
>   }
> ]
> ++ daxctl_get_mode dax0.0
> ++ ../daxctl/daxctl list -d dax0.0
> ++ jq -er '.[].mode'
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine 
> phys_index: Success
> + [[ system-ram == \s\y\s\t\e\m\-\r\a\m ]] ../daxctl/daxctl 
> + online-memory dax0.0
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine 
> phys_index: Success
> libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine 
> phys_index: Success
> dax0.0:
>   WARNING: detected a race while onlining memory
>   Some memory may not be in the expected zone. It is
>   recommended to disable any other onlining mechanisms,
>   and retry. If onlining is to be left to other agents,
>   use the --no-online option to suppress this warning

This is likely because Ubuntu ships a udev rule that automatically onlines hot-added memory. We've talked about a way to auto-detect when a distribution ships a udev configuration like this, but for now this warning message is the best we can do.

[..]>
> 2.  2 nvdimm will make daxctl-devices.sh FAIL

Do you mean a system with real nvdimms makes daxctl-devices.sh fail?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
