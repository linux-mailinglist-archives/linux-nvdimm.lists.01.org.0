Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8219823D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 20:03:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 460F920213F0C;
	Wed, 21 Aug 2019 11:04:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B02C720212C93
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 11:04:29 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 11:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="169495620"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 11:03:19 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 21 Aug 2019 11:03:19 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX112.amr.corp.intel.com ([169.254.5.162]) with mapi id 14.03.0439.000;
 Wed, 21 Aug 2019 11:03:19 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "msuchanek@suse.de"
 <msuchanek@suse.de>
Subject: Re: [ndctl PATCH v2 14/26] ndctl/namespace: Handle
 'create-namespace' in label-less mode
Thread-Topic: [ndctl PATCH v2 14/26] ndctl/namespace: Handle
 'create-namespace' in label-less mode
Thread-Index: AQHVRMXsk8OMgntO9UCLVvFdfEUjSKcGK2KAgABV1gA=
Date: Wed, 21 Aug 2019 18:03:18 +0000
Message-ID: <c92890eae097e27edb65afd4fc969f032fb9a18d.camel@intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156426363655.531577.4504452379578995249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190821145605.206372a0@kitsune.suse.cz>
In-Reply-To: <20190821145605.206372a0@kitsune.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <B5285B74E1F6AB458ACD98F55C0AE4A0@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gV2VkLCAyMDE5LTA4LTIxIGF0IDE0OjU2ICswMjAwLCBNaWNoYWwgU3VjaMOhbmVrIHdyb3Rl
Og0KPiBIZWxsbywNCj4gDQo+IHRoaXMgcGF0Y2ggaXMgbWFya2VkIGFzIHN1cGVyc2VkZWQgaW4g
dGhlIHBhdGNod29yay4NCj4gDQo+IFdoYXQgaXMgdGhlIGludGVuZGVkIHJlcGxhY2VtZW50Pw0K
PiANCg0KSGkgTWljaGFsLA0KDQpUaGUgcGF0Y2ggd2FzIHN1cGVyc2VkZWQgYnkgdjMgb2YgdGhl
IHNlcmllcywgYW5kIGlzIHByZXNlbnQgaW4gdGhlDQpsYXRlc3QgcmVsZWFzZSAodjY2KToNCg0K
Nzk2NmM5MiBuZGN0bC9uYW1lc3BhY2U6IEhhbmRsZSAnY3JlYXRlLW5hbWVzcGFjZScgaW4gbGFi
ZWwtbGVzcyBtb2RlDQoNCgktVmlzaGFsDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dmRpbW0K
