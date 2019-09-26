Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F0BF668
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 18:05:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 318C221967BC5;
	Thu, 26 Sep 2019 09:07:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 97B312010BCCF
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 09:07:34 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 09:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="219449975"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2019 09:05:27 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:05:27 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:05:27 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.249]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.223]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 10:05:24 -0600
From: "Weiny, Ira" <ira.weiny@intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>
Subject: RE: [PATCH] bnvdimm/namsepace: Don't set claim_class on error
Thread-Topic: [PATCH] bnvdimm/namsepace: Don't set claim_class on error
Thread-Index: AQHVc8ygy0t9taFML0a+mKhnV0JE/Kc9HU2A//+OToCAAUO0AIAAMVwQ
Date: Thu, 26 Sep 2019 16:05:24 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E89924636@CRSMSX101.amr.corp.intel.com>
References: <20190925181056.11097-1-ira.weiny@intel.com>
 <ff7ff4f5b4289d189a7c347591a5c35876ea804f.camel@intel.com>
 <20190925184939.GA11669@iweiny-DESK2.sc.intel.com>
 <fe170e53-92d1-eca8-d419-1a4210cb7313@suse.de>
In-Reply-To: <fe170e53-92d1-eca8-d419-1a4210cb7313@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmJmYzc1MWYtZWE2NC00MmRiLWI0NWQtOWRlZTMzNDI1Y2VlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidzE4RUtjK3FvbGZrTnVndUwwUEppWTc0ZXJcL0FUUXVFd3pWQmpxNmtmRTFNVFA2elBSU24ybXJcL2lzRDh3V1dTIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

PiBPbiAyNS8wOS8yMDE5IDIwOjQ5LCBJcmEgV2Vpbnkgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gU2ln
bmVkLW9mZi1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiA+Pj4gLS0tDQo+
ID4+PiAgZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYyB8IDE5ICsrKysrKysrKy0tLS0t
LS0tLS0NCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkNCj4gPj4NCj4gPj4gT25lIG1pbm9yIG5pdCBiZWxvdywgYnV0IG90aGVyd2lzZSBpdCBs
b29rcyBnb29kIHRvIG1lOg0KPiA+PiBSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwu
bC52ZXJtYUBpbnRlbC5jb20+DQo+IA0KPiBBbm90aGVyIG1pbm9yIG5pdCwgdGhlIFN1YmplY3Qg
c2F5czoNCj4gImJudmRpbW0vbmFtc2VwYWNlOiBEb24ndCBzZXQgY2xhaW1fY2xhc3Mgb24gZXJy
b3IiDQo+IA0KPiBhLmsuYSBtaXNzaW5nIHRoZSAnbGknIHBhcnQgb2YgbGlibnZkaW1tDQoNClll
YS4uLiAgSSB3YXMganVzdCBydXNoaW5nLiAgVjMgaGFzIHRoaXMgZml4Lg0KDQpUaGFua3MsDQpJ
cmENCg0KPiANCj4gLS0NCj4gSm9oYW5uZXMgVGh1bXNoaXJuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNVU0UgTGFicyBGaWxlc3lzdGVtcw0KPiBqdGh1bXNoaXJuQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg5DQo+IFNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSA0KPiBNYXhmZWxkc3RyLiA1DQo+IDkwNDA5IE7DvHJu
YmVyZw0KPiBHZXJtYW55DQo+IChIUkIgMjQ3MTY1LCBBRyBNw7xuY2hlbikNCj4gS2V5IGZpbmdl
cnByaW50ID0gRUMzOCA5Q0FCIEMyQzQgRjI1RCA4NjAwIEQwRDAgMDM5MyA5NjlEIDJENzYgMDg1
MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlz
dHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
