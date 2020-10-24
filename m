Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497C297DD5
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Oct 2020 19:41:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BD6915E6076B;
	Sat, 24 Oct 2020 10:41:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.177; helo=cha2.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha2.chairmaneventsummit.info (ip177.ip-54-38-202.eu [54.38.202.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3C6A15E60769
	for <linux-nvdimm@lists.01.org>; Sat, 24 Oct 2020 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=x3qIEF+YUI1ZAajoTKzxupD6eb0=;
 b=k+Fh7q2pYb+nvdgPqv+YTStDYeD2SRCKVg9QjtGTMukDJcHKYv1fiEmxygnf6or6XExFacKdgIwz
   8OMTYr9GYQ7K1U0eTmnoqZQCmcqMiiDlmIaCCqquNKkfgMv8s7X64z6S2Nlw//IcTV2dyozfgIN+
   NhJxZXUlKtLGplusvNoIGWLqSMFPv2NAreO1MkdeVUFz4ThrraYjaIn2JruTxX5Wdep4MAMLmSjA
   eCrEqO3p4lHv7ZdBZLjwTXcjP8AbNFNHhAuFO2W0w1hw01hv0JgMm59gEqTAXVvAhuhiz5fclguV
   ISguWDGGmLrcYI6KSw/owwMDafKwPZC306SO1g==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=V/wnGtszmF8JaVYKSKnez5g7q6d4Wknxu91IIG1O6oibHg1CJyQM2xAhXYOgA5hZU3gV0D7RjkhN
   GjZ9Z8Jkbrzax8ePc4s1Jv0IB47rDNilPvdQxx6CqKCTlw/3r1Wn2nlAsKOOhNae4NA+WWhS31XE
   RgaWbM8xce6eajAYXUJXcSWY9n023+ICYyDt/CDtEoVd+BUZ8QTWAbdb/wVB567uOeBHmvrGhZ9A
   myZ0TMu88vG4f/iMgLy5Jsbj0szISq2CfCQFFdHrUQ3BidhIWcIxLkYZwRU7PM/8+OUE4wG9iWVY
   EKCxUSBovXheE4ddXLaKDwgk1AaXC2t5LQShdQ==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hihjkbi19tkd for <linux-nvdimm@lists.01.org>; Sat, 24 Oct 2020 17:40:03 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Sat, 24 Oct 2020 17:40:03 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Kimberley Rodriguez <info@chairmaneventsummit.info>
Subject: RE: 10K LinkedIn Leads at 500
Message-ID: <1a2fbfdf617cfbe2879ddaad1c84f419@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: wq522taw2qffb
X-Trgm-Subscriber-Uid: xj9408r1qtf27
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/wq522taw2qffb/report-abuse/tr3842wxgefa2/xj9408r1qtf27
Feedback-ID: wq522taw2qffb:xj9408r1qtf27:tr3842wxgefa2:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: QWZHVU33CT63WLZOMHS3ZOUMHP32I27J
X-Message-ID-Hash: QWZHVU33CT63WLZOMHS3ZOUMHP32I27J
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Kimberley Rodriguez <kim@eventattendsummits.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QWZHVU33CT63WLZOMHS3ZOUMHP32I27J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgMTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpmcm9tIExpbmtlZEluIGF0ICQ1MDA/DQpJZiB5b3UgaGF2ZSBhIHZlcnkgdGFy
Z2V0ZWQgZGF0YSByZXF1aXJlbWVudCBhbmQgeW91IG5lZWQgTGlua2VkSW4NCmRhdGFiYXNlLCB3
ZSB3aWxsIHB1bGwgdGFyZ2V0ZWQgZGF0YWJhc2VzIGZvciB5b3Ugd2l0aCB0aGVpciBMaW5rZWRJ
bg0KcHJvZmlsZSBsaW5rLCBuYW1lLCB0aXRsZSwgZW1haWwgYWRkcmVzcywgY29tcGFueSBuYW1l
LCBjaXR5LCBjb21wYW55DQpzaXplIGV0Yy4gUGxlYXNlIHNoYXJlIHlvdXIgdGFyZ2V0IGF1ZGll
bmNlIGFuZCBJIHdpbGwgc3VwcGx5IHRoZQ0Kc2FtcGxlIHdpdGhpbiAxIGJ1c2luZXNzIGRheXPi
gJkgdGltZS4NClRoYW5rcyBhbmQgbGV0IG1lIGtub3cuDQpLaW1iZXJsZXkgUm9kcmlndWV6DQpM
ZWFkIGdlbmVyYXRpb24gVGVhbQ0KKzEtKDY3OCkgNzQ1LTgzODUNCkVtYWlsIE1hcmtldGluZyBJ
bmMNClVuc3Vic2NyaWJlDQpodHRwczovL2NoYWlybWFuZXZlbnRzdW1taXQuaW5mby9lbW0vaW5k
ZXgucGhwL2xpc3RzL3RyMzg0Mnd4Z2VmYTIvdW5zdWJzY3JpYmUveGo5NDA4cjFxdGYyNy93cTUy
MnRhdzJxZmZiDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
