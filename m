Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD0E2969D8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 08:39:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DA2E162DBE05;
	Thu, 22 Oct 2020 23:39:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 23678162DBE03
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 23:39:06 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09N6W2UJ089682;
	Fri, 23 Oct 2020 02:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=jSBqA2Xb3V1/Ng9IC6LYQAyTgeWhz3BE+u4Ec2ULnY8=;
 b=RIIbsnBZdhOxViKe35KEpsxpaWFN337S8ywDtrfjw/NPZy0YoaO+TEzRpbyU+TgszFl3
 c57LIw7yHyPdlc8SD/VerGAX3Tie4+kWSU/r0Jmz5oRVepVhygEglqd/lYZJx8Hf1dVO
 lA0QzJE2CJ4tbCCQblpda5Dm2jzBwlQv7uG6uu34mLQuLOW3YHmaAnccTbUjvMY1+Ixh
 NFYWtPRLCppvEUFMoeeuRDtWiMmUNNv7KVi7iuj5F8u6a787k87kS/iMpvDbkyZfVFNQ
 9iMtNnUmi3ASlE3l8S+1bnZ2UHZn1FxRwkK8m1fdXVkV2r5V+CgQ9YUTxJB0GW6oFwQS Ng==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34bseq0w5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2020 02:38:58 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09N6QehN016505;
	Fri, 23 Oct 2020 06:38:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 347r88e8wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2020 06:38:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09N6crUF33489394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2020 06:38:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2ECFA405C;
	Fri, 23 Oct 2020 06:38:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36999A4054;
	Fri, 23 Oct 2020 06:38:52 +0000 (GMT)
Received: from [9.85.95.180] (unknown [9.85.95.180])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2020 06:38:52 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
Date: Fri, 23 Oct 2020 12:08:51 +0530
Message-Id: <A6E29259-1EFD-4E6D-B72A-DA67A026040C@linux.vnet.ibm.com>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
 <20201022154124.GA537138@iweiny-DESK2.sc.intel.com>
 <d7540264-48f1-9fdc-0769-de68fdfc1c7b@nvidia.com>
To: Ralph Campbell <rcampbell@nvidia.com>
X-Mailer: Apple Mail (2.3445.104.17)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-23_03:2020-10-20,2020-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 mlxlogscore=932 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230044
Message-ID-Hash: JVIOZ4UVKUGWZFSGITNBVZ4KLTNSHGFV
X-Message-ID-Hash: JVIOZ4UVKUGWZFSGITNBVZ4KLTNSHGFV
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JVIOZ4UVKUGWZFSGITNBVZ4KLTNSHGFV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+PiBJcyBpdCBvdmVya2lsbCB0byBhdm9pZCBkdXBsaWNhdGluZyB0aGlzIHN3aXRjaCBsb2dp
YyBpbg0KPj4gcGFnZV9pc19kZXZtYXBfbWFuYWdlZCgpIGJ5IGNyZWF0aW5nIGFub3RoZXIgY2Fs
bCB3aGljaCBjYW4gYmUgdXNlZCBoZXJlPw0KPiANCj4gUGVyaGFwcy4gSSBjYW4gaW1hZ2luZSBh
IGhlbHBlciBkZWZpbmVkIGluIGluY2x1ZGUvbGludXgvbW0uaCB3aGljaA0KPiBwYWdlX2lzX2Rl
dm1hcF9tYW5hZ2VkKCkgY291bGQgYWxzbyBjYWxsIGJ1dCB0aGF0IHdvdWxkIGltcGFjdCBhIGxv
dCBvZg0KPiBwbGFjZXMgdGhhdCBpbmNsdWRlIG1tLmguIFNpbmNlIG1lbXJlbWFwLmMgYWxyZWFk
eSBoYXMgdG8gaGF2ZSBpbnRpbWF0ZQ0KPiBrbm93bGVkZ2Ugb2YgdGhlIHBnbWFwLT50eXBlLCBJ
IHRoaW5rIGxpbWl0aW5nIHRoZSBjaGFuZ2UgdG8ganVzdCB3aGF0DQo+IGlzIG5lZWRlZCBpcyBi
ZXR0ZXIgZm9yIG5vdy4gU28gdGhlIHBhdGNoIGxvb2tzIE9LIHRvIG1lLg0KPiANCj4gTG9va2lu
ZyBhdCB0aGlzIHNvbWUgbW9yZSwgSSB3b3VsZCBzdWdnZXN0IGNoYW5naW5nIGRldm1hcF9tYW5h
Z2VkX2VuYWJsZV9nZXQoKQ0KPiBhbmQgZGV2bWFwX21hbmFnZWRfZW5hYmxlX3B1dCgpIHRvIGRv
IHRoZSBzcGVjaWFsIGNhc2UgY2hlY2tpbmcgaW5zdGVhZCBvZg0KPiBkb2luZyBpdCBpbiBtZW1y
ZW1hcF9wYWdlcygpIGFuZCBtZW11bm1hcF9wYWdlcygpLg0KPiBUaGVuIGRldm1hcF9tYW5hZ2Vk
X2VuYWJsZV9nZXQoKSBkb2Vzbid0IG5lZWQgdG8gcmV0dXJuIGFuIGVycm9yIGlmDQo+IENPTkZJ
R19ERVZfUEFHRU1BUF9PUFMgaXNuJ3QgZGVmaW5lZC4gSSBoYXZlIG9ubHkgY29tcGlsZSB0ZXN0
ZWQgdGhlDQo+IGZvbGxvd2luZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxs
IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4NCj4g4oCUDQoNClRoaXMgcGF0Y2ggZml4ZXMgdGhlIHdh
cm5pbmcgZm9yIG1lLg0KDQpUZXN0ZWQtYnk6IFNhY2hpbiBTYW50IDxzYWNoaW5wQGxpbnV4LnZu
ZXQuaWJtLmNvbT4NCg0KLVNhY2hpbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
