Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313A311529
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 23:29:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B09B4100EAAF0;
	Fri,  5 Feb 2021 14:29:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:c0c:3a97::2; helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org; receiver=<UNKNOWN> 
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7210D100EBBC1
	for <linux-nvdimm@lists.01.org>; Fri,  5 Feb 2021 14:29:00 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
	id 21106AEDEF7; Fri,  5 Feb 2021 23:28:57 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] dax-device: Some cleanups
Date: Fri,  5 Feb 2021 23:28:37 +0100
Message-Id: <20210205222842.34896-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: ULQWUJTRWFA67KG3MVGGNSAGRFZE6EU4
X-Message-ID-Hash: ULQWUJTRWFA67KG3MVGGNSAGRFZE6EU4
X-MailFrom: uwe@kleine-koenig.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULQWUJTRWFA67KG3MVGGNSAGRFZE6EU4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgZGlkbid0IGdldCBhbnkgZmVlZGJhY2sgZm9yIHRoZSAoaW1wbGljaXQpIHYx
IG9mIHRoaXMgc2VyaWVzIHRoYXQNCnN0YXJ0ZWQgd2l0aCBNZXNzYWdlLUlkOiAyMDIxMDEyNzIz
MDEyNC4xMDk1MjItMS11d2VAa2xlaW5lLWtvZW5pZy5vcmcsDQpidXQgSSBpZGVudGlmaWVkIGEg
ZmV3IGltcHJvdmVtZW50cyBteXNlbGY6DQoNCiAtIFVzZSAiZGF4LWRldmljZSIgY29uc2lzdGVu
dGx5IGFzIGEgcHJlZml4DQogLSBJbnN0ZWFkIG9mIHJlcXVpcmluZyBhIC5yZW1vdmUgY2FsbGJh
Y2ssIG1ha2UgaXQgZXhwbGljaXRseQ0KICAgb3B0aW9uYWwuIChEcm9wIGNoZWNraW5nIGZvciAu
cmVtb3ZlIGZyb20gZm9ybWVyIHBhdGNoIDEsIGludHJvZHVjZQ0KICAgbmV3IHBhdGNoICJQcm9w
ZXJseSBoYW5kbGUgZHJpdmVycyB3aXRob3V0IHJlbW92ZSBjYWxsYmFjayIpDQogLSBUaGUgbmV3
IHBhdGNoIGFib3V0IHJlbW92ZSBiZWluZyBvcHRpb25hbCBhbGxvd3MgdG8gc2ltcGxpZnkgb25l
IG9mDQogICB0aGUgdHdvIGRheCBkcml2ZXJzIHdoaWNoIGlzIGltcGxlbWVudGVkIGluIHBhdGNo
IDQNCiAtIFBhdGNoIDUgZ290IGEgYml0IHNtYWxsZXIgYmVjYXVzZSB3ZSBub3cgaGF2ZSBvbmUg
ZHJpdmVyIGxlc3Mgd2l0aCBhDQogICByZW1vdmUgY2FsbGJhY2suDQogLSBBZGRlZCBBbmRyZXcg
dG8gVG86IGFzIGhlIG1lcmdlZCBkYXggZHJpdmVycyBpbiB0aGUgcGFzdC4NCg0KQW5kcmV3OiBB
c3N1bWluZyB5b3UgY29uc2lkZXIgdGhlc2UgcGF0Y2hlcyB1c2VmdWwsIHdvdWxkIHlvdSBwbGVh
c2UNCmNhcmUgZm9yIG1lcmdpbmcgdGhlbT8NCg0KQmVzdCByZWdhcmRzDQpVd2UNCg0KVXdlIEts
ZWluZS1Lw7ZuaWcgKDUpOg0KICBkYXgtZGV2aWNlOiBQcmV2ZW50IHJlZ2lzdGVyaW5nIGRyaXZl
cnMgd2l0aG91dCBwcm9iZSBjYWxsYmFjaw0KICBkYXgtZGV2aWNlOiBQcm9wZXJseSBoYW5kbGUg
ZHJpdmVycyB3aXRob3V0IHJlbW92ZSBjYWxsYmFjaw0KICBkYXgtZGV2aWNlOiBGaXggZXJyb3Ig
cGF0aCBpbiBkYXhfZHJpdmVyX3JlZ2lzdGVyDQogIGRheC1kZXZpY2U6IERyb3AgYW4gZW1wdHkg
LnJlbW92ZSBjYWxsYmFjaw0KICBkYXgtZGV2aWNlOiBNYWtlIHJlbW92ZSBjYWxsYmFjayByZXR1
cm4gdm9pZA0KDQogZHJpdmVycy9kYXgvYnVzLmMgICAgfCAyMiArKysrKysrKysrKysrKysrKysr
Ky0tDQogZHJpdmVycy9kYXgvYnVzLmggICAgfCAgMiArLQ0KIGRyaXZlcnMvZGF4L2RldmljZS5j
IHwgIDggKy0tLS0tLS0NCiBkcml2ZXJzL2RheC9rbWVtLmMgICB8ICA3ICsrLS0tLS0NCiA0IGZp
bGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQoNCmJhc2Ut
Y29tbWl0OiA1YzhmZTU4M2NjZTU0MmFhMGI4NGFkYzkzOWNlODUyOTNkZTM2ZTVlDQotLSANCjIu
MjkuMg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
