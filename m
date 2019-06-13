Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03744FDC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 01:10:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E917821296B05;
	Thu, 13 Jun 2019 16:10:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.73.47; helo=nam05-dm3-obe.outbound.protection.outlook.com;
 envelope-from=yue.li@memverge.com; receiver=linux-nvdimm@lists.01.org 
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730047.outbound.protection.outlook.com [40.107.73.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F051F21296705
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=memverge.onmicrosoft.com; s=selector1-memverge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ62ecepxFLNl1sSYl8dV+HQz9p8/LzT43m9CXUxP+M=;
 b=RmAxDdnJti2hYTQTovnNW2FaZIi/WT5vj5rnkr2Ks4qjVpdLgZ9fI1YpYXcjJDYojQGXRphIhJYI9bhWzBbgJJtoM2hqkGUIYSeSog5t8zpOwOhnDSKhBnpStArkQV5eRKwo6zIuOjx+sVhD7mMr+OWVBKGLdqZeNpcXIuxeJmg=
Received: from BYAPR17MB2376.namprd17.prod.outlook.com (52.135.221.29) by
 BYAPR17MB2903.namprd17.prod.outlook.com (20.178.235.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 23:10:26 +0000
Received: from BYAPR17MB2376.namprd17.prod.outlook.com
 ([fe80::2054:93a4:cc54:d75d]) by BYAPR17MB2376.namprd17.prod.outlook.com
 ([fe80::2054:93a4:cc54:d75d%5]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 23:10:26 +0000
From: Yue Li <yue.li@memverge.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: ndctl hangs after memory deregistration
Thread-Topic: ndctl hangs after memory deregistration
Thread-Index: AQHVIZ2h/38SJcCyuUuJqqWUyP3fR6aZ8tEAgADKbYA=
Date: Thu, 13 Jun 2019 23:10:26 +0000
Message-ID: <4C50C748-FD16-4AC8-A870-1E47ADB4CAF7@memverge.com>
References: <41115947-1EBD-4686-8196-C06BD23CECE6@memverge.com>
 <CAA9_cmcNNN6fUQmKU_9Rw-6H84p-=e1DZiAcra+H1Ed=T_CALg@mail.gmail.com>
In-Reply-To: <CAA9_cmcNNN6fUQmKU_9Rw-6H84p-=e1DZiAcra+H1Ed=T_CALg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.b.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yue.li@memverge.com; 
x-originating-ip: [140.206.187.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfca2a37-71fb-4968-2eaa-08d6f0545241
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BYAPR17MB2903; 
x-ms-traffictypediagnostic: BYAPR17MB2903:
x-ld-processed: 5c90cb59-37e7-4c81-9c07-00473d5fb682,ExtAddr
x-microsoft-antispam-prvs: <BYAPR17MB2903FFA6A500F91F8D2C2C92F1EF0@BYAPR17MB2903.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39830400003)(346002)(366004)(396003)(136003)(51914003)(199004)(189003)(14454004)(14444005)(99286004)(305945005)(6486002)(64756008)(44832011)(6512007)(76176011)(11346002)(316002)(54906003)(476003)(6436002)(229853002)(33656002)(58126008)(2616005)(8936002)(2906002)(7736002)(66476007)(71190400001)(486006)(26005)(4326008)(86362001)(102836004)(66556008)(91956017)(66066001)(6116002)(53546011)(6506007)(186003)(71200400001)(68736007)(508600001)(53936002)(66946007)(3846002)(81166006)(81156014)(6246003)(73956011)(76116006)(36756003)(25786009)(446003)(256004)(6916009)(66446008)(5660300002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR17MB2903;
 H:BYAPR17MB2376.namprd17.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: memverge.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HQFhXhIqc/1kUpzSvi+Xiv+IXVfrG3pCO7s+SSQrViu+Ei9EWUFgE0O25YNHUYhXCZc7zdqIoAbwjGJBWFz5TQ8vo6voRfcslcpdiqS+YsExrs8BpQxoDcqvU8elqrQ/WcSbWk34aKhfnDiauumcqjRaZx/QB20dD+15ccggq37bRRXTc8p0E0sMPzlI5Vl0PmmcusoVeF/nEUjpdogqE0jjUje7uNlD6Xx7wgy3mCOf4oCw8yrni+6eB1ahxsf2Z2t0MG2QzEAhfLFsOjXRloyOnG/oB3T6F2tcw44hHZXr/H8AifR9NU8lsfdVCZ2YO3P01CNu1TAlbjV91xQ5z/CtBzTA5nSUmM2oCjssUJDaBUIE8JhDVNjMXYZpJqwpe+DbZVUMwYzul6NcdzGU2w4/tt/1pUT0lrrG66bF84Y=
Content-ID: <69D0145372BE524B8F827F7A2257458C@namprd17.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfca2a37-71fb-4968-2eaa-08d6f0545241
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 23:10:26.6067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yue.li@memverge.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR17MB2903
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
 Jacky Wu <jacky.wu@memverge.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

VGhhbmtzIERhbiBmb3IgdGhlIHJlcGx5IQ0KDQrvu79PbiA2LzE0LzE5LCAzOjA2IEFNLCAiRGFu
IFdpbGxpYW1zIiA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPiB3cm90ZToNCg0KICAgIE9uIFdl
ZCwgSnVuIDEyLCAyMDE5IGF0IDk6MDggUE0gWXVlIExpIDx5dWUubGlAbWVtdmVyZ2UuY29tPiB3
cm90ZToNCiAgICA+DQogICAgPiBoaSBEYW4gYW5kIFN0ZXZlLA0KICAgID4NCiAgICA+DQogICAg
DQogICAgSGksDQogICAgDQogICAgSSBqdXN0IGhhcHBlbmVkIHRvIHNlZSB0aGlzIGJ5IGx1Y2ss
IHBsZWFzZSB1c2UgbXkgSW50ZWwgYWRkcmVzcywgYW5kDQogICAgY29weSB0aGUgbGlibnZkaW1t
IG1haWxpbmcgbGlzdCBvbiBpc3N1ZXMgbGlrZSB0aGlzDQogICAgKGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcpLg0KDQpPSy4NCiAgICANCiAgICA+IFdlIHJlY2VudGx5IHJhbiBpbnRvIGEgc3Ry
YW5nZSBpc3N1ZSB3aGVyZSBuZGN0bCBjb21tYW5kIGhhbmdzIG9uIGRldiBkYXggYWZ0ZXIgb3Vy
IHNvZnR3YXJlIHVzZXMgaXQuDQogICAgDQogICAgVGhlIGxhc3QgdGhpbmcgdGhhdCBkZXZpY2Ut
ZGF4IHRlYXJkb3duIGRvZXMgaXMgd2FpdCBmb3IgYW55IHBpbm5lZA0KICAgIHBhZ2VzIHRvIGJl
IHJlbGVhc2VkIGJlZm9yZSBhbGxvd2luZyB0aGUgZXhpdCB0byBwcm9jZWVkLg0KICAgIA0KT0su
DQoNCiAgICA+IEluc2lkZSBvdXIgYXBwbGljYXRpb24sIHdlIGJhc2ljYWxseSB3aWxsIGZpcnN0
IFJETUEgcmVnaXN0ZXIgdGhlIHdob2xlIGRldmljZSwgdGhlbiBkZXJlZ2lzdGVyLCBhbmQgZXhp
dC4NCiAgICANCiAgICBJcyB0aGlzIGp1c3QgdXNpbmcgc2ltcGxlIGlidmVyYnMgdG8gdW5yZWdp
c3RlciBvciBzb21ldGhpbmcgc3BlY2lmaWMNCiAgICB0byB0aGlzIGRyaXZlci4NCiAgICANCiAg
ICBUaGVyZSB3YXMgYSBidWcgdXBzdHJlYW0gdGhhdCBhZGRyZXNzZWQgY2FzZXMgd2hlcmUgZGV2
aWNlIHRlYXJkb3duDQogICAgcHJvY2VlZGVkIHdoZW4gaXQgc2hvdWxkbid0LCBidXQgdGhlIHNl
cXVlbmNlIHlvdSBkZXNjcmliZSBpcyB0aGUNCiAgICBvcHBvc2l0ZSB0aGUgcGFnZXMgcGlucyBz
aG91bGQgYmUgdG9ybiBkb3duIGJlZm9yZSB0aGUgZGV2aWNlDQogICAgcmVjb25maWd1cmF0aW9u
Lg0KDQogICAgPiBIb3dldmVyLCBpZiB3ZSByZW1vdmUgdGhlIHJlZ2lzdHJhdGlvbiBhbmQgZGVy
ZWdpc3RyYXRpb24gY29kZSwgbmRjdGwgd29ya3MgY29ycmVjdGx5IHdpdGhvdXQgaGFuZ2luZy4g
VGhlIHByb2JsZW0gb2NjdXJzIGJvdGggb24gRFJBTSBlbXVsYXRlZCBkYXggYXMgd2VsbCBhcyBy
ZWFsIFBNRU0gYmFja2VkIGRheC4NCiAgICA+DQogICAgPiBIZXJlIGlzIG91ciBzeXN0ZW0gaW5m
b3JtYXRpb246DQogICAgPg0KICAgID4NCiAgICA+DQogICAgPiBDZW50T1MgNy42DQogICAgPg0K
ICAgID4gVmFuaWxsYSBrZXJuZWwgMy4xMC4wLTk1Ny5lbDcueDg2XzY0DQogICAgDQogICAgQXJl
IHlvdSBmYW1pbGlhciB3aXRoIHJlYnVpbGRpbmcgdGhlIGtlcm5lbD8gSSdkIGFzayB5b3UgdG8g
dHJ5IHRvDQogICAgcmVwcm9kdWNlIHdpdGggdGhlIGxhdGVzdCBkZXZlbG9wbWVudCBrZXJuZWwg
dGhhdCBpbmNsdWRlcyB0aGVzZQ0KICAgIGZpeGVzOg0KICAgIA0KICAgIDQ0MjJlZTg0NzZmMCBt
bS9kZXZtX21lbXJlbWFwX3BhZ2VzOiBmaXggZmluYWwgcGFnZSBwdXQgcmFjZQ0KICAgIDc3MWYw
NzE0ZDBkYyBQQ0kvUDJQRE1BOiB0cmFjayBwZ21hcCByZWZlcmVuY2VzIHBlciByZXNvdXJjZSwg
bm90IGdsb2JhbGx5DQogICAgYWYzNzA4NWRlOTA2IGxpYi9nZW5hbGxvYzogaW50cm9kdWNlIGNo
dW5rIG93bmVycw0KICAgIGUwMDQ3ZmY4YWE3NyBQQ0kvUDJQRE1BOiBmaXggdGhlIGdlbl9wb29s
X2FkZF92aXJ0KCkgZmFpbHVyZSBwYXRoDQogICAgMDMxNWQ0N2Q2YWU5IG1tL2Rldm1fbWVtcmVt
YXBfcGFnZXM6IGludHJvZHVjZSBkZXZtX21lbXVubWFwX3BhZ2VzDQogICAgMjE2NDc1YzdlYWE4
IGRyaXZlcnMvYmFzZS9kZXZyZXM6IGludHJvZHVjZSBkZXZtX3JlbGVhc2VfYWN0aW9uKCkNCiAg
ICANCiAgICAuLi5idXQgaXQgc291bmRzIGxpa2UgeW91IG1heSBiZSBoaXR0aW5nIGEgZGlmZmVy
ZW50IGlzc3VlLg0KICAgIA0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgd2Ugd2lsbCBkb3du
bG9hZCB0aGUgdXBzdHJlYW0ga2VybmVsIGFuZCB0cnkgaXQgYWdhaW4uIFdpbGwgcG9zdCB0aGUg
cmVzdWx0cyBzb29uLiANCg0KQmVzdCwgDQoNCll1ZQ0KDQoNCg0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0
CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udmRpbW0K
