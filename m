Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606F2BA09F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 03:47:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B338100EF261;
	Thu, 19 Nov 2020 18:47:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0A03B100EF25F
	for <linux-nvdimm@lists.01.org>; Thu, 19 Nov 2020 18:47:39 -0800 (PST)
IronPort-SDR: RcICAgzy3bLkytKrlHBZN6Rp77OEKXVEGEFZP9ifWVCijtwBmHd5ddUaqNbm13n0Qfm+2BuxJZ
 Nm2erY/qq9zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171501285"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400";
   d="scan'208";a="171501285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:47:39 -0800
IronPort-SDR: a1GAptKb6gEIzEsX3pqU4V+nqfBFburNh7NMePFasrueI5aN5Tr2WzmtGhB1R/HXeRvGKndkJe
 sG7E/Bcxl96w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400";
   d="scan'208";a="535011909"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 18:47:39 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 18:47:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 18:47:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 18:47:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHhdzuqyJTVvrTK0CI7LFa7sUV6Brl5rEv+uDPdpG2qks1ED3OQYEEDz5sK2T78yFqlbmGxabdv8ZLUSwDf1t3ee+P6msBNSwe+Wd7YmYZZkLYJh3YWOuB8AEFmmkS9hE5A6J/z+MsvqTo55TWmpe+2Tm4wG6Bjsd7vJhOR/podj75BE9crrHJavdrFK/6S/Ow/+QQkMD/f/67tuO1iiNS5csnz8/V3B0ZHhJx5oJvHSbp56QjghpE+WbdbcAWaMSGp19KI1ASuaxmr+JBMGSSavbeOxvPc2MVXhOb5NkA3L1tnVLGRa9yR/XFXYU4ho0ZUZpnkG3zLfH0PdBmMEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2PgVvM4gAAkv6inYaKaxTxDDfPIpjNh4FMRBx8IVnQ=;
 b=Qq1Xe554a/GqXt9tTR+U4U6ZGHSNYS70T4T5CHU1BUBeE+PQXBKoe5GJ4GAlaJN3rOyrxybEY+eVF8euwJ5Dugwznc+WFJtz2Mkp/V1/fRE3Ezr4hHKfBgN/N+jlWssSbv0le3QaqtxycZ0T5M1igUHMTiSegDlW6NsujReOmP9IE6arTn+/+eJlimuFCBMm1PYppXAik0Kr5X71ATRgkYydHezSRNmR+UW3J9PYepd8GTDybOLWDaQz1QryhzMgX1PMOTAWJLnatSH9UscPJMxRZYGgHzRnxtQEujSmgN5ca+8V+0cz5x/BDlxFFZq+yqt08L+2ayctTE4vuk6MEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2PgVvM4gAAkv6inYaKaxTxDDfPIpjNh4FMRBx8IVnQ=;
 b=POobIxedyWaWGP2UoGZw34F+HzmP5LzXcQoMOUkHtq25pUSy6+FujqoJw11jpgnfI/JHYA/n7fzYvVPYaVThZaSquBeNLmH69NkDMs/p4Ps+om4ob1XNixvDuSGaL4IZoKKwErHVhhLdlerLCKbY02YlUzuBNB3ePXZX9xQ88OU=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4813.namprd11.prod.outlook.com (2603:10b6:a03:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 02:47:37 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f%5]) with mapi id 15.20.3541.029; Fri, 20 Nov 2020
 02:47:37 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>, "Scargall, Steve"
	<steve.scargall@intel.com>
Subject: Re: [ndctl PATCH 0/8] fix serverl issues reported by Coverity
Thread-Topic: [ndctl PATCH 0/8] fix serverl issues reported by Coverity
Thread-Index: AQHWtB6HUCWOpFzHRkKKtABqbGpvf6nQZhEAgAAAswA=
Date: Fri, 20 Nov 2020 02:47:37 +0000
Message-ID: <d79aa3a155fb2373e96f00b7b796d3d7ab5022b5.camel@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
	 <5a9465d5-b933-3b74-bd74-7e18e48a7467@huawei.com>
In-Reply-To: <5a9465d5-b933-3b74-bd74-7e18e48a7467@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e5f89b7-1caa-4112-18b1-08d88cfea3fc
x-ms-traffictypediagnostic: SJ0PR11MB4813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4813BE6515D7455A8415E5E1C7FF0@SJ0PR11MB4813.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prbkdgrqlCxS5ZQmKSM7uaUvQdMH6CuQmqT2BCtzIdUoLjaHtUVwrOpJvKkkdzKKlaFdFPFECorkNBBuw57Jj4pNCNIlCq45l2lR8wXFNUPG2gF1Mx0iSkV93UK41kIEjAbPCwY1QFmq/pXPBXxs8j2C+uKCb746AVj73XicAD6sgfOt+ZyaDchnOJwTLzymEeGYPTlgi9yI+Hk0/TjXONSkINDJnXDL18UWlrfrcnJyNKz/w5mP+hvcUIap38vqZUJK3tv7vE1ddOMYkDsU9v6//Vieqs+aWB9kaAXBC07neJwJBaxBx2HRY/aVvQjx/KC14Uwgs5hY2P35+VTaPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(478600001)(71200400001)(6486002)(6506007)(53546011)(110136005)(36756003)(66476007)(8676002)(8936002)(316002)(66556008)(66446008)(5660300002)(2906002)(66946007)(64756008)(76116006)(91956017)(6636002)(83380400001)(186003)(4001150100001)(86362001)(4326008)(54906003)(2616005)(26005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2aW+7m/RexgeS8slqt3kEgNU3j5RpU6Eq79xCevWACQVDvTh+TVKvVFQgCUL6gVNEc4zqY6g2ZFunXDUvdK6HBFtWkLmw/wEzoRIL3yDu4mVu0a10AhShNSRz3BmCe697F2FyEMjA6QdFbWlZl+rP47KaqdW+TCGQGQqOROYrp+YJCeIfFtERhHPmCPc95etdS9zbIeJoyS34z+aDRptA6GtwtSREOz2oP/8wk376yo0jxV2hPnCOt/mlRNdbr5Zlt9MQPL56BQGumKRf8X2GcHHgFOWZLPlSy9UR35gfiDspL4N6thudxE09QrDfcZssUaey/wNcKi5FOrgcA9PP4/nTxRBRffAuOTsHEmJoIiBFQ5rRZ93md9+Ew9BotchdnRVllLITneR+W8gk/FM92ZvNep7VBQL7ApZbS0WaPoa9tN/e11RdcQIIZByU/B4UXYioMZD2FG4uFVZXooRi8bPLRSeWaFqG8eLiITpVYuOgBimrQse8Io9tml9nqqGgRk+XVPQ/tgxFxPuV3AJ7LiWZiwfcJ3khZQ7bsA39sNAYEBzDpiqZNGxDVrCQvFe5q7gB8sDBkCrNwHKgDkS8ivw7MLRh0TAqb1rIoLiQkabuhclrI72U7HKKVZmwBPGPE8Z0mTE59x7Lg2uJVtCs8cH/ShNCg1OPZJvS4Xhmhb6ZIm5BKN7z9Yd2opYn2WFgkwo1jbR2MHQcLmv/KSVLcjFAHGE6Ntx2oOTXnmUgXEzPwqXKlJV+fov3Udt5n5Ho/hsz/CbFeGFdVaf+sei6Mr1u6X6pPYcnlCSb0ebzRcNGEbq0vNMGPIHfa0704wFl5/1Mb8HSTKLF2MgY5RftoXbvYZKQc0liv7xU+ADp1DNzX0DOEtIrcyN5q+5tBuYsHqXobS7b1tepOFfD6lWkA==
Content-ID: <1CEB63C9F8ACE443B04D6BE9981242C1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5f89b7-1caa-4112-18b1-08d88cfea3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 02:47:37.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnpKz6asIjVINhfM6gF1USP/ODJCicOp9k9rmW2dVhL7772JtNlZvJM2NP+G0TH7NbW9QEoDesTubWMTaDjD9amQxCXbfbSqNXBU9b/N6hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4813
X-OriginatorOrg: intel.com
Message-ID-Hash: OPMCMKTACOHOJA4MACEHY3TZR4Q22B2M
X-Message-ID-Hash: OPMCMKTACOHOJA4MACEHY3TZR4Q22B2M
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OPMCMKTACOHOJA4MACEHY3TZR4Q22B2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-20 at 10:45 +0800, Zhiqiang Liu wrote:
> Friendly ping...
> 
> I just wonder if this kind of patches will not be reviewed
> and processed.
> 
> I`d be very happy to receive any feedback.

Hi Zhiqiang,

These are definitely on my list to look at, I've just not had the time
to do so yet. I'm hoping to clear up my ndctl backlog in the next couple
of weeks though and get a v71 release out.

Thanks for the patience!

-Vishal

> 
> On 2020/11/6 17:23, Zhiqiang Liu wrote:
> > Recently, we use Coverity to analysis the ndctl package.
> > Several issues should be resolved to make Coverity happy.
> > 
> > lihaotian9 (8):
> >   namespace: check whether pfn|dax|btt is NULL in setup_namespace
> >   lib/libndctl: fix memory leakage problem in add_bus
> >   libdaxctl: fix memory leakage in add_dax_region()
> >   dimm: fix potential fd leakage in dimm_action()
> >   util/help: check whether strdup returns NULL in exec_man_konqueror
> >   lib/inject: check whether cmd is created successfully
> >   libndctl: check whether ndctl_btt_get_namespace returns NULL in
> >     callers
> >   namespace: check whether seed is NULL in validate_namespace_options
> > 
> >  daxctl/lib/libdaxctl.c |  3 +++
> >  ndctl/dimm.c           | 12 +++++++-----
> >  ndctl/lib/inject.c     |  8 ++++++++
> >  ndctl/lib/libndctl.c   |  1 +
> >  ndctl/namespace.c      | 23 ++++++++++++++++++-----
> >  test/libndctl.c        | 16 +++++++++++-----
> >  test/parent-uuid.c     |  2 +-
> >  util/help.c            |  8 +++++++-
> >  util/json.c            |  3 +++
> >  9 files changed, 59 insertions(+), 17 deletions(-)
> > 
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
