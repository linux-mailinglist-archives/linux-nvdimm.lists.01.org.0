Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FCE1EB6DF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 09:57:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 361C010106A00;
	Tue,  2 Jun 2020 00:52:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA8CD100DBB71
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 00:52:38 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527Xfbb012177;
	Tue, 2 Jun 2020 03:57:26 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bjssfcv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:57:25 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0527p21l015335;
	Tue, 2 Jun 2020 07:57:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma04wdc.us.ibm.com with ESMTP id 31bf48rwt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 07:57:24 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0527vN4v22741272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2020 07:57:23 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF1526E053;
	Tue,  2 Jun 2020 07:57:23 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C90A6E054;
	Tue,  2 Jun 2020 07:57:21 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.130])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2020 07:57:20 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
In-Reply-To: <af150987-156f-71dc-a4cd-e6f8e670839a@linux.ibm.com>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <20200601100925.GC3960@quack2.suse.cz>
 <2bf026cc-2ed0-70b6-bf99-ecfd0fa3dac4@linux.ibm.com>
 <20200601120705.GQ25173@kitsune.suse.cz>
 <af150987-156f-71dc-a4cd-e6f8e670839a@linux.ibm.com>
Date: Tue, 02 Jun 2020 13:27:18 +0530
Message-ID: <87y2p5oq75.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020043
Message-ID-Hash: HCM2QPVP2UH7C4CONLFEYY6OPXFQHCUB
X-Message-ID-Hash: HCM2QPVP2UH7C4CONLFEYY6OPXFQHCUB
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCM2QPVP2UH7C4CONLFEYY6OPXFQHCUB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IkFuZWVzaCBLdW1hciBLLlYiIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JpdGVzOg0K
DQo+IE9uIDYvMS8yMCA1OjM3IFBNLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOg0KPj4gT24gTW9u
LCBKdW4gMDEsIDIwMjAgYXQgMDU6MzE6NTBQTSArMDUzMCwgQW5lZXNoIEt1bWFyIEsuViB3cm90
ZToNCj4+PiBPbiA2LzEvMjAgMzozOSBQTSwgSmFuIEthcmEgd3JvdGU6DQo+Pj4+IE9uIEZyaSAy
OS0wNS0yMCAxNjoyNTozNSwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToNCj4+Pj4+IE9uIDUvMjkv
MjAgMzoyMiBQTSwgSmFuIEthcmEgd3JvdGU6DQo+Pj4+Pj4gT24gRnJpIDI5LTA1LTIwIDE1OjA3
OjMxLCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOg0KPj4+Pj4+PiBUaGFua3MgTWljaGFsLiBJIGFs
c28gbWlzc2VkIEplZmYgaW4gdGhpcyBlbWFpbCB0aHJlYWQuDQo+Pj4+Pj4NCj4+Pj4+PiBBbmQg
SSB0aGluayB5b3UnbGwgYWxzbyBuZWVkIHNvbWUgb2YgdGhlIHNjaGVkIG1haW50YWluZXJzIGZv
ciB0aGUgcHJjdGwNCj4+Pj4+PiBiaXRzLi4uDQo+Pj4+Pj4NCj4+Pj4+Pj4gT24gNS8yOS8yMCAz
OjAzIFBNLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOg0KPj4+Pj4+Pj4gQWRkaW5nIEphbg0KPj4+
Pj4+Pj4NCj4+Pj4+Pj4+IE9uIEZyaSwgTWF5IDI5LCAyMDIwIGF0IDExOjExOjM5QU0gKzA1MzAs
IEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+Pj4+Pj4+Pj4gV2l0aCBQT1dFUjEwLCBhcmNoaXRl
Y3R1cmUgaXMgYWRkaW5nIG5ldyBwbWVtIGZsdXNoIGFuZCBzeW5jIGluc3RydWN0aW9ucy4NCj4+
Pj4+Pj4+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2ZW50IHRoZSB1c2FnZSBvZiBNQVBfU1lOQyBp
ZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0KPj4+Pj4+Pj4+IHRoZSBuZXcgaW5zdHJ1Y3Rp
b25zIG9uIG5ld2VyIGhhcmR3YXJlLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gVGhpcyBwYXRjaCBh
ZGRzIGEgcHJjdGwgb3B0aW9uIE1BUF9TWU5DX0VOQUJMRSB0aGF0IGNhbiBiZSB1c2VkIHRvIGVu
YWJsZQ0KPj4+Pj4+Pj4+IHRoZSB1c2FnZSBvZiBNQVBfU1lOQy4gVGhlIGtlcm5lbCBjb25maWcg
b3B0aW9uIGlzIGFkZGVkIHRvIGFsbG93IHRoZSB1c2VyDQo+Pj4+Pj4+Pj4gdG8gY29udHJvbCB3
aGV0aGVyIE1BUF9TWU5DIHNob3VsZCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQgb3Igbm90Lg0KPj4+
Pj4+Pj4+DQo+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNo
Lmt1bWFyQGxpbnV4LmlibS5jb20+DQo+Pj4+Pj4gLi4uDQo+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jDQo+Pj4+Pj4+Pj4gaW5kZXggOGM3MDBmODgx
ZDkyLi5kNWE5YTM2M2U4MWUgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEva2VybmVsL2ZvcmsuYw0K
Pj4+Pj4+Pj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMNCj4+Pj4+Pj4+PiBAQCAtOTYzLDYgKzk2Mywx
MiBAQCBfX2NhY2hlbGluZV9hbGlnbmVkX2luX3NtcCBERUZJTkVfU1BJTkxPQ0sobW1saXN0X2xv
Y2spOw0KPj4+Pj4+Pj4+ICAgICAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZGVmYXVsdF9kdW1wX2Zp
bHRlciA9IE1NRl9EVU1QX0ZJTFRFUl9ERUZBVUxUOw0KPj4+Pj4+Pj4+ICsjaWZkZWYgQ09ORklH
X0FSQ0hfTUFQX1NZTkNfRElTQUJMRQ0KPj4+Pj4+Pj4+ICt1bnNpZ25lZCBsb25nIGRlZmF1bHRf
bWFwX3N5bmNfbWFzayA9IE1NRl9ESVNBQkxFX01BUF9TWU5DX01BU0s7DQo+Pj4+Pj4+Pj4gKyNl
bHNlDQo+Pj4+Pj4+Pj4gK3Vuc2lnbmVkIGxvbmcgZGVmYXVsdF9tYXBfc3luY19tYXNrID0gMDsN
Cj4+Pj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+DQo+Pj4+Pj4gSSdtIG5vdCBz
dXJlIENPTkZJRyBpcyByZWFsbHkgdGhlIHJpZ2h0IGFwcHJvYWNoIGhlcmUuIEZvciBhIGRpc3Ry
byB0aGF0IHdvdWxkDQo+Pj4+Pj4gYmFzaWNhbGx5IG1lYW4gdG8gZGlzYWJsZSBNQVBfU1lOQyBm
b3IgYWxsIFBQQyBrZXJuZWxzIHVubGVzcyBhcHBsaWNhdGlvbg0KPj4+Pj4+IGV4cGxpY2l0bHkg
dXNlcyB0aGUgcmlnaHQgcHJjdGwuIFNob3VsZG4ndCB3ZSByYXRoZXIgaW5pdGlhbGl6ZQ0KPj4+
Pj4+IGRlZmF1bHRfbWFwX3N5bmNfbWFzayBvbiBib290IGJhc2VkIG9uIHdoZXRoZXIgdGhlIENQ
VSB3ZSBydW4gb24gcmVxdWlyZXMNCj4+Pj4+PiBuZXcgZmx1c2ggaW5zdHJ1Y3Rpb25zIG9yIG5v
dD8gT3RoZXJ3aXNlIHRoZSBwYXRjaCBsb29rcyBzZW5zaWJsZS4NCj4+Pj4+Pg0KPj4+Pj4NCj4+
Pj4+IHllcyB0aGF0IGlzIGNvcnJlY3QuIFdlIGlkZWFsbHkgd2FudCB0byBkZW55IE1BUF9TWU5D
IG9ubHkgdy5yLnQgUE9XRVIxMC4NCj4+Pj4+IEJ1dCBvbiBhIHZpcnR1YWxpemVkIHBsYXRmb3Jt
IHRoZXJlIGlzIG5vIGVhc3kgd2F5IHRvIGRldGVjdCB0aGF0LiBXZSBjb3VsZA0KPj4+Pj4gaWRl
YWxseSBob29rIHRoaXMgaW50byB0aGUgbnZkaW1tIGRyaXZlciB3aGVyZSB3ZSBsb29rIGF0IHRo
ZSBuZXcgY29tcGF0DQo+Pj4+PiBzdHJpbmcgaWJtLHBlcnNpc3RlbnQtbWVtb3J5LXYyIGFuZCB0
aGVuIGRpc2FibGUgTUFQX1NZTkMNCj4+Pj4+IGlmIHdlIGZpbmQgYSBkZXZpY2Ugd2l0aCB0aGUg
c3BlY2lmaWMgdmFsdWUuDQo+Pj4+DQo+Pj4+IEh1bSwgY291bGRuJ3Qgd2Ugc2V0IHNvbWUgZmxh
ZyBmb3IgbnZkaW1tIGRldmljZXMgd2l0aA0KPj4+PiAiaWJtLHBlcnNpc3RlbnQtbWVtb3J5LXYy
IiBwcm9wZXJ0eSBhbmQgdGhlbiBjaGVjayBpdCBkdXJpbmcgbW1hcCgyKSB0aW1lDQo+Pj4+IGFu
ZCB3aGVuIHRoZSBkZXZpY2UgaGFzIHRoaXMgcHJvcGVyeSBhbmQgdGhlIG1tYXAoMikgY2FsbGVy
IGRvZXNuJ3QgaGF2ZQ0KPj4+PiB0aGUgcHJjdGwgc2V0LCB3ZSdkIGRpc2FsbG93IE1BUF9TWU5D
PyBUaGF0IHNob3VsZCBtYWtlIHRoaW5ncyBtb3N0bHkNCj4+Pj4gc2VhbWxlc3MsIHNob3VsZG4n
dCBpdD8gT25seSBhcHBzIHRoYXQgd2FudCB0byB1c2UgTUFQX1NZTkMgb24gdGhlc2UNCj4+Pj4g
ZGV2aWNlcyB3b3VsZCBuZWVkIHRvIHVzZSBwcmN0bChNTUZfRElTQUJMRV9NQVBfU1lOQywgMCkg
YnV0IHRoZW4gdGhlc2UNCj4+Pj4gYXBwbGljYXRpb25zIG5lZWQgdG8gYmUgYXdhcmUgb2YgbmV3
IGluc3RydWN0aW9ucyBzbyB0aGlzIGlzbid0IHRoYXQgbXVjaA0KPj4+PiBhZGRpdGlvbmFsIGJ1
cmRlbi4uLg0KPj4+DQo+Pj4gSSBhbSBub3Qgc3VyZSBhcHBsaWNhdGlvbiB3b3VsZCB3YW50IHRv
IGFkZCB0aGF0IG11Y2ggZGV0YWlscy9rbm93bGVkZ2UNCj4+PiBhYm91dCBhIHBsYXRmb3JtIGlu
IHRoZWlyIGNvZGUuIEkgd2FzIGV4cGVjdGluZyBhcHBsaWNhdGlvbiB0byBkbw0KPj4+DQo+Pj4g
I2lmZGVmIF9fcHBjNjRfXw0KPj4+ICAgICAgICAgIHByY3RsKE1BUF9TWU5DX0VOQUJMRSwgMSwg
MCwgMCwgMCkpOw0KPj4+ICNlbmRpZg0KPj4+ICAgICAgICAgIGEgPSBtbWFwKE5VTEwsIFBBR0Vf
U0laRSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
IE1BUF9TSEFSRURfVkFMSURBVEUgfCBNQVBfU1lOQywgZmQsIDApOw0KPj4+DQo+Pj4NCj4+PiBG
b3IgdGhhdCBjb2RlIGFsbCB0aGUgY29tcGxleGl0eSB0aGF0IHdlIGFkZCB3LnIudCBpYm0scGVy
c2lzdGVudC1tZW1vcnktdjINCj4+PiBpcyBub3QgdXNlZnVsLiBEbyB5b3Ugc2VlIGEgdmFsdWUg
aW4gbWFraW5nIGFsbCB0aGVzZSBkZXZpY2Ugc3BlY2lmaWMgcmF0aGVyDQo+Pj4gdGhhbiBhIGNv
bmRpdGlvbmFsIG9uICBfX3BwYzY0X18/DQo+DQo+PiBJZiB0aGUgdnBtZW0gZGV2aWNlcyBjb250
aW51ZSB0byB3b3JrIHdpdGggdGhlIG9sZCBpbnN0cnVjdGlvbiBvbg0KPj4gUE9XRVIxMCB0aGVu
IGl0IG1ha2VzIHNlbnNlIHRvIG1ha2UgdGhpcyBwZXItZGV2aWNlLg0KPg0KPiB2UE1FTSBkb2Vz
bid0IGhhdmUgd3JpdGVfY2FjaGUgYW5kIGhlbmNlIGl0IGlzIHN5bmNocm9ub3VzIGV2ZW4gd2l0
aG91dCANCj4gdXNpbmcgYW55IHNwZWNpZmljIGZsdXNoIGluc3RydWN0aW9uLiBUaGUgcXVlc3Rp
b24gaXMgZG8gd2Ugd2FudCB0byBoYXZlDQo+IGRpZmZlcmVudCBwcm9ncmFtbWluZyBzdGVwcyB3
aGVuIHJ1bm5pbmcgb24gdlBNRU0gdnMgYSBwZXJzaXN0ZW50IFBNRU0gDQo+IGRldmljZSBvbiBw
cGM2NC4NCj4NCj4gSSB3aWxsIHdvcmsgb24gdGhlIGRldmljZSBzcGVjaWZpYyBFTkFCTEUgZmxh
ZyBhbmQgdGhlbiB3ZSBjYW4gY29tcGFyZSANCj4gdGhlIGtlcm5lbCBjb21wbGV4aXR5IGFnYWlu
c3QgdGhlIGFkZGVkIGJlbmVmaXQuDQoNCkkgaGF2ZSBwb3N0ZWQgYW4gUkZDIHYyIFsxXSB0aGF0
IGltcGxlbWVudHMgYSBkZXZpY2Utc3BlY2lmaWMgTUFQX1NZTkMNCmVuYWJsZS9kaXNhYmxlIGZl
YXR1cmUuIFRoZSBQb3N0ZWQgY2hhbmdlcyBhbHNvIGFkZCBhIGRheCBmbGFnIHN1Z2dlc3RlZA0K
YnkgRGFuLiBXaXRoIGRldmljZS1zcGVjaWZpYyBNQVBfU1lOQyBlbmFibGUvZGlzYWJsZSwgaXQg
d2FzIGp1c3QgYSBzeXNmcw0KZmlsZSBleHBvcnQgb2YgdGhlIHNhbWUgZmxhZy4gDQoNCjEuIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4cHBjLWRldi8yMDIwMDYwMjA3NDkwOS4zNjczOC0x
LWFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tLw0KDQotYW5lZXNoCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
