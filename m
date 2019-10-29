Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7BE7ECD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 29 Oct 2019 04:16:34 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54D2B100EA529;
	Mon, 28 Oct 2019 20:17:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.236.179.24; helo=info0.azulejosbenadresa.ga; envelope-from=info@azulejosbenadresa.ga; receiver=<UNKNOWN> 
Received: from info0.azulejosbenadresa.ga (info0.azulejosbenadresa.ga [192.236.179.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85D2D100EA528
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=azulejosbenadresa.ga;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 i=info@azulejosbenadresa.ga;
 bh=AtVKGLxOFfPC8HdZql2OoKAQG9m00j00/x3pBmue9Cs=;
 b=Si74CcIWf0mGVSp0d7WDEhKS7akiJhkRQYXBttS4/uYQ/te8CyrETm3eeirP3fz1K2xIeQoomc96
   RwcRtGFkKfrTe75LQaDJu9qOmVQXx+qTIHQgnUM45o2fFA6X7V2kNrYM0bRf7G8EUXW8GlQkXnqu
   AtGYKZfcJx43vSczykk=
From: info@azulejosbenadresa.ga
To: linux-nvdimm@lists.01.org
Subject: Re: Complete PO-008293 For Review
Date: 28 Oct 2019 20:16:26 -0700
Message-ID: <20191028201626.6BD236DCFBECB14A@azulejosbenadresa.ga>
MIME-Version: 1.0
Message-ID-Hash: NIAGOCUAYBKTFFFT3TTUJ4QSKF7UYQLO
X-Message-ID-Hash: NIAGOCUAYBKTFFFT3TTUJ4QSKF7UYQLO
X-MailFrom: info@azulejosbenadresa.ga
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NIAGOCUAYBKTFFFT3TTUJ4QSKF7UYQLO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpTb3JyeSBmb3IgZGVsYXkuDQoNCkkgaGF2ZSBhdHRhY2hlZCBjb21wbGV0ZSBvcmRlciBmb3Ig
aW1tZWRpYXRlIHByb2Nlc3NpbmcsIGFsc28gDQpmZWVsIGZyZWUgdG8gZ2V0IGJhY2sgdG8gbWUg
d2l0aCBhbnkgY29ycmVjdGlvbnMgaWYgbmVlZCBiZS4NCg0KLS0tLcKgDQoNClJlZ2FyZHMsDQoN
CkF6dWxlam8gTHRkDQppbmZvQGF6dWxlam9zYmVuYWRyZXNhLmdhDQpDZWxsOiArMzQgNjYwIDI5
MSA4MTUNClNUL0F2LmRlbCBNYXIgNjEsIDZCDQpDLlAuIDEyMDAzDQpDYXN0ZWxsb24NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
