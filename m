Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C431C29C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 20:45:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97981100EBB9F;
	Mon, 15 Feb 2021 11:44:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.244.104; helo=ceo5.ceoemailfinder.info; envelope-from=info-linux+2dnvdimm=lists.01.org@ceoemailfinder.info; receiver=<UNKNOWN> 
Received: from ceo5.ceoemailfinder.info (ip104.ip-51-83-244.eu [51.83.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B904100EBB6B
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ceoemailfinder.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@ceoemailfinder.info;
 bh=kU/xTuXuCr8MO77l/3YQic9/Wew=;
 b=WYPwvcl4svIjtMvd403uwhTBxi3lwlyt7c8rKYfzdxmScSN0YLlxbY603axqMCvARpZYCniXrsUH
   LdrOmXEW1fcOtQuVaLQ94rBq/V9QPX7/ZKAKuysF2vhZalBwRVdbbk929jbxNu/EHUi4iBtbqYW5
   7soYsg79uIlZHKelV8F+PYe8CPuw28yxu00+COtL0zt38ABCgVKDTZFVcdlZEK6sIHT0oCjBVKPN
   ch71hPXvCuC+47baiTxIymTmP23QBT0PIMiJC11xED+BRYIxCujb+eEXvSN2oUay7OaiVJ/No4gg
   WztdHtoLkPeh+qHpWte8r9vlsW+J6SaInfhfVQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=ceoemailfinder.info;
 b=S2ptA94HOJpdqFQW240GvyewZQAftFVn87YOU6h2+Vev/309dLudbz2oIcPuXfSsg3Ck0see1GWF
   sE+Fdu3I4Fj6Oabwn51P0d98veS4dKVl2z2FbOBZXcS4Yjf5NG9mMeMsH+nOSVkT9Yu7/hxghzhg
   tvpW51E2cV0baaPgtEzPCsAgeI8R/NiYyb3mEfAub2veOU/WqYG3uPuH7gi7Lw6N/qk0a0JtYtGJ
   0KTmG5HVyZ2UOAAkTYwzK1NOHoOuvlQAS1a5ffNrR29RF7RCEyR1ER1FgzrRFKJDkW7ivXqsmDjo
   qdVSaABppsJkVV/YIQ6akvVRHPZfFMEOqeSXxQ==;
Received: from ceoemailfinder.info (127.0.0.1) by ceo1.ceoemailfinder.info id h5b7jfi19tkn for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 19:44:47 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info>)
Message-ID: <f20412afae530345ff80b7da7e252bed@ceoemailfinder.info>
Date: Mon, 15 Feb 2021 19:44:47 +0000
Subject: RE: did you see this email
From: Emily Johnson <info@ceoemailfinder.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@ceoemailfinder.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://ceoemailfinder.info/app/index.php/campaigns/jh1090yw5n998/report-abuse/vt3541rbjs34d/zt837z15co2f7
X-Receiver: linux-nvdimm@lists.01.org
X-Cfhh-Tracking-Did: 0
X-Cfhh-Subscriber-Uid: zt837z15co2f7
X-Cfhh-Mailer: SwiftMailer - 5.4.x
X-Cfhh-EBS: http://ceoemailfinder.info/app/index.php/lists/block-address
X-Cfhh-Delivery-Sid: 1
X-Cfhh-Customer-Uid: on987d5f1x791
X-Cfhh-Customer-Gid: 0
X-Cfhh-Campaign-Uid: jh1090yw5n998
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: jh1090yw5n998:zt837z15co2f7:vt3541rbjs34d:on987d5f1x791
Message-ID-Hash: 5ZOXXQIIHT2OS623VDHJT2VR5JPA4PI3
X-Message-ID-Hash: 5ZOXXQIIHT2OS623VDHJT2VR5JPA4PI3
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emily Johnson <emily.johnsontarget@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5ZOXXQIIHT2OS623VDHJT2VR5JPA4PI3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V2UgYXJlIG9mZmVycmluZyA1MCBmcmVlIGRhdGEgc2FtcGxlIGZyb20geW91ciB0YXJnZXQgYXVk
aWVuY2UsIGlmIHlvdQ0KYXJlIGhhcHB5IHdpdGggdGhhdCB5b3UgY2FuIGJ1eSBvdXIgZGF0YWJh
c2UsIGFyZSB5b3UgaW50ZXJlc3RlZCB0byBkbw0KdGhhdD8gV2UgZ2F0aGVyIGRhdGFiYXNlIGZy
b20gTGlua2VkSW4sIGV2ZW50cywgb25saW5lIHN1Ym1pc3Npb25zLA0KYjJiIHBvcnRhbHMsIG1h
cmtldCByZXNlYXJjaCBldGMuIDkwJSBhY2N1cmFjeSBndXJhbnRlZSBvbiBvdXINCmRhdGFiYXNl
Lg0KKiBBcmNoaXRlY3RzIGFuZCBpbnRlcmlvciBkZXNpZ25lcnMgZW1haWwgbGlzdA0KKiBDRU8s
IG93bmVyLCBQcmVzaWRlbnQgYW5kIENPTyBjb250YWN0cw0KKiBDRk8sIENvbnRyb2xsZXIsIFZQ
L0RpcmVjdG9yL01hbmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMgUGF5YWJsZSwNCkFjY291bnRz
IFJlY2VpdmFibGUsIEF1ZGl0IENvbnRhY3RzDQoqIENoaWVmIEh1bWFuIFJlc291cmNlcyBPZmZp
Y2VyLCBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEhSLCBFbXBsb3llZQ0KQmVuZWZpdHMsIEVtcGxv
eWVlIENvbW11bmljYXRpb25zLCBFbXBsb3llZSBDb21wZW5zYXRpb24sIEVtcGxveWVlDQpFbmdh
Z2VtZW50LCBFbXBsb3llZSBFeHBlcmllbmNlIGFuZCBFbXBsb3llZSBSZWxhdGlvbnMsIFRhbGVu
dA0KQWNxdWlzaXRpb24sIFRhbGVudCBEZXZlbG9wbWVudCwgVGFsZW50IE1hbmFnZW1lbnQsIFJl
Y3J1aXRpbmcNCkNvbnRhY3RzDQoqIENJTyxDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIg
b2YgSVQsIElUIENvbXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJ
VCBTZWN1cml0eSBDb250YWN0cw0KKiBDTU8sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgTWFya2V0
aW5nLCBzb2NpYWwgbWVkaWEsIFNhbGVzLCBkZW1hbmQNCmdlbmVyYXRpb24sIExlYWQgZ2VuZXJh
dGlvbiwgaW5zaWRlIHNhbGVzLCBNYXJrZXRpbmcgQ29tbXVuaWNhdGlvbnMNCmNvbnRhY3RzIGV0
Yy4NCiogQ29tcGxpYW5jZSBhbmQgUmlzayBNYW5hZ2VtZW50IENvbnRhY3RzDQoqIENQQSBhbmQg
Qm9va2tlZXBlcnMgZW1haWwgbGlzdA0KKiBEYXRhIEFuYWx5dGljcyBhbmQgRGF0YWJhc2UgQWRt
aW5pc3RyYXRvcnMgY29udGFjdHMNCiogRGlzYXN0ZXIgUmVjb3ZlcnkgQ29udGFjdHMNCiogRS1j
b21tZXJjZSBvciBvbmxpbmUgcmV0YWlsZXJzIGVtYWlsIGxpc3QNCiogRWR1Y2F0aW9uIGluZHVz
dHJ5IGV4ZWN1dGl2ZXMgZW1haWwgbGlzdCAtIFByaW5jaXBhbHMsIERlYW4sDQpBZG1pbnMgYW5k
IHRlYWNoZXJzIGZyb20gU2Nob29scywgQ29sbGVnZXMgYW5kIFVuaXZlcnNpdGllcw0KKiBFbmdp
bmVlcnMgZW1haWwgbGlzdA0KKiBFdmVudCBhbmQgbWVldGluZyBwbGFubmVycyBlbWFpbCBsaXN0
DQoqIEZhY2lsaXRpZXMgYW5kIG9mZmljZSBtYW5hZ2VyIENvbnRhY3RzDQoqIEdlbmVyYWwgYW5k
IGNvcnBvcmF0ZSBjb3Vuc2VsIGFzIHdlbGwgbGVnYWwgcHJvZmVzc2lvbmFscyBsaXN0DQoqIEdv
dmVybm1lbnQgY29udHJhY3RvcnMgZW1haWwgbGlzdA0KKiBIZWFsdGggJiBTYWZldHkgQ29udGFj
dHMNCiogSGlnaCBuZXQgd29ydGggaW5kaXZpZHVhbHMvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCiog
SG9zcGl0YWxzLCBjbGluaWNzLCBwcml2YXRlIHByYWN0aWNlcywgUGhhcm1hY2V1dGljYWwgYW5k
DQpiaW90ZWNobm9sb2d5IGNvbXBhbnnigJlzIHRvcCBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlz
dA0KKiBIdW1hbiBDYXBpdGFsIE1hbmFnZW1lbnQgQ29udGFjdHMNCiogSW5kaXZpZHVhbCBpbnN1
cmFuY2UgYWdlbnRzIGxpc3QNCiogSVNWL1ZBUnMgbGlzdA0KKiBMZWFybmluZyAmIERldmVsb3Bt
ZW50IENvbnRhY3RzDQoqIExvZ2lzdGljcywgc2hpcHBpbmcgYW5kIHN1cHBseSBjaGFpbiBtYW5h
Z2VycyBlbWFpbCBsaXN0DQoqIE1hbnVmYWN0dXJpbmcgSW5kdXN0cnkgZXhlY3V0aXZlcyBsaXN0
DQoqIE5ldHdvcmsgbWFuYWdlciwgU3VydmVpbGxhbmNlLCBTeXN0ZW0gQWRtaW5pc3RyYXRvciwg
VGVjaG5pY2FsDQpTdXBwb3J0IENvbnRhY3RzDQoqIE5ldyAmIFVzZWQgQ2FyIERlYWxlcnMgZW1h
aWwgbGlzdA0KKiBPaWwsIEdhcyBhbmQgdXRpbGl0eSBpbmR1c3RyeSBjb250YWN0cw0KKiBQaHlz
aWNpYW5zLCBEb2N0b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QN
CiogUGxhbnQgTWFuYWdlciBDb250YWN0cw0KKiBQcm9kdWN0IGFuZCBwcm9qZWN0IG1hbmFnZW1l
bnQgbGlzdA0KKiBQdXJjaGFzaW5nIGFuZCBQcm9jdXJlbWVudCBDb250YWN0cw0KKiBTcGVjaWZp
YyBFdmVudCBhdHRlbmRlZXMgbGlzdA0KKiBUZWxlY29tIG1hbmFnZXJzLCBWT0lQIG1hbmFnZXJz
LCBDbG91ZCBhcmNoaXRlY3QsIENsb3VkIG1hbmFnZXJzLA0KU3RvcmFnZSBtYW5hZ2VycyBlbWFp
bCBsaXN0DQoqIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgQ3VzdG9tZXIgU2VydmljZSBhbmQgQ3Vz
dG9tZXIgU3VjY2Vzcw0KVGhhbmtzIGFuZCBsZXQgbWUga25vdy4NCkVtaWx5IEpvaG5zb24NCkRh
dGFiYXNlIE1hcmtldGluZw0KVW5zdWJzY3JpYmUNCmh0dHA6Ly9jZW9lbWFpbGZpbmRlci5pbmZv
L2FwcC9pbmRleC5waHAvbGlzdHMvdnQzNTQxcmJqczM0ZC91bnN1YnNjcmliZS96dDgzN3oxNWNv
MmY3L2poMTA5MHl3NW45OTgNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
