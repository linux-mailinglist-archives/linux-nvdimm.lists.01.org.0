Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D73F23AFA7
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 23:26:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29BC7129E8167;
	Mon,  3 Aug 2020 14:26:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dave.jiang@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0FD451294F0A5
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 14:26:19 -0700 (PDT)
IronPort-SDR: u3OnlY+s7KSI/vS+lJubGm5HaC/ZqQ3K//0ULdvXI5cyzdy2Mz3Jtz/XsmKv6X+hkLw8Hz8S2w
 hquaNl5HGqxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237067244"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="237067244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 14:26:19 -0700
IronPort-SDR: RulXwNywhv1eI8mAx/l2FWKIOuoPQn3y862B8fRMfSTGFJVWGCJfUoaFdi2W5KFVaVNAJJW7qT
 9QbcAWE9RiPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800";
   d="scan'208";a="314981446"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 14:26:19 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To: Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
 <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <69576669-632e-1821-2076-7bc47c0bbd85@intel.com>
Date: Mon, 3 Aug 2020 14:26:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
Content-Language: en-US
Message-ID-Hash: OEXROATNRHJQTW25JZ5EHR4CJJVE7UPS
X-Message-ID-Hash: OEXROATNRHJQTW25JZ5EHR4CJJVE7UPS
X-MailFrom: dave.jiang@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OEXROATNRHJQTW25JZ5EHR4CJJVE7UPS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDgvMy8yMDIwIDI6MTAgUE0sIEphbmUgQ2h1IHdyb3RlOg0KPiBIaSwgRGF2ZSwNCj4g
DQo+IE9uIDgvMy8yMDIwIDE6NDEgUE0sIERhdmUgSmlhbmcgd3JvdGU6DQo+PiBPbiA3LzI0LzIw
MjAgOTowOSBBTSwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4gU2luY2UNCj4+PiBjb21taXQgZDc4YzYy
MGEyZTgyICgibGlibnZkaW1tL3NlY3VyaXR5OiBJbnRyb2R1Y2UgYSAnZnJvemVuJyBhdHRyaWJ1
dGUiKSwNCj4+PiB3aGVuIGlzc3VlDQo+Pj4gwqAgIyBuZGN0bCBzYW5pdGl6ZS1kaW1tIG5tZW0w
IC0tb3ZlcndyaXRlDQo+Pj4gdGhlbiBpbW1lZGlhdGVseSBjaGVjayB0aGUgJ3NlY3VyaXR5JyBh
dHRyaWJ1dGUsDQo+Pj4gwqAgIyBjYXQgL3N5cy9kZXZpY2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVT
OjAwL0FDUEkwMDEyOjAwL25kYnVzMC9ubWVtMC9zZWN1cml0eQ0KPj4+IMKgIHVubG9ja2VkDQo+
Pj4gQWN0dWFsbHkgdGhlIGF0dHJpYnV0ZSBzdGF5cyAndW5sb2NrZWQnIHRocm91Z2ggb3V0IHRo
ZSBlbnRpcmUgb3ZlcndyaXRlDQo+Pj4gb3BlcmF0aW9uLCBuZXZlciBjaGFuZ2VkLsKgIFRoYXQn
cyBiZWNhdXNlICdudmRpbW0tPnNlYy5mbGFncycgaXMgYSBiaXRtYXANCj4+PiB0aGF0IGhhcyBi
b3RoIGJpdHMgc2V0IGluZGljYXRpbmcgJ292ZXJ3cml0ZScgYW5kICd1bmxvY2tlZCcuDQo+Pj4g
QnV0IHNlY3VyaXR5X3Nob3coKSBjaGVja3MgdGhlIG11dHVhbGx5IGV4Y2x1c2l2ZSBiaXRzIGJl
Zm9yZSBpdCBjaGVja3MNCj4+PiB0aGUgJ292ZXJ3cml0ZScgYml0IGF0IGxhc3QuIFRoZSBvcmRl
ciBzaG91bGQgYmUgcmV2ZXJzZWQuDQo+Pj4NCj4+PiBUaGUgY29tbWl0IGFsc28gaGFzIGEgdHlw
bzogaW4gb25lIG9jY2FzaW9uLCAnbnZkaW1tLT5zZWMuZXh0X3N0YXRlJw0KPj4+IGFzc2lnbm1l
bnQgaXMgcmVwbGFjZWQgd2l0aCAnbnZkaW1tLT5zZWMuZmxhZ3MnIGFzc2lnbm1lbnQgZm9yDQo+
Pj4gdGhlIE5WRElNTV9NQVNURVIgdHlwZS4NCj4+DQo+PiBNYXkgYmUgYmVzdCB0byBzcGxpdCB0
aGlzIGZpeCB0byBhIGRpZmZlcmVudCBwYXRjaD8gSnVzdCB0aGlua2luZyBnaXQgYmlzZWN0IA0K
Pj4gbGF0ZXIgb24gdG8gdHJhY2sgaXNzdWVzLiBPdGhlcndpc2UgUmV2aWV3ZWQtYnk6IERhdmUg
SmlhbmcgDQo+PiA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IA0KPiBTdXJlLiBJIHRha2UgaXQg
eW91IG1lYW50IHRvIHNlcGFyYXRlIHRoZSB0eXBvIGZpeCBmcm9tIHRoZSBjaGFuZ2UgdGhhdCB0
ZXN0cyANCj4gdGhlIE9WRVJXUklURSBiaXQgZmlyc3Q/DQoNClllcCENCg0KPiANCj4gUmVnYXJk
cywNCj4gLWphbmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
