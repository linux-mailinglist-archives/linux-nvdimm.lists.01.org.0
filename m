Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F7295A68
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Oct 2020 10:35:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA4671619E7E3;
	Thu, 22 Oct 2020 01:35:01 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DFF21619E7E2
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 01:34:45 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09M8XQOt084075;
	Thu, 22 Oct 2020 04:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=GQZYt0DQyzHG6Sxy2k2U59i5y3PI30cW7y6OKLNMUYY=;
 b=IoPII3dyPpxUnJvq8TVigwiNVzFjFaQXDon0bgwcMv90QsOMVNmnBofqkJunUH+MYS9U
 DDlIfSnDopRlv8E3Vn9j6wMdS/I7owKcHsfRUWNlk98XI9wsIjyou39J/aueQGJssrCA
 fNTqtuYn4tpEeIFgm2AI2cqaDY4DwN2DKZt2MVOrQf1VmeG98L46+FfHLeBNXhAYhLOl
 u/2Gm+Aj8hbj+GznUt2htcA20tlf02ilaKghQ68WIuB1w7GKh3TfjtKv30t7crB6FtYN
 P32NlwvdIzK1ZUxM6a0fe+9AFpmZaylDv2UvltdUtGarP0I0oxY8/vPfMOvULDR4X+h4 nA==
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34b0wj0tub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2020 04:34:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
	by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09M8WETC010627;
	Thu, 22 Oct 2020 08:34:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma01fra.de.ibm.com with ESMTP id 347r882q2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2020 08:34:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09M8YVjd26935724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2020 08:34:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73A744204F;
	Thu, 22 Oct 2020 08:34:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A10142047;
	Thu, 22 Oct 2020 08:34:30 +0000 (GMT)
Received: from [9.102.2.245] (unknown [9.102.2.245])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2020 08:34:29 +0000 (GMT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
Date: Thu, 22 Oct 2020 14:04:24 +0530
Message-Id: <7317954B-41A5-47D0-93ED-17A06630DFD7@linux.vnet.ibm.com>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.17)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_02:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220057
Message-ID-Hash: PAJOWWYO4LYHYSPJWH5VSQS5EIY5QR2M
X-Message-ID-Hash: PAJOWWYO4LYHYSPJWH5VSQS5EIY5QR2M
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PAJOWWYO4LYHYSPJWH5VSQS5EIY5QR2M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IGp1bXAgbGFiZWw6IG5lZ2F0aXZlIGNvdW50IQ0KPiBXQVJOSU5HOiBDUFU6IDUyIFBJRDog
MTMzNSBhdCBrZXJuZWwvanVtcF9sYWJlbC5jOjIzNSBzdGF0aWNfa2V5X3Nsb3dfdHJ5X2RlYysw
eDg4LzB4YTANCj4gTW9kdWxlcyBsaW5rZWQgaW46DQo+IOKApi4NCj4gDQoNCj4gQ2M6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDYzogU2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXgu
dm5ldC5pYm0uY29tPg0KPiBDYzogbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZw0KPiBDYzogSXJh
IFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dA
bWVsbGFub3guY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gu
a3VtYXJAbGludXguaWJtLmNvbT4NCj4g4oCUDQoNClRlc3RlZC1ieTogU2FjaGluIFNhbnQgPHNh
Y2hpbnBAbGludXgudm5ldC5pYm0uY29tPg0KDQotU2FjaGluDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0t
IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0
byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
