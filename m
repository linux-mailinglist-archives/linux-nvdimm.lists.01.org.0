Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD347DB3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:57:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D746221962301;
	Mon, 17 Jun 2019 01:57:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.71.58; helo=nam05-by2-obe.outbound.protection.outlook.com;
 envelope-from=jacky.wu@memverge.com; receiver=linux-nvdimm@lists.01.org 
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710058.outbound.protection.outlook.com [40.107.71.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4FB0321296B16
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=memverge.onmicrosoft.com; s=selector1-memverge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqoFOtxSdAI8mJIA0KpqXKzFWV2YCvnJrsDHQxB57xU=;
 b=RpAd7X3pLp4e2m7zyUniTImJZfu/R8UZFEW63DFVob6FDtP/SeZ1X/iSCtCx+8+WU7ouHfdlLj2A3vEJ7GB66TqM/UrFhv/H8Yzcb76YSMVRBU75T1pYxZhspOHei+bnrdYgHSdK6ErsHiP9iOKaUxUx7XFbRc77xgIGZUq+COo=
Received: from DM6PR17MB3369.namprd17.prod.outlook.com (20.176.127.78) by
 DM6PR17MB2556.namprd17.prod.outlook.com (20.177.218.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 08:57:41 +0000
Received: from DM6PR17MB3369.namprd17.prod.outlook.com
 ([fe80::b882:66a:27ae:3ef6]) by DM6PR17MB3369.namprd17.prod.outlook.com
 ([fe80::b882:66a:27ae:3ef6%3]) with mapi id 15.20.1965.019; Mon, 17 Jun 2019
 08:57:41 +0000
From: Jacky Wu <jacky.wu@memverge.com>
To: Yue Li <yue.li@memverge.com>, Dan Williams <dan.j.williams@intel.com>
Subject: RE: ndctl hangs after memory deregistration
Thread-Topic: ndctl hangs after memory deregistration
Thread-Index: AQHVIZ2h/38SJcCyuUuJqqWUyP3fR6aZ8tEAgADKbYCABL8g4A==
Date: Mon, 17 Jun 2019 08:57:41 +0000
Message-ID: <DM6PR17MB3369B9A9E76E1632DFF0E5CBE5EB0@DM6PR17MB3369.namprd17.prod.outlook.com>
References: <41115947-1EBD-4686-8196-C06BD23CECE6@memverge.com>
 <CAA9_cmcNNN6fUQmKU_9Rw-6H84p-=e1DZiAcra+H1Ed=T_CALg@mail.gmail.com>
 <4C50C748-FD16-4AC8-A870-1E47ADB4CAF7@memverge.com>
In-Reply-To: <4C50C748-FD16-4AC8-A870-1E47ADB4CAF7@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jacky.wu@memverge.com; 
x-originating-ip: [116.236.182.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44c3b3e0-2ddf-48e9-a13b-08d6f301db28
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(49563074)(7193020);
 SRVR:DM6PR17MB2556; 
x-ms-traffictypediagnostic: DM6PR17MB2556:
x-ld-processed: 5c90cb59-37e7-4c81-9c07-00473d5fb682,ExtAddr
x-microsoft-antispam-prvs: <DM6PR17MB25564922AE4E5A804E70E932E5EB0@DM6PR17MB2556.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(396003)(366004)(39830400003)(346002)(13464003)(51914003)(189003)(199004)(66066001)(55016002)(9686003)(6116002)(7696005)(76176011)(478600001)(71200400001)(71190400001)(86362001)(2906002)(6436002)(5660300002)(53936002)(52536014)(99286004)(7736002)(305945005)(486006)(44832011)(4326008)(66476007)(74316002)(64756008)(66556008)(99936001)(476003)(81166006)(11346002)(8936002)(229853002)(66946007)(6246003)(256004)(14444005)(68736007)(66446008)(33656002)(5024004)(66616009)(316002)(14454004)(26005)(54906003)(186003)(76116006)(102836004)(6506007)(53546011)(3846002)(81156014)(25786009)(8676002)(446003)(110136005)(73956011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR17MB2556;
 H:DM6PR17MB3369.namprd17.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: memverge.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pfae9Gu1kVLRgHJxHNFWYanRiz1TaGpFkCw2hBIgigVCM/dCiq1zYW0e465enD827LHYu6AqzNj5/LA4Ul9kPpMXeNyYNKA60iPmEP915UHm/Ij3cbDEasqaAHd/fjPUMlYtoqijcXkl8yNgM4QgxiQK3Bb300vYJcCBXKVJ/+nPcmJt7RXkswp3Yj+yoxRMRlhMgFYg38KG8eiGDkp9MhoV7opsCIx/L4kALaJawpIP/D8Z87Q2wj+rDKb6TVrBRA+SK7alFVCC8eD/4MpDI1jboO6/S2laEu+3o/gpS/ejj83ACaX84hOmlUK5/B9zuheFinU0kTaZALooUQqVfg+N/FgPbfMdNOH9VFC8OJU8A+Amocsy986EIDIR6qU6sMsrp6oBdRUrxPdlvDGlsLOMWfmVmryXo1igznHY+To=
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c3b3e0-2ddf-48e9-a13b-08d6f301db28
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 08:57:41.5464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jacky.wu@memverge.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2556
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "Scargall, Steve" <steve.scargall@intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

SGkgRGFuLA0KDQpJIHdyb3RlIGEgc21hbGwgcHJvZ3JhbSB0byBzaW11bGF0ZSBvdXIgdXNlIGNh
c2UsIGFuZCB0ZXN0ZWQgMyBjYXNlcywgZG8gbm8gcmVnaXN0ZXIvdW5yZWdpc3RlciwgZG8gcmVn
aXN0ZXIgb25seSBidXQgbm8gdW5yZWdpc3RlciwgZG8gYm90aCByZWdpc3Rlci91bnJlZ2lzdGVy
LCBhbmQgbmRjdGwgY29tbWFuZCBodW5nIGluIGxhdHRlciB0d28gY2FzZXMuICBJJ20gYXR0YWNo
aW5nIHRoZSBzb3VyY2UgY29kZSBmb3IgeW91ciByZWZlcmVuY2UuDQoNCkkgd2lsbCB0cnkgdXNp
bmcgbGF0ZXN0IGtlcm5lbCBuZXh0Lg0KDQpUaGFua3MsDQpKYWNreQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogWXVlIExpIDx5dWUubGlAbWVtdmVyZ2UuY29tPiANClNlbnQ6
IEZyaWRheSwgSnVuZSAxNCwgMjAxOSA3OjEwIEFNDQpUbzogRGFuIFdpbGxpYW1zIDxkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+DQpDYzogU2NhcmdhbGwsIFN0ZXZlIDxzdGV2ZS5zY2FyZ2FsbEBp
bnRlbC5jb20+OyBKYWNreSBXdSA8amFja3kud3VAbWVtdmVyZ2UuY29tPjsgbGludXgtbnZkaW1t
QGxpc3RzLjAxLm9yZw0KU3ViamVjdDogUmU6IG5kY3RsIGhhbmdzIGFmdGVyIG1lbW9yeSBkZXJl
Z2lzdHJhdGlvbg0KDQpUaGFua3MgRGFuIGZvciB0aGUgcmVwbHkhDQoNCu+7v09uIDYvMTQvMTks
IDM6MDYgQU0sICJEYW4gV2lsbGlhbXMiIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3Rl
Og0KDQogICAgT24gV2VkLCBKdW4gMTIsIDIwMTkgYXQgOTowOCBQTSBZdWUgTGkgPHl1ZS5saUBt
ZW12ZXJnZS5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+IGhpIERhbiBhbmQgU3RldmUsDQogICAg
Pg0KICAgID4NCiAgICANCiAgICBIaSwNCiAgICANCiAgICBJIGp1c3QgaGFwcGVuZWQgdG8gc2Vl
IHRoaXMgYnkgbHVjaywgcGxlYXNlIHVzZSBteSBJbnRlbCBhZGRyZXNzLCBhbmQNCiAgICBjb3B5
IHRoZSBsaWJudmRpbW0gbWFpbGluZyBsaXN0IG9uIGlzc3VlcyBsaWtlIHRoaXMNCiAgICAobGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZykuDQoNCk9LLg0KICAgIA0KICAgID4gV2UgcmVjZW50bHkg
cmFuIGludG8gYSBzdHJhbmdlIGlzc3VlIHdoZXJlIG5kY3RsIGNvbW1hbmQgaGFuZ3Mgb24gZGV2
IGRheCBhZnRlciBvdXIgc29mdHdhcmUgdXNlcyBpdC4NCiAgICANCiAgICBUaGUgbGFzdCB0aGlu
ZyB0aGF0IGRldmljZS1kYXggdGVhcmRvd24gZG9lcyBpcyB3YWl0IGZvciBhbnkgcGlubmVkDQog
ICAgcGFnZXMgdG8gYmUgcmVsZWFzZWQgYmVmb3JlIGFsbG93aW5nIHRoZSBleGl0IHRvIHByb2Nl
ZWQuDQogICAgDQpPSy4NCg0KICAgID4gSW5zaWRlIG91ciBhcHBsaWNhdGlvbiwgd2UgYmFzaWNh
bGx5IHdpbGwgZmlyc3QgUkRNQSByZWdpc3RlciB0aGUgd2hvbGUgZGV2aWNlLCB0aGVuIGRlcmVn
aXN0ZXIsIGFuZCBleGl0Lg0KICAgIA0KICAgIElzIHRoaXMganVzdCB1c2luZyBzaW1wbGUgaWJ2
ZXJicyB0byB1bnJlZ2lzdGVyIG9yIHNvbWV0aGluZyBzcGVjaWZpYw0KICAgIHRvIHRoaXMgZHJp
dmVyLg0KICAgIA0KICAgIFRoZXJlIHdhcyBhIGJ1ZyB1cHN0cmVhbSB0aGF0IGFkZHJlc3NlZCBj
YXNlcyB3aGVyZSBkZXZpY2UgdGVhcmRvd24NCiAgICBwcm9jZWVkZWQgd2hlbiBpdCBzaG91bGRu
J3QsIGJ1dCB0aGUgc2VxdWVuY2UgeW91IGRlc2NyaWJlIGlzIHRoZQ0KICAgIG9wcG9zaXRlIHRo
ZSBwYWdlcyBwaW5zIHNob3VsZCBiZSB0b3JuIGRvd24gYmVmb3JlIHRoZSBkZXZpY2UNCiAgICBy
ZWNvbmZpZ3VyYXRpb24uDQoNCiAgICA+IEhvd2V2ZXIsIGlmIHdlIHJlbW92ZSB0aGUgcmVnaXN0
cmF0aW9uIGFuZCBkZXJlZ2lzdHJhdGlvbiBjb2RlLCBuZGN0bCB3b3JrcyBjb3JyZWN0bHkgd2l0
aG91dCBoYW5naW5nLiBUaGUgcHJvYmxlbSBvY2N1cnMgYm90aCBvbiBEUkFNIGVtdWxhdGVkIGRh
eCBhcyB3ZWxsIGFzIHJlYWwgUE1FTSBiYWNrZWQgZGF4Lg0KICAgID4NCiAgICA+IEhlcmUgaXMg
b3VyIHN5c3RlbSBpbmZvcm1hdGlvbjoNCiAgICA+DQogICAgPg0KICAgID4NCiAgICA+IENlbnRP
UyA3LjYNCiAgICA+DQogICAgPiBWYW5pbGxhIGtlcm5lbCAzLjEwLjAtOTU3LmVsNy54ODZfNjQN
CiAgICANCiAgICBBcmUgeW91IGZhbWlsaWFyIHdpdGggcmVidWlsZGluZyB0aGUga2VybmVsPyBJ
J2QgYXNrIHlvdSB0byB0cnkgdG8NCiAgICByZXByb2R1Y2Ugd2l0aCB0aGUgbGF0ZXN0IGRldmVs
b3BtZW50IGtlcm5lbCB0aGF0IGluY2x1ZGVzIHRoZXNlDQogICAgZml4ZXM6DQogICAgDQogICAg
NDQyMmVlODQ3NmYwIG1tL2Rldm1fbWVtcmVtYXBfcGFnZXM6IGZpeCBmaW5hbCBwYWdlIHB1dCBy
YWNlDQogICAgNzcxZjA3MTRkMGRjIFBDSS9QMlBETUE6IHRyYWNrIHBnbWFwIHJlZmVyZW5jZXMg
cGVyIHJlc291cmNlLCBub3QgZ2xvYmFsbHkNCiAgICBhZjM3MDg1ZGU5MDYgbGliL2dlbmFsbG9j
OiBpbnRyb2R1Y2UgY2h1bmsgb3duZXJzDQogICAgZTAwNDdmZjhhYTc3IFBDSS9QMlBETUE6IGZp
eCB0aGUgZ2VuX3Bvb2xfYWRkX3ZpcnQoKSBmYWlsdXJlIHBhdGgNCiAgICAwMzE1ZDQ3ZDZhZTkg
bW0vZGV2bV9tZW1yZW1hcF9wYWdlczogaW50cm9kdWNlIGRldm1fbWVtdW5tYXBfcGFnZXMNCiAg
ICAyMTY0NzVjN2VhYTggZHJpdmVycy9iYXNlL2RldnJlczogaW50cm9kdWNlIGRldm1fcmVsZWFz
ZV9hY3Rpb24oKQ0KICAgIA0KICAgIC4uLmJ1dCBpdCBzb3VuZHMgbGlrZSB5b3UgbWF5IGJlIGhp
dHRpbmcgYSBkaWZmZXJlbnQgaXNzdWUuDQogICAgDQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9u
LCB3ZSB3aWxsIGRvd25sb2FkIHRoZSB1cHN0cmVhbSBrZXJuZWwgYW5kIHRyeSBpdCBhZ2Fpbi4g
V2lsbCBwb3N0IHRoZSByZXN1bHRzIHNvb24uIA0KDQpCZXN0LCANCg0KWXVlDQoNCg0KDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAx
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
