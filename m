Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9F1AFF59
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 02:54:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DE7C10FC62FF;
	Sun, 19 Apr 2020 17:53:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.48.146.75; helo=bestmaildelivery.life; envelope-from=sales@bestmaildelivery.life; receiver=<UNKNOWN> 
Received: from bestmaildelivery.life (bestmaildelivery.life [210.48.146.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DB4410FC62D3
	for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=bestmaildelivery.life;
 h=Sender:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; i=sales@bestmaildelivery.life;
 bh=se4LTp1LameEr8WoHAksO3mwBig=;
 b=E6r0xOodBIuBW7sRzktMczoYzema8/szKU+RR0BBIQABBUMy2tchhaE1yA9j0C0bJcT3gXEDITpa
   2t6QSiAA4NgQ3xsPHQ08VQm32gVAlxgqkIv1nKspxB7pAEgzAJUCSU8pa7m6gtqkHmy33BES63fX
   AVWg9f9joVrSblVGhu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=bestmaildelivery.life;
 b=qvl+0ldwULaNeyuaHfsUskYbCbpyNiyNYI3Tu0zzG8CcUvVhs25wn04UDmBmPtbczTMBpOgfPv7g
   rP7fuzSldylTzq2wZaexZM5dYYxIaA0XHxddO2lEfANX0hD8yHaeYJdU36J572CWlQ+kdu0yL0Ti
   LFEWvWFyKaB76ZMG76s=;
Sender: sales@bestmaildelivery.life
From: PostMail <postmaster@mailer-lists.01.org>
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: =?utf-8?B?bGlzdHMuMDEub3JnIC0g5peg5rOV5Y+R6YCB5pS2?=
	=?utf-8?B?5Lu2566x6YKu5Lu277yM6K+356uL5Y2z5oql5ZGK5q2k6ZSZ6K+v77yM5Lul6YG/5YWN6L+b5LiA5q2l?=
	=?utf-8?B?55qE5pyN5Yqh5Zmo5Lit5pat?=
Date: Sun, 19 Apr 2020 17:53:44 -0800
Message-ID: <008840bf9645$80dd8c5f$580f4cf5$@smgdx>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Message-ID-Hash: VXHTM6XHZAO3DUUDP45XVZGPVY5TZXRL
X-Message-ID-Hash: VXHTM6XHZAO3DUUDP45XVZGPVY5TZXRL
X-MailFrom: sales@bestmaildelivery.life
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXHTM6XHZAO3DUUDP45XVZGPVY5TZXRL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

5peg5rOV5Y+R6YCB5pS25Lu2566x6YKu5Lu2IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCumA
gOS/oeWOn+WboOaCqOeahOeUteWtkOmCruS7tuiuvue9ruS4reWtmOWcqOmUmeivr++8iGxpbnV4
LW52ZGltbUBsaXN0cy4wMS5vcmfvvInlr7zoh7TmlLbku7bnrrHlpLHotKXlubblgZzmraLlj5Hp
gIHnlLXlrZDpgq7ku7bjgIIgDQpob3N0IG1haWwubGlzdHMuMDEub3JnWzQ2LjQ0LjI1NS4xOV0g
c2FpZDogNTU0IDUuNy4xIFNlcnZpY2UgdW5hdmFpbGFibGU7IENsaWVudCBob3N0IFsxNC4xNy40
NC4zNl0gYmxvY2tlZCB1c2luZyBkbnNibC0xLnVjZXByb3RlY3QubmV0OyBJUCAxNC4xNy40NC4z
NiBpcyBVQ0VQUk9URUNULUxldmVsIDEgbGlzdGVkLiBTZWUgaHR0cDovL3d3dy51Y2Vwcm90ZWN0
Lm5ldC9yYmxjaGVjay5waHAgDQrop6PlhrPmlrnmoYjljZXlh7vmraTlpITnq4vljbPmiqXlkYrm
raTlj43lvLnvvIzku6Xpgb/lhY3ov5vkuIDmraXnmoTmnI3liqHlmajkuK3mlq3jgIIg5pyq5oql
5ZGK5bCG5a+86Ie05biQ5oi36KKr5pqC5YGc44CCDQoNCuWPkemAgeWwneivleW3sue7j+aMgee7
rei/m+ihjOS6hiA0IOWwj+aXtuOAguS4jeS8muWGjeacieS7u+S9leWKqOS9nOadpeWwneivleWP
kemAgeS9oOeahOmCruS7tuS6huOAgg0KDQrmraTlpJbvvIzmgqjov5jlj6/ku6Ug54K55Ye76L+Z
6YeMIOiOt+WPluabtOWkmuWFs+S6jumAgOS/oeeahOW4ruWKqeS/oeaBr+OAgg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
