Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6069231B32
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 10:28:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A81D91269A49C;
	Wed, 29 Jul 2020 01:28:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.14.41; helo=eur01-ve1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EBD10125B96B2
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh45dN8iA1h9QafMV89tabtTIkfybWLoq6KjjrLWsgg=;
 b=d3auCks10wvAL8qzuq8SQLW5IL80vWqKe81735yC0pwWuWjF3M4IZ21AMejQqGGSR+B8kYtm8FW8u9TwBddnZlvLNgS1Fzbk7zxD8KV2vbLx8OjM7CYIuM7TjSmuPfvkSOkImJGToH68aKl7O8w7D2dRP4u1e5LfVRov4wivxSY=
Received: from DBBPR09CA0039.eurprd09.prod.outlook.com (2603:10a6:10:d4::27)
 by DB6PR0802MB2536.eurprd08.prod.outlook.com (2603:10a6:4:a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 08:28:07 +0000
Received: from DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::75) by DBBPR09CA0039.outlook.office365.com
 (2603:10a6:10:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Wed, 29 Jul 2020 08:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT037.mail.protection.outlook.com (10.152.20.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Wed, 29 Jul 2020 08:28:07 +0000
Received: ("Tessian outbound 7de93d801f24:v62"); Wed, 29 Jul 2020 08:28:07 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3f268a414667.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0187ABA6-D241-40F2-9963-9B19ACC3E19A.1;
	Wed, 29 Jul 2020 08:28:02 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3f268a414667.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 29 Jul 2020 08:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzUaMED3b0YWje/h6jxmQIchBDR7H2FenJ7hym/SCaprMODjauvizAx650oKgv6x02OWmHntEZqvSFahASZQOqei7YeDEjRzRYZC8mjq54lL+KenftcvAUirkRJ/Jg/XiMXTfZRkEWvu3jzgoD0T38nzb9lMOf5Ax6UxTbQffhTc3RlQ3YHTM0N/T3Zfo/ib9vlTx22aIHTjJGcNHAtcVLXApIlO/pEvktZSUNx7ys3ai23iiTRBy3CXb7CfI4nM0YNczSjrrm0vc4AakKrlxjA0gYacJ/j3Ed6FSJ/uGSUFmUnfaxD99dxDGf67LhYv8M/jYoVmqMCM+1MAxCeZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh45dN8iA1h9QafMV89tabtTIkfybWLoq6KjjrLWsgg=;
 b=Exes/00nJdKYQpsAuIFKXTgijbulBpqUOg+GLcyC4GUewRCeu3zN20fYXfkS/M1EA/T+PDq97hXHaF5BiqGgl9XAddJAdPTIVa1IBFOXPX3xOodA5cAc6KoKisYUiSqaNcdax0rmNzxCHKk20J9vcN7vsA/0Y+D7KqOOFX2WSj69omRQIBaYeyON5jGXh1vpIoU9r83SfMLrPv7p9RdT26VEZIdNOr8XodcO6nUtZEMWpUp5wzb6VpV2S2vCtziOxmr/TYV7ge7YFFr5FydqW8fdwGJn2Jd0ClmLGnbEiENwn7GjTsCeejTKmGSbTkH6bGeRv8TbFpyVvCe5t+EC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh45dN8iA1h9QafMV89tabtTIkfybWLoq6KjjrLWsgg=;
 b=d3auCks10wvAL8qzuq8SQLW5IL80vWqKe81735yC0pwWuWjF3M4IZ21AMejQqGGSR+B8kYtm8FW8u9TwBddnZlvLNgS1Fzbk7zxD8KV2vbLx8OjM7CYIuM7TjSmuPfvkSOkImJGToH68aKl7O8w7D2dRP4u1e5LfVRov4wivxSY=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB4088.eurprd08.prod.outlook.com (2603:10a6:20b:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Wed, 29 Jul
 2020 08:27:58 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::9cc7:c232:9b1b:3c0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::9cc7:c232:9b1b:3c0%5]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 08:27:58 +0000
From: Justin He <Justin.He@arm.com>
To: David Hildenbrand <david@redhat.com>
Subject: RE: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Thread-Topic: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Thread-Index: AQHWZVlS1SmlDBWRzUu4RhfiOuAhPqkeGoMAgAAZXOA=
Date: Wed, 29 Jul 2020 08:27:58 +0000
Message-ID: 
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
In-Reply-To: <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 45f80ecd-758d-4a83-b0bf-b369073c407a.1
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76c3d7f5-a846-42ba-daa8-08d833995249
x-ms-traffictypediagnostic: AM6PR08MB4088:|DB6PR0802MB2536:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<DB6PR0802MB2536714571924FEB4D8219B9F7700@DB6PR0802MB2536.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 +vFwelrFZVa1INa//PHshf1BMDHBIOUD5zDBZeLV+3ARPdgDbzi12h6e65r+g7hb8V4z52rTip4Hb/+MDP6RNqZohK0yPzfbhPfkQShdBTe+qXvVmFjLOKgejVQEZlWks4CmXjbK6BpGEImWUl8PryNUa5y6hBuIOVLREbORIiQtQkbaOtp15oNfrDgkOeyYizs9nX+9TF9Z9MsHItwXplrv2SQBPH9gOe/qGDrZv4jOPNvAo+ipWIjqcU49Gag+ZeltYEwceADytJq2NzK85Q9q+otiCVPElGRISHhYlZw9PmPN9y4ak3G7Tnp+Ku22fBZ4dozeuaToxIjoCI/vhqUuhM6pgAHKHU6TsCh/mEGj+Fvyl32yoZsOzfXquTR6XEl55sjcTRccqc9iFvkKkA==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(66556008)(64756008)(66446008)(76116006)(966005)(7696005)(66476007)(71200400001)(52536014)(5660300002)(478600001)(83380400001)(33656002)(66946007)(2906002)(9686003)(26005)(186003)(4326008)(8936002)(86362001)(55016002)(54906003)(6506007)(6916009)(7416002)(8676002)(316002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 1piMn4fW6c26ejrOY9+0apsN09zARI2FUC+XvTaKoEn3fW9n+y58ostUvJTHzAkkbPxuHOXFiJXYznY3X4PGCvsrB909dWjSJGIQsBlXc5eUTwRUu+4FXGZgpPuD5tCR3AiMH7ZoMl7DNcTruE4xvnOyqko+Cbr4h58U1NceTldFzRlBRx9QRzzyTYyLmmbI/0v0e1PuehYrd7OV/LIZ6z4M2DGtncMAnI986Lf1622VhccmLPBqIJ3cj4HOaYjoyyQES8EWcW7PS8gpBZz1GcwmsKxwdOrKT7zasrP1esvLa6iX6O2najTgrA+7nx/uYKRvuoZBByaNK3S2cuIlLCW703cSyVmuwdd2DVNvk84fp3fc3PnVZ0+n2RdnHgW55iaMwI7WxJm5bk8Dlw7IHk/7KDeS2CGED4J3fg3AQgJmH/+kXVkqnvsA4DjeGwmfPI8c23duoZP0D+4MjUybWInZQjuW8g90ZvwVhadL9zk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4088
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	440db831-23ee-4e84-7b8c-08d833994cc9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xl8os/OB2Mc4/ndpzneOf68KyAw5s28MbQFBYP3Tr201nS+iqnzO9+osr3BKumKQxZJ+Atml3+hkCjANX7rmaqCfEWQV5Cae+Yw4emrRDRKB0SaRPElt4iB9f1LuIhig59Jzx26WawEPTi9pQB07VW8JuqLvnHk9KjTnQszgmNojEoLUFWTykqntRUaV8fhxxiGELYvSlPXA0GPdY0ly884BQq80t1RcrIddzrdelReLPenh2+5VaGesc57BXh6T3l5644mmvnbexmYCupdy/uVd/jYG4aDKeUSYrtI1VY/LccDAvmV0QEOiS2Kg/hK/zDD3YQkHu91TvIkLAmG7ydaWEpQrZDMhzCKjyvJs2nB0LwaQGQvkqx+Q3ZJ5N+2O3LKp8f+drey/uL/mSuTQB9nnGYMaYzNHQOTGt34NW/gDD2ybkirqmw4lq6XHwv0rlAQ7CU0qi9COHykucGE3hDL1M0hj3WKG1PVViWMTooc=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39850400004)(376002)(346002)(46966005)(52536014)(478600001)(9686003)(5660300002)(336012)(83380400001)(33656002)(4326008)(2906002)(6862004)(82740400003)(53546011)(966005)(8936002)(55016002)(7696005)(54906003)(356005)(82310400002)(47076004)(81166007)(86362001)(186003)(8676002)(6506007)(70206006)(70586007)(26005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 08:28:07.6429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c3d7f5-a846-42ba-daa8-08d833995249
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2536
Message-ID-Hash: ZSWI5FHUYNPBVTODEQZHY32Z5K432Z33
X-Message-ID-Hash: ZSWI5FHUYNPBVTODEQZHY32Z5K432Z33
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UX5X2DX7TAXH5WWJUX3DYZUUK4GEPCFC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

SGkgRGF2aWQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI5
LCAyMDIwIDI6MzcgUE0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENj
OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47IFZpc2hhbCBWZXJtYQ0K
PiA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsgTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5p
Ym0uY29tPjsgRGF2aWQNCj4gSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+OyBDYXRhbGlu
IE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsNCj4gV2lsbCBEZWFjb24gPHdpbGxA
a2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBEYXZlDQo+IEpp
YW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+Ow0KPiBTdGV2ZSBDYXBwZXIgPFN0ZXZlLkNhcHBlckBhcm0uY29tPjsgTWFy
ayBSdXRsYW5kIDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47DQo+IExvZ2FuIEd1bnRob3JwZSA8bG9n
YW5nQGRlbHRhdGVlLmNvbT47IEFuc2h1bWFuIEtoYW5kdWFsDQo+IDxBbnNodW1hbi5LaGFuZHVh
bEBhcm0uY29tPjsgSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPjsgSmFzb24NCj4g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPjsgS2Vlcw0KPiBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IFdl
aQ0KPiBZYW5nIDxyaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbT47IFBhbmthaiBHdXB0YQ0K
PiA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT47IElyYSBXZWlueSA8aXJhLndlaW55QGlu
dGVsLmNvbT47IEthbHkgWGluDQo+IDxLYWx5LlhpbkBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCAwLzZdIGRlY3JlYXNlIHVubmVjZXNzYXJ5IGdhcCBkdWUgdG8gcG1lbSBrbWVt
DQo+IGFsaWdubWVudA0KPiANCj4gDQo+IA0KPiA+IEFtIDI5LjA3LjIwMjAgdW0gMDU6MzUgc2No
cmllYiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPjoNCj4gPg0KPiA+IO+7v1doZW4gZW5hYmxp
bmcgZGF4IHBtZW0gYXMgUkFNIGRldmljZSBvbiBhcm02NCwgSSBub3RpY2VkIHRoYXQga21lbV9z
dGFydA0KPiA+IGFkZHIgaW4gZGV2X2RheF9rbWVtX3Byb2JlKCkgc2hvdWxkIGJlIGFsaWduZWQg
dy8NCj4gU0VDVElPTl9TSVpFX0JJVFMoMzApLGkuZS4NCj4gPiAxRyBtZW1ibG9jayBzaXplLiBF
dmVuIERhbiBXaWxsaWFtcycgc3ViLXNlY3Rpb24gcGF0Y2ggc2VyaWVzIFsxXSBoYWQNCj4gYmVl
bg0KPiA+IHVwc3RyZWFtIG1lcmdlZCwgaXQgd2FzIG5vdCBoZWxwZnVsIGR1ZSB0byBoYXJkIGxp
bWl0YXRpb24gb2Yga21lbV9zdGFydDoNCj4gPiAkbmRjdGwgY3JlYXRlLW5hbWVzcGFjZSAtZSBu
YW1lc3BhY2UwLjAgLS1tb2RlPWRldmRheCAtLW1hcD1kZXYgLXMgMmcgLWYNCj4gLWEgMk0NCj4g
PiAkZWNobyBkYXgwLjAgPiAvc3lzL2J1cy9kYXgvZHJpdmVycy9kZXZpY2VfZGF4L3VuYmluZA0K
PiA+ICRlY2hvIGRheDAuMCA+IC9zeXMvYnVzL2RheC9kcml2ZXJzL2ttZW0vbmV3X2lkDQo+ID4g
JGNhdCAvcHJvYy9pb21lbQ0KPiA+IC4uLg0KPiA+IDIzYzAwMDAwMC0yM2ZmZmZmZmYgOiBTeXN0
ZW0gUkFNDQo+ID4gIDIzZGQ0MDAwMC0yM2ZlY2ZmZmYgOiByZXNlcnZlZA0KPiA+ICAyM2ZlZDAw
MDAtMjNmZmZmZmZmIDogcmVzZXJ2ZWQNCj4gPiAyNDAwMDAwMDAtMzNmZGZmZmZmIDogUGVyc2lz
dGVudCBNZW1vcnkNCj4gPiAgMjQwMDAwMDAwLTI0MDNmZmZmZiA6IG5hbWVzcGFjZTAuMA0KPiA+
ICAyODAwMDAwMDAtMmJmZmZmZmZmIDogZGF4MC4wICAgICAgICAgIDwtIGFsaWduZWQgd2l0aCAx
RyBib3VuZGFyeQ0KPiA+ICAgIDI4MDAwMDAwMC0yYmZmZmZmZmYgOiBTeXN0ZW0gUkFNDQo+ID4g
SGVuY2UgdGhlcmUgaXMgYSBiaWcgZ2FwIGJldHdlZW4gMHgyNDAzZmZmZmYgYW5kIDB4MjgwMDAw
MDAwIGR1ZSB0byB0aGUNCj4gMUcNCj4gPiBhbGlnbm1lbnQuDQo+ID4NCj4gPiBXaXRob3V0IHRo
aXMgc2VyaWVzLCBpZiBxZW11IGNyZWF0ZXMgYSA0RyBieXRlcyBudmRpbW0gZGV2aWNlLCB3ZSBj
YW4NCj4gb25seQ0KPiA+IHVzZSAyRyBieXRlcyBmb3IgZGF4IHBtZW0oa21lbSkgaW4gdGhlIHdv
cnN0IGNhc2UuDQo+ID4gZS5nLg0KPiA+IDI0MDAwMDAwMC0zM2ZkZmZmZmYgOiBQZXJzaXN0ZW50
IE1lbW9yeQ0KPiA+IFdlIGNhbiBvbmx5IHVzZSB0aGUgbWVtYmxvY2sgYmV0d2VlbiBbMjQwMDAw
MDAwLCAyZmZmZmZmZmZdIGR1ZSB0byB0aGUNCj4gaGFyZA0KPiA+IGxpbWl0YXRpb24uIEl0IHdh
c3RlcyB0b28gbXVjaCBtZW1vcnkgc3BhY2UuDQo+ID4NCj4gPiBEZWNyZWFzaW5nIHRoZSBTRUNU
SU9OX1NJWkVfQklUUyBvbiBhcm02NCBtaWdodCBiZSBhbiBhbHRlcm5hdGl2ZSwgYnV0DQo+IHRo
ZXJlDQo+ID4gYXJlIHRvbyBtYW55IGNvbmNlcm5zIGZyb20gb3RoZXIgY29uc3RyYWludHMsIGUu
Zy4gUEFHRV9TSVpFLCBodWdldGxiLA0KPiA+IFNQQVJTRU1FTV9WTUVNTUFQLCBwYWdlIGJpdHMg
aW4gc3RydWN0IHBhZ2UgLi4uDQo+ID4NCj4gPiBCZXNpZGUgZGVjcmVhc2luZyB0aGUgU0VDVElP
Tl9TSVpFX0JJVFMsIHdlIGNhbiBhbHNvIHJlbGF4IHRoZSBrbWVtDQo+IGFsaWdubWVudA0KPiA+
IHdpdGggbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMoKS4NCj4gPg0KPiA+IFRlc3RlZCBvbiBhcm02
NCBndWVzdCBhbmQgeDg2IGd1ZXN0LCBxZW11IGNyZWF0ZXMgYSA0RyBwbWVtIGRldmljZS4gZGF4
DQo+IHBtZW0NCj4gPiBjYW4gYmUgdXNlZCBhcyByYW0gd2l0aCBzbWFsbGVyIGdhcC4gQWxzbyB0
aGUga21lbSBob3RwbHVnIGFkZC9yZW1vdmUNCj4gYXJlIGJvdGgNCj4gPiB0ZXN0ZWQgb24gYXJt
NjQveDg2IGd1ZXN0Lg0KPiA+DQo+IA0KPiBIaSwNCj4gDQo+IEkgYW0gbm90IGNvbnZpbmNlZCB0
aGlzIHVzZSBjYXNlIGlzIHdvcnRoIHN1Y2ggaGFja3MgKHRoYXTigJlzIHdoYXQgaXQgaXMpDQo+
IGZvciBub3cuIE9uIHJlYWwgbWFjaGluZXMgcG1lbSBpcyBiaWcgLSB5b3VyIGV4YW1wbGUgKGxv
c2luZyA1MCUgaXMNCj4gZXh0cmVtZSkuDQo+IA0KPiBJIHdvdWxkIG11Y2ggcmF0aGVyIHdhbnQg
dG8gc2VlIHRoZSBzZWN0aW9uIHNpemUgb24gYXJtNjQgcmVkdWNlZC4gSQ0KPiByZW1lbWJlciB0
aGVyZSB3ZXJlIHBhdGNoZXMgYW5kIHRoYXQgYXQgbGVhc3Qgd2l0aCBhIGJhc2UgcGFnZSBzaXpl
IG9mIDRrDQo+IGl0IGNhbiBiZSByZWR1Y2VkIGRyYXN0aWNhbGx5ICg2NGsgYmFzZSBwYWdlcyBh
cmUgbW9yZSBwcm9ibGVtYXRpYyBkdWUgdG8NCj4gdGhlIHJpZGljdWxvdXMgVEhQIHNpemUgb2Yg
NTEyTSkuIEJ1dCBjb3VsZCBiZSBhIHNlY3Rpb24gc2l6ZSBvZiA1MTIgaXMNCj4gcG9zc2libGUg
b24gYWxsIGNvbmZpZ3MgcmlnaHQgbm93Lg0KDQpZZXMsIEkgb25jZSBpbnZlc3RpZ2F0ZWQgaG93
IHRvIHJlZHVjZSBzZWN0aW9uIHNpemUgb24gYXJtNjQgdGhvdWdodGZ1bGx5Og0KVGhlcmUgYXJl
IG1hbnkgY29uc3RyYWludHMgZm9yIHJlZHVjaW5nIFNFQ1RJT05fU0laRV9CSVRTDQoxLiBHaXZl
biBwYWdlLT5mbGFncyBiaXRzIGlzIGxpbWl0ZWQsIFNFQ1RJT05fU0laRV9CSVRTIGNhbid0IGJl
IHJlZHVjZWQgdG9vDQogICBtdWNoLg0KMi4gT25jZSBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAg
aXMgZW5hYmxlZCwgc2VjdGlvbiBpZCB3aWxsIG5vdCBiZSBjb3VudGVkDQogICBpbnRvIHBhZ2Ut
PmZsYWdzLg0KMy4gTUFYX09SREVSIGRlcGVuZHMgb24gU0VDVElPTl9TSVpFX0JJVFMgDQogLSAz
LjEgbW16b25lLmgNCiNpZiAoTUFYX09SREVSIC0gMSArIFBBR0VfU0hJRlQpID4gU0VDVElPTl9T
SVpFX0JJVFMNCiNlcnJvciBBbGxvY2F0b3IgTUFYX09SREVSIGV4Y2VlZHMgU0VDVElPTl9TSVpF
DQojZW5kaWYNCiAtIDMuMiBodWdlcGFnZV9pbml0KCkNCk1BWUJFX0JVSUxEX0JVR19PTihIUEFH
RV9QTURfT1JERVIgPj0gTUFYX09SREVSKTsNCg0KSGVuY2Ugd2hlbiBBUk02NF80S19QQUdFUyAm
JiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgYXJlIGVuYWJsZWQsDQpTRUNUSU9OX1NJWkVfQklU
UyBjYW4gYmUgcmVkdWNlZCB0byAyNy4NCkJ1dCB3aGVuIEFSTTY0XzY0S19QQUdFUywgZ2l2ZW4g
My4yLCBNQVhfT1JERVIgPiAyOS0xNiA9IDEzLg0KR2l2ZW4gMy4xIFNFQ1RJT05fU0laRV9CSVRT
ID49IE1BWF9PUkRFUisxNSA+IDI4LiBTbyBTRUNUSU9OX1NJWkVfQklUUyBjYW4gbm90DQpiZSBy
ZWR1Y2VkIHRvIDI3Lg0KDQpJbiBvbmUgd29yZCwgaWYgd2UgY29uc2lkZXJlZCB0byByZWR1Y2Ug
U0VDVElPTl9TSVpFX0JJVFMgb24gYXJtNjQsIHRoZSBLY29uZmlnDQptaWdodCBiZSB2ZXJ5IGNv
bXBsaWNhdGVkLGUuZy4gd2Ugc3RpbGwgbmVlZCB0byBjb25zaWRlciB0aGUgY2FzZSBmb3INCkFS
TTY0XzE2S19QQUdFUy4NCg0KPiANCj4gSW4gdGhlIGxvbmcgdGVybSB3ZSBtaWdodCB3YW50IHRv
IHJld29yayB0aGUgbWVtb3J5IGJsb2NrIGRldmljZSBtb2RlbA0KPiAoZXZlbnR1YWxseSBzdXBw
b3J0aW5nIG9sZC9uZXcgYXMgZGlzY3Vzc2VkIHdpdGggTWljaGFsIHNvbWUgdGltZSBhZ28NCj4g
dXNpbmcgYSBrZXJuZWwgcGFyYW1ldGVyKSwgZHJvcHBpbmcgdGhlIGZpeGVkIHNpemVzDQoNCkhh
cyB0aGlzIGJlZW4gcG9zdGVkIHRvIExpbnV4IG1tIG1haWxsaXN0PyBTb3JyeSwgc2VhcmNoZWQg
YW5kIGRpZG4ndCBmaW5kIGl0Lg0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0K
DQoNCj4gLSBhbGxvd2luZyBzaXplcyAvIGFkZHJlc3NlcyBhbGlnbmVkIHdpdGggc3Vic2VjdGlv
biBzaXplDQo+IC0gZHJhc3RpY2FsbHkgcmVkdWNpbmcgdGhlIG51bWJlciBvZiBkZXZpY2VzIGZv
ciBib290IG1lbW9yeSB0byBvbmx5IGENCj4gaGFuZCBmdWxsIChlLmcuLCBvbmUgcGVyIHJlc291
cmNlIC8gRElNTSB3ZSBjYW4gYWN0dWFsbHkgdW5wbHVnIGFnYWluLg0KPiANCj4gTG9uZyBzdG9y
eSBzaG9ydCwgSSBkb27igJl0IGxpa2UgdGhpcyBoYWNrLg0KPiANCj4gDQo+ID4gVGhpcyBwYXRj
aCBzZXJpZXMgKG1haW5seSBwYXRjaDYvNikgaXMgYmFzZWQgb24gdGhlIGZpeGluZyBwYXRjaCwg
fnY1LjgtDQo+IHJjNSBbMl0uDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTkvNi8xOS82Nw0KPiA+IFsyXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzgvMTU0Ng0K
PiA+IEppYSBIZSAoNik6DQo+ID4gIG1tL21lbW9yeV9ob3RwbHVnOiByZW1vdmUgcmVkdW5kYW50
IG1lbW9yeSBibG9jayBzaXplIGFsaWdubWVudCBjaGVjaw0KPiA+ICByZXNvdXJjZTogZXhwb3J0
IGZpbmRfbmV4dF9pb21lbV9yZXMoKSBoZWxwZXINCj4gPiAgbW0vbWVtb3J5X2hvdHBsdWc6IGFs
bG93IHBtZW0ga21lbSBub3QgdG8gYWxpZ24gd2l0aCBtZW1vcnlfYmxvY2tfc2l6ZQ0KPiA+ICBt
bS9wYWdlX2FsbG9jOiBhZGp1c3QgdGhlIHN0YXJ0LGVuZCBpbiBkYXggcG1lbSBrbWVtIGNhc2UN
Cj4gPiAgZGV2aWNlLWRheDogcmVsYXggdGhlIG1lbWJsb2NrIHNpemUgYWxpZ25tZW50IGZvciBr
bWVtX3N0YXJ0DQo+ID4gIGFybTY0OiBmYWxsIGJhY2sgdG8gdm1lbW1hcF9wb3B1bGF0ZV9iYXNl
cGFnZXMgaWYgbm90IGFsaWduZWQgIHdpdGgNCj4gPiAgICBQTURfU0laRQ0KPiA+DQo+ID4gYXJj
aC9hcm02NC9tbS9tbXUuYyAgICB8ICA0ICsrKysNCj4gPiBkcml2ZXJzL2Jhc2UvbWVtb3J5LmMg
IHwgMjQgKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gZHJpdmVycy9kYXgva21lbS5jICAg
ICB8IDIyICsrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiBpbmNsdWRlL2xpbnV4L2lvcG9ydC5o
IHwgIDMgKysrDQo+ID4ga2VybmVsL3Jlc291cmNlLmMgICAgICB8ICAzICsrLQ0KPiA+IG1tL21l
bW9yeV9ob3RwbHVnLmMgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gPiBtbS9wYWdlX2FsbG9jLmMgICAgICAgIHwgMTQgKysrKysrKysrKysrKysNCj4g
PiA3IGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
