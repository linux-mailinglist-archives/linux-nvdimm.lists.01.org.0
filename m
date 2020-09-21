Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21183271947
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 04:25:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2DE014FEABE6;
	Sun, 20 Sep 2020 19:25:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f44; helo=mail-qv1-xf44.google.com; envelope-from=achirvasub@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85DC414FEABE4
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 19:25:54 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id f11so6567185qvw.3
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 19:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lFSktLUg4vlJvFR6j+da57CRrfVvfFDzsNGXcJskpWg=;
        b=WijXhVtHinjwUial10pwIzB6tFdj9f7sYNeCvlh7wyq3AT2G2FbkKm5BieT99Q56Wd
         VYRcXPC1N91NugEuLTa6orlyl6dmthJJa9WtSs5RJDe/31LNgPXVPQRmiu52d+HPXdqV
         RONcqR38ovOMJ9pqh4hv4s5YjWVlv2Xl3x3hfPuJzkqcxrA+JPR3TeL+FbbzG2Kz7Wog
         nIC/Iy9R8gaWyINgl8SEn3hy23QYrK8UTz4CmdkY+sXZs/xeEsP8AHXnResdLuW/R69X
         M2l7U01gK4o2hW57vddMS4qdm4WPOYneDsJvwCmID1/4P00fAqnCRrped7wtIbjkAR8l
         BEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lFSktLUg4vlJvFR6j+da57CRrfVvfFDzsNGXcJskpWg=;
        b=JR2AN0ijzeaMnyzM1k0ufoOpZ8XAnhB4UFCLOA+Dm/TO5UEhp2T93rkMthHrAfxkG3
         AJaoL3Yw+X6FmJ8ukCn8n8ppFyS8Vd/HEpjheJIVXcBM7HosGRKnbfuu6FNQkFeP67o/
         YIE0+coOYkQaZdnO3wgRu9OV9meOsXV1qYPzTKvmfb5ZvdshqhFMmgoz6kZn6Pemdggb
         sVlMbys2WVM7pmZ/6UFYWBLGXPStC7OjQfeUAKt7q/KY5gEtaat0oYZzTqvafBjyYVc2
         CymclmxrAMvvZ57bwpSEd30+C4qPAX56jAk7mWgzrJd/qim/QRoSqYShQoZShxP/lF8H
         SMcg==
X-Gm-Message-State: AOAM532xOkzeAf2t24eiHg0VczkUJkrHJOuQQWn3qU1zBALH1pLzme8g
	B7e+z5kDUzNPZACMUkWF+Mc=
X-Google-Smtp-Source: ABdhPJxB3XAhWC2X9pslRsVbnBITL/SE6RQDK8MbXF4CJ3WmAPUe41uo94GaO/8AlPphAuQKeZySoQ==
X-Received: by 2002:a0c:e788:: with SMTP id x8mr41799676qvn.27.1600655152779;
        Sun, 20 Sep 2020 19:25:52 -0700 (PDT)
Received: from arch-chirva.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id w44sm9044859qth.9.2020.09.20.19.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 19:25:52 -0700 (PDT)
Date: Sun, 20 Sep 2020 22:25:50 -0400
From: Stuart Little <achirvasub@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: PROBLEM: 5.9.0-rc6 fails =?utf-8?Q?to_?=
 =?utf-8?Q?compile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported?=
 =?utf-8?B?4oCZJw==?=
Message-ID: <20200921022550.GE3027080@arch-chirva.localdomain>
References: <20200921010359.GO3027113@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921010359.GO3027113@arch-chirva.localdomain>
Message-ID-Hash: RZQ5O65QXM3EOA6HWGIDHIWQYLC3BAAA
X-Message-ID-Hash: RZQ5O65QXM3EOA6HWGIDHIWQYLC3BAAA
X-MailFrom: achirvasub@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kernel list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RZQ5O65QXM3EOA6HWGIDHIWQYLC3BAAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QW4gdXBkYXRlIG9uIHRoaXM6IEkndmUgZG9uZSBhIGJpc2VjdCwgd2l0aCB0aGUgZm9sbG93aW5n
IHJlc3VsdC4NCg0KLS0tIGN1dCBoZXJlIC0tLQ0KDQplMmVjNTEyODI1NDUxOGNhZTMyMGQ1ZGM2
MzFiNzFiOTQxNjBmNjYzIGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0DQpjb21taXQgZTJlYzUxMjgy
NTQ1MThjYWUzMjBkNWRjNjMxYjcxYjk0MTYwZjY2Mw0KQXV0aG9yOiBKYW4gS2FyYSA8amFja0Bz
dXNlLmN6Pg0KRGF0ZTogICBTdW4gU2VwIDIwIDA4OjU0OjQyIDIwMjAgLTA3MDANCg0KICAgIGRt
OiBDYWxsIHByb3BlciBoZWxwZXIgdG8gZGV0ZXJtaW5lIGRheCBzdXBwb3J0DQogICAgDQogICAg
RE0gd2FzIGNhbGxpbmcgZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQoKSB0byBkZXRlcm1pbmUgd2hl
dGhlciBhIGRldmljZQ0KICAgIHJlZmVyZW5jZWQgaW4gdGhlIERNIHRhYmxlIHN1cHBvcnRzIERB
WC4gSG93ZXZlciB0aGlzIGlzIGEgaGVscGVyIGZvciAibGVhZiIgZGV2aWNlIGRyaXZlcnMgc28g
dGhhdA0KICAgIHRoZXkgZG9uJ3QgaGF2ZSB0byBkdXBsaWNhdGUgY29tbW9uIGdlbmVyaWMgY2hl
Y2tzLiBIaWdoIGxldmVsIGNvZGUNCiAgICBzaG91bGQgY2FsbCBkYXhfc3VwcG9ydGVkKCkgaGVs
cGVyIHdoaWNoIHRoYXQgY2FsbHMgaW50byBhcHByb3ByaWF0ZQ0KICAgIGhlbHBlciBmb3IgdGhl
IHBhcnRpY3VsYXIgZGV2aWNlLiBUaGlzIHByb2JsZW0gbWFuaWZlc3RlZCBpdHNlbGYgYXMNCiAg
ICBrZXJuZWwgbWVzc2FnZXM6DQogICAgDQogICAgZG0tMzogZXJyb3I6IGRheCBhY2Nlc3MgZmFp
bGVkICgtOTUpDQogICAgDQogICAgd2hlbiBsdm0yLXRlc3RzdWl0ZSBydW4gaW4gY2FzZXMgd2hl
cmUgYSBETSBkZXZpY2Ugd2FzIHN0YWNrZWQgb24gdG9wIG9mDQogICAgYW5vdGhlciBETSBkZXZp
Y2UuDQogICAgDQogICAgRml4ZXM6IDdiZjdlYWM4ZDY0OCAoImRheDogQXJyYW5nZSBmb3IgZGF4
X3N1cHBvcnRlZCBjaGVjayB0byBzcGFuIG11bHRpcGxlIGRldmljZXMiKQ0KICAgIENjOiA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4NCiAgICBUZXN0ZWQtYnk6IEFkcmlhbiBIdWFuZyA8YWh1YW5n
MTJAbGVub3ZvLmNvbT4NCiAgICBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6
Pg0KICAgIEFja2VkLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAcmVkaGF0LmNvbT4NCiAgICBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQogICAgTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNjAwNjE3MTUxOTUuMTMxMzEuNTUwMzE3MzI0NzYz
MjA0MTk3NS5zdGdpdEBkd2lsbGlhMi1kZXNrMy5hbXIuY29ycC5pbnRlbC5jb20NCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0KIGRy
aXZlcnMvZGF4L3N1cGVyLmMgICB8ICA0ICsrKysNCiBkcml2ZXJzL21kL2RtLXRhYmxlLmMgfCAx
MCArKysrKysrLS0tDQogaW5jbHVkZS9saW51eC9kYXguaCAgIHwgMjIgKysrKysrKysrKysrKysr
KysrKystLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCg0KLS0tIGVuZCAtLS0NCg0KT24gU3VuLCBTZXAgMjAsIDIwMjAgYXQgMDk6MDM6NTlQTSAt
MDQwMCwgU3R1YXJ0IExpdHRsZSB3cm90ZToNCj4gSSBhbSB0cnlpbmcgdG8gY29tcGlsZSBmb3Ig
YW4geDg2XzY0IG1hY2hpbmUgKEludGVsKFIpIENvcmUoVE0pIGk3LTc1MDBVIENQVSBAIDIuNzBH
SHopLiBUaGUgY29uZmlnIGZpbGUgSSBhbSBjdXJyZW50bHkgdXNpbmcgaXMgYXQNCj4gDQo+IGh0
dHBzOi8vdGVybWJpbi5jb20veGluNw0KPiANCj4gVGhlIGJ1aWxkIGZvciA1LjkuMC1yYzYgZmFp
bHMgd2l0aCB0aGUgZm9sbG93aW5nIGVycm9yczoNCj4gDQo+IC0tLSBjdXQgaGVyZSAtLS0NCj4g
DQo+IGRyaXZlcnMvZGF4L3N1cGVyLmM6MzI1OjY6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCY
ZGF4X3N1cHBvcnRlZOKAmQ0KPiAgIDMyNSB8IGJvb2wgZGF4X3N1cHBvcnRlZChzdHJ1Y3QgZGF4
X2RldmljZSAqZGF4X2Rldiwgc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwNCj4gICAgICAgfCAg
ICAgIF5+fn5+fn5+fn5+fn4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZGF4L3N1
cGVyLmM6MTY6DQo+IC4vaW5jbHVkZS9saW51eC9kYXguaDoxNjI6MjA6IG5vdGU6IHByZXZpb3Vz
IGRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmSB3YXMgaGVyZQ0KPiAgIDE2MiB8IHN0
YXRpYyBpbmxpbmUgYm9vbCBkYXhfc3VwcG9ydGVkKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2
LA0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+DQo+ICAgQ0MgICAg
ICBsaWIvbWVtcmVnaW9uLm8NCj4gICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3Zy
YW1faGVscGVyLm8NCj4gbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI4Mzog
ZHJpdmVycy9kYXgvc3VwZXIub10gRXJyb3IgMQ0KPiBtYWtlWzFdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6NTAwOiBkcml2ZXJzL2RheF0gRXJyb3IgMg0KPiBtYWtlWzFdOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiANCj4gLS0tIGVuZCAtLS0NCj4gDQo+IFRo
YXQncyBlYXJsaWVyIG9uLCBhbmQgdGhlbiBsYXRlciwgYXQgdGhlIGVuZCBvZiB0aGUgKGZhaWxl
ZCkgYnVpbGQ6DQo+IA0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjE3ODQ6IGRyaXZlcnNdIEVycm9y
IDINCj4gDQo+IFRoZSBmdWxsIGJ1aWxkIGxvZyBpcyBhdA0KPiANCj4gaHR0cHM6Ly90ZXJtYmlu
LmNvbS9paHhqDQo+IA0KPiBidXQgSSBkbyBub3Qgc2VlIGFueXRoaW5nIGVsc2UgYW1pc3MuIDUu
OS4wLXJjNSBidWlsdCBmaW5lIGxhc3Qgd2Vlay4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
