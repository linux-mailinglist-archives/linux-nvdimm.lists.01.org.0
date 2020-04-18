Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E81AF577
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 00:36:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C034F10FC62FB;
	Sat, 18 Apr 2020 15:36:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=chuck.lever@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C54EE10FC62FA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 15:36:30 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IMWJax025251;
	Sat, 18 Apr 2020 22:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zK4gJmDAQjm6odpqw+dWgt3X8Z8VkPHJX9eb1aKLC5g=;
 b=x2TF6WJw26JFS9DnzG1jjX7fP7mK0Gmueyj0VEUPz5H83bvjFEEwlne4gN+tk9eBscUm
 90ro37TBLrsx8aoPw+tGrpex6qPRAvhSHvbeBXswEwzL2kVQ3pz78kuJncF1HNoWMT2j
 QRoWUa/r0eaCnaztQlQ4n8h/igTGoktprS0Lj0IKrdFzvtpr1o3bwUEpjem5uQioamKj
 82bJVWqQoP+zfd1SQ+rPmWEF1NJGwV8Sey/KtKrs2TWKmazxhP9idWtuAFq86C+upl5u
 lJ2ZrAZYW+xzqm4vONNeX03aSz20xUVcvYXQ9z+0XJHfCyxQGRNSSE1mtNbDXfldBK+t HA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 30fsgkj1d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2020 22:35:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IMXRJG022075;
	Sat, 18 Apr 2020 22:33:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 30fqkadq8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2020 22:33:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03IMXbL4005563;
	Sat, 18 Apr 2020 22:33:41 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 18 Apr 2020 15:33:37 -0700
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <c838fc1d-3973-9cd8-ecc6-8739af514dd0@infradead.org>
Date: Sat, 18 Apr 2020 18:33:35 -0400
Message-Id: <B4067786-F04F-4CE5-B84B-DE5BB0890529@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
 <d2e2f7967804446a825ec0ff61095e6640b5a968.camel@hammerspace.com>
 <c838fc1d-3973-9cd8-ecc6-8739af514dd0@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180188
Message-ID-Hash: YNSUFM6C6IY4UXBILCT4PD2Q5ELTFNRY
X-Message-ID-Hash: YNSUFM6C6IY4UXBILCT4PD2Q5ELTFNRY
X-MailFrom: chuck.lever@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Trond Myklebust <trondmy@hammerspace.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Bruce Fields <bfields@fieldses.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "zzy@zzywysm.com" <zzy@zzywysm.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alsa-devel@al
 sa-project.org" <alsa-devel@alsa-project.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YNSUFM6C6IY4UXBILCT4PD2Q5ELTFNRY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gQXByIDE4LCAyMDIwLCBhdCA2OjMyIFBNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiA0LzE4LzIwIDM6MjggUE0sIFRyb25kIE15
a2xlYnVzdCB3cm90ZToNCj4+IE9uIFNhdCwgMjAyMC0wNC0xOCBhdCAxNDo0NSAtMDQwMCwgQ2h1
Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4+IE9uIEFwciAxOCwgMjAyMCwgYXQgMjo0MSBQTSwgUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+Pj4+IHdyb3RlOg0KPj4+PiANCj4+Pj4g
Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQo+Pj4+IA0K
Pj4+PiAuLi9mcy9uZnNkL25mczRzdGF0ZS5jOjM4OTg6Mzogd2FybmluZzogc3VnZ2VzdCBicmFj
ZXMgYXJvdW5kIGVtcHR5DQo+Pj4+IGJvZHkgaW4gYW4g4oCYZWxzZeKAmSBzdGF0ZW1lbnQgWy1X
ZW1wdHktYm9keV0NCj4+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPj4+PiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPj4+PiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz4NCj4+Pj4gQ2M6ICJKLiBCcnVjZSBGaWVsZHMiIDxiZmllbGRzQGZpZWxk
c2VzLm9yZz4NCj4+Pj4gQ2M6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0K
Pj4+PiBDYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPj4+IA0KPj4+IEkgaGF2ZSBhIHBh
dGNoIGluIG15IHF1ZXVlIHRoYXQgYWRkcmVzc2VzIHRoaXMgcGFydGljdWxhciB3YXJuaW5nLA0K
Pj4+IGJ1dCB5b3VyIGNoYW5nZSB3b3JrcyBmb3IgbWUgdG9vLg0KPj4+IA0KPj4+IEFja2VkLWJ5
OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+PiANCj4+PiBVbmxlc3Mg
QnJ1Y2Ugb2JqZWN0cy4NCj4+PiANCj4+PiANCj4+Pj4gLS0tDQo+Pj4+IGZzL25mc2QvbmZzNHN0
YXRlLmMgfCAgICAzICsrLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pj4+IA0KPj4+PiAtLS0gbGludXgtbmV4dC0yMDIwMDQxNy5vcmlnL2Zz
L25mc2QvbmZzNHN0YXRlLmMNCj4+Pj4gKysrIGxpbnV4LW5leHQtMjAyMDA0MTcvZnMvbmZzZC9u
ZnM0c3RhdGUuYw0KPj4+PiBAQCAtMzQsNiArMzQsNyBAQA0KPj4+PiANCj4+Pj4gI2luY2x1ZGUg
PGxpbnV4L2ZpbGUuaD4NCj4+Pj4gI2luY2x1ZGUgPGxpbnV4L2ZzLmg+DQo+Pj4+ICsjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+Pj4+ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+Pj4+ICNp
bmNsdWRlIDxsaW51eC9uYW1laS5oPg0KPj4+PiAjaW5jbHVkZSA8bGludXgvc3dhcC5oPg0KPj4+
PiBAQCAtMzg5NSw3ICszODk2LDcgQEAgbmZzZDRfc2V0Y2xpZW50aWQoc3RydWN0IHN2Y19ycXN0
ICpycXN0cA0KPj4+PiAJCWNvcHlfY2xpZChuZXcsIGNvbmYpOw0KPj4+PiAJCWdlbl9jb25maXJt
KG5ldywgbm4pOw0KPj4+PiAJfSBlbHNlIC8qIGNhc2UgNCAobmV3IGNsaWVudCkgb3IgY2FzZXMg
MiwgMyAoY2xpZW50IHJlYm9vdCk6ICovDQo+Pj4+IC0JCTsNCj4+Pj4gKwkJZG9fZW1wdHkoKTsN
Cj4+IA0KPj4gVXJnaC4uLiBUaGlzIGlzIGp1c3QgZm9yIGRvY3VtZW50YXRpb24gcHVycG9zZXMg
YW55d2F5LCBzbyB3aHkgbm90IGp1c3QNCj4+IHR1cm4gaXQgYWxsIGludG8gYSBjb21tZW50IGJ5
IG1vdmluZyB0aGUgJ2Vsc2UnIGludG8gdGhlIGNvbW1lbnQgZmllbGQ/DQo+PiANCj4+IGkuZS4N
Cj4+IAl9IC8qIGVsc2UgY2FzZSA0ICguLi4uICovDQo+PiANCj4+IAluZXctPmNsX21pbm9ydmVy
c2lvbiA9IDA7DQo+Pj4+IAlnZW5fY2FsbGJhY2sobmV3LCBzZXRjbGlkLCBycXN0cCk7DQo+Pj4+
IAlhZGRfdG9fdW5jb25maXJtZWQobmV3KTsNCj4gDQo+IExpa2UgSSBzYWlkIGVhcmxpZXIsIHNp
bmNlIENodWNrIGhhcyBhIHBhdGNoIHRoYXQgYWRkcmVzc2VzIHRoaXMsDQo+IGxldCdzIGp1c3Qg
Z28gd2l0aCB0aGF0Lg0KDQpJJ2xsIHBvc3QgdGhhdCBwYXRjaCBmb3IgcmV2aWV3IGFzIHBhcnQg
b2YgbXkgTkZTRCBmb3ItNS44IHBhdGNoZXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
