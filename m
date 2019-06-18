Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDA497B6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Jun 2019 05:15:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C87A221296065;
	Mon, 17 Jun 2019 20:15:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.74.51; helo=nam01-bn3-obe.outbound.protection.outlook.com;
 envelope-from=jacky.wu@memverge.com; receiver=linux-nvdimm@lists.01.org 
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740051.outbound.protection.outlook.com [40.107.74.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D898221290DE3
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=memverge.onmicrosoft.com; s=selector1-memverge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFhEVtMiqlJOE7/Upw1CBMoxHLzS+/QwSqxjzH3B8Xg=;
 b=CKvFq9/+jBhHluMTWkDxv7nANCa6/oTeAhUYWoRd0h2YcAGLUdiucaa9lijrfwkgVrxLgXZrtPloSScN/Kk6s44kfnxogX6xldDMjrWER50ONbv7kBlsFY/MgYv24KM8CrVn3BSqUTS0AaJLZox92Sv8sW60SRQJzous/GQ8rAU=
Received: from DM6PR17MB3369.namprd17.prod.outlook.com (20.176.127.78) by
 DM6PR17MB2875.namprd17.prod.outlook.com (20.178.227.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 03:15:45 +0000
Received: from DM6PR17MB3369.namprd17.prod.outlook.com
 ([fe80::b882:66a:27ae:3ef6]) by DM6PR17MB3369.namprd17.prod.outlook.com
 ([fe80::b882:66a:27ae:3ef6%3]) with mapi id 15.20.1965.019; Tue, 18 Jun 2019
 03:15:45 +0000
From: Jacky Wu <jacky.wu@memverge.com>
To: Yue Li <yue.li@memverge.com>, Dan Williams <dan.j.williams@intel.com>
Subject: RE: ndctl hangs after memory deregistration
Thread-Topic: ndctl hangs after memory deregistration
Thread-Index: AQHVIZ2h/38SJcCyuUuJqqWUyP3fR6aZ8tEAgADKbYCABL8g4IABRyRA
Date: Tue, 18 Jun 2019 03:15:45 +0000
Message-ID: <DM6PR17MB336977BC3CB20B9796C0BEDAE5EA0@DM6PR17MB3369.namprd17.prod.outlook.com>
References: <41115947-1EBD-4686-8196-C06BD23CECE6@memverge.com>
 <CAA9_cmcNNN6fUQmKU_9Rw-6H84p-=e1DZiAcra+H1Ed=T_CALg@mail.gmail.com>
 <4C50C748-FD16-4AC8-A870-1E47ADB4CAF7@memverge.com>
 <DM6PR17MB3369B9A9E76E1632DFF0E5CBE5EB0@DM6PR17MB3369.namprd17.prod.outlook.com>
In-Reply-To: <DM6PR17MB3369B9A9E76E1632DFF0E5CBE5EB0@DM6PR17MB3369.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jacky.wu@memverge.com; 
x-originating-ip: [116.236.182.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a042a77-5ed6-4f6f-819b-08d6f39b4120
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR17MB2875; 
x-ms-traffictypediagnostic: DM6PR17MB2875:
x-ms-exchange-purlcount: 2
x-ld-processed: 5c90cb59-37e7-4c81-9c07-00473d5fb682,ExtAddr
x-microsoft-antispam-prvs: <DM6PR17MB2875948E6E009198A921852DE5EA0@DM6PR17MB2875.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(376002)(346002)(39830400003)(136003)(189003)(199004)(13464003)(51914003)(26005)(5024004)(66556008)(236005)(55016002)(66476007)(71200400001)(71190400001)(6116002)(790700001)(446003)(229853002)(316002)(9686003)(186003)(54896002)(6306002)(3846002)(486006)(7736002)(6436002)(74316002)(99286004)(66446008)(76176011)(64756008)(25786009)(68736007)(81156014)(8936002)(5660300002)(6246003)(33656002)(7696005)(102836004)(14454004)(81166006)(6506007)(53546011)(476003)(478600001)(2906002)(44832011)(66066001)(8676002)(110136005)(66946007)(11346002)(4326008)(53936002)(73956011)(54906003)(256004)(86362001)(52536014)(14444005)(76116006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR17MB2875;
 H:DM6PR17MB3369.namprd17.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: memverge.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5HsAlekz0f/VRLIsKD5TYYFEOuQPjsDkjmvsCPFqEasR8FcxENCVS3nG8WuEwfVW1dqqYBli2u0Nh1Ds117m2r5h+5GE2SBwH45r32x199o56GQyK+gJxvcxuZi7r8gEwu47Jq6WG6nzNHPmqcPGtQjzHxli6hTXOmy9T5uSRCTXCthg7PTxJzfKWqXKZ3c+uAWGUefFWwt8BZSDdlMBXW0TMgVPghb8MeS2Qu1hK0H/Qs6jhmLuilaoQ7pYw7lgyx9CkqrVYEo+uL+zAnlYUGWEIBuudzP8GdqI8eeGEGvE+DgtVfkMg5fr4aLNxMMI2oMpZPFhtte5jr7AzKxJV0UfwgvztokpvxINb8CbB38NHSDuigQXFOrGgjwaeOMiMZ4hPeeFYJi3o3B6lU7a2qluPM4OozH1RRA3NHdHDk=
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a042a77-5ed6-4f6f-819b-08d6f39b4120
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 03:15:45.6814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jacky.wu@memverge.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB2875
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

VHJpZWQgb24ga2VybmVsIDQuMTguMjAgYW5kIHRoaXMgaXNzdWUgaXMgbm90IHNlZW4uDQoNCg0K
DQpbcm9vdEBsb2NhbGhvc3Qgfl0jIC4vdGVzdC1pYnZfcmVnIDEwLjguOC4xMzMgL2Rldi9kYXgw
LjAgMw0KDQpDcmVhdGluZyBSRE1BIGV2ZW50IGNoYW5uZWwuDQoNCkNyZWF0aW5nIFJETUEgY29t
bXVuaWNhdGlvbiBpZGVudGlmaWVyLg0KDQpSRE1BIGJpbmQgYWRkcmVzcyB0byAxMC44LjguMTMz
DQoNClJETUEgc3RhcnQgbGlzdGVuDQoNClJlZ2lzdGVyIG1lbW9yeSByZWdpb24uDQoNClVucmVn
aXN0ZXIgbWVtb3J5IHJlZ2lvbi4NCg0KUG9vbCB1bm1hcHBlZC4NCg0KUG9vbCBoYW5kbGVyIGNs
b3NlZC4NCg0KUG9vbCBjbG9zZWQuDQoNCkRlLWFsbG9jYXRlZCBQRC4NCg0KRGVzdHJveWVkIFJE
TUEgY29tbXVuaWNhdGlvbiBpZGVudGlmaWVyLg0KDQpEZXN0cm95ZWQgUkRNQSBldmVudCBjaGFu
bmVsLg0KDQpbcm9vdEBsb2NhbGhvc3Qgfl0jIG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLWZlIG5h
bWVzcGFjZTAuMCAtYSA0aw0KDQp7DQoNCiAgImRldiI6Im5hbWVzcGFjZTAuMCIsDQoNCiAgIm1v
ZGUiOiJkZXZkYXgiLA0KDQogICJtYXAiOiJkZXYiLA0KDQogICJzaXplIjoiNy44NyBHaUIgKDgu
NDUgR0IpIiwNCg0KICAidXVpZCI6Ijc0M2VjNDg1LTZjNzctNDMyMy05MGNhLTVhZDg2NGEwMGU3
MiIsDQoNCiAgImRheHJlZ2lvbiI6ew0KDQogICAgImlkIjowLA0KDQogICAgInNpemUiOiI3Ljg3
IEdpQiAoOC40NSBHQikiLA0KDQogICAgImFsaWduIjo0MDk2LA0KDQogICAgImRldmljZXMiOlsN
Cg0KICAgICAgew0KDQogICAgICAgICJjaGFyZGV2IjoiZGF4MC4wIiwNCg0KICAgICAgICAic2l6
ZSI6IjcuODcgR2lCICg4LjQ1IEdCKSINCg0KICAgICAgfQ0KDQogICAgXQ0KDQogIH0sDQoNCiAg
Im51bWFfbm9kZSI6MA0KDQp9DQoNCg0KDQpbcm9vdEBsb2NhbGhvc3Qgfl0jIHVuYW1lIC1hDQoN
CkxpbnV4IGxvY2FsaG9zdC5sb2NhbGRvbWFpbiA0LjE4LjIwICMxIFNNUCBNb24gSnVuIDE3IDA2
OjQzOjE5IEVEVCAyMDE5IHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eA0KDQoNCg0KDQoN
ClRoYW5rcywNCg0KSmFja3kNCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBKYWNreSBXdQ0KU2VudDogTW9uZGF5LCBKdW5lIDE3LCAyMDE5IDQ6NTggUE0NClRvOiBZdWUg
TGkgPHl1ZS5saUBtZW12ZXJnZS5jb20+OyBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGlu
dGVsLmNvbT4NCkNjOiBTY2FyZ2FsbCwgU3RldmUgPHN0ZXZlLnNjYXJnYWxsQGludGVsLmNvbT47
IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNClN1YmplY3Q6IFJFOiBuZGN0bCBoYW5ncyBhZnRl
ciBtZW1vcnkgZGVyZWdpc3RyYXRpb24NCg0KDQoNCkhpIERhbiwNCg0KDQoNCkkgd3JvdGUgYSBz
bWFsbCBwcm9ncmFtIHRvIHNpbXVsYXRlIG91ciB1c2UgY2FzZSwgYW5kIHRlc3RlZCAzIGNhc2Vz
LCBkbyBubyByZWdpc3Rlci91bnJlZ2lzdGVyLCBkbyByZWdpc3RlciBvbmx5IGJ1dCBubyB1bnJl
Z2lzdGVyLCBkbyBib3RoIHJlZ2lzdGVyL3VucmVnaXN0ZXIsIGFuZCBuZGN0bCBjb21tYW5kIGh1
bmcgaW4gbGF0dGVyIHR3byBjYXNlcy4gIEknbSBhdHRhY2hpbmcgdGhlIHNvdXJjZSBjb2RlIGZv
ciB5b3VyIHJlZmVyZW5jZS4NCg0KDQoNCkkgd2lsbCB0cnkgdXNpbmcgbGF0ZXN0IGtlcm5lbCBu
ZXh0Lg0KDQoNCg0KVGhhbmtzLA0KDQpKYWNreQ0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCg0KRnJvbTogWXVlIExpIDx5dWUubGlAbWVtdmVyZ2UuY29tPG1haWx0bzp5dWUubGlA
bWVtdmVyZ2UuY29tPj4NCg0KU2VudDogRnJpZGF5LCBKdW5lIDE0LCAyMDE5IDc6MTAgQU0NCg0K
VG86IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPG1haWx0bzpkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+Pg0KDQpDYzogU2NhcmdhbGwsIFN0ZXZlIDxzdGV2ZS5zY2FyZ2Fs
bEBpbnRlbC5jb208bWFpbHRvOnN0ZXZlLnNjYXJnYWxsQGludGVsLmNvbT4+OyBKYWNreSBXdSA8
amFja3kud3VAbWVtdmVyZ2UuY29tPG1haWx0bzpqYWNreS53dUBtZW12ZXJnZS5jb20+PjsgbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZzxtYWlsdG86bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZz4N
Cg0KU3ViamVjdDogUmU6IG5kY3RsIGhhbmdzIGFmdGVyIG1lbW9yeSBkZXJlZ2lzdHJhdGlvbg0K
DQoNCg0KVGhhbmtzIERhbiBmb3IgdGhlIHJlcGx5IQ0KDQoNCg0K77u/T24gNi8xNC8xOSwgMzow
NiBBTSwgIkRhbiBXaWxsaWFtcyIgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTxtYWlsdG86ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPj4gd3JvdGU6DQoNCg0KDQogICAgT24gV2VkLCBKdW4gMTIs
IDIwMTkgYXQgOTowOCBQTSBZdWUgTGkgPHl1ZS5saUBtZW12ZXJnZS5jb208bWFpbHRvOnl1ZS5s
aUBtZW12ZXJnZS5jb20+PiB3cm90ZToNCg0KICAgID4NCg0KICAgID4gaGkgRGFuIGFuZCBTdGV2
ZSwNCg0KICAgID4NCg0KICAgID4NCg0KDQoNCiAgICBIaSwNCg0KDQoNCiAgICBJIGp1c3QgaGFw
cGVuZWQgdG8gc2VlIHRoaXMgYnkgbHVjaywgcGxlYXNlIHVzZSBteSBJbnRlbCBhZGRyZXNzLCBh
bmQNCg0KICAgY29weSB0aGUgbGlibnZkaW1tIG1haWxpbmcgbGlzdCBvbiBpc3N1ZXMgbGlrZSB0
aGlzDQoNCiAgICAobGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZzxtYWlsdG86bGludXgtbnZkaW1t
QGxpc3RzLjAxLm9yZz4pLg0KDQoNCg0KT0suDQoNCg0KDQogICAgPiBXZSByZWNlbnRseSByYW4g
aW50byBhIHN0cmFuZ2UgaXNzdWUgd2hlcmUgbmRjdGwgY29tbWFuZCBoYW5ncyBvbiBkZXYgZGF4
IGFmdGVyIG91ciBzb2Z0d2FyZSB1c2VzIGl0Lg0KDQoNCg0KICAgIFRoZSBsYXN0IHRoaW5nIHRo
YXQgZGV2aWNlLWRheCB0ZWFyZG93biBkb2VzIGlzIHdhaXQgZm9yIGFueSBwaW5uZWQNCg0KICAg
IHBhZ2VzIHRvIGJlIHJlbGVhc2VkIGJlZm9yZSBhbGxvd2luZyB0aGUgZXhpdCB0byBwcm9jZWVk
Lg0KDQoNCg0KT0suDQoNCg0KDQogICAgPiBJbnNpZGUgb3VyIGFwcGxpY2F0aW9uLCB3ZSBiYXNp
Y2FsbHkgd2lsbCBmaXJzdCBSRE1BIHJlZ2lzdGVyIHRoZSB3aG9sZSBkZXZpY2UsIHRoZW4gZGVy
ZWdpc3RlciwgYW5kIGV4aXQuDQoNCg0KDQogICAgSXMgdGhpcyBqdXN0IHVzaW5nIHNpbXBsZSBp
YnZlcmJzIHRvIHVucmVnaXN0ZXIgb3Igc29tZXRoaW5nIHNwZWNpZmljDQoNCiAgICB0byB0aGlz
IGRyaXZlci4NCg0KDQoNCiAgICBUaGVyZSB3YXMgYSBidWcgdXBzdHJlYW0gdGhhdCBhZGRyZXNz
ZWQgY2FzZXMgd2hlcmUgZGV2aWNlIHRlYXJkb3duDQoNCiAgICBwcm9jZWVkZWQgd2hlbiBpdCBz
aG91bGRuJ3QsIGJ1dCB0aGUgc2VxdWVuY2UgeW91IGRlc2NyaWJlIGlzIHRoZQ0KDQogICAgb3Bw
b3NpdGUgdGhlIHBhZ2VzIHBpbnMgc2hvdWxkIGJlIHRvcm4gZG93biBiZWZvcmUgdGhlIGRldmlj
ZQ0KDQogICAgcmVjb25maWd1cmF0aW9uLg0KDQoNCg0KICAgID4gSG93ZXZlciwgaWYgd2UgcmVt
b3ZlIHRoZSByZWdpc3RyYXRpb24gYW5kIGRlcmVnaXN0cmF0aW9uIGNvZGUsIG5kY3RsIHdvcmtz
IGNvcnJlY3RseSB3aXRob3V0IGhhbmdpbmcuIFRoZSBwcm9ibGVtIG9jY3VycyBib3RoIG9uIERS
QU0gZW11bGF0ZWQgZGF4IGFzIHdlbGwgYXMgcmVhbCBQTUVNIGJhY2tlZCBkYXguDQoNCiAgICA+
DQoNCiAgICA+IEhlcmUgaXMgb3VyIHN5c3RlbSBpbmZvcm1hdGlvbjoNCg0KICAgID4NCg0KICAg
ID4NCg0KICAgID4NCg0KICAgID4gQ2VudE9TIDcuNg0KDQogICAgPg0KDQogICAgPiBWYW5pbGxh
IGtlcm5lbCAzLjEwLjAtOTU3LmVsNy54ODZfNjQNCg0KDQoNCiAgICBBcmUgeW91IGZhbWlsaWFy
IHdpdGggcmVidWlsZGluZyB0aGUga2VybmVsPyBJJ2QgYXNrIHlvdSB0byB0cnkgdG8NCg0KICAg
IHJlcHJvZHVjZSB3aXRoIHRoZSBsYXRlc3QgZGV2ZWxvcG1lbnQga2VybmVsIHRoYXQgaW5jbHVk
ZXMgdGhlc2UNCg0KICAgIGZpeGVzOg0KDQoNCg0KICAgIDQ0MjJlZTg0NzZmMCBtbS9kZXZtX21l
bXJlbWFwX3BhZ2VzOiBmaXggZmluYWwgcGFnZSBwdXQgcmFjZQ0KDQogICAgNzcxZjA3MTRkMGRj
IFBDSS9QMlBETUE6IHRyYWNrIHBnbWFwIHJlZmVyZW5jZXMgcGVyIHJlc291cmNlLCBub3QgZ2xv
YmFsbHkNCg0KICAgIGFmMzcwODVkZTkwNiBsaWIvZ2VuYWxsb2M6IGludHJvZHVjZSBjaHVuayBv
d25lcnMNCg0KICAgIGUwMDQ3ZmY4YWE3NyBQQ0kvUDJQRE1BOiBmaXggdGhlIGdlbl9wb29sX2Fk
ZF92aXJ0KCkgZmFpbHVyZSBwYXRoDQoNCiAgICAwMzE1ZDQ3ZDZhZTkgbW0vZGV2bV9tZW1yZW1h
cF9wYWdlczogaW50cm9kdWNlIGRldm1fbWVtdW5tYXBfcGFnZXMNCg0KICAgIDIxNjQ3NWM3ZWFh
OCBkcml2ZXJzL2Jhc2UvZGV2cmVzOiBpbnRyb2R1Y2UgZGV2bV9yZWxlYXNlX2FjdGlvbigpDQoN
Cg0KDQogICAgLi4uYnV0IGl0IHNvdW5kcyBsaWtlIHlvdSBtYXkgYmUgaGl0dGluZyBhIGRpZmZl
cmVudCBpc3N1ZS4NCg0KDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24sIHdlIHdpbGwgZG93
bmxvYWQgdGhlIHVwc3RyZWFtIGtlcm5lbCBhbmQgdHJ5IGl0IGFnYWluLiBXaWxsIHBvc3QgdGhl
IHJlc3VsdHMgc29vbi4NCg0KDQoNCkJlc3QsDQoNCg0KDQpZdWUNCg0KDQoNCg0KDQoNCg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRp
bW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4w
MS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
