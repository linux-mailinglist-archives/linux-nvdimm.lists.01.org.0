Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B182A1BC3DC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 17:40:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC90F1106B8AC;
	Tue, 28 Apr 2020 08:39:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D54541106B8AC
	for <linux-nvdimm@lists.01.org>; Tue, 28 Apr 2020 08:39:12 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFcjSa155813;
	Tue, 28 Apr 2020 15:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=dfXvM4xuNIeZaJFuK3qt5Sc+zWA9hEOGGKCO2odjOlY=;
 b=Qyi1DXhpYDb15soPsP+xFNjmBvH+QlXLmb2FA+WsRcY4d07OZOPz/2Kypv7HtI/zpmhr
 By2uzixHj+6ZgJiWW99kEjLGcLiS2hu1TISIxg6RuYesVDTd8NFg+K+TOL0CgNVptzXW
 PKTZOR/HU1xWAb0ctQ8+LX1X6pFYAn0pYlPfUTxYDMp5YdoXPh9vz1x/ZjSoVQWvy5AV
 Lg7ajSujOQkyVcBhlARH7gRr7l7qA5jB9Gs01AaPpjKrz4I3YGmpShh4Z+KbnanoTlKC
 A9eDlU05ZCQM+BJVV7iObWZJmybX/ZgYwHAT8yc/6f/2/rw6QElREC8AR5gCZkfywTD6 tg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 30nucg0rgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2020 15:39:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFahHn180974;
	Tue, 28 Apr 2020 15:37:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 30mxpga2ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2020 15:37:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFbYAT031620;
	Tue, 28 Apr 2020 15:37:35 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 28 Apr 2020 08:37:34 -0700
Date: Tue, 28 Apr 2020 08:37:32 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428153732.GZ6742@magnolia>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
 <20200428111636.GK29705@bombadil.infradead.org>
 <20200428112441.GH2040@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428112441.GH2040@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280122
Message-ID-Hash: NADF7GX2DJLMYYSRSNY26OCCWOENF7RZ
X-Message-ID-Hash: NADF7GX2DJLMYYSRSNY26OCCWOENF7RZ
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NADF7GX2DJLMYYSRSNY26OCCWOENF7RZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDk6MjQ6NDFQTSArMTAwMCwgRGF2ZSBDaGlubmVyIHdy
b3RlOg0KPiBPbiBUdWUsIEFwciAyOCwgMjAyMCBhdCAwNDoxNjozNkFNIC0wNzAwLCBNYXR0aGV3
IFdpbGNveCB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAyOCwgMjAyMCBhdCAwNTozMjo0MVBNICsw
ODAwLCBSdWFuIFNoaXlhbmcgd3JvdGU6DQo+ID4gPiBPbiAyMDIwLzQvMjgg5LiL5Y2IMjo0Mywg
RGF2ZSBDaGlubmVyIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEFwciAyOCwgMjAyMCBhdCAwNjow
OTo0N0FNICswMDAwLCBSdWFuLCBTaGl5YW5nIHdyb3RlOg0KPiA+ID4gPiA+IOWcqCAyMDIwLzQv
MjcgMjA6Mjg6MzYsICJNYXR0aGV3IFdpbGNveCIgPHdpbGx5QGluZnJhZGVhZC5vcmc+IOWGmemB
kzoNCj4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI3LCAyMDIwIGF0IDA0OjQ3OjQyUE0gKzA4MDAs
IFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gICBUaGlzIHBhdGNoc2V0IGlzIGEg
dHJ5IHRvIHJlc29sdmUgdGhlIHNoYXJlZCAncGFnZSBjYWNoZScgcHJvYmxlbSBmb3INCj4gPiA+
ID4gPiA+ID4gICBmc2RheC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICAgSW4gb3Jk
ZXIgdG8gdHJhY2sgbXVsdGlwbGUgbWFwcGluZ3MgYW5kIGluZGV4ZXMgb24gb25lIHBhZ2UsIEkN
Cj4gPiA+ID4gPiA+ID4gICBpbnRyb2R1Y2VkIGEgZGF4LXJtYXAgcmItdHJlZSB0byBtYW5hZ2Ug
dGhlIHJlbGF0aW9uc2hpcC4gIEEgZGF4IGVudHJ5DQo+ID4gPiA+ID4gPiA+ICAgd2lsbCBiZSBh
c3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJlZC4gIEF0IHRoZSBzZWNvbmQgdGlt
ZSB3ZQ0KPiA+ID4gPiA+ID4gPiAgIGFzc29jaWF0ZSB0aGlzIGVudHJ5LCB3ZSBjcmVhdGUgdGhp
cyByYi10cmVlIGFuZCBzdG9yZSBpdHMgcm9vdCBpbg0KPiA+ID4gPiA+ID4gPiAgIHBhZ2UtPnBy
aXZhdGUobm90IHVzZWQgaW4gZnNkYXgpLiAgSW5zZXJ0ICgtPm1hcHBpbmcsIC0+aW5kZXgpIHdo
ZW4NCj4gPiA+ID4gPiA+ID4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0ZSBpdCB3
aGVuIGRheF9kaXNhc3NvY2lhdGVfZW50cnkoKS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
RG8gd2UgcmVhbGx5IHdhbnQgdG8gdHJhY2sgYWxsIG9mIHRoaXMgb24gYSBwZXItcGFnZSBiYXNp
cz8gIEkgd291bGQNCj4gPiA+ID4gPiA+IGhhdmUgdGhvdWdodCBhIHBlci1leHRlbnQgYmFzaXMg
d2FzIG1vcmUgdXNlZnVsLiAgRXNzZW50aWFsbHksIGNyZWF0ZQ0KPiA+ID4gPiA+ID4gYSBuZXcg
YWRkcmVzc19zcGFjZSBmb3IgZWFjaCBzaGFyZWQgZXh0ZW50LiAgUGVyIHBhZ2UganVzdCBzZWVt
cyBsaWtlDQo+ID4gPiA+ID4gPiBhIGh1Z2Ugb3ZlcmhlYWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiBQZXItZXh0ZW50IHRyYWNraW5nIGlzIGEgbmljZSBpZGVhIGZvciBtZS4gIEkgaGF2ZW4n
dCB0aG91Z2h0IG9mIGl0DQo+ID4gPiA+ID4geWV0Li4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
QnV0IHRoZSBleHRlbnQgaW5mbyBpcyBtYWludGFpbmVkIGJ5IGZpbGVzeXN0ZW0uICBJIHRoaW5r
IHdlIG5lZWQgYSB3YXkNCj4gPiA+ID4gPiB0byBvYnRhaW4gdGhpcyBpbmZvIGZyb20gRlMgd2hl
biBhc3NvY2lhdGluZyBhIHBhZ2UuICBNYXkgYmUgYSBiaXQNCj4gPiA+ID4gPiBjb21wbGljYXRl
ZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCdzIHdo
eSBJIHdhbnQgdGhlIC11c2VyIG9mIHRoaXMgYXNzb2NpYXRpb24tIHRvIGRvIGEgZmlsZXN5c3Rl
bQ0KPiA+ID4gPiBjYWxsb3V0IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2ZSB0cmFj
a2luZyBpbmZyYXN0cnVjdHVyZS4NCj4gPiA+ID4gVGhlIGZpbGVzeXN0ZW0gY2FuIGRvIGFuIGVm
ZmljaWVudCwgb24tZGVtYW5kIHJldmVyc2UgbWFwcGluZyBsb29rdXANCj4gPiA+ID4gZnJvbSBp
dCdzIG93biBleHRlbnQgdHJhY2tpbmcgaW5mcmFzdHJ1Y3R1cmUsIGFuZCB0aGVyZSdzIHplcm8N
Cj4gPiA+ID4gcnVudGltZSBvdmVyaGVhZCB3aGVuIHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2Vu
dC4NCj4gPiA+ID4gDQo+ID4gPiA+IEF0IHRoZSBtb21lbnQsIHRoaXMgImRheCBhc3NvY2lhdGlv
biIgaXMgdXNlZCB0byAicmVwb3J0IiBhIHN0b3JhZ2UNCj4gPiA+ID4gbWVkaWEgZXJyb3IgZGly
ZWN0bHkgdG8gdXNlcnNwYWNlLiBJIHNheSAicmVwb3J0IiBiZWNhdXNlIHdoYXQgaXQNCj4gPiA+
ID4gZG9lcyBpcyBraWxsIHVzZXJzcGFjZSBwcm9jZXNzZXMgZGVhZC4gVGhlIHN0b3JhZ2UgbWVk
aWEgZXJyb3INCj4gPiA+ID4gYWN0dWFsbHkgbmVlZHMgdG8gYmUgcmVwb3J0ZWQgdG8gdGhlIG93
bmVyIG9mIHRoZSBzdG9yYWdlIG1lZGlhLA0KPiA+ID4gPiB3aGljaCBpbiB0aGUgY2FzZSBvZiBG
Uy1EQVggaXMgdGhlIGZpbGVzeXRlbS4NCj4gPiA+IA0KPiA+ID4gVW5kZXJzdG9vZC4NCj4gPiA+
IA0KPiA+ID4gQlRXLCB0aGlzIGlzIHRoZSB1c2FnZSBpbiBtZW1vcnktZmFpbHVyZSwgc28gd2hh
dCBhYm91dCBybWFwPyAgSSBoYXZlIG5vdA0KPiA+ID4gZm91bmQgaG93IHRvIHVzZSB0aGlzIHRy
YWNraW5nIGluIHJtYXAuICBEbyB5b3UgaGF2ZSBhbnkgaWRlYXM/DQo+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IFRoYXQgd2F5IHRoZSBmaWxlc3lzdGVtIGNhbiB0aGVuIGxvb2sgdXAgYWxsIHRo
ZSBvd25lcnMgb2YgdGhhdCBiYWQNCj4gPiA+ID4gbWVkaWEgcmFuZ2UgKGkuZS4gdGhlIGZpbGVz
eXN0ZW0gYmxvY2sgaXQgY29ycmVzcG9uZHMgdG8pIGFuZCB0YWtlDQo+ID4gPiA+IGFwcHJvcHJp
YXRlIGFjdGlvbi4gZS5nLg0KPiA+ID4gDQo+ID4gPiBJIHRyaWVkIHdyaXRpbmcgYSBmdW5jdGlv
biB0byBsb29rIHVwIGFsbCB0aGUgb3duZXJzJyBpbmZvIG9mIG9uZSBibG9jayBpbg0KPiA+ID4g
eGZzIGZvciBtZW1vcnktZmFpbHVyZSB1c2UuICBJdCB3YXMgZHJvcHBlZCBpbiB0aGlzIHBhdGNo
c2V0IGJlY2F1c2UgSSBmb3VuZA0KPiA+ID4gb3V0IHRoYXQgdGhpcyBsb29rdXAgZnVuY3Rpb24g
bmVlZHMgJ3JtYXBidCcgdG8gYmUgZW5hYmxlZCB3aGVuIG1rZnMuICBCdXQNCj4gPiA+IGJ5IGRl
ZmF1bHQsIHJtYXBidCBpcyBkaXNhYmxlZC4gIEkgYW0gbm90IHN1cmUgaWYgaXQgbWF0dGVycy4u
Lg0KPiA+IA0KPiA+IEknbSBwcmV0dHkgc3VyZSB5b3UgY2FuJ3QgaGF2ZSBzaGFyZWQgZXh0ZW50
cyBvbiBhbiBYRlMgZmlsZXN5c3RlbSBpZiB5b3UNCj4gPiBfZG9uJ3RfIGhhdmUgdGhlIHJtYXBi
dCBmZWF0dXJlIGVuYWJsZWQuICBJIG1lYW4sIHRoYXQncyB3aHkgaXQgZXhpc3RzLg0KPiANCj4g
WW91J3JlIGNvbmZ1c2luZyByZWZsaW5rIHdpdGggcm1hcC4gOikNCj4gDQo+IHJtYXBidCBkb2Vz
IGFsbCB0aGUgcmV2ZXJzZSBtYXBwaW5nIHRyYWNraW5nLCByZWZsaW5rIGp1c3QgZG9lcyB0aGUN
Cj4gc2hhcmVkIGRhdGEgZXh0ZW50IHRyYWNraW5nLg0KPiANCj4gQnV0IGdpdmVuIHRoYXQgYW55
b25lIHdobyB3YW50cyB0byB1c2UgREFYIHdpdGggcmVmbGluayBpcyBnb2luZyB0bw0KPiBoYXZl
IHRvIG1rZnMgdGhlaXIgZmlsZXN5c3RlbSBhbnl3YXkgKHRvIHR1cm4gb24gcmVmbGluaykgcmVx
dWlyaW5nDQo+IHRoYXQgcm1hcGJ0IGlzIGFsc28gdHVybmVkIG9uIGlzIG5vdCBhIGJpZyBkZWFs
LiBFc3BlY2lhbGx5IGFzIHdlDQo+IGNhbiBjaGVjayBpdCBhdCBtb3VudCB0aW1lIGluIHRoZSBr
ZXJuZWwuLi4NCg0KQXJlIHdlIGdvaW5nIHRvIHR1cm4gb24gcm1hcCBieSBkZWZhdWx0PyAgVGhl
IGxhc3QgSSBjaGVja2VkLCBpdCBkaWQNCmhhdmUgYSAxMC0yMCUgcGVyZm9ybWFuY2UgY29zdCBv
biBleHRyZW1lIG1ldGFkYXRhLWhlYXZ5IHdvcmtsb2Fkcy4NCk9yIGRvIHdlIG9ubHkgZW5hYmxl
IGl0IGJ5IGRlZmF1bHQgaWYgbWtmcyBkZXRlY3RzIGEgcG1lbSBkZXZpY2U/DQoNCihBZG1pdHRl
ZGx5LCBtb3N0IHBlb3BsZSBkbyBub3QgcnVuIGZzeCBhcyBhIHByb2R1Y3Rpdml0eSBhcHA7IHRo
ZQ0Kbm9ybWFsIGhpdCBpcyB1c3VhbGx5IDMtNSUgd2hpY2ggbWlnaHQgbm90IGJlIHN1Y2ggYSBi
aWcgZGVhbCBzaW5jZSB5b3UNCmFsc28gZ2V0IChoYWxmIG9mKSBvbmxpbmUgZnNjay4gOlApDQoN
Ci0tRA0KDQo+IENoZWVycywNCj4gDQo+IERhdmUuDQo+IC0tIA0KPiBEYXZlIENoaW5uZXINCj4g
ZGF2aWRAZnJvbW9yYml0LmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
