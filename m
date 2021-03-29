Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D5934C24C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Mar 2021 05:50:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5EEB100EC1D7;
	Sun, 28 Mar 2021 20:50:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.147.167; helo=b2b3.b2beventsummit.xyz; envelope-from=info-linux+2dnvdimm=lists.01.org@b2beventsummit.xyz; receiver=<UNKNOWN> 
Received: from b2b3.b2beventsummit.xyz (ip167.ip-51-83-147.eu [51.83.147.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53EE5100ED4AC
	for <linux-nvdimm@lists.01.org>; Sun, 28 Mar 2021 20:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=b2beventsummit.xyz;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@b2beventsummit.xyz;
 bh=HAIdDaMFa0MHvBOophiTxyMnbT4=;
 b=Sg2kXFbWKY5LrhD5CHVwSZhkNiWK6As/xv2Jp6UdjFLnoLgfD63SV5DbB27OxERKUb2THLAVFd72
   +LyB6rpKvRKmtyzvybdsZNcgylqXdQ5wdj7v01Hou2t+5VHCOm/GYDae5mIDuqp+ruX2d8Yx24ms
   the2Kth2WyZXRosl8yubEWMdJ5eMbcJpeyuNnOGZ49NNvNgtj1rJJIS1O+EL/4wh1gvY8Xan+3/S
   wiIwT+ULT9dPf55Tr8SVEzMgCacjjAj2Hza8J13IOajzoZn+PdPopQTxrsSKGqhNYyFAWckCs4qS
   Elxwi0iQH0ZJbAIqBBCLVzNCG+ElDes/joKWyw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=b2beventsummit.xyz;
 b=Zpeg3mfy7h2ODgiCTbuT9Vsyz2O4cpV/qUySAzgNBXxkh+xQiG60+Q7fDa6Z4oPGwSrFAsvx7OhU
   owb/MN0z8eqo/avFh2Vs2uDsllEOvTB6fEPRHqPtR9xQtHdjZCRcM0JwYM4E/hceY3+0vYai/wFw
   hHFMGa58qbZtkwNrfFVbNwp2YRRi3mOQaggbYx+OCyNNWIn4RSWaLk18RhrYui29puGaiLwSR3xw
   EPwDvyO0U9ds/eOabMvcEeehE6Ev6Z1nAMEGscuTKq42xbFpmpAKvqUrol/CNpnAcgGIuz0Ifq9I
   VxllAp8SR+XVruiRK7J149P2rZpY0pxBlVoseA==;
Received: from b2beventsummit.xyz (127.0.0.1) by b2b1.b2beventsummit.xyz id hc578bi19tkf for <linux-nvdimm@lists.01.org>; Mon, 29 Mar 2021 03:06:41 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@b2beventsummit.xyz>)
Message-ID: <22d09ea0a373049c0d5a7c8def6e4f5c@b2beventsummit.xyz>
Date: Mon, 29 Mar 2021 03:06:41 +0000
Subject: RE: Conference call request
From: Olivia Miller <info@b2beventsummit.xyz>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@b2beventsummit.xyz
X-Report-Abuse: Please report abuse for this campaign here:
 https://b2beventsummit.xyz/emm/index.php/campaigns/fw44553z70255/report-abuse/xn499a6wns573/pv448mcdk7a8a
X-Receiver: linux-nvdimm@lists.01.org
X-Mepp-Tracking-Did: 0
X-Mepp-Subscriber-Uid: pv448mcdk7a8a
X-Mepp-Mailer: SwiftMailer - 5.4.x
X-Mepp-EBS: https://b2beventsummit.xyz/emm/index.php/lists/block-address
X-Mepp-Delivery-Sid: 1
X-Mepp-Customer-Uid: tm4000h3gsb5a
X-Mepp-Customer-Gid: 0
X-Mepp-Campaign-Uid: fw44553z70255
Precedence: bulk
Feedback-ID: fw44553z70255:pv448mcdk7a8a:xn499a6wns573:tm4000h3gsb5a
Message-ID-Hash: EMQLVWD2UTIJO45EAZUDETQXBRMVOFBJ
X-Message-ID-Hash: EMQLVWD2UTIJO45EAZUDETQXBRMVOFBJ
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@b2beventsummit.xyz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Olivia Miller <olivia.millerbusiness21@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EMQLVWD2UTIJO45EAZUDETQXBRMVOFBJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

V291bGQgeW91IGxpa2UgdG8gcHVyY2hhc2UgeW91ciBwcm9zcGVjdHMgb3IgdGFyZ2V0IGF1ZGll
bmNlIGVtYWlsDQpsaXN0IHdpdGggOTAlIGFjY3VyYWN5IGd1YXJhbnRlZT8gV2UgaGF2ZSBkYXRh
YmFzZXMgbGlrZSwNCihTYW1wbGUgYXR0YWNoZWQpDQoxLiBBdHRvcm5leXMgYW5kIExhd3llcnMg
ZW1haWwgbGlzdA0KMi4gQXJjaGl0ZWN0cyBhbmQgaW50ZXJpb3IgZGVzaWduZXJzIGVtYWlsIGxp
c3QNCjMuIEJ1aWxkZXJzLCBwcm9wZXJ0eSBkZXZlbG9wZXJzIGFuZCBjb25zdHJ1Y3Rpb24gaW5k
dXN0cnkgZGVjaXNpb24NCm1ha2VycyBlbWFpbCBsaXN0DQo0LiBDRU9zLCBvd25lcnMsIFByZXNp
ZGVudHMgYW5kIE1EcyBlbWFpbCBsaXN0DQo1LiBDRk8sIENvbnRyb2xsZXIsIFZQL0RpcmVjdG9y
L01hbmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMgUGF5YWJsZSwNCkFjY291bnRzIFJlY2VpdmFi
bGUsIEF1ZGl0IG1hbmFnZXJzIGVtYWlsIGxpc3QNCjYuIENJTywgQ1RPLCBDSVNPLCBWUC9EaXJl
Y3Rvci9NYW5hZ2VyIG9mIElULCBJVCBDb21wbGlhbmNlLCBJVCBSaXNrLA0KQkksIENsb3VkLCBE
YXRhYmFzZSBhbmQgSVQgU2VjdXJpdHkgbWFuYWdlcnMgZW1haWwgbGlzdA0KNy4gQ29tbWVyY2lh
bCBwcm9wZXJ0eSBvd25lcnMgZW1haWwgbGlzdA0KOC4gQ29tcGxpYW5jZSBhbmQgUmlzayBNYW5h
Z2VtZW50IG1hbmFnZXJzIGVtYWlsIGxpc3QNCjkuIENQQSBhbmQgQm9va2tlZXBlcnMgZW1haWwg
bGlzdA0KMTAuIERhdGEgc2NpZW50aXN0LCBEYXRhIEFuYWx5dGljcyBhbmQgRGF0YWJhc2UgQWRt
aW5pc3RyYXRvcnMgZW1haWwNCmxpc3QNCjExLiBFLWNvbW1lcmNlIG9yIG9ubGluZSByZXRhaWxl
cnMgZW1haWwgbGlzdA0KMTIuIEVkdWNhdGlvbiBpbmR1c3RyeSBleGVjdXRpdmVzIGVtYWlsIGxp
c3QgLSBQcmluY2lwYWxzLCBEZWFuLA0KQWRtaW5zIGFuZCB0ZWFjaGVycyBmcm9tIFNjaG9vbHMs
IENvbGxlZ2VzIGFuZCBVbml2ZXJzaXRpZXMNCjEzLiBFbmdpbmVlcnMgZW1haWwgbGlzdA0KMTQu
IEV2ZW50IGFuZCBNZWV0aW5nIHBsYW5uZXJzLCBvcmdhbml6ZXJzLCBhbmQgZXhoaWJpdG9ycyBl
bWFpbCBsaXN0DQoxNS4gRmFjaWxpdGllcywgb2ZmaWNlIGFuZCBtYWludGVuYW5jZSBtYW5hZ2Vy
cyBlbWFpbCBsaXN0DQoxNi4gRmluYW5jaWFsIHBsYW5uZXIvYWR2aXNvcnMgZW1haWwgbGlzdA0K
MTcuIEZsZWV0IG1hbmFnZXJzLCBUcnVja2luZyBjb21wYW55IG93bmVycyBlbWFpbCBsaXN0DQox
OC4gR2VuZXJhbCBhbmQgY29ycG9yYXRlIGNvdW5zZWxzIGVtYWlsIGxpc3QNCjE5LiBHb3Zlcm5t
ZW50IGRlY2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0DQoyMC4gSGVhbHRoLCBlbnZpcm9ubWVudCAm
IFNhZmV0eSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoyMS4gSGlnaCBuZXQgd29ydGggaW5kaXZpZHVh
bHMvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCjIyLiBIb21lb3duZXJzLCBBcGFydG1lbnQgb3duZXJz
LCBCdWlsZGluZyBvd25lcg0KMjMuIEhvc3BpdGFscywgY2xpbmljcywgcHJpdmF0ZSBwcmFjdGlj
ZXMsIFBoYXJtYWNldXRpY2FsIGFuZA0KYmlvdGVjaG5vbG9neSBjb21wYW554oCZcyB0b3AgZGVj
aXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCjI0LiBIUiwgVHJhaW5pbmcsIExlYXJuaW5nICYgRGV2
ZWxvcG1lbnQsIEVtcGxveWVlIEJlbmVmaXRzLCBUYWxlbnQNCkFjcXVpc2l0aW9uLCBSZWNydWl0
aW5nIGRlY2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0DQoyNS4gSW5kaXZpZHVhbCBpbnN1cmFuY2Ug
YWdlbnRzIGVtYWlsIGxpc3QNCjI2LiBJU1YvVkFScy9SZXNlbGxlcnMgZW1haWwgbGlzdA0KMjcu
IExvZ2lzdGljcywgc2hpcHBpbmcsIGFuZCBzdXBwbHkgY2hhaW4gbWFuYWdlcnMgZW1haWwgbGlz
dA0KMjguIE1hbnVmYWN0dXJpbmcgSW5kdXN0cnkgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QN
CjI5LiBNYXJrZXRpbmcsIHNvY2lhbCBtZWRpYSwgU2FsZXMsIGRlbWFuZCBnZW5lcmF0aW9uLCBM
ZWFkDQpnZW5lcmF0aW9uIGRlY2lzaW9uIG1ha2VycyBlbWFpbCBsaXN0DQozMC4gTmV3ICYgVXNl
ZCBDYXIgRGVhbGVycyBlbWFpbCBsaXN0DQozMS4gT2lsLCBHYXMgYW5kIHV0aWxpdHkgaW5kdXN0
cnkgZGVjaXNpb24gbWFrZXJzIGVtYWlsIGxpc3QNCjMyLiBwaGFybWFjaXN0IGFuZCBwaGFybWFj
eSBvd25lcnMgZW1haWwgbGlzdA0KMzMuIFBoeXNpY2lhbnMsIERvY3RvcnMsIE51cnNlcywgRGVu
dGlzdHMsIFRoZXJhcGlzdHMgZW1haWwgbGlzdA0KMzQuIFB1cmNoYXNpbmcgYW5kIFByb2N1cmVt
ZW50IE1hbmFnZXJzIGVtYWlsIGxpc3QNCjM1LiBTbWFsbCBCdXNpbmVzcyBvd25lcnMgZW1haWwg
bGlzdA0KMzYuIFRlbGVjb20gbWFuYWdlcnMsIFZPSVAgbWFuYWdlcnMsIENsb3VkIGFyY2hpdGVj
dCwgQ2xvdWQgbWFuYWdlcnMsDQpTdG9yYWdlIG1hbmFnZXJzIGVtYWlsIGxpc3QNCjM3LiBUcmFk
ZXIvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCjM4LiBWUC9EaXJlY3Rvci9NYW5hZ2VyIG9mIEN1c3Rv
bWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MNCm1hbmFnZXJzIGVtYWlsIGxpc3QNClBs
ZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLg0KT2xpdmlhIE1pbGxlcg0KRW1haWwgRGF0
YWJhc2UgUHJvdmlkZXINClVuc3Vic2NyaWJlDQpodHRwczovL2IyYmV2ZW50c3VtbWl0Lnh5ei9l
bW0vaW5kZXgucGhwL2xpc3RzL3huNDk5YTZ3bnM1NzMvdW5zdWJzY3JpYmUvcHY0NDhtY2RrN2E4
YS9mdzQ0NTUzejcwMjU1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
