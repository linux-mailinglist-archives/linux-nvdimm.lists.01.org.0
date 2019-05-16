Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4922719
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 May 2019 17:23:24 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BBF221244A69;
	Sun, 19 May 2019 08:23:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Too many DNS lookups)
 identity=mailfrom; client-ip=106.12.144.54; helo=bhd2.sosung.net;
 envelope-from=info@i.u-bordeaux.xyz; receiver=linux-nvdimm@lists.01.org 
Received: from bhd2.sosung.net (bhd2.sosung.net [106.12.144.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 70FDE2122C2F8
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 08:23:10 -0700 (PDT)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
 by bhd2.sosung.net (Postfix) with ESMTPS id 0AC0B10126B
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 20:02:38 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
 by edm01.bossedm.com (Bossedm) with SMTP id A7615121122
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 20:02:32 +0800 (CST)
Date: Thu, 16 May 2019 20:02:31 +0800 (CST)
From: "=?utf-8?B?WXVtaSA=?=" <yumi@hardfindelectronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UmU6VmlzaGF54oCLIERpb2RlIFNNQUoxNUEtRTMvNjEg?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1858#40891#linux-nvdimm@lists.01.org#e358f98847f1ee53ccc515b2fd0679bf#1558008151897>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA163E85126B94690000000000005851DD5C000000000E00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=i.u-bordeaux.xyz;
 s=s9527; t=1558008152;
 bh=rrVeJ0oSUUW9Qj93TJcCYz+LIZdX/W8GmMwcjTwjI0U=;
 h=Date:From:Subject:Message-ID;
 b=RoVpIbTvpAqXpV+cAIrOFSO8m6oXsZIHtmTs4mdKDzU8E5M8RjKTWAct51FRHzEpx
 4NSig5P3yl/IHGazjrt8lj/7gp2PJ6LdjMMJT3iSXSl6i/rgDxJ37awK0pTXUo0OsX
 sNQhswRjhWgMsOEvS/D9H6lKYAZyJqYE6sTVjPus=
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Reply-To: yumi@hardfindelectronics.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

DQoJJm5ic3A7Jm5ic3A7SGFyZCZuYnNwO0ZpbmQmbmJzcDtFbGVjdHJvbmljcyBMdGQuIA0KDQoN
CgkmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsxIFBjcyBPcmRlciAmYW1wOyBTaG9ydCBM
ZWFkIFRpbWUgJmFtcDsgMzY1RGF5cyBXYXJyYW50eSBEaXN0cmlidXRvciZuYnNwOw0KIA0KDQpE
ZWFyIEN1c3RvbWVyLA0KIA0KDQoJTmljZSBkYXkhDQpUaGlzIGlzIFl1bWkgZnJvbSBIYXJkIEZp
bmQgRWxlY3Ryb25pY3MgTHRkKHd3dy5oYXJkZmluZGVsZWN0cm9uaWNzLmNvbSkgd2hpY2ggaXMg
YSBwcm9mZXNzaW5hbCBlbGVjdHJvbmljcyBkaXN0cmlidXRvciB3aXRoIDEwIHllYXJzIG9mIGV4
cGVyaWVuY2VzLiZuYnNwOw0KV2UgYXJlIGdvb2QgYXQgSGFyZC10by1GaW5kIGVsZWN0cm9uaWMg
Y29tcG9uZW50cy4NCg0KSUM6IFhpbGlueCwgQWx0ZXJhLCBUSSwgTFQsIEFELE1pY3Jvbi4uDQpN
TENDIENhcGFjaXRvcjogTXVyYXRhLCBTYW1zdW5nLCBZYWdlbywgQVZYLCBLZW1ldC4uDQpEaW9k
ZSZhbXA7VHJhbnNpc3RvcjogVmlzaGF5LFRJLFNULi4NCg0KSWYgeW91Jm5ic3A7bmVlZCZuYnNw
O3NhbXBsZSwgcGxzIGZlZWwgZnJlZSB0byBjb250YWN0IG1lLiANCiBQbHMgY2hlY2sgb3VyIGhv
dCBvZmZlcix3YWl0IGZvciB5b3VyIGtpbmRseSBSRlE6DQoNCiANCg0KDQoJU01BSjE1QS1FMy82
MSBWaXNoYXkgMjAxOCsgMC4wMTYzdXNkIGRpZ2kta2V5ICQwLjExMTcyDQpTTUFKMTJBLUUzLzYx
IFZpc2hheSAyMDE4KyAwLjAxNjV1c2QgZGlnaS1rZXkgJDAuMTExNzINClNNQUoxMEEtRTMvNjEg
VmlzaGF5IDIwMTgrIDAuMDE3OXVzZCBkaWdpLWtleSAkMC4xMTE3Mg0KU01BSjkuMENBLUUzLzYx
IFZpc2hheSAyMDE4KyAwLjAxM3VzZCBkaWdpLWtleSAkMC4xMjI4Mg0KU01CSjI2Q0EtRTMvNTIg
IFZpc2hheSAyMDE4KyAwLjAxMzR1c2QgZGlnaS1rZXkgJCQwLjE5NjcyDQpTTUNKMzZBLUUzLzU3
VCZuYnNwOyAgVmlzaGF5IDIwMTgrIDAuMDMyM3VzZCBkaWdpLWtleSAkMC4yOTQwNA0KCQ0KCQkN
CgkNCiANCg0KDQoJS2VlcCBzbWlsaW5nIGV2ZXJ5IGRheSZuYnNwOygq77+jKe+/oykgDQoNCg0K
CSANCg0KDQoJWXVtaSZuYnNwOyhQcm9kdWN0Jm5ic3A7TWFuYWdlcikgDQoNCg0KCUhhcmQmbmJz
cDtGaW5kJm5ic3A7RWxlY3Ryb25pY3MgTHRkLg0KMzE1LCBTaGFoZSBSb2QsIExvbmcgR2FuZyBE
aXN0cmljdCwgU2hlbnpoZW4sIENOLCA1MTgwMDANCiBUZWw6ICs4Ni03NTUtODQxOCA4MTAzJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7Jm5ic3A7IA0KDQoNCglTa3lwZSAmYW1wOyBFbWFpbDom
bmJzcDt5dW1pQGhhcmRmaW5kZWxlY3Ryb25pY3MuY29tDQpMaW5rZWRsbjp3d3cubGlua2VkaW4u
Y29tL2luL3l1bWktZ2FvIA0KDQoNCglGYWNlYm9vazombmJzcDtmYWNlYm9vay5jb20vWXVtaWhh
cmRmaW5kIA0KDQoNCglXZWI6Jm5ic3A7aHR0cDovL3d3dy5oYXJkZmluZGVsZWN0cm9uaWNzLmNv
bS8gDQoNCg0KCSZuYnNwOyANCg0KDQoJSWYgeW91IGRvbid0IHdhbnQgdG8gcmVjZWl2ZSB0aGlz
IG1haWwsIHBscyByZXR1cm4gd2l0aCAicmVtb3ZlIiBvbiB0aGUgc3ViamVjdCBsaW5lLiANCg0K
DQoJDQogDQrlpoLmnpzkvaDkuI3mg7Plho3mlLbliLDor6Xkuqflk4HnmoTmjqjojZDpgq7ku7bv
vIzor7fngrnlh7vov5nph4zpgIDorqIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlz
dHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZk
aW1tCg==
