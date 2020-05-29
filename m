Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C5F1E7B03
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 12:55:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DF951231EE6E;
	Fri, 29 May 2020 03:51:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 209A21231EE6E
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 03:51:27 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TAVnYf082301;
	Fri, 29 May 2020 06:55:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1dn09j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 06:55:45 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TAiMrZ150546;
	Fri, 29 May 2020 06:55:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31as1dn091-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 06:55:44 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TAthcT029895;
	Fri, 29 May 2020 10:55:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf93sqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 10:55:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04TAteen45744268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 10:55:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B823C11C054;
	Fri, 29 May 2020 10:55:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BBAE11C052;
	Fri, 29 May 2020 10:55:36 +0000 (GMT)
Received: from [9.85.84.128] (unknown [9.85.84.128])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2020 10:55:35 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: Jan Kara <jack@suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
 <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
 <20200529095250.GP14550@quack2.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7e8ee9e3-4d4d-e4b9-913b-1c2448adc62a@linux.ibm.com>
Date: Fri, 29 May 2020 16:25:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529095250.GP14550@quack2.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_02:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290080
Message-ID-Hash: 4CJBXQWUZQ355TNWNKKRUWXRWUE7HUS5
X-Message-ID-Hash: 4CJBXQWUZQ355TNWNKKRUWXRWUE7HUS5
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, jack@suse.de, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4CJBXQWUZQ355TNWNKKRUWXRWUE7HUS5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNS8yOS8yMCAzOjIyIFBNLCBKYW4gS2FyYSB3cm90ZToNCj4gSGkhDQo+IA0KPiBPbiBGcmkg
MjktMDUtMjAgMTU6MDc6MzEsIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6DQo+PiBUaGFua3MgTWlj
aGFsLiBJIGFsc28gbWlzc2VkIEplZmYgaW4gdGhpcyBlbWFpbCB0aHJlYWQuDQo+IA0KPiBBbmQg
SSB0aGluayB5b3UnbGwgYWxzbyBuZWVkIHNvbWUgb2YgdGhlIHNjaGVkIG1haW50YWluZXJzIGZv
ciB0aGUgcHJjdGwNCj4gYml0cy4uLg0KPiANCj4+IE9uIDUvMjkvMjAgMzowMyBQTSwgTWljaGFs
IFN1Y2jDoW5layB3cm90ZToNCj4+PiBBZGRpbmcgSmFuDQo+Pj4NCj4+PiBPbiBGcmksIE1heSAy
OSwgMjAyMCBhdCAxMToxMTozOUFNICswNTMwLCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOg0KPj4+
PiBXaXRoIFBPV0VSMTAsIGFyY2hpdGVjdHVyZSBpcyBhZGRpbmcgbmV3IHBtZW0gZmx1c2ggYW5k
IHN5bmMgaW5zdHJ1Y3Rpb25zLg0KPj4+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2ZW50IHRoZSB1
c2FnZSBvZiBNQVBfU1lOQyBpZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0KPj4+PiB0aGUg
bmV3IGluc3RydWN0aW9ucyBvbiBuZXdlciBoYXJkd2FyZS4NCj4+Pj4NCj4+Pj4gVGhpcyBwYXRj
aCBhZGRzIGEgcHJjdGwgb3B0aW9uIE1BUF9TWU5DX0VOQUJMRSB0aGF0IGNhbiBiZSB1c2VkIHRv
IGVuYWJsZQ0KPj4+PiB0aGUgdXNhZ2Ugb2YgTUFQX1NZTkMuIFRoZSBrZXJuZWwgY29uZmlnIG9w
dGlvbiBpcyBhZGRlZCB0byBhbGxvdyB0aGUgdXNlcg0KPj4+PiB0byBjb250cm9sIHdoZXRoZXIg
TUFQX1NZTkMgc2hvdWxkIGJlIGVuYWJsZWQgYnkgZGVmYXVsdCBvciBub3QuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IEFuZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0u
Y29tPg0KPiAuLi4NCj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9y
ay5jDQo+Pj4+IGluZGV4IDhjNzAwZjg4MWQ5Mi4uZDVhOWEzNjNlODFlIDEwMDY0NA0KPj4+PiAt
LS0gYS9rZXJuZWwvZm9yay5jDQo+Pj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMNCj4+Pj4gQEAgLTk2
Myw2ICs5NjMsMTIgQEAgX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9zbXAgREVGSU5FX1NQSU5MT0NL
KG1tbGlzdF9sb2NrKTsNCj4+Pj4gICAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZGVmYXVsdF9kdW1w
X2ZpbHRlciA9IE1NRl9EVU1QX0ZJTFRFUl9ERUZBVUxUOw0KPj4+PiArI2lmZGVmIENPTkZJR19B
UkNIX01BUF9TWU5DX0RJU0FCTEUNCj4+Pj4gK3Vuc2lnbmVkIGxvbmcgZGVmYXVsdF9tYXBfc3lu
Y19tYXNrID0gTU1GX0RJU0FCTEVfTUFQX1NZTkNfTUFTSzsNCj4+Pj4gKyNlbHNlDQo+Pj4+ICt1
bnNpZ25lZCBsb25nIGRlZmF1bHRfbWFwX3N5bmNfbWFzayA9IDA7DQo+Pj4+ICsjZW5kaWYNCj4+
Pj4gKw0KPiANCj4gSSdtIG5vdCBzdXJlIENPTkZJRyBpcyByZWFsbHkgdGhlIHJpZ2h0IGFwcHJv
YWNoIGhlcmUuIEZvciBhIGRpc3RybyB0aGF0IHdvdWxkDQo+IGJhc2ljYWxseSBtZWFuIHRvIGRp
c2FibGUgTUFQX1NZTkMgZm9yIGFsbCBQUEMga2VybmVscyB1bmxlc3MgYXBwbGljYXRpb24NCj4g
ZXhwbGljaXRseSB1c2VzIHRoZSByaWdodCBwcmN0bC4gU2hvdWxkbid0IHdlIHJhdGhlciBpbml0
aWFsaXplDQo+IGRlZmF1bHRfbWFwX3N5bmNfbWFzayBvbiBib290IGJhc2VkIG9uIHdoZXRoZXIg
dGhlIENQVSB3ZSBydW4gb24gcmVxdWlyZXMNCj4gbmV3IGZsdXNoIGluc3RydWN0aW9ucyBvciBu
b3Q/IE90aGVyd2lzZSB0aGUgcGF0Y2ggbG9va3Mgc2Vuc2libGUuDQo+IA0KDQp5ZXMgdGhhdCBp
cyBjb3JyZWN0LiBXZSBpZGVhbGx5IHdhbnQgdG8gZGVueSBNQVBfU1lOQyBvbmx5IHcuci50IA0K
UE9XRVIxMC4gQnV0IG9uIGEgdmlydHVhbGl6ZWQgcGxhdGZvcm0gdGhlcmUgaXMgbm8gZWFzeSB3
YXkgdG8gZGV0ZWN0IA0KdGhhdC4gV2UgY291bGQgaWRlYWxseSBob29rIHRoaXMgaW50byB0aGUg
bnZkaW1tIGRyaXZlciB3aGVyZSB3ZSBsb29rIGF0IA0KdGhlIG5ldyBjb21wYXQgc3RyaW5nIGli
bSxwZXJzaXN0ZW50LW1lbW9yeS12MiBhbmQgdGhlbiBkaXNhYmxlIE1BUF9TWU5DDQppZiB3ZSBm
aW5kIGEgZGV2aWNlIHdpdGggdGhlIHNwZWNpZmljIHZhbHVlLg0KDQpCVFcgd2l0aCB0aGUgcmVj
ZW50IGNoYW5nZXMgSSBwb3N0ZWQgZm9yIHRoZSBudmRpbW0gZHJpdmVyLCBvbGRlciBrZXJuZWwg
DQp3b24ndCBpbml0aWFsaXplIHBlcnNpc3RlbnQgbWVtb3J5IGRldmljZSBvbiBuZXdlciBoYXJk
d2FyZS4gTmV3ZXIgDQpoYXJkd2FyZSB3aWxsIHByZXNlbnQgdGhlIGRldmljZSB0byBPUyB3aXRo
IGEgZGlmZmVyZW50IGRldmljZSB0cmVlIA0KY29tcGF0IHN0cmluZy4NCg0KTXkgZXhwZWN0YXRp
b24gIHcuci50IHRoaXMgcGF0Y2ggd2FzLCBEaXN0cm8gd291bGQgd2FudCB0byAgbWFyaw0KQ09O
RklHX0FSQ0hfTUFQX1NZTkNfRElTQUJMRT1uIGJhc2VkIG9uIHRoZSBkaWZmZXJlbnQgYXBwbGlj
YXRpb24gDQpjZXJ0aWZpY2F0aW9uLiAgT3RoZXJ3aXNlIGFwcGxpY2F0aW9uIHdpbGwgaGF2ZSB0
byBlbmQgdXAgY2FsbGluZyB0aGUgDQpwcmN0bChNTUZfRElTQUJMRV9NQVBfU1lOQywgMCkgYW55
IHdheS4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgc2hvdWxkIHRoaXMNCmJlIGRlcGVuZGVudCBvbiBQ
MTA/DQoNCldpdGggdGhhdCBJIGFtIHdvbmRlcmluZyBzaG91bGQgd2UgZXZlbiBoYXZlIHRoaXMg
cGF0Y2g/IENhbiB3ZSBleHBlY3QgDQp1c2Vyc3BhY2UgZ2V0IHVwZGF0ZWQgdG8gdXNlIG5ldyBp
bnN0cnVjdGlvbj8uDQoNCldpdGggcHBjNjQgd2UgbmV2ZXIgaGFkIGEgcmVhbCBwZXJzaXN0ZW50
IG1lbW9yeSBkZXZpY2UgYXZhaWxhYmxlIGZvciANCmVuZCB1c2VyIHRvIHRyeS4gVGhlIGF2YWls
YWJsZSBwZXJzaXN0ZW50IG1lbW9yeSBzdGFjayB3YXMgdXNpbmcgdlBNRU0gDQp3aGljaCB3YXMg
cHJlc2VudGVkIGFzIGEgdm9sYXRpbGUgbWVtb3J5IHJlZ2lvbiBmb3Igd2hpY2ggdGhlcmUgaXMg
bm8gDQpuZWVkIHRvIHVzZSBhbnkgb2YgdGhlIGZsdXNoIGluc3RydWN0aW9ucy4gV2UgY291bGQg
c2FmZWx5IGFzc3VtZSB0aGF0IA0KYXMgd2UgZ2V0IGFwcGxpY2F0aW9ucyBjZXJ0aWZpZWQvdmVy
aWZpZWQgZm9yIHdvcmtpbmcgd2l0aCBwbWVtIGRldmljZSANCm9uIHBwYzY0LCB0aGV5IHdvdWxk
IGFsbCBiZSB1c2luZyB0aGUgbmV3IGluc3RydWN0aW9ucz8NCg0KDQotYW5lZXNoDQoNCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
