Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12ED27A52B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 03:19:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A208213E2CA98;
	Sun, 27 Sep 2020 18:19:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.178; helo=cha4.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha4.chairmaneventsummit.info (ip178.ip-54-38-202.eu [54.38.202.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E10E313E2CA9A
	for <linux-nvdimm@lists.01.org>; Sun, 27 Sep 2020 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=8HFq9hcZiZuedS87uquqIsJibn4=;
 b=CktqOADUtYSIwPemU9sv7vEHvVIhJCtH/ZmhKesE1P8fZiv80uhmF2516kWq7jovCoW1hxx/ubWT
   IjbDSl4sn3NNYeifofbf2oC4bcHzltjw1Vm04DgKFbRR2Eid9vA/QQVMZwSA3zBya1yCdF4j/Md8
   BoHxOXHTVACV18a7HwO9fyaSMY0VVTfSWvrPJJbpsw1+4Tr7ywWm13TQ9xvVIx43PLfKo3rfa/Uj
   iutsk1hv0/YWwPj95EeL5JF4qzoozTGr9v7NZNmnfBGy7tkk0qiyG2ocDPI8b5bcyM+jT3iCHbPH
   bWyUNFAZKimfY8qFvnNyB90QGH9qiRolk2zE+g==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=I3YdvYAQSBPlgkdPC94Dxi05gVBW74CBZ0cJ2X0oj8RUJBFtELYCmwbJFQDuCBURdO3HTAxnfo8J
   l/4wWXJn2zUSGHtCDW/6fKEvksLlxCRMQ1WuFYLGW2LVPImADKE01NE7+DFwONlWmbpMTsagYShA
   fSUy4di9szvQAV/mWrpSv38JcrNzl2S9moRj9ZT57NZMzYIVi91bnZX2f1TEyTA3dCkGPCg7tP9t
   x6a68uoQ5GGqxiuOtFDWkSfcE7PPckJ5MMIKIc0CuJ3FbaIbxf+6taCGa1cDglHV5XtrtKpfugKG
   UnM1wXTGGkE97KxhzSGn8i7BOLww9U4EEGqMOQ==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id he4t15i19tkh for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 01:19:09 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Mon, 28 Sep 2020 01:19:09 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Barbara Joseph <info@chairmaneventsummit.info>
Subject: RE: did you get my previous email
Message-ID: <21653c2ceff283f410d3d9255a4b0ba7@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: wo301h2txk24c
X-Trgm-Subscriber-Uid: po8112n7ft903
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/wo301h2txk24c/report-abuse/xl708j0f7wbd2/po8112n7ft903
Feedback-ID: wo301h2txk24c:po8112n7ft903:xl708j0f7wbd2:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: YR7EFZOBRSYCBIZIGQZSA4LBCHW4DHAQ
X-Message-ID-Hash: YR7EFZOBRSYCBIZIGQZSA4LBCHW4DHAQ
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Barbara Joseph <barbara@mytbedm.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YR7EFZOBRSYCBIZIGQZSA4LBCHW4DHAQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIGFueSBvZiB0aGUgZm9sbG93aW5nIGVtYWls
IGxpc3RzIHdpdGgNCjkwJSBhY2N1cmFjeSBndWFyYW50ZWU/DQoqIENFTywgb3duZXIsIFByZXNp
ZGVudCBhbmQgQ09PIGVtYWlsIGxpc3QNCiogQ0ZPLCBDb250cm9sbGVyLCBWUC9EaXJlY3Rvci9N
YW5hZ2VyIG9mIEZpbmFuY2UsIEFjY291bnRzIFBheWFibGUsDQpBY2NvdW50cyBSZWNlaXZhYmxl
LCBBdWRpdCBlbWFpbCBsaXN0DQoqIFBoeXNpY2lhbnMsIERvY3RvcnMsIE51cnNlcywgRGVudGlz
dHMsIFRoZXJhcGlzdHMgZW1haWwgbGlzdA0KKiBDaGllZiBIdW1hbiBSZXNvdXJjZXMgT2ZmaWNl
ciwgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBIUiwgRW1wbG95ZWUNCkJlbmVmaXRzLCBFbXBsb3ll
ZSBDb21tdW5pY2F0aW9ucywgRW1wbG95ZWUgQ29tcGVuc2F0aW9uLCBFbXBsb3llZQ0KRW5nYWdl
bWVudCwgRW1wbG95ZWUgRXhwZXJpZW5jZSBhbmQgRW1wbG95ZWUgUmVsYXRpb25zLCBUYWxlbnQN
CkFjcXVpc2l0aW9uLCBUYWxlbnQgRGV2ZWxvcG1lbnQsIFRhbGVudCBNYW5hZ2VtZW50LCBSZWNy
dWl0aW5nIGVtYWlsDQpsaXN0DQoqIENJTyxDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIg
b2YgSVQsIElUIENvbXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJ
VCBTZWN1cml0eSBlbWFpbCBsaXN0DQoqIENNTywgVlAvRGlyZWN0b3IvTWFuYWdlciBvZiBNYXJr
ZXRpbmcsIHNvY2lhbCBtZWRpYSwgU2FsZXMsIGRlbWFuZA0KZ2VuZXJhdGlvbiwgTGVhZCBnZW5l
cmF0aW9uLCBpbnNpZGUgc2FsZXMsIE1hcmtldGluZyBDb21tdW5pY2F0aW9ucw0KZW1haWwgbGlz
dA0KKiBDb21wbGlhbmNlIGFuZCBSaXNrIE1hbmFnZW1lbnQgZW1haWwgbGlzdA0KKiBDUEEgYW5k
IEJvb2trZWVwZXJzIGVtYWlsIGxpc3QNCiogRGF0YSBBbmFseXRpY3MgYW5kIERhdGFiYXNlIEFk
bWluaXN0cmF0b3JzIGVtYWlsIGxpc3QNCiogRGlzYXN0ZXIgUmVjb3ZlcnkgZW1haWwgbGlzdA0K
KiBFLWNvbW1lcmNlIG9yIG9ubGluZSByZXRhaWxlcnMgZW1haWwgbGlzdA0KKiBFZHVjYXRpb24g
aW5kdXN0cnkgZXhlY3V0aXZlcyBlbWFpbCBsaXN0IC0gUHJpbmNpcGFscywgRGVhbiwNCkFkbWlu
cyBhbmQgdGVhY2hlcnMgZnJvbSBTY2hvb2xzLCBDb2xsZWdlcyBhbmQgVW5pdmVyc2l0aWVzDQoq
IEVuZ2luZWVycyBlbWFpbCBsaXN0DQoqIEV2ZW50IGFuZCBtZWV0aW5nIHBsYW5uZXJzIGVtYWls
IGxpc3QNCiogRmFjaWxpdGllcyBhbmQgb2ZmaWNlIG1hbmFnZXIgQ29udGFjdHMNCiogR2VuZXJh
bCBhbmQgY29ycG9yYXRlIGNvdW5zZWwgYXMgd2VsbCBsZWdhbCBwcm9mZXNzaW9uYWxzIGVtYWls
DQpsaXN0DQoqIEdvdmVybm1lbnQgY29udHJhY3RvcnMgZW1haWwgbGlzdA0KKiBIZWFsdGggJiBT
YWZldHkgZW1haWwgbGlzdA0KKiBIaWdoIG5ldCB3b3J0aCBpbmRpdmlkdWFscy9pbnZlc3RvcnMg
ZW1haWwgbGlzdA0KKiBIb3NwaXRhbHMsIGNsaW5pY3MsIHByaXZhdGUgcHJhY3RpY2VzLCBQaGFy
bWFjZXV0aWNhbCBhbmQNCmJpb3RlY2hub2xvZ3kgY29tcGFueeKAmXMgdG9wIGRlY2lzaW9uIG1h
a2VycyBlbWFpbCBsaXN0DQoqIEh1bWFuIENhcGl0YWwgTWFuYWdlbWVudCBlbWFpbCBsaXN0DQoq
IEluZGl2aWR1YWwgaW5zdXJhbmNlIGFnZW50cyBlbWFpbCBsaXN0DQoqIElTVi9WQVJzIGVtYWls
IGxpc3QNCiogQXJjaGl0ZWN0cyBhbmQgaW50ZXJpb3IgZGVzaWduZXJzIGVtYWlsIGxpc3QNCiog
TGVhcm5pbmcgJiBEZXZlbG9wbWVudCBlbWFpbCBsaXN0DQoqIExvZ2lzdGljcywgc2hpcHBpbmcg
YW5kIHN1cHBseSBjaGFpbiBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIE1hbnVmYWN0dXJpbmcgSW5k
dXN0cnkgZXhlY3V0aXZlcyBsaXN0DQoqIE5ldHdvcmsgbWFuYWdlciwgU3VydmVpbGxhbmNlLCBT
eXN0ZW0gQWRtaW5pc3RyYXRvciwgVGVjaG5pY2FsDQpTdXBwb3J0IGVtYWlsIGxpc3QNCiogTmV3
ICYgVXNlZCBDYXIgRGVhbGVycyBlbWFpbCBsaXN0DQoqIE9pbCwgR2FzIGFuZCB1dGlsaXR5IGlu
ZHVzdHJ5IGVtYWlsIGxpc3QNCiogUGxhbnQgTWFuYWdlciBlbWFpbCBsaXN0DQoqIFByb2R1Y3Qg
YW5kIHByb2plY3QgbWFuYWdlbWVudCBlbWFpbCBsaXN0DQoqIFB1cmNoYXNpbmcgYW5kIFByb2N1
cmVtZW50IGVtYWlsIGxpc3QNCiogU3BlY2lmaWMgRXZlbnQgYXR0ZW5kZWVzIGxpc3QNCiogVGVs
ZWNvbSBtYW5hZ2VycywgVk9JUCBtYW5hZ2VycywgQ2xvdWQgYXJjaGl0ZWN0LCBDbG91ZCBtYW5h
Z2VycywNClN0b3JhZ2UgbWFuYWdlcnMgZW1haWwgbGlzdA0KKiBWUC9EaXJlY3Rvci9NYW5hZ2Vy
IG9mIEN1c3RvbWVyIFNlcnZpY2UgYW5kIEN1c3RvbWVyIFN1Y2Nlc3MgZW1haWwNCmxpc3QNClRo
YW5rcyBhbmQgbGV0IG1lIGtub3cuDQpCYXJiYXJhIEpvc2VwaA0KRGF0YWJhc2UgQ29uc3VsdGFu
dA0KNDJNaWwgQjJCIGFuZCAyMTBNaWwgQjJDIE9wdC1pbiBFbWFpbCBhbmQgcGhvbmUgbGlzdCB3
aXRoIG90aGVyIGRhdGENCmZpZWxkcw0KaHR0cHM6Ly9jaGFpcm1hbmV2ZW50c3VtbWl0LmluZm8v
ZW1tL2luZGV4LnBocC9saXN0cy94bDcwOGowZjd3YmQyL3Vuc3Vic2NyaWJlL3BvODExMm43ZnQ5
MDMvd28zMDFoMnR4azI0Yw0KwqANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
