Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0C29FF72
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 09:14:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 886781635C217;
	Fri, 30 Oct 2020 01:14:04 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=185.149.113.111; helo=server.msgroupspa.com; envelope-from=no-reply@msgroupspa.com; receiver=<UNKNOWN> 
Received: from server.msgroupspa.com (unknown [185.149.113.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53A371635C20D
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=msgroupspa.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gOeEglh1DIJatPKqyvOsPs4e0Zw8Lzg9wwjnNfQdiM8=; b=nK3IDYT+DT+afspoRk1vnh030x
	JBANriWCpwGFqkJTHXsxgXz4zPu7XOm+ROYW+1LhSp6Xws1Wm9Gxv0Soi++3fpbt9358vEM1Vilpv
	5xlCNIs/Y8Yak5vs3SvhE9OTE/TC6Vf04ze0iphAaRgUliWRhAsWS8s68bwFyUv4tdChHxOH/JwR2
	Vv+jWIv637j1UH3aZ6QLvXZrjdEmRucUTVxZtH4VnCDjrc4XZi9EwE5rzVsYDmyiNG+eYB+1QY+/8
	bPWWeacOm9DyYRD9g3bLyiVv0uincEH4/sdJ6fuUSabQfGsi095GX6rsmNCONVo4/rhE4INecsjOZ
	9QdrBN4A==;
Received: from [::1] (port=55352 helo=server.msgroupspa.com)
	by server.msgroupspa.com with esmtpa (Exim 4.93)
	(envelope-from <no-reply@msgroupspa.com>)
	id 1kYPRU-0006Ky-OT; Fri, 30 Oct 2020 16:07:24 +0800
MIME-Version: 1.0
Date: Fri, 30 Oct 2020 16:07:24 +0800
From: "Mr. John Galvan" <no-reply@msgroupspa.com>
To: undisclosed-recipients:;
Subject: Hello/Hallo
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <8970d4ac30f8022b0ae628d9b69a2d43@msgroupspa.com>
X-Sender: no-reply@msgroupspa.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.msgroupspa.com
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - msgroupspa.com
X-Get-Message-Sender-Via: server.msgroupspa.com: authenticated_id: no-reply@msgroupspa.com
X-Authenticated-Sender: server.msgroupspa.com: no-reply@msgroupspa.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-ID-Hash: ZPQKYF6G7HFT6XD576SN3LR4RBNZAVKD
X-Message-ID-Hash: ZPQKYF6G7HFT6XD576SN3LR4RBNZAVKD
X-MailFrom: no-reply@msgroupspa.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: galvan.johnny@outlook.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZPQKYF6G7HFT6XD576SN3LR4RBNZAVKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCi0tIA0KU2lyL01hZGFtLA0KDQpJIGhhdmUgYWNjZXNzIHRvIHZlcnkgdml0YWwgaW5mb3Jt
YXRpb24gdGhhdCBjYW4gYmUgdXNlZCB0byBtb3ZlIGEgaHVnZSANCmFtb3VudCBvZiBtb25leS4g
SSBoYXZlIGRvbmUgbXkgaG9tZXdvcmsgdmVyeSB3ZWxsIGFuZCBJIGhhdmUgdGhlIA0KbWFjaGlu
ZXJpZXMgaW4gcGxhY2UgdG8gZ2V0IGl0IGRvbmUgc2luY2UgSSBhbSBzdGlsbCBpbiBhY3RpdmUg
c2VydmljZS4gDQpJZiBpdCB3YXMgcG9zc2libGUgZm9yIG1lIHRvIGRvIGl0IGFsb25lIEkgd291
bGQgbm90IGhhdmUgYm90aGVyZWQgDQpjb250YWN0aW5nIHlvdS4gVWx0aW1hdGVseSBJIG5lZWQg
YW4gaG9uZXN0IGZvcmVpZ25lciB0byBwbGF5IGFuIA0KaW1wb3J0YW50IHJvbGUgaW4gdGhlIGNv
bXBsZXRpb24gb2YgdGhpcyBidXNpbmVzcyB0cmFuc2FjdGlvbi4gU2VuZCANCnJlc3BvbmRzIHRv
IHRoaXMgZW1haWw6wqBnYWx2YW4uam9obm55QG91dGxvb2suY29tDQoNClJlZ2FyZHMsDQpKb2hu
IEdhbHZhbg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCg0KU2lyIC8gTWFkYW0sDQoNCkljaCBoYWJlIFp1Z2FuZyB6dSBz
ZWhyIHdpY2h0aWdlbiBJbmZvcm1hdGlvbmVuLCBtaXQgZGVuZW4gaWNoIGVpbmUgDQpncm/Dn2Ug
TWVuZ2UgR2VsZCBiZXdlZ2VuIGthbm4uIEljaCBoYWJlIG1laW5lIEhhdXNhdWZnYWJlbiBzZWhy
IGd1dCANCmdlbWFjaHQgdW5kIGljaCBoYWJlIGRpZSBNYXNjaGluZW4sIHVtIHNpZSB6dSBlcmxl
ZGlnZW4sIGRhIGljaCBpbW1lciANCm5vY2ggaW0gYWt0aXZlbiBEaWVuc3QgYmluLiBXZW5uIGVz
IG1pciBtw7ZnbGljaCBnZXdlc2VuIHfDpHJlLCBlcyBhbGxlaW5lIA0KenUgdHVuLCBow6R0dGUg
aWNoIG1pY2ggbmljaHQgZGFydW0gZ2Vrw7xtbWVydCwgU2llIHp1IGtvbnRha3RpZXJlbi4gDQpM
ZXR6dGVuZGxpY2ggYnJhdWNoZSBpY2ggZWluZW4gZWhybGljaGVuIEF1c2zDpG5kZXIsIGRlciBl
aW5lIHdpY2h0aWdlIA0KUm9sbGUgYmVpbSBBYnNjaGx1c3MgZGllc2VzIEdlc2Now6RmdHN2b3Jn
YW5ncyBzcGllbHQuIFNlbmRlbiBTaWUgDQpBbnR3b3J0ZW4gYXVmIGRpZXNlIEUtTWFpbDogZ2Fs
dmFuLmpvaG5ueUBvdXRsb29rLmNvbQ0KDQpHcsO8w59lLA0KSm9obiBHYWx2YW4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
