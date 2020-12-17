Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADE2DD446
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 16:35:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CE5A100EB82F;
	Thu, 17 Dec 2020 07:35:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D5FB100EB82E
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 07:35:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so4323656pjl.0
        for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 07:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cF1lpVOfX+qqIliOA4fJEolSXJPbWdzTY82HZk7M6Ss=;
        b=jmCoo2KfKiXBFPZ5Pu4hTHY3iB5JmJdEW2xDg11/qL0XDN1JfsdN7XyC2j8sEoH95y
         GFMTYGr0oCS+l4J4pMyQxd8aZ/F75Twiay44FOIBLAxCIaB28JlAUo9Ib+wLBPNGhIB5
         JZos5e7Irlc2WYQAdv2N/x8jYTVEVdXO+q3lEFoIwQJafSWpP75RiwxCcuG16exsWsl1
         /xaldJycza+FyblXi0w7S8BUo7Flvd3XJQ13gxiBJ6wf0KNWX2NhU00LCXp3C5ufBfWG
         twR6w2w9HVJM956l2GZbRuU5Uhi+JmF4wOm7e79KWTwg3krAg7CO6ep+OzxKH/X27pcp
         D66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cF1lpVOfX+qqIliOA4fJEolSXJPbWdzTY82HZk7M6Ss=;
        b=PfKs6v65KRqHxnVA5gcDlLnUUq2LFitQKwnN5Idn7DAhTwYDuJTlOF7AOWrs0WIzwI
         OqE8xhDb+4KZ9ApHbReKP3cjgN2y+Cls1+HdHApDu9uaByBTCLn3pWz9zisMN8R07bGl
         4l1eT4Ecacc90PLskpPOULA4fNwOLQcZOOrVZMBtyRBlNYFPm+Av2Cvdfm7BoGeT7TCr
         zRlLNE5SNaLaocSrKGjh1sFuJrViaPyJgMr7CaYWh3mBDHmFpYPc6IVRU8aLaVJpOpah
         EgW6ob7NPuchVg9roRz1ppa/klObSPc7Q5Vjw7W79k4S3/PWdGQAxJ9kkPyX5i31mO7e
         ZOXw==
X-Gm-Message-State: AOAM531rbY6iv4LIJWBpZ6fXvE+VO3b2tExJyOp5p9OTX/oI5zBZy8NY
	vkf6dnpbfZFw6MCxHLOW6zRvLw==
X-Google-Smtp-Source: ABdhPJxqYT8PU/t0P9GGyShWjJrS4X7K4WGiEwYmQMQu9GEUzGcTkb4Xv4/Y1sZVsWotkJYwFWmFsw==
X-Received: by 2002:a17:902:64:b029:da:a9cf:4065 with SMTP id 91-20020a1709020064b02900daa9cf4065mr36533471pla.26.1608219321514;
        Thu, 17 Dec 2020 07:35:21 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:9dc1:d988:a568:787a? ([2601:646:c200:1ef2:9dc1:d988:a568:787a])
        by smtp.gmail.com with ESMTPSA id r123sm6059458pfr.68.2020.12.17.07.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:35:20 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Date: Thu, 17 Dec 2020 07:35:18 -0800
Message-Id: <24F5DC49-1FB3-42CF-8323-B0B39D936F7F@amacapital.net>
References: <20201217131924.GW3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201217131924.GW3040@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (18B121)
Message-ID-Hash: O2BR2ZFIVNVABO4DHHRBFUIL74O4EUK2
X-Message-ID-Hash: O2BR2ZFIVNVABO4DHHRBFUIL74O4EUK2
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O2BR2ZFIVNVABO4DHHRBFUIL74O4EUK2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIERlYyAxNywgMjAyMCwgYXQgNToxOSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgRGVjIDE3LCAyMDIwIGF0IDAy
OjA3OjAxUE0gKzAxMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+PiBPbiBGcmksIERlYyAx
MSAyMDIwIGF0IDE0OjE0LCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+Pj4+IE9uIE1vbiwgTm92
IDIzLCAyMDIwIGF0IDEwOjEwIFBNIDxpcmEud2VpbnlAaW50ZWwuY29tPiB3cm90ZToNCj4+PiBB
ZnRlciBjb250ZW1wbGF0aW5nIHRoaXMgZm9yIGEgYml0LCBJIHRoaW5rIHRoaXMgaXNuJ3QgcmVh
bGx5IHRoZQ0KPj4+IHJpZ2h0IGFwcHJvYWNoLiAgSXQgKndvcmtzKiwgYnV0IHdlJ3ZlIG1vc3Rs
eSBqdXN0IGNyZWF0ZWQgYSBiaXQgb2YgYW4NCj4+PiB1bmZvcnR1bmF0ZSBzaXR1YXRpb24uICBP
dXIgc3RhY2ssIG9uIGEgKHBvc3NpYmx5IG5lc3RlZCkgZW50cnkgbG9va3MNCj4+PiBsaWtlOg0K
Pj4+IA0KPj4+IHByZXZpb3VzIGZyYW1lIChvciBlbXB0eSBpZiB3ZSBjYW1lIGZyb20gdXNlcm1v
ZGUpDQo+Pj4gLS0tDQo+Pj4gU1MNCj4+PiBSU1ANCj4+PiBGTEFHUw0KPj4+IENTDQo+Pj4gUklQ
DQo+Pj4gcmVzdCBvZiBwdF9yZWdzDQo+Pj4gDQo+Pj4gQyBmcmFtZQ0KPj4+IA0KPj4+IGlycWVu
dHJ5X3N0YXRlX3QgKG1heWJlIC0tIHRoZSBjb21waWxlciBpcyB3aXRoaW4gaXRzIHJpZ2h0cyB0
byBwbGF5DQo+Pj4gYWxtb3N0IGFyYml0cmFyeSBnYW1lcyBoZXJlKQ0KPj4+IA0KPj4+IG1vcmUg
QyBzdHVmZg0KPj4+IA0KPj4+IFNvIHdoYXQgd2UndmUgYWNjb21wbGlzaGVkIGlzIGhhdmluZyB0
d28gZGlzdGluY3QgYXJjaCByZWdpc3Rlcg0KPj4+IHJlZ2lvbnMsIG9uZSBjYWxsZWQgcHRfcmVn
cyBhbmQgdGhlIG90aGVyIHN0dWNrIGluIGlycWVudHJ5X3N0YXRlX3QuDQo+Pj4gVGhpcyBpcyBh
bm5veWluZyBiZWNhdXNlIGl0IG1lYW5zIHRoYXQsIGlmIHdlIHdhbnQgdG8gYWNjZXNzIHRoaXMN
Cj4+PiB0aGluZyB3aXRob3V0IHBhc3NpbmcgYSBwb2ludGVyIGFyb3VuZCBvciBhY2Nlc3MgaXQg
YXQgYWxsIGZyb20gb3V0ZXINCj4+PiBmcmFtZXMsIHdlIG5lZWQgdG8gZG8gc29tZXRoaW5nIHRl
cnJpYmxlIHdpdGggdGhlIHVud2luZGVyLCBhbmQgd2UNCj4+PiBkb24ndCB3YW50IHRvIGdvIHRo
ZXJlLg0KPj4+IA0KPj4+IFNvIEkgcHJvcG9zZSBhIHNvbWV3aGF0IGRpZmZlcmVudCBzb2x1dGlv
bjogbGF5IG91dCB0aGUgc3RhY2sgbGlrZSB0aGlzLg0KPj4+IA0KPj4+IFNTDQo+Pj4gUlNQDQo+
Pj4gRkxBR1MNCj4+PiBDUw0KPj4+IFJJUA0KPj4+IHJlc3Qgb2YgcHRfcmVncw0KPj4+IFBLUw0K
Pj4+IF5eXl5eXl5eIGV4dGVuZGVkX3B0X3JlZ3MgcG9pbnRzIGhlcmUNCj4+PiANCj4+PiBDIGZy
YW1lDQo+Pj4gbW9yZSBDIHN0dWZmDQo+Pj4gLi4uDQo+Pj4gDQo+Pj4gSU9XIHdlIGhhdmU6DQo+
Pj4gDQo+Pj4gc3RydWN0IGV4dGVuZGVkX3B0X3JlZ3Mgew0KPj4+ICBib29sIHJjdV93aGF0ZXZl
cjsNCj4+PiAgb3RoZXIgZ2VuZXJpYyBmaWVsZHMgaGVyZTsNCj4+PiAgc3RydWN0IGFyY2hfZXh0
ZW5kZWRfcHRfcmVncyBhcmNoX3JlZ3M7DQo+Pj4gIHN0cnVjdCBwdF9yZWdzIHJlZ3M7DQo+Pj4g
fTsNCj4+PiANCj4+PiBhbmQgYXJjaF9leHRlbmRlZF9wdF9yZWdzIGhhcyB1bnNpZ25lZCBsb25n
IHBrczsNCj4+PiANCj4+PiBhbmQgaW5zdGVhZCBvZiBwYXNzaW5nIGEgcG9pbnRlciB0byBpcnFl
bnRyeV9zdGF0ZV90IHRvIHRoZSBnZW5lcmljDQo+Pj4gZW50cnkvZXhpdCBjb2RlLCB3ZSBqdXN0
IHBhc3MgYSBwdF9yZWdzIHBvaW50ZXIuDQo+PiANCj4+IFdoaWxlIEkgYWdyZWUgdnMuIFBLUyB3
aGljaCBpcyBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgc3RhdGUgYW5kIG5lZWRlZCBpbg0KPj4gb3Ro
ZXIgcGxhY2VzIGUuZy4gI1BGLCBJJ20gbm90IGNvbnZpbmNlZCB0aGF0IHN0aWNraW5nIHRoZSBl
eGlzdGluZw0KPj4gc3RhdGUgaW50byB0aGUgc2FtZSBhcmVhIGJ1eXMgdXMgYW55dGhpbmcgbW9y
ZSB0aGFuIGFuIGluZGlyZWN0IGFjY2Vzcy4NCj4+IA0KPj4gUGV0ZXI/DQo+IA0KPiBBZ3JlZWQ7
IHRoYXQgaW1tZWRpYXRlbHkgc29sdmVzIHRoZSBjb25mdXNpb24gSXJhIGhhZCBhcyB3ZWxsLiBX
aGlsZQ0KPiBleHRlbmRpbmcgcHRfcmVncyBzb3VuZHMgc2NhcnksIEkgdGhpbmsgd2UndmUgaXNv
bGF0ZWQgb3VyIHB0X3JlZ3MNCj4gaW1wbGVtZW50YXRpb24gZnJvbSBhY3R1YWwgQUJJIHByZXR0
eSB3ZWxsLCBidXQgb2YgY291cnNlLCB0aGF0IHdvdWxkDQo+IG5lZWQgYW4gYXVkaXQuIFdlIGRv
bid0IHdhbnQgdG8gbGVhayB0aGlzIGludG8gc2lnbmFscyBmb3IgZXhhbXBsZS4NCj4gDQoNCkni
gJltIG9rYXkgd2l0aCB0aGlzLg0KDQpNeSBzdWdnZXN0aW9uIGZvciBoYXZpbmcgYW4gZXh0ZW5k
ZWQgcHRfcmVncyB0aGF0IGNvbnRhaW5zIHB0X3JlZ3MgaXMgdG8ga2VlcCBleHRlbnNpb25zIGxp
a2UgdGhpcyBpbnZpc2libGUgdG8gdW5zdXNwZWN0aW5nIHBhcnRzIG9mIHRoZSBrZXJuZWwuIElu
IHBhcnRpY3VsYXIsIEJQRiBzZWVtcyB0byBwYXNzIGFyb3VuZCBzdHJ1Y3QgcHRfcmVncyAqLCBh
bmQgSSBkb27igJl0IGtub3cgd2hhdCB0aGUgaW1wbGljYXRpb25zIG9mIGVmZmVjdGl2ZWx5IG9m
ZnNldHRpbmcgYWxsIHRoZSByZWdpc3RlcnMgcmVsYXRpdmUgdG8gdGhlIHBvaW50ZXIgd291bGQg
YmUuDQoNCkFueXRoaW5nIHRoYXQgYWN0dWFsbHkgYnJva2UgdGhlIHNpZ25hbCByZWdzIEFCSSBz
aG91bGQgYmUgbm90aWNlZCBieSB0aGUgeDg2IHNlbGZ0ZXN0cyDigJQgdGhlIHRlc3RzIHJlYWQg
YW5kIHdyaXRlIHJlZ2lzdGVycyB0aHJvdWdoIHVjb250ZXh0Lg0KDQo+IApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
