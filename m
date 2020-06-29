Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A920DCD5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 22:40:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA855111F92BA;
	Mon, 29 Jun 2020 13:40:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A14B10FCBC59
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 13:40:29 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TKb6iu105954;
	Mon, 29 Jun 2020 16:40:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjxcy8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 16:40:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TKeObh112150;
	Mon, 29 Jun 2020 16:40:24 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydjxcy7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 16:40:24 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TKYcpa000459;
	Mon, 29 Jun 2020 20:40:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma01dal.us.ibm.com with ESMTP id 31wwr8yh59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 20:40:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TKeMfe22741388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 20:40:22 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519A0136051;
	Mon, 29 Jun 2020 20:40:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4024C13604F;
	Mon, 29 Jun 2020 20:40:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.39])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 20:40:18 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
In-Reply-To: <20200629160940.GU21462@kitsune.suse.cz>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
 <20200629160940.GU21462@kitsune.suse.cz>
Date: Tue, 30 Jun 2020 02:10:15 +0530
Message-ID: <87lfk5hahc.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 cotscore=-2147483648 bulkscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290130
Message-ID-Hash: 4JKA37O7P2FTODM2RUVYXRU45HFGPNG5
X-Message-ID-Hash: 4JKA37O7P2FTODM2RUVYXRU45HFGPNG5
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4JKA37O7P2FTODM2RUVYXRU45HFGPNG5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWljaGFsIFN1Y2jDoW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+IHdyaXRlczoNCg0KPiBIZWxsbywN
Cj4NCj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMDc6Mjc6MjBQTSArMDUzMCwgQW5lZXNoIEt1
bWFyIEsuViB3cm90ZToNCj4+IG52ZGltbSBleHBlY3QgdGhlIGZsdXNoIHJvdXRpbmVzIHRvIGp1
c3QgbWFyayB0aGUgY2FjaGUgY2xlYW4uIFRoZSBiYXJyaWVyDQo+PiB0aGF0IG1hcmsgdGhlIHN0
b3JlIGdsb2JhbGx5IHZpc2libGUgaXMgZG9uZSBpbiBudmRpbW1fZmx1c2goKS4NCj4+IA0KPj4g
VXBkYXRlIHRoZSBwYXByX3NjbSBkcml2ZXIgdG8gYSBzaW1wbGlmaWVkIG52ZGltX2ZsdXNoIGNh
bGxiYWNrIHRoYXQgZG8NCj4+IG9ubHkgdGhlIHJlcXVpcmVkIGJhcnJpZXIuDQo+PiANCj4+IFNp
Z25lZC1vZmYtYnk6IEFuZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29t
Pg0KPj4gLS0tDQo+PiAgYXJjaC9wb3dlcnBjL2xpYi9wbWVtLmMgICAgICAgICAgICAgICAgICAg
fCAgNiAtLS0tLS0NCj4+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20u
YyB8IDEzICsrKysrKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbGli
L3BtZW0uYyBiL2FyY2gvcG93ZXJwYy9saWIvcG1lbS5jDQo+PiBpbmRleCA1YTYxYWFlYjY5MzAu
LjIxMjEwZmE2NzZlNSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9saWIvcG1lbS5jDQo+
PiArKysgYi9hcmNoL3Bvd2VycGMvbGliL3BtZW0uYw0KPj4gQEAgLTE5LDkgKzE5LDYgQEAgc3Rh
dGljIGlubGluZSB2b2lkIF9fY2xlYW5fcG1lbV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1
bnNpZ25lZCBsb25nIHN0b3ApDQo+PiAgDQo+PiAgCWZvciAoaSA9IDA7IGkgPCBzaXplID4+IHNo
aWZ0OyBpKyssIGFkZHIgKz0gYnl0ZXMpDQo+PiAgCQlhc20gdm9sYXRpbGUoUFBDX0RDQlNUUFMo
JTAsICUxKTogOiJpIigwKSwgInIiKGFkZHIpOiAibWVtb3J5Iik7DQo+PiAtDQo+PiAtDQo+PiAt
CWFzbSB2b2xhdGlsZShQUENfUEhXU1lOQyA6OjogIm1lbW9yeSIpOw0KPj4gIH0NCj4+ICANCj4+
ICBzdGF0aWMgaW5saW5lIHZvaWQgX19mbHVzaF9wbWVtX3JhbmdlKHVuc2lnbmVkIGxvbmcgc3Rh
cnQsIHVuc2lnbmVkIGxvbmcgc3RvcCkNCj4+IEBAIC0zNCw5ICszMSw2IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBfX2ZsdXNoX3BtZW1fcmFuZ2UodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQg
bG9uZyBzdG9wKQ0KPj4gIA0KPj4gIAlmb3IgKGkgPSAwOyBpIDwgc2l6ZSA+PiBzaGlmdDsgaSsr
LCBhZGRyICs9IGJ5dGVzKQ0KPj4gIAkJYXNtIHZvbGF0aWxlKFBQQ19EQ0JGUFMoJTAsICUxKTog
OiJpIigwKSwgInIiKGFkZHIpOiAibWVtb3J5Iik7DQo+PiAtDQo+PiAtDQo+PiAtCWFzbSB2b2xh
dGlsZShQUENfUEhXU1lOQyA6OjogIm1lbW9yeSIpOw0KPj4gIH0NCj4+ICANCj4+ICBzdGF0aWMg
aW5saW5lIHZvaWQgY2xlYW5fcG1lbV9yYW5nZSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25l
ZCBsb25nIHN0b3ApDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2Vy
aWVzL3BhcHJfc2NtLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20u
Yw0KPj4gaW5kZXggOWM1NjkwNzhhMDlmLi45YTlhMDc2NmY4YjYgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGFwcl9zY20uYw0KPj4gKysrIGIvYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3BhcHJfc2NtLmMNCj4+IEBAIC02MzAsNiArNjMwLDE4
IEBAIHN0YXRpYyBpbnQgcGFwcl9zY21fbmRjdGwoc3RydWN0IG52ZGltbV9idXNfZGVzY3JpcHRv
ciAqbmRfZGVzYywNCj4+ICANCj4+ICAJcmV0dXJuIDA7DQo+PiAgfQ0KPj4gKy8qDQo+PiArICog
V2UgaGF2ZSBtYWRlIHN1cmUgdGhlIHBtZW0gd3JpdGVzIGFyZSBkb25lIHN1Y2ggdGhhdCBiZWZv
cmUgY2FsbGluZyB0aGlzDQo+PiArICogYWxsIHRoZSBjYWNoZXMgYXJlIGZsdXNoZWQvY2xlYW4u
IFdlIHVzZSBkY2JmL2RjYmZwcyB0byBlbnN1cmUgdGhpcy4gSGVyZQ0KPj4gKyAqIHdlIGp1c3Qg
bmVlZCB0byBhZGQgdGhlIG5lY2Vzc2FyeSBiYXJyaWVyIHRvIG1ha2Ugc3VyZSB0aGUgYWJvdmUg
Zmx1c2hlcw0KPj4gKyAqIGFyZSBoYXZlIHVwZGF0ZWQgcGVyc2lzdGVudCBzdG9yYWdlIGJlZm9y
ZSBhbnkgZGF0YSBhY2Nlc3Mgb3IgZGF0YSB0cmFuc2Zlcg0KPj4gKyAqIGNhdXNlZCBieSBzdWJz
ZXF1ZW50IGluc3RydWN0aW9ucyBpcyBpbml0aWF0ZWQuDQo+PiArICovDQo+PiArc3RhdGljIGlu
dCBwYXByX3NjbV9mbHVzaF9zeW5jKHN0cnVjdCBuZF9yZWdpb24gKm5kX3JlZ2lvbiwgc3RydWN0
IGJpbyAqYmlvKQ0KPj4gK3sNCj4+ICsJYXJjaF9wbWVtX2ZsdXNoX2JhcnJpZXIoKTsNCj4+ICsJ
cmV0dXJuIDA7DQo+PiArfQ0KPj4gIA0KPj4gIHN0YXRpYyBzc2l6ZV90IGZsYWdzX3Nob3coc3Ry
dWN0IGRldmljZSAqZGV2LA0KPj4gIAkJCSAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
IGNoYXIgKmJ1ZikNCj4+IEBAIC03NDMsNiArNzU1LDcgQEAgc3RhdGljIGludCBwYXByX3NjbV9u
dmRpbW1faW5pdChzdHJ1Y3QgcGFwcl9zY21fcHJpdiAqcCkNCj4+ICAJbmRyX2Rlc2MubWFwcGlu
ZyA9ICZtYXBwaW5nOw0KPj4gIAluZHJfZGVzYy5udW1fbWFwcGluZ3MgPSAxOw0KPj4gIAluZHJf
ZGVzYy5uZF9zZXQgPSAmcC0+bmRfc2V0Ow0KPj4gKwluZHJfZGVzYy5mbHVzaCA9IHBhcHJfc2Nt
X2ZsdXNoX3N5bmM7DQo+DQo+IEFGQUlDVCBjdXJyZW50bHkgdGhlIG9ubHkgZGV2aWNlIHRoYXQg
aW1wbGVtZW50cyBmbHVzaCBpcyB2aXJ0aW9fcG1lbS4NCj4gSG93IGRvZXMgdGhlIG5maXQgZHJp
dmVyIGdldCBhd2F5IHdpdGhvdXQgaW1wbGVtZW50aW5nIGZsdXNoPw0KDQpnZW5lcmljX252ZGlt
bV9mbHVzaCBkb2VzIHRoZSByZXF1aXJlZCBiYXJyaWVyIGZvciBuZml0LiBUaGUgcmVhc29uIGZv
cg0KYWRkaW5nIG5kcl9kZXNjLmZsdXNoIGNhbGwgYmFjayBmb3IgcGFwcl9zY20gd2FzIHRvIGF2
b2lkIHRoZSB1c2FnZQ0Kb2YgaW9tZW0gYmFzZWQgZGVlcCBmbHVzaGluZyAobmRyX3JlZ2lvbl9k
YXRhLmZsdXNoX3dwcSkgd2hpY2ggaXMgbm90DQpzdXBwb3J0ZWQgYnkgcGFwcl9zY20uDQoNCkJU
VyB3ZSBkbyByZXR1cm4gTlVMTCBmb3IgbmRyZF9nZXRfZmx1c2hfd3BxKCkgb24gcG93ZXIuIFNv
IHRoZSB1cHN0cmVhbQ0KY29kZSBhbHNvIGRvZXMgdGhlIHNhbWUgdGhpbmcsIGJ1dCBpbiBhIGRp
ZmZlcmVudCB3YXkuDQoNCg0KPiBBbHNvIHRoZSBmbHVzaCB0YWtlcyBhcmd1bWVudHMgdGhhdCBh
cmUgY29tcGxldGVseSB1bnVzZWQgYnV0IGEgdXNlciBvZg0KPiB0aGUgcG1lbSByZWdpb24gbXVz
dCBhc3N1bWUgdGhleSBhcmUgdXNlZCwgYW5kIGNhbGwgZmx1c2goKSBvbiB0aGUNCj4gcmVnaW9u
IHJhdGhlciB0aGFuIGFyY2hfcG1lbV9mbHVzaF9iYXJyaWVyKCkgZGlyZWN0bHkuDQoNClRoZSBi
aW8gYXJndW1lbnQgY2FuIGhlbHAgYSBwbWVtIGRyaXZlciB0byBkbyByYW5nZSBiYXNlZCBmbHVz
aGluZyBpbg0KY2FzZSBvZiBwbWVtX21ha2VfcmVxdWVzdC4gSWYgYmlvIGlzIG51bGwgdGhlbiB3
ZSBtdXN0IGFzc3VtZSBhIGZ1bGwNCmRldmljZSBmbHVzaC4gDQoNCj5UaGlzIG1heSBub3QNCj4g
d29yayB3ZWxsIHdpdGggbWQgYXMgZGlzY3Vzc2VkIHdpdGggZWFybGllciBpdGVyYXRpb24gb2Yg
dGhlIHBhdGNoZXN0Lg0KPg0KDQpkbS13cml0ZWNhY2hlIG5lZWRzIHNvbWUgbWFqb3IgY2hhbmdl
cyB0byB3b3JrIHdpdGggYXN5bmNocm9ub3VzIHBtZW0NCmRldmljZXMuIA0KDQotYW5lZXNoCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
