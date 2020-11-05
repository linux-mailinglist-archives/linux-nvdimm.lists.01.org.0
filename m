Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308F2A87DC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Nov 2020 21:19:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2A87165C01B2;
	Thu,  5 Nov 2020 12:19:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.68.149.179; helo=ceo8.kmsattendceo.info; envelope-from=info-linux+2dnvdimm=lists.01.org@kmsattendceo.info; receiver=<UNKNOWN> 
Received: from ceo8.kmsattendceo.info (ip179.ip-51-68-149.eu [51.68.149.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B603165C01B0
	for <linux-nvdimm@lists.01.org>; Thu,  5 Nov 2020 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=kmsattendceo.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@kmsattendceo.info;
 bh=FL6O5QiuQjGdzkIpr7Jw74zMg3I=;
 b=sQesyn5vNW0VE5RkSMDE8rfE2ifRnHKd2Bg/tKyJ5+Dyt33uJOVwqdFxHsdg9N3kgIDv53QrwOO9
   wJ7XhfDPUn7He5pcSTQdRFoecfzkijb6razGsyI7pRsGBO+tH3+5Poq65BB5Nj6XVofweGi05aLE
   /c/soztFmJp9kne18U9jyjRTQMhRfGtaKtit896Nw/mFpvQVgTFr0kJrQNBHdLaZCNWecPMJNtB8
   DZLs0b913oOWFvKB0oTrOAcPU2VDI9P4S+Yo7wQTm7TM7V0kxx2nO/Ol3MQCMi0xk+CVs5dKvQQ1
   66Pa+55aRflKlqQ5NAjbH2/PYoc2y5QfYUVfbQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=kmsattendceo.info;
 b=OtmjkpbeYXcnHIQ4xFSkPXCdeP9l1uh4bIdzHsHJn4iSSBcc06B+Ju1NqSZ4T7u2yx3+oaGmjm7X
   cMjZaHposhU2XPBIFo0heYse0qRVX5n8pS7CRkrNoWRG9KzM98kDULR7EPBh9HUkVWOGDKUKRasw
   1TZ7kiCMdZ4dJVySZwSrG1Sg7VKryIbYJVMY0+YscI3ZM2J9Q6iWEB+BiSHlexR695uhyoKYVZKU
   IRvGV33R5pVEdzWH3Bfz1qEbf6s+/3UXVuB3B0vNo6IbUWX9HG5IuIIAytmJx8+7fsY6sllxzDe8
   AQRjOKl6Ro5zj16qSkWVQ6ZxVy1zx4sPyUHovA==;
Received: from kmsattendceo.info (54.37.138.114) by ceo1.kmsattendceo.info id hkhf5ji19tku for <linux-nvdimm@lists.01.org>; Thu, 5 Nov 2020 20:19:33 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info>)
Date: Thu, 5 Nov 2020 20:19:33 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Garcia Taylor <info@kmsattendceo.info>
Subject: FW: 10K LinkedIn Leads at 500
Message-ID: <43aff54466f05606d77486b1a35eab64@kmsattendceo.info>
X-Rcde-Campaign-Uid: gb282n3hv6ea0
X-Rcde-Subscriber-Uid: qq4462rtg8bff
X-Rcde-Customer-Uid: kj6787n91o3e8
X-Rcde-Customer-Gid: 0
X-Rcde-Delivery-Sid: 1
X-Rcde-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://kmsattendceo.info/latest/index.php/campaigns/gb282n3hv6ea0/report-abuse/cw228ewqocc87/qq4462rtg8bff
Feedback-ID: gb282n3hv6ea0:qq4462rtg8bff:cw228ewqocc87:kj6787n91o3e8
Precedence: bulk
X-Rcde-EBS: https://kmsattendceo.info/latest/index.php/lists/block-address
X-Sender: info@kmsattendceo.info
X-Receiver: linux-nvdimm@lists.01.org
X-Rcde-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: CNYBQYYEBIS7GH5T3XIKQH3JNU2SBAIQ
X-Message-ID-Hash: CNYBQYYEBIS7GH5T3XIKQH3JNU2SBAIQ
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@kmsattendceo.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Garcia Taylor <garcia@soltecmaredm.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CNYBQYYEBIS7GH5T3XIKQH3JNU2SBAIQ/>
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
bmQgbGV0IG1lIGtub3cuDQpHYXJjaWEgVGF5bG9yDQpMaW5rZWRJbiBEYXRhYmFzZSBQcm92aWRl
cg0KKzEtKDY3OCkgNzQ1LTgzODUNClVuc3Vic2NyaWJlDQpodHRwczovL2ttc2F0dGVuZGNlby5p
bmZvL2xhdGVzdC9pbmRleC5waHAvbGlzdHMvY3cyMjhld3FvY2M4Ny91bnN1YnNjcmliZS9xcTQ0
NjJydGc4YmZmL2diMjgybjNodjZlYTANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
