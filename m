Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F764023
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 06:50:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 250AE212B5EE3;
	Tue,  9 Jul 2019 21:50:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9A0AB212B0FC8
 for <linux-nvdimm@lists.01.org>; Tue,  9 Jul 2019 21:50:33 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6A4l2uU066093
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:50:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tn7ye2j0j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:50:32 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 10 Jul 2019 05:50:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Jul 2019 05:50:28 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6A4oRhf49938626
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2019 04:50:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 087C7A4051;
 Wed, 10 Jul 2019 04:50:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F705A4040;
 Wed, 10 Jul 2019 04:50:26 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.35.64])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jul 2019 04:50:26 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [PATCH v4 0/6] Fixes related namespace alignment/page size/big
 endian
In-Reply-To: <20190620091626.31824-1-aneesh.kumar@linux.ibm.com>
References: <20190620091626.31824-1-aneesh.kumar@linux.ibm.com>
Date: Wed, 10 Jul 2019 10:20:24 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19071004-0012-0000-0000-00000330D993
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071004-0013-0000-0000-0000216A40BD
Message-Id: <87o9221oj3.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-10_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100058
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

CkhpIERhbiwKCkNhbiB5b3UgbWVyZ2UgdGhpcyB0byB5b3VyIHRyZWU/CgotYW5lZXNoCiJBbmVl
c2ggS3VtYXIgSy5WIiA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+IHdyaXRlczoKCj4gVGhp
cyBzZXJpZXMgaGFuZGxlIGNvbmZpZ3Mgd2hlcmUgaHVnZXBhZ2Ugc3VwcG9ydCBpcyBub3QgZW5h
YmxlZCBieSBkZWZhdWx0Lgo+IEFsc28sIHdlIHVwZGF0ZSBzb21lIG9mIHRoZSBpbmZvcm1hdGlv
biBtZXNzYWdlcyB0byBtYWtlIHN1cmUgd2UgdXNlIFBBR0VfU0laRSBpbnN0ZWFkCj4gb2YgU1pf
NEsuIFdlIG5vdyBzdG9yZSBwYWdlIHNpemUgYW5kIHN0cnVjdCBwYWdlIHNpemUgaW4gcGZuX3Ni
IGFuZCBkbyBleHRyYSBjaGVjawo+IGJlZm9yZSBlbmFibGluZyBuYW1lc3BhY2UuIFRoZXJlIGFs
c28gYW4gZW5kaWFubmVzcyBmaXguCj4KPiBUaGUgcGF0Y2ggc2VyaWVzIGlzIG9uIHRvcCBvZiBz
dWJzZWN0aW9uIHYxMCBwYXRjaHNldAo+Cj4gaHR0cDovL2xvcmUua2VybmVsLm9yZy9saW51eC1t
bS8xNTYwOTIzNDkzMDAuOTc5OTU5LjE3NjAzNzEwNzExOTU3NzM1MTM1LnN0Z2l0QGR3aWxsaWEy
LWRlc2szLmFtci5jb3JwLmludGVsLmNvbQo+Cj4gQ2hhbmdlcyBmcm9tIFYzOgo+ICogRHJvcHBl
ZCB0aGUgY2hhbmdlIHJlbGF0ZWQgUEZOX01JTl9WRVJTSU9OCj4gKiBmb3IgcGZuX3NiIG1pbm9y
IHZlcnNpb24gPCA0LCB3ZSBkZWZhdWx0IHBhZ2Vfc2l6ZSB0byBQQUdFX1NJWkUgaW5zdGVhZCBv
ZiBTWl80ay4KPgo+IEFuZWVzaCBLdW1hciBLLlYgKDYpOgo+ICAgbnZkaW1tOiBDb25zaWRlciBw
cm9iZSByZXR1cm4gLUVPUE5PVFNVUFAgYXMgc3VjY2Vzcwo+ICAgbW0vbnZkaW1tOiBBZGQgcGFn
ZSBzaXplIGFuZCBzdHJ1Y3QgcGFnZSBzaXplIHRvIHBmbiBzdXBlcmJsb2NrCj4gICBtbS9udmRp
bW06IFVzZSBjb3JyZWN0ICNkZWZpbmVzIGluc3RlYWQgb2Ygb3BlbiBjb2RpbmcKPiAgIG1tL252
ZGltbTogUGljayB0aGUgcmlnaHQgYWxpZ25tZW50IGRlZmF1bHQgd2hlbiBjcmVhdGluZyBkYXgg
ZGV2aWNlcwo+ICAgbW0vbnZkaW1tOiBVc2UgY29ycmVjdCBhbGlnbm1lbnQgd2hlbiBsb29raW5n
IGF0IGZpcnN0IHBmbiBmcm9tIGEKPiAgICAgcmVnaW9uCj4gICBtbS9udmRpbW06IEZpeCBlbmRp
YW4gY29udmVyc2lvbiBpc3N1ZXPCoAo+Cj4gIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9saWJu
dmRpbW0uaCB8ICA5ICsrKysKPiAgYXJjaC9wb3dlcnBjL21tL01ha2VmaWxlICAgICAgICAgICAg
IHwgIDEgKwo+ICBhcmNoL3Bvd2VycGMvbW0vbnZkaW1tLmMgICAgICAgICAgICAgfCAzNCArKysr
KysrKysrKysrKysKPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbGlibnZkaW1tLmggICAgIHwgMTkg
KysrKysrKysrCj4gIGRyaXZlcnMvbnZkaW1tL2J0dC5jICAgICAgICAgICAgICAgICB8ICA4ICsr
LS0KPiAgZHJpdmVycy9udmRpbW0vYnVzLmMgICAgICAgICAgICAgICAgIHwgIDQgKy0KPiAgZHJp
dmVycy9udmRpbW0vbGFiZWwuYyAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9udmRp
bW0vbmFtZXNwYWNlX2RldnMuYyAgICAgIHwgMTMgKysrLS0tCj4gIGRyaXZlcnMvbnZkaW1tL25k
LWNvcmUuaCAgICAgICAgICAgICB8ICAzICstCj4gIGRyaXZlcnMvbnZkaW1tL25kLmggICAgICAg
ICAgICAgICAgICB8ICA2IC0tLQo+ICBkcml2ZXJzL252ZGltbS9wZm4uaCAgICAgICAgICAgICAg
ICAgfCAgNSArKy0KPiAgZHJpdmVycy9udmRpbW0vcGZuX2RldnMuYyAgICAgICAgICAgIHwgNjIg
KysrKysrKysrKysrKysrKysrKysrKysrKystLQo+ICBkcml2ZXJzL252ZGltbS9wbWVtLmMgICAg
ICAgICAgICAgICAgfCAyNiArKysrKysrKysrLS0KPiAgZHJpdmVycy9udmRpbW0vcmVnaW9uX2Rl
dnMuYyAgICAgICAgIHwgMjcgKysrKysrKystLS0tCj4gIGluY2x1ZGUvbGludXgvaHVnZV9tbS5o
ICAgICAgICAgICAgICB8ICA3ICsrKy0KPiAga2VybmVsL21lbXJlbWFwLmMgICAgICAgICAgICAg
ICAgICAgIHwgIDggKystLQo+ICAxNiBmaWxlcyBjaGFuZ2VkLCAxOTQgaW5zZXJ0aW9ucygrKSwg
NDAgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbGlibnZkaW1tLmgKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcG93ZXJwYy9tbS9u
dmRpbW0uYwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvaW5jbHVkZS9hc20vbGlibnZk
aW1tLmgKPgo+IC0tIAo+IDIuMjEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlz
dHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZk
aW1tCg==
