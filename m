Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FD163681
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 23:53:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0781E10FC341C;
	Tue, 18 Feb 2020 14:54:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8580110097DFC
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:54:40 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMlx4S125643;
	Tue, 18 Feb 2020 22:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1Q62cPH1Xp8kxiw0GhNYjhX3s5Y04bDzwFnSLddrOUc=;
 b=l3++8akYe9ElvfQqjWDQpEwvdV8wwfreMQoxJcVn6Cllni9gF7QvrNJ+RVYjlZRt2Z5n
 pq7UQtB3EqR1bDBymj1nXZ8LyK2bS1TMkl/R6t0Ezvz9opnRvXqaodmsmOXZrgI+Q4vL
 nsicuYfBVVyTgmWGVXNEbXIT0vs1HkCBXqD/y2cLW5b2NUzDRuGisU8Zzz023OITk1x+
 8K+xhKeT9AxfztuI3IzZokmKhZwkrHVgGn7/b/xx2PxJo/qCk4eZ09T66IexBR2OwTj0
 h00TZXEntmvNNfCpqIv7x0WbanZiLxZKAJ07oljB/c/3rVg4kp/w/MZvSN7bn5QiURlO RQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2y699rsdny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2020 22:53:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IMrewJ108538;
	Tue, 18 Feb 2020 22:53:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2y6tc393hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2020 22:53:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01IMrS6Y020383;
	Tue, 18 Feb 2020 22:53:29 GMT
Received: from [10.132.96.37] (/10.132.96.37)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 18 Feb 2020 14:50:44 -0800
Subject: Re: [RFC][PATCH] dax: Do not try to clear poison for partial pages
To: Jeff Moyer <jmoyer@redhat.com>, Dan Williams <dan.j.williams@intel.com>
References: <20200129210337.GA13630@redhat.com>
 <f97d1ce2-9003-6b46-cd25-a908dc3bd2c6@oracle.com>
 <CAPcyv4ittXHkEV4eH_4F5vCfwRLoTTtDqEU1SmCs5DYUdZxBOA@mail.gmail.com>
 <x49v9o3brom.fsf@segfault.boston.devel.redhat.com>
 <583b5fc2-0358-ea9d-20eb-1323c8cedce2@oracle.com>
From: jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <17c0d27e-c23f-b686-1d47-a0ccace03211@oracle.com>
Date: Tue, 18 Feb 2020 14:50:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <583b5fc2-0358-ea9d-20eb-1323c8cedce2@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180155
Message-ID-Hash: EXVSR4IJTELJHH3D6F663CS4BFSNL52H
X-Message-ID-Hash: EXVSR4IJTELJHH3D6F663CS4BFSNL52H
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXVSR4IJTELJHH3D6F663CS4BFSNL52H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMi8xOC8yMCAxMjo0NSBQTSwgamFuZS5jaHVAb3JhY2xlLmNvbSB3cm90ZToNCj4gT24gMi8x
OC8yMCAxMTo1MCBBTSwgSmVmZiBNb3llciB3cm90ZToNCj4+IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPiB3cml0ZXM6DQo+Pg0KPj4+IFJpZ2h0IG5vdyB0aGUga2VybmVs
IGRvZXMgbm90IGluc3RhbGwgYSBwdGUgb24gZmF1bHRzIHRoYXQgbGFuZCBvbiBhDQo+Pj4gcGFn
ZSB3aXRoIGtub3duIHBvaXNvbiwgYnV0IG9ubHkgYmVjYXVzZSB0aGUgZXJyb3IgY2xlYXJpbmcg
cGF0aCBpcyBzbw0KPj4+IGNvbnZvbHV0ZWQgYW5kIGNvdWxkIG9ubHkgY2xhaW0gdGhhdCBmYWxs
b2NhdGUoUFVOQ0hfSE9MRSkgY2xlYXJlZA0KPj4+IGVycm9ycyBiZWNhdXNlIHRoYXQgd2FzIGd1
YXJhbnRlZWQgdG8gc2VuZCA1MTItYnl0ZSBhbGlnbmVkIHplcm8ncw0KPj4+IGRvd24gdGhlIGJs
b2NrLUkvTyBwYXRoIHdoZW4gdGhlIGZzLWJsb2NrcyBnb3QgcmVhbGxvY2F0ZWQuIEluIGEgd29y
bGQNCj4+PiB3aGVyZSBuYXRpdmUgY3B1IGluc3RydWN0aW9ucyBjYW4gY2xlYXIgZXJyb3JzIHRo
ZSBkYXggd3JpdGUoKSBzeXNjYWxsDQo+Pj4gY2FzZSBjb3VsZCBiZSBjb3ZlcmVkIChtb2R1bG8g
NjQtYnl0ZSBhbGlnbm1lbnQpLCBhbmQgdGhlIGtlcm5lbCBjb3VsZA0KPj4+IGp1c3QgbGV0IHRo
ZSBwYWdlIGJlIG1hcHBlZCBzbyB0aGF0IHRoZSBhcHBsaWNhdGlvbiBjb3VsZCBhdHRlbXB0IGl0
J3MNCj4+PiBvd24gZmluZS1ncmFpbmVkIGNsZWFyaW5nIHdpdGhvdXQgY2FsbGluZyBiYWNrIGlu
dG8gdGhlIGtlcm5lbC4NCj4+DQo+PiBJJ20gbm90IHN1cmUgd2UnZCB3YW50IHRvIGRvIGFsbG93
IG1hcHBpbmcgdGhlIFBURXMgZXZlbiBpZiB0aGVyZSB3YXMNCj4+IHN1cHBvcnQgZm9yIGNsZWFy
aW5nIGVycm9ycyB2aWEgQ1BVIGluc3RydWN0aW9ucy7CoCBBbnkgbG9hZCBmcm9tIGENCj4+IHBv
aXNvbmVkIHBhZ2Ugd2lsbCByZXN1bHQgaW4gYW4gTUNFLCBhbmQgdGhlcmUgZXhpc3RzIHRoZSBw
b3NzaWJsaXR5DQo+PiB0aGF0IHlvdSB3aWxsIGhpdCBhbiB1bnJlY292ZXJhYmxlIGVycm9yIChQ
cm9jZXNzb3IgQ29udGV4dCBDb3JydXB0KS4NCj4+IEl0J3MganVzdCBzYWZlciB0byBjYXRjaCB0
aGVzZSBjYXNlcyBieSBub3QgbWFwcGluZyB0aGUgcGFnZSwgYW5kDQo+PiBmb3JjaW5nIHJlY292
ZXJ5IHRocm91Z2ggdGhlIGRyaXZlci4NCj4+DQo+PiAtSmVmZg0KPj4NCj4gDQo+IEknbSBzdGls
bCBpbiB0aGUgcHJvY2VzcyBvZiB0cnlpbmcgYSBudW1iZXIgb2YgdGhpbmdzIGJlZm9yZSBtYWtp
bmcgYW4NCj4gYXR0ZW1wdCB0byByZXNwb25kIHRvIERhbidzIHJlc3BvbnNlLiBCdXQgSSdtIHRv
byBzbG93LCBzbyBJJ2QgbGlrZQ0KPiB0byBzaGFyZSBzb21lIGNvbmNlcm5zIEkgaGF2ZSBoZXJl
Lg0KPiANCj4gSWYgYSBwb2lzb24gaW4gYSBmaWxlIGlzIGNvbnN1bWVkLCBhbmQgdGhlIHNpZ25h
bCBoYW5kbGUgZG9lcyB0aGUNCj4gcmVwYWlyIGFuZCByZWNvdmVyIGFzIGZvbGxvdzogcHVuY2gg
YSBob2xlIHRoZSBzaXplIGF0IGxlYXN0IDRLLCB0aGVuDQo+IHB3cml0ZSB0aGUgY29ycmVjdCBk
YXRhIGluIHRvIHRoZSAnaG9sZScsIHRoZW4gcmVzdW1lIHRoZSBvcGVyYXRpb24uDQo+IEhvd2V2
ZXIsIGJlY2F1c2UgdGhlIG5ld2x5IGFsbG9jYXRlZCBwbWVtIGJsb2NrIChkdWUgdG8gcHdyaXRl
IHRvIHRoZSANCj4gJ2hvbGUnKSBpcyBhIGRpZmZlcmVudCBjbGVhbiBwaHlzaWNhbCBwbWVtIGJs
b2NrIHdoaWxlIHRoZSBwb2lzb25lZA0KPiBibG9jayByZW1haW4gdW5maXhlZCwgc28gd2UgaGF2
ZSBhIHByb3Zpc2lvbmluZyBwcm9ibGVtLCBiZWNhdXNlDQo+ICDCoDEuIERDUE1FTSBpcyBleHBl
bnNpdmUgaGVuY2UgdGhlcmUgaXMgbGlrZWx5IGxpdHRsZSBwcm92aXNpb24gYmVpbmcNCj4gcHJv
dmlkZWQgYnkgdXNlcnM7DQo+ICDCoDIuIGxhY2sgdXAgQVBJIGJldHdlZW4gZGF4LWZpbGVzeXN0
ZW0gYW5kIHBtZW0gZHJpdmVyIGZvciBjbGVhcmluZw0KPiBwb2lzb24gYXQgZWFjaCBsZWdpdGlt
YXRlIHBvaW50LCBzdWNoIGFzIHdoZW4gdGhlIGZpbGVzeXN0ZW0gdHJpZXMNCj4gdG8gYWxsb2Nh
dGUgYSBwbWVtIGJsb2NrLCBvciB6ZXJvaW5nIG91dCBhIHJhbmdlID4NCj4gQXMgRENQTU0gaXMg
dXNlZCBmb3IgaXRzIHBlcmZvcm1hbmNlIGFuZCBjYXBhY2l0eSBpbiBjbG91ZCBhcHBsaWNhdGlv
biwNCj4gd2hpY2ggdHJhbnNsYXRlcyB0byB0aGF0IHRoZSBwZXJmb3JtYW5jZSBjb2RlIHBhdGhz
IGluY2x1ZGUgdGhlIGVycm9yDQo+IGhhbmRsaW5nIGFuZCByZWNvdmVyeSBjb2RlIHBhdGguLi4N
Cj4gDQo+IFdpdGggcmVzcGVjdCB0byB0aGUgbmV3IGNwdSBpbnN0cnVjdGlvbiwgbXkgY29uY2Vy
biBpcyBhYm91dCB0aGUgQVBJIA0KPiBpbmNsdWRpbmcgdGhlIGVycm9yIGJsYXN0IHJhZGl1cyBh
cyByZXBvcnRlZCBpbiB0aGUgc2lnbmFsIHBheWxvYWQuDQo+IElzIHRoZXJlIGEgdmVudWUgd2hl
cmUgd2UgY291bGQgZGlzY3VzcyBtb3JlIGluIGRldGFpbCA/DQoNCkZvciBhbGwgdGhlIHF1YXJh
bnRpbmVkIHBvaXNvbiBibG9ja3MsIGl0J3Mgbm90IHByYWN0aWNhbCB0byBjbGVhciB0aGVtIA0K
cG9pc29ucyB2aWEgbmRjdGwvbGlibmRjdGwgb24gYSBwZXIgbmFtZXNwYWNlIGdyYW51bGFyaXR5
IGZvciBmZWFyIG9mDQpwb2lzb25zIG9jY3VycmVkIGluIHZhbGlkIHBtZW0gYmxvY2tzIGR1cmlu
ZyBkYXRhIGF0IHJlc3QuDQoNCkhvdyB0byB1bHRpbWF0ZWx5IGNsZWFyIHBvaXNvbnMgaW4gYSBk
YXgtZnMgaW4gY3VycmVudCBmcmFtZXdvcms/DQppdCBzZWVtcyB0byBtZSBwb2lzb25zIG5lZWQg
dG8gYmUgY2xlYXJlZCBvbiB0aGUgZ28gYXV0b21hdGljYWxseS4NCg0KUmVnYXJkcywNCi1qYW5l
DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IC1qYW5lDQo+IA0KPiANCj4gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
