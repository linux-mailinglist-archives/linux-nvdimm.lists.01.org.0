Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A381E8EDA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 09:18:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6022100F2276;
	Sat, 30 May 2020 00:14:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC3DB100F2260
	for <linux-nvdimm@lists.01.org>; Sat, 30 May 2020 00:14:19 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04U73cQu147824;
	Sat, 30 May 2020 03:18:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bhtas9g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 May 2020 03:18:41 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04U75uhY157503;
	Sat, 30 May 2020 03:18:41 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bhtas9fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 May 2020 03:18:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04U7Bp3S023676;
	Sat, 30 May 2020 07:18:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma04ams.nl.ibm.com with ESMTP id 31bf47r9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 May 2020 07:18:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04U7IaXd49742040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 May 2020 07:18:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1788A4051;
	Sat, 30 May 2020 07:18:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790BAA404D;
	Sat, 30 May 2020 07:18:34 +0000 (GMT)
Received: from [9.79.179.87] (unknown [9.79.179.87])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Sat, 30 May 2020 07:18:34 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: Dan Williams <dan.j.williams@intel.com>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
 <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
 <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7f163562-e7e3-7668-7415-c40e57c32582@linux.ibm.com>
Date: Sat, 30 May 2020 12:48:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jrss3dFcCOar3JTFnuN0_pgFNtBPiJzUdKxtiax6pPgQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-30_02:2020-05-28,2020-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 clxscore=1015 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005300054
Message-ID-Hash: UMOQZAWVRZ2C6ZKXE5S4JANPASORDZC2
X-Message-ID-Hash: UMOQZAWVRZ2C6ZKXE5S4JANPASORDZC2
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMOQZAWVRZ2C6ZKXE5S4JANPASORDZC2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNS8zMC8yMCAxMjo1MiBBTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBGcmksIE1heSAy
OSwgMjAyMCBhdCAzOjU1IEFNIEFuZWVzaCBLdW1hciBLLlYNCj4gPGFuZWVzaC5rdW1hckBsaW51
eC5pYm0uY29tPiB3cm90ZToNCj4+DQo+PiBPbiA1LzI5LzIwIDM6MjIgUE0sIEphbiBLYXJhIHdy
b3RlOg0KPj4+IEhpIQ0KPj4+DQo+Pj4gT24gRnJpIDI5LTA1LTIwIDE1OjA3OjMxLCBBbmVlc2gg
S3VtYXIgSy5WIHdyb3RlOg0KPj4+PiBUaGFua3MgTWljaGFsLiBJIGFsc28gbWlzc2VkIEplZmYg
aW4gdGhpcyBlbWFpbCB0aHJlYWQuDQo+Pj4NCj4+PiBBbmQgSSB0aGluayB5b3UnbGwgYWxzbyBu
ZWVkIHNvbWUgb2YgdGhlIHNjaGVkIG1haW50YWluZXJzIGZvciB0aGUgcHJjdGwNCj4+PiBiaXRz
Li4uDQo+Pj4NCj4+Pj4gT24gNS8yOS8yMCAzOjAzIFBNLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3Rl
Og0KPj4+Pj4gQWRkaW5nIEphbg0KPj4+Pj4NCj4+Pj4+IE9uIEZyaSwgTWF5IDI5LCAyMDIwIGF0
IDExOjExOjM5QU0gKzA1MzAsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+Pj4+Pj4gV2l0aCBQ
T1dFUjEwLCBhcmNoaXRlY3R1cmUgaXMgYWRkaW5nIG5ldyBwbWVtIGZsdXNoIGFuZCBzeW5jIGlu
c3RydWN0aW9ucy4NCj4+Pj4+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2ZW50IHRoZSB1c2FnZSBv
ZiBNQVBfU1lOQyBpZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0KPj4+Pj4+IHRoZSBuZXcg
aW5zdHJ1Y3Rpb25zIG9uIG5ld2VyIGhhcmR3YXJlLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBwYXRj
aCBhZGRzIGEgcHJjdGwgb3B0aW9uIE1BUF9TWU5DX0VOQUJMRSB0aGF0IGNhbiBiZSB1c2VkIHRv
IGVuYWJsZQ0KPj4+Pj4+IHRoZSB1c2FnZSBvZiBNQVBfU1lOQy4gVGhlIGtlcm5lbCBjb25maWcg
b3B0aW9uIGlzIGFkZGVkIHRvIGFsbG93IHRoZSB1c2VyDQo+Pj4+Pj4gdG8gY29udHJvbCB3aGV0
aGVyIE1BUF9TWU5DIHNob3VsZCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQgb3Igbm90Lg0KPj4+Pj4+
DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGxp
bnV4LmlibS5jb20+DQo+Pj4gLi4uDQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMg
Yi9rZXJuZWwvZm9yay5jDQo+Pj4+Pj4gaW5kZXggOGM3MDBmODgxZDkyLi5kNWE5YTM2M2U4MWUg
MTAwNjQ0DQo+Pj4+Pj4gLS0tIGEva2VybmVsL2ZvcmsuYw0KPj4+Pj4+ICsrKyBiL2tlcm5lbC9m
b3JrLmMNCj4+Pj4+PiBAQCAtOTYzLDYgKzk2MywxMiBAQCBfX2NhY2hlbGluZV9hbGlnbmVkX2lu
X3NtcCBERUZJTkVfU1BJTkxPQ0sobW1saXN0X2xvY2spOw0KPj4+Pj4+ICAgICBzdGF0aWMgdW5z
aWduZWQgbG9uZyBkZWZhdWx0X2R1bXBfZmlsdGVyID0gTU1GX0RVTVBfRklMVEVSX0RFRkFVTFQ7
DQo+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfQVJDSF9NQVBfU1lOQ19ESVNBQkxFDQo+Pj4+Pj4gK3Vu
c2lnbmVkIGxvbmcgZGVmYXVsdF9tYXBfc3luY19tYXNrID0gTU1GX0RJU0FCTEVfTUFQX1NZTkNf
TUFTSzsNCj4+Pj4+PiArI2Vsc2UNCj4+Pj4+PiArdW5zaWduZWQgbG9uZyBkZWZhdWx0X21hcF9z
eW5jX21hc2sgPSAwOw0KPj4+Pj4+ICsjZW5kaWYNCj4+Pj4+PiArDQo+Pj4NCj4+PiBJJ20gbm90
IHN1cmUgQ09ORklHIGlzIHJlYWxseSB0aGUgcmlnaHQgYXBwcm9hY2ggaGVyZS4gRm9yIGEgZGlz
dHJvIHRoYXQgd291bGQNCj4+PiBiYXNpY2FsbHkgbWVhbiB0byBkaXNhYmxlIE1BUF9TWU5DIGZv
ciBhbGwgUFBDIGtlcm5lbHMgdW5sZXNzIGFwcGxpY2F0aW9uDQo+Pj4gZXhwbGljaXRseSB1c2Vz
IHRoZSByaWdodCBwcmN0bC4gU2hvdWxkbid0IHdlIHJhdGhlciBpbml0aWFsaXplDQo+Pj4gZGVm
YXVsdF9tYXBfc3luY19tYXNrIG9uIGJvb3QgYmFzZWQgb24gd2hldGhlciB0aGUgQ1BVIHdlIHJ1
biBvbiByZXF1aXJlcw0KPj4+IG5ldyBmbHVzaCBpbnN0cnVjdGlvbnMgb3Igbm90PyBPdGhlcndp
c2UgdGhlIHBhdGNoIGxvb2tzIHNlbnNpYmxlLg0KPj4+DQo+Pg0KPj4geWVzIHRoYXQgaXMgY29y
cmVjdC4gV2UgaWRlYWxseSB3YW50IHRvIGRlbnkgTUFQX1NZTkMgb25seSB3LnIudA0KPj4gUE9X
RVIxMC4gQnV0IG9uIGEgdmlydHVhbGl6ZWQgcGxhdGZvcm0gdGhlcmUgaXMgbm8gZWFzeSB3YXkg
dG8gZGV0ZWN0DQo+PiB0aGF0LiBXZSBjb3VsZCBpZGVhbGx5IGhvb2sgdGhpcyBpbnRvIHRoZSBu
dmRpbW0gZHJpdmVyIHdoZXJlIHdlIGxvb2sgYXQNCj4+IHRoZSBuZXcgY29tcGF0IHN0cmluZyBp
Ym0scGVyc2lzdGVudC1tZW1vcnktdjIgYW5kIHRoZW4gZGlzYWJsZSBNQVBfU1lOQw0KPj4gaWYg
d2UgZmluZCBhIGRldmljZSB3aXRoIHRoZSBzcGVjaWZpYyB2YWx1ZS4NCj4+DQo+PiBCVFcgd2l0
aCB0aGUgcmVjZW50IGNoYW5nZXMgSSBwb3N0ZWQgZm9yIHRoZSBudmRpbW0gZHJpdmVyLCBvbGRl
ciBrZXJuZWwNCj4+IHdvbid0IGluaXRpYWxpemUgcGVyc2lzdGVudCBtZW1vcnkgZGV2aWNlIG9u
IG5ld2VyIGhhcmR3YXJlLiBOZXdlcg0KPj4gaGFyZHdhcmUgd2lsbCBwcmVzZW50IHRoZSBkZXZp
Y2UgdG8gT1Mgd2l0aCBhIGRpZmZlcmVudCBkZXZpY2UgdHJlZQ0KPj4gY29tcGF0IHN0cmluZy4N
Cj4+DQo+PiBNeSBleHBlY3RhdGlvbiAgdy5yLnQgdGhpcyBwYXRjaCB3YXMsIERpc3RybyB3b3Vs
ZCB3YW50IHRvICBtYXJrDQo+PiBDT05GSUdfQVJDSF9NQVBfU1lOQ19ESVNBQkxFPW4gYmFzZWQg
b24gdGhlIGRpZmZlcmVudCBhcHBsaWNhdGlvbg0KPj4gY2VydGlmaWNhdGlvbi4gIE90aGVyd2lz
ZSBhcHBsaWNhdGlvbiB3aWxsIGhhdmUgdG8gZW5kIHVwIGNhbGxpbmcgdGhlDQo+PiBwcmN0bChN
TUZfRElTQUJMRV9NQVBfU1lOQywgMCkgYW55IHdheS4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgc2hv
dWxkIHRoaXMNCj4+IGJlIGRlcGVuZGVudCBvbiBQMTA/DQo+Pg0KPj4gV2l0aCB0aGF0IEkgYW0g
d29uZGVyaW5nIHNob3VsZCB3ZSBldmVuIGhhdmUgdGhpcyBwYXRjaD8gQ2FuIHdlIGV4cGVjdA0K
Pj4gdXNlcnNwYWNlIGdldCB1cGRhdGVkIHRvIHVzZSBuZXcgaW5zdHJ1Y3Rpb24/Lg0KPj4NCj4+
IFdpdGggcHBjNjQgd2UgbmV2ZXIgaGFkIGEgcmVhbCBwZXJzaXN0ZW50IG1lbW9yeSBkZXZpY2Ug
YXZhaWxhYmxlIGZvcg0KPj4gZW5kIHVzZXIgdG8gdHJ5LiBUaGUgYXZhaWxhYmxlIHBlcnNpc3Rl
bnQgbWVtb3J5IHN0YWNrIHdhcyB1c2luZyB2UE1FTQ0KPj4gd2hpY2ggd2FzIHByZXNlbnRlZCBh
cyBhIHZvbGF0aWxlIG1lbW9yeSByZWdpb24gZm9yIHdoaWNoIHRoZXJlIGlzIG5vDQo+PiBuZWVk
IHRvIHVzZSBhbnkgb2YgdGhlIGZsdXNoIGluc3RydWN0aW9ucy4gV2UgY291bGQgc2FmZWx5IGFz
c3VtZSB0aGF0DQo+PiBhcyB3ZSBnZXQgYXBwbGljYXRpb25zIGNlcnRpZmllZC92ZXJpZmllZCBm
b3Igd29ya2luZyB3aXRoIHBtZW0gZGV2aWNlDQo+PiBvbiBwcGM2NCwgdGhleSB3b3VsZCBhbGwg
YmUgdXNpbmcgdGhlIG5ldyBpbnN0cnVjdGlvbnM/DQo+IA0KPiBJIHRoaW5rIHByY3RsIGlzIHRo
ZSB3cm9uZyBpbnRlcmZhY2UgZm9yIHRoaXMuIEkgd2FzIHRoaW5raW5nIGEgc3lzZnMNCj4gaW50
ZXJmYWNlIGFsb25nIHRoZSBzYW1lIGxpbmVzIGFzIC9zeXMvYmxvY2svcG1lbVgvZGF4L3dyaXRl
X2NhY2hlLg0KPiBUaGF0IGF0dHJpYnV0ZSBpcyB0b2dnbGluZyBEQVhERVZfV1JJVEVfQ0FDSEUg
Zm9yIHRoZSBkZXRlcm1pbmF0aW9uIG9mDQo+IHdoZXRoZXIgdGhlIHBsYXRmb3JtIG9yIHRoZSBr
ZXJuZWwgbmVlZHMgdG8gaGFuZGxlIGNhY2hlIGZsdXNoaW5nDQo+IHJlbGF0aXZlIHRvIHBvd2Vy
IGxvc3MuIEEgc2ltaWxhciBhdHRyaWJ1dGUgY2FuIGJlIGVzdGFibGlzaGVkIGZvcg0KPiBEQVhE
RVZfU1lOQywgaXQgd291bGQgc2ltcGx5IGRlZmF1bHQgdG8gb2ZmIGJhc2VkIG9uIGEgY29uZmln
dXJhdGlvbg0KPiB0aW1lIHBvbGljeSwgYnV0IGJlIGR5bmFtaWNhbGx5IGNoYW5nZWFibGUgYXQg
cnVudGltZSB2aWEgc3lzZnMuDQo+IA0KPiBUaGVzZSBmbGFncyBhcmUgZGV2aWNlIHByb3BlcnRp
ZXMgdGhhdCBhZmZlY3QgdGhlIGtlcm5lbCBhbmQNCj4gdXNlcnNwYWNlJ3MgaGFuZGxpbmcgb2Yg
cGVyc2lzdGVuY2UuDQo+IA0KDQpUaGF0IHdpbGwgbm90IGhhbmRsZSB0aGUgc2NlbmFyaW8gd2l0
aCBtdWx0aXBsZSBhcHBsaWNhdGlvbnMgdXNpbmcgdGhlIA0Kc2FtZSBmc2RheCBtb3VudCBwb2lu
dCB3aGVyZSBvbmUgaXMgdXBkYXRlZCB0byB1c2UgdGhlIG5ldyBpbnN0cnVjdGlvbiANCmFuZCB0
aGUgb3RoZXIgaXMgbm90Lg0KDQotYW5lZXNlaApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
