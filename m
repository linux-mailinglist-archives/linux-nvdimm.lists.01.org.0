Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C881A25A663
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Sep 2020 09:23:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 842FF139E7841;
	Wed,  2 Sep 2020 00:23:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.141.245; helo=esa1.hgst.iphmx.com; envelope-from=prvs=507b913ec=johannes.thumshirn@wdc.com; receiver=<UNKNOWN> 
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23FB213A6843F
	for <linux-nvdimm@lists.01.org>; Wed,  2 Sep 2020 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031394; x=1630567394;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HwjdEyHi3fljkwtYmLlhqIfSlIuGISp9GMNPicgVNyAHfVQf+qcTmE9j
   yjmB3ZQzmxM1LJdVLTlZqHCGfSOt8zEeOWvDOwldgoyi7gUzKH37V0PKN
   zABoBW/X22lqnySfXgCHhPpuAAZzHzMQwfgZx9sUrreZap6eTDM5KqKff
   iLHFnQR/CJZhl7AyVd2RvZUDYfPyqPW1cEwPqXjC/8fC/eIa1am3uCa9l
   mvvFoGc07NeYum8zjTdAicKABSUNmIU67xZxJM/mKwnxZa13qUedvbx6+
   LRSu5RagQY8O9BCQkU+nxv4zKZGhPX6W2BexDdVrFf8m5Fg/b1pW8Mcsy
   w==;
IronPort-SDR: nafJtDwz7q/g5sTZdsH5gvMQLdGT8NIKlTetdPeBeZ1N03EBp0xaHz8Ok5UyH75odR0eDf4lUG
 x8FhbhH4cHNixu6uF1SvLQYX5jeaOd8CShf/x+Q6VcYHPPCURgYLFXdIAjQrXLRa3vi2NLRMSA
 4bm0fkYO0Pe/LW03AvKfzNcyPTKx3M2chqs+tJsrYM9tSyAW+w+7tWycSHR4xDiu1MjbgHhZ+O
 iJHGUweclU/XCC5LJRO6cbJNNV2Gfe1WuQIEo6/crjGxKYwsYE4y2UpAx2wlcjfODsYo4bQzTX
 b1k=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600";
   d="scan'208";a="255918271"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs4ui3mdnrHHyxnpW/7TC1JPBu28wRCV+Sp6kjqdIfr+j6U5jRF+/CsCO003y3iWGHSLNvDkKb1N2j6BieLy/AB3HH0/Qi6+/qdN8VCblxobkpI7MVCHNZZOyt0/y21zuzikMSpFeRIldqKk2tTwZEw1GEt1GYn4/Unxlmi+lWpOGKZZdu0hrC0bmFn/wuKoYP35X7eFwdTTV9KbbEmiQ/Y+KLMi0ub8zv7+Ydp15HklDOo1KlS6BqOtzWDkKCp9SuyDuvU42n5OIdV27Nv7VMNH9KFfdpwBPTWzEFWA8PnNvDiJTbVk6Bf8XP7EafTy/lFcp+fWcQ5Tzvc2do8XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oYIGXOetxZeWNdht/DwRDxtJuUB34BPLTHWBylzuAQ7FXyhvek/iSw/CrlVJBm7qZAD4P7r0SfZPMZP4o+Yfxm9lrBanDgkJsAGZm9VnYMjMzU/DWCuDV5aa4thTeVYd7BK76CeBIGaeC17AlQyljVGV1nR+KvsQtXJWASq6O1w20UyF6Xu6T6IKG5SbSX3PVui5wuKFdUFv1gfBI12c3pz43M3nTGv5qZaL8szn7lDegjybLLl6DYyl67OTQQgGToy3cQLJ2hD9JBUgO2anSHrUpdfkAwvAj2lPGO0sNW1TVG7B3k8Kym2Uz1WXRRTuyyUvs9v1W8XAuJvKcaUdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PH3M7qm0YHXA4Vn3VG8fxk0niapXETmg2WbvamRzEY/CyNKt7YNN4K8c0f0OAOwdfYHNpFoH1dWIcwt3oQg12m4xjtT93JfWXRa6pDVOhnF7fqbp0C94jd9rxkYeih+ErVpdqKwOI5x89F8Oylmuvx4wZDrHUj+ve64ncmqzOys=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:23:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:23:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/9] block: rename bd_invalidated
Thread-Topic: [PATCH 3/9] block: rename bd_invalidated
Thread-Index: AQHWgHktLSbA5ZkuskSPO2+ZwjQCtA==
Date: Wed, 2 Sep 2020 07:23:11 +0000
Message-ID: 
 <SN4PR0401MB35989D97E602B0000F82E67B9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9365223b-b008-4771-c661-08d84f110c92
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: 
 <SN6PR04MB39669B41CADD6B73F46EC00A9B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 agD5XaPdbaQVSeSzu4fkHtkJ/VRxlRlDDVEGxBjMSnHFBbt45Ne34HMIrl05ycSYQnToBG6EOX6+/LL1fOYQgnchDJ4Tq6/+uW3RAlpG5+B1+AXnp0KITQ7D0BA8lOiLBpGHk69UrgcbjiXrU9PG3Vxejj+XvaJsSw/U1oaZxyBBHS3A4wpyOIpzdMUFS2uCJ5E06MoILEWMVw8ZYifRVoOl83xI6Wr8K4H/boDcwp7qYHHuQXnRUSvVA7Mmxpaq3IkXmRo74pKgDOylT44kWfSHG/pI8i6Lt/NTfTP7guD/FCzHu0+zy4MQdYy9lmW6XtNR2RSDweV23iMeV4RQ6A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 zita5OxGoQ33fEn/ZlvilfIj5xAq8Hg/xjtEa2FBpPWpNe9VSirjvP0QFnjlvzcyMRUXWdfcwk8DE090n8DjHn7q+r8IdKCuxLYhIyUjL2oYJOhyPSv8Z0r1IMOI/XI8g59XChk3O6m6KYg0hm5MjOG2XDU3ltnMaJKuCJWADQCMu69OdGfjX9ORfqePqbFpuEfoYU+aVDS372c0R7ELYyEXEIjN6Qw7kxiYS4T7b26Uh/jK2e30LXJV5hHs/e5Bon6ATRxVRbgYLYyms6p0Mexzk2Nw28Tnvtz/JwK7rI1bQGEY6YWEb+9itcpV7osk9JIPveSTNpYqZzRK+iCNUVHTmv4a+npzKexjYj+2lkA+2hLCivZEk/yuwLYwRpnOI27OSFsVAHTvLDTSVzOq28bxvqxxv4d6QBZnnWnMfcmT1GE7QUE13cfioZeGCBEKaBfadW0/ZaAWlqwAlGkSc7JuMXWLedGYsU/BKsrZ0H6ooQAtk/Fxk9xf0wZV3wFJ6pSLk/GbIJFrGJeZ6Xs7AHhQDw3Ab8mTLBa44AIT2s+QrghM+E2OAtgwiV9zV/jGIGc4TrvFHJ5hXb0HyZ5YGpcHex5OnQYvaQh0RbUDI+4itd0z4a+EH8XJOGSVdKPp8x9ohwl+8az9gGKbo7CsKp3CB7Jdm5w0PIhcslAAEHHbTb7lgmjXEzq26eFvrwPMMF+kJfN9b5mfbiWvNSeZLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9365223b-b008-4771-c661-08d84f110c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:23:11.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRMKQuBx0pDuAjD3/npBNx4zS2+H5kQI9gL066NCl4nkEDvvyLgOnA1AZIqfPyK8Os7gPBRhlGLZbL1fr7VBwZAsB2+7sbTG0rmDEGdty9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Message-ID-Hash: 3WAAALMPNPWJXSVERTCNORFSUDFC5Y6C
X-Message-ID-Hash: 3WAAALMPNPWJXSVERTCNORFSUDFC5Y6C
X-MailFrom: prvs=507b913ec=Johannes.Thumshirn@wdc.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Josef Bacik <josef@toxicpanda.com>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6D27FEQ3CRMQFSVZETC7UXESJ5KPFOYL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
