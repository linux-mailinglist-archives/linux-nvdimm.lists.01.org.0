Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811F1908D3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 10:16:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BC8810FC38AA;
	Tue, 24 Mar 2020 02:16:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C419D10FC38A9
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 02:16:55 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O93wqX064445;
	Tue, 24 Mar 2020 05:16:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejw4wv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2020 05:16:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02O93wD4064429;
	Tue, 24 Mar 2020 05:16:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejw4wuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2020 05:16:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02O9EdDe017613;
	Tue, 24 Mar 2020 09:16:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma02wdc.us.ibm.com with ESMTP id 2ywawjq77b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2020 09:16:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O9FxoK37290390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 09:15:59 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64B30BE059;
	Tue, 24 Mar 2020 09:15:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4BDCBE051;
	Tue, 24 Mar 2020 09:15:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.116.254])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2020 09:15:55 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
In-Reply-To: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2020 14:45:53 +0530
Message-ID: <87a746cdva.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=2 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240048
Message-ID-Hash: X637WJVBN4SDBFRDUTSIRY5KT6JG566X
X-Message-ID-Hash: X637WJVBN4SDBFRDUTSIRY5KT6JG566X
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X637WJVBN4SDBFRDUTSIRY5KT6JG566X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXgudm5ldC5pYm0uY29tPiB3cml0ZXM6DQoNCj4gV2hp
bGUgcnVubmluZyBuZGN0bFsxXSB0ZXN0cyBhZ2FpbnN0IDUuNi4wLXJjNyBmb2xsb3dpbmcgY3Jh
c2ggaXMgZW5jb3VudGVyZWQuDQo+DQo+IEJpc2VjdCBsZWFkcyBtZSB0byAgY29tbWl0IGQ0MWUy
ZjNiZDU0NiANCj4gbW0vaG90cGx1ZzogZml4IGhvdCByZW1vdmUgZmFpbHVyZSBpbiBTUEFSU0VN
RU18IVZNRU1NQVAgY2FzZQ0KPg0KPiBSZXZlcnRpbmcgdGhpcyBjb21taXQgaGVscHMgYW5kIHRo
ZSB0ZXN0cyBjb21wbGV0ZSB3aXRob3V0IGFueSBjcmFzaC4NCj4NCj4gcG1lbTA6IGRldGVjdGVk
IGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMTA3MjA2NDEwMjQNCj4gQlVHOiBLZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIG9uIHJlYWQgYXQgMHgwMDAwMDAwMA0KPiBGYXVsdGluZyBp
bnN0cnVjdGlvbiBhZGRyZXNzOiAweGMwMDAwMDAwMDBjMzQ0N2MNCj4gT29wczogS2VybmVsIGFj
Y2VzcyBvZiBiYWQgYXJlYSwgc2lnOiAxMSBbIzFdDQo+IExFIFBBR0VfU0laRT02NEsgTU1VPUhh
c2ggU01QIE5SX0NQVVM9MjA0OCBOVU1BIHBTZXJpZXMNCj4gRHVtcGluZyBmdHJhY2UgYnVmZmVy
Og0KPiAgICAoZnRyYWNlIGJ1ZmZlciBlbXB0eSkNCj4gTW9kdWxlcyBsaW5rZWQgaW46IGRtX21v
ZCBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgbGliY3JjMzJjIGlw
Nl90YWJsZXMgbmZ0X2NvbXBhdCBpcF9zZXQgcmZraWxsIG5mX3RhYmxlcyBuZm5ldGxpbmsgc3Vu
cnBjIHNnIHBzZXJpZXNfcm5nIHBhcHJfc2NtIHVpb19wZHJ2X2dlbmlycSB1aW8gc2NoX2ZxX2Nv
ZGVsIGlwX3RhYmxlcyBzZF9tb2QgdDEwX3BpIGlibXZzY3NpIHNjc2lfdHJhbnNwb3J0X3NycCBp
Ym12ZXRoDQo+IENQVTogMTEgUElEOiA3NTE5IENvbW06IGx0LW5kY3RsIE5vdCB0YWludGVkIDUu
Ni4wLXJjNy1hdXRvdGVzdCAjMQ0KPiBOSVA6ICBjMDAwMDAwMDAwYzM0NDdjIExSOiBjMDAwMDAw
MDAwMDg4MzU0IENUUjogYzAwMDAwMDAwMDE4ZTk5MA0KPiBSRUdTOiBjMDAwMDAwNjIyM2ZiNjMw
IFRSQVA6IDAzMDAgICBOb3QgdGFpbnRlZCAgKDUuNi4wLXJjNy1hdXRvdGVzdCkNCj4gTVNSOiAg
ODAwMDAwMDAwMjgwYjAzMyA8U0YsVkVDLFZTWCxFRSxGUCxNRSxJUixEUixSSSxMRT4gIENSOiAy
NDA0ODg4OCAgWEVSOiAwMDAwMDAwMA0KPiBDRkFSOiBjMDAwMDAwMDAwMDBkZWM0IERBUjogMDAw
MDAwMDAwMDAwMDAwMCBEU0lTUjogNDAwMDAwMDAgSVJRTUFTSzogMCANCj4gR1BSMDA6IGMwMDAw
MDAwMDAzYzU4MjAgYzAwMDAwMDYyMjNmYjhjMCBjMDAwMDAwMDAxNjg0OTAwIDAwMDAwMDAwMDQw
MDAwMDAgDQo+IEdQUjA0OiBjMDBjMDAwMTAxMDAwMDAwIDAwMDAwMDAwMDdmZmZmZmYgYzAwMDAw
MDY3ZmYyMDkwMCBjMDBjMDAwMDAwMDAwMDAwIA0KPiBHUFIwODogMDAwMDAwMDAwMDAwMDAwMCBj
MDBjMDAwMTAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgYzAwMDAwMDAwM2YwMDAwMCANCj4gR1BS
MTI6IDAwMDAwMDAwMDAwMDgwMDAgYzAwMDAwMDAxZWM3MDIwMCAwMDAwN2ZmZmMxMDJmOWU4IDAw
MDAwMDAwMTAwMmUwODggDQo+IEdQUjE2OiAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMTAwNTBk
ODggMDAwMDAwMDAxMDAyZjc3OCAwMDAwMDAwMDEwMDJmNzcwIA0KPiBHUFIyMDogMDAwMDAwMDAw
MDAwMDAwMCAwMDAwMDAwMDAwMDAwMTAwIDAwMDAwMDAwMDAwMDAwMDEgMDAwMDAwMDAwMDAwMTAw
MCANCj4gR1BSMjQ6IDAwMDAwMDAwMDAwMDAwMDggMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDA0
MDAwMDAwIGMwMGMwMDAxMDAwMDQwMDAgDQo+IEdQUjI4OiBjMDAwMDAwMDAzMTAxYWEwIGMwMGMw
MDAxMDAwMDAwMDAgMDAwMDAwMDAwMTAwMDAwMCAwMDAwMDAwMDA0MDAwMTAwIA0KPiBOSVAgW2Mw
MDAwMDAwMDBjMzQ0N2NdIHZtZW1tYXBfcG9wdWxhdGVkKzB4OTgvMHhjMA0KPiBMUiBbYzAwMDAw
MDAwMDA4ODM1NF0gdm1lbW1hcF9mcmVlKzB4MTQ0LzB4MzIwDQo+IENhbGwgVHJhY2U6DQo+IFtj
MDAwMDAwNjIyM2ZiOGMwXSBbYzAwMDAwMDYyMjNmYjk2MF0gMHhjMDAwMDAwNjIyM2ZiOTYwICh1
bnJlbGlhYmxlKQ0KPiBbYzAwMDAwMDYyMjNmYjk4MF0gW2MwMDAwMDAwMDAzYzU4MjBdIHNlY3Rp
b25fZGVhY3RpdmF0ZSsweDIyMC8weDI0MA0KPiBbYzAwMDAwMDYyMjNmYmEzMF0gW2MwMDAwMDAw
MDAzZGMxZDhdIF9fcmVtb3ZlX3BhZ2VzKzB4MTE4LzB4MTcwDQo+IFtjMDAwMDAwNjIyM2ZiYTgw
XSBbYzAwMDAwMDAwMDA4NmU1Y10gYXJjaF9yZW1vdmVfbWVtb3J5KzB4M2MvMHgxNTANCj4gW2Mw
MDAwMDA2MjIzZmJiMDBdIFtjMDAwMDAwMDAwNDFhM2JjXSBtZW11bm1hcF9wYWdlcysweDFjYy8w
eDJmMA0KPiBbYzAwMDAwMDYyMjNmYmI4MF0gW2MwMDAwMDAwMDA3ZDZkMDBdIGRldm1fYWN0aW9u
X3JlbGVhc2UrMHgzMC8weDUwDQo+IFtjMDAwMDAwNjIyM2ZiYmEwXSBbYzAwMDAwMDAwMDdkN2Rl
OF0gcmVsZWFzZV9ub2RlcysweDJmOC8weDNlMA0KPiBbYzAwMDAwMDYyMjNmYmM1MF0gW2MwMDAw
MDAwMDA3ZDBiMzhdIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE2OC8weDI3MA0K
PiBbYzAwMDAwMDYyMjNmYmM5MF0gW2MwMDAwMDAwMDA3Y2NmNTBdIHVuYmluZF9zdG9yZSsweDEz
MC8weDE3MA0KPiBbYzAwMDAwMDYyMjNmYmNkMF0gW2MwMDAwMDAwMDA3Y2MwYjRdIGRydl9hdHRy
X3N0b3JlKzB4NDQvMHg2MA0KPiBbYzAwMDAwMDYyMjNmYmNmMF0gW2MwMDAwMDAwMDA1MWZkYjhd
IHN5c2ZzX2tmX3dyaXRlKzB4NjgvMHg4MA0KPiBbYzAwMDAwMDYyMjNmYmQxMF0gW2MwMDAwMDAw
MDA1MWYyMDBdIGtlcm5mc19mb3Bfd3JpdGUrMHgxMDAvMHgyOTANCj4gW2MwMDAwMDA2MjIzZmJk
NjBdIFtjMDAwMDAwMDAwNDIwMzdjXSBfX3Zmc193cml0ZSsweDNjLzB4NzANCj4gW2MwMDAwMDA2
MjIzZmJkODBdIFtjMDAwMDAwMDAwNDI0MDRjXSB2ZnNfd3JpdGUrMHhjYy8weDI0MA0KPiBbYzAw
MDAwMDYyMjNmYmRkMF0gW2MwMDAwMDAwMDA0MjQ0MmNdIGtzeXNfd3JpdGUrMHg3Yy8weDE0MA0K
PiBbYzAwMDAwMDYyMjNmYmUyMF0gW2MwMDAwMDAwMDAwMGIyNzhdIHN5c3RlbV9jYWxsKzB4NWMv
MHg2OA0KPiBJbnN0cnVjdGlvbiBkdW1wOg0KPiAyZWE4MDAwMCA0MTk2MDAzYyA3OTRhMjQyOCA3
ZDY4NTIxNSA0MTgyMDAzMCA3ZDQ4NTAyYSA3MTQ4MDAwMiA0MTgyMDAyNCANCj4gNzE0YTAwMDgg
NDA4MjAwMmMgZTkwYjAwMDggNzg2YWRmNjIgPGU4NjgwMDAwPiA3YzYzNTQzNiA3MDYzMDAwMSA0
YzgyMDAyMCANCj4gLS0tWyBlbmQgdHJhY2UgNTc5YjQ4MTYyZGExYjg5MCBd4oCUDQoNCg0KQ2Fu
IHlvdSB0cnkgdGhpcyBjaGFuZ2U/DQoNCmRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3Nw
YXJzZS5jDQppbmRleCBhYWRiNzI5OGRjZWYuLjMwMTJkMWYzNzcxYSAxMDA2NDQNCi0tLSBhL21t
L3NwYXJzZS5jDQorKysgYi9tbS9zcGFyc2UuYw0KQEAgLTc4MSw2ICs3ODEsOCBAQCBzdGF0aWMg
dm9pZCBzZWN0aW9uX2RlYWN0aXZhdGUodW5zaWduZWQgbG9uZyBwZm4sIHVuc2lnbmVkIGxvbmcg
bnJfcGFnZXMsDQogCQkJbXMtPnVzYWdlID0gTlVMTDsNCiAJCX0NCiAJCW1lbW1hcCA9IHNwYXJz
ZV9kZWNvZGVfbWVtX21hcChtcy0+c2VjdGlvbl9tZW1fbWFwLCBzZWN0aW9uX25yKTsNCisJCS8q
IE1hcmsgdGhlIHNlY3Rpb24gaW52YWxpZCAqLw0KKwkJbXMtPnNlY3Rpb25fbWVtX21hcCAmPSB+
U0VDVElPTl9IQVNfTUVNX01BUDsNCiAJfQ0KIA0KIAlpZiAoc2VjdGlvbl9pc19lYXJseSAmJiBt
ZW1tYXApDQoNCmEgcGZuX3ZhbGlkIGNoZWNrIGludm9sdmVzIHBuZl9zZWN0aW9uX3ZhbGlkKCkg
Y2hlY2sgaWYgc2VjdGlvbiBpcw0KaGF2aW5nIE1FTV9NQVAuIEluIHRoaXMgY2FzZSB3ZSBkaWQg
ZW5kIHVwICBzZXR0aW5nIHRoZSBtcy0+dWFnZSA9IE5VTEwuDQpTbyB3aGVuIHdlIGRvIHRoYXQg
dHVwZGF0ZSB0aGUgc2VjdGlvbiB0byBub3QgaGF2ZSBNRU1fTUFQLg0KDQotYW5lZXNoCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
