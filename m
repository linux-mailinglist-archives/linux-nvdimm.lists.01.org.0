Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8019055B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 06:55:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE8B310FC389E;
	Mon, 23 Mar 2020 22:56:26 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7358510FC389A
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 22:56:24 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O5ajhq021842
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 01:55:33 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr5rm6a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 01:55:33 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <sachinp@linux.vnet.ibm.com>;
	Tue, 24 Mar 2020 05:55:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 24 Mar 2020 05:55:27 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O5tQ0D39059534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 05:55:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB800A4054;
	Tue, 24 Mar 2020 05:55:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D39F0A405B;
	Tue, 24 Mar 2020 05:55:25 +0000 (GMT)
Received: from [9.199.50.248] (unknown [9.199.50.248])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2020 05:55:25 +0000 (GMT)
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [5.6.0-rc7] Kernel crash while running ndctl tests
Date: Tue, 24 Mar 2020 11:25:24 +0530
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032405-0028-0000-0000-000003EA5D76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032405-0029-0000-0000-000024AFC5E6
Message-Id: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_10:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxlogscore=945 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240027
Message-ID-Hash: W4ZKBAT2RZNUBSL4D6USLUC3HXI7UDDZ
X-Message-ID-Hash: W4ZKBAT2RZNUBSL4D6USLUC3HXI7UDDZ
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W4ZKBAT2RZNUBSL4D6USLUC3HXI7UDDZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V2hpbGUgcnVubmluZyBuZGN0bFsxXSB0ZXN0cyBhZ2FpbnN0IDUuNi4wLXJjNyBmb2xsb3dpbmcg
Y3Jhc2ggaXMgZW5jb3VudGVyZWQuDQoNCkJpc2VjdCBsZWFkcyBtZSB0byAgY29tbWl0IGQ0MWUy
ZjNiZDU0NiANCm1tL2hvdHBsdWc6IGZpeCBob3QgcmVtb3ZlIGZhaWx1cmUgaW4gU1BBUlNFTUVN
fCFWTUVNTUFQIGNhc2UNCg0KUmV2ZXJ0aW5nIHRoaXMgY29tbWl0IGhlbHBzIGFuZCB0aGUgdGVz
dHMgY29tcGxldGUgd2l0aG91dCBhbnkgY3Jhc2guDQoNCnBtZW0wOiBkZXRlY3RlZCBjYXBhY2l0
eSBjaGFuZ2UgZnJvbSAwIHRvIDEwNzIwNjQxMDI0DQpCVUc6IEtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2Ugb24gcmVhZCBhdCAweDAwMDAwMDAwDQpGYXVsdGluZyBpbnN0cnVjdGlvbiBh
ZGRyZXNzOiAweGMwMDAwMDAwMDBjMzQ0N2MNCk9vcHM6IEtlcm5lbCBhY2Nlc3Mgb2YgYmFkIGFy
ZWEsIHNpZzogMTEgWyMxXQ0KTEUgUEFHRV9TSVpFPTY0SyBNTVU9SGFzaCBTTVAgTlJfQ1BVUz0y
MDQ4IE5VTUEgcFNlcmllcw0KRHVtcGluZyBmdHJhY2UgYnVmZmVyOg0KICAgKGZ0cmFjZSBidWZm
ZXIgZW1wdHkpDQpNb2R1bGVzIGxpbmtlZCBpbjogZG1fbW9kIG5mX2Nvbm50cmFjayBuZl9kZWZy
YWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBsaWJjcmMzMmMgaXA2X3RhYmxlcyBuZnRfY29tcGF0IGlw
X3NldCByZmtpbGwgbmZfdGFibGVzIG5mbmV0bGluayBzdW5ycGMgc2cgcHNlcmllc19ybmcgcGFw
cl9zY20gdWlvX3BkcnZfZ2VuaXJxIHVpbyBzY2hfZnFfY29kZWwgaXBfdGFibGVzIHNkX21vZCB0
MTBfcGkgaWJtdnNjc2kgc2NzaV90cmFuc3BvcnRfc3JwIGlibXZldGgNCkNQVTogMTEgUElEOiA3
NTE5IENvbW06IGx0LW5kY3RsIE5vdCB0YWludGVkIDUuNi4wLXJjNy1hdXRvdGVzdCAjMQ0KTklQ
OiAgYzAwMDAwMDAwMGMzNDQ3YyBMUjogYzAwMDAwMDAwMDA4ODM1NCBDVFI6IGMwMDAwMDAwMDAx
OGU5OTANClJFR1M6IGMwMDAwMDA2MjIzZmI2MzAgVFJBUDogMDMwMCAgIE5vdCB0YWludGVkICAo
NS42LjAtcmM3LWF1dG90ZXN0KQ0KTVNSOiAgODAwMDAwMDAwMjgwYjAzMyA8U0YsVkVDLFZTWCxF
RSxGUCxNRSxJUixEUixSSSxMRT4gIENSOiAyNDA0ODg4OCAgWEVSOiAwMDAwMDAwMA0KQ0ZBUjog
YzAwMDAwMDAwMDAwZGVjNCBEQVI6IDAwMDAwMDAwMDAwMDAwMDAgRFNJU1I6IDQwMDAwMDAwIElS
UU1BU0s6IDAgDQpHUFIwMDogYzAwMDAwMDAwMDNjNTgyMCBjMDAwMDAwNjIyM2ZiOGMwIGMwMDAw
MDAwMDE2ODQ5MDAgMDAwMDAwMDAwNDAwMDAwMCANCkdQUjA0OiBjMDBjMDAwMTAxMDAwMDAwIDAw
MDAwMDAwMDdmZmZmZmYgYzAwMDAwMDY3ZmYyMDkwMCBjMDBjMDAwMDAwMDAwMDAwIA0KR1BSMDg6
IDAwMDAwMDAwMDAwMDAwMDAgYzAwYzAwMDEwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIGMwMDAw
MDAwMDNmMDAwMDAgDQpHUFIxMjogMDAwMDAwMDAwMDAwODAwMCBjMDAwMDAwMDFlYzcwMjAwIDAw
MDA3ZmZmYzEwMmY5ZTggMDAwMDAwMDAxMDAyZTA4OCANCkdQUjE2OiAwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDAwMTAwNTBkODggMDAwMDAwMDAxMDAyZjc3OCAwMDAwMDAwMDEwMDJmNzcwIA0KR1BS
MjA6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDEwMCAwMDAwMDAwMDAwMDAwMDAxIDAw
MDAwMDAwMDAwMDEwMDAgDQpHUFIyNDogMDAwMDAwMDAwMDAwMDAwOCAwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDAwMDQwMDAwMDAgYzAwYzAwMDEwMDAwNDAwMCANCkdQUjI4OiBjMDAwMDAwMDAzMTAx
YWEwIGMwMGMwMDAxMDAwMDAwMDAgMDAwMDAwMDAwMTAwMDAwMCAwMDAwMDAwMDA0MDAwMTAwIA0K
TklQIFtjMDAwMDAwMDAwYzM0NDdjXSB2bWVtbWFwX3BvcHVsYXRlZCsweDk4LzB4YzANCkxSIFtj
MDAwMDAwMDAwMDg4MzU0XSB2bWVtbWFwX2ZyZWUrMHgxNDQvMHgzMjANCkNhbGwgVHJhY2U6DQpb
YzAwMDAwMDYyMjNmYjhjMF0gW2MwMDAwMDA2MjIzZmI5NjBdIDB4YzAwMDAwMDYyMjNmYjk2MCAo
dW5yZWxpYWJsZSkNCltjMDAwMDAwNjIyM2ZiOTgwXSBbYzAwMDAwMDAwMDNjNTgyMF0gc2VjdGlv
bl9kZWFjdGl2YXRlKzB4MjIwLzB4MjQwDQpbYzAwMDAwMDYyMjNmYmEzMF0gW2MwMDAwMDAwMDAz
ZGMxZDhdIF9fcmVtb3ZlX3BhZ2VzKzB4MTE4LzB4MTcwDQpbYzAwMDAwMDYyMjNmYmE4MF0gW2Mw
MDAwMDAwMDAwODZlNWNdIGFyY2hfcmVtb3ZlX21lbW9yeSsweDNjLzB4MTUwDQpbYzAwMDAwMDYy
MjNmYmIwMF0gW2MwMDAwMDAwMDA0MWEzYmNdIG1lbXVubWFwX3BhZ2VzKzB4MWNjLzB4MmYwDQpb
YzAwMDAwMDYyMjNmYmI4MF0gW2MwMDAwMDAwMDA3ZDZkMDBdIGRldm1fYWN0aW9uX3JlbGVhc2Ur
MHgzMC8weDUwDQpbYzAwMDAwMDYyMjNmYmJhMF0gW2MwMDAwMDAwMDA3ZDdkZThdIHJlbGVhc2Vf
bm9kZXMrMHgyZjgvMHgzZTANCltjMDAwMDAwNjIyM2ZiYzUwXSBbYzAwMDAwMDAwMDdkMGIzOF0g
ZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4MTY4LzB4MjcwDQpbYzAwMDAwMDYyMjNm
YmM5MF0gW2MwMDAwMDAwMDA3Y2NmNTBdIHVuYmluZF9zdG9yZSsweDEzMC8weDE3MA0KW2MwMDAw
MDA2MjIzZmJjZDBdIFtjMDAwMDAwMDAwN2NjMGI0XSBkcnZfYXR0cl9zdG9yZSsweDQ0LzB4NjAN
CltjMDAwMDAwNjIyM2ZiY2YwXSBbYzAwMDAwMDAwMDUxZmRiOF0gc3lzZnNfa2Zfd3JpdGUrMHg2
OC8weDgwDQpbYzAwMDAwMDYyMjNmYmQxMF0gW2MwMDAwMDAwMDA1MWYyMDBdIGtlcm5mc19mb3Bf
d3JpdGUrMHgxMDAvMHgyOTANCltjMDAwMDAwNjIyM2ZiZDYwXSBbYzAwMDAwMDAwMDQyMDM3Y10g
X192ZnNfd3JpdGUrMHgzYy8weDcwDQpbYzAwMDAwMDYyMjNmYmQ4MF0gW2MwMDAwMDAwMDA0MjQw
NGNdIHZmc193cml0ZSsweGNjLzB4MjQwDQpbYzAwMDAwMDYyMjNmYmRkMF0gW2MwMDAwMDAwMDA0
MjQ0MmNdIGtzeXNfd3JpdGUrMHg3Yy8weDE0MA0KW2MwMDAwMDA2MjIzZmJlMjBdIFtjMDAwMDAw
MDAwMDBiMjc4XSBzeXN0ZW1fY2FsbCsweDVjLzB4NjgNCkluc3RydWN0aW9uIGR1bXA6DQoyZWE4
MDAwMCA0MTk2MDAzYyA3OTRhMjQyOCA3ZDY4NTIxNSA0MTgyMDAzMCA3ZDQ4NTAyYSA3MTQ4MDAw
MiA0MTgyMDAyNCANCjcxNGEwMDA4IDQwODIwMDJjIGU5MGIwMDA4IDc4NmFkZjYyIDxlODY4MDAw
MD4gN2M2MzU0MzYgNzA2MzAwMDEgNGM4MjAwMjAgDQotLS1bIGVuZCB0cmFjZSA1NzliNDgxNjJk
YTFiODkwIF3igJQNCg0KVGhhbmtzDQotU2FjaGluDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20v
YXZvY2Fkby1mcmFtZXdvcmstdGVzdHMvYXZvY2Fkby1taXNjLXRlc3RzL2Jsb2IvbWFzdGVyL21l
bW9yeS9uZGN0bC5weQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlz
dHMuMDEub3JnCg==
