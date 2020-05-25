Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 357751E097D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 25 May 2020 11:01:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97078121A5898;
	Mon, 25 May 2020 01:57:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E832121A5896
	for <linux-nvdimm@lists.01.org>; Mon, 25 May 2020 01:57:04 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04P8VdMq096901;
	Mon, 25 May 2020 05:00:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 316y4t7vvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2020 05:00:58 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04P8VedC096969;
	Mon, 25 May 2020 05:00:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 316y4t7vuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2020 05:00:57 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04P8tMNQ002678;
	Mon, 25 May 2020 09:00:55 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf8urp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2020 09:00:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04P8xdbM64029124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2020 08:59:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1698AE057;
	Mon, 25 May 2020 09:00:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E2BAAE04D;
	Mon, 25 May 2020 09:00:49 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.54.11])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 25 May 2020 09:00:48 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 25 May 2020 14:30:47 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: Feedback requested: Exposing NVDIMM performance statistics in a generic way
Date: Mon, 25 May 2020 14:30:47 +0530
Message-ID: <87d06swfr4.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_02:2020-05-22,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005250063
Message-ID-Hash: AERBIEELE44K7GPLLKUSWE2MMGTO3TG2
X-Message-ID-Hash: AERBIEELE44K7GPLLKUSWE2MMGTO3TG2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@d-silva.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AERBIEELE44K7GPLLKUSWE2MMGTO3TG2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgYW0gbG9va2luZyBmb3Igc29tZSBjb21tdW5pdHkgZmVlZGJhY2sgb24gdGhl
c2UgdHdvIFByb2JsZW0tc3RhdGVtZW50czoNCg0KMS5Ib3cgdG8gZXhwb3NlIE5WRElNTSBwZXJm
b3JtYW5jZSBzdGF0aXN0aWNzIGluIGFuIGFyY2ggb3IgbnZkaW1tIHZlbmRvcg0KYWdub3N0aWMg
bWFubmVyID8NCg0KMi4gSXMgdGhlcmUgYSBjb21tb24gc2V0IG9mIHBlcmZvcm1hbmNlIHN0YXRp
c3RpY3MgZm9yIE5WRElNTXMgdGhhdCBhbGwNCnZlbmRvcnMgc2hvdWxkIHByb3ZpZGUgPw0KDQpQ
cm9ibGVtIGNvbnRleHQNCj09PT09PT09PT09PT09PQ0KV2hpbGUgd29ya2luZyBvbiBicmluZyB1
cCBvZiBQQVBSIFNDTSBiYXNlZCBOVkRJTU1zWzFdIGZvciBhcmNoL3Bvd2VycGMNCndlIHdhbnQg
dG8gZXhwb3NlIGNlcnRhaW4gZGltbSBwZXJmb3JtYW5jZSBzdGF0aXN0aWNzIGxpa2UgIk1lZGlh
DQpSZWFkL1dyaXRlIENvdW50cyIsICJQb3dlci1vbiBTZWNvbmRzIiBldGMgdG8gdXNlci1zcGFj
ZSBbMl0uIFRoZXNlDQpwZXJmb3JtYW5jZSBzdGF0aXN0aWNzIGFyZSBzaW1pbGFyIHRvIHdoYXQg
aXBtY3RsWzNdIHJlcG9ydHMgZm9yIEludGVswq4NCk9wdGFuZeKEoiBwZXJzaXN0ZW50IG1lbW9y
eSB2aWEgdGhlICctc2hvdyBwZXJmb3JtYW5jZScgY29tbWFuZCBsaW5lDQphcmcuIEhvd2V2ZXIg
dGhlIHJlcG9ydGVkIHNldCBvZiBwZXJmb3JtYW5jZSBzdGF0cyBkb2Vzbid0IGNvdmVyIHRoZQ0K
ZW50aXJldHkgb2YgYWxsIHBlcmZvcm1hbmNlIHN0YXRzIHN1cHBvcnRlZCBieSBQQVBSIFNDTSBi
YXNlZCBOVkRpbW1zLg0KDQpGb3IgZXhhbXBsZSBoZXJlIGlzIGEgc3Vic2V0IG9mIHBlcmZvcm1h
bmNlIHN0YXRzIHdoaWNoIGFyZSBzcGVjaWZpYyB0bw0KUEFQUiBTQ00gTlZEaW1tcyBhbmQgdGhh
dCBub3QgcmVwb3J0ZWQgYnkgaXBtY3RsOg0KDQoqIENvbnRyb2xsZXIgUmVzZXQgQ291bnQNCiog
Q29udHJvbGxlciBSZXNldCBFbGFwc2VkIFRpbWUNCiogUG93ZXItb24gU2Vjb25kcw0KKiBDYWNo
ZSBSZWFkIEhpdCBDb3VudA0KKiBDYWNoZSBXcml0ZSBIaXQgQ291bnQNCg0KUG9zc2liaWxpdHkg
b2YgdXBkYXRpbmcgaXBtY3RsIHRvIGFkZCBzdXBwb3J0IGZvciB0aGVzZSBwZXJmb3JtYW5jZQ0K
c3RhdGlzdGljcyBpcyBncmVhdGx5IGhhbXBlcmVkIGJ5IG5vIHN1cHBvcnQgZm9yIEFDUEkgb24g
UG93ZXJwYw0KYXJjaC4gU2Vjb25kbHkgdmVuZG9ycyB3aG8gZG9udCBzdXBwb3J0IEFDUEkvTkZJ
VCBjb21tYW5kIHNldA0Kc2ltaWxhciB0byBJbnRlbMKuIE9wdGFuZeKEoiAoRXhhbXBsZSBNU0ZU
KSBhcmUgYWxzbyBsZWZ0IG91dCBpbg0KbHVyY2guIFByb2JsZW0tc3RhdGVtZW50IzEgcG9pbnRz
IHRvIHRoaXMgc3BlY2lmaWMgcHJvYmxlbS4NCg0KQWRkaXRpb25hbGx5IGluIGFic2VuY2Ugb2Yg
YW55IHByZS1hZ3JlZWQgc2V0IG9mIHBlcmZvcm1hbmNlIHN0YXRpc3RpY3MNCndoaWNoIGFsbCB2
ZW5kb3JzIHNob3VsZCBzdXBwb3J0LCBhZGRpbmcgc3VwcG9ydCBmb3Igc3VjaCBhDQpmdW5jdGlv
bmFsaXR5IGluIGlwbWN0bCBtYXkgbm90IGJvZGUgd2VsbCBvZiBvdGhlciBudmRpbW0gdmVuZG9y
cy4gRm9yDQpleGFtcGxlIGlmIHN1cHBvcnQgZm9yIHJlcG9ydGluZyAiQ29udHJvbGxlciBSZXNl
dCBDb3VudCIgaXMgYWRkZWQgdG8NCmlwbWN0bCB0aGVuIGl0IG1heSBub3QgYmUgYXBwbGljYWJs
ZSB0byBvdGhlciB2ZW5kb3JzIHN1Y2ggYXMgSW50ZWzCrg0KT3B0YW5l4oSiLiBUaGlzIGlzc3Vl
IGlzIHdoYXQgUHJvYmxlbS1zdGF0ZW1lbnQjMiByZWZlcnMgdG8uDQoNClBvc3NpYmxlIFNvbHV0
aW9uIGZvciBQcm9ibGVtIzENCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KT25l
IHBvc3NpYmxlIHNvbHV0aW9uIHRvIFByb2JsZW0jMSBjYW4gdG8gYWRkIHN1cHBvcnQgZm9yIHJl
cG9ydGluZw0KTlZESU1NIHBlcmZvcm1hbmNlIHN0YXRpc3RpY3MgaW4gJ25kdGNsJy4gJ2xpYm5k
Y3RsJyBhbHJlYWR5IGhhcyBhIGxheWVyDQp0aGF0IGFic3RyYWN0cyB1bmRlcmx5aW5nIE5WRElN
TSB2ZW5kb3JzICh2aWEgc3RydWN0IG5kY3RsX2RpbW1fb3BzKSwNCm1ha2luZyBzdXBwb3J0aW5n
IGRpZmZlcmVudCBOVkRJTU0gdmVuZG9ycyBmYWlybHkgZWFzeS4gQWxzbyBuZGN0bCBpcw0KbW9y
ZSB3aWRlbHkgdXNlZCBjb21wYXJlZCB0byAnaXBtY3RsJywgaGVuY2UgYWRkaW5nIHN1Y2ggYSBm
dW5jdGlvbmFsaXR5DQp0byBuZGN0bCB3b3VsZCBtYWtlIGl0IG1vcmUgd2lkZWx5IHVzZWQuDQoN
CkFib3ZlIHNvbHV0aW9uIHdhcyBpbXBsZW1lbnRlZCBhcyBSRkMgcGF0Y2gtc2V0WzJdIHRoYXQg
ZXhwb3NlcyB0aGVzZQ0KcGVyZm9ybWFuY2Ugc3RhdGlzdGljcyB0aHJvdWdoIGEgZ2VuZXJpYyBh
YnN0cmFjdGlvbiBpbiBsaWJuZGN0bCBhbmQNCmFkZGVkIGEgcHJlc2VudGF0aW9uIGxheWVyIGZv
ciB0aGlzIGRhdGEgaW4gbmRjdGxbNF0uIEl0IGFkZGVkIGEgbmV3DQpjb21tYW5kIGxpbmUgZmxh
Z3MgJy0tc3RhdCcgdG8gbmRjdGwgdG8gcmVwb3J0ICphbGwqIG52ZGltbSB2ZW5kb3INCnJlcG9y
dGVkIHBlcmZvcm1hbmNlIHN0YXRzLiBUaGUgb3V0cHV0IGlzIHNpbWlsYXIgdG8gb25lIGJlbG93
Og0KDQojIG5kY3RsIGxpc3QgLUQgLS1zdGF0cw0KWw0KICB7DQogICAgImRldiI6Im5tZW0wIiwN
CiAgICAic3RhdHMiOnsNCiAgICAgICJQb3dlci1vbiBTZWNvbmRzIjo2MDM5MzEsDQogICAgICAi
TWVkaWEgUmVhZCBDb3VudCI6MCwNCiAgICAgICJNZWRpYSBXcml0ZSBDb3VudCI6NjMxMywNCiAg
ICB9DQogIH0NCl0NCg0KVGhpcyB3YXMgZG9uZSBieSBhZGRpbmcgdHdvIG5ldyBkaW1tLW9wcyBj
YWxsYmFja3MgdGhhdCB3ZXJlDQppbXBsZW1lbnRlZCBieSB0aGUgcGFwcl9zY20gaW1wbGVtZW50
YXRpb24gd2l0aGluIGxpYm5kY3RsLiBUaGVzZQ0KY2FsbGJhY2tzIGFyZSBpbnZva2VkIGJ5IG5l
d2x5IGludHJvZHVjZSBjb2RlIGluICd1dGlsL2pzb24tc21hcnQuYycNCnRoYXQgZm9ybWF0IHRo
ZSByZXR1cm5lZCBzdGF0cyBmcm9tIHRoZXNlIG5ldyBkaW1tLW9wcyBhbmQgdHJhbnNmb3JtDQp0
aGVtIGludG8gYSBqc29uLW9iamVjdCB0byBsYXRlciBwcmVzZW50YXRpb24uIEkgd291bGQgcmVx
dWVzdCB5b3UgdG8NCmxvb2sgYXQgUkZDIHBhdGNoLXNldFsyXSB0byB1bmRlcnN0YW5kIHRoZSBp
bXBsZW1lbnRhdGlvbiBkZXRhaWxzLg0KDQpQb3NzaWJsZWQgU29sdXRpb24gZm9yIFByb2JsZW0j
Mg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg0KU29sdXRpb24gdG8gUHJvYmxl
bS1zdGF0ZW1lbnQjMiBpcyB3aGF0IGVsdWRlcyBtZSB0aG91Z2guIElmIHRoZXJlIGlzIGENCm1p
bmltYWwgc2V0IG9mIHBlcmZvcm1hbmNlIHN0YXRzIChzaW1pbGFyIHRvIHdoYXQgbmRjdGwgZW5m
b3JjZXMgZm9yDQpoZWFsdGgtc3RhdHMpIHRoZW4gaW1wbGVtZW50YXRpb24gb2Ygc3VjaCBhIGZ1
bmN0aW9uYWxpdHkgaW4NCm5kY3RsL2lwbWN0bCB3b3VsZCBiZSBlYXN5IHRvIGltcGxlbWVudC4g
QnV0IGlzIGl0IHJlYWxseSBwb3NzaWJsZSB0bw0KaGF2ZSBzdWNoIGEgY29tbW9uIHNldCBvZiBw
ZXJmb3JtYW5jZSBzdGF0cyB0aGF0IE5WRElNTSB2ZW5kb3JzIGNhbg0KZXhwb3NlLg0KDQpQYXRj
aC1zZXRbMl0gdGhvdWdoIHRyaWVzIHRvIGJ5cGFzcyB0aGlzIHByb2JsZW0gYnkgbGV0dGluZyB0
aGUgdmVuZG9yDQpkZXNjaWRlIHdoaWNoIHBlcmZvcm1hbmNlIHN0YXRzIHRvIGV4cG9zZS4gVGhp
cyBvcGVucyB1cCBhIHBvc3NpYmlsaXR5DQpvZiB0aGlzIGZ1bmN0aW9uYWxpdHkgdG8gYWJ1c2Vk
IGJ5IGRpbW0gdmVuZG9ycyB0byByZXBvcnRzIGFyYmlyYXJ5IGRhdGENCnRocm91Z2ggdGhpcyBm
bGFnIHRoYXQgbWF5IG5vdCBiZSBwZXJmb3JtYW5jZS1zdGF0cy4NCg0KU3VtbWluZy11cA0KPT09
PT09PT09PQ0KDQpJbiBsaWdodCBvZiBhYm92ZSwgcmVxdWVzdGluZyB5b3VyIGZlZWRiYWNrIGFz
IHRvIGhvdw0KcHJvYmxlbS1zdGF0ZW1lbnRzI3sxLCAyfSBjYW4gYmUgYWRkcmVzc2VkIHdpdGhp
biBuZGN0bCBzdWJzeXN0ZW0uIEFsc28NCmFyZSB0aGVzZSBwcm9ibGVtcyBldmVuIHdvcnRoIHNv
bHZpbmcuDQoNClJlZmVyZW5jZXMNCj09PT09PT09PT0NClsxXSBodHRwczovL2dpdGh1Yi5jb20v
dG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9wb3dlcnBjL3BhcHJfaGNh
bGxzLnJzdA0KDQpbMl0gIltuZGN0bCBSRkMtUEFUQ0ggMC80XSBBZGQgc3VwcG9ydCBmb3IgcmVw
b3J0aW5nIFBBUFIgTlZESU1NDQpTdGF0aXN0aWNzIg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbnZkaW1tLzIwMjAwNTE4MTEwODE0LjE0NTY0NC0xLXZhaWJoYXZAbGludXguaWJtLmNv
bS8NCg0KWzNdIGh0dHBzOi8vZG9jcy5wbWVtLmlvL2lwbWN0bC11c2VyLWd1aWRlL2luc3RydW1l
bnRhdGlvbi9zaG93LWRldmljZS1wZXJmb3JtYW5jZQ0KDQpbNF0gIltSRkMtUEFUQ0ggMS80XSBu
ZGN0bCxsaWJuZGN0bDogSW1wbGVtZW50IG5ldyBkaW1tLW9wcyAnbmV3X3N0YXRzJw0KYW5kICdn
ZXRfc3RhdCciDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udmRpbW0vMjAyMDA1MTQy
MjUyNTguNTA4NDYzLTItdmFpYmhhdkBsaW51eC5pYm0uY29tDQoNClRoYW5rcywNCn4gVmFpYmhh
dg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
