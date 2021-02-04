Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC931000A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 23:24:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E97F100EAB1D;
	Thu,  4 Feb 2021 14:24:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC661100EAB17
	for <linux-nvdimm@lists.01.org>; Thu,  4 Feb 2021 14:24:28 -0800 (PST)
IronPort-SDR: pIxQExgNjKvdHIFwaT7/Wgv1ZMPaFECIQChPOYfaSFdymFfiJRcpJfxwYMHZ5ZNEGQ8xfITFri
 NmHbN1QCHvdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200333769"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400";
   d="scan'208";a="200333769"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 14:24:27 -0800
IronPort-SDR: y/7S/VUBRnji49Z9RcM7MCK9m9bPc9F2qnjPMyRowJSljxxzoccj0mjoNWsOJdTYwHZYVCzA52
 cylVr2edM40A==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400";
   d="scan'208";a="576429167"
Received: from jguillor-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.14])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 14:24:26 -0800
Date: Thu, 4 Feb 2021 14:24:25 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: "John Groves (jgroves)" <jgroves@micron.com>
Subject: Re: [EXT] Re: [PATCH 04/14] cxl/mem: Implement polled mode mailbox
Message-ID: <20210204222425.5vlulgaip7stal3z@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-5-ben.widawsky@intel.com>
 <20210201175400.GG197521@fedora>
 <20210201191316.e3kkkwqbx5fujp6y@intel.com>
 <CAPcyv4hP6AOV1OQKbohCqczM1RUPQHQ07+7MuNJ1_p6+opLSQQ@mail.gmail.com>
 <SN6PR08MB46052FE9BC20A747CACD8F50D1B39@SN6PR08MB4605.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR08MB46052FE9BC20A747CACD8F50D1B39@SN6PR08MB4605.namprd08.prod.outlook.com>
Message-ID-Hash: EMPUULXO7V2HG26RYJXVLKVNCVBN2EHQ
X-Message-ID-Hash: EMPUULXO7V2HG26RYJXVLKVNCVBN2EHQ
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>, David Rientjes <rientjes@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMPUULXO7V2HG26RYJXVLKVNCVBN2EHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjEtMDItMDQgMjE6NTM6MjksIEpvaG4gR3JvdmVzIChqZ3JvdmVzKSB3cm90ZToNCj4gICAg
TWljcm9uIENvbmZpZGVudGlhbA0KPiANCj4gDQo+IA0KPiAgICBGcm9tOiBEYW4gV2lsbGlhbXMg
PGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gICAgRGF0ZTogTW9uZGF5LCBGZWJydWFyeSAx
LCAyMDIxIGF0IDE6MjggUE0NCj4gICAgVG86IEJlbiBXaWRhd3NreSA8YmVuLndpZGF3c2t5QGlu
dGVsLmNvbT4NCj4gICAgQ2M6IEtvbnJhZCBSemVzenV0ZWsgV2lsayA8a29ucmFkLndpbGtAb3Jh
Y2xlLmNvbT4sDQo+ICAgIGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWN4bEB2Z2Vy
Lmtlcm5lbC5vcmc+LCBMaW51eCBBQ1BJDQo+ICAgIDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
Zz4sIExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gICAgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+LCBsaW51eC1udmRpbW0NCj4gICAgPGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc+
LCBMaW51eCBQQ0kgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+LA0KPiAgICBCam9ybiBIZWxn
YWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+LCBDaHJpcyBCcm93eQ0KPiAgICA8Y2Jyb3d5QGF2ZXJ5
LWRlc2lnbi5jb20+LCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+LCBJcmEN
Cj4gICAgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+LCBKb24gTWFzdGVycyA8amNtQGpvbm1h
c3RlcnMub3JnPiwgSm9uYXRoYW4NCj4gICAgQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3
ZWkuY29tPiwgUmFmYWVsIFd5c29ja2kNCj4gICAgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
PiwgUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+LA0KPiAgICBWaXNoYWwgVmVy
bWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4sIGRhbmllbC5sbGxAYWxpYmFiYS1pbmMuY29t
DQo+ICAgIDxkYW5pZWwubGxsQGFsaWJhYmEtaW5jLmNvbT4sIEpvaG4gR3JvdmVzIChqZ3JvdmVz
KQ0KPiAgICA8amdyb3Zlc0BtaWNyb24uY29tPiwgS2VsbGV5LCBTZWFuIFYgPHNlYW4udi5rZWxs
ZXlAaW50ZWwuY29tPg0KPiAgICBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDA0LzE0XSBjeGwv
bWVtOiBJbXBsZW1lbnQgcG9sbGVkIG1vZGUgbWFpbGJveA0KPiANCj4gICAgQ0FVVElPTjogRVhU
RVJOQUwgRU1BSUwuIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cw0KPiAgICB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIHdlcmUgZXhwZWN0aW5nIHRoaXMg
bWVzc2FnZS4NCj4gICAgT24gTW9uLCBGZWIgMSwgMjAyMSBhdCAxMToxMyBBTSBCZW4gV2lkYXdz
a3kgPGJlbi53aWRhd3NreUBpbnRlbC5jb20+DQo+ICAgIHdyb3RlOg0KPiAgICA+DQo+ICAgID4g
T24gMjEtMDItMDEgMTI6NTQ6MDAsIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToNCj4gICAg
PiA+ID4gKyNkZWZpbmUNCj4gICAgY3hsX2Rvb3JiZWxsX2J1c3koY3hsbSkNCj4gICAgXA0KPiAg
ICA+ID4gPiArICAgKGN4bF9yZWFkX21ib3hfcmVnMzIoY3hsbSwgQ1hMREVWX01CX0NUUkxfT0ZG
U0VUKQ0KPiAgICAmICAgICAgICAgICAgICAgICAgICBcDQo+ICAgID4gPiA+ICsgICAgQ1hMREVW
X01CX0NUUkxfRE9PUkJFTEwpDQo+ICAgID4gPiA+ICsNCj4gICAgPiA+ID4gKyNkZWZpbmUgQ1hM
X01BSUxCT1hfVElNRU9VVF9VUyAyMDAwDQo+ICAgID4gPg0KPiAgICA+ID4gWW91IGJlZW4gdXNp
bmcgdGhlIHNwZWMgZm9yIHRoZSB2YWx1ZXMuIElzIHRoYXQgbnVtYmVyIGFsc28gZnJvbSBpdA0K
PiAgICA/DQo+ICAgID4gPg0KPiAgICA+DQo+ICAgID4gWWVzIGl0IGlzLiBJJ2xsIGFkZCBhIGNv
bW1lbnQgd2l0aCB0aGUgc3BlYyByZWZlcmVuY2UuDQo+IA0KPiANCj4gDQo+ICAgIEZyb20gc2Vj
dGlvbiA4LjIuOC40IGluIHRoZSBDWEwgMi4wIHNwZWM6IOKAnFRoZSBtYWlsYm94IGNvbW1hbmQg
dGltZW91dA0KPiAgICBpcyAyIHNlY29uZHMu4oCdICBTbyB0aGlzIHNob3VsZCBiZToNCj4gDQo+
IA0KPiAgICAjZGVmaW5lIENYTF9NQUlMQk9YX1RJTUVPVVRfVVMgMjAwMDAwMA0KPiANCj4gDQo+
ICAgIOKApnJpZ2h0PyAyMDAwdXMgaXMgMm1z4oCmDQo+IA0KPiANCg0KVGhhbmtzLiBUaGlzIHdh
cyBjYXVnaHQgYWxyZWFkeSBpbiBlYXJsaWVyIHJldmlldyBieSBEYXZpZCBSaWVudGplcw0KPHJp
ZW50amVzQGdvb2dsZS5jb20+DQoNCkl0J3MgcmVuYW1lZCBDWExfTUFJTEJPWF9USU1FT1VUX01T
IDIwMDAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
