Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96E2AA346
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 09:13:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78754164BCF8C;
	Sat,  7 Nov 2020 00:13:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.178; helo=cha4.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha4.chairmaneventsummit.info (ip178.ip-54-38-202.eu [54.38.202.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64ED5164BCF89
	for <linux-nvdimm@lists.01.org>; Sat,  7 Nov 2020 00:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=4uX1R7lfP8msRa7X31EhG7/SAgE=;
 b=eodsRb98IFo3OOk7bbExPnbXd+vAHRt4f6cigRqZIgOkWDTN2FR9dl5BmmXRwtLzP7TBYd/kDy6d
   tMe9k7B5swgWT0/cj28K5d0F/iF61QMDdmbv6HZIgufFNKH/gjXQWWLrWWr+5C2IjBdqplgsJ9dT
   WnFR1WbsUvync55CRKTz4EBQDYhGo9eBZlz4MoSr7GSBobWgOHfNAMiXyBRdxFZIJTaI59rOsb1O
   LvEdyawj3TNuYDw2GLnoiSKjn0/qeQGSsR7e/C1e1uSBL0JKsVwNZ1vA8LpUTqKTqsPEQ35re3ka
   vdBAGeeitz5T+1Alp5pbBegFxw6G9O0RH8iFEQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=IzhjfTkOq4xlQjWypBHD9xOg0uo7CIWlYXHjU5DDLfO+ZGBPMHMKzKL7tBzI/lHJWUJYlfN5/QUh
   MmG723PBiXeRFPWcxi4Be34060d3oJ6jltCRSFL5IjxnCHxz5LS49xxPVPHm0wJVP3+5kuvwpyno
   JJFuUJqijh+A4wCg1EZWvFEDZlkVQYhxpytLAisjLjP88KynQIVqgOekSEOWO7G3cDtOWv7F+nnG
   aj9LOd8SfJh83EJdo8J3YeQ8tTRhyrOdL4irz7ZrHrGGlb0R4JXmp7KoJczKPfsQO4+y+otIR4yb
   9Z+Nx+Zd+qiCUoanB8SP+UBJLRxnHBwg6Df95w==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hkpbk3i19tkj for <linux-nvdimm@lists.01.org>; Sat, 7 Nov 2020 08:13:49 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Sat, 7 Nov 2020 08:13:49 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Garcia Taylor <info@chairmaneventsummit.info>
Subject: RE: 10K LinkedIn Leads at 500
Message-ID: <38648c42e6d449e10948f8cc342b87c9@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: nv041ezp7a4ba
X-Trgm-Subscriber-Uid: xj9408r1qtf27
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/nv041ezp7a4ba/report-abuse/tr3842wxgefa2/xj9408r1qtf27
Feedback-ID: nv041ezp7a4ba:xj9408r1qtf27:tr3842wxgefa2:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: BTNKFVWQDY6KZEP2DTKGRNA6Q2BGWTAI
X-Message-ID-Hash: BTNKFVWQDY6KZEP2DTKGRNA6Q2BGWTAI
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Garcia Taylor <garcia@soltecmaredm.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BTNKFVWQDY6KZEP2DTKGRNA6Q2BGWTAI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QXJlIHlvdSBpbnRlcmVzdGVkIHRvIHB1cmNoYXNlIDEwMCUgYWNjdXJhdGUgMTAsMDAwIFRhcmdl
dGVkIExlYWRzDQpmcm9tIExpbmtlZEluIGF0ICQ1MDAoQW55IHRpdGxlcy9pbmR1c3RyeS9sb2Nh
dGlvbi9rZXl3b3Jkcyk/DQpJZiB5b3UgaGF2ZSBhIHZlcnkgdGFyZ2V0ZWQgZGF0YSByZXF1aXJl
bWVudCBhbmQgeW91IG5lZWQgTGlua2VkSW4NCmRhdGFiYXNlLCB3ZSB3aWxsIHB1bGwgdGFyZ2V0
ZWQgZGF0YWJhc2VzIGZvciB5b3Ugd2l0aCB0aGVpciBMaW5rZWRJbg0KcHJvZmlsZSBsaW5rLCBu
YW1lLCB0aXRsZSwgZW1haWwgYWRkcmVzcywgY29tcGFueSBuYW1lLCBjaXR5LCBjb21wYW55DQpz
aXplIGV0Yy4gUGxlYXNlIHNoYXJlIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIGFuZCBJIHdpbGwgc3Vw
cGx5IHRoZQ0Kc2FtcGxlIHdpdGhpbiAxIGJ1c2luZXNzIGRheXPigJkgdGltZS4NClRoYW5rcyBh
bmQgbGV0IG1lIGtub3cuDQpHYXJjaWEgVGF5bG9yDQpMZWFkIGdlbmVyYXRpb24gVGVhbQ0KUHJl
bWl1bSBMaW5rZWRJbiBEYXRhYmFzZQ0KVW5zdWJzY3JpYmUNCmh0dHBzOi8vY2hhaXJtYW5ldmVu
dHN1bW1pdC5pbmZvL2VtbS9pbmRleC5waHAvbGlzdHMvdHIzODQyd3hnZWZhMi91bnN1YnNjcmli
ZS94ajk0MDhyMXF0ZjI3L252MDQxZXpwN2E0YmENCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
