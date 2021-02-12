Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D9D31A3B0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 18:35:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A141D100EBB76;
	Fri, 12 Feb 2021 09:35:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.244.105; helo=ceo6.ceoemailfinder.info; envelope-from=info-linux+2dnvdimm=lists.01.org@ceoemailfinder.info; receiver=<UNKNOWN> 
Received: from ceo6.ceoemailfinder.info (ip105.ip-51-83-244.eu [51.83.244.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABBD5100EBB71
	for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ceoemailfinder.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@ceoemailfinder.info;
 bh=DSdgE7i6xgFcA690sN3wu3DaGRQ=;
 b=yUWwI3qIQGpYoY396LDZlAc6KoCUFoefjXr/3xG4zBwwpWdi72vNrAxa4ASfoV7R3b+s3FKKTDM+
   uSgurhU7xrXJxdKdp76Ud5/Q61ZFHEeFunURXE2u+qMREtGtzeFq3jC0pe8Yh8qMFz6WFfw+yCX3
   vYoyudpXF5Sk5cI94W/8oziIPlV8YtZQiOLyvws+cEQuZltRrpDwlI+CSbntrJwwOS1svQRQxzGv
   o7J+qRUXZOHJIlOKetL0B6bCvlwTsBpmhMtIttOkwrTD0Q8FvpNUWJGAiTf82oAFyU8BqrZZG+NP
   Yus6nZ+2VL1Jjt8w8l1RZnpgB79bPRbtvxx3VA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=ceoemailfinder.info;
 b=jLIw8UJDYJf6bzabGq8XlrLxyN9pmhwROEwbS4T+SunDLR0ztRApjPzbuOVTzVCDz6555EKeSSu0
   7lp/xoByfI/skfwrlKLZv74zZEDcaYP7ZwacXHLH8aNXfm1AXr2o9Pw6Ejpe1wShbxpKIJZkBNlV
   vVJi1JluSHjQrmGH6P02eZe1cnJ0/GFyNX3LnHciNZYgFEBmIeWxkGHRvdrQVghHN7M1dW4oUU5P
   v77+XhysRpGodttSgdb/ZhqbJP/litg3oo9OPt0rAt8NeQeG7f8v0GeB9m32h5FKnXw9cA5GwEQE
   DQNpe+jnvpcWO2n7BKZr0nKQXZy/5U5CfP88HA==;
Received: from ceoemailfinder.info (127.0.0.1) by ceo1.ceoemailfinder.info id h4qu4ji19tkl for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 17:33:28 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info>)
Message-ID: <a1a7d205b9683087320ad5968fe816d6@ceoemailfinder.info>
Date: Fri, 12 Feb 2021 17:33:28 +0000
Subject: RE: Your Clients List
From: Emily Johnson <info@ceoemailfinder.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@ceoemailfinder.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://ceoemailfinder.info/app/index.php/campaigns/ns897sglp9b5e/report-abuse/vt3541rbjs34d/zt837z15co2f7
X-Receiver: linux-nvdimm@lists.01.org
X-Cfhh-Tracking-Did: 0
X-Cfhh-Subscriber-Uid: zt837z15co2f7
X-Cfhh-Mailer: SwiftMailer - 5.4.x
X-Cfhh-EBS: http://ceoemailfinder.info/app/index.php/lists/block-address
X-Cfhh-Delivery-Sid: 1
X-Cfhh-Customer-Uid: on987d5f1x791
X-Cfhh-Customer-Gid: 0
X-Cfhh-Campaign-Uid: ns897sglp9b5e
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: ns897sglp9b5e:zt837z15co2f7:vt3541rbjs34d:on987d5f1x791
Message-ID-Hash: D5EDYP2KVS7CFNRB5BYU2UV64N2KFZ4U
X-Message-ID-Hash: D5EDYP2KVS7CFNRB5BYU2UV64N2KFZ4U
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emily Johnson <emily.johnsontarget@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D5EDYP2KVS7CFNRB5BYU2UV64N2KFZ4U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgNTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpmcm9tIExpbmtlZEluIChBbnkgdGl0bGVzL2luZHVzdHJ5L2xvY2F0aW9uL2tl
eXdvcmRzKT8NCklmIHlvdSBoYXZlIGEgdmVyeSB0YXJnZXRlZCBkYXRhIHJlcXVpcmVtZW50IGFu
ZCB5b3UgbmVlZCBMaW5rZWRJbg0KZGF0YWJhc2UsIHdlIHdpbGwgcHVsbCB0YXJnZXRlZCBkYXRh
YmFzZXMgZm9yIHlvdSB3aXRoIHRoZWlyIExpbmtlZEluDQpwcm9maWxlIGxpbmssIG5hbWUsIHRp
dGxlLCBlbWFpbCBhZGRyZXNzLCBjb21wYW55IG5hbWUsIGNpdHksIGNvbXBhbnkNCnNpemUgZXRj
LiBQbGVhc2Ugc2hhcmUgeW91ciB0YXJnZXQgYXVkaWVuY2UgYW5kIEkgd2lsbCBzdXBwbHkgdGhl
DQpzYW1wbGUgd2l0aGluIDEgYnVzaW5lc3MgZGF5c+KAmSB0aW1lLg0KMS7CoMKgIMKgQXJjaGl0
ZWN0cyBhbmQgaW50ZXJpb3IgZGVzaWduZXJzIGVtYWlsIGxpc3QNCjIuwqDCoCDCoENFTywgb3du
ZXIsIFByZXNpZGVudCBhbmQgQ09PIGNvbnRhY3RzDQozLsKgwqAgwqBDRk8sIENvbnRyb2xsZXIs
IFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMNClBheWFibGUsIEFjY291
bnRzIFJlY2VpdmFibGUsIEF1ZGl0IENvbnRhY3RzDQo0LsKgwqAgwqBDaGllZiBIdW1hbiBSZXNv
dXJjZXMgT2ZmaWNlciwgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBIUiwNCkVtcGxveWVlIEJlbmVm
aXRzLCBFbXBsb3llZSBDb21tdW5pY2F0aW9ucywgRW1wbG95ZWUgQ29tcGVuc2F0aW9uLA0KRW1w
bG95ZWUgRW5nYWdlbWVudCwgRW1wbG95ZWUgRXhwZXJpZW5jZSBhbmQgRW1wbG95ZWUgUmVsYXRp
b25zLA0KVGFsZW50IEFjcXVpc2l0aW9uLCBUYWxlbnQgRGV2ZWxvcG1lbnQsIFRhbGVudCBNYW5h
Z2VtZW50LCBSZWNydWl0aW5nDQpDb250YWN0cw0KNS7CoMKgIMKgQ0lPLENUTywgQ0lTTywgVlAv
RGlyZWN0b3IvTWFuYWdlciBvZiBJVCwgSVQgQ29tcGxpYW5jZSwgSVQNClJpc2ssIEJJLCBDbG91
ZCwgRGF0YWJhc2UgYW5kIElUIFNlY3VyaXR5IENvbnRhY3RzDQo2LsKgwqAgwqBDTU8sIFZQL0Rp
cmVjdG9yL01hbmFnZXIgb2YgTWFya2V0aW5nLCBzb2NpYWwgbWVkaWEsIFNhbGVzLA0KZGVtYW5k
IGdlbmVyYXRpb24sIExlYWQgZ2VuZXJhdGlvbiwgaW5zaWRlIHNhbGVzLCBNYXJrZXRpbmcNCkNv
bW11bmljYXRpb25zIGNvbnRhY3RzIGV0Yy4NCjcuwqDCoCDCoENvbXBsaWFuY2UgYW5kIFJpc2sg
TWFuYWdlbWVudCBDb250YWN0cw0KOC7CoMKgIMKgQ1BBIGFuZCBCb29ra2VlcGVycyBlbWFpbCBs
aXN0DQo5LsKgwqAgwqBEYXRhIEFuYWx5dGljcyBhbmQgRGF0YWJhc2UgQWRtaW5pc3RyYXRvcnMg
Y29udGFjdHMNCjEwLsKgwqAgwqBEaXNhc3RlciBSZWNvdmVyeSBDb250YWN0cw0KMTEuwqDCoCDC
oEUtY29tbWVyY2Ugb3Igb25saW5lIHJldGFpbGVycyBlbWFpbCBsaXN0DQoxMi7CoMKgIMKgRWR1
Y2F0aW9uIGluZHVzdHJ5IGV4ZWN1dGl2ZXMgZW1haWwgbGlzdCAtIFByaW5jaXBhbHMsDQpEZWFu
LCBBZG1pbnMgYW5kIHRlYWNoZXJzIGZyb20gU2Nob29scywgQ29sbGVnZXMgYW5kIFVuaXZlcnNp
dGllcw0KMTMuwqDCoCDCoEVuZ2luZWVycyBlbWFpbCBsaXN0DQoxNC7CoMKgIMKgRXZlbnQgYW5k
IG1lZXRpbmcgcGxhbm5lcnMgZW1haWwgbGlzdA0KMTUuwqDCoCDCoEZhY2lsaXRpZXMgYW5kIG9m
ZmljZSBtYW5hZ2VyIENvbnRhY3RzDQoxNi7CoMKgIMKgR2VuZXJhbCBhbmQgY29ycG9yYXRlIGNv
dW5zZWwgYXMgd2VsbCBsZWdhbCBwcm9mZXNzaW9uYWxzDQpsaXN0DQoxNy7CoMKgIMKgR292ZXJu
bWVudCBjb250cmFjdG9ycyBlbWFpbCBsaXN0DQoxOC7CoMKgIMKgSGVhbHRoICYgU2FmZXR5IENv
bnRhY3RzDQoxOS7CoMKgIMKgSGlnaCBuZXQgd29ydGggaW5kaXZpZHVhbHMvaW52ZXN0b3JzIGVt
YWlsIGxpc3QNCjIwLsKgwqAgwqBIb3NwaXRhbHMsIGNsaW5pY3MsIHByaXZhdGUgcHJhY3RpY2Vz
LCBQaGFybWFjZXV0aWNhbCBhbmQNCmJpb3RlY2hub2xvZ3kgY29tcGFueeKAmXMgdG9wIGRlY2lz
aW9uIG1ha2VycyBlbWFpbCBsaXN0DQoyMS7CoMKgIMKgSHVtYW4gQ2FwaXRhbCBNYW5hZ2VtZW50
IENvbnRhY3RzDQoyMi7CoMKgIMKgSW5kaXZpZHVhbCBpbnN1cmFuY2UgYWdlbnRzIGxpc3QNCjIz
LsKgwqAgwqBJU1YvVkFScyBsaXN0DQoyNC7CoMKgIMKgTGVhcm5pbmcgJiBEZXZlbG9wbWVudCBD
b250YWN0cw0KMjUuwqDCoCDCoExvZ2lzdGljcywgc2hpcHBpbmcgYW5kIHN1cHBseSBjaGFpbiBt
YW5hZ2VycyBlbWFpbCBsaXN0DQoyNi7CoMKgIMKgTWFudWZhY3R1cmluZyBJbmR1c3RyeSBleGVj
dXRpdmVzIGxpc3QNCjI3LsKgwqAgwqBOZXR3b3JrIG1hbmFnZXIsIFN1cnZlaWxsYW5jZSwgU3lz
dGVtIEFkbWluaXN0cmF0b3IsDQpUZWNobmljYWwgU3VwcG9ydCBDb250YWN0cw0KMjguwqDCoCDC
oE5ldyAmIFVzZWQgQ2FyIERlYWxlcnMgZW1haWwgbGlzdA0KMjkuwqDCoCDCoE9pbCwgR2FzIGFu
ZCB1dGlsaXR5IGluZHVzdHJ5IGNvbnRhY3RzDQozMC7CoMKgIMKgUGh5c2ljaWFucywgRG9jdG9y
cywgTnVyc2VzLCBEZW50aXN0cywgVGhlcmFwaXN0cyBlbWFpbA0KbGlzdA0KMzEuwqDCoCDCoFBs
YW50IE1hbmFnZXIgQ29udGFjdHMNCjMyLsKgwqAgwqBQcm9kdWN0IGFuZCBwcm9qZWN0IG1hbmFn
ZW1lbnQgbGlzdA0KMzMuwqDCoCDCoFB1cmNoYXNpbmcgYW5kIFByb2N1cmVtZW50IENvbnRhY3Rz
DQozNC7CoMKgIMKgU3BlY2lmaWMgRXZlbnQgYXR0ZW5kZWVzIGxpc3QNCjM1LsKgwqAgwqBUZWxl
Y29tIG1hbmFnZXJzLCBWT0lQIG1hbmFnZXJzLCBDbG91ZCBhcmNoaXRlY3QsIENsb3VkDQptYW5h
Z2VycywgU3RvcmFnZSBtYW5hZ2VycyBlbWFpbCBsaXN0DQozNi7CoMKgIMKgVlAvRGlyZWN0b3Iv
TWFuYWdlciBvZiBDdXN0b21lciBTZXJ2aWNlIGFuZCBDdXN0b21lcg0KU3VjY2Vzcw0KVGhhbmtz
IGFuZCBsZXQgbWUga25vdy4NCkVtaWx5IEpvaG5zb24NCkRhdGFiYXNlIE1hcmtldGluZw0KVW5z
dWJzY3JpYmUNCmh0dHA6Ly9jZW9lbWFpbGZpbmRlci5pbmZvL2FwcC9pbmRleC5waHAvbGlzdHMv
dnQzNTQxcmJqczM0ZC91bnN1YnNjcmliZS96dDgzN3oxNWNvMmY3L25zODk3c2dscDliNWUNCsKg
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
