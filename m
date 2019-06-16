Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428FA473B2
	for <lists+linux-nvdimm@lfdr.de>; Sun, 16 Jun 2019 09:49:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98CF021290DE4;
	Sun, 16 Jun 2019 00:49:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9AC3121276BA6
 for <linux-nvdimm@lists.01.org>; Sun, 16 Jun 2019 00:49:48 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5G7l6vR019114
 for <linux-nvdimm@lists.01.org>; Sun, 16 Jun 2019 03:49:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t5e6wmyvd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Sun, 16 Jun 2019 03:49:47 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Sun, 16 Jun 2019 08:49:45 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 16 Jun 2019 08:49:41 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5G7nerW29622376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Jun 2019 07:49:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D64F4C04E;
 Sun, 16 Jun 2019 07:49:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FD194C046;
 Sun, 16 Jun 2019 07:49:38 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.86.48])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Jun 2019 07:49:38 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v9 10/12] mm/devm_memremap_pages: Enable sub-section remap
In-Reply-To: <155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Sun, 16 Jun 2019 13:19:36 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19061607-0020-0000-0000-0000034A7E9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061607-0021-0000-0000-0000219DBFAE
Message-Id: <87zhmigeb3.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160076
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: mhocko@suse.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, osalvador@suse.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyaXRlczoKCj4gVGVhY2gg
ZGV2bV9tZW1yZW1hcF9wYWdlcygpIGFib3V0IHRoZSBuZXcgc3ViLXNlY3Rpb24gY2FwYWJpbGl0
aWVzIG9mCj4gYXJjaF97YWRkLHJlbW92ZX1fbWVtb3J5KCkuIEVmZmVjdGl2ZWx5LCBqdXN0IHJl
cGxhY2UgYWxsIHVzYWdlIG9mCj4gYWxpZ25fc3RhcnQsIGFsaWduX2VuZCwgYW5kIGFsaWduX3Np
emUgd2l0aCByZXMtPnN0YXJ0LCByZXMtPmVuZCwgYW5kCj4gcmVzb3VyY2Vfc2l6ZShyZXMpLiBU
aGUgZXhpc3Rpbmcgc2FuaXR5IGNoZWNrIHdpbGwgc3RpbGwgbWFrZSBzdXJlIHRoYXQKPiB0aGUg
dHdvIHNlcGFyYXRlIHJlbWFwIGF0dGVtcHRzIGRvIG5vdCBjb2xsaWRlIHdpdGhpbiBhIHN1Yi1z
ZWN0aW9uICgyTUIKPiBvbiB4ODYpLgo+Cj4gQ2M6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2Uu
Y29tPgo+IENjOiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+Cj4gQ2M6IErDqXLDtG1l
IEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPgo+IENjOiBMb2dhbiBHdW50aG9ycGUgPGxvZ2Fu
Z0BkZWx0YXRlZS5jb20+Cj4gQ2M6IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4K
PiBDYzogUGF2ZWwgVGF0YXNoaW4gPHBhc2hhLnRhdGFzaGluQHNvbGVlbi5jb20+Cj4gU2lnbmVk
LW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Cj4gLS0tCj4g
IGtlcm5lbC9tZW1yZW1hcC5jIHwgICA2MSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygr
KSwgMzcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21lbXJlbWFwLmMgYi9r
ZXJuZWwvbWVtcmVtYXAuYwo+IGluZGV4IDU3OTgwZWQ0ZTU3MS4uYTBlNWY2YjkxYjA0IDEwMDY0
NAo+IC0tLSBhL2tlcm5lbC9tZW1yZW1hcC5jCj4gKysrIGIva2VybmVsL21lbXJlbWFwLmMKPiBA
QCAtNTgsNyArNTgsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBwZm5fZmlyc3Qoc3RydWN0IGRl
dl9wYWdlbWFwICpwZ21hcCkKPiAgCXN0cnVjdCB2bWVtX2FsdG1hcCAqYWx0bWFwID0gJnBnbWFw
LT5hbHRtYXA7Cj4gIAl1bnNpZ25lZCBsb25nIHBmbjsKPiAgCj4gLQlwZm4gPSByZXMtPnN0YXJ0
ID4+IFBBR0VfU0hJRlQ7Cj4gKwlwZm4gPSBQSFlTX1BGTihyZXMtPnN0YXJ0KTsKPiAgCWlmIChw
Z21hcC0+YWx0bWFwX3ZhbGlkKQo+ICAJCXBmbiArPSB2bWVtX2FsdG1hcF9vZmZzZXQoYWx0bWFw
KTsKPiAgCXJldHVybiBwZm47Cj4gQEAgLTg2LDcgKzg2LDYgQEAgc3RhdGljIHZvaWQgZGV2bV9t
ZW1yZW1hcF9wYWdlc19yZWxlYXNlKHZvaWQgKmRhdGEpCj4gIAlzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwID0gZGF0YTsKPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBnbWFwLT5kZXY7Cj4gIAlz
dHJ1Y3QgcmVzb3VyY2UgKnJlcyA9ICZwZ21hcC0+cmVzOwo+IC0JcmVzb3VyY2Vfc2l6ZV90IGFs
aWduX3N0YXJ0LCBhbGlnbl9zaXplOwo+ICAJdW5zaWduZWQgbG9uZyBwZm47Cj4gIAlpbnQgbmlk
Owo+ICAKPiBAQCAtOTYsMjUgKzk1LDIxIEBAIHN0YXRpYyB2b2lkIGRldm1fbWVtcmVtYXBfcGFn
ZXNfcmVsZWFzZSh2b2lkICpkYXRhKQo+ICAJcGdtYXAtPmNsZWFudXAocGdtYXAtPnJlZik7Cj4g
IAo+ICAJLyogcGFnZXMgYXJlIGRlYWQgYW5kIHVudXNlZCwgdW5kbyB0aGUgYXJjaCBtYXBwaW5n
ICovCj4gLQlhbGlnbl9zdGFydCA9IHJlcy0+c3RhcnQgJiB+KFBBX1NFQ1RJT05fU0laRSAtIDEp
Owo+IC0JYWxpZ25fc2l6ZSA9IEFMSUdOKHJlcy0+c3RhcnQgKyByZXNvdXJjZV9zaXplKHJlcyks
IFBBX1NFQ1RJT05fU0laRSkKPiAtCQktIGFsaWduX3N0YXJ0Owo+IC0KPiAtCW5pZCA9IHBhZ2Vf
dG9fbmlkKHBmbl90b19wYWdlKGFsaWduX3N0YXJ0ID4+IFBBR0VfU0hJRlQpKTsKPiArCW5pZCA9
IHBhZ2VfdG9fbmlkKHBmbl90b19wYWdlKFBIWVNfUEZOKHJlcy0+c3RhcnQpKSk7CgpXaHkgZG8g
d2Ugbm90IHJlcXVpcmUgdG8gYWxpZ24gdGhpbmdzIHRvIHN1YnNlY3Rpb24gc2l6ZSBub3c/IAoK
LWFuZWVzaAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBz
Oi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
