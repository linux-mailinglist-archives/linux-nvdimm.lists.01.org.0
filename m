Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2DC284C5B
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Oct 2020 15:15:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18D721559C379;
	Tue,  6 Oct 2020 06:15:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.113.234.62; helo=apageyantak.us; envelope-from=fyhuxagae@apageyantak.us; receiver=<UNKNOWN> 
Received: from apageyantak.us (apageyantak.us [194.113.234.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F41291557AA8F
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mail; d=apageyantak.us;
 h=To:MIME-Version:Subject:From:Message-ID:Content-Type:Date:List-Archive;
 i=fyhuxagae@apageyantak.us;
 bh=X0nwzzXVAFmVZLS+r8QJp2ZQnXU5NfORFdMI59HSJq8=;
 b=uhx2oZytQGmcNLPN1Ad3K7YHnas+fZc7KEoKsnKzyI9gdBg809XyxzpkIiKoUd2YxVXCiYOLoiga
   TZU3C8oQTHER5r67Ih8ZWCIwUZg3gJhTzpbuOSm3IWM8Yyk+2qoGPkPQhj/B1AZuAiT5U56jBJzN
   iOqnDqhbvqIRszbMW+E=
To: linux-nvdimm@lists.01.org
MIME-Version: 1.0
Subject: Communication N-4267IA3058
From: Sombre Union <fyhuxagae@apageyantak.us>
Message-ID: <28001609810554.448228.80280.087.855518@delivery2o.cmail.apageyantak.us>
Date: Tue, 6 Oct 2020 10:09:27 -0700
Message-ID-Hash: PMHULTBK73YZ26PABHYCSJY5VON2HH3P
X-Message-ID-Hash: PMHULTBK73YZ26PABHYCSJY5VON2HH3P
X-MailFrom: fyhuxagae@apageyantak.us
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PMHULTBK73YZ26PABHYCSJY5VON2HH3P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

SGksIA0KDQpJIGhvcGUgdGhhdCB5b3UgYXJlIGRvaW5nIHdlbGwuIFBsZWFzZSBzZWUgYXR0YWNo
ZWQgaW52b2ljZS4gQ2FuIHlvdSBwbGVhc2Ugc2VuZCB0byB0aGUgYXBwcm9wcmlhdGUgcGFydHku
IA0KDQpUaGFuayB5b3UsIA0KDQpNYWxjb20gTWFqa2ENCkFkbWluaXN0cmF0b3INCkguQS4gRGVI
YXJ0ICYgU29uLCBJbmMgDQozMTEgQ3Jvd24gUG9pbnQgUm9hZA0KU2hlcGhlcmRzdG93biBEZWxh
d2FyZSA4NTU4OQ0KODU2LTg0NS0wNzA1DQoNCnVuc3Vic2NyaWJlwqDCoHByaXZhY3kgcG9saWN5
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
