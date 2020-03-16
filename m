Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CDF1866C0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Mar 2020 09:41:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45C911007B1C9;
	Mon, 16 Mar 2020 01:42:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B913E10097DC6
	for <linux-nvdimm@lists.01.org>; Mon, 16 Mar 2020 01:42:29 -0700 (PDT)
IronPort-SDR: vnlHfoINCCG1QSBquTHdHWtf/QIZga9rUOtXIVLC/RcbKsRSRgGIK5fJOV/Nyc7TKOy1gHKt3h
 KuKNF0Eps1Tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 01:41:38 -0700
IronPort-SDR: m0oaRbjKNdBvfPfWpKpO9ymxy44eqeo+f1rHkXBa+SmCCdRTVSqxQbAAVK24c16qta8Bjau9Kb
 9nFoINrQqq/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400";
   d="scan'208";a="237894534"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2020 01:41:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Mar 2020 01:41:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Mar 2020 01:41:37 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Mar 2020 01:41:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Mar 2020 01:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IylPO0J09My5pg/OVWZcdLiwzVTMF8BqR/Ws74CdtIi4XfyuQYPybmrXEApst64BgkzwdfrtAs9PO9fdJmAEH4FJP/ZbEW/gLT8GQPqEMjkAOsrm8coFweM4jcKN3fswwNdInAFTXfMRVIY9pGg4pTL+cPvr47NL0N1o7uaa6jzLXw45izNfh4WglbB4TamnbrNCO0T8wH25VpZJYLc3ggsZ46U0pxXwipFdYPoJ1WolX03hy6mV4Kkw82QxIHZiOsxeu7FHedZqj7OK7FSK8HkQh8AAm/sfsIw6uXI7/2TzPml7AH9UQrvCnPEjlYLNb/Vj5Wag0TJzxP4JmEdB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDDauPIrBY5JQsq7RVQnGDXezA/0+uSslphIB82TEOg=;
 b=c5Z79y3V7YjcTUImO782ZF8POpamWtg2vlKVndLzIPS/A+O5ws8gtfE+TGR4YjImiwP3oLTmPfDAcIgn1cXpU0o3Su9aTEmToIDd84qwZBV5tOd2WOSMLRk5rpGzR7B855AuC7bRTKr5JsqPlIxt+6siEWOXBFxPiUFdelZylFOUpKHuAv5FAhbUP7q2ER7hXYtOQ2UApE1IJnnHecfaWTj1rOYzLJeqG69ZDOBDqhGBBKiiZ/2sZfy33RY0dL8zaXaCWULU99sySlc4VshasWS46oYEk1X3LZiCws8r8ugXv0ibfzF8giK2jkF4mfTx88axIXSyiT7bYP/LQdC9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDDauPIrBY5JQsq7RVQnGDXezA/0+uSslphIB82TEOg=;
 b=Mn7JNMEizTwHGT6JW+Nv2x+357k4AdgxlQ2gItp2q3G5NDmyY9CA7ofwW2ewMZNYGTC5JVKgMqQsAHYWUrn30QTQ5rgGoZ9IEzmlKdBazEy6r0AZKdiWba+V4S+5OpIpAhSDgVtj6LYVUTzhgyBot81TCcdsVnGP6AwSXnH3UQE=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB2621.namprd11.prod.outlook.com (2603:10b6:805:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Mon, 16 Mar
 2020 08:41:31 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2814.018; Mon, 16 Mar 2020
 08:41:31 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
Thread-Topic: nfit_test: issue #2: modprobe: ERROR: could not insert
 'nfit_test': Unknown symbol in module, or unknown parameter
Thread-Index: AdX4eeu8S4UKpcXxQVyul9RQ8BWIzAAFpEOAACLglpAADHb6AACIDRcw
Date: Mon, 16 Mar 2020 08:41:31 +0000
Message-ID: <SN6PR11MB28642183BB35451EBC30803096F90@SN6PR11MB2864.namprd11.prod.outlook.com>
References: <SN6PR11MB2864B07E6EA3CFCDB77169FE96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4hX5D6G6uSCoeV78NfJtNj8cvk5=ouLJ+EL2SXvqi-d_Q@mail.gmail.com>
 <SN6PR11MB28647C6C4DE888D1B74A903B96FA0@SN6PR11MB2864.namprd11.prod.outlook.com>
 <CAPcyv4igs_41gvtoqkA6a8LshkrXsKLBaZa3KwkuRRPyczdXSg@mail.gmail.com>
In-Reply-To: <CAPcyv4igs_41gvtoqkA6a8LshkrXsKLBaZa3KwkuRRPyczdXSg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: a7b0e7e5-60df-4a04-3259-08d7c985d39e
x-ms-traffictypediagnostic: SN6PR11MB2621:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2621A58E3B6214F0C0A4E9C496F90@SN6PR11MB2621.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(107886003)(55016002)(9686003)(478600001)(186003)(8936002)(4326008)(6862004)(4744005)(8676002)(81166006)(81156014)(26005)(316002)(6636002)(54906003)(7696005)(53546011)(6506007)(71200400001)(76116006)(52536014)(66946007)(66446008)(64756008)(66476007)(66556008)(2906002)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2621;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2Wx5C91/vQvGmlK/WABE7pkVMpZtQV9gWWH8Uf9CLky8HkuBCHe9I0w6S5ASkjvti41lxqNNq9L+X55RJo5GiFmG18Rnp55dljHqc+7H+oVDyZGvn2i2aep5iwpyXgQqile0Ndn4qP09NX7i/pqQv5/G4KtaVChdADc3ddsiguSPysmNNh5HFlnYwAXpkiwoGFRao+7qjsp1ANJSY2Y0RZFLreGvUdkokSgxtV6VzG8mL02Suf5HNo7BV+jI+bmE8LotI4hy7xJgl30iGSmHmGbCa9LemxAoHh0UkLUeAy8bQScPhXoOfBRlPmFAkeycSZ5SHC2Am/ev9bwwx0frieAVefB81tQBBzyRsP4D+KXqf5HWhgmZn0qC5Xle26caWnvFLOxVyDvadcX10x/K47lMnL1sSRtp8QlBSEpeDJxRbZEALC/ctraWK3/2GpR
x-ms-exchange-antispam-messagedata: IptXmMEj9I2vurO+56bUN4Lyw+uuYZBkOOV4dr3ZtemGMb43tnreWQ/U4I1WA2hDyKnJxR8e7dei11Aedy10cLl1VR8kdC/6RtoA50zJiATrtpZbWHXk/xMYPlMgngjYh3nOhcPfc7D/PWkgnk9e8Q==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b0e7e5-60df-4a04-3259-08d7c985d39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 08:41:31.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjRahV8Wplu+oRWl4ZWqtrvsEMQ0kNZg9xs7TM/USAAMgkbftFOA5E/eM/vbOBmSMfzDxI92sZQ3aI0eGK4JYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2621
X-OriginatorOrg: intel.com
Message-ID-Hash: 54XL23QYQ5X77HTUDAM63OC5ZRP7EQNS
X-Message-ID-Hash: 54XL23QYQ5X77HTUDAM63OC5ZRP7EQNS
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/54XL23QYQ5X77HTUDAM63OC5ZRP7EQNS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Friday, March 13, 2020 4:41 PM Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Mar 13, 2020 at 2:49 AM Dorau, Lukasz <lukasz.dorau@intel.com> wrote:
> > As you can see 'ndctl' also cannot load the extra test version of the modules even if
> there is the following file:
> >
> > $ cat /etc/depmod.d/nvdimm-extra
> > override nfit * extra
> > override device_dax * extra
> > override dax_pmem * extra
> > override dax_pmem_core * extra
> > override dax_pmem_compat * extra
> > override libnvdimm * extra
> > override nd_blk * extra
> > override nd_btt * extra
> > override nd_e820 * extra
> > override nd_pmem * extra
> >
> > Can I try anything else? Do you have any suggestions?
> 
> Do you have the nfit, or libnvdimm modules loading from the initramfs?

No, I do not:	

$ sudo lsinitrd /boot/initramfs-5.6.0-rc1-13504-g7b27a8622f80.img | grep nfit
$ sudo lsinitrd /boot/initramfs-5.6.0-rc1-13504-g7b27a8622f80.img | grep libnvdimm
$

--
Lukasz

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
