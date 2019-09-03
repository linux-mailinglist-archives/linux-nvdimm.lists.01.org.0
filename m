Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 140ECAB247
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Sep 2019 08:16:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8B0E21962301;
	Thu,  5 Sep 2019 23:16:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Too many DNS lookups)
 identity=mailfrom; client-ip=106.12.150.83; helo=bhd3.sosung.net;
 envelope-from=zhan.bixia@ed.swmail.top; receiver=linux-nvdimm@lists.01.org 
Received: from bhd3.sosung.net (bhd3.sosung.net [106.12.150.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0B892027725A
 for <linux-nvdimm@lists.01.org>; Thu,  5 Sep 2019 23:16:51 -0700 (PDT)
Received: from edm01.bossedm.com (edm01.chinaemail.cn [180.76.132.54])
 by bhd3.sosung.net (Postfix) with ESMTPS id D90D0107C54
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 17:04:25 +0800 (CST)
Received: from unknown (unknown [127.0.0.1])
 by edm01.bossedm.com (Bossedm) with SMTP id C701B12134C
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 17:03:41 +0800 (CST)
Date: Tue,  3 Sep 2019 17:03:41 +0800 (CST)
From: "=?utf-8?B?WXVtaSA=?=" <yumi@hardfindtronics.com>
To: <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?UmU6IFJGUSBNQ1AyNTE1VC1JL1NUIDUwMHBjcw==?=
Mime-Version: 1.0
X-Notify-Mail: No
Message-ID: <1883#47401#linux-nvdimm@lists.01.org#e358f98847f1ee53ccc515b2fd0679bf#1567501421606>
X-Iszbb: Yes
X-ZZY-MESSAGE-ID: FA163E85126B5A250000000000006D2C6E5D000000000C00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ed.swmail.top; s=s9527; 
 t=1567501421; bh=0G8wYkyQvIdrlRW1tjPNneDw49aNukGi6Q9nyB8elWs=; 
 h=Date:From:Subject:Message-ID;
 b=W84GeDUPOky2o4Ghpz7ggD3IZZEjzBaKBJYGZG+ojSi5r0hooV6BQ7txvQIG/W1cj
 WHrNQpp9Nnv05QLv0ISsnJGTrJrWXnKD8inWpvl+QdvBZyPr6KY0jlY/7SukJ30v+a
 t3Za7rqHd+CX6tx1pIQAmkrbQ+WZLAaupmEm/oW0=
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
Reply-To: yumi@hardfindtronics.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

DQoNCg0KDQoNCg0KCQ0KCQkmbmJzcDsmbmJzcDtIYXJkJm5ic3A7RmluZCZuYnNwO0VsZWN0cm9u
aWNzIEx0ZC4NCnNvdXJjaW5nIGhhcmQgZmluZCBlbGVjdHJvbmljIGNvbXBvbmVudHMgDQoJDQoJ
DQoJCSZuYnNwOyANCgkNCgkNCgkJRGVhciBDdXN0b21lciwgDQoJDQoJDQoJCU5pY2UgZGF5IQ0K
VGhpcyBpcyBZdW1pIGZyb20gSGFyZCBGaW5kIEVsZWN0cm9uaWNzIEx0ZCh3d3cuaGFyZGZpbmRl
bGVjdHJvbmljcy5jb20pJm5ic3A7d2hpY2ggaXMgYSBwcm9mZXNzaW9uYWwgZWxlY3Ryb25pY3Mg
ZGlzdHJpYnV0b3Igd2l0aCAxMCB5ZWFycyBvZiBleHBlcmllbmNlcy4mbmJzcDsNCldlIGFyZSBn
b29kIGF0Jm5ic3A7SGFyZCBGaW5kJm5ic3A7ZWxlY3Ryb25pYyBjb21wb25lbnRz77yaDQoNCklD
OiBYaWxpbngsIEFsdGVyYSwgVEksIExULCBBRCxNaWNyb24uLg0KTUxDQyBDYXBhY2l0b3I6IE11
cmF0YSwgU2Ftc3VuZywgWWFnZW8sIEFWWCwgS2VtZXQuLg0KRGlvZGUmYW1wO1RyYW5zaXN0b3I6
IFZpc2hheSxUSSxTVC4uDQoNCklmIHlvdSZuYnNwO25lZWQmbmJzcDtzYW1wbGUsIHBscyBmZWVs
IGZyZWUgdG8gY29udGFjdCBtZS4mbmJzcDsNClBscyBjaGVjayBvdXIgaG90IG9mZmVyLHdhaXQg
Zm9yIHlvdXIga2luZGx5IFJGUTogDQoJDQoJDQoJCSZuYnNwOyANCgkNCgkNCgkJTUNQMTUyNVQt
SS9UVCZuYnNwOyBNSUNST0NISVAgMjAxOCsgMC4yMnVzZCZuYnNwOyBTT1QtMjMmbmJzcDsgIA0K
TUNQMTU0MVQtSS9UVCBNSUNST0NISVAgMjAxOCsgMC4yNXVzZCZuYnNwOyBTT1QyMy0zIA0KTUNQ
MjUxNVQtSS9TVCBNSUNST0NISVAgMjAxOCsgMC42dXNkIDIwVFNTT1AgDQpNQ1A5NzAwVC1FL1RU
IE1JQ1JPQ0hJUCAyMDE4KyAwLjE0NHVzZCBTT1QyMy0zICANCk1DUDYwNFQtSS9TTCZuYnNwOyBN
SUNST0NISVAgMjAxOSsgMC4zMXVzZCAxNFNPSUMgDQoyNUxDMTAyNC1JL1NNIE1JQ1JPQ0hJUCAy
MDE4KyAxdXNkIDhTT0lDIA0KOTNMQzU2QlQtSS9PVCZuYnNwOyBNSUNST0NISVAgMjAxOCsgMC4x
NjJ1c2QgU09UMjMtNiANCjI0TEM2NC1JL1NOJm5ic3A7IE1JQ1JPQ0hJUCAyMDE4KyZuYnNwOyAw
LjEzdXNkIDhTT0lDIA0KDQogDQoJDQoJDQoJCUtlZXAgc21pbGluZyBldmVyeSBkYXkmbmJzcDso
Ku+/oynvv6MpIA0KCQ0KCQ0KCQlZdW1pJm5ic3A7KFByb2R1Y3QmbmJzcDtNYW5hZ2VyKSANCgkN
CgkNCgkJSGFyZCZuYnNwO0ZpbmQmbmJzcDtFbGVjdHJvbmljcyBMdGQuDQpzb3VyY2luZyBoYXJk
IGZpbmQgZWxlY3Ryb25pYyBjb21wb25lbnRzDQoNCjMxNSwgU2hhaGUgUm9kLCBMb25nIEdhbmcg
RGlzdHJpY3QsIFNoZW56aGVuLCBDTiwgNTE4MDAwDQpUZWw6ICs4Ni03NTUtODQxOCA4MTAzJm5i
c3A7Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7DQpTa3lwZSAmYW1wOyBFbWFpbDombmJzcDt5
dW1pQGhhcmRmaW5kZWxlY3Ryb25pY3MuY29tDQpMaW5rZWRsbjp3d3cubGlua2VkaW4uY29tL2lu
L3l1bWktZ2FvDQpGYWNlYm9vazombmJzcDtmYWNlYm9vay5jb20vWXVtaWhhcmRmaW5kDQombmJz
cDsgDQoJDQoJDQoJCUlmIHlvdSBkb24ndCB3YW50IHRvIHJlY2VpdmUgdGhpcyBtYWlsLCBwbHMg
cmV0dXJuIHdpdGggInJlbW92ZSIgb24gdGhlIHN1YmplY3QgbGluZS4gDQoJDQoJDQoJCSZuYnNw
OyANCgkNCg0KDQoNCg0KCeaho+mTuue9keKAlOKAlOWcqOe6v+aWh+aho+WFjei0ueWkhOeQhiAN
CuWmguaenOS9oOS4jeaDs+WGjeaUtuWIsOivpeS6p+WTgeeahOaOqOiNkOmCruS7tu+8jOivt+eC
ueWHu+i/memHjOmAgOiuogpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
