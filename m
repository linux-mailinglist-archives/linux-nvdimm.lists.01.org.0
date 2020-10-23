Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0D297774
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 21:03:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A2B8D1633C8C9;
	Fri, 23 Oct 2020 12:03:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 53F901633312A
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 12:03:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p13so2540163edi.7
        for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GPHwU9J+X3OUBX85mSZFovT9hbvIw6S5Kdvr9vsVInA=;
        b=jO7ovvOaVscsZX/zUflT5SIsUiK+3Fc7YQ6OYCBAGnDxSqfYt8dGgwUWTsEqvjwHs8
         nXd4+bCwcztEkO683V7syVwwO1wOZk6YHC63TP9MuFRNnc0whna8y9wzdIFBFVLeLLh/
         /KveDQfUVWukZl2rPRPxX1Nt8IuKNSxWWTRmVahpiWb6QPFzDHFfHycEk0kRryl43DYk
         iv0QWuLlWBTGbP5gjKhfIZ5tnXN5EBvH31yYCeej8rIutvlFyzJoQn4BQblfkSRD/xwT
         iZVEo1j1AgP3IhH8x1gmtFa7rppmjRIzDEFzEZgmsJOmJJ4xr66Dhk1rOUhHGkt4tNUO
         JKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GPHwU9J+X3OUBX85mSZFovT9hbvIw6S5Kdvr9vsVInA=;
        b=ncpOjwBPj2PQRoI6MfSQYH9me5cUaSVVtk3Y0lhypiHMAj7F86pJPL+tkbeg5acXwp
         dPaVpSOCf8OXm8oJSfwV3DUzn5mIPrhO55dXhXpV5+Wx9ls4UPDDaUjkhiCwy5g3XNw/
         EyEt+5rXUgc73LnxhznEeHV6ef2Oe/kKR1KX7wRvdzPmCxk7htAbpfCr5eZz5KaYMCgL
         c/Rj8HnxgCE4TszJ4d/qDHKsFrGYVaRZPgFMjxpc+MpEO9MbG7OgpPcUMmEjVZ4TOCnZ
         4xmhgXIYepxeim3jsv945q5WdbrtHsFwINMK/Gjbk6do35jdowbrQcjSZTRtTlJgZ8FW
         a5/Q==
X-Gm-Message-State: AOAM531eV/AlpCh4fV7qvjII8XBYgpSLc30FqMIKH1D9c9dEpe4sfv4J
	YseA8dIvcIT2/R6iCUFE3OOBV92CPLD5Ab5QcRSJJZ5+v8M=
X-Google-Smtp-Source: ABdhPJzvjEp1OUbFeIZOhzAWFdZhOgSjaLlQM9WLg6N09UmnP+QbZaUxsIO6185O51O24w7ZcuKjdN812WPY6D7RaaY=
X-Received: by 2002:a50:871d:: with SMTP id i29mr3721039edb.300.1603479795291;
 Fri, 23 Oct 2020 12:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <87r1v3lwcn.fsf@linux.ibm.com> <20201023192829.3ee3c1a7@naga.suse.cz>
In-Reply-To: <20201023192829.3ee3c1a7@naga.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Oct 2020 12:03:05 -0700
Message-ID: <CAPcyv4hTYQ8upuDd0RqUzBtSqjBr4rJz0eaceUmr4b=XeXqs-A@mail.gmail.com>
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a
 generic way
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Message-ID-Hash: IRDI7LP7JDQ4DJJSOZLJCW2J7RYFFKS5
X-Message-ID-Hash: IRDI7LP7JDQ4DJJSOZLJCW2J7RYFFKS5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, Alastair D'Silva <alastair@d-silva.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IRDI7LP7JDQ4DJJSOZLJCW2J7RYFFKS5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBPY3QgMjMsIDIwMjAgYXQgMTA6MjggQU0gTWljaGFsIFN1Y2jDoW5layA8bXN1Y2hh
bmVrQHN1c2UuZGU+IHdyb3RlOg0KPg0KPiBIZWxsbywNCj4NCj4gT24gVGh1LCBNYXkgMjgsIDIw
MjAgYXQgMTE6NTkgQU0gVmFpYmhhdiBKYWluIDx2YWliaGF2QGxpbnV4LmlibS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGlzIHRha2luZyB0aW1lIHRvIGxvb2sgaW50byB0aGlz
IERhbiwNCj4gPg0KPiA+IEFncmVlIHdpdGggdGhlIHBvaW50cyB5b3UgaGF2ZSBtYWRlIGVhcmxp
ZXIgdGhhdCBJIGFtIHN1bW1hcml6aW5nIGJlbG93Og0KPiA+DQo+ID4gKiBUaGlzIGlzIGJldHRl
ciBkb25lIGluIG5kY3RsIHJhdGhlciB0aGFuIGlwbWN0bC4NCj4gPiAqIFNob3VsZCBvbmx5IGV4
cG9zZSBnZW5lcmFsIHBlcmZvcm1hbmNlIG1ldHJpY3MgYW5kIG5vdCBwZXJmb3JtYW5jZQ0KPiA+
ICAgY291bnRlcnMuIFBlcmZvcm1hbmNlIGNvdW50ZXIgc2hvdWxkIGJlIGV4cG9zZWQgdmlhIHBl
cmYNCj4gPiAqIFZlbmRvciBzcGVjaWZpYyBtZXRyaWNzIHRvIGJlIHNlcGFyYXRlZCBmcm9tIGdl
bmVyaWMgcGVyZm9ybWFuY2UNCj4gPiAgIG1ldHJpY3MuDQo+ID4NCj4gPiBPbmUgd2F5IHRvIHNw
bGl0IGdlbmVyaWMgYW5kIHZlbmRvciBzcGVjaWZpYyBtZXRyaWNzIG1pZ2h0IGJlIHRvIHJlcG9y
dA0KPiA+IGdlbmVyaWMgcGVyZm9ybWFuY2UgbWV0cmljcyB0b2dldGhlciB3aXRoIGRpbW0gaGVh
bHRoIG1ldHJpY3Mgc3VjaCBhcw0KPiA+ICJ0ZW1wcmF0dXJlX2NlbHNpdXMiIG9yICJzcGFyZXNf
cGVyY2VudGFnZSIgdGhhdCBhcmUgYWxyZWFkeSByZXBvcnRlZCBpbg0KPiA+IGJ5IGRpbW0gaGVh
bHRoIG91dHB1dC4NCj4gPg0KPiA+IFZlbmRvciBzcGVjaWZpYyBwZXJmb3JtYW5jZSBtZXRyaWNz
IGNhbiBiZSByZXBvcnRlZCBhcyBhIHNlcGVyYXRlIG9iamVjdA0KPiA+IGluIHRoZSBqc29uIG91
dHB1dC4gU29tZXRoaW5nIHNpbWlsYXIgdG8gb3V0cHV0IGJlbG93Og0KPiA+DQo+ID4gIyBuZGN0
bCBsaXN0IC1ESCAtLXN0YXRzIC0tdmVuZG9yLXN0YXRzDQo+ID4gWw0KPiA+ICAgew0KPiA+ICAg
ICAiZGV2Ijoibm1lbTAiLA0KPiA+ICAgICAiaGVhbHRoIjp7DQo+ID4gICAgICAgImhlYWx0aF9z
dGF0ZSI6Im9rIiwNCj4gPiAgICAgICAic2h1dGRvd25fc3RhdGUiOiJjbGVhbiIsDQo+ID4gICAg
ICAgInRlbXBlcmF0dXJlX2NlbHNpdXMiOjQ4LjAwLA0KPiA+ICAgICAgICJzcGFyZXNfcGVyY2Vu
dGFnZSI6MTAsDQo+ID4NCj4gPiAgICAgICAvKiBHZW5lcmljIHBlcmZvcm1hbmNlIG1ldHJpY3Mv
c3RhdHMgKi8NCj4gPiAgICAgICAiVG90YWxNZWRpYVJlYWRzIjogMTg5MjksDQo+ID4gICAgICAg
IlRvdGFsTWVkaWFXcml0ZXMiOiAwLA0KPiA+ICAgICAgIC4uLi4NCj4gPiAgICAgfQ0KPiA+DQo+
ID4gICAgIC8qIFZlbmRvciBzcGVjaWZpYyBzdGF0cyBmb3IgdGhlIGRpbW0gKi8NCj4gPiAgICAg
InZlbmRvci1zdGF0cyI6IHsNCj4gPiAgICAgIkNvbnRyb2xsZXIgUmVzZXQgQ291bnQiOjEwDQo+
ID4gICAgICJDb250cm9sbGVyIFJlc2V0IEVsYXBzZWQgVGltZSI6IDM2MDANCj4gPiAgICAgIlBv
d2VyLW9uIFNlY29uZHMiOiAzNjAwDQo+DQo+IEhvdyBkbyB5b3UgdGVsbCBnZW5lcmljIGZyb20g
dmVuZG9yLXNwZWNpZmljIHN0YXRzLCB0aG91Z2g/DQo+DQo+IENvbnRyb2xsZXIgcmVzZXQgY291
bnQgYW5kIHBvd2VyLW9uIHRpbWUgbWF5IG5vdCBiZSByZXBvcnRlZCBieSBzb21lDQo+IGNvbnRy
b2xsZXJzIGJ1dCBzb3VuZCBwcmV0dHkgZ2VuZXJpYy4NCj4NCj4gRXZlbiBpZiB5b3UgZGVjbGFy
ZSB0aGF0IHRoZSBzdGF0cyByZXBvcnRlZCBieSBhbGwgY29udHJvbGxlcnMNCj4gYXZhaWxhYmxl
IGF0IHRoaXMgbW9tZW50IGFyZSBnZW5lcmljIGEgbGF0ZXIgb25lIG1heSBub3QgcmVwb3J0IHNv
bWUgb2YNCj4gdGhlc2UgJ2dlbmVyaWMnIHN0YXRpc3RpY3MsIG9yIHJlcG9ydCB0aGVtIGluIGRp
ZmZlcmVudCB3YXkvdW5pdHMsIG9yDQo+IG1heSBzaW1wbHkgbm90IHJlcG9ydCBhbnl0aGluZyBh
dCBhbGwgZm9yIHNvbWUgdGVjaG5pY2FsIHJlYXNvbi4NCj4NCj4gS2VybmVscyB0aGF0IGRvIG5v
dCBoYXZlIHRoaXMgZmVhdHVyZSB3aWxsIG5vdCByZXBvcnQgYW55dGhpbmcgYXQgYWxsDQo+IGVp
dGhlci4NCg0KTXkgZXhwZWN0YXRpb24gaXMgdGhhdCBmb3IgYSBnaXZlbiBqc29uIGF0dHJpYnV0
ZSBuYW1lIGFueSB2ZW5kb3INCmJhY2tlbmQgdGhhdCBzdXBwb3J0cyBpdCBtdXN0IGNvbnZleSBp
dCBpbiBhIGNvbXBhdGlibGUgd2F5LiBJZiBhDQpnaXZlbiBhdHRyaWJ1dGUgZG9lcyBub3QgbWFr
ZSBzZW5zZSBmb3IgYSBnaXZlbiB2ZW5kb3IsIG9yIGlzIG5vdCB5ZXQNCmltcGxlbWVudGVkIHRo
ZW4gbGVhdmluZyBpdCB1bnBvcHVsYXRlZCBpcyBpbmRlZWQgdGhlIGV4cGVjdGF0aW9uLg0KDQpU
aGUgZ29hbCBpcyB0byBib3RoIG1pbmltaXplIHZlbmRvciBzcGVjaWZpYyBsb2dpYyBpbiBpbmZy
YXN0cnVjdHVyZQ0KdGhhdCBjb25zdW1lcyB0aGUgbmRjdGwganNvbiB3aGlsZSBhdCB0aGUgc2Ft
ZSB0aW1lIGJhbGFuY2UgdmVuZG9yDQpuZWVkcy4gSW4gb3RoZXIgd29yZHMgYXZvaWQgIm5lZWRs
ZXNzIiBkaWZmZXJlbnRpYXRpb24gYXMgbXVjaCBhcw0KcG9zc2libGUgd2l0aCBzbWFsbCBhbW91
bnQgb2YgY29tcGF0IHdvcmsgYWNyb3NzIHZlbmRvcnMuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
bnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
