Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDA2C007D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Nov 2020 08:21:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2F22100EC1C7;
	Sun, 22 Nov 2020 23:21:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B5D6100EC1C6
	for <linux-nvdimm@lists.01.org>; Sun, 22 Nov 2020 23:21:44 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AN747Fe061284;
	Mon, 23 Nov 2020 02:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=iwQ+Pdy7E4CWNLoPiFkc31rAtVYVOThkt1k/ajJpLJA=;
 b=W7CUOpxx1jWuEvnmREmc2RAL3WB2CYTp07502XP3SDrVx/eZVXYdmOGBmlQR9Cc7O7vQ
 VHrR2iILZQtTYJbxIEnceXbSlgpojjroJn4ow64o42jMNTd/JiDmVgD0F7w+LnsfVsN8
 MunVpWaa2k35tu5/sePHURqM0HUn+L1LkFr4pUKqFBSdrUa0R4nSOEO1jy3jvdiwpbZr
 2QhIAMJH/eZIEKrkYiniTtK3iHEXGgzUJ17J00RYun3gm/0+tGXZhMDY5/18CMax8d8T
 3Lk4YgU3qzq9Q/o2pCWjvu9pJ/yu4JIN7k1rNTKREoQjNwTtgFtLM6zGiMTD8D94DssK Qg==
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34yvnrd1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2020 02:21:41 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AN7IYFB014591;
	Mon, 23 Nov 2020 07:21:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 34xt5ha7ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2020 07:21:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AN7LbLr30409210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2020 07:21:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EFB6A4054;
	Mon, 23 Nov 2020 07:21:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF9CA405F;
	Mon, 23 Nov 2020 07:21:34 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.107.136])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Mon, 23 Nov 2020 07:21:34 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 23 Nov 2020 12:51:33 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Michal =?utf-8?Q?Such=C3=A1ne?=
 =?utf-8?Q?k?=
 <msuchanek@suse.de>
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a
 generic way
In-Reply-To: <CAPcyv4hTYQ8upuDd0RqUzBtSqjBr4rJz0eaceUmr4b=XeXqs-A@mail.gmail.com>
References: <87r1v3lwcn.fsf@linux.ibm.com>
 <20201023192829.3ee3c1a7@naga.suse.cz>
 <CAPcyv4hTYQ8upuDd0RqUzBtSqjBr4rJz0eaceUmr4b=XeXqs-A@mail.gmail.com>
Date: Mon, 23 Nov 2020 12:51:33 +0530
Message-ID: <87k0ucfshu.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230048
Message-ID-Hash: HSMMB5IVLL6GC2J33ZN25ZCXDF2Z42KB
X-Message-ID-Hash: HSMMB5IVLL6GC2J33ZN25ZCXDF2Z42KB
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@d-silva.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HSMMB5IVLL6GC2J33ZN25ZCXDF2Z42KB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRGFuIGFuZCBNaWNoYWwsDQoNCkkgaGF2ZSBwb3N0ZWQgYW4gUkZDIHBhdGNoIHRvIGltcGxt
ZW50IHRoZSBrZXJuZWwgc2lkZSBpbnRlcmZhY2UgZm9yDQp0aGlzIGluIGxpYm52ZGltbSB3aXRo
IGFuIGltcGxlbWVudGF0aW9uIGluIHBhcHItc2NtIGRyaXZlciBtb2R1bGUgYXQgWzFdLiBDYW4N
CnlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIHBhdGNoIHNlcmllZCBhbmQgcHJvdmlkZSB5
b3VyIGlucHV0cy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52ZGltbS8y
MDIwMTEwODIxMTU0OS4xMjIwMTgtMS12YWliaGF2QGxpbnV4LmlibS5jb20vDQoNClRoYW5rcywN
Cn4gVmFpYmhhdg0KDQpEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4gd3Jp
dGVzOg0KDQo+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDEwOjI4IEFNIE1pY2hhbCBTdWNow6Fu
ZWsgPG1zdWNoYW5la0BzdXNlLmRlPiB3cm90ZToNCj4+DQo+PiBIZWxsbywNCj4+DQo+PiBPbiBU
aHUsIE1heSAyOCwgMjAyMCBhdCAxMTo1OSBBTSBWYWliaGF2IEphaW4gPHZhaWJoYXZAbGludXgu
aWJtLmNvbT4gd3JvdGU6DQo+PiA+DQo+PiA+IFRoYW5rcyBmb3IgdGhpcyB0YWtpbmcgdGltZSB0
byBsb29rIGludG8gdGhpcyBEYW4sDQo+PiA+DQo+PiA+IEFncmVlIHdpdGggdGhlIHBvaW50cyB5
b3UgaGF2ZSBtYWRlIGVhcmxpZXIgdGhhdCBJIGFtIHN1bW1hcml6aW5nIGJlbG93Og0KPj4gPg0K
Pj4gPiAqIFRoaXMgaXMgYmV0dGVyIGRvbmUgaW4gbmRjdGwgcmF0aGVyIHRoYW4gaXBtY3RsLg0K
Pj4gPiAqIFNob3VsZCBvbmx5IGV4cG9zZSBnZW5lcmFsIHBlcmZvcm1hbmNlIG1ldHJpY3MgYW5k
IG5vdCBwZXJmb3JtYW5jZQ0KPj4gPiAgIGNvdW50ZXJzLiBQZXJmb3JtYW5jZSBjb3VudGVyIHNo
b3VsZCBiZSBleHBvc2VkIHZpYSBwZXJmDQo+PiA+ICogVmVuZG9yIHNwZWNpZmljIG1ldHJpY3Mg
dG8gYmUgc2VwYXJhdGVkIGZyb20gZ2VuZXJpYyBwZXJmb3JtYW5jZQ0KPj4gPiAgIG1ldHJpY3Mu
DQo+PiA+DQo+PiA+IE9uZSB3YXkgdG8gc3BsaXQgZ2VuZXJpYyBhbmQgdmVuZG9yIHNwZWNpZmlj
IG1ldHJpY3MgbWlnaHQgYmUgdG8gcmVwb3J0DQo+PiA+IGdlbmVyaWMgcGVyZm9ybWFuY2UgbWV0
cmljcyB0b2dldGhlciB3aXRoIGRpbW0gaGVhbHRoIG1ldHJpY3Mgc3VjaCBhcw0KPj4gPiAidGVt
cHJhdHVyZV9jZWxzaXVzIiBvciAic3BhcmVzX3BlcmNlbnRhZ2UiIHRoYXQgYXJlIGFscmVhZHkg
cmVwb3J0ZWQgaW4NCj4+ID4gYnkgZGltbSBoZWFsdGggb3V0cHV0Lg0KPj4gPg0KPj4gPiBWZW5k
b3Igc3BlY2lmaWMgcGVyZm9ybWFuY2UgbWV0cmljcyBjYW4gYmUgcmVwb3J0ZWQgYXMgYSBzZXBl
cmF0ZSBvYmplY3QNCj4+ID4gaW4gdGhlIGpzb24gb3V0cHV0LiBTb21ldGhpbmcgc2ltaWxhciB0
byBvdXRwdXQgYmVsb3c6DQo+PiA+DQo+PiA+ICMgbmRjdGwgbGlzdCAtREggLS1zdGF0cyAtLXZl
bmRvci1zdGF0cw0KPj4gPiBbDQo+PiA+ICAgew0KPj4gPiAgICAgImRldiI6Im5tZW0wIiwNCj4+
ID4gICAgICJoZWFsdGgiOnsNCj4+ID4gICAgICAgImhlYWx0aF9zdGF0ZSI6Im9rIiwNCj4+ID4g
ICAgICAgInNodXRkb3duX3N0YXRlIjoiY2xlYW4iLA0KPj4gPiAgICAgICAidGVtcGVyYXR1cmVf
Y2Vsc2l1cyI6NDguMDAsDQo+PiA+ICAgICAgICJzcGFyZXNfcGVyY2VudGFnZSI6MTAsDQo+PiA+
DQo+PiA+ICAgICAgIC8qIEdlbmVyaWMgcGVyZm9ybWFuY2UgbWV0cmljcy9zdGF0cyAqLw0KPj4g
PiAgICAgICAiVG90YWxNZWRpYVJlYWRzIjogMTg5MjksDQo+PiA+ICAgICAgICJUb3RhbE1lZGlh
V3JpdGVzIjogMCwNCj4+ID4gICAgICAgLi4uLg0KPj4gPiAgICAgfQ0KPj4gPg0KPj4gPiAgICAg
LyogVmVuZG9yIHNwZWNpZmljIHN0YXRzIGZvciB0aGUgZGltbSAqLw0KPj4gPiAgICAgInZlbmRv
ci1zdGF0cyI6IHsNCj4+ID4gICAgICJDb250cm9sbGVyIFJlc2V0IENvdW50IjoxMA0KPj4gPiAg
ICAgIkNvbnRyb2xsZXIgUmVzZXQgRWxhcHNlZCBUaW1lIjogMzYwMA0KPj4gPiAgICAgIlBvd2Vy
LW9uIFNlY29uZHMiOiAzNjAwDQo+Pg0KPj4gSG93IGRvIHlvdSB0ZWxsIGdlbmVyaWMgZnJvbSB2
ZW5kb3Itc3BlY2lmaWMgc3RhdHMsIHRob3VnaD8NCj4+DQo+PiBDb250cm9sbGVyIHJlc2V0IGNv
dW50IGFuZCBwb3dlci1vbiB0aW1lIG1heSBub3QgYmUgcmVwb3J0ZWQgYnkgc29tZQ0KPj4gY29u
dHJvbGxlcnMgYnV0IHNvdW5kIHByZXR0eSBnZW5lcmljLg0KPj4NCj4+IEV2ZW4gaWYgeW91IGRl
Y2xhcmUgdGhhdCB0aGUgc3RhdHMgcmVwb3J0ZWQgYnkgYWxsIGNvbnRyb2xsZXJzDQo+PiBhdmFp
bGFibGUgYXQgdGhpcyBtb21lbnQgYXJlIGdlbmVyaWMgYSBsYXRlciBvbmUgbWF5IG5vdCByZXBv
cnQgc29tZSBvZg0KPj4gdGhlc2UgJ2dlbmVyaWMnIHN0YXRpc3RpY3MsIG9yIHJlcG9ydCB0aGVt
IGluIGRpZmZlcmVudCB3YXkvdW5pdHMsIG9yDQo+PiBtYXkgc2ltcGx5IG5vdCByZXBvcnQgYW55
dGhpbmcgYXQgYWxsIGZvciBzb21lIHRlY2huaWNhbCByZWFzb24uDQo+Pg0KPj4gS2VybmVscyB0
aGF0IGRvIG5vdCBoYXZlIHRoaXMgZmVhdHVyZSB3aWxsIG5vdCByZXBvcnQgYW55dGhpbmcgYXQg
YWxsDQo+PiBlaXRoZXIuDQo+DQo+IE15IGV4cGVjdGF0aW9uIGlzIHRoYXQgZm9yIGEgZ2l2ZW4g
anNvbiBhdHRyaWJ1dGUgbmFtZSBhbnkgdmVuZG9yDQo+IGJhY2tlbmQgdGhhdCBzdXBwb3J0cyBp
dCBtdXN0IGNvbnZleSBpdCBpbiBhIGNvbXBhdGlibGUgd2F5LiBJZiBhDQo+IGdpdmVuIGF0dHJp
YnV0ZSBkb2VzIG5vdCBtYWtlIHNlbnNlIGZvciBhIGdpdmVuIHZlbmRvciwgb3IgaXMgbm90IHll
dA0KPiBpbXBsZW1lbnRlZCB0aGVuIGxlYXZpbmcgaXQgdW5wb3B1bGF0ZWQgaXMgaW5kZWVkIHRo
ZSBleHBlY3RhdGlvbi4NCj4NCj4gVGhlIGdvYWwgaXMgdG8gYm90aCBtaW5pbWl6ZSB2ZW5kb3Ig
c3BlY2lmaWMgbG9naWMgaW4gaW5mcmFzdHJ1Y3R1cmUNCj4gdGhhdCBjb25zdW1lcyB0aGUgbmRj
dGwganNvbiB3aGlsZSBhdCB0aGUgc2FtZSB0aW1lIGJhbGFuY2UgdmVuZG9yDQo+IG5lZWRzLiBJ
biBvdGhlciB3b3JkcyBhdm9pZCAibmVlZGxlc3MiIGRpZmZlcmVudGlhdGlvbiBhcyBtdWNoIGFz
DQo+IHBvc3NpYmxlIHdpdGggc21hbGwgYW1vdW50IG9mIGNvbXBhdCB3b3JrIGFjcm9zcyB2ZW5k
b3JzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
