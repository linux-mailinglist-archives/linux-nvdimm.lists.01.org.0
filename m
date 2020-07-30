Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1A2329D8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 04:18:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E280126F1921;
	Wed, 29 Jul 2020 19:18:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.2.85; helo=eur02-ve1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C753012583724
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfXnxQtLGkm+4+TgSB3yD5g0qLO9rNkBG2VEo+bg2dY=;
 b=YVWXInlgvGkNlAJUdnnkx8DsKBYGmfIzfTJhhbbRPAyrUgLewgcyJP7CQldUziV6/+SzxRD29/RKMK3A9v3ZGj1PW6qkd3+9lfH9jM+x/NeV0DtfUMkLkW7MKMI+/XPUJvXN5z3tS1JJ8YTn1NHwDKHHHX6RS0EW7xkMY58N0l0=
Received: from AM6P194CA0009.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::22)
 by DB6PR0801MB1639.eurprd08.prod.outlook.com (2603:10a6:4:3b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 02:18:03 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::7) by AM6P194CA0009.outlook.office365.com
 (2603:10a6:209:90::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 02:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 02:18:03 +0000
Received: ("Tessian outbound 1c27ecaec3d6:v62"); Thu, 30 Jul 2020 02:18:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from 37d1308fcf1f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5244F910-ED24-4013-9A1F-4EDEB4798EDA.1;
	Thu, 30 Jul 2020 02:17:57 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 37d1308fcf1f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Jul 2020 02:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYhYXV6m6FTX4Plf3UXHZdpqR7vIZ9fjFLJxgOU87cW9DvGGK6vN5viprysV8vyR1k1XSJEapBzK7wVMYtXovi/EmV1EHKmZxbIBMUZ0bOtD5KyIOkYCyHbUaIpmGT2dp6ZCMa/Glzoz7FDc3S02K9KZzg0GEsU7n7TMsi7doj8waNw3z3JxLhpXEVS20cUsbRn2+8UFgUHOJAM6UeLFtycrEp7FWoIMv+6f4+UxDaZ32t4mKvh3x458K1ZfyL7PrPds3aH7DjWiOGdR+IAP2p0fGyQhf8CPbWnPVG7cvdxrti0LAM9nEmwRfQ1DOqXn739yGZSBAAVfBYmUKpR2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfXnxQtLGkm+4+TgSB3yD5g0qLO9rNkBG2VEo+bg2dY=;
 b=i7rflhxKL6EPjfD0i6QOXvsBAgeHxPR/DrmRwRaxpZQtGMMucOFfpH7aIV1c0Dc23cjWUVZFZepfGL11NiMRE7uUFMFw+vPU+P4TrZjzBn5gy+fP+gFhg2Y4Ijf81vGY66ago4jYN3VPLhhbdpdO9xxZWVQgdHuuSjucv1CqauRcIq+fGJgpHfU/qeJLfNXpiMd2/Eo0Jmz//eggL1S1NN8luZvnWnUkYCm5tmc+g8rD3Wo6pknNi6FWY6HBDydKX1LFEY2NREu6jeztosfvL+LYUqxi9qbY+Wbi0TKgAlFl/1GWiEhbWsUKdVkopaaPqH8NJZVfo5TtxR53dQhxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfXnxQtLGkm+4+TgSB3yD5g0qLO9rNkBG2VEo+bg2dY=;
 b=YVWXInlgvGkNlAJUdnnkx8DsKBYGmfIzfTJhhbbRPAyrUgLewgcyJP7CQldUziV6/+SzxRD29/RKMK3A9v3ZGj1PW6qkd3+9lfH9jM+x/NeV0DtfUMkLkW7MKMI+/XPUJvXN5z3tS1JJ8YTn1NHwDKHHHX6RS0EW7xkMY58N0l0=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM5PR0801MB1906.eurprd08.prod.outlook.com (2603:10a6:203:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 30 Jul
 2020 02:17:54 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::9cc7:c232:9b1b:3c0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::9cc7:c232:9b1b:3c0%5]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 02:17:54 +0000
From: Justin He <Justin.He@arm.com>
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Thread-Topic: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Thread-Index: AQHWZVlS1SmlDBWRzUu4RhfiOuAhPqkeGoMAgAAZXOCAABeaAIAAAPoAgAETF6A=
Date: Thu, 30 Jul 2020 02:17:53 +0000
Message-ID: 
 <AM6PR08MB406926D981C46E7711EB9DA4F7710@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
 <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
In-Reply-To: <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5581abab-623a-43dc-bb3c-b1b26c4d28f2.0
x-checkrecipientchecked: true
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12bc87ac-2716-497e-b52b-08d8342eca0f
x-ms-traffictypediagnostic: AM5PR0801MB1906:|DB6PR0801MB1639:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: 
	<DB6PR0801MB1639896372C07219E0F92959F7710@DB6PR0801MB1639.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 mZ+b/Fv1YwchhRtPnbEwcpKJDtVj3/4A+vA32IVzFZLFAVrU6bh0vIrWxwAQ7b4uc69vNpsEL1riKt7Ps8RxLq+Qfhb3HD/l+0j+2udIsR2Je58je1MUCs1bKKsk7kkCtnVnaizP5K9vA9mSnQDivkz9ilxtS5g4TP1w75C0O6JVCbCxqM2ufjKXYFPPMClkWpkxy/n7R81KwtujubZxN7/ReioReweba5lJzRZO9nA5OP3pcUMmDblkJWXyyXSdCyfSbAczo62zyoaEDdAU4PNaNDLDKHg5uj8PD+1TXi4ALQt+qrOOBajAgoBPk/FaGdzeNNBbrgiVzMXC4M8zdw==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(83380400001)(186003)(64756008)(66556008)(66476007)(2906002)(54906003)(66446008)(110136005)(52536014)(7416002)(26005)(5660300002)(76116006)(66946007)(8936002)(8676002)(53546011)(86362001)(4326008)(316002)(55016002)(7696005)(9686003)(478600001)(6506007)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 h4gJ9DU6Lm8nQzWBR4a0ZwnRifIJcW5zOXxNAVPGX2kE1Bn/K4AIMD8/5JuXO80sIMmtoKeIZ1IoUVIEZnHHG1HFv3/HJGJBSI4lY/tjnF1TSOnZEnnf/z12uRjNWiXLp27tLHZUiWCJX/CEwBpGVg3nMLy6p/AFPY8sHpe23cVp2PyxnZX3iLn7iX0YAqY8SKLvZfVgLdM7B3CO/vhpo6HCC8oDy4wK6qe1OY41gcdlE2rTfFbirLYNsYwTjY8DgvkNK+MJHfRVwo4qUgRCCOvxSbGmocWvrLWUvY90FJ+OgkmZe+B4tQ6cWqcRvADgVUU+U8HxV4uiPb3cUvZhwN86Q+e33D1J27ZsRlKIIeNcJZAvG77VgVsgwmZdgZt0IC2Y+hj0iFyLRkMFjPUY+apvt3OFMtBrN5754p3ITpTgAGSHtIYqeDvs6uPtX10Fea94LJmJyLVMpNN5JvVMXGf/6+399r7eUNvhhIclhjU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1906
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	11c7ff36-4b3e-4d8a-e7f5-08d8342ec45c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PwhZqTsgUIU7HnhqHgh0Ot3gUdtc0CTGgdzwicNSgS9JOc2+527E6UVNytsHLUUCtxhQOpcuGiGhl6ytAPwbSBG2Z7zVS+oHHmuMjn/puqwb5pLtJn3GiNWa/TdHaK0GzbdlPySeeHCMzk21+ntcPHyfo1K3HuzU2fwYjltrkn3SosfIziaYvDCS6ITI/4PaTqtLw9VbdcDQvdQyfC9S5DzcbAYbFFEJCWcmCWSklPYJG0NiN2+R3Q9Uq8KY7CbGZEpleo7gSVmBLi+qEolZw3VyTgxB3Ph+sDW9NsgwD3G5xIfTtKwmgZqDJ+OynVXHbd7zwpqeAQTlJ6U40v8nPXx0CN078TkEQF3DaKzYw25grQPDRiHTsWpbuZ+GUXqRIU4lBC2hE/jf0bhL5iaH3A==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(26005)(186003)(52536014)(2906002)(70586007)(70206006)(5660300002)(6506007)(53546011)(7696005)(4326008)(336012)(83380400001)(110136005)(47076004)(82310400002)(86362001)(33656002)(9686003)(8676002)(54906003)(316002)(82740400003)(356005)(81166007)(55016002)(8936002)(478600001)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 02:18:03.5482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc87ac-2716-497e-b52b-08d8342eca0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1639
Message-ID-Hash: LDNPM4EX6SKSGTHD4E36CVOCQJRJPM2L
X-Message-ID-Hash: LDNPM4EX6SKSGTHD4E36CVOCQJRJPM2L
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HK55K27BWJSVOULZGKZIIPOCOKKYTXDI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMjksIDIwMjAgNToz
NSBQTQ0KPiBUbzogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPjsgSnVzdGluIEhl
IDxKdXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPjsgVmlzaGFsIFZlcm1hDQo+IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBD
YXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsNCj4gV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBEYXZl
DQo+IEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+Ow0KPiBTdGV2ZSBDYXBwZXIgPFN0ZXZlLkNhcHBlckBhcm0uY29t
PjsgTWFyayBSdXRsYW5kIDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47DQo+IExvZ2FuIEd1bnRob3Jw
ZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT47IEFuc2h1bWFuIEtoYW5kdWFsDQo+IDxBbnNodW1hbi5L
aGFuZHVhbEBhcm0uY29tPjsgSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPjsgSmFz
b24NCj4gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
bGludXguaW50ZWwuY29tPjsgS2Vlcw0KPiBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC1tbUBrdmFjay5v
cmc7IFdlaQ0KPiBZYW5nIDxyaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbT47IFBhbmthaiBH
dXB0YQ0KPiA8cGFua2FqLmd1cHRhLmxpbnV4QGdtYWlsLmNvbT47IElyYSBXZWlueSA8aXJhLndl
aW55QGludGVsLmNvbT47IEthbHkgWGluDQo+IDxLYWx5LlhpbkBhcm0uY29tPg0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCAwLzZdIGRlY3JlYXNlIHVubmVjZXNzYXJ5IGdhcCBkdWUgdG8gcG1l
bSBrbWVtDQo+IGFsaWdubWVudA0KPiANCj4gT24gMjkuMDcuMjAgMTE6MzEsIE1pa2UgUmFwb3Bv
cnQgd3JvdGU6DQo+ID4gSGkgSnVzdGluLA0KPiA+DQo+ID4gT24gV2VkLCBKdWwgMjksIDIwMjAg
YXQgMDg6Mjc6NThBTSArMDAwMCwgSnVzdGluIEhlIHdyb3RlOg0KPiA+PiBIaSBEYXZpZA0KPiA+
Pj4+DQo+ID4+Pj4gV2l0aG91dCB0aGlzIHNlcmllcywgaWYgcWVtdSBjcmVhdGVzIGEgNEcgYnl0
ZXMgbnZkaW1tIGRldmljZSwgd2UgY2FuDQo+ID4+PiBvbmx5DQo+ID4+Pj4gdXNlIDJHIGJ5dGVz
IGZvciBkYXggcG1lbShrbWVtKSBpbiB0aGUgd29yc3QgY2FzZS4NCj4gPj4+PiBlLmcuDQo+ID4+
Pj4gMjQwMDAwMDAwLTMzZmRmZmZmZiA6IFBlcnNpc3RlbnQgTWVtb3J5DQo+ID4+Pj4gV2UgY2Fu
IG9ubHkgdXNlIHRoZSBtZW1ibG9jayBiZXR3ZWVuIFsyNDAwMDAwMDAsIDJmZmZmZmZmZl0gZHVl
IHRvDQo+IHRoZQ0KPiA+Pj4gaGFyZA0KPiA+Pj4+IGxpbWl0YXRpb24uIEl0IHdhc3RlcyB0b28g
bXVjaCBtZW1vcnkgc3BhY2UuDQo+ID4+Pj4NCj4gPj4+PiBEZWNyZWFzaW5nIHRoZSBTRUNUSU9O
X1NJWkVfQklUUyBvbiBhcm02NCBtaWdodCBiZSBhbiBhbHRlcm5hdGl2ZSwNCj4gYnV0DQo+ID4+
PiB0aGVyZQ0KPiA+Pj4+IGFyZSB0b28gbWFueSBjb25jZXJucyBmcm9tIG90aGVyIGNvbnN0cmFp
bnRzLCBlLmcuIFBBR0VfU0laRSwgaHVnZXRsYiwNCj4gPj4+PiBTUEFSU0VNRU1fVk1FTU1BUCwg
cGFnZSBiaXRzIGluIHN0cnVjdCBwYWdlIC4uLg0KPiA+Pj4+DQo+ID4+Pj4gQmVzaWRlIGRlY3Jl
YXNpbmcgdGhlIFNFQ1RJT05fU0laRV9CSVRTLCB3ZSBjYW4gYWxzbyByZWxheCB0aGUga21lbQ0K
PiA+Pj4gYWxpZ25tZW50DQo+ID4+Pj4gd2l0aCBtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygpLg0K
PiA+Pj4+DQo+ID4+Pj4gVGVzdGVkIG9uIGFybTY0IGd1ZXN0IGFuZCB4ODYgZ3Vlc3QsIHFlbXUg
Y3JlYXRlcyBhIDRHIHBtZW0gZGV2aWNlLg0KPiBkYXgNCj4gPj4+IHBtZW0NCj4gPj4+PiBjYW4g
YmUgdXNlZCBhcyByYW0gd2l0aCBzbWFsbGVyIGdhcC4gQWxzbyB0aGUga21lbSBob3RwbHVnIGFk
ZC9yZW1vdmUNCj4gPj4+IGFyZSBib3RoDQo+ID4+Pj4gdGVzdGVkIG9uIGFybTY0L3g4NiBndWVz
dC4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+IEkgYW0gbm90IGNvbnZp
bmNlZCB0aGlzIHVzZSBjYXNlIGlzIHdvcnRoIHN1Y2ggaGFja3MgKHRoYXTigJlzIHdoYXQgaXQN
Cj4gaXMpDQo+ID4+PiBmb3Igbm93LiBPbiByZWFsIG1hY2hpbmVzIHBtZW0gaXMgYmlnIC0geW91
ciBleGFtcGxlIChsb3NpbmcgNTAlIGlzDQo+ID4+PiBleHRyZW1lKS4NCj4gPj4+DQo+ID4+PiBJ
IHdvdWxkIG11Y2ggcmF0aGVyIHdhbnQgdG8gc2VlIHRoZSBzZWN0aW9uIHNpemUgb24gYXJtNjQg
cmVkdWNlZC4gSQ0KPiA+Pj4gcmVtZW1iZXIgdGhlcmUgd2VyZSBwYXRjaGVzIGFuZCB0aGF0IGF0
IGxlYXN0IHdpdGggYSBiYXNlIHBhZ2Ugc2l6ZSBvZg0KPiA0aw0KPiA+Pj4gaXQgY2FuIGJlIHJl
ZHVjZWQgZHJhc3RpY2FsbHkgKDY0ayBiYXNlIHBhZ2VzIGFyZSBtb3JlIHByb2JsZW1hdGljIGR1
ZQ0KPiB0bw0KPiA+Pj4gdGhlIHJpZGljdWxvdXMgVEhQIHNpemUgb2YgNTEyTSkuIEJ1dCBjb3Vs
ZCBiZSBhIHNlY3Rpb24gc2l6ZSBvZiA1MTINCj4gaXMNCj4gPj4+IHBvc3NpYmxlIG9uIGFsbCBj
b25maWdzIHJpZ2h0IG5vdy4NCj4gPj4NCj4gPj4gWWVzLCBJIG9uY2UgaW52ZXN0aWdhdGVkIGhv
dyB0byByZWR1Y2Ugc2VjdGlvbiBzaXplIG9uIGFybTY0DQo+IHRob3VnaHRmdWxseToNCj4gPj4g
VGhlcmUgYXJlIG1hbnkgY29uc3RyYWludHMgZm9yIHJlZHVjaW5nIFNFQ1RJT05fU0laRV9CSVRT
DQo+ID4+IDEuIEdpdmVuIHBhZ2UtPmZsYWdzIGJpdHMgaXMgbGltaXRlZCwgU0VDVElPTl9TSVpF
X0JJVFMgY2FuJ3QgYmUNCj4gcmVkdWNlZCB0b28NCj4gPj4gICAgbXVjaC4NCj4gPj4gMi4gT25j
ZSBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgZW5hYmxlZCwgc2VjdGlvbiBpZCB3aWxsIG5v
dCBiZQ0KPiBjb3VudGVkDQo+ID4+ICAgIGludG8gcGFnZS0+ZmxhZ3MuDQo+ID4+IDMuIE1BWF9P
UkRFUiBkZXBlbmRzIG9uIFNFQ1RJT05fU0laRV9CSVRTDQo+ID4+ICAtIDMuMSBtbXpvbmUuaA0K
PiA+PiAjaWYgKE1BWF9PUkRFUiAtIDEgKyBQQUdFX1NISUZUKSA+IFNFQ1RJT05fU0laRV9CSVRT
DQo+ID4+ICNlcnJvciBBbGxvY2F0b3IgTUFYX09SREVSIGV4Y2VlZHMgU0VDVElPTl9TSVpFDQo+
ID4+ICNlbmRpZg0KPiA+PiAgLSAzLjIgaHVnZXBhZ2VfaW5pdCgpDQo+ID4+IE1BWUJFX0JVSUxE
X0JVR19PTihIUEFHRV9QTURfT1JERVIgPj0gTUFYX09SREVSKTsNCj4gPj4NCj4gPj4gSGVuY2Ug
d2hlbiBBUk02NF80S19QQUdFUyAmJiBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgYXJlIGVuYWJs
ZWQsDQo+ID4+IFNFQ1RJT05fU0laRV9CSVRTIGNhbiBiZSByZWR1Y2VkIHRvIDI3Lg0KPiA+PiBC
dXQgd2hlbiBBUk02NF82NEtfUEFHRVMsIGdpdmVuIDMuMiwgTUFYX09SREVSID4gMjktMTYgPSAx
My4NCj4gPj4gR2l2ZW4gMy4xIFNFQ1RJT05fU0laRV9CSVRTID49IE1BWF9PUkRFUisxNSA+IDI4
LiBTbyBTRUNUSU9OX1NJWkVfQklUUw0KPiBjYW4gbm90DQo+ID4+IGJlIHJlZHVjZWQgdG8gMjcu
DQo+ID4+DQo+ID4+IEluIG9uZSB3b3JkLCBpZiB3ZSBjb25zaWRlcmVkIHRvIHJlZHVjZSBTRUNU
SU9OX1NJWkVfQklUUyBvbiBhcm02NCwgdGhlDQo+IEtjb25maWcNCj4gPj4gbWlnaHQgYmUgdmVy
eSBjb21wbGljYXRlZCxlLmcuIHdlIHN0aWxsIG5lZWQgdG8gY29uc2lkZXIgdGhlIGNhc2UgZm9y
DQo+ID4+IEFSTTY0XzE2S19QQUdFUy4NCj4gPg0KPiA+IEl0IGlzIG5vdCBuZWNlc3NhcnkgdG8g
cG9sbHV0ZSBLY29uZmlnIHdpdGggdGhhdC4NCj4gPiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3Nw
YXJlc2VtZW0uaCBjYW4gaGF2ZSBzb21ldGhpbmcgbGlrZQ0KPiA+DQo+ID4gI2lmZGVmIENPTkZJ
R19BUk02NF82NEtfUEFHRVMNCj4gPiAjZGVmaW5lIFNQQVJTRV9TRUNUSU9OX1NJWkUgMjkNCj4g
PiAjZWxpZiBkZWZpbmVkKENPTkZJR19BUk0xNktfUEFHRVMpDQo+ID4gI2RlZmluZSBTUEFSU0Vf
U0VDVElPTl9TSVpFIDI4DQo+ID4gI2VsaWYgZGVmaW5lZChDT05GSUdfQVJNNEtfUEFHRVMpDQo+
ID4gI2RlZmluZSBTUEFSU0VfU0VDVElPTl9TSVpFIDI3DQo+ID4gI2Vsc2UNCj4gPiAjZXJyb3IN
Cj4gPiAjZW5kaWYNCj4gDQo+IGFjaw0KVGhhbmtzLCBEYXZpZCBhbmQgTWlrZS4gV2lsbCBkaXNj
dXNzIGl0IGZ1cnRoZXIgbW9yZSB3aXRoIGFybSBpbnRlcm5hbGx5IGFib3V0DQp0aGUgdGhvdWdo
dGZ1bCBzZWN0aW9uX3NpemUgY2hhbmdlDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
