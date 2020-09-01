Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE918258AD0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 10:55:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B765139E51AA;
	Tue,  1 Sep 2020 01:55:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58D21139E51A7
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 01:55:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b17so519530ilh.4
        for <linux-nvdimm@lists.01.org>; Tue, 01 Sep 2020 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d8u+bBUivnnRT/2GGOxyKpzT/GBIGvxJ27fiHGNX228=;
        b=UvpjWhd8G2kPgF5D5eQHLAN6JpOZhfKgykyurIFmDoV5ERgF9W0Ckwc3WYHkEKzYSQ
         vkCVslyOGmN71UBW9T4z16Ci5K1Vw0zdUpw1LLx8r5VFk1jwLvDiYSEORzkqIghaDEzo
         mKYNXmdw3bfEDX4ohV74UZavc3L1fAiDefptKicpEtAhJaMUfSjppTikmIgXNUk4Ymw9
         JG5JL9Zss7KqLUc4dzuyblarmK9DDR7m3DmC8m8mWncTWlXfUiXe7RRAuWRjfWWH2DJ+
         Va+YzOioYSc6Bu3sNbAJQmYTMI3GjnxUwr2tNYdYkIjbEqt9DEC8T2NxxoJU5o6H2zxP
         dlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d8u+bBUivnnRT/2GGOxyKpzT/GBIGvxJ27fiHGNX228=;
        b=pLdPRdcZm4tJtBGo6OI8QO929AwY5hgR55hp96kXIayYLkhthDt8Mx292MQk8h1BYu
         qdwfjdTabT1Iea+xG/lPk3xzL9EMsNwba/7rPpSM0GzC/xjCDQlyVLNT3ldpr1MOutJv
         qqfZfTcFvS6gbktplukFTXxj5WkrY+lrbl+2EpcSGHC+rIR7DAWhW7QGfn9pzKgVG8Mt
         y3/gQHZ6NohtSSO8I0Zrrzp+0b5u6Rbxmmp6qVPaf7VAKxZAgIuwC/YDQYA8um69tnrl
         EppIV7T4yoLC4FXAC5UfTJbhDIdIOCHPQXpyaes/yFF7Ks+FjZdqg6aJR5WEFhpHW3cL
         +qtg==
X-Gm-Message-State: AOAM5324hpiq6pcVzL+zScZJ+Q4kByan8lRZbVUSjgC3UAAqfb+42xXq
	ig3vZvhZmeK74S4njVO4cO9JVdzlzAHm1fWiiFw=
X-Google-Smtp-Source: ABdhPJwp0CAa160ULiz0kc7ScfoUoQdYdKQDFLFkpfbxOti5zA88kx8eDPHqu5jG5O/5yyV9mb4YsNBcg7CWHvoBz2Q=
X-Received: by 2002:a92:444c:: with SMTP id a12mr419956ilm.143.1598950507394;
 Tue, 01 Sep 2020 01:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200901083326.21264-1-roger.pau@citrix.com> <20200901083326.21264-3-roger.pau@citrix.com>
In-Reply-To: <20200901083326.21264-3-roger.pau@citrix.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 1 Sep 2020 10:54:56 +0200
Message-ID: <CAM9Jb+g3=CbEC1QqdZj6ZqXZ78JsnrjPPV6+ATw7ewSCfa3b4w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
To: Roger Pau Monne <roger.pau@citrix.com>
Message-ID-Hash: RKTUNXSVAMT7DHR3C372VOW4JF43WUD6
X-Message-ID-Hash: RKTUNXSVAMT7DHR3C372VOW4JF43WUD6
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, Johannes Thumshirn <jthumshirn@suse.de>, Logan Gunthorpe" <logang@deltatee.com>, Juergen Gross <jgross@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, xen-devel@lists.xenproject.org, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RKTUNXSVAMT7DHR3C372VOW4JF43WUD6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBUaGlzIGlzIGluIHByZXBhcmF0aW9uIGZvciB0aGUgbG9naWMgYmVoaW5kIE1FTU9SWV9ERVZJ
Q0VfREVWREFYIGFsc28NCj4gYmVpbmcgdXNlZCBieSBub24gREFYIGRldmljZXMuDQo+DQo+IE5v
IGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBQ
YXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IElyYSBXZWlu
eSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gQWNrZWQtYnk6IEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+DQo+IC0tLQ0KPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+DQo+IENjOiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGlu
dGVsLmNvbT4NCj4gQ2M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiBDYzog
QW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IEphc29uIEd1
bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwu
Y29tPg0KPiBDYzogIkFuZWVzaCBLdW1hciBLLlYiIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNv
bT4NCj4gQ2M6IEpvaGFubmVzIFRodW1zaGlybiA8anRodW1zaGlybkBzdXNlLmRlPg0KPiBDYzog
TG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBDYzogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KPiBDYzogbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZw0KPiBD
YzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnDQo+IENjOiBsaW51eC1tbUBrdmFjay5v
cmcNCj4gLS0tDQo+ICBkcml2ZXJzL2RheC9kZXZpY2UuYyAgICAgfCAyICstDQo+ICBpbmNsdWRl
L2xpbnV4L21lbXJlbWFwLmggfCA5ICsrKystLS0tLQ0KPiAgbW0vbWVtcmVtYXAuYyAgICAgICAg
ICAgIHwgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9kZXZpY2UuYyBiL2RyaXZlcnMv
ZGF4L2RldmljZS5jDQo+IGluZGV4IDRjMGFmMmViN2UxOS4uMWU4OTUxM2YzYzU5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2RheC9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2RheC9kZXZpY2Uu
Yw0KPiBAQCAtNDI5LDcgKzQyOSw3IEBAIGludCBkZXZfZGF4X3Byb2JlKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUJVU1k7DQo+ICAgICAgICAgfQ0KPg0K
PiAtICAgICAgIGRldl9kYXgtPnBnbWFwLnR5cGUgPSBNRU1PUllfREVWSUNFX0RFVkRBWDsNCj4g
KyAgICAgICBkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklDRV9HRU5FUklDOw0KPiAg
ICAgICAgIGFkZHIgPSBkZXZtX21lbXJlbWFwX3BhZ2VzKGRldiwgJmRldl9kYXgtPnBnbWFwKTsN
Cj4gICAgICAgICBpZiAoSVNfRVJSKGFkZHIpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIFBU
Ul9FUlIoYWRkcik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggYi9p
bmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCj4gaW5kZXggNWY1YjJkZjA2ZTYxLi5lNTg2Mjc0Njc1
MWIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L21lbXJlbWFwLmgNCj4gQEAgLTQ2LDExICs0NiwxMCBAQCBzdHJ1Y3Qgdm1lbV9h
bHRtYXAgew0KPiAgICogd2FrZXVwIGlzIHVzZWQgdG8gY29vcmRpbmF0ZSBwaHlzaWNhbCBhZGRy
ZXNzIHNwYWNlIG1hbmFnZW1lbnQgKGV4Og0KPiAgICogZnMgdHJ1bmNhdGUvaG9sZSBwdW5jaCkg
dnMgcGlubmVkIHBhZ2VzIChleDogZGV2aWNlIGRtYSkuDQo+ICAgKg0KPiAtICogTUVNT1JZX0RF
VklDRV9ERVZEQVg6DQo+ICsgKiBNRU1PUllfREVWSUNFX0dFTkVSSUM6DQo+ICAgKiBIb3N0IG1l
bW9yeSB0aGF0IGhhcyBzaW1pbGFyIGFjY2VzcyBzZW1hbnRpY3MgYXMgU3lzdGVtIFJBTSBpLmUu
IERNQQ0KPiAtICogY29oZXJlbnQgYW5kIHN1cHBvcnRzIHBhZ2UgcGlubmluZy4gSW4gY29udHJh
c3QgdG8NCj4gLSAqIE1FTU9SWV9ERVZJQ0VfRlNfREFYLCB0aGlzIG1lbW9yeSBpcyBhY2Nlc3Mg
dmlhIGEgZGV2aWNlLWRheA0KPiAtICogY2hhcmFjdGVyIGRldmljZS4NCj4gKyAqIGNvaGVyZW50
IGFuZCBzdXBwb3J0cyBwYWdlIHBpbm5pbmcuIFRoaXMgaXMgZm9yIGV4YW1wbGUgdXNlZCBieSBE
QVggZGV2aWNlcw0KPiArICogdGhhdCBleHBvc2UgbWVtb3J5IHVzaW5nIGEgY2hhcmFjdGVyIGRl
dmljZS4NCj4gICAqDQo+ICAgKiBNRU1PUllfREVWSUNFX1BDSV9QMlBETUE6DQo+ICAgKiBEZXZp
Y2UgbWVtb3J5IHJlc2lkaW5nIGluIGEgUENJIEJBUiBpbnRlbmRlZCBmb3IgdXNlIHdpdGggUGVl
ci10by1QZWVyDQo+IEBAIC02MCw3ICs1OSw3IEBAIGVudW0gbWVtb3J5X3R5cGUgew0KPiAgICAg
ICAgIC8qIDAgaXMgcmVzZXJ2ZWQgdG8gY2F0Y2ggdW5pbml0aWFsaXplZCB0eXBlIGZpZWxkcyAq
Lw0KPiAgICAgICAgIE1FTU9SWV9ERVZJQ0VfUFJJVkFURSA9IDEsDQo+ICAgICAgICAgTUVNT1JZ
X0RFVklDRV9GU19EQVgsDQo+IC0gICAgICAgTUVNT1JZX0RFVklDRV9ERVZEQVgsDQo+ICsgICAg
ICAgTUVNT1JZX0RFVklDRV9HRU5FUklDLA0KPiAgICAgICAgIE1FTU9SWV9ERVZJQ0VfUENJX1Ay
UERNQSwNCj4gIH07DQo+DQo+IGRpZmYgLS1naXQgYS9tbS9tZW1yZW1hcC5jIGIvbW0vbWVtcmVt
YXAuYw0KPiBpbmRleCAwM2UzOGI3YTM4ZjEuLjAwNmRhY2U2MGIxYSAxMDA2NDQNCj4gLS0tIGEv
bW0vbWVtcmVtYXAuYw0KPiArKysgYi9tbS9tZW1yZW1hcC5jDQo+IEBAIC0yMTYsNyArMjE2LDcg
QEAgdm9pZCAqbWVtcmVtYXBfcGFnZXMoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwgaW50IG5p
ZCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+
ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gLSAgICAgICBj
YXNlIE1FTU9SWV9ERVZJQ0VfREVWREFYOg0KPiArICAgICAgIGNhc2UgTUVNT1JZX0RFVklDRV9H
RU5FUklDOg0KPiAgICAgICAgICAgICAgICAgbmVlZF9kZXZtYXBfbWFuYWdlZCA9IGZhbHNlOw0K
PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgY2FzZSBNRU1PUllfREVWSUNFX1BD
SV9QMlBETUE6DQoNClJldmlld2VkLWJ5OiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YS5saW51
eEBnbWFpbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
