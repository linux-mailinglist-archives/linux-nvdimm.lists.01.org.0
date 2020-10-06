Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B81285454
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 00:10:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7541B15872067;
	Tue,  6 Oct 2020 15:10:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.179; helo=cha5.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha5.chairmaneventsummit.info (ip179.ip-54-38-202.eu [54.38.202.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8658715872067
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=Q+QbE2BpnrLj0eGo2amdFSZGe80=;
 b=mIqw3AQOMCLADlTAgYPpFfrSoBQgRgUnq1zlzPewhnU2UvrZi2LYMXwnCSCTHUjH+v3upE8GAND8
   rkDLDZ2vk3vMPbk5pHhu+Fbqun+ugeJcMpGGEd0kzyI//oPx+I1Z8yzv774VJuPhMZf/kRveSflK
   AWOX0Hx8WpRTciDZpKRqiRQfhUHT+J+s3jxtOs1A0K2CwUtEj72GwCR05i9vQMMEwrpTI94SLqqG
   izFS/ir1/sqP1lJsWI+z1zUQWCe3SpPGBdaiWjOry46wIZeMR57mJpjyg3UhEz+sHxGdlRdSyDjO
   Z+2mrAobvJVtsCosju7Q3KjT/lWbTOMT8UOuVw==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=k/jBClJl5eLnu8ugOFSdjeEwz9S7sp8XuGJhPAeDB8aGInsdEHAU0+NC0okUmUqR3gkak+l0DMS2
   bpslQ03F39vMMsYmgJu2zvz0uh9Qy6cd8MOQ7TaL2IdtObl7wlBRRpchxLINUms3hyq/7/k66X0E
   rbDxdL8wLlFGBPvEbn9iiebk09W8g71vN5hZCBB/fNHW1NN7Qk/+AUXI3bOqtR+DDxtTm/WJ0o0h
   8wbRjnJuCC05+PFqWsTqK0NwjCUuFm5RGjT+b2MnebkCDLHQL1jpwg2yR2bvDNWMJKMpxceIg07p
   gqULux+fPZ/OmPzXv+qfiv34Mc1cRlC6wJgvFg==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hfjlmbi19tkm for <linux-nvdimm@lists.01.org>; Tue, 6 Oct 2020 22:06:38 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Tue, 6 Oct 2020 22:06:38 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Emma Johnson <info@chairmaneventsummit.info>
Subject: RE: Conference call request
Message-ID: <c28d107a96a4719a204dbec55bbae882@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: rz347jx7d41a9
X-Trgm-Subscriber-Uid: ek460shgxm55f
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/rz347jx7d41a9/report-abuse/ks05428k240e4/ek460shgxm55f
Feedback-ID: rz347jx7d41a9:ek460shgxm55f:ks05428k240e4:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: PQ344E2JCEFLUUZKDBTSOYEXDBCG5J7P
X-Message-ID-Hash: PQ344E2JCEFLUUZKDBTSOYEXDBCG5J7P
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emma Johnson <emma@ceoeventsummit2020.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PQ344E2JCEFLUUZKDBTSOYEXDBCG5J7P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBob3BlIHlvdSBhcmUgZG9pbmcgd2VsbCBhbmQgSSBwcmF5IHRvIGFsbCBtaWdodHkgR29kIHRv
IGtlZXAgeW91cg0KZmFtaWx5IHNhZmUuIFdoaWxlIHByb2Zlc3Npb25hbHMgYXJlIHdvcmtpbmcg
ZnJvbSBob21lLCBmb2xsb3dpbmcNCnNlcnZpY2VzIGNhbiBoZWxwIGluIHlvdXIgYnVzaW5lc3Mg
YWx3YXlzLg0KMS7CoFdlIGNhbiB1cGRhdGUgeW91ciBleGlzdGluZyBwcm9zcGVjdHMgZGF0YWJh
c2Ugd2l0aCB2YWxpZCBlbWFpbA0KYWRkcmVzcy9waG9uZSBudW1iZXIvTGlua2VkSW4gUHJvZmls
ZSBsaW5rIGFuZCBvdGhlciBkZXRhaWxzIHlvdSBtYXkNCm5lZWQuDQoyLsKgVGFyZ2V0ZWQgRW1h
aWwgbWFya2V0aW5nIGNhbXBhaWduIHVzaW5nIG91ciBkYXRhYmFzZSBmcm9tIHlvdXINCnRhcmdl
dCBtYXJrZXQ6IEF0ICQ0OTkgd2Ugc2VuZCA1MDAsMDAwIGVtYWlscyB0byB5b3VyIHRhcmdldCBh
dWRpZW5jZQ0KdG8gZ2VuZXJhdGUgbGVhZHMvc2lnbiB1cHMvc2FsZS9hcHBvaW50bWVudHMvc3Vy
dmV5cy9pbnZpdGF0aW9ucw0KMy7CoFRlbGVtYXJrZXRpbmc6IEF0ICQ5OTkgd2Ugd2lsbCBtYWtl
IDMsMDAwIHBob25lIGNhbGxzIHRvIGdlbmVyYXRlDQpsZWFkcy9zaWduIHVwcy9zYWxlL2FwcG9p
bnRtZW50cy9zdXJ2ZXlzL2ludml0YXRpb25zDQo0LsKgTGlua2VkSW4gZGF0YSBwdXJjaGFzZTog
QXQgJDUwMCBmcm9tIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIHdlIHdpbGwNCmRlbGl2ZXIgeW91IDUs
MDAwIGxlYWRzIGZyb20gTGlua2VkSW4gd2l0aCBuYW1lLCB0aXRsZSwgTGlua2VkSW4gbGluaywN
CmVtYWlsLCBhZGRyZXNzLCBpbmR1c3RyeSBhbmQgY29tcGFueSBkZXRhaWxzLg0KNS7CoEV2ZW50
IExlYWRzOiAxMCwwMDAgdGFyZ2V0ZWQgbGVhZHMgZ2VuZXJhdGVkIGZyb20geW91ciB0YXJnZXQN
CmV2ZW50cyBhdCAkNTAwDQo2LsKgV2UgYWxzbyBndWFyYW50ZWUgaW4gUHJvbW90aW5nIHlvdXIg
YnVzaW5lc3MgbG9jYWxseSB0aHJvdWdoDQpjaXRhdGlvbiwgYmFja2xpbmtzLCBzb2NpYWwgbWVk
aWEgcHJvbW90aW9uIGV0Yy4NClRoYW5rcyBhbmQgbGV0IG1lIGtub3cgaWYgeW91IHdpc2ggdG8g
c2VlIGEgc2FtcGxlIG9yIGtub3cgbW9yZS4NCkVtbWEgSm9obnNvbg0KKzEtKDY3OCkgNzQ1LTgz
ODUNCkVtYWlsIExpc3QgfCBFbWFpbCBDYW1wYWlnbiB8IEVtYWlsIEFwcGVuZGluZyB8IFRlbGVt
YXJrZXRpbmcgfCBMZWFkDQpnZW5lcmF0aW9uIHwgU0VPIHwgU29jaWFsIG1lZGlhIENhbXBhaWdu
IHwgVmlkZW8gTWFya2V0aW5nIHwgQ29tcGxldGUNCkRpZ2l0YWwgTWFya2V0aW5nDQpodHRwczov
L2NoYWlybWFuZXZlbnRzdW1taXQuaW5mby9lbW0vaW5kZXgucGhwL2xpc3RzL2tzMDU0MjhrMjQw
ZTQvdW5zdWJzY3JpYmUvZWs0NjBzaGd4bTU1Zi9yejM0N2p4N2Q0MWE5DQrCoA0KwqANCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
