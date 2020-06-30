Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD020EFEB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 09:53:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56F1611202ACA;
	Tue, 30 Jun 2020 00:53:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D75A611202AC7
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 00:53:44 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U7WAqF111998;
	Tue, 30 Jun 2020 03:53:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg3ec3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 03:53:38 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05U7WU0U114181;
	Tue, 30 Jun 2020 03:53:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31ycg3ec35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 03:53:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05U7nof4032633;
	Tue, 30 Jun 2020 07:53:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03fra.de.ibm.com with ESMTP id 31wwr89jss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 07:53:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05U7rXG061210900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2020 07:53:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 732B04C04A;
	Tue, 30 Jun 2020 07:53:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8465C4C050;
	Tue, 30 Jun 2020 07:53:31 +0000 (GMT)
Received: from [9.199.48.28] (unknown [9.199.48.28])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2020 07:53:31 +0000 (GMT)
Subject: Re: [PATCH updated] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
 <20200629202901.83516-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hgjH4We9Th2oir3NxpJEhFuLnQeCrF8auwNfF+5av8jQ@mail.gmail.com>
 <87imf9gn9w.fsf@linux.ibm.com>
 <CAPcyv4hbECX+7cvX+eT97jvDFUTjQbUEqExZKpV_moDWMFzJ6A@mail.gmail.com>
 <03cf6d12-544f-154d-18da-a6cd204998ee@linux.ibm.com>
Message-ID: <9f5de2ca-1877-979c-c7e8-a7434f1c5670@linux.ibm.com>
Date: Tue, 30 Jun 2020 13:23:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <03cf6d12-544f-154d-18da-a6cd204998ee@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_01:2020-06-30,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 cotscore=-2147483648 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300049
Message-ID-Hash: MMA3IMSWPGFYDPPEII4H74GMCHZHPSFF
X-Message-ID-Hash: MMA3IMSWPGFYDPPEII4H74GMCHZHPSFF
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MMA3IMSWPGFYDPPEII4H74GMCHZHPSFF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNi8zMC8yMCAxMjo1MiBQTSwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToNCj4gT24gNi8zMC8y
MCAxMjozNiBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPj4gT24gTW9uLCBKdW4gMjksIDIwMjAg
YXQgMTA6MDIgUE0gQW5lZXNoIEt1bWFyIEsuVg0KPj4gPGFuZWVzaC5rdW1hckBsaW51eC5pYm0u
Y29tPiB3cm90ZToNCj4+Pg0KPj4+IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwu
Y29tPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMToyOSBQTSBB
bmVlc2ggS3VtYXIgSy5WDQo+Pj4+IDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4gd3JvdGU6
DQo+Pj4+Pg0KPj4+Pj4gQXJjaGl0ZWN0dXJlcyBsaWtlIHBwYzY0IHByb3ZpZGUgcGVyc2lzdGVu
dCBtZW1vcnkgc3BlY2lmaWMgYmFycmllcnMNCj4+Pj4+IHRoYXQgd2lsbCBlbnN1cmUgdGhhdCBh
bGwgc3RvcmVzIGZvciB3aGljaCB0aGUgbW9kaWZpY2F0aW9ucyBhcmUNCj4+Pj4+IHdyaXR0ZW4g
dG8gcGVyc2lzdGVudCBzdG9yYWdlIGJ5IHByZWNlZGluZyBkY2JmcHMgYW5kIGRjYnN0cHMNCj4+
Pj4+IGluc3RydWN0aW9ucyBoYXZlIHVwZGF0ZWQgcGVyc2lzdGVudCBzdG9yYWdlIGJlZm9yZSBh
bnkgZGF0YQ0KPj4+Pj4gYWNjZXNzIG9yIGRhdGEgdHJhbnNmZXIgY2F1c2VkIGJ5IHN1YnNlcXVl
bnQgaW5zdHJ1Y3Rpb25zIGlzIA0KPj4+Pj4gaW5pdGlhdGVkLg0KPj4+Pj4gVGhpcyBpcyBpbiBh
ZGRpdGlvbiB0byB0aGUgb3JkZXJpbmcgZG9uZSBieSB3bWIoKQ0KPj4+Pj4NCj4+Pj4+IFVwZGF0
ZSBudmRpbW0gY29yZSBzdWNoIHRoYXQgYXJjaGl0ZWN0dXJlIGNhbiB1c2UgYmFycmllcnMgb3Ro
ZXIgdGhhbg0KPj4+Pj4gd21iIHRvIGVuc3VyZSBhbGwgcHJldmlvdXMgd3JpdGVzIGFyZSBhcmNo
aXRlY3R1cmFsbHkgdmlzaWJsZSBmb3INCj4+Pj4+IHRoZSBwbGF0Zm9ybSBidWZmZXIgZmx1c2gu
DQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1
bWFyQGxpbnV4LmlibS5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IMKgIGRyaXZlcnMvbWQvZG0td3Jp
dGVjYWNoZS5jwqDCoCB8IDIgKy0NCj4+Pj4+IMKgIGRyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZz
LmMgfCA4ICsrKystLS0tDQo+Pj4+PiDCoCBpbmNsdWRlL2xpbnV4L2xpYm52ZGltbS5owqDCoMKg
IHwgNCArKysrDQo+Pj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS13cml0
ZWNhY2hlLmMgYi9kcml2ZXJzL21kL2RtLXdyaXRlY2FjaGUuYw0KPj4+Pj4gaW5kZXggNzRmM2M1
MDZmMDg0Li44YzZiNmRjZTY0ZTIgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL21kL2RtLXdy
aXRlY2FjaGUuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9tZC9kbS13cml0ZWNhY2hlLmMNCj4+Pj4+
IEBAIC01MzYsNyArNTM2LDcgQEAgc3RhdGljIHZvaWQgc3NkX2NvbW1pdF9zdXBlcmJsb2NrKHN0
cnVjdCANCj4+Pj4+IGRtX3dyaXRlY2FjaGUgKndjKQ0KPj4+Pj4gwqAgc3RhdGljIHZvaWQgd3Jp
dGVjYWNoZV9jb21taXRfZmx1c2hlZChzdHJ1Y3QgZG1fd3JpdGVjYWNoZSAqd2MsIA0KPj4+Pj4g
Ym9vbCB3YWl0X2Zvcl9pb3MpDQo+Pj4+PiDCoCB7DQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlm
IChXQ19NT0RFX1BNRU0od2MpKQ0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
d21iKCk7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoX3BtZW1fZmx1
c2hfYmFycmllcigpOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+Pj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzc2RfY29tbWl0X2ZsdXNoZWQod2MsIHdhaXRfZm9y
X2lvcyk7DQo+Pj4+PiDCoCB9DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vcmVn
aW9uX2RldnMuYyANCj4+Pj4+IGIvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPj4+Pj4g
aW5kZXggNDUwMmY5YzQ3MDhkLi5iMzA4YWQwOWI2M2QgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2
ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jDQo+Pj4+PiArKysgYi9kcml2ZXJzL252ZGltbS9yZWdp
b25fZGV2cy5jDQo+Pj4+PiBAQCAtMTIwNiwxMyArMTIwNiwxMyBAQCBpbnQgZ2VuZXJpY19udmRp
bW1fZmx1c2goc3RydWN0IG5kX3JlZ2lvbiANCj4+Pj4+ICpuZF9yZWdpb24pDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgIGlkeCA9IHRoaXNfY3B1X2FkZF9yZXR1cm4oZmx1c2hfaWR4LCBoYXNoXzMy
KGN1cnJlbnQtPnBpZCANCj4+Pj4+ICsgaWR4LCA4KSk7DQo+Pj4+Pg0KPj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoCAvKg0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgICogVGhlIGZpcnN0IHdtYigpIGlzIG5l
ZWRlZCB0byAnc2ZlbmNlJyBhbGwgcHJldmlvdXMgd3JpdGVzDQo+Pj4+PiAtwqDCoMKgwqDCoMKg
wqAgKiBzdWNoIHRoYXQgdGhleSBhcmUgYXJjaGl0ZWN0dXJhbGx5IHZpc2libGUgZm9yIHRoZSBw
bGF0Zm9ybQ0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgICogYnVmZmVyIGZsdXNoLsKgIE5vdGUgdGhh
dCB3ZSd2ZSBhbHJlYWR5IGFycmFuZ2VkIGZvciBwbWVtDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
KiBUaGUgZmlyc3QgYXJjaF9wbWVtX2ZsdXNoX2JhcnJpZXIoKSBpcyBuZWVkZWQgdG8gDQo+Pj4+
PiAnc2ZlbmNlJyBhbGwNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqIHByZXZpb3VzIHdyaXRlcyBz
dWNoIHRoYXQgdGhleSBhcmUgYXJjaGl0ZWN0dXJhbGx5IA0KPj4+Pj4gdmlzaWJsZSBmb3INCj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCAqIHRoZSBwbGF0Zm9ybSBidWZmZXIgZmx1c2guIE5vdGUgdGhh
dCB3ZSd2ZSBhbHJlYWR5IA0KPj4+Pj4gYXJyYW5nZWQgZm9yIHBtZW0NCj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAqIHdyaXRlcyB0byBhdm9pZCB0aGUgY2FjaGUgdmlhIG1lbWNweV9mbHVzaGNh
Y2hlKCkuwqAgVGhlIA0KPj4+Pj4gZmluYWwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdt
YigpIGVuc3VyZXMgb3JkZXJpbmcgZm9yIHRoZSBOVkRJTU0gZmx1c2ggd3JpdGUuDQo+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+Pj4+IC3CoMKgwqDCoMKgwqAgd21iKCk7DQo+Pj4+PiAr
wqDCoMKgwqDCoMKgIGFyY2hfcG1lbV9mbHVzaF9iYXJyaWVyKCk7DQo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBuZF9yZWdpb24tPm5kcl9tYXBwaW5nczsgaSsrKQ0KPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5kcmRfZ2V0X2ZsdXNoX3dw
cShuZHJkLCBpLCAwKSkNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB3cml0ZXEoMSwgbmRyZF9nZXRfZmx1c2hfd3BxKG5kcmQsIGksIGlkeCkp
Ow0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbGlibnZkaW1tLmggYi9pbmNsdWRl
L2xpbnV4L2xpYm52ZGltbS5oDQo+Pj4+PiBpbmRleCAxOGRhNDA1OWJlMDkuLjY2ZjZjNjViZDc4
OSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbGlibnZkaW1tLmgNCj4+Pj4+ICsr
KyBiL2luY2x1ZGUvbGludXgvbGlibnZkaW1tLmgNCj4+Pj4+IEBAIC0yODYsNCArMjg2LDggQEAg
c3RhdGljIGlubGluZSB2b2lkIGFyY2hfaW52YWxpZGF0ZV9wbWVtKHZvaWQgDQo+Pj4+PiAqYWRk
ciwgc2l6ZV90IHNpemUpDQo+Pj4+PiDCoCB9DQo+Pj4+PiDCoCAjZW5kaWYNCj4+Pj4+DQo+Pj4+
PiArI2lmbmRlZiBhcmNoX3BtZW1fZmx1c2hfYmFycmllcg0KPj4+Pj4gKyNkZWZpbmUgYXJjaF9w
bWVtX2ZsdXNoX2JhcnJpZXIoKSB3bWIoKQ0KPj4+Pj4gKyNlbmRpZg0KPj4+Pg0KPj4+PiBJIHRo
aW5rIGl0IGlzIG91dCBvZiBwbGFjZSB0byBkZWZpbmUgdGhpcyBpbiBsaWJudmRpbW0uaCBhbmQg
aXQgaXMgb2RkDQo+Pj4+IHRvIGdpdmUgaXQgc3VjaCBhIGxvbmcgbmFtZS4gVGhlIG90aGVyIHBt
ZW0gYXBpIGhlbHBlcnMgbGlrZQ0KPj4+PiBhcmNoX3diX2NhY2hlX3BtZW0oKSBhbmQgYXJjaF9p
bnZhbGlkYXRlX3BtZW0oKSBhcmUgZnVuY3Rpb24gY2FsbHMgZm9yDQo+Pj4+IGxpYm52ZGltbSBk
cml2ZXIgb3BlcmF0aW9ucywgdGhpcyBiYXJyaWVyIGlzIGp1c3QgYW4gaW5zdHJ1Y3Rpb24gYW5k
DQo+Pj4+IGlzIGNsb3NlciB0byB3bWIoKSB0aGFuIHRoZSBwbWVtIGFwaSByb3V0aW5lLg0KPj4+
Pg0KPj4+PiBTaW5jZSBpdCBpcyBhIHN0b3JlIGZlbmNlIGZvciBwbWVtLCBzbyBsZXQncyBqdXN0
IGNhbGwgaXQgcG1lbV93bWIoKQ0KPj4+PiBhbmQgZGVmaW5lIHRoZSBnZW5lcmljIHZlcnNpb24g
aW4gaW5jbHVkZS9saW51eC9jb21waWxlci5oLiBJdCBzaG91bGQNCj4+Pj4gcHJvYmFibHkgYWxz
byBiZSBkb2N1bWVudGVkIGFsb25nc2lkZSBkbWFfd21iKCkgaW4NCj4+Pj4gRG9jdW1lbnRhdGlv
bi9tZW1vcnktYmFycmllcnMudHh0IGFib3V0IHdoeSBjb2RlIHdvdWxkIHVzZSBpdCBvdmVyDQo+
Pj4+IHdtYigpLCBhbmQgd2h5IGEgc3ltbWV0cmljIHBtZW1fcm1iKCkgaXMgbm90IG5lZWRlZC4N
Cj4+Pg0KPj4+IEhvdyBhYm91dCB0aGUgYmVsb3c/IEkgdXNlZCBwbWVtX2JhcnJpZXIoKSBpbnN0
ZWFkIG9mIHBtZW1fd21iKCkuDQo+Pg0KPj4gV2h5PyBBIGJhcnJpZXIoKSBpcyBhIGJpLWRpcmVj
dGlvbmFsIG9yZGVyaW5nIG1lY2hhbmljIGZvciByZWFkcyBhbmQNCj4+IHdyaXRlcywgYW5kIHRo
ZSBwcm9wb3NlZCBzZW1hbnRpY3MgbWVjaGFuaXNtIG9ubHkgb3JkZXJzIHdyaXRlcyArDQo+PiBw
ZXJzaXN0ZW5jZS4gT3RoZXJ3aXNlIHRoZSBkZWZhdWx0IGZhbGxiYWNrIHRvIHdtYigpIG9uIGFy
Y2hzIHRoYXQNCj4+IGRvbid0IG92ZXJyaWRlIGl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UuDQo+Pg0K
Pj4+IEkNCj4+PiBndWVzcyB3ZSB3YW50ZWQgdGhpcyB0byBvcmRlcigpIGFueSBkYXRhIGFjY2Vz
cyBub3QganVzIHRoZSBmb2xsb3dpbmcNCj4+PiBzdG9yZXMgdG8gcGVyc2lzdGVudCBzdG9yYWdl
Pw0KPj4NCj4+IFdoeT8NCj4+DQo+Pj4gVy5yLnQgd2h5IGEgc3ltbWV0cmljIHBtZW1fcm1iKCkg
aXMgbm90DQo+Pj4gbmVlZGVkIEkgd2FzIG5vdCBzdXJlIGhvdyB0byBleHBsYWluIHRoYXQuIEFy
ZSB5b3Ugc3VnZ2VzdGluZyB0byBleHBsYWluDQo+Pj4gd2h5IGEgcmVhZC9sb2FkIGZyb20gcGVy
c2lzdGVudCBzdG9yYWdlIGRvbid0IHdhbnQgdG8gd2FpdCBmb3INCj4+PiBwbWVtX2JhcnJpZXIo
KSA/DQo+Pg0KPj4gSSB3b3VsZCBleHBlY3QgdGhhdCB0aGUgZXhwbGFuYXRpb24gaXMgdGhhdCBh
IHR5cGljYWwgcm1iKCkgaXMNCj4+IHN1ZmZpY2llbnQgYW5kIHRoYXQgdGhlcmUgaXMgbm90aGlu
ZyBwbWVtIHNwZWNpZmljIHNlbWFudGljIGZvciByZWFkDQo+PiBvcmRlcmluZyBmb3IgcG1lbSB2
cyBub3JtYWwgcmVhZC1iYXJyaWVyIHNlbWFudGljcy4NCj4+DQoNClNob3VsZCB0aGF0IGJlIHJt
YigpPyBBIHNtcF9ybWIoKSB3b3VsZCBzdWZmaWNlIHJpZ2h0Pw0KDQoNCi1hbmVlc2gKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
