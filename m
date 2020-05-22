Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591A1DE3B5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 May 2020 12:08:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DBD8911F4592E;
	Fri, 22 May 2020 03:05:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 828DD117AE4DB
	for <linux-nvdimm@lists.01.org>; Fri, 22 May 2020 03:05:12 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04MA397p131619;
	Fri, 22 May 2020 06:08:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3160mktfqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2020 06:08:47 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04MA3IFP132696;
	Fri, 22 May 2020 06:08:47 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 3160mktfpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2020 06:08:47 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MA5Imh015672;
	Fri, 22 May 2020 10:08:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma05fra.de.ibm.com with ESMTP id 313x4xk19p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2020 10:08:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04MA8gwZ42533016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2020 10:08:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611864C052;
	Fri, 22 May 2020 10:08:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E6864C04E;
	Fri, 22 May 2020 10:08:40 +0000 (GMT)
Received: from [9.85.70.225] (unknown [9.85.70.225])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2020 10:08:40 +0000 (GMT)
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
 <87v9kspk3x.fsf@linux.ibm.com>
 <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com>
 <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
 <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
 <ba91c061-41ef-5c54-8e9b-7b22e44577cd@linux.ibm.com>
 <CAPcyv4iG9GC42s5DaWWegH=Mi7XHgJoUghgOM9qMRrCg4wuMig@mail.gmail.com>
 <alpine.LRH.2.02.2005211442290.22894@file01.intranet.prod.int.rdu2.redhat.com>
 <20200522093127.GY25173@kitsune.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <23e57565-be2a-a45c-f4d4-d8eca7262dea@linux.ibm.com>
Date: Fri, 22 May 2020 15:38:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522093127.GY25173@kitsune.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220082
Message-ID-Hash: 4XQWSQYTP7Q4X6TYTKWUMCIYPUDFJZET
X-Message-ID-Hash: 4XQWSQYTP7Q4X6TYTKWUMCIYPUDFJZET
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4XQWSQYTP7Q4X6TYTKWUMCIYPUDFJZET/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNS8yMi8yMCAzOjAxIFBNLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOg0KPiBPbiBUaHUsIE1h
eSAyMSwgMjAyMCBhdCAwMjo1MjozMFBNIC0wNDAwLCBNaWt1bGFzIFBhdG9ja2Egd3JvdGU6DQo+
Pg0KPj4NCj4+IE9uIFRodSwgMjEgTWF5IDIwMjAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+DQo+
Pj4gT24gVGh1LCBNYXkgMjEsIDIwMjAgYXQgMTA6MDMgQU0gQW5lZXNoIEt1bWFyIEsuVg0KPj4+
IDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+PiBNb3Zpbmcg
b24gdG8gdGhlIHBhdGNoIGl0c2VsZi0tQW5lZXNoLCBoYXZlIHlvdSBhdWRpdGVkIG90aGVyIHBl
cnNpc3RlbnQNCj4+Pj4+IG1lbW9yeSB1c2VycyBpbiB0aGUga2VybmVsPyAgRm9yIGV4YW1wbGUs
IGRyaXZlcnMvbWQvZG0td3JpdGVjYWNoZS5jIGRvZXMNCj4+Pj4+IHRoaXM6DQo+Pj4+Pg0KPj4+
Pj4gc3RhdGljIHZvaWQgd3JpdGVjYWNoZV9jb21taXRfZmx1c2hlZChzdHJ1Y3QgZG1fd3JpdGVj
YWNoZSAqd2MsIGJvb2wgd2FpdF9mb3JfaW9zKQ0KPj4+Pj4gew0KPj4+Pj4gICAgICAgIGlmIChX
Q19NT0RFX1BNRU0od2MpKQ0KPj4+Pj4gICAgICAgICAgICAgICAgd21iKCk7IDw9PT09PT09PT09
DQo+Pj4+PiAgICAgICAgICAgZWxzZQ0KPj4+Pj4gICAgICAgICAgICAgICAgICAgc3NkX2NvbW1p
dF9mbHVzaGVkKHdjLCB3YWl0X2Zvcl9pb3MpOw0KPj4+Pj4gfQ0KPj4+Pj4NCj4+Pj4+IEkgYmVs
aWV2ZSB5b3UnbGwgbmVlZCB0byBtYWtlIG1vZGlmaWNhdGlvbnMgdGhlcmUuDQo+Pj4+Pg0KPj4+
Pg0KPj4+PiBDb3JyZWN0LiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoYXQuDQo+Pj4+DQo+Pj4+DQo+
Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCBkbSBtdWNoLCB3b25kZXJpbmcgaG93IHRoaXMgd2lsbCB3
b3JrIHdpdGgNCj4+Pj4gbm9uLXN5bmNocm9ub3VzIERBWCBkZXZpY2U/DQo+Pj4NCj4+PiBUaGF0
J3MgYSBnb29kIHBvaW50LiBETS13cml0ZWNhY2hlIG5lZWRzIHRvIGJlIGNvZ25pemFudCBvZiB0
aGluZ3MNCj4+PiBsaWtlIHZpcnRpby1wbWVtIHRoYXQgdmlvbGF0ZSB0aGUgcnVsZSB0aGF0IHBl
cnNpc2VudCBtZW1vcnkgd3JpdGVzDQo+Pj4gY2FuIGJlIGZsdXNoZWQgYnkgQ1BVIGZ1bmN0aW9u
cyByYXRoZXIgdGhhbiBjYWxsaW5nIGJhY2sgaW50byB0aGUNCj4+PiBkcml2ZXIuIEl0IHNlZW1z
IHdlIG5lZWQgdG8gYWx3YXlzIG1ha2UgdGhlIGZsdXNoIGNhc2UgYSBkYXhfb3BlcmF0aW9uDQo+
Pj4gY2FsbGJhY2sgdG8gYWNjb3VudCBmb3IgdGhpcy4NCj4+DQo+PiBkbS13cml0ZWNhY2hlIGlz
IG5vcm1hbGx5IHNpdHRpbmcgb24gdGhlIHRvcCBvZiBkbS1saW5lYXIsIHNvIGl0IHdvdWxkDQo+
PiBuZWVkIHRvIHBhc3MgdGhlIHdtYigpIGNhbGwgdGhyb3VnaCB0aGUgZG0gY29yZSBhbmQgZG0t
bGluZWFyIHRhcmdldCAuLi4NCj4+IHRoYXQgd291bGQgc2xvdyBpdCBkb3duIC4uLiBJIHJlbWVt
YmVyIHRoYXQgeW91IGFscmVhZHkgZGlkIGl0IHRoaXMgd2F5DQo+PiBzb21lIHRpbWVzIGFnbyBh
bmQgdGhlbiByZW1vdmVkIGl0Lg0KPj4NCj4+IFdoYXQncyB0aGUgZXhhY3QgcHJvYmxlbSB3aXRo
IFBPV0VSPyBDb3VsZCB0aGUgUE9XRVIgc3lzdGVtIGhhdmUgdHdvIHR5cGVzDQo+PiBvZiBwZXJz
aXN0ZW50IG1lbW9yeSB0aGF0IG5lZWQgdHdvIGRpZmZlcmVudCB3YXlzIG9mIGZsdXNoaW5nPw0K
PiANCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUgZGlzY3Vzc2lvbiBzbyBmYXINCj4gDQo+
ICAgLSBvbiBQT1dFUiAkb2xkaGFyZHdhcmUgdXNlcyAkb2xkaW5zdHJ1Y3Rpb24gdG8gZW5zdXJl
IHBtZW0gY29uc2lzdGVuY3kNCj4gICAtIG9uIFBPV0VSICRuZXdoYXJkd2FyZSB1c2VzICRuZXdp
bnN0cnVjdGlvbiB0byBlbnN1cmUgcG1lbSBjb25zaXN0ZW5jeQ0KPiAgICAgKGNvbXBhdGlibGUg
d2l0aCAkb2xkaW5zdHJ1Y3Rpb24gb24gJG9sZGhhcmR3YXJlKQ0KDQpDb3JyZWN0Lg0KDQo+ICAg
LSBvbiBzb21lIHBsYXRmb3JtcyBpbnN0ZWFkIG9mIGJhcnJpZXIgaW5zdHJ1Y3Rpb24gYSBjYWxs
YmFjayBpbnRvIHRoZQ0KPiAgICAgZHJpdmVyIGlzIGlzc3VlZCB0byBlbnN1cmUgY29uc2lzdGVu
Y3kgDQoNClRoaXMgaXMgdmlydGlvLXBtZW0gb25seSBhdCB0aGlzIHBvaW50IElJVUMuDQoNCg0K
PiANCj4gTm9uZSBvZiB0aGlzIGlzIHJlZmxlY3RlZCBieSB0aGUgZG0gZHJpdmVyLg0KPiANCg0K
LWFuZWVzaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
