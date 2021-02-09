Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6048314BF7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 10:46:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 341A1100EAB58;
	Tue,  9 Feb 2021 01:46:22 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id A41B8100EAB53
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 01:46:19 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800";
   d="scan'208";a="104368304"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 17:46:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 7E31B4CE6F81;
	Tue,  9 Feb 2021 17:46:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 17:46:12 +0800
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
To: Christoph Hellwig <hch@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
 <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
 <20210209093438.GA630@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
Date: Tue, 9 Feb 2021 17:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209093438.GA630@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 7E31B4CE6F81.AEF5B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 37NTNMQVVWOD5VXWKZP2NME6XGRMUREW
X-Message-ID-Hash: 37NTNMQVVWOD5VXWKZP2NME6XGRMUREW
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/37NTNMQVVWOD5VXWKZP2NME6XGRMUREW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi85IOS4i+WNiDU6MzQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBP
biBUdWUsIEZlYiAwOSwgMjAyMSBhdCAwNToxNToxM1BNICswODAwLCBSdWFuIFNoaXlhbmcgd3Jv
dGU6DQo+PiBUaGUgZGF4IGRlZHVwZSBjb21wYXJpc29uIG5lZWQgdGhlIGlvbWFwX29wcyBwb2lu
dGVyIGFzIGFyZ3VtZW50LCBzbyBteQ0KPj4gdW5kZXJzdGFuZGluZyBpcyB0aGF0IHdlIGRvbid0
IG1vZGlmeSB0aGUgYXJndW1lbnQgbGlzdCBvZg0KPj4gZ2VuZXJpY19yZW1hcF9maWxlX3Jhbmdl
X3ByZXAoKSwgYnV0IG1vdmUgaXRzIGNvZGUgaW50bw0KPj4gX19nZW5lcmljX3JlbWFwX2ZpbGVf
cmFuZ2VfcHJlcCgpIHdob3NlIGFyZ3VtZW50IGxpc3QgY2FuIGJlIG1vZGlmaWVkIHRvDQo+PiBh
Y2NlcHRzIHRoZSBpb21hcF9vcHMgcG9pbnRlci4gIFRoZW4gaXQgbG9va3MgbGlrZSB0aGlzOg0K
PiANCj4gSSdkIHNheSBqdXN0IGFkZCB0aGUgaW9tYXBfb3BzIHBvaW50ZXIgdG8NCj4gZ2VuZXJp
Y19yZW1hcF9maWxlX3JhbmdlX3ByZXAgYW5kIGRvIGF3YXkgd2l0aCB0aGUgZXh0cmEgd3JhcHBl
cnMuICBXZQ0KPiBvbmx5IGhhdmUgdGhyZWUgY2FsbGVycyBhbnl3YXkuDQoNCk9LLg0KDQoNCi0t
DQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQo+IA0KPiANCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
