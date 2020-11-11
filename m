Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1A2AF901
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Nov 2020 20:26:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE985169BB483;
	Wed, 11 Nov 2020 11:26:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.179; helo=ceo8.kmsattendceo.info; envelope-from=info-linux+2dnvdimm=lists.01.org@kmsattendceo.info; receiver=<UNKNOWN> 
Received: from ceo8.kmsattendceo.info (ip179.ip-51-68-149.eu [51.68.149.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A8C116973BD6
	for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=kmsattendceo.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@kmsattendceo.info;
 bh=ft9ZyIAyFx2Ct5MgtQ+FXqDXi5k=;
 b=c4LRNP7mVKNzoy6V2PK5Ni+DxRxklnqRXgPKJrMB23xreFF6vD5fRUH070Vqz0uGfaEWwmLgVZQh
   l9yIUXm5j7kELeKzR8a38SsFl6+k0pJsqsa7xXT2Q/qwebyZtBzPAm9U0e4D5FC4G76SZjQ479WT
   zIlINuld+ebQF+1i3Z2KGUD1VzSDKA8Ax+P/iH/08H1XcE+AL48+u5v+cYBBYGGU4UUI2B0eigns
   9ZzwEhiXd9d5HjsooXOiOXDKmT0CfC+cTPsndGNDbapBueDvV4SHrf0OqrUK0sIOyzOygVZ01HiF
   z4iCpMmjHh1G8N4qzGJgJ7ijNMHwHvuVX1RD+g==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=kmsattendceo.info;
 b=GnwD4b41Prow0oGNgxhEHFe4Pv8/hPfFBntJZS0Bgb1Q7OsyZZQfVwop70jQgw3bhncm7zxunY5E
   Uq4NjMcQaA4gZWfJcw88VPQTjMgmWpE7TfAyHns1qOPrLBGN/2PD0HxgSPgKMsbzwtKwHDWuZPDt
   TRdFYTkARo5+CUxcQVGG7jp4KvT61DIAvnZmq9OQuEcOLVYWuGK4JqlcXTUlKKkVyY+3Y12QpqAJ
   WPQnu5PGCykV/NERdKDiTqfR2FxPR/y7WREDOwJwm6mj8PvFy4/AwgiJJ5HalY2ME9rz23vFE7+O
   OOEOWQ8NG/pHqsozR8kZlAvkS4EKHlX4/kgNvQ==;
Received: from kmsattendceo.info (54.37.138.114) by ceo1.kmsattendceo.info id hlgtcni19tk1 for <linux-nvdimm@lists.01.org>; Wed, 11 Nov 2020 19:26:01 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info>)
Date: Wed, 11 Nov 2020 19:26:01 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Sara Miller <info@kmsattendceo.info>
Subject: RE: 10K LinkedIn Leads from your Target Audience at 500
Message-ID: <3e48e100f5d8dc3d8b79c598baa55633@kmsattendceo.info>
X-Rcde-Campaign-Uid: ms2349j8p868a
X-Rcde-Subscriber-Uid: jv501yldye7aa
X-Rcde-Customer-Uid: kj6787n91o3e8
X-Rcde-Customer-Gid: 0
X-Rcde-Delivery-Sid: 1
X-Rcde-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://kmsattendceo.info/latest/index.php/campaigns/ms2349j8p868a/report-abuse/wt7487c7j021d/jv501yldye7aa
Feedback-ID: ms2349j8p868a:jv501yldye7aa:wt7487c7j021d:kj6787n91o3e8
Precedence: bulk
X-Rcde-EBS: https://kmsattendceo.info/latest/index.php/lists/block-address
X-Sender: info@kmsattendceo.info
X-Receiver: linux-nvdimm@lists.01.org
X-Rcde-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: JZWKOECHJMTIVAVVUVUD3I66LPEB2ZT3
X-Message-ID-Hash: JZWKOECHJMTIVAVVUVUD3I66LPEB2ZT3
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Sara Miller <sara@b2bcedmevent.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JZWKOECHJMTIVAVVUVUD3I66LPEB2ZT3/>
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
bmQgbGV0IG1lIGtub3cuDQpTYXJhIE1pbGxlcg0KUHJlbWl1bSBMaW5rZWRJbiBEYXRhYmFzZQ0K
MTAwJSBBY2N1cmF0ZSBEYXRhYmFzZQ0KVW5zdWJzY3JpYmUNCmh0dHBzOi8va21zYXR0ZW5kY2Vv
LmluZm8vbGF0ZXN0L2luZGV4LnBocC9saXN0cy93dDc0ODdjN2owMjFkL3Vuc3Vic2NyaWJlL2p2
NTAxeWxkeWU3YWEvbXMyMzQ5ajhwODY4YQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
