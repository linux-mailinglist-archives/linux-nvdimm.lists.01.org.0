Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66DE1EA3AB
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 14:20:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2E90100DDCC0;
	Mon,  1 Jun 2020 05:16:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A8C60100DEFFD
	for <linux-nvdimm@lists.01.org>; Mon,  1 Jun 2020 05:16:09 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 051C2Opx116343;
	Mon, 1 Jun 2020 08:20:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkg7wjg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:20:48 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 051C2YZF117320;
	Mon, 1 Jun 2020 08:20:47 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkg7wjf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 08:20:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 051CFl2T011348;
	Mon, 1 Jun 2020 12:20:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 31bf47v21y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2020 12:20:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 051CKh3M66257150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2020 12:20:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBADF4203F;
	Mon,  1 Jun 2020 12:20:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DDC942047;
	Mon,  1 Jun 2020 12:20:41 +0000 (GMT)
Received: from [9.85.99.223] (unknown [9.85.99.223])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2020 12:20:41 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <20200601100925.GC3960@quack2.suse.cz>
 <2bf026cc-2ed0-70b6-bf99-ecfd0fa3dac4@linux.ibm.com>
 <20200601120705.GQ25173@kitsune.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <af150987-156f-71dc-a4cd-e6f8e670839a@linux.ibm.com>
Date: Mon, 1 Jun 2020 17:50:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601120705.GQ25173@kitsune.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_07:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 cotscore=-2147483648 phishscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010087
Message-ID-Hash: X23TYYP2E77TIVOMZDWHQIBGYATGIMDQ
X-Message-ID-Hash: X23TYYP2E77TIVOMZDWHQIBGYATGIMDQ
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X23TYYP2E77TIVOMZDWHQIBGYATGIMDQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNi8xLzIwIDU6MzcgUE0sIE1pY2hhbCBTdWNow6FuZWsgd3JvdGU6DQo+IE9uIE1vbiwgSnVu
IDAxLCAyMDIwIGF0IDA1OjMxOjUwUE0gKzA1MzAsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+
PiBPbiA2LzEvMjAgMzozOSBQTSwgSmFuIEthcmEgd3JvdGU6DQo+Pj4gT24gRnJpIDI5LTA1LTIw
IDE2OjI1OjM1LCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOg0KPj4+PiBPbiA1LzI5LzIwIDM6MjIg
UE0sIEphbiBLYXJhIHdyb3RlOg0KPj4+Pj4gT24gRnJpIDI5LTA1LTIwIDE1OjA3OjMxLCBBbmVl
c2ggS3VtYXIgSy5WIHdyb3RlOg0KPj4+Pj4+IFRoYW5rcyBNaWNoYWwuIEkgYWxzbyBtaXNzZWQg
SmVmZiBpbiB0aGlzIGVtYWlsIHRocmVhZC4NCj4+Pj4+DQo+Pj4+PiBBbmQgSSB0aGluayB5b3Un
bGwgYWxzbyBuZWVkIHNvbWUgb2YgdGhlIHNjaGVkIG1haW50YWluZXJzIGZvciB0aGUgcHJjdGwN
Cj4+Pj4+IGJpdHMuLi4NCj4+Pj4+DQo+Pj4+Pj4gT24gNS8yOS8yMCAzOjAzIFBNLCBNaWNoYWwg
U3VjaMOhbmVrIHdyb3RlOg0KPj4+Pj4+PiBBZGRpbmcgSmFuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9u
IEZyaSwgTWF5IDI5LCAyMDIwIGF0IDExOjExOjM5QU0gKzA1MzAsIEFuZWVzaCBLdW1hciBLLlYg
d3JvdGU6DQo+Pj4+Pj4+PiBXaXRoIFBPV0VSMTAsIGFyY2hpdGVjdHVyZSBpcyBhZGRpbmcgbmV3
IHBtZW0gZmx1c2ggYW5kIHN5bmMgaW5zdHJ1Y3Rpb25zLg0KPj4+Pj4+Pj4gVGhlIGtlcm5lbCBz
aG91bGQgcHJldmVudCB0aGUgdXNhZ2Ugb2YgTUFQX1NZTkMgaWYgYXBwbGljYXRpb25zIGFyZSBu
b3QgdXNpbmcNCj4+Pj4+Pj4+IHRoZSBuZXcgaW5zdHJ1Y3Rpb25zIG9uIG5ld2VyIGhhcmR3YXJl
Lg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIHByY3RsIG9wdGlvbiBNQVBf
U1lOQ19FTkFCTEUgdGhhdCBjYW4gYmUgdXNlZCB0byBlbmFibGUNCj4+Pj4+Pj4+IHRoZSB1c2Fn
ZSBvZiBNQVBfU1lOQy4gVGhlIGtlcm5lbCBjb25maWcgb3B0aW9uIGlzIGFkZGVkIHRvIGFsbG93
IHRoZSB1c2VyDQo+Pj4+Pj4+PiB0byBjb250cm9sIHdoZXRoZXIgTUFQX1NZTkMgc2hvdWxkIGJl
IGVuYWJsZWQgYnkgZGVmYXVsdCBvciBub3QuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+DQo+Pj4+
PiAuLi4NCj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2Zvcmsu
Yw0KPj4+Pj4+Pj4gaW5kZXggOGM3MDBmODgxZDkyLi5kNWE5YTM2M2U4MWUgMTAwNjQ0DQo+Pj4+
Pj4+PiAtLS0gYS9rZXJuZWwvZm9yay5jDQo+Pj4+Pj4+PiArKysgYi9rZXJuZWwvZm9yay5jDQo+
Pj4+Pj4+PiBAQCAtOTYzLDYgKzk2MywxMiBAQCBfX2NhY2hlbGluZV9hbGlnbmVkX2luX3NtcCBE
RUZJTkVfU1BJTkxPQ0sobW1saXN0X2xvY2spOw0KPj4+Pj4+Pj4gICAgICBzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBkZWZhdWx0X2R1bXBfZmlsdGVyID0gTU1GX0RVTVBfRklMVEVSX0RFRkFVTFQ7DQo+
Pj4+Pj4+PiArI2lmZGVmIENPTkZJR19BUkNIX01BUF9TWU5DX0RJU0FCTEUNCj4+Pj4+Pj4+ICt1
bnNpZ25lZCBsb25nIGRlZmF1bHRfbWFwX3N5bmNfbWFzayA9IE1NRl9ESVNBQkxFX01BUF9TWU5D
X01BU0s7DQo+Pj4+Pj4+PiArI2Vsc2UNCj4+Pj4+Pj4+ICt1bnNpZ25lZCBsb25nIGRlZmF1bHRf
bWFwX3N5bmNfbWFzayA9IDA7DQo+Pj4+Pj4+PiArI2VuZGlmDQo+Pj4+Pj4+PiArDQo+Pj4+Pg0K
Pj4+Pj4gSSdtIG5vdCBzdXJlIENPTkZJRyBpcyByZWFsbHkgdGhlIHJpZ2h0IGFwcHJvYWNoIGhl
cmUuIEZvciBhIGRpc3RybyB0aGF0IHdvdWxkDQo+Pj4+PiBiYXNpY2FsbHkgbWVhbiB0byBkaXNh
YmxlIE1BUF9TWU5DIGZvciBhbGwgUFBDIGtlcm5lbHMgdW5sZXNzIGFwcGxpY2F0aW9uDQo+Pj4+
PiBleHBsaWNpdGx5IHVzZXMgdGhlIHJpZ2h0IHByY3RsLiBTaG91bGRuJ3Qgd2UgcmF0aGVyIGlu
aXRpYWxpemUNCj4+Pj4+IGRlZmF1bHRfbWFwX3N5bmNfbWFzayBvbiBib290IGJhc2VkIG9uIHdo
ZXRoZXIgdGhlIENQVSB3ZSBydW4gb24gcmVxdWlyZXMNCj4+Pj4+IG5ldyBmbHVzaCBpbnN0cnVj
dGlvbnMgb3Igbm90PyBPdGhlcndpc2UgdGhlIHBhdGNoIGxvb2tzIHNlbnNpYmxlLg0KPj4+Pj4N
Cj4+Pj4NCj4+Pj4geWVzIHRoYXQgaXMgY29ycmVjdC4gV2UgaWRlYWxseSB3YW50IHRvIGRlbnkg
TUFQX1NZTkMgb25seSB3LnIudCBQT1dFUjEwLg0KPj4+PiBCdXQgb24gYSB2aXJ0dWFsaXplZCBw
bGF0Zm9ybSB0aGVyZSBpcyBubyBlYXN5IHdheSB0byBkZXRlY3QgdGhhdC4gV2UgY291bGQNCj4+
Pj4gaWRlYWxseSBob29rIHRoaXMgaW50byB0aGUgbnZkaW1tIGRyaXZlciB3aGVyZSB3ZSBsb29r
IGF0IHRoZSBuZXcgY29tcGF0DQo+Pj4+IHN0cmluZyBpYm0scGVyc2lzdGVudC1tZW1vcnktdjIg
YW5kIHRoZW4gZGlzYWJsZSBNQVBfU1lOQw0KPj4+PiBpZiB3ZSBmaW5kIGEgZGV2aWNlIHdpdGgg
dGhlIHNwZWNpZmljIHZhbHVlLg0KPj4+DQo+Pj4gSHVtLCBjb3VsZG4ndCB3ZSBzZXQgc29tZSBm
bGFnIGZvciBudmRpbW0gZGV2aWNlcyB3aXRoDQo+Pj4gImlibSxwZXJzaXN0ZW50LW1lbW9yeS12
MiIgcHJvcGVydHkgYW5kIHRoZW4gY2hlY2sgaXQgZHVyaW5nIG1tYXAoMikgdGltZQ0KPj4+IGFu
ZCB3aGVuIHRoZSBkZXZpY2UgaGFzIHRoaXMgcHJvcGVyeSBhbmQgdGhlIG1tYXAoMikgY2FsbGVy
IGRvZXNuJ3QgaGF2ZQ0KPj4+IHRoZSBwcmN0bCBzZXQsIHdlJ2QgZGlzYWxsb3cgTUFQX1NZTkM/
IFRoYXQgc2hvdWxkIG1ha2UgdGhpbmdzIG1vc3RseQ0KPj4+IHNlYW1sZXNzLCBzaG91bGRuJ3Qg
aXQ/IE9ubHkgYXBwcyB0aGF0IHdhbnQgdG8gdXNlIE1BUF9TWU5DIG9uIHRoZXNlDQo+Pj4gZGV2
aWNlcyB3b3VsZCBuZWVkIHRvIHVzZSBwcmN0bChNTUZfRElTQUJMRV9NQVBfU1lOQywgMCkgYnV0
IHRoZW4gdGhlc2UNCj4+PiBhcHBsaWNhdGlvbnMgbmVlZCB0byBiZSBhd2FyZSBvZiBuZXcgaW5z
dHJ1Y3Rpb25zIHNvIHRoaXMgaXNuJ3QgdGhhdCBtdWNoDQo+Pj4gYWRkaXRpb25hbCBidXJkZW4u
Li4NCj4+DQo+PiBJIGFtIG5vdCBzdXJlIGFwcGxpY2F0aW9uIHdvdWxkIHdhbnQgdG8gYWRkIHRo
YXQgbXVjaCBkZXRhaWxzL2tub3dsZWRnZQ0KPj4gYWJvdXQgYSBwbGF0Zm9ybSBpbiB0aGVpciBj
b2RlLiBJIHdhcyBleHBlY3RpbmcgYXBwbGljYXRpb24gdG8gZG8NCj4+DQo+PiAjaWZkZWYgX19w
cGM2NF9fDQo+PiAgICAgICAgICBwcmN0bChNQVBfU1lOQ19FTkFCTEUsIDEsIDAsIDAsIDApKTsN
Cj4+ICNlbmRpZg0KPj4gICAgICAgICAgYSA9IG1tYXAoTlVMTCwgUEFHRV9TSVpFLCBQUk9UX1JF
QUR8UFJPVF9XUklURSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBNQVBfU0hBUkVEX1ZB
TElEQVRFIHwgTUFQX1NZTkMsIGZkLCAwKTsNCj4+DQo+Pg0KPj4gRm9yIHRoYXQgY29kZSBhbGwg
dGhlIGNvbXBsZXhpdHkgdGhhdCB3ZSBhZGQgdy5yLnQgaWJtLHBlcnNpc3RlbnQtbWVtb3J5LXYy
DQo+PiBpcyBub3QgdXNlZnVsLiBEbyB5b3Ugc2VlIGEgdmFsdWUgaW4gbWFraW5nIGFsbCB0aGVz
ZSBkZXZpY2Ugc3BlY2lmaWMgcmF0aGVyDQo+PiB0aGFuIGEgY29uZGl0aW9uYWwgb24gIF9fcHBj
NjRfXz8NCg0KPiBJZiB0aGUgdnBtZW0gZGV2aWNlcyBjb250aW51ZSB0byB3b3JrIHdpdGggdGhl
IG9sZCBpbnN0cnVjdGlvbiBvbg0KPiBQT1dFUjEwIHRoZW4gaXQgbWFrZXMgc2Vuc2UgdG8gbWFr
ZSB0aGlzIHBlci1kZXZpY2UuDQoNCnZQTUVNIGRvZXNuJ3QgaGF2ZSB3cml0ZV9jYWNoZSBhbmQg
aGVuY2UgaXQgaXMgc3luY2hyb25vdXMgZXZlbiB3aXRob3V0IA0KdXNpbmcgYW55IHNwZWNpZmlj
IGZsdXNoIGluc3RydWN0aW9uLiBUaGUgcXVlc3Rpb24gaXMgZG8gd2Ugd2FudCB0byBoYXZlDQpk
aWZmZXJlbnQgcHJvZ3JhbW1pbmcgc3RlcHMgd2hlbiBydW5uaW5nIG9uIHZQTUVNIHZzIGEgcGVy
c2lzdGVudCBQTUVNIA0KZGV2aWNlIG9uIHBwYzY0Lg0KDQpJIHdpbGwgd29yayBvbiB0aGUgZGV2
aWNlIHNwZWNpZmljIEVOQUJMRSBmbGFnIGFuZCB0aGVuIHdlIGNhbiBjb21wYXJlIA0KdGhlIGtl
cm5lbCBjb21wbGV4aXR5IGFnYWluc3QgdGhlIGFkZGVkIGJlbmVmaXQuDQoNCg0KLWFuZWVzaApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRp
bW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3Jp
YmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
