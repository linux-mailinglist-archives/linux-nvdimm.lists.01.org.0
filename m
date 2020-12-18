Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE92DDD68
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 04:49:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBFBB100EB851;
	Thu, 17 Dec 2020 19:49:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 96A63100EB327
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 19:49:30 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI3i0TM015386;
	Fri, 18 Dec 2020 03:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=LIwujB5reJPpKPd0TNJ4s00yRFeVMTgcLTo3JiXpJic=;
 b=LB/IHwsQbjaq0Bm2V6SUYRH59yiRsBVst/8PKZ7PZlHL/lBgsGbQN/1uC2Bav0O7+S4s
 hHC/e2c9bWlsQsvyTn1T83Ykdpq4E1aBZjroluXAiN/mblg94hgM1GtcsyawhGCp1iYj
 IsZIaTfX6bJC7Eqr1a3e/Viesx9qnb8otkChHKwWENKTYnpdDo1BWfEJrYncWMTUSu1E
 bx6DO6CceKpWYaILCZ/FuDBb79WF3hI47xEKDC2OpmSAiZTeoxXWwFFYfrsbprALpBYG
 RVVjKXals9/03C2h4kty5eWhAui1zELwe4VqEkBdO+rQXTTdpd7MloRSrW7+6gthCoNw Bg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2120.oracle.com with ESMTP id 35cntmgf70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Dec 2020 03:49:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI3jJO8147213;
	Fri, 18 Dec 2020 03:49:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 35g3rfkd11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Dec 2020 03:49:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BI3n95J022125;
	Fri, 18 Dec 2020 03:49:09 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 19:49:09 -0800
Date: Thu, 17 Dec 2020 19:49:07 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
Message-ID: <20201218034907.GG6918@magnolia>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180025
Message-ID-Hash: BQGBQ5WUTFHJUVQJTORYVR2QN6RLITL2
X-Message-ID-Hash: BQGBQ5WUTFHJUVQJTORYVR2QN6RLITL2
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BQGBQ5WUTFHJUVQJTORYVR2QN6RLITL2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMTA6NDQ6MjZBTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDIwMjAvMTIvMTcg5LiK5Y2INDo1NSwgSmFuZSBDaHUgd3JvdGU6
DQo+ID4gSGksIFNoaXlhbmcsDQo+ID4gDQo+ID4gT24gMTIvMTUvMjAyMCA0OjE0IEFNLCBTaGl5
YW5nIFJ1YW4gd3JvdGU6DQo+ID4gPiBUaGUgY2FsbCB0cmFjZSBpcyBsaWtlIHRoaXM6DQo+ID4g
PiBtZW1vcnlfZmFpbHVyZSgpDQo+ID4gPiDCoCBwZ21hcC0+b3BzLT5tZW1vcnlfZmFpbHVyZSgp
wqDCoMKgwqDCoCA9PiBwbWVtX3BnbWFwX21lbW9yeV9mYWlsdXJlKCkNCj4gPiA+IMKgwqAgZ2Vu
ZGlzay0+Zm9wcy0+Y29ycnVwdGVkX3JhbmdlKCkgPT4gLSBwbWVtX2NvcnJ1cHRlZF9yYW5nZSgp
DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gbWRfYmxrX2NvcnJ1cHRlZF9yYW5nZSgpDQo+
ID4gPiDCoMKgwqAgc2ItPnNfb3BzLT5jdXJydXB0ZWRfcmFuZ2UoKcKgwqDCoCA9PiB4ZnNfZnNf
Y29ycnVwdGVkX3JhbmdlKCkNCj4gPiA+IMKgwqDCoMKgIHhmc19ybWFwX3F1ZXJ5X3JhbmdlKCkN
Cj4gPiA+IMKgwqDCoMKgwqAgeGZzX2N1cnJ1cHRfaGVscGVyKCkNCj4gPiA+IMKgwqDCoMKgwqDC
oCAqIGNvcnJ1cHRlZCBvbiBtZXRhZGF0YQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ5
IHRvIHJlY292ZXIgZGF0YSwgY2FsbCB4ZnNfZm9yY2Vfc2h1dGRvd24oKQ0KPiA+ID4gwqDCoMKg
wqDCoMKgICogY29ycnVwdGVkIG9uIGZpbGUgZGF0YQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHJ5IHRvIHJlY292ZXIgZGF0YSwgY2FsbCBtZl9kYXhfbWFwcGluZ19raWxsX3Byb2NzKCkN
Cj4gPiA+IA0KPiA+ID4gVGhlIGZzZGF4ICYgcmVmbGluayBzdXBwb3J0IGZvciBYRlMgaXMgbm90
IGNvbnRhaW5lZCBpbiB0aGlzIHBhdGNoc2V0Lg0KPiA+ID4gDQo+ID4gPiAoUmViYXNlZCBvbiB2
NS4xMCkNCj4gPiANCj4gPiBTbyBJIHRyaWVkIHRoZSBwYXRjaHNldCB3aXRoIHBtZW0gZXJyb3Ig
aW5qZWN0aW9uLCB0aGUgU0lHQlVTIHBheWxvYWQNCj4gPiBkb2VzIG5vdCBsb29rIHJpZ2h0IC0N
Cj4gPiANCj4gPiAqKiBTSUdCVVMoNyk6ICoqDQo+ID4gKiogc2lfYWRkcigweChuaWwpKSwgc2lf
bHNiKDB4QyksIHNpX2NvZGUoMHg0LCBCVVNfTUNFRVJSX0FSKSAqKg0KPiA+IA0KPiA+IEkgZXhw
ZWN0IHRoZSBwYXlsb2FkIGxvb2tzIGxpa2UNCj4gPiANCj4gPiAqKiBzaV9hZGRyKDB4N2YzNjcy
ZTAwMDAwKSwgc2lfbHNiKDB4MTUpLCBzaV9jb2RlKDB4NCwgQlVTX01DRUVSUl9BUikgKioNCj4g
DQo+IFRoYW5rcyBmb3IgdGVzdGluZy4gIEkgdGVzdCB0aGUgU0lHQlVTIGJ5IHdyaXRpbmcgYSBw
cm9ncmFtIHdoaWNoIGNhbGxzDQo+IG1hZHZpc2UoLi4uICxNQURWX0hXUE9JU09OKSB0byBpbmpl
Y3QgbWVtb3J5LWZhaWx1cmUuICBJdCBqdXN0IHNob3dzIHRoYXQNCj4gdGhlIHByb2dyYW0gaXMg
a2lsbGVkIGJ5IFNJR0JVUy4gIEkgY2Fubm90IGdldCBhbnkgZGV0YWlsIGZyb20gaXQuICBTbywN
Cj4gY291bGQgeW91IHBsZWFzZSBzaG93IG1lIHRoZSByaWdodCB3YXkodGVzdCB0b29scykgdG8g
dGVzdCBpdD8NCg0KSSdtIGFzc3VtaW5nIHRoYXQgSmFuZSBpcyB1c2luZyBhIHByb2dyYW0gdGhh
dCBjYWxscyBzaWdhY3Rpb24gdG8NCmluc3RhbGwgYSBTSUdCVVMgaGFuZGxlciwgYW5kIGR1bXBz
IHRoZSBlbnRpcmUgc2lnaW5mb190IHN0cnVjdHVyZQ0Kd2hlbmV2ZXIgaXQgcmVjZWl2ZXMgb25l
Li4uDQoNCi0tRA0KDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IFJ1YW4gU2hpeWFuZy4NCj4gDQo+
ID4gDQo+ID4gdGhhbmtzLA0KPiA+IC1qYW5lDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4g
DQo+ID4gDQo+IA0KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
