Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7131D433
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 04:24:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74307100EAB40;
	Tue, 16 Feb 2021 19:24:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 473D6100F2268
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:24:22 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800";
   d="scan'208";a="104562120"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2021 11:24:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 1AC344CE602A;
	Wed, 17 Feb 2021 11:24:20 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 11:24:18 +0800
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
To: Christoph Hellwig <hch@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
 <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
 <20210209093438.GA630@lst.de>
 <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
 <20210210131928.GA30109@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com>
Date: Wed, 17 Feb 2021 11:24:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210131928.GA30109@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 1AC344CE602A.A9FC5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: INW7FD67ZD6653W6GP6DBA2ZXEXRRKKP
X-Message-ID-Hash: INW7FD67ZD6653W6GP6DBA2ZXEXRRKKP
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/INW7FD67ZD6653W6GP6DBA2ZXEXRRKKP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi8xMCDkuIvljYg5OjE5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4g
T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDU6NDY6MTNQTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiAyMDIxLzIvOSDkuIvljYg1OjM0LCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4+PiBPbiBUdWUsIEZlYiAwOSwgMjAyMSBhdCAwNToxNToxM1BNICswODAwLCBS
dWFuIFNoaXlhbmcgd3JvdGU6DQo+Pj4+IFRoZSBkYXggZGVkdXBlIGNvbXBhcmlzb24gbmVlZCB0
aGUgaW9tYXBfb3BzIHBvaW50ZXIgYXMgYXJndW1lbnQsIHNvIG15DQo+Pj4+IHVuZGVyc3RhbmRp
bmcgaXMgdGhhdCB3ZSBkb24ndCBtb2RpZnkgdGhlIGFyZ3VtZW50IGxpc3Qgb2YNCj4+Pj4gZ2Vu
ZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAoKSwgYnV0IG1vdmUgaXRzIGNvZGUgaW50bw0KPj4+
PiBfX2dlbmVyaWNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKCkgd2hvc2UgYXJndW1lbnQgbGlzdCBj
YW4gYmUgbW9kaWZpZWQgdG8NCj4+Pj4gYWNjZXB0cyB0aGUgaW9tYXBfb3BzIHBvaW50ZXIuICBU
aGVuIGl0IGxvb2tzIGxpa2UgdGhpczoNCj4+Pg0KPj4+IEknZCBzYXkganVzdCBhZGQgdGhlIGlv
bWFwX29wcyBwb2ludGVyIHRvDQo+Pj4gZ2VuZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAgYW5k
IGRvIGF3YXkgd2l0aCB0aGUgZXh0cmEgd3JhcHBlcnMuICBXZQ0KPj4+IG9ubHkgaGF2ZSB0aHJl
ZSBjYWxsZXJzIGFueXdheS4NCj4+DQo+PiBPSy4NCj4gDQo+IFNvIGxvb2tpbmcgYXQgdGhpcyBh
Z2FpbiBJIHRoaW5rIHlvdXIgcHJvcG9zYWwgYWN0YXVsbHkgaXMgYmV0dGVyLA0KPiBnaXZlbiB0
aGF0IHRoZSBpb21hcCB2YXJpYW50IGlzIHN0aWxsIERBWCBzcGVjaWZpYy4gIFNvcnJ5IGZvcg0K
PiB0aGUgbm9pc2UuDQo+IA0KPiBBbHNvIEkgdGhpbmsgZGF4X2ZpbGVfcmFuZ2VfY29tcGFyZSBz
aG91bGQgdXNlIGlvbWFwX2FwcGx5IGluc3RlYWQNCj4gb2Ygb3BlbiBjb2RpbmcgaXQuDQo+IA0K
DQpUaGVyZSBhcmUgdHdvIGZpbGVzLCB3aGljaCBhcmUgbm90IHJlZmxpbmtlZCwgbmVlZCB0byBi
ZSBkaXJlY3RfYWNjZXNzKCkgDQpoZXJlLiAgVGhlIGlvbWFwX2FwcGx5KCkgY2FuIGhhbmRsZSBv
bmUgZmlsZSBlYWNoIHRpbWUuICBTbywgaXQgc2VlbXMgDQp0aGF0IGlvbWFwX2FwcGx5KCkgaXMg
bm90IHN1aXRhYmxlIGZvciB0aGlzIGNhc2UuLi4NCg0KDQpUaGUgcHNldWRvIGNvZGUgb2YgdGhp
cyBwcm9jZXNzIGlzIGFzIGZvbGxvd3M6DQoNCiAgIHNyY2xlbiA9IG9wcy0+YmVnaW4oJnNyY21h
cCkNCiAgIGRlc3RsZW4gPSBvcHMtPmJlZ2luKCZkZXN0bWFwKQ0KDQogICBkaXJlY3RfYWNjZXNz
KCZzcmNtYXAsICZzYWRkcikNCiAgIGRpcmVjdF9hY2Nlc3MoJmRlc3RtYXAsICZkYWRkcikNCg0K
ICAgc2FtZSA9IG1lbWNweShzYWRkciwgZGFkZHIsIG1pbihzcmNsZW4sZGVzdGxlbikpDQoNCiAg
IG9wcy0+ZW5kKCZkZXN0bWFwKQ0KICAgb3BzLT5lbmQoJnNyY21hcCkNCg0KSSB0aGluayBhIG5l
c3RlZCBjYWxsIGxpa2UgdGhpcyBpcyBuZWNlc3NhcnkuICBUaGF0J3Mgd2h5IEkgdXNlIHRoZSBv
cGVuIA0KY29kZSB3YXkuDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCj4gDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
