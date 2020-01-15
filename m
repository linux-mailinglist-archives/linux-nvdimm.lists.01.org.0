Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDA13CB0A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 18:31:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B26810097DC8;
	Wed, 15 Jan 2020 09:34:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 692E110097DC7
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 09:34:43 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FHR7Xc068478
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:31:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xhm34mrmq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 12:31:24 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
	Wed, 15 Jan 2020 17:31:22 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 15 Jan 2020 17:31:18 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FHVHVq48496666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2020 17:31:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D418B52051;
	Wed, 15 Jan 2020 17:31:16 +0000 (GMT)
Received: from [9.85.72.166] (unknown [9.85.72.166])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07F795205A;
	Wed, 15 Jan 2020 17:31:15 +0000 (GMT)
Subject: Re: [RFC PATCH] libnvdimm: Update the meaning for persistence_domain
 values
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Jeff Moyer <jmoyer@redhat.com>
References: <20200108064905.170394-1-aneesh.kumar@linux.ibm.com>
 <x49o8v4oe0t.fsf@segfault.boston.devel.redhat.com>
 <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
Date: Wed, 15 Jan 2020 23:01:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a87b5da8-54d1-3c1a-f068-4d2f389576c9@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011517-0020-0000-0000-000003A0F342
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011517-0021-0000-0000-000021F86E17
Message-Id: <0f44df90-1f75-9d0a-10af-6e7f48158bc7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150133
Message-ID-Hash: Y3LKAEX6MX7JQK4P4XOFIR2D7VGPGBME
X-Message-ID-Hash: Y3LKAEX6MX7JQK4P4XOFIR2D7VGPGBME
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y3LKAEX6MX7JQK4P4XOFIR2D7VGPGBME/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMS8xNS8yMCAxMDo1NyBQTSwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToNCj4gT24gMS8xNS8y
MCAxMDoyNSBQTSwgSmVmZiBNb3llciB3cm90ZToNCj4+ICJBbmVlc2ggS3VtYXIgSy5WIiA8YW5l
ZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+IHdyaXRlczoNCj4+DQo+Pj4gQ3VycmVudGx5LCBrZXJu
ZWwgc2hvd3MgdGhlIGJlbG93IHZhbHVlcw0KPj4+IMKgwqDCoMKgInBlcnNpc3RlbmNlX2RvbWFp
biI6ImNwdV9jYWNoZSINCj4+PiDCoMKgwqDCoCJwZXJzaXN0ZW5jZV9kb21haW4iOiJtZW1vcnlf
Y29udHJvbGxlciINCj4+PiDCoMKgwqDCoCJwZXJzaXN0ZW5jZV9kb21haW4iOiJ1bmtub3duIg0K
Pj4+DQo+Pj4gVGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBtZWFuaW5nIG9mIHRoZXNlIHZhbHVlcyBz
dWNoIHRoYXQNCj4+Pg0KPj4+ICJjcHVfY2FjaGUiIGluZGljYXRlcyBubyBleHRyYSBpbnN0cnVj
dGlvbnMgaXMgbmVlZGVkIHRvIGVuc3VyZSB0aGUgDQo+Pj4gcGVyc2lzdGVuY2UNCj4+PiBvZiBk
YXRhIGluIHRoZSBwbWVtIG1lZGlhIG9uIHBvd2VyIGZhaWx1cmUuDQo+Pj4NCj4+PiAibWVtb3J5
X2NvbnRyb2xsZXIiIGluZGljYXRlcyBwbGF0Zm9ybSBwcm92aWRlZCBpbnN0cnVjdGlvbnMgbmVl
ZCB0byANCj4+PiBiZSBpc3N1ZWQNCj4+PiBhcyBwZXIgZG9jdW1lbnRlZCBzZXF1ZW5jZSB0byBt
YWtlIHN1cmUgZGF0YSBmbHVzaGVkIGlzIGd1YXJhbnRlZWQgdG8gDQo+Pj4gYmUgb24gcG1lbQ0K
Pj4+IG1lZGlhIGluIGNhc2Ugb2Ygc3lzdGVtIHBvd2VyIGxvc3MuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4NCj4+
PiAtLS0NCj4+PiDCoCBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20uYyB8
IDcgKysrKysrLQ0KPj4+IMKgIGluY2x1ZGUvbGludXgvbGlibnZkaW1tLmjCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDYgKysrLS0tDQo+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BhcHJfc2NtLmMgDQo+Pj4gYi9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20uYw0KPj4+IGluZGV4IGMyZWYzMjBiYTFiZi4u
MjZhNWVmMjYzNzU4IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNl
cmllcy9wYXByX3NjbS5jDQo+Pj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVz
L3BhcHJfc2NtLmMNCj4+PiBAQCAtMzYwLDggKzM2MCwxMyBAQCBzdGF0aWMgaW50IHBhcHJfc2Nt
X252ZGltbV9pbml0KHN0cnVjdCANCj4+PiBwYXByX3NjbV9wcml2ICpwKQ0KPj4+IMKgwqDCoMKg
wqAgaWYgKHAtPmlzX3ZvbGF0aWxlKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5yZWdpb24g
PSBudmRpbW1fdm9sYXRpbGVfcmVnaW9uX2NyZWF0ZShwLT5idXMsICZuZHJfZGVzYyk7DQo+Pj4g
LcKgwqDCoCBlbHNlDQo+Pj4gK8KgwqDCoCBlbHNlIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgLyoN
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFdlIG5lZWQgdG8gZmx1c2ggdGhpbmdzIGNvcnJlY3Rs
eSB0byBndWFyYW50ZWUgcGVyc2lzdGFuY2UNCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPj4+
ICvCoMKgwqDCoMKgwqDCoCBzZXRfYml0KE5EX1JFR0lPTl9QRVJTSVNUX01FTUNUUkwsICZuZHJf
ZGVzYy5mbGFncyk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHAtPnJlZ2lvbiA9IG52ZGltbV9w
bWVtX3JlZ2lvbl9jcmVhdGUocC0+YnVzLCAmbmRyX2Rlc2MpOw0KPj4+ICvCoMKgwqAgfQ0KPj4+
IMKgwqDCoMKgwqAgaWYgKCFwLT5yZWdpb24pIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2VycihkZXYsICJFcnJvciByZWdpc3RlcmluZyByZWdpb24gJXBSIGZyb20gJXBPRlxuIiwNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5kcl9kZXNjLnJlcywgcC0+ZG4p
Ow0KPj4NCj4+IFdvdWxkIHlvdSBhbHNvIHVwZGF0ZSBvZl9wbWVtIHRvIGluZGljYXRlIHRoZSBw
ZXJzaXN0ZW5jZSBkb21haW4sDQo+PiBwbGVhc2U/DQo+Pg0KPiANCj4gc3VyZS4NCj4gDQo+IA0K
Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xpYm52ZGltbS5oIGIvaW5jbHVkZS9saW51
eC9saWJudmRpbW0uaA0KPj4+IGluZGV4IGYyYTMzZjJlM2JhOC4uOTEyNjczNzM3N2UxIDEwMDY0
NA0KPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbGlibnZkaW1tLmgNCj4+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2xpYm52ZGltbS5oDQo+Pj4gQEAgLTUyLDkgKzUyLDkgQEAgZW51bSB7DQo+Pj4gwqDC
oMKgwqDCoMKgICovDQo+Pj4gwqDCoMKgwqDCoCBORF9SRUdJT05fUEVSU0lTVF9DQUNIRSA9IDEs
DQo+Pj4gwqDCoMKgwqDCoCAvKg0KPj4+IC3CoMKgwqDCoCAqIFBsYXRmb3JtIHByb3ZpZGVzIG1l
Y2hhbmlzbXMgdG8gYXV0b21hdGljYWxseSBmbHVzaCBvdXRzdGFuZGluZw0KPj4+IC3CoMKgwqDC
oCAqIHdyaXRlIGRhdGEgZnJvbSBtZW1vcnkgY29udHJvbGVyIHRvIHBtZW0gb24gc3lzdGVtIHBv
d2VyIGxvc3MuDQo+Pj4gLcKgwqDCoMKgICogKEFEUikNCj4+PiArwqDCoMKgwqAgKiBQbGF0Zm9y
bSBwcm92aWRlcyBpbnN0cnVjdGlvbnMgdG8gZmx1c2ggZGF0YSBzdWNoIHRoYXQgb24gDQo+Pj4g
Y29tcGxldGlvbg0KPj4+ICvCoMKgwqDCoCAqIG9mIHRoZSBpbnN0cnVjdGlvbnMsIGRhdGEgZmx1
c2hlZCBpcyBndWFyYW50ZWVkIHRvIGJlIG9uIHBtZW0gDQo+Pj4gZXZlbg0KPj4+ICvCoMKgwqDC
oCAqIGluIGNhc2Ugb2YgYSBzeXN0ZW0gcG93ZXIgbG9zcy4NCj4+DQo+PiBJIGZpbmQgdGhlIHBy
aW9yIGRlc2NyaXB0aW9uIGVhc2llciB0byB1bmRlcnN0YW5kLg0KPiANCj4gDQo+IEkgd2FzIHRy
eWluZyB0byBhdm9pZCB0aGUgdGVybSAnYXV0b21hdGljYWxseSwgJ21lbW9yeSBjb250cm9sZXIn
IGFuZCANCj4gQURSLiBDYW4gSSB1cGRhdGUgdGhlIGFib3ZlIGFzDQo+IA0KPiAvKg0KPiAgwqAq
IFBsYXRmb3JtIHByb3ZpZGVzIG1lY2hhbmlzbXMgdG8gZmx1c2ggb3V0c3RhbmRpbmcgd3JpdGUg
ZGF0YQ0KPiAgwqAqIHRvIHBtZW0gb24gc3lzdGVtIHBvd2VyIGxvc3MuDQo+ICDCoCovDQo+IA0K
DQpXYW50ZWQgdG8gYWRkIG1vcmUgZGV0YWlscy4gU28gd2l0aCB0aGUgYWJvdmUgaW50ZXJwcmV0
YXRpb24sIGlmIHRoZSANCnBlcnNpc3RlbmNlX2RvbWFpbiBpcyBmb3VuZCB0byBiZSAnY3B1X2Nh
Y2hlJywgYXBwbGljYXRpb24gY2FuIGV4cGVjdCBhIA0Kc3RvcmUgaW5zdHJ1Y3Rpb24gdG8gZ3Vh
cmFudGVlIHBlcnNpc3RlbmNlLiBJZiBpdCBpcyAnbm9uZScgdGhlcmUgaXMgbm8gDQpwZXJzaXN0
ZW5jZSAoIEkgYW0gbm90IHN1cmUgaG93IHRoYXQgaXMgdGhlIGRpZmZlcmVuY2UgZnJvbSAndm9s
YXRpbGUnIA0KcG1lbSByZWdpb24pLiBJZiBpdCBpcyAgJ21lbW9yeV9jb250cm9sbGVyJyAoIEkg
YW0gbm90IHN1cmUgd2hldGhlciB0aGF0IA0KaXMgdGhlIHJpZ2h0IHRlcm0pLCBhcHBsaWNhdGlv
biBuZWVkcyB0byBmb2xsb3cgdGhlIHJlY29tbWVuZGVkIA0KbWVjaGFuaXNtIHRvIGZsdXNoIHdy
aXRlIGRhdGEgdG8gcG1lbS4NCg0KLWFuZWVzaA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
