Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48915338831
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 10:04:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D389100EAB58;
	Fri, 12 Mar 2021 01:04:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.75.37.24; helo=bra5.presidentsummit2021.info; envelope-from=domain-adm-linux+2dnvdimm=lists.01.org@presidentsummit2021.info; receiver=<UNKNOWN> 
Received: from bra5.presidentsummit2021.info (ip24.ip-51-75-37.eu [51.75.37.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9800100EAB4D
	for <linux-nvdimm@lists.01.org>; Fri, 12 Mar 2021 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=gmail.com;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=addilyn.davis2021@gmail.com;
 bh=7oIg77nbXJ8QUeq72ZFclDuHp5w=;
 b=ChR9w9rhAtbNDxZEMkm1vrLMTSEkHumDi/+91RCh9Ob2r2W1wPftu0VrhIw7fnhSRC8nlpY9Egz5
   C1aRhvbKd6P82yu/kz9aADC54FMppohzTVV5AJux1cQsQiWL++XzKLaQ0AzSisfkQrxvixGZG2Y4
   yCwMEeWVeQZ02iibwnjEoBepnCD0gE7Fki0uGSPWUfSKRK4hjPw9seBNBlg1qK/Uaj3kW6YVvwlE
   +LXrsGBmfNmFwSPmL8tg2zZ6e58xUIvt/1SiKg4v21YIWFJdgTQn9+F8B+ac+39JWasK02SoMbMP
   FdRcXvft1zKsr4Q4XRJctBYlISObrKT5wE5OtQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=gmail.com;
 b=MOyVqeWPFEwAhEycaaH9SOLRoroGe2BA+0adPYwio7eiC75+qrdO6/OZGjRVZjqo7WzK8C2DDS9O
   e7IcutIP4SBR0FLt7iFpCi6rt5yIuH7nQHqh8ACn+gSbYqo9xQ2OpqIprJykfdi/9odjHqEgvv3R
   ozfQJDtN85lWh51W+/Ehso8REQilIOurQMszANVsWcdYMQ5JoNcaycwSKQ+kadRREjtUK6rcil2e
   G9yqK1GuWq1ajuNaIVs0rj9HRjjflBaueG8XOsUJ/PAnolpF9absAd2mzshRGCUq0fBSKFDsCyrX
   ddsETyWHJa0d1rOYNOQFOz8UegcjIvI3IL55ag==;
Received: from brandtrendonline.xyz (127.0.0.1) by bra1.presidentsummit2021.info id h9cn99i19tkg for <linux-nvdimm@lists.01.org>; Fri, 12 Mar 2021 07:04:01 +0000 (envelope-from <domain-adm-linux+2Dnvdimm=lists.01.org@presidentsummit2021.info>)
Message-ID: <fa80fe8c72325d6017446f5c3c46bf5f@presidentsummit2021.info>
Date: Fri, 12 Mar 2021 07:04:01 +0000
Subject: RE: follow up
From: Addilyn Davis <addilyn.davis2021@gmail.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Vmnn-Tracking-Did: 0
X-Vmnn-Subscriber-Uid: rq915xxmxp8f7
X-Vmnn-Mailer: SwiftMailer - 5.4.x
X-Vmnn-EBS: https://brandtrendonline.xyz/app/index.php/lists/block-address
X-Vmnn-Delivery-Sid: 1
X-Vmnn-Customer-Uid: cl2968o8ac47b
X-Vmnn-Customer-Gid: 0
X-Vmnn-Campaign-Uid: md1677zwfwc87
X-Sender: domain-adm@presidentsummit2021.info
X-Report-Abuse: Please report abuse for this campaign here:
 https://brandtrendonline.xyz/app/index.php/campaigns/md1677zwfwc87/report-abuse/ry381vynw7a4b/rq915xxmxp8f7
X-Receiver: linux-nvdimm@lists.01.org
Precedence: bulk
Feedback-ID: md1677zwfwc87:rq915xxmxp8f7:ry381vynw7a4b:cl2968o8ac47b
Message-ID-Hash: LBDPPO4TPVJFQHSYL5IWCIOHVOBULQ2P
X-Message-ID-Hash: LBDPPO4TPVJFQHSYL5IWCIOHVOBULQ2P
X-MailFrom: domain-adm-linux+2Dnvdimm=lists.01.org@presidentsummit2021.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Addilyn Davis <addilyn.davis2021@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LBDPPO4TPVJFQHSYL5IWCIOHVOBULQ2P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V291bGQgeW91IGxpa2UgdG8gcHVyY2hhc2UgYW55IG9mIHRoZXNlIGZvbGxvd2luZyBkaXNjb3Vu
dGVkIDkwJQ0KYWNjdXJhdGUgZGF0YWJhc2VzPyBXZSBoYXZlIGdsb2JhbCBjb3ZlcmFnZSBvZiB0
aGVzZSBkYXRhYmFzZXMuDQooNTAgRlJFRSBzYW1wbGUgYXZhaWxhYmxlIG9uIHJlcXVlc3QpDQox
LsKgwqAgwqAxMzcsNDkzIEF0dG9ybmV5cyBhbmQgTGF3eWVycyBlbWFpbCBsaXN0IGF0ICQxLDM3
NA0KMi7CoMKgIMKgMTI4LDk3MiBBcmNoaXRlY3RzIGFuZCBpbnRlcmlvciBkZXNpZ25lcnMgZW1h
aWwgbGlzdCBhdA0KJDEsMjg5DQozLsKgwqAgwqAyMDAsMDAwIEJ1aWxkZXJzLCBwcm9wZXJ0eSBk
ZXZlbG9wZXJzIGFuZCBjb25zdHJ1Y3Rpb24NCmluZHVzdHJ5IGRlY2lzaW9uIG1ha2VycyBlbWFp
bCBsaXN0IGF0ICQyLDUwMA0KNC7CoMKgIMKgMU1pbCBDRU9zLCBvd25lcnMsIFByZXNpZGVudHMg
YW5kIE1EcyBlbWFpbCBsaXN0IGF0ICQ1LDAwMA0KNS7CoMKgIMKgMjAwLDAwMCBDRk8sIENvbnRy
b2xsZXIsIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgRmluYW5jZSwNCkFjY291bnRzIFBheWFibGUs
IEFjY291bnRzIFJlY2VpdmFibGUsIEF1ZGl0IG1hbmFnZXJzIGVtYWlsIGxpc3QgYXQNCiQyLDAw
MA0KNi7CoMKgIMKgNTAwLDAwMCBDSU8sIENUTywgQ0lTTywgVlAvRGlyZWN0b3IvTWFuYWdlciBv
ZiBJVCwgSVQNCkNvbXBsaWFuY2UsIElUIFJpc2ssIEJJLCBDbG91ZCwgRGF0YWJhc2UgYW5kIElU
IFNlY3VyaXR5IG1hbmFnZXJzDQplbWFpbCBsaXN0IGF0ICQ1LDAwMA0KNy7CoMKgIMKgNTAsMDAw
IENvbW1lcmNpYWwgcHJvcGVydHkgb3duZXJzIGVtYWlsIGxpc3QgYXQgJDEsMDAwDQo4LsKgwqAg
wqA1MCwwMDAgQ29tcGxpYW5jZSBhbmQgUmlzayBNYW5hZ2VtZW50IG1hbmFnZXJzIGVtYWlsIGxp
c3QgYXQNCiQxLDAwMA0KOS7CoMKgIMKgMTAwLDAwMCBDUEEgYW5kIEJvb2trZWVwZXJzIGVtYWls
IGxpc3QgYXQgJDIsMDAwDQoxMC7CoMKgIMKgMTAwLDAwMCBEYXRhIHNjaWVudGlzdCwgRGF0YSBB
bmFseXRpY3MgYW5kIERhdGFiYXNlDQpBZG1pbmlzdHJhdG9ycyBlbWFpbCBsaXN0IGF0ICQyLDAw
MA0KMTEuwqDCoCDCoDEwMCwwMDAgRS1jb21tZXJjZSBvciBvbmxpbmUgcmV0YWlsZXJzIGVtYWls
IGxpc3QgYXQgJDIsMDAwDQoxMi7CoMKgIMKgNTAwLDAwMCBFZHVjYXRpb24gaW5kdXN0cnkgZXhl
Y3V0aXZlcyBlbWFpbCBsaXN0IGF0ICQ1LDAwMC0NClByaW5jaXBhbHMsIERlYW4sIEFkbWlucyBh
bmQgdGVhY2hlcnMgZnJvbSBTY2hvb2xzLCBDb2xsZWdlcyBhbmQNClVuaXZlcnNpdGllcw0KMTMu
wqDCoCDCoDEwMCwwMDAgRW5naW5lZXJzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQoxNC7CoMKgIMKg
MTAwLDAwMCBFdmVudCBhbmQgTWVldGluZyBwbGFubmVycywgb3JnYW5pemVycywgYW5kDQpleGhp
Yml0b3JzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQoxNS7CoMKgIMKgMTAwLDAwMCBGYWNpbGl0aWVz
LCBvZmZpY2UgYW5kIG1haW50ZW5hbmNlIG1hbmFnZXJzIGVtYWlsDQpsaXN0IGF0ICQyLDAwMA0K
MTYuwqDCoCDCoDEwMCwwMDAgRmluYW5jaWFsIHBsYW5uZXIvYWR2aXNvcnMgZW1haWwgbGlzdCBh
dCAkMiwwMDANCjE3LsKgwqAgwqA1MCwwMDAgRmxlZXQgbWFuYWdlcnMgYW5kIFRydWNraW5nIGNv
bXBhbnkgb3duZXJzIGVtYWlsDQpsaXN0IGF0ICQyLDAwMA0KMTguwqDCoCDCoDEwMCwwMDAgR2Vu
ZXJhbCBhbmQgY29ycG9yYXRlIGNvdW5zZWxzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQoxOS7CoMKg
IMKgNTAsMDAwIEdvdmVybm1lbnQgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QgYXQgJDEsMDAw
DQoyMC7CoMKgIMKgNTAsMDAwIEhlYWx0aCwgZW52aXJvbm1lbnQgJiBTYWZldHkgbWFuYWdlcnMg
ZW1haWwgbGlzdCBhdA0KJDEsMDAwDQoyMS7CoMKgIMKgNTAwLDAwMCBIaWdoIG5ldCB3b3J0aCBp
bmRpdmlkdWFscy9pbnZlc3RvcnMgZW1haWwgbGlzdCBhdA0KJDUsMDAwDQoyMi7CoMKgIMKgMk1p
bCBIb21lb3duZXJzLCBBcGFydG1lbnQgb3duZXJzIGFuZCBCdWlsZGluZyBvd25lcnMgZW1haWwN
Cmxpc3QgYXQgJDUsMDAwDQoyMy7CoMKgIMKgMzAwLDAwMCBIb3NwaXRhbHMsIGNsaW5pY3MsIHBy
aXZhdGUgcHJhY3RpY2VzLA0KUGhhcm1hY2V1dGljYWwgYW5kIGJpb3RlY2hub2xvZ3kgY29tcGFu
eeKAmXMgdG9wIGRlY2lzaW9uIG1ha2VycyBlbWFpbA0KbGlzdCBhdCAkMywwMDANCjI0LsKgwqAg
wqA1MDAsMDAgSFIsIFRyYWluaW5nLCBMZWFybmluZyAmIERldmVsb3BtZW50LCBFbXBsb3llZQ0K
QmVuZWZpdHMsIFRhbGVudCBBY3F1aXNpdGlvbiwgUmVjcnVpdGluZyBkZWNpc2lvbiBtYWtlcnMg
ZW1haWwgbGlzdCBhdA0KJDUsMDAwDQoyNS7CoMKgIMKgNTAsMDAwIEluZGl2aWR1YWwgaW5zdXJh
bmNlIGFnZW50cyBlbWFpbCBsaXN0IGF0ICQxLDAwMA0KMjYuwqDCoCDCoDUwLDAwMCBJU1YvVkFS
cy9SZXNlbGxlcnMgZW1haWwgbGlzdCBhdCAkMSwwMDANCjI3LsKgwqAgwqA1MCwwMDAgTG9naXN0
aWNzLCBzaGlwcGluZywgYW5kIHN1cHBseSBjaGFpbiBtYW5hZ2VycyBlbWFpbA0KbGlzdCBhdCAk
MSwwMDANCjI4LsKgwqAgwqAxTWlsIE1hbnVmYWN0dXJpbmcgSW5kdXN0cnkgZGVjaXNpb24gbWFr
ZXJzIGVtYWlsIGxpc3QgYXQNCiQ1LDAwMA0KMjkuwqDCoCDCoDUwMCwwMDAgTWFya2V0aW5nLCBz
b2NpYWwgbWVkaWEsIFNhbGVzLCBkZW1hbmQgZ2VuZXJhdGlvbiwNCkxlYWQgZ2VuZXJhdGlvbiBk
ZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdCBhdCAkNSwwMDANCjMwLsKgwqAgwqAyMDAsMDAwIE5l
dyAmIFVzZWQgQ2FyIERlYWxlcnMgZW1haWwgbGlzdCBhdCAkMiwwMDANCjMxLsKgwqAgwqA1MDAs
MDAwIE9pbCwgR2FzIGFuZCB1dGlsaXR5IGluZHVzdHJ5IGRlY2lzaW9uIG1ha2VycyBlbWFpbA0K
bGlzdCBhdCAkNCwwMDANCjMyLsKgwqAgwqA1MCwwMDAgcGhhcm1hY2lzdCBhbmQgcGhhcm1hY3kg
b3duZXJzIGVtYWlsIGxpc3QgYXQgJDEsMDAwDQozMy7CoMKgIMKgODAwLDAwMCBQaHlzaWNpYW5z
LCBEb2N0b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzDQplbWFpbCBsaXN0IGF0ICQ0
LDAwMA0KMzQuwqDCoCDCoDEwMCwwMDAgUHVyY2hhc2luZyBhbmQgUHJvY3VyZW1lbnQgTWFuYWdl
cnMgZW1haWwgbGlzdCBhdA0KJDIsMDAwDQozNS7CoMKgIMKgNTAwLDAwMCBTbWFsbCBCdXNpbmVz
cyBvd25lcnMgZW1haWwgbGlzdCBhdCAkNSwwMDANCjM2LsKgwqAgwqAxMDAsMDAwIFRlbGVjb20g
bWFuYWdlcnMsIFZPSVAgbWFuYWdlcnMsIENsb3VkIGFyY2hpdGVjdCwNCkNsb3VkIG1hbmFnZXJz
LCBTdG9yYWdlIG1hbmFnZXJzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQozNy7CoMKgIMKgMTAwLDAw
MCBUcmFkZXIvaW52ZXN0b3JzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQozOC7CoMKgIMKgMTAwLDAw
MCBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEN1c3RvbWVyIFNlcnZpY2UgYW5kDQpDdXN0b21lciBT
dWNjZXNzIG1hbmFnZXJzIGVtYWlsIGxpc3QgYXQgJDIsMDAwDQpQbGVhc2UgbGV0IG1lIGtub3cg
eW91ciB0aG91Z2h0cy4NCkFkZGlseW4gRGF2aXMNCkVtYWlsIERhdGFiYXNlIFByb3ZpZGVyDQor
MS0gKDY3OCkgNzQ1LTgzODUNClVuc3Vic2NyaWJlDQpodHRwczovL2JyYW5kdHJlbmRvbmxpbmUu
eHl6L2FwcC9pbmRleC5waHAvbGlzdHMvcnkzODF2eW53N2E0Yi91bnN1YnNjcmliZS9ycTkxNXh4
bXhwOGY3L21kMTY3N3p3ZndjODcNCsKgDQrCoA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
