Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA11C2936
	for <lists+linux-nvdimm@lfdr.de>; Sun,  3 May 2020 02:30:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D4FA1161378F;
	Sat,  2 May 2020 17:28:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42B5E1161378C
	for <linux-nvdimm@lists.01.org>; Sat,  2 May 2020 17:28:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so4597045wml.2
        for <linux-nvdimm@lists.01.org>; Sat, 02 May 2020 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V2nT+jmzW6uK6j6RNvaRunaFhSFW7qRx5cWISy3xtsQ=;
        b=E1AEkHox21046/Jzv0H2sg0BIzJvXI5WKdhrIfyzhtFbc0BBr2Jbbo4W/cz61zuCWi
         N7wfdgGQbbeddGO74JguUI2EXq4+V2iEf/49y27rGKNWMBfesVlzBgPOzVPeBAWsDjVi
         MwfyIgQ4sj5GybFYWk26pinWgUjQkfCWZ6xmmDA/YANZdJExvY+1eHRU0qsu08dgxRg4
         yba0Fz8wK4DVM4JNI9vneWIr8MwO1iTNEI1j2c8OtrlAD2zgZyVuN0UPndhOvADA09K0
         oGD9E7oaU2Xm77LaL1nDwVx5b0TQ2W5oTxfvUMvijPlQLM0HQwCdOkQFHHjX+VELIOiy
         0BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V2nT+jmzW6uK6j6RNvaRunaFhSFW7qRx5cWISy3xtsQ=;
        b=jCvbyz5HBqtoDUVdZK7Q1vJPtv+Z/2tGdZoXvebVPjID3ruDxcNK0tDsXseumZHUm0
         GwzR9whC7fZbUGSjmHp1cuFV3wbDqBCYlij2zS2T3rObLRJ+IKjUd+TRlC9ltIGCfSBz
         OpqmIyJ223rbSAMiUJfm4+4ZDkI4p/E1T/z+Ch6I548hRk637CzmRzKrx14WaIh/yGUk
         +n9jnoP5SHWsPRuUTAafjOX6Kd6D67Gnta8PZob3tlzqybLr1PrWbtHwKeOHEYMHSZrI
         IrVotLdGTJCW4GysRkrRXIEh4V/L/B/Y+UXTIeqAv2eSunNSkHcCzvY87viq2pbJ3Pax
         J/VQ==
X-Gm-Message-State: AGi0PuY3q0/EwHeoZMjUHOWCACJpt4RgAFIuQbJACSDJcCdyN0yXWtKE
	jTkzV6kXs54gflX93bUuvlfY8XUM7Fq0r6mNmv95ww==
X-Google-Smtp-Source: APiQypK033BSVa5j3+ZhThYcEUFkwS26U4I4SJPdSG0fksA6GljM8v6NbCEY+NCeISjVSggtF2WxUBXyAZEAOTUxbUM=
X-Received: by 2002:a1c:4186:: with SMTP id o128mr6735406wma.21.1588465809902;
 Sat, 02 May 2020 17:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net> <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 2 May 2020 17:29:57 -0700
Message-ID: <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: "Luck, Tony" <tony.luck@intel.com>
Message-ID-Hash: HNNC544O2V56D7FJS2TR5Z67YVCMJE37
X-Message-ID-Hash: HNNC544O2V56D7FJS2TR5Z67YVCMJE37
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Tsaur, Erwin" <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HNNC544O2V56D7FJS2TR5Z67YVCMJE37/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBNYXkgMSwgMjAyMCBhdCA3OjA5IEFNIEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRl
bC5jb20+IHdyb3RlOg0KPg0KPiA+IE5vdyBtYXliZSBjb3B5X3RvX3VzZXIoKSBzaG91bGQgKmFs
d2F5cyogd29yayB0aGlzIHdheSwgYnV0IEnigJltIG5vdCBjb252aW5jZWQuDQo+ID4gQ2VydGFp
bmx5IHB1dF91c2VyKCkgc2hvdWxkbuKAmXQg4oCUIHRoZSByZXN1bHQgd291bGRu4oCZdCBldmVu
IGJlIHdlbGwgZGVmaW5lZC4gQW5kIEnigJltDQo+ID4gIHVuY29udmluY2VkIHRoYXQgaXQgbWFr
ZXMgbXVjaCBzZW5zZSBmb3IgdGhlIG1ham9yaXR5IG9mIGNvcHlfdG9fdXNlcigpIGNhbGxlcnMN
Cj4gPiAgdGhhdCBhcmUgYWxzbyBkaXJlY3RseSBhY2Nlc3NpbmcgdGhlIHNvdXJjZSBzdHJ1Y3R1
cmUuDQo+DQo+IE9uZSBjYXNlIHRoYXQgbWlnaHQgd29yayBpcyBjb3B5X3RvX3VzZXIoKSB0aGF0
J3MgY29weWluZyBmcm9tIHRoZSBrZXJuZWwgcGFnZSBjYWNoZQ0KPiB0byB0aGUgdXNlciBpbiBy
ZXNwb25zZSB0byBhIHJlYWQoMikgc3lzdGVtIGNhbGwuICBBY3Rpb24gd291bGQgYmUgdG8gY2hl
Y2sgaWYgd2UgY291bGQNCj4gcmUtcmVhZCBmcm9tIHRoZSBmaWxlIHN5c3RlbSB0byBhIGRpZmZl
cmVudCBwYWdlLiBJZiBub3QsIHJldHVybiAtRUlPLiBFaXRoZXIgd2F5IGRpdGNoIHRoZQ0KPiBw
b2lzb24gcGFnZSBmcm9tIHRoZSBwYWdlIGNhY2hlLg0KPg0KDQpJIHRoaW5rIHRoYXQsIGJlZm9y
ZSB3ZSBkbyB0b28gbXVjaCBkZXNpZ24gb2YgdGhlIHNlbWFudGljcyBvZiBqdXN0DQp0aGUgY29w
eSBmdW5jdGlvbiwgd2UgbmVlZCBhIGRlc2lnbiBmb3IgdGhlIHdob2xlIHN5c3RlbS4NClNwZWNp
ZmljYWxseToNCg0KV2hlbiB0aGUga2VybmVsIGZpbmRzIG91dCB0aGF0IGEga2VybmVsIHBhZ2Ug
aXMgYmFkICh2aWEgI01DIG9yIHZpYQ0KYW55IG90aGVyIG1lY2hhbmlzbSksIHdoYXQgZG9lcyB0
aGUga2VybmVsIGRvPyAgRG9lcyBpdCB1bm1hcCBpdD8NCkRvZXMgaXQgcmVwbGFjZSBpdCB3aXRo
IGEgZHVtbXkgcGFnZT8gIERvZXMgaXQgbGVhdmUgaXQgdGhlcmU/DQoNCldoZW4gYSBjb3B5IGZ1
bmN0aW9uIGhpdHMgYSBiYWQgcGFnZSBhbmQgdGhlIHBhZ2UgaXMgbm90IHlldCBrbm93biB0bw0K
YmUgYmFkLCB3aGF0IGRvZXMgaXQgZG8/ICAoSS5lLiB0aGUgcGFnZSB3YXMgYmVsaWV2ZWQgdG8g
YmUgZmluZSBidXQNCnRoZSBjb3B5IGZ1bmN0aW9uIGdldHMgI01DLikgIERvZXMgaXQgdW5tYXAg
aXQgcmlnaHQgYXdheT8gIFdoYXQgZG9lcw0KaXQgcmV0dXJuPw0KDQpXaGVuIGEgY29weSBmdW5j
dGlvbiBoaXRzIGEgcGFnZSB0aGF0IGlzIGFscmVhZHkga25vd24gdG8gYmUgYmFkDQpiZWNhdXNl
IHRoZSBrZXJuZWwgZ290IHRoZSAib2ggY3JhcCwgYmFkIHBhZ2UiIG5vdGlmaWNhdGlvbiBlYXJs
aWVyLA0Kd2hhdCBkb2VzIGl0IGRvPyAgUmV0dXJuIC1FSU8/ICBUYWtlIHNvbWUgZmFuY2llciBh
Y3Rpb24gdW5kZXIgdGhlDQphc3N1bXB0aW9uIHRoYXQgaXQncyBjYWxsZWQgaW4gYSBwcmVlbXB0
aWJsZSwgSVJRcy1vbiBjb250ZXh0LCB3aGVyZWFzDQp0aGUgb3JpZ2luYWwgI01DIG9yIG90aGVy
IGhhcmR3YXJlIG5vdGlmaWNhdGlvbiBtYXkgaGF2ZSBjb21lIGF0IGENCmxlc3Mgb3Bwb3J0dW5l
IHRpbWU/Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
