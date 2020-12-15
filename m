Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9C2DB437
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 20:05:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B1AF100EBB75;
	Tue, 15 Dec 2020 11:05:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 418ED100EBB74
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 11:05:28 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJ05Nn166879;
	Tue, 15 Dec 2020 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rPaA1lXHtSIrJnQXSfEHzf/QB0dDoI9KLHNNF9d2vyk=;
 b=XxG8yezhuwhvdL/NoipNesCnm3sm5cjA8YlgvbvW1HHxEITZTP0ZyhE82MIDP+GN9/5j
 /UZJZ7hWT3uni1b4nkheEECeEBHEr1L2SnshTtQVU/iqLCgyI7D+ORP5ghWepy3TfEgC
 0m6V/K1enEiivJ1Jiiiq2UvfS1meyUKLdtShxrbkD0aSPeyF2GLlG0llWmfavR8YciAQ
 ar+LEZmRhmWrMOrGwGdcmluYiQ74ngB7eLg1+QbsEWoR4Hl88lMeQ9Zgq5zyTg3P69Ti
 /1zZpwj5XBbTcCQjYQY80V+mav+tk0T+ALeAhgWPt2AA+kYasicfoyT8hMUB07BJOemq 7g==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 35ckcbcgye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Dec 2020 19:05:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJ1C3e048331;
	Tue, 15 Dec 2020 19:05:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 35d7enf2hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Dec 2020 19:05:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFJ5AuJ024299;
	Tue, 15 Dec 2020 19:05:10 GMT
Received: from [10.159.136.92] (/10.159.136.92)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 15 Dec 2020 11:05:09 -0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
Date: Tue, 15 Dec 2020 11:05:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150126
Message-ID-Hash: SEIBRBCCNGBKMRKNKVEY4NMKSAEAMKU5
X-Message-ID-Hash: SEIBRBCCNGBKMRKNKVEY4NMKSAEAMKU5
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SEIBRBCCNGBKMRKNKVEY4NMKSAEAMKU5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTIvMTUvMjAyMCAzOjU4IEFNLCBSdWFuIFNoaXlhbmcgd3JvdGU6DQo+IEhpIEphbmUNCj4g
DQo+IE9uIDIwMjAvMTIvMTUg5LiK5Y2INDo1OCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBIaSwgU2hp
eWFuZywNCj4+DQo+PiBPbiAxMS8yMi8yMDIwIDQ6NDEgUE0sIFNoaXlhbmcgUnVhbiB3cm90ZToN
Cj4+PiBUaGlzIHBhdGNoc2V0IGlzIGEgdHJ5IHRvIHJlc29sdmUgdGhlIHByb2JsZW0gb2YgdHJh
Y2tpbmcgc2hhcmVkIHBhZ2UNCj4+PiBmb3IgZnNkYXguDQo+Pj4NCj4+PiBDaGFuZ2UgZnJvbSB2
MToNCj4+PiDCoMKgIC0gSW50b3JkdWNlIC0+YmxvY2tfbG9zdCgpIGZvciBibG9jayBkZXZpY2UN
Cj4+PiDCoMKgIC0gU3VwcG9ydCBtYXBwZWQgZGV2aWNlDQo+Pj4gwqDCoCAtIEFkZCAnbm90IGF2
YWlsYWJsZScgd2FybmluZyBmb3IgcmVhbHRpbWUgZGV2aWNlIGluIFhGUw0KPj4+IMKgwqAgLSBS
ZWJhc2VkIHRvIHY1LjEwLXJjMQ0KPj4+DQo+Pj4gVGhpcyBwYXRjaHNldCBtb3ZlcyBvd25lciB0
cmFja2luZyBmcm9tIGRheF9hc3NvY2FpdGVfZW50cnkoKSB0byBwbWVtDQo+Pj4gZGV2aWNlLCBi
eSBpbnRyb2R1Y2luZyBhbiBpbnRlcmZhY2UgLT5tZW1vcnlfZmFpbHVyZSgpIG9mIHN0cnVjdA0K
Pj4+IHBhZ2VtYXAuwqAgVGhlIGludGVyZmFjZSBpcyBjYWxsZWQgYnkgbWVtb3J5X2ZhaWx1cmUo
KSBpbiBtbSwgYW5kDQo+Pj4gaW1wbGVtZW50ZWQgYnkgcG1lbSBkZXZpY2UuwqAgVGhlbiBwbWVt
IGRldmljZSBjYWxscyBpdHMgLT5ibG9ja19sb3N0KCkNCj4+PiB0byBmaW5kIHRoZSBmaWxlc3lz
dGVtIHdoaWNoIHRoZSBkYW1hZ2VkIHBhZ2UgbG9jYXRlZCBpbiwgYW5kIGNhbGwNCj4+PiAtPnN0
b3JhZ2VfbG9zdCgpIHRvIHRyYWNrIGZpbGVzIG9yIG1ldGFkYXRhIGFzc29jYWl0ZWQgd2l0aCB0
aGlzIHBhZ2UuDQo+Pj4gRmluYWxseSB3ZSBhcmUgYWJsZSB0byB0cnkgdG8gZml4IHRoZSBkYW1h
Z2VkIGRhdGEgaW4gZmlsZXN5c3RlbSBhbmQgZG8NCj4+DQo+PiBEb2VzIHRoYXQgbWVhbiBjbGVh
cmluZyBwb2lzb24/IGlmIHNvLCB3b3VsZCB5b3UgbWluZCB0byBlbGFib3JhdGUgDQo+PiBzcGVj
aWZpY2FsbHkgd2hpY2ggY2hhbmdlIGRvZXMgdGhhdD8NCj4gDQo+IFJlY292ZXJpbmcgZGF0YSBm
b3IgZmlsZXN5c3RlbSAob3IgcG1lbSBkZXZpY2UpIGhhcyBub3QgYmVlbiBkb25lIGluIA0KPiB0
aGlzIHBhdGNoc2V0Li4uwqAgSSBqdXN0IHRyaWdnZXJlZCB0aGUgaGFuZGxlciBmb3IgdGhlIGZp
bGVzIHNoYXJpbmcgdGhlIA0KPiBjb3JydXB0ZWQgcGFnZSBoZXJlLg0KDQpUaGFua3MhIFRoYXQg
Y29uZmlybXMgbXkgdW5kZXJzdGFuZGluZy4NCg0KV2l0aCB0aGUgZnJhbWV3b3JrIHByb3ZpZGVk
IGJ5IHRoZSBwYXRjaHNldCwgaG93IGRvIHlvdSBlbnZpc2lvbiBpdCB0bw0KZWFzZS9zaW1wbGlm
eSBwb2lzb24gcmVjb3ZlcnkgZnJvbSB0aGUgdXNlcidzIHBlcnNwZWN0aXZlPw0KDQpBbmQgaG93
IGRvZXMgaXQgaGVscCBpbiBkZWFsaW5nIHdpdGggcGFnZSBmYXVsdHMgdXBvbiBwb2lzb25lZA0K
ZGF4IHBhZ2U/DQoNCnRoYW5rcyENCi1qYW5lDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
