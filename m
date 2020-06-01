Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4541EA357
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 14:02:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21EBF100DDCC0;
	Mon,  1 Jun 2020 04:57:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39AC6100DEFFD
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 04:57:39 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 051C2HaN104327;
	Mon, 1 Jun 2020 08:02:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bm15df89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:02:18 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 051C2Grt104255;
	Mon, 1 Jun 2020 08:02:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bm15df00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:02:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 051C05cT013598;
	Mon, 1 Jun 2020 12:01:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04ams.nl.ibm.com with ESMTP id 31bf47v1b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 12:01:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 051C1rAW43057400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2020 12:01:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCD514204B;
	Mon,  1 Jun 2020 12:01:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEDF64204C;
	Mon,  1 Jun 2020 12:01:51 +0000 (GMT)
Received: from [9.85.99.223] (unknown [9.85.99.223])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2020 12:01:51 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: Jan Kara <jack@suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <20200601100925.GC3960@quack2.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <2bf026cc-2ed0-70b6-bf99-ecfd0fa3dac4@linux.ibm.com>
Date: Mon, 1 Jun 2020 17:31:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601100925.GC3960@quack2.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_07:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 cotscore=-2147483648 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010087
Message-ID-Hash: P3DOC6WPQQE4ZZQORAGHYJXW3ZKT57TI
X-Message-ID-Hash: P3DOC6WPQQE4ZZQORAGHYJXW3ZKT57TI
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P3DOC6WPQQE4ZZQORAGHYJXW3ZKT57TI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNi8xLzIwIDM6MzkgUE0sIEphbiBLYXJhIHdyb3RlOg0KPiBPbiBGcmkgMjktMDUtMjAgMTY6
MjU6MzUsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+PiBPbiA1LzI5LzIwIDM6MjIgUE0sIEph
biBLYXJhIHdyb3RlOg0KPj4+IE9uIEZyaSAyOS0wNS0yMCAxNTowNzozMSwgQW5lZXNoIEt1bWFy
IEsuViB3cm90ZToNCj4+Pj4gVGhhbmtzIE1pY2hhbC4gSSBhbHNvIG1pc3NlZCBKZWZmIGluIHRo
aXMgZW1haWwgdGhyZWFkLg0KPj4+DQo+Pj4gQW5kIEkgdGhpbmsgeW91J2xsIGFsc28gbmVlZCBz
b21lIG9mIHRoZSBzY2hlZCBtYWludGFpbmVycyBmb3IgdGhlIHByY3RsDQo+Pj4gYml0cy4uLg0K
Pj4+DQo+Pj4+IE9uIDUvMjkvMjAgMzowMyBQTSwgTWljaGFsIFN1Y2jDoW5layB3cm90ZToNCj4+
Pj4+IEFkZGluZyBKYW4NCj4+Pj4+DQo+Pj4+PiBPbiBGcmksIE1heSAyOSwgMjAyMCBhdCAxMTox
MTozOUFNICswNTMwLCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOg0KPj4+Pj4+IFdpdGggUE9XRVIx
MCwgYXJjaGl0ZWN0dXJlIGlzIGFkZGluZyBuZXcgcG1lbSBmbHVzaCBhbmQgc3luYyBpbnN0cnVj
dGlvbnMuDQo+Pj4+Pj4gVGhlIGtlcm5lbCBzaG91bGQgcHJldmVudCB0aGUgdXNhZ2Ugb2YgTUFQ
X1NZTkMgaWYgYXBwbGljYXRpb25zIGFyZSBub3QgdXNpbmcNCj4+Pj4+PiB0aGUgbmV3IGluc3Ry
dWN0aW9ucyBvbiBuZXdlciBoYXJkd2FyZS4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgcGF0Y2ggYWRk
cyBhIHByY3RsIG9wdGlvbiBNQVBfU1lOQ19FTkFCTEUgdGhhdCBjYW4gYmUgdXNlZCB0byBlbmFi
bGUNCj4+Pj4+PiB0aGUgdXNhZ2Ugb2YgTUFQX1NZTkMuIFRoZSBrZXJuZWwgY29uZmlnIG9wdGlv
biBpcyBhZGRlZCB0byBhbGxvdyB0aGUgdXNlcg0KPj4+Pj4+IHRvIGNvbnRyb2wgd2hldGhlciBN
QVBfU1lOQyBzaG91bGQgYmUgZW5hYmxlZCBieSBkZWZhdWx0IG9yIG5vdC4NCj4+Pj4+Pg0KPj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1hckBsaW51eC5p
Ym0uY29tPg0KPj4+IC4uLg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2Vy
bmVsL2ZvcmsuYw0KPj4+Pj4+IGluZGV4IDhjNzAwZjg4MWQ5Mi4uZDVhOWEzNjNlODFlIDEwMDY0
NA0KPj4+Pj4+IC0tLSBhL2tlcm5lbC9mb3JrLmMNCj4+Pj4+PiArKysgYi9rZXJuZWwvZm9yay5j
DQo+Pj4+Pj4gQEAgLTk2Myw2ICs5NjMsMTIgQEAgX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXAg
REVGSU5FX1NQSU5MT0NLKG1tbGlzdF9sb2NrKTsNCj4+Pj4+PiAgICAgc3RhdGljIHVuc2lnbmVk
IGxvbmcgZGVmYXVsdF9kdW1wX2ZpbHRlciA9IE1NRl9EVU1QX0ZJTFRFUl9ERUZBVUxUOw0KPj4+
Pj4+ICsjaWZkZWYgQ09ORklHX0FSQ0hfTUFQX1NZTkNfRElTQUJMRQ0KPj4+Pj4+ICt1bnNpZ25l
ZCBsb25nIGRlZmF1bHRfbWFwX3N5bmNfbWFzayA9IE1NRl9ESVNBQkxFX01BUF9TWU5DX01BU0s7
DQo+Pj4+Pj4gKyNlbHNlDQo+Pj4+Pj4gK3Vuc2lnbmVkIGxvbmcgZGVmYXVsdF9tYXBfc3luY19t
YXNrID0gMDsNCj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4gKw0KPj4+DQo+Pj4gSSdtIG5vdCBzdXJl
IENPTkZJRyBpcyByZWFsbHkgdGhlIHJpZ2h0IGFwcHJvYWNoIGhlcmUuIEZvciBhIGRpc3RybyB0
aGF0IHdvdWxkDQo+Pj4gYmFzaWNhbGx5IG1lYW4gdG8gZGlzYWJsZSBNQVBfU1lOQyBmb3IgYWxs
IFBQQyBrZXJuZWxzIHVubGVzcyBhcHBsaWNhdGlvbg0KPj4+IGV4cGxpY2l0bHkgdXNlcyB0aGUg
cmlnaHQgcHJjdGwuIFNob3VsZG4ndCB3ZSByYXRoZXIgaW5pdGlhbGl6ZQ0KPj4+IGRlZmF1bHRf
bWFwX3N5bmNfbWFzayBvbiBib290IGJhc2VkIG9uIHdoZXRoZXIgdGhlIENQVSB3ZSBydW4gb24g
cmVxdWlyZXMNCj4+PiBuZXcgZmx1c2ggaW5zdHJ1Y3Rpb25zIG9yIG5vdD8gT3RoZXJ3aXNlIHRo
ZSBwYXRjaCBsb29rcyBzZW5zaWJsZS4NCj4+Pg0KPj4NCj4+IHllcyB0aGF0IGlzIGNvcnJlY3Qu
IFdlIGlkZWFsbHkgd2FudCB0byBkZW55IE1BUF9TWU5DIG9ubHkgdy5yLnQgUE9XRVIxMC4NCj4+
IEJ1dCBvbiBhIHZpcnR1YWxpemVkIHBsYXRmb3JtIHRoZXJlIGlzIG5vIGVhc3kgd2F5IHRvIGRl
dGVjdCB0aGF0LiBXZSBjb3VsZA0KPj4gaWRlYWxseSBob29rIHRoaXMgaW50byB0aGUgbnZkaW1t
IGRyaXZlciB3aGVyZSB3ZSBsb29rIGF0IHRoZSBuZXcgY29tcGF0DQo+PiBzdHJpbmcgaWJtLHBl
cnNpc3RlbnQtbWVtb3J5LXYyIGFuZCB0aGVuIGRpc2FibGUgTUFQX1NZTkMNCj4+IGlmIHdlIGZp
bmQgYSBkZXZpY2Ugd2l0aCB0aGUgc3BlY2lmaWMgdmFsdWUuDQo+IA0KPiBIdW0sIGNvdWxkbid0
IHdlIHNldCBzb21lIGZsYWcgZm9yIG52ZGltbSBkZXZpY2VzIHdpdGgNCj4gImlibSxwZXJzaXN0
ZW50LW1lbW9yeS12MiIgcHJvcGVydHkgYW5kIHRoZW4gY2hlY2sgaXQgZHVyaW5nIG1tYXAoMikg
dGltZQ0KPiBhbmQgd2hlbiB0aGUgZGV2aWNlIGhhcyB0aGlzIHByb3BlcnkgYW5kIHRoZSBtbWFw
KDIpIGNhbGxlciBkb2Vzbid0IGhhdmUNCj4gdGhlIHByY3RsIHNldCwgd2UnZCBkaXNhbGxvdyBN
QVBfU1lOQz8gVGhhdCBzaG91bGQgbWFrZSB0aGluZ3MgbW9zdGx5DQo+IHNlYW1sZXNzLCBzaG91
bGRuJ3QgaXQ/IE9ubHkgYXBwcyB0aGF0IHdhbnQgdG8gdXNlIE1BUF9TWU5DIG9uIHRoZXNlDQo+
IGRldmljZXMgd291bGQgbmVlZCB0byB1c2UgcHJjdGwoTU1GX0RJU0FCTEVfTUFQX1NZTkMsIDAp
IGJ1dCB0aGVuIHRoZXNlDQo+IGFwcGxpY2F0aW9ucyBuZWVkIHRvIGJlIGF3YXJlIG9mIG5ldyBp
bnN0cnVjdGlvbnMgc28gdGhpcyBpc24ndCB0aGF0IG11Y2gNCj4gYWRkaXRpb25hbCBidXJkZW4u
Li4NCg0KSSBhbSBub3Qgc3VyZSBhcHBsaWNhdGlvbiB3b3VsZCB3YW50IHRvIGFkZCB0aGF0IG11
Y2ggZGV0YWlscy9rbm93bGVkZ2UgDQphYm91dCBhIHBsYXRmb3JtIGluIHRoZWlyIGNvZGUuIEkg
d2FzIGV4cGVjdGluZyBhcHBsaWNhdGlvbiB0byBkbw0KDQojaWZkZWYgX19wcGM2NF9fDQogICAg
ICAgICBwcmN0bChNQVBfU1lOQ19FTkFCTEUsIDEsIDAsIDAsIDApKTsNCiNlbmRpZg0KICAgICAg
ICAgYSA9IG1tYXAoTlVMTCwgUEFHRV9TSVpFLCBQUk9UX1JFQUR8UFJPVF9XUklURSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICBNQVBfU0hBUkVEX1ZBTElEQVRFIHwgTUFQX1NZTkMsIGZkLCAw
KTsNCg0KDQpGb3IgdGhhdCBjb2RlIGFsbCB0aGUgY29tcGxleGl0eSB0aGF0IHdlIGFkZCB3LnIu
dCANCmlibSxwZXJzaXN0ZW50LW1lbW9yeS12MiBpcyBub3QgdXNlZnVsLiBEbyB5b3Ugc2VlIGEg
dmFsdWUgaW4gbWFraW5nIGFsbCANCnRoZXNlIGRldmljZSBzcGVjaWZpYyByYXRoZXIgdGhhbiBh
IGNvbmRpdGlvbmFsIG9uICBfX3BwYzY0X18/DQoNCg0KPiANCj4+IFdpdGggdGhhdCBJIGFtIHdv
bmRlcmluZyBzaG91bGQgd2UgZXZlbiBoYXZlIHRoaXMgcGF0Y2g/IENhbiB3ZSBleHBlY3QNCj4+
IHVzZXJzcGFjZSBnZXQgdXBkYXRlZCB0byB1c2UgbmV3IGluc3RydWN0aW9uPy4NCj4+DQo+PiBX
aXRoIHBwYzY0IHdlIG5ldmVyIGhhZCBhIHJlYWwgcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlIGF2
YWlsYWJsZSBmb3IgZW5kDQo+PiB1c2VyIHRvIHRyeS4gVGhlIGF2YWlsYWJsZSBwZXJzaXN0ZW50
IG1lbW9yeSBzdGFjayB3YXMgdXNpbmcgdlBNRU0gd2hpY2ggd2FzDQo+PiBwcmVzZW50ZWQgYXMg
YSB2b2xhdGlsZSBtZW1vcnkgcmVnaW9uIGZvciB3aGljaCB0aGVyZSBpcyBubyBuZWVkIHRvIHVz
ZSBhbnkNCj4+IG9mIHRoZSBmbHVzaCBpbnN0cnVjdGlvbnMuIFdlIGNvdWxkIHNhZmVseSBhc3N1
bWUgdGhhdCBhcyB3ZSBnZXQNCj4+IGFwcGxpY2F0aW9ucyBjZXJ0aWZpZWQvdmVyaWZpZWQgZm9y
IHdvcmtpbmcgd2l0aCBwbWVtIGRldmljZSBvbiBwcGM2NCwgdGhleQ0KPj4gd291bGQgYWxsIGJl
IHVzaW5nIHRoZSBuZXcgaW5zdHJ1Y3Rpb25zPw0KPiANCj4gVGhpcyBpcyBhIGJpdCBvZiBhIGdh
bWJsZS4uLiBJIGRvbid0IGhhdmUgdG9vIG11Y2ggdHJ1c3QgaW4gY2VydGlmaWNhdGlvbiAvDQo+
IHZlcmlmaWNhdGlvbiBiZWNhdXNlIG9ubHkgdGhlICJiaWcgcGxheWVycyIgbWF5IGRvIHBvd2Vy
ZmFpbCB0ZXN0aW5nDQo+IHRocm91Z2hvdXQgZW5vdWdoIHRoYXQgdGhleSdkIHVuY292ZXIgdGhl
c2UgcHJvYmxlbXMuIFNvIHRoZSBxdWVzdGlvbg0KPiByZWFsbHkgaXM6IEhvdyBtYW55IGFwcHMg
YXJlIG91dCB0aGVyZSB1c2luZyBNQVBfU1lOQyBvbiBwcGM2ND8gSG9wZWZ1bGx5DQo+IG5vdCBt
YW55IGdpdmVuIHRoZSBIVyBkaWRuJ3Qgc2hpcCB5ZXQgYXMgeW91IHdyb3RlIGJ1dCBJIGhhdmUg
bm8gcmVhbCBjbHVlLg0KPiBTaW1pbGFybHkgdGhlcmUncyBhIHF1ZXN0aW9uOiBIb3cgbWFueSBh
cHAgd3JpdGVycyB3aWxsIHJlYWQgbWFudWFsIGZvcg0KPiBvbGRlciBwcGM2NCBhcmNoaXRlY3R1
cmUgYW5kIHdyaXRlIGFwcHMgdGhhdCB3b24ndCB3b3JrIHJlbGlhYmx5IG9uDQo+IFBPV0VSMTA/
IEFnYWluLCBJIGhhdmUgbm8gaWRlYS4NCj4gDQo+IFNvIHRoZSBwcmN0bCB3b3VsZCBiZSBJTUhP
IGEgbmljZSBzYWZldHkgYmVsdCBidXQgSSdtIG5vdCAxMDAlIGNlcnRhaW4gaXQNCj4gd2lsbCBi
ZSBuZWVkZWQuLi4NCj4gDQo+DQoNCi1hbmVlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
