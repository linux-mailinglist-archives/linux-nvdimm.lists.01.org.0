Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4234431D454
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 04:55:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DD65100EAB4E;
	Tue, 16 Feb 2021 19:55:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 44483100EAB4D
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:55:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id n1so4458397edv.2
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+XdSGRDC+UKZZb+od4CJ/ox1PUUGOWH7HVwdvWgOms=;
        b=Qd9vr/arQTN+PcJt3DWX6TO3dsl6/R80iu/o6waYw4xwTrj6mYvu+HVXKipiU75PY7
         kNAu5uFtgqL5FAO9tZp7C/4Xd+6zSTr4k1ONKPg5SDclVhS01GklWKJuUTaPrIFoqEmY
         lfQwYF73uPhqOt59UyZteqP+avjsKt7a3D2RDqyPpHnsPO9uh8CYMkmdYulIc5I1mbv7
         qm2fdAhVB7tbnnzp2yVzqycJ0dFLIRBhkP+pLLjHFGgqILyfp/50F9sPubyMnCVUAogu
         Otrh17mdzLdzRED7yW3i1qAwgEikA3840gh1bM6ED3vFD14WwQxNIV11YmsDikTQW+fy
         Z3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+XdSGRDC+UKZZb+od4CJ/ox1PUUGOWH7HVwdvWgOms=;
        b=b4aoONsPLFBLgHy0nKK0cpHOBND6DNB3EWEySSiOEWLZHB/lnrG2uilXncTlDiWR+e
         yHQK4Pn5jF7hqjb8VhTGtYZ75StRrXPu8FsCtGlfCwKhOxm4zb8sWdp17+xjFxj535uj
         ZG3vm4oQAAVse49lERifTQPb0Snk8eUhA13CuyvBveXThi4DZb3mKJLYLW66+dZirBEH
         Ah/1aumFXaZP6dYGlwlSq70jILJ4xkQRbLt4s43vXh4qY6rPP7kdd4hOl7ef7DKxGQSm
         +T1CHc+CttEY5FZe6f0QerAm2nfINKb/MY5ThZsAl8ASXXRSOpqmBqlgz2Orjd3qySep
         zgsg==
X-Gm-Message-State: AOAM533icmV3FYDWjeCbOXlLE1kkItsYxiwyvY/8b9KURAUcYRazhYp5
	Dq8aNEYQEjdYBPWDZf9rI67RDMxmfGvXjcAiZsFcaw==
X-Google-Smtp-Source: ABdhPJxbyEummMiLabbqUc5of7znDOlGaSNSQaPzX6SYYjiEpYGI47uLVWLG+/V/yL78HvLrDpa0nfbhFqs2CjpNSJo=
X-Received: by 2002:aa7:c58b:: with SMTP id g11mr18792732edq.354.1613534130701;
 Tue, 16 Feb 2021 19:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20210205222842.34896-1-uwe@kleine-koenig.org> <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Feb 2021 19:55:20 -0800
Message-ID: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Message-ID-Hash: JKHHJ7CHRBT6XEZHCHLFAFWUUUEOJKRC
X-Message-ID-Hash: JKHHJ7CHRBT6XEZHCHLFAFWUUUEOJKRC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JKHHJ7CHRBT6XEZHCHLFAFWUUUEOJKRC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBGZWIgMTYsIDIwMjEgYXQgNzo0OCBQTSBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIEZyaSwgRmViIDUsIDIwMjEgYXQgMjoyOSBQ
TSBVd2UgS2xlaW5lLUvDtm5pZyA8dXdlQGtsZWluZS1rb2VuaWcub3JnPiB3cm90ZToNCj4gPg0K
PiA+IEhlbGxvLA0KPiA+DQo+ID4gSSBkaWRuJ3QgZ2V0IGFueSBmZWVkYmFjayBmb3IgdGhlIChp
bXBsaWNpdCkgdjEgb2YgdGhpcyBzZXJpZXMgdGhhdA0KPiA+IHN0YXJ0ZWQgd2l0aCBNZXNzYWdl
LUlkOiAyMDIxMDEyNzIzMDEyNC4xMDk1MjItMS11d2VAa2xlaW5lLWtvZW5pZy5vcmcsDQo+ID4g
YnV0IEkgaWRlbnRpZmllZCBhIGZldyBpbXByb3ZlbWVudHMgbXlzZWxmOg0KPiA+DQo+ID4gIC0g
VXNlICJkYXgtZGV2aWNlIiBjb25zaXN0ZW50bHkgYXMgYSBwcmVmaXgNCj4gPiAgLSBJbnN0ZWFk
IG9mIHJlcXVpcmluZyBhIC5yZW1vdmUgY2FsbGJhY2ssIG1ha2UgaXQgZXhwbGljaXRseQ0KPiA+
ICAgIG9wdGlvbmFsLiAoRHJvcCBjaGVja2luZyBmb3IgLnJlbW92ZSBmcm9tIGZvcm1lciBwYXRj
aCAxLCBpbnRyb2R1Y2UNCj4gPiAgICBuZXcgcGF0Y2ggIlByb3Blcmx5IGhhbmRsZSBkcml2ZXJz
IHdpdGhvdXQgcmVtb3ZlIGNhbGxiYWNrIikNCj4gPiAgLSBUaGUgbmV3IHBhdGNoIGFib3V0IHJl
bW92ZSBiZWluZyBvcHRpb25hbCBhbGxvd3MgdG8gc2ltcGxpZnkgb25lIG9mDQo+ID4gICAgdGhl
IHR3byBkYXggZHJpdmVycyB3aGljaCBpcyBpbXBsZW1lbnRlZCBpbiBwYXRjaCA0DQo+ID4gIC0g
UGF0Y2ggNSBnb3QgYSBiaXQgc21hbGxlciBiZWNhdXNlIHdlIG5vdyBoYXZlIG9uZSBkcml2ZXIg
bGVzcyB3aXRoIGENCj4gPiAgICByZW1vdmUgY2FsbGJhY2suDQo+ID4gIC0gQWRkZWQgQW5kcmV3
IHRvIFRvOiBhcyBoZSBtZXJnZWQgZGF4IGRyaXZlcnMgaW4gdGhlIHBhc3QuDQo+ID4NCj4gPiBB
bmRyZXc6IEFzc3VtaW5nIHlvdSBjb25zaWRlciB0aGVzZSBwYXRjaGVzIHVzZWZ1bCwgd291bGQg
eW91IHBsZWFzZQ0KPiA+IGNhcmUgZm9yIG1lcmdpbmcgdGhlbT8NCj4NCj4gSSd2ZSByb3V0ZWQg
ZGV2aWNlLWRheCBwYXRjaGVzIHRocm91Z2ggQW5kcmV3IHdoZW4gdGhleSBoYWQgY29yZS1tbQ0K
PiBlbnRhbmdsZW1lbnRzLCBidXQgYSBwdXJlIGRldmljZS1kYXggc2VyaWVzIGxpa2UgdGhpcyBJ
IGNhbiB0YWtlDQo+IHRocm91Z2ggbXkgdHJlZS4NCj4NCj4gT25lIHNtYWxsIGNvbW1lbnQgb24g
cGF0Y2g1LCBvdGhlcndpc2UgbG9va3MgZ29vZC4NCg0KSSB0YWtlIGl0IGJhY2ssIHBhdGNoNSBs
b29rcyBnb29kLiBJIHdhcyBnb2luZyB0byBhc2sgYWJvdXQgdGhlIHJldHVybg0KdmFsdWUgcmVt
b3ZhbCBmb3IgZGF4X2J1c19yZW1vdmUoKSwgYnV0IHRoYXQgd291bGQgbmVlZCBzdHJ1Y3QNCmJ1
c190eXBlIHRvIGNoYW5nZSBwcm90b3R5cGVzLg0KDQpBbGwgbWVyZ2VkIHRvIHRoZSBudmRpbW0g
dHJlZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
