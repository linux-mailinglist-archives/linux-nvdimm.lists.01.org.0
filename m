Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D230EA00
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Feb 2021 03:13:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CC24100EB35E;
	Wed,  3 Feb 2021 18:13:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=petroleumtanmia@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2EFC9100EB34C
	for <linux-nvdimm@lists.01.org>; Wed,  3 Feb 2021 18:13:06 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a25so1582082ljn.0
        for <linux-nvdimm@lists.01.org>; Wed, 03 Feb 2021 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:cc;
        bh=XHcatEznOjyooOZ/4cQWFffIMoGHBqr+W7S+MfISZVw=;
        b=q2cJ9oenk4dpjMpV16U+YiS9p0FWXAUAxwVpi16q+22Z3sDStTkjH2ar0jfSwOPZ/+
         f1AoicYPt63e/DxxfB2JiL5EbN0CqYTAXE1lOSnPiM/5YC5rtqR4LF9m1TgTyQEblw5j
         PyuZAG2lGAifq/ImAbvXg9q/HDk7+YDuE6gZctBCfTXKqQ0IZ268IUT3vMGXImVhiDdf
         yV5sj/tyU6dTOCK8Gw1Epb8j7gq2ZPBJhU3CnYvVxkj9ntvLJUF8kRploU26csNchwIQ
         5jmFOp/SyXzI0dMh9aEGtHGEbFJbljrNERpLIe/aUQgQpMR2Uy0m7U+qC6T/v/I3ZqnQ
         QRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=XHcatEznOjyooOZ/4cQWFffIMoGHBqr+W7S+MfISZVw=;
        b=A1+BDJjcfRK5fDAhisJF9urFq6M69ig2St6qiBJn1uQCX5JHhL0AasAspcL9uqzrw4
         8fgx0EdEGfmzTNExw3OJ5Z8suJqjD7Re/x/noEfZLK8XHSvmwdPHBfPNixvtx9VF4Boy
         zLlHcFRs2Zsvh4XenL3CxLpZANki+tFDN0u/q0GkFsqwCMlQwyXzbK1DP/yBH0tupSPG
         3HGZbC9b7+fKvaS0grRz5HHY9oaeNz/ja+Yl1yth/JjIXI1Ed63IO/XhVE+reqLrdit8
         nzzAAB4+Pih5UDZRDdAxhiVrgtDymnJWwowfMGldSYIRMhN2svMhmhgAifZ5ZJyTgCTv
         u7WQ==
X-Gm-Message-State: AOAM530mmdMCrCfV9s9eLcoND1feWcjc3K+uoc1XKgSE4M8E0szl2czq
	cTJv4IU897FanBS7CXKN4ryisdQngSt3kY7xtuE=
X-Received: by 2002:a2e:8541:: with SMTP id u1mt1894478ljj.0.1612404783706;
 Wed, 03 Feb 2021 18:13:03 -0800 (PST)
MIME-Version: 1.0
From: Tanmia Petroleum <petroleumtanmia@gmail.com>
Date: Thu, 4 Feb 2021 04:12:47 +0200
Message-ID: <CALUEhTuw=+pWZKbuVr5CezF-kb1cj-z7ep2vVARzpL-m86eswA@mail.gmail.com>
Subject: Hi
Message-ID-Hash: 7WZYDQFVEYUKS5AIYYM35HPULAJFQENF
X-Message-ID-Hash: 7WZYDQFVEYUKS5AIYYM35HPULAJFQENF
X-MailFrom: petroleumtanmia@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: inquiries@acuvat.com, intrafinance@intradebt.ae, inventaeration@gmail.com, j.samad@mhhydraulics.ae, jan@prolabllc.com, jasamin.fichte@fichtelegal.com, jassimco2@gmail.com, javedjames@gmail.com, jaynamideast@gmail.com, jaysonkervysebastian24@gmail.com, jciquality@jcrinc.com, Jmm.mgt@gmail.com, jobs.chubbycheeks@gmail.com, johncy@arte-marketing.net, joseph.saad@kbguae.com, josephgergessaad@gmail.com, jrmearnest@gmail.com, jumaajabuu97@gmail.com, justice.publicinterest@gmail.com, k.intissar@gmail.com, karredirajamraah@gmail.com, katja@connex-llc.com, kazind.com@gmail.com, keytech@gmail.com, Khalfan.maf@uae.gov.ae, khdeir99@gmail.com, khijas@gmail.com, khizermahenti@gmail.com, khurramayo@gmail.com, kinza@koranrealestate.com, kmccsaudi@gmail.com, krishnan@wnet.net.in, krishnan0123@gmail.com, kulmiyehassan@gmail.com, kvel637@gmail.com, laagfound@gmail.com, lawyers.dominica@gmail.com, lcbkuwait@gmail.com, lcsctrl@moa.gov.sa, leath.irq@gmail.com, lestermsantos@gmail.com, liberleo.fzeuae@
 gmail.com, licgensec@gmail.com, linux-nvdimm@lists.01.org, Ljantonaccio@gmail.com, locust_jeddah@yahoo.com, lyymqa@gmail.com, m.delenda@gmail.com, m.horoub@seedengineering.com, m.s.consultancy.est@gmail.co, m.syem007@gmail.com, maazuae6@gmail.com, madelinerose31@gmail.com, mahmoudkhaja@gmail.com, mail@3demirates.ae, mail@venturesonsite.com, majd.khraim@theland.com.jo, malekjavad007@gmail.com, manarislam@gmail.com, manueldelpozo.id@gmail.com, manzoor709@gmail.com, maohakccd.se@gmail.com, marketing@gumatech.com, marketing@ugtmedical.com, marwanhusseinn@gmail.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WZYDQFVEYUKS5AIYYM35HPULAJFQENF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

ICAgICAgTEVU4oCZUyBIQVZFIEEgRElTQ1VTU0lPTiEhIQ0KDQpXaGF0c2FwcCBOdW1iZXIgIDog
ICArMzgwNjMyODUxMjQyDQoNCkdvb2QgZGF5IHRvIHlvdSwNCg0KSSBhbSwgTWFkZGFtLiBKZW5l
cmV0dGUgIENvb25yb2QgZnJvbSBBbWVyaWNhLiBJdCB3b3VsZCBwbGVhc2UgbWUgdG8NCm5lZ290
aWF0ZSBhIHBvc3NpYmxlIHdvcmtpbmcgdGVybXMgd2l0aCB5b3Ugb24gYW4gaW52ZXN0bWVudCBp
bnRlcmVzdCBpbg0KeW91ciBjb3VudHJ5Lg0KDQpQbGVhc2UgZ2V0IGJhY2sgdG8gbWUgZm9yIHBy
b3BlciBkaXNjdXNzaW9uIGlmIGl0IHdvdWxkIHBsZWFzZSB5b3UgdG9vLg0KDQoNCg0KS2luZCBy
ZWdhcmRzDQpNYWRkYW0uIEplbmVyZXR0ZSAgQ29vbnJvZA0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
