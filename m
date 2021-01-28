Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F4307186
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 09:34:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23096100F226E;
	Thu, 28 Jan 2021 00:34:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.77.33.218; helo=ceo3.ceoemailfinder.info; envelope-from=info-linux+2dnvdimm=lists.01.org@ceoemailfinder.info; receiver=<UNKNOWN> 
Received: from ceo3.ceoemailfinder.info (ip218.ip-51-77-33.eu [51.77.33.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C42DA100F2265
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 00:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ceoemailfinder.info;
 h=Message-ID:Date:Subject:From:Reply-To:To:MIME-Version:Content-Type:List-Unsubscribe:List-Id; i=info@ceoemailfinder.info;
 bh=BGjiR0wcHHzMVL/SsvO6TAsGJI4=;
 b=cnb54cLPmQNOdi/EZh05autJO8xdDKeSGAoFmgR0C7DUWeXQYB2i13wnEf9ohPeGMVI7DI6K+Zn/
   O+GUUCoZHfPDagMCuA0oqUxulWWJO+IIdkChm0+sT+zPxBwt3UILzdXbuFsmv4wZDTnXj7QFgYUy
   0sgRJzcnLH7EC+FMKCAjxqNrcM0JMsMdBrfKd2jMdLr+ATA6tTb6BoDxooXzwwdU3MWxqHfrWSqn
   1dCleZL4tKgKyldlNkdklc+dYjwSzh8zqzQC2sotRDdr7nxCpo5cx6mHxPkaYUdobjJkCyJcS+AX
   MlFZV03hCLKcZ4bm/FpoxTgfIb7nv7hDIatbSQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=ceoemailfinder.info;
 b=SA7pBjOc1bY4j3N94mAvqK0azLV+kDuAGmt9syv8e+nITsU1GCFNtNJR0g5DVFz+MxyoO+OBfDQf
   1V+x0tCmnixVd3qDW95V37rAR9w+0IG3Ozu0Grmjn8QdoB1MDX2uxwmtzymd4YK/PaMbvYwpuFpn
   IwfQsk1eUVBkOZ3vzl5b1lPWaBDchjlMRq0gZWbPFjNIs+Izu7g9ZbwfxCbKFFA8kgKH6NzZT2QL
   H9fG9o87wCwvSm0O9hWFjoMTbAytlgQWR9ZbF0i4M6DuDqgplQ6JONOAjDXRMvrXy9X3FdHYnJZQ
   hKHdCoBNbLRvQlfZ2tFJuofSGi79gKq5uPtnog==;
Received: from ceoemailfinder.info (127.0.0.1) by ceo1.ceoemailfinder.info id h29rghi19tkj for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 08:34:13 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info>)
Message-ID: <79ed2aab2b33636ace5ba91d073f1578@ceoemailfinder.info>
Date: Thu, 28 Jan 2021 08:34:13 +0000
Subject: RE: 10K LinkedIn Leads at 500
From: Emily Johnson <info@ceoemailfinder.info>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
MIME-Version: 1.0
X-Sender: info@ceoemailfinder.info
X-Report-Abuse: Please report abuse for this campaign here:
 http://ceoemailfinder.info/app/index.php/campaigns/cw7208d4ca9f1/report-abuse/zx374g4v5rd55/dm200ahb6hbca
X-Receiver: linux-nvdimm@lists.01.org
X-Cfhh-Tracking-Did: 0
X-Cfhh-Subscriber-Uid: dm200ahb6hbca
X-Cfhh-Mailer: SwiftMailer - 5.4.x
X-Cfhh-EBS: http://ceoemailfinder.info/app/index.php/lists/block-address
X-Cfhh-Delivery-Sid: 1
X-Cfhh-Customer-Uid: on987d5f1x791
X-Cfhh-Customer-Gid: 0
X-Cfhh-Campaign-Uid: cw7208d4ca9f1
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: cw7208d4ca9f1:dm200ahb6hbca:zx374g4v5rd55:on987d5f1x791
Message-ID-Hash: 7MTBH6XQZCDTQ6YTIJZDNVQXR473CSR4
X-Message-ID-Hash: 7MTBH6XQZCDTQ6YTIJZDNVQXR473CSR4
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@ceoemailfinder.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emily Johnson <emily.johnsontarget@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7MTBH6XQZCDTQ6YTIJZDNVQXR473CSR4/>
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
bmQgbGV0IG1lIGtub3cuDQpFbWlseSBKb2huc29uDQpMaW5rZWRJbiBEYXRhYmFzZSBQcm92aWRl
cg0KKzEtKDY3OCkgNzQ1LTgzODUNClVuc3Vic2NyaWJlDQpodHRwOi8vY2VvZW1haWxmaW5kZXIu
aW5mby9hcHAvaW5kZXgucGhwL2xpc3RzL3p4Mzc0ZzR2NXJkNTUvdW5zdWJzY3JpYmUvZG0yMDBh
aGI2aGJjYS9jdzcyMDhkNGNhOWYxDQrCoA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
