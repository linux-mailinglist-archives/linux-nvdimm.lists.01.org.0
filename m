Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8C31E7B6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Feb 2021 10:00:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F281100EBB62;
	Thu, 18 Feb 2021 01:00:08 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id B0FBB100EBBC4
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 01:00:05 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,186,1610380800";
   d="scan'208";a="104601999"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2021 17:00:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 2F5E34CE72E3;
	Thu, 18 Feb 2021 16:59:58 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Feb
 2021 16:59:57 +0800
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
To: Christoph Hellwig <hch@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <20210210133347.GD30109@lst.de>
 <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
 <20210218083230.GA17913@lst.de>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9edffa8e-faf8-3d29-6ec0-69ad512e7bb7@cn.fujitsu.com>
Date: Thu, 18 Feb 2021 16:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218083230.GA17913@lst.de>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 2F5E34CE72E3.AE2D0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: UVUK55GBIXOPG7OFW3U6ZEODYS77733T
X-Message-ID-Hash: UVUK55GBIXOPG7OFW3U6ZEODYS77733T
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UVUK55GBIXOPG7OFW3U6ZEODYS77733T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi8xOCDkuIvljYg0OjMyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4g
T24gV2VkLCBGZWIgMTcsIDIwMjEgYXQgMTA6NTY6MTFBTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPj4gSSdkIGxpa2UgdG8gY29uZmlybSBvbmUgdGhpbmcuLi4gIEkgaGF2ZSBjaGVja2Vk
IGFsbCBvZiB0aGlzIHBhdGNoc2V0IGJ5DQo+PiBjaGVja3BhdGNoLnBsIGFuZCBpdCBkaWQgbm90
IHJlcG9ydCB0aGUgb3Zlcmx5IGxvbmcgbGluZSB3YXJuaW5nLiAgU28sIEkNCj4+IHNob3VsZCBz
dGlsbCBvYmV5IHRoZSBydWxlIG9mIDgwIGNoYXJzIG9uZSBsaW5lPw0KPiANCj4gY2hlY2twYXRj
aC5wbCBpcyBjb21wbGV0ZWx5IGJyb2tlbiwgSSB3b3VsZCBub3QgcmVseSBvbiBpdC4NCj4gDQo+
IEhlcmUgaXMgdGhlIHF1b3RlIGZyb20gdGhlIGNvZGluZyBzdHlsZSBkb2N1bWVudDoNCj4gDQo+
ICJUaGUgcHJlZmVycmVkIGxpbWl0IG9uIHRoZSBsZW5ndGggb2YgYSBzaW5nbGUgbGluZSBpcyA4
MCBjb2x1bW5zLg0KPiANCj4gU3RhdGVtZW50cyBsb25nZXIgdGhhbiA4MCBjb2x1bW5zIHNob3Vs
ZCBiZSBicm9rZW4gaW50byBzZW5zaWJsZSBjaHVua3MsDQo+IHVubGVzcyBleGNlZWRpbmcgODAg
Y29sdW1ucyBzaWduaWZpY2FudGx5IGluY3JlYXNlcyByZWFkYWJpbGl0eSBhbmQgZG9lcw0KPiBu
b3QgaGlkZSBpbmZvcm1hdGlvbi4iDQo+IA0KDQpPSy4gIEdvdCBpdC4gIFRoYW5rIHlvdS4NCg0K
DQotLQ0KUnVhbiBTaGl5YW5nLg0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
