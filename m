Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291D1EE6F1
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 16:51:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7DFB100A3033;
	Thu,  4 Jun 2020 07:46:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 696DC100A302E
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 07:46:31 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054EmRN1006694;
	Thu, 4 Jun 2020 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=yZ/+ZJnzGnmR7xhhJsmwnbo92NBRhvNckmqD86Sq/yw=;
 b=Y3gp9V2VSFZ5CQzf0bwJEoNtW2VsYWuDv10PHG4vOY9tJtXkCuZY0UNWqXph/Ymwlm+m
 VTK+37yFHeqNgd7lXN81KtlfGdj5Fnj5JT9SSD4VAx+quVwNrrplZAvnX1QTPNpyCYhc
 uEKm48/mrUCaq3oeFnxYZVz8JehshmL+Lta/nYK2AYVt9TqaH5t0m66cWXFdkTy0YX2k
 4mJAkH0Xhqgdv4qBoIMWyIV9hxaj6y7J7x5cl/KL3P48WOnCRnXPLH0LHukU2X5+Ohqg
 vFXpSG/9HMgYO9PjeGzLCcJ00CrnGJSXf/UamHDxXpzqFNUg1f7TpgpHwdV9jQrbqNOq Sg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 31evvn1ygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 04 Jun 2020 14:51:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054Em3vE111522;
	Thu, 4 Jun 2020 14:51:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 31c25vffjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jun 2020 14:51:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054Ep9Dr003969;
	Thu, 4 Jun 2020 14:51:09 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 04 Jun 2020 07:51:09 -0700
Date: Thu, 4 Jun 2020 07:51:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200604145107.GA1334206@magnolia>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=1
 phishscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040102
Message-ID-Hash: XNXPAXSJWAH4IUOTWJJOTDSFJPNODQB6
X-Message-ID-Hash: XNXPAXSJWAH4IUOTWJJOTDSFJPNODQB6
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XNXPAXSJWAH4IUOTWJJOTDSFJPNODQB6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBKdW4gMDQsIDIwMjAgYXQgMDM6Mzc6NDJQTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDIwMjAvNC8yOCDkuIvljYgyOjQzLCBEYXZlIENoaW5uZXIgd3Jv
dGU6DQo+ID4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDY6MDk6NDdBTSArMDAwMCwgUnVhbiwg
U2hpeWFuZyB3cm90ZToNCj4gPiA+IA0KPiA+ID4g5ZyoIDIwMjAvNC8yNyAyMDoyODozNiwgIk1h
dHRoZXcgV2lsY294IiA8d2lsbHlAaW5mcmFkZWFkLm9yZz4g5YaZ6YGTOg0KPiA+ID4gDQo+ID4g
PiA+IE9uIE1vbiwgQXByIDI3LCAyMDIwIGF0IDA0OjQ3OjQyUE0gKzA4MDAsIFNoaXlhbmcgUnVh
biB3cm90ZToNCj4gPiA+ID4gPiAgIFRoaXMgcGF0Y2hzZXQgaXMgYSB0cnkgdG8gcmVzb2x2ZSB0
aGUgc2hhcmVkICdwYWdlIGNhY2hlJyBwcm9ibGVtIGZvcg0KPiA+ID4gPiA+ICAgZnNkYXguDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gICBJbiBvcmRlciB0byB0cmFjayBtdWx0aXBsZSBtYXBwaW5n
cyBhbmQgaW5kZXhlcyBvbiBvbmUgcGFnZSwgSQ0KPiA+ID4gPiA+ICAgaW50cm9kdWNlZCBhIGRh
eC1ybWFwIHJiLXRyZWUgdG8gbWFuYWdlIHRoZSByZWxhdGlvbnNoaXAuICBBIGRheCBlbnRyeQ0K
PiA+ID4gPiA+ICAgd2lsbCBiZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJl
ZC4gIEF0IHRoZSBzZWNvbmQgdGltZSB3ZQ0KPiA+ID4gPiA+ICAgYXNzb2NpYXRlIHRoaXMgZW50
cnksIHdlIGNyZWF0ZSB0aGlzIHJiLXRyZWUgYW5kIHN0b3JlIGl0cyByb290IGluDQo+ID4gPiA+
ID4gICBwYWdlLT5wcml2YXRlKG5vdCB1c2VkIGluIGZzZGF4KS4gIEluc2VydCAoLT5tYXBwaW5n
LCAtPmluZGV4KSB3aGVuDQo+ID4gPiA+ID4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRl
bGV0ZSBpdCB3aGVuIGRheF9kaXNhc3NvY2lhdGVfZW50cnkoKS4NCj4gPiA+ID4gDQo+ID4gPiA+
IERvIHdlIHJlYWxseSB3YW50IHRvIHRyYWNrIGFsbCBvZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFz
aXM/ICBJIHdvdWxkDQo+ID4gPiA+IGhhdmUgdGhvdWdodCBhIHBlci1leHRlbnQgYmFzaXMgd2Fz
IG1vcmUgdXNlZnVsLiAgRXNzZW50aWFsbHksIGNyZWF0ZQ0KPiA+ID4gPiBhIG5ldyBhZGRyZXNz
X3NwYWNlIGZvciBlYWNoIHNoYXJlZCBleHRlbnQuICBQZXIgcGFnZSBqdXN0IHNlZW1zIGxpa2UN
Cj4gPiA+ID4gYSBodWdlIG92ZXJoZWFkLg0KPiA+ID4gPiANCj4gPiA+IFBlci1leHRlbnQgdHJh
Y2tpbmcgaXMgYSBuaWNlIGlkZWEgZm9yIG1lLiAgSSBoYXZlbid0IHRob3VnaHQgb2YgaXQNCj4g
PiA+IHlldC4uLg0KPiA+ID4gDQo+ID4gPiBCdXQgdGhlIGV4dGVudCBpbmZvIGlzIG1haW50YWlu
ZWQgYnkgZmlsZXN5c3RlbS4gIEkgdGhpbmsgd2UgbmVlZCBhIHdheQ0KPiA+ID4gdG8gb2J0YWlu
IHRoaXMgaW5mbyBmcm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0
DQo+ID4gPiBjb21wbGljYXRlZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiA+IA0KPiA+
IFRoYXQncyB3aHkgSSB3YW50IHRoZSAtdXNlciBvZiB0aGlzIGFzc29jaWF0aW9uLSB0byBkbyBh
IGZpbGVzeXN0ZW0NCj4gPiBjYWxsb3V0IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2
ZSB0cmFja2luZyBpbmZyYXN0cnVjdHVyZS4NCj4gPiBUaGUgZmlsZXN5c3RlbSBjYW4gZG8gYW4g
ZWZmaWNpZW50LCBvbi1kZW1hbmQgcmV2ZXJzZSBtYXBwaW5nIGxvb2t1cA0KPiA+IGZyb20gaXQn
cyBvd24gZXh0ZW50IHRyYWNraW5nIGluZnJhc3RydWN0dXJlLCBhbmQgdGhlcmUncyB6ZXJvDQo+
ID4gcnVudGltZSBvdmVyaGVhZCB3aGVuIHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2VudC4NCj4g
DQo+IEhpIERhdmUsDQo+IA0KPiBJIHJhbiBpbnRvIHNvbWUgZGlmZmljdWx0aWVzIHdoZW4gdHJ5
aW5nIHRvIGltcGxlbWVudCB0aGUgcGVyLWV4dGVudCBybWFwDQo+IHRyYWNraW5nLiAgU28sIEkg
cmUtcmVhZCB5b3VyIGNvbW1lbnRzIGFuZCBmb3VuZCB0aGF0IEkgd2FzIG1pc3VuZGVyc3RhbmRp
bmcNCj4gd2hhdCB5b3UgZGVzY3JpYmVkIGhlcmUuDQo+IA0KPiBJIHRoaW5rIHdoYXQgeW91IG1l
YW4gaXM6IHdlIGRvbid0IG5lZWQgdGhlIGluLW1lbW9yeSBkYXgtcm1hcCB0cmFja2luZyBub3cu
DQo+IEp1c3QgYXNrIHRoZSBGUyBmb3IgdGhlIG93bmVyJ3MgaW5mb3JtYXRpb24gdGhhdCBhc3Nv
Y2lhdGUgd2l0aCBvbmUgcGFnZQ0KPiB3aGVuIG1lbW9yeS1mYWlsdXJlLiAgU28sIHRoZSBwZXIt
cGFnZSAoZXZlbiBwZXItZXh0ZW50KSBkYXgtcm1hcCBpcw0KPiBuZWVkbGVzcyBpbiB0aGlzIGNh
c2UuICBJcyB0aGlzIHJpZ2h0Pw0KDQpSaWdodC4gIFhGUyBhbHJlYWR5IGhhcyBpdHMgb3duIHJt
YXAgdHJlZS4NCg0KPiBCYXNlZCBvbiB0aGlzLCB3ZSBvbmx5IG5lZWQgdG8gc3RvcmUgdGhlIGV4
dGVudCBpbmZvcm1hdGlvbiBvZiBhIGZzZGF4IHBhZ2UNCj4gaW4gaXRzIC0+bWFwcGluZyAoYnkg
c2VhcmNoaW5nIGZyb20gRlMpLiAgVGhlbiBvYnRhaW4gdGhlIG93bmVycyBvZiB0aGlzDQo+IHBh
Z2UgKGFsc28gYnkgc2VhcmNoaW5nIGZyb20gRlMpIHdoZW4gbWVtb3J5LWZhaWx1cmUgb3Igb3Ro
ZXIgcm1hcCBjYXNlDQo+IG9jY3Vycy4NCg0KSSBkb24ndCBldmVuIHRoaW5rIHlvdSBuZWVkIHRo
YXQgbXVjaC4gIEFsbCB5b3UgbmVlZCBpcyB0aGUgInBoeXNpY2FsIg0Kb2Zmc2V0IG9mIHRoYXQg
cGFnZSB3aXRoaW4gdGhlIHBtZW0gZGV2aWNlIChlLmcuICd0aGlzIGlzIHRoZSAzMDd0aCA0aw0K
cGFnZSA9PSBvZmZzZXQgMTI1NzQ3MiBzaW5jZSB0aGUgc3RhcnQgb2YgL2Rldi9wbWVtMCcpIGFu
ZCB4ZnMgY2FuIGxvb2sNCnVwIHRoZSBvd25lciBvZiB0aGF0IHJhbmdlIG9mIHBoeXNpY2FsIHN0
b3JhZ2UgYW5kIGRlYWwgd2l0aCBpdCBhcw0KbmVlZGVkLg0KDQo+IFNvLCBhIGZzZGF4IHBhZ2Ug
aXMgbm8gbG9uZ2VyIGFzc29jaWF0ZWQgd2l0aCBhIHNwZWNpZmljIGZpbGUsIGJ1dCB3aXRoIGEN
Cj4gRlMob3IgdGhlIHBtZW0gZGV2aWNlKS4gIEkgdGhpbmsgaXQncyBlYXNpZXIgdG8gdW5kZXJz
dGFuZCBhbmQgaW1wbGVtZW50Lg0KDQpZZXMuICBJIGFsc28gc3VzcGVjdCB0aGlzIHdpbGwgYmUg
bmVjZXNzYXJ5IHRvIHN1cHBvcnQgcmVmbGluay4uLg0KDQotLUQNCg0KPiANCj4gLS0NCj4gVGhh
bmtzLA0KPiBSdWFuIFNoaXlhbmcuDQo+ID4gDQo+ID4gQXQgdGhlIG1vbWVudCwgdGhpcyAiZGF4
IGFzc29jaWF0aW9uIiBpcyB1c2VkIHRvICJyZXBvcnQiIGEgc3RvcmFnZQ0KPiA+IG1lZGlhIGVy
cm9yIGRpcmVjdGx5IHRvIHVzZXJzcGFjZS4gSSBzYXkgInJlcG9ydCIgYmVjYXVzZSB3aGF0IGl0
DQo+ID4gZG9lcyBpcyBraWxsIHVzZXJzcGFjZSBwcm9jZXNzZXMgZGVhZC4gVGhlIHN0b3JhZ2Ug
bWVkaWEgZXJyb3INCj4gPiBhY3R1YWxseSBuZWVkcyB0byBiZSByZXBvcnRlZCB0byB0aGUgb3du
ZXIgb2YgdGhlIHN0b3JhZ2UgbWVkaWEsDQo+ID4gd2hpY2ggaW4gdGhlIGNhc2Ugb2YgRlMtREFY
IGlzIHRoZSBmaWxlc3l0ZW0uDQo+ID4gDQo+ID4gVGhhdCB3YXkgdGhlIGZpbGVzeXN0ZW0gY2Fu
IHRoZW4gbG9vayB1cCBhbGwgdGhlIG93bmVycyBvZiB0aGF0IGJhZA0KPiA+IG1lZGlhIHJhbmdl
IChpLmUuIHRoZSBmaWxlc3lzdGVtIGJsb2NrIGl0IGNvcnJlc3BvbmRzIHRvKSBhbmQgdGFrZQ0K
PiA+IGFwcHJvcHJpYXRlIGFjdGlvbi4gZS5nLg0KPiA+IA0KPiA+IC0gaWYgaXQgZmFsbHMgaW4g
ZmlsZXN5dGVtIG1ldGFkYXRhLCBzaHV0ZG93biB0aGUgZmlsZXN5c3RlbQ0KPiA+IC0gaWYgaXQg
ZmFsbHMgaW4gdXNlciBkYXRhLCBjYWxsIHRoZSAia2lsbCB1c2Vyc3BhY2UgZGVhZCIgcm91dGlu
ZXMNCj4gPiAgICBmb3IgZWFjaCBtYXBwaW5nL2luZGV4IHR1cGxlIHRoZSBmaWxlc3lzdGVtIGZp
bmRzIGZvciB0aGUgZ2l2ZW4NCj4gPiAgICBMQkEgYWRkcmVzcyB0aGF0IHRoZSBtZWRpYSBlcnJv
ciBvY2N1cnJlZC4NCj4gPiANCj4gPiBSaWdodCBub3cgaWYgdGhlIG1lZGlhIGVycm9yIGlzIGlu
IGZpbGVzeXN0ZW0gbWV0YWRhdGEsIHRoZQ0KPiA+IGZpbGVzeXN0ZW0gaXNuJ3QgZXZlbiB0b2xk
IGFib3V0IGl0LiBUaGUgZmlsZXN5c3RlbSBjYW4ndCBldmVuIHNodXQNCj4gPiBkb3duIC0gdGhl
IGVycm9yIGlzIGp1c3QgZHJvcHBlZCBvbiB0aGUgZmxvb3IgYW5kIGl0IHdvbid0IGJlIHVudGls
DQo+ID4gdGhlIGZpbGVzeXN0ZW0gbmV4dCB0cmllcyB0byByZWZlcmVuY2UgdGhhdCBtZXRhZGF0
YSB0aGF0IHdlIG5vdGljZQ0KPiA+IHRoZXJlIGlzIGFuIGlzc3VlLg0KPiA+IA0KPiA+IENoZWVy
cywNCj4gPiANCj4gPiBEYXZlLg0KPiA+IA0KPiANCj4gCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
bnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
