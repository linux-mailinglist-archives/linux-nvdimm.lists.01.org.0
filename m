Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDC320F172
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 11:20:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1454F114129E3;
	Tue, 30 Jun 2020 02:20:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B93F7114129D9
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 02:20:53 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U92HgL045577;
	Tue, 30 Jun 2020 05:20:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ybnut460-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 05:20:41 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U92OqP046379;
	Tue, 30 Jun 2020 05:20:40 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ybnut459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 05:20:40 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U9Gun0008352;
	Tue, 30 Jun 2020 09:20:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma06fra.de.ibm.com with ESMTP id 31wwcgsm4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 09:20:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U9JGwg57475430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2020 09:19:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 981E04C052;
	Tue, 30 Jun 2020 09:20:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9777A4C04A;
	Tue, 30 Jun 2020 09:20:34 +0000 (GMT)
Received: from [9.199.48.28] (unknown [9.199.48.28])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2020 09:20:34 +0000 (GMT)
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
 <20200629160940.GU21462@kitsune.suse.cz> <87lfk5hahc.fsf@linux.ibm.com>
 <CAPcyv4hEV=Ps=t=3qsFq3Ob1jzf=ptoZmYTDkgr8D_G0op8uvQ@mail.gmail.com>
 <20200630085413.GW21462@kitsune.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <9204289b-2274-b5c1-2cd5-8ed5ce28efb4@linux.ibm.com>
Date: Tue, 30 Jun 2020 14:50:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630085413.GW21462@kitsune.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_02:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300062
Message-ID-Hash: A52K76WIGFUK5HZOV75N34CJTLGJMM7W
X-Message-ID-Hash: A52K76WIGFUK5HZOV75N34CJTLGJMM7W
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A52K76WIGFUK5HZOV75N34CJTLGJMM7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNi8zMC8yMCAyOjI0IFBNLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3RlOg0KPiBPbiBNb24sIEp1
biAyOSwgMjAyMCBhdCAwNjo1MDoxNVBNIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+PiBP
biBNb24sIEp1biAyOSwgMjAyMCBhdCAxOjQxIFBNIEFuZWVzaCBLdW1hciBLLlYNCj4+IDxhbmVl
c2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4NCj4+PiBNaWNoYWwgU3VjaMOhbmVr
IDxtc3VjaGFuZWtAc3VzZS5kZT4gd3JpdGVzOg0KPj4+DQo+Pj4+IEhlbGxvLA0KPj4+Pg0KPj4+
PiBPbiBNb24sIEp1biAyOSwgMjAyMCBhdCAwNzoyNzoyMFBNICswNTMwLCBBbmVlc2ggS3VtYXIg
Sy5WIHdyb3RlOg0KPj4+Pj4gbnZkaW1tIGV4cGVjdCB0aGUgZmx1c2ggcm91dGluZXMgdG8ganVz
dCBtYXJrIHRoZSBjYWNoZSBjbGVhbi4gVGhlIGJhcnJpZXINCj4+Pj4+IHRoYXQgbWFyayB0aGUg
c3RvcmUgZ2xvYmFsbHkgdmlzaWJsZSBpcyBkb25lIGluIG52ZGltbV9mbHVzaCgpLg0KPj4+Pj4N
Cj4+Pj4+IFVwZGF0ZSB0aGUgcGFwcl9zY20gZHJpdmVyIHRvIGEgc2ltcGxpZmllZCBudmRpbV9m
bHVzaCBjYWxsYmFjayB0aGF0IGRvDQo+Pj4+PiBvbmx5IHRoZSByZXF1aXJlZCBiYXJyaWVyLg0K
Pj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZWVzaCBLdW1hciBLLlYgPGFuZWVzaC5rdW1h
ckBsaW51eC5pYm0uY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgIGFyY2gvcG93ZXJwYy9saWIvcG1l
bS5jICAgICAgICAgICAgICAgICAgIHwgIDYgLS0tLS0tDQo+Pj4+PiAgIGFyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcHNlcmllcy9wYXByX3NjbS5jIHwgMTMgKysrKysrKysrKysrKw0KPj4+Pj4gICAy
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+Pg0K
Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9saWIvcG1lbS5jIGIvYXJjaC9wb3dlcnBj
L2xpYi9wbWVtLmMNCj4+Pj4+IGluZGV4IDVhNjFhYWViNjkzMC4uMjEyMTBmYTY3NmU1IDEwMDY0
NA0KPj4+Pj4gLS0tIGEvYXJjaC9wb3dlcnBjL2xpYi9wbWVtLmMNCj4+Pj4+ICsrKyBiL2FyY2gv
cG93ZXJwYy9saWIvcG1lbS5jDQo+Pj4+PiBAQCAtMTksOSArMTksNiBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgX19jbGVhbl9wbWVtX3JhbmdlKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxv
bmcgc3RvcCkNCj4+Pj4+DQo+Pj4+PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2l6ZSA+PiBzaGlm
dDsgaSsrLCBhZGRyICs9IGJ5dGVzKQ0KPj4+Pj4gICAgICAgICAgICAgICBhc20gdm9sYXRpbGUo
UFBDX0RDQlNUUFMoJTAsICUxKTogOiJpIigwKSwgInIiKGFkZHIpOiAibWVtb3J5Iik7DQo+Pj4+
PiAtDQo+Pj4+PiAtDQo+Pj4+PiAtICAgIGFzbSB2b2xhdGlsZShQUENfUEhXU1lOQyA6OjogIm1l
bW9yeSIpOw0KPj4+Pj4gICB9DQo+Pj4+Pg0KPj4+Pj4gICBzdGF0aWMgaW5saW5lIHZvaWQgX19m
bHVzaF9wbWVtX3JhbmdlKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxvbmcgc3RvcCkN
Cj4+Pj4+IEBAIC0zNCw5ICszMSw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2ZsdXNoX3BtZW1f
cmFuZ2UodW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzdG9wKQ0KPj4+Pj4NCj4+
Pj4+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaXplID4+IHNoaWZ0OyBpKyssIGFkZHIgKz0gYnl0
ZXMpDQo+Pj4+PiAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZShQUENfRENCRlBTKCUwLCAlMSk6
IDoiaSIoMCksICJyIihhZGRyKTogIm1lbW9yeSIpOw0KPj4+Pj4gLQ0KPj4+Pj4gLQ0KPj4+Pj4g
LSAgICBhc20gdm9sYXRpbGUoUFBDX1BIV1NZTkMgOjo6ICJtZW1vcnkiKTsNCj4+Pj4+ICAgfQ0K
Pj4+Pj4NCj4+Pj4+ICAgc3RhdGljIGlubGluZSB2b2lkIGNsZWFuX3BtZW1fcmFuZ2UodW5zaWdu
ZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBzdG9wKQ0KPj4+Pj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9wYXByX3NjbS5jIGIvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wc2VyaWVzL3BhcHJfc2NtLmMNCj4+Pj4+IGluZGV4IDljNTY5MDc4YTA5Zi4uOWE5
YTA3NjZmOGI2IDEwMDY0NA0KPj4+Pj4gLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2Vy
aWVzL3BhcHJfc2NtLmMNCj4+Pj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmll
cy9wYXByX3NjbS5jDQo+Pj4+PiBAQCAtNjMwLDYgKzYzMCwxOCBAQCBzdGF0aWMgaW50IHBhcHJf
c2NtX25kY3RsKHN0cnVjdCBudmRpbW1fYnVzX2Rlc2NyaXB0b3IgKm5kX2Rlc2MsDQo+Pj4+Pg0K
Pj4+Pj4gICAgICAgcmV0dXJuIDA7DQo+Pj4+PiAgIH0NCj4+Pj4+ICsvKg0KPj4+Pj4gKyAqIFdl
IGhhdmUgbWFkZSBzdXJlIHRoZSBwbWVtIHdyaXRlcyBhcmUgZG9uZSBzdWNoIHRoYXQgYmVmb3Jl
IGNhbGxpbmcgdGhpcw0KPj4+Pj4gKyAqIGFsbCB0aGUgY2FjaGVzIGFyZSBmbHVzaGVkL2NsZWFu
LiBXZSB1c2UgZGNiZi9kY2JmcHMgdG8gZW5zdXJlIHRoaXMuIEhlcmUNCj4+Pj4+ICsgKiB3ZSBq
dXN0IG5lZWQgdG8gYWRkIHRoZSBuZWNlc3NhcnkgYmFycmllciB0byBtYWtlIHN1cmUgdGhlIGFi
b3ZlIGZsdXNoZXMNCj4+Pj4+ICsgKiBhcmUgaGF2ZSB1cGRhdGVkIHBlcnNpc3RlbnQgc3RvcmFn
ZSBiZWZvcmUgYW55IGRhdGEgYWNjZXNzIG9yIGRhdGEgdHJhbnNmZXINCj4+Pj4+ICsgKiBjYXVz
ZWQgYnkgc3Vic2VxdWVudCBpbnN0cnVjdGlvbnMgaXMgaW5pdGlhdGVkLg0KPj4+Pj4gKyAqLw0K
Pj4+Pj4gK3N0YXRpYyBpbnQgcGFwcl9zY21fZmx1c2hfc3luYyhzdHJ1Y3QgbmRfcmVnaW9uICpu
ZF9yZWdpb24sIHN0cnVjdCBiaW8gKmJpbykNCj4+Pj4+ICt7DQo+Pj4+PiArICAgIGFyY2hfcG1l
bV9mbHVzaF9iYXJyaWVyKCk7DQo+Pj4+PiArICAgIHJldHVybiAwOw0KPj4+Pj4gK30NCj4+Pj4+
DQo+Pj4+PiAgIHN0YXRpYyBzc2l6ZV90IGZsYWdzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0K
Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsIGNoYXIgKmJ1ZikNCj4+Pj4+IEBAIC03NDMsNiArNzU1LDcgQEAgc3RhdGljIGludCBwYXBy
X3NjbV9udmRpbW1faW5pdChzdHJ1Y3QgcGFwcl9zY21fcHJpdiAqcCkNCj4+Pj4+ICAgICAgIG5k
cl9kZXNjLm1hcHBpbmcgPSAmbWFwcGluZzsNCj4+Pj4+ICAgICAgIG5kcl9kZXNjLm51bV9tYXBw
aW5ncyA9IDE7DQo+Pj4+PiAgICAgICBuZHJfZGVzYy5uZF9zZXQgPSAmcC0+bmRfc2V0Ow0KPj4+
Pj4gKyAgICBuZHJfZGVzYy5mbHVzaCA9IHBhcHJfc2NtX2ZsdXNoX3N5bmM7DQo+Pj4+DQo+Pj4+
IEFGQUlDVCBjdXJyZW50bHkgdGhlIG9ubHkgZGV2aWNlIHRoYXQgaW1wbGVtZW50cyBmbHVzaCBp
cyB2aXJ0aW9fcG1lbS4NCj4+Pj4gSG93IGRvZXMgdGhlIG5maXQgZHJpdmVyIGdldCBhd2F5IHdp
dGhvdXQgaW1wbGVtZW50aW5nIGZsdXNoPw0KPj4+DQo+Pj4gZ2VuZXJpY19udmRpbW1fZmx1c2gg
ZG9lcyB0aGUgcmVxdWlyZWQgYmFycmllciBmb3IgbmZpdC4gVGhlIHJlYXNvbiBmb3INCj4+PiBh
ZGRpbmcgbmRyX2Rlc2MuZmx1c2ggY2FsbCBiYWNrIGZvciBwYXByX3NjbSB3YXMgdG8gYXZvaWQg
dGhlIHVzYWdlDQo+Pj4gb2YgaW9tZW0gYmFzZWQgZGVlcCBmbHVzaGluZyAobmRyX3JlZ2lvbl9k
YXRhLmZsdXNoX3dwcSkgd2hpY2ggaXMgbm90DQo+Pj4gc3VwcG9ydGVkIGJ5IHBhcHJfc2NtLg0K
Pj4+DQo+Pj4gQlRXIHdlIGRvIHJldHVybiBOVUxMIGZvciBuZHJkX2dldF9mbHVzaF93cHEoKSBv
biBwb3dlci4gU28gdGhlIHVwc3RyZWFtDQo+Pj4gY29kZSBhbHNvIGRvZXMgdGhlIHNhbWUgdGhp
bmcsIGJ1dCBpbiBhIGRpZmZlcmVudCB3YXkuDQo+Pj4NCj4+Pg0KPj4+PiBBbHNvIHRoZSBmbHVz
aCB0YWtlcyBhcmd1bWVudHMgdGhhdCBhcmUgY29tcGxldGVseSB1bnVzZWQgYnV0IGEgdXNlciBv
Zg0KPj4+PiB0aGUgcG1lbSByZWdpb24gbXVzdCBhc3N1bWUgdGhleSBhcmUgdXNlZCwgYW5kIGNh
bGwgZmx1c2goKSBvbiB0aGUNCj4+Pj4gcmVnaW9uIHJhdGhlciB0aGFuIGFyY2hfcG1lbV9mbHVz
aF9iYXJyaWVyKCkgZGlyZWN0bHkuDQo+Pj4NCj4+PiBUaGUgYmlvIGFyZ3VtZW50IGNhbiBoZWxw
IGEgcG1lbSBkcml2ZXIgdG8gZG8gcmFuZ2UgYmFzZWQgZmx1c2hpbmcgaW4NCj4+PiBjYXNlIG9m
IHBtZW1fbWFrZV9yZXF1ZXN0LiBJZiBiaW8gaXMgbnVsbCB0aGVuIHdlIG11c3QgYXNzdW1lIGEg
ZnVsbA0KPj4+IGRldmljZSBmbHVzaC4NCj4+DQo+PiBUaGUgYmlvIGFyZ3VtZW50IGlzbid0IGZv
ciByYW5nZSBiYXNlZCBmbHVzaGluZywgaXQgaXMgZm9yIGZsdXNoDQo+PiBvcGVyYXRpb25zIHRo
YXQgbmVlZCB0byBjb21wbGV0ZSBhc3luY2hyb25vdXNseS4NCj4gSG93IGRvZXMgdGhlIGJsb2Nr
IGxheWVyIGRldGVybWluZSB0aGF0IHRoZSBwbWVtIGRldmljZSBuZWVkcw0KPiBhc3luY2hyb25v
dXMgZnVzaGluZz8NCj4gDQoNCglzZXRfYml0KE5EX1JFR0lPTl9BU1lOQywgJm5kcl9kZXNjLmZs
YWdzKTsNCgkNCmFuZCBkYXhfc3luY2hyb25vdXMoZGV2KQ0KDQo+IFRoZSBmbHVzaCgpIHdhcyBk
ZXNpZ25lZCBmb3IgdGhlIHB1cnBvc2Ugd2l0aCB0aGUgYmlvIGFyZ3VtZW50IGFuZCBvbmx5DQo+
IHZpcnRpb19wbWVtIHdoaWNoIGlzIGZ1bHNoZWQgYXN5bmNocm9ub3VzbHkgdXNlZCBpdC4gTm93
IHRoYXQgcGFwcl9zY20NCj4gcmVzdXNlcyBpdCBmaXIgZGlmZmVyZW50IHB1cnBvc2UgaG93IGRv
IHlvdSB0ZWxsPw0KPiANCg0KLWFuZWVzaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
