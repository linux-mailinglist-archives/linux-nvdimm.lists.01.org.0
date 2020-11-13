Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B72B294A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 14 Nov 2020 00:42:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29D10100EB35E;
	Fri, 13 Nov 2020 15:42:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com; envelope-from=guroan@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD722100EB359
	for <linux-nvdimm@lists.01.org>; Fri, 13 Nov 2020 15:42:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r9so16568696lfn.11
        for <linux-nvdimm@lists.01.org>; Fri, 13 Nov 2020 15:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JqzzLgIvxHqw73GCku4Mas63TAVlMZ5DWuV5xVfKdKs=;
        b=B0r19MMZBS4qnPOpH3Oh7mviI2ESDdHEhgo+UT9aZXskXoEd9SnPfMI/JIQYxPxtOR
         EGdJ2X/BFGo2JIgPc7YKwL5OHO+C0iGUlcLt7SsFk5strPrUoRxXyWJ0RUiRQlWr4+Q9
         UGWo8SVcac0O9tQYHuBdOkO7NOuKdAMPi3UiVqcUEf+/yt3BCTCvkiiO9shXsZcgvKCI
         mqX10Qdfqu4P8JgnD2ndzSSlvwFINTNV0y8KdpRHFKCK3X2fikhgsl9ap1i9u5iJJjMW
         PWLkp0ZY+5TBxslo+fG0/WW3kZ1717ioHRkZ7oRtRA7lwDMuCMImPvZsEfTtSS5PpFGO
         gyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqzzLgIvxHqw73GCku4Mas63TAVlMZ5DWuV5xVfKdKs=;
        b=GewBSWBAdD+MVMjzO0hpcU2gkeSTWy3OH7MowrNkAksyKH9FLerUhija1eUt+XoauI
         ma5KTFH0PFQ7XnCOs8OoLtjtNIcrBW6gGovkMSWbUYEPAwimiIh2T8Y9KkX3qkKT2Zau
         QqB18/g3hb5HTIu9XO1PctZnp7pO8I9tY+BplvZ1lsKMnSi7ehXjRak5NXlaAMPqdYuF
         Ki59hii5auvWIptbgf0x59a3WGH4p/DAr6/sZ9sSZ8NGdfM1S8ss7Cu0R5+sjBnx77RP
         H89R/P7xfXLbsBADFKnlmniVLxXPGanu/hT+wPf/io6niPX2UAs2Ao/Tlv232/NVysHI
         siew==
X-Gm-Message-State: AOAM531O2zKowt/CKiZ6Sb9//gBtiFvfxYBIigZIBNrRl0RabJf3lzUt
	NiWyxetKB8RsoXhz0y5FRBjtAJY2JdW+AFqsoVc=
X-Google-Smtp-Source: ABdhPJzhCiM/9It/85NbIdVKdebxXQcus40OOuN1h7PzHPVAvA/sjezmqkryt630ZVNrgKRfchCjAC+cyB3SFkLkebc=
X-Received: by 2002:a19:e84:: with SMTP id 126mr1806647lfo.432.1605310957017;
 Fri, 13 Nov 2020 15:42:37 -0800 (PST)
MIME-Version: 1.0
References: <20201110151444.20662-1-rppt@kernel.org> <20201110151444.20662-7-rppt@kernel.org>
In-Reply-To: <20201110151444.20662-7-rppt@kernel.org>
From: Roman Gushchin <guroan@gmail.com>
Date: Fri, 13 Nov 2020 15:42:25 -0800
Message-ID: <CALo0P13aq3GsONnZrksZNU9RtfhMsZXGWhK1n=xYJWQizCd4Zw@mail.gmail.com>
Subject: Re: [PATCH v8 6/9] secretmem: add memcg accounting
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: A3ON7UYR464QON5AYGLUL6JNJIZK4XYS
X-Message-ID-Hash: A3ON7UYR464QON5AYGLUL6JNJIZK4XYS
X-MailFrom: guroan@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-ap
 i@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3ON7UYR464QON5AYGLUL6JNJIZK4XYS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

0LLRgiwgMTAg0L3QvtGP0LEuIDIwMjAg0LMuINCyIDA3OjE2LCBNaWtlIFJhcG9wb3J0IDxycHB0
QGtlcm5lbC5vcmc+Og0KPg0KPiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5j
b20+DQo+DQo+IEFjY291bnQgbWVtb3J5IGNvbnN1bWVkIGJ5IHNlY3JldG1lbSB0byBtZW1jZy4g
VGhlIGFjY291bnRpbmcgaXMgdXBkYXRlZA0KPiB3aGVuIHRoZSBtZW1vcnkgaXMgYWN0dWFsbHkg
YWxsb2NhdGVkIGFuZCBmcmVlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8
cnBwdEBsaW51eC5pYm0uY29tPg0KPiAtLS0NCj4gIG1tL2ZpbGVtYXAuYyAgIHwgIDIgKy0NCj4g
IG1tL3NlY3JldG1lbS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFwLmMNCj4gaW5k
ZXggMjQ5Y2Y0ODlmNWRmLi4xMTM4N2EwNzczNzMgMTAwNjQ0DQo+IC0tLSBhL21tL2ZpbGVtYXAu
Yw0KPiArKysgYi9tbS9maWxlbWFwLmMNCj4gQEAgLTg0NCw3ICs4NDQsNyBAQCBzdGF0aWMgbm9p
bmxpbmUgaW50IF9fYWRkX3RvX3BhZ2VfY2FjaGVfbG9ja2VkKHN0cnVjdCBwYWdlICpwYWdlLA0K
PiAgICAgICAgIHBhZ2UtPm1hcHBpbmcgPSBtYXBwaW5nOw0KPiAgICAgICAgIHBhZ2UtPmluZGV4
ID0gb2Zmc2V0Ow0KPg0KPiAtICAgICAgIGlmICghaHVnZSkgew0KPiArICAgICAgIGlmICghaHVn
ZSAmJiAhcGFnZS0+bWVtY2dfZGF0YSkgew0KPiAgICAgICAgICAgICAgICAgZXJyb3IgPSBtZW1f
Y2dyb3VwX2NoYXJnZShwYWdlLCBjdXJyZW50LT5tbSwgZ2ZwKTsNCj4gICAgICAgICAgICAgICAg
IGlmIChlcnJvcikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4gZGlm
ZiAtLWdpdCBhL21tL3NlY3JldG1lbS5jIGIvbW0vc2VjcmV0bWVtLmMNCj4gaW5kZXggMWFhMmI3
Y2ZmZTBkLi4xZWI3NjY3MDE2ZmEgMTAwNjQ0DQo+IC0tLSBhL21tL3NlY3JldG1lbS5jDQo+ICsr
KyBiL21tL3NlY3JldG1lbS5jDQo+IEBAIC0xNyw2ICsxNyw3IEBADQo+ICAjaW5jbHVkZSA8bGlu
dXgvc3lzY2FsbHMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3BzZXVkb19mcy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21lbWNvbnRyb2wuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9zZXRfbWVtb3J5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2No
ZWQvc2lnbmFsLmg+DQo+DQo+IEBAIC00OSw2ICs1MCwzOCBAQCBzdHJ1Y3Qgc2VjcmV0bWVtX2N0
eCB7DQo+DQo+ICBzdGF0aWMgc3RydWN0IGNtYSAqc2VjcmV0bWVtX2NtYTsNCj4NCg0KSGkgTWlr
ZSENCg0KPiArc3RhdGljIGludCBzZWNyZXRtZW1fbWVtY2dfY2hhcmdlKHN0cnVjdCBwYWdlICpw
YWdlLCBnZnBfdCBnZnAsIGludCBvcmRlcikNCj4gK3sNCj4gKyAgICAgICB1bnNpZ25lZCBsb25n
IG5yX3BhZ2VzID0gKDEgPDwgb3JkZXIpOw0KPiArICAgICAgIGludCBpLCBlcnI7DQo+ICsNCj4g
KyAgICAgICBlcnIgPSBtZW1jZ19rbWVtX2NoYXJnZV9wYWdlKHBhZ2UsIGdmcCwgb3JkZXIpOw0K
PiArICAgICAgIGlmIChlcnIpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiArDQo+
ICsgICAgICAgZm9yIChpID0gMTsgaSA8IG5yX3BhZ2VzOyBpKyspIHsNCj4gKyAgICAgICAgICAg
ICAgIHN0cnVjdCBwYWdlICpwID0gcGFnZSArIGk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIHAt
Pm1lbWNnX2RhdGEgPSBwYWdlLT5tZW1jZ19kYXRhOw0KPiArICAgICAgIH0NCg0KSG0sIGl0IGxv
b2tzIHZlcnkgc3RyYW5nZSB0byBtZS4gV2h5IGRvIHdlIG5lZWQgdG8gY29weSBtZW1jZ19kYXRh
Pw0KV2hhdCBhYm91dCBjc3MgcmVmZXJlbmNlIGNvdW50aW5nPw0KDQpBbmQgd2hhdCBhYm91dCBz
dGF0aXN0aWNzPw0KDQpJJ20gc29ycnkgZm9yIGJlaW5nIGxhdGUuDQoNClRoYW5rIHlvdSENCg0K
PiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHNlY3Jl
dG1lbV9tZW1jZ191bmNoYXJnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IG9yZGVyKQ0KPiArew0K
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMgPSAoMSA8PCBvcmRlcik7DQo+ICsgICAg
ICAgaW50IGk7DQo+ICsNCj4gKyAgICAgICBmb3IgKGkgPSAxOyBpIDwgbnJfcGFnZXM7IGkrKykg
ew0KPiArICAgICAgICAgICAgICAgc3RydWN0IHBhZ2UgKnAgPSBwYWdlICsgaTsNCj4gKw0KPiAr
ICAgICAgICAgICAgICAgcC0+bWVtY2dfZGF0YSA9IDA7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsg
ICAgICAgbWVtY2dfa21lbV91bmNoYXJnZV9wYWdlKHBhZ2UsIFBNRF9QQUdFX09SREVSKTsNCj4g
K30NCj4gKw0KPiAgc3RhdGljIGludCBzZWNyZXRtZW1fcG9vbF9pbmNyZWFzZShzdHJ1Y3Qgc2Vj
cmV0bWVtX2N0eCAqY3R4LCBnZnBfdCBnZnApDQo+ICB7DQo+ICAgICAgICAgdW5zaWduZWQgbG9u
ZyBucl9wYWdlcyA9ICgxIDw8IFBNRF9QQUdFX09SREVSKTsNCj4gQEAgLTYxLDEwICs5NCwxNCBA
QCBzdGF0aWMgaW50IHNlY3JldG1lbV9wb29sX2luY3JlYXNlKHN0cnVjdCBzZWNyZXRtZW1fY3R4
ICpjdHgsIGdmcF90IGdmcCkNCj4gICAgICAgICBpZiAoIXBhZ2UpDQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCj4NCj4gLSAgICAgICBlcnIgPSBzZXRfZGlyZWN0X21hcF9pbnZh
bGlkX25vZmx1c2gocGFnZSwgbnJfcGFnZXMpOw0KPiArICAgICAgIGVyciA9IHNlY3JldG1lbV9t
ZW1jZ19jaGFyZ2UocGFnZSwgZ2ZwLCBQTURfUEFHRV9PUkRFUik7DQo+ICAgICAgICAgaWYgKGVy
cikNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2NtYV9yZWxlYXNlOw0KPg0KPiArICAgICAg
IGVyciA9IHNldF9kaXJlY3RfbWFwX2ludmFsaWRfbm9mbHVzaChwYWdlLCBucl9wYWdlcyk7DQo+
ICsgICAgICAgaWYgKGVycikNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX21lbWNnX3VuY2hh
cmdlOw0KPiArDQo+ICAgICAgICAgYWRkciA9ICh1bnNpZ25lZCBsb25nKXBhZ2VfYWRkcmVzcyhw
YWdlKTsNCj4gICAgICAgICBlcnIgPSBnZW5fcG9vbF9hZGQocG9vbCwgYWRkciwgUE1EX1NJWkUs
IE5VTUFfTk9fTk9ERSk7DQo+ICAgICAgICAgaWYgKGVycikNCj4gQEAgLTgxLDYgKzExOCw4IEBA
IHN0YXRpYyBpbnQgc2VjcmV0bWVtX3Bvb2xfaW5jcmVhc2Uoc3RydWN0IHNlY3JldG1lbV9jdHgg
KmN0eCwgZ2ZwX3QgZ2ZwKQ0KPiAgICAgICAgICAqIHdvbid0IGZhaWwNCj4gICAgICAgICAgKi8N
Cj4gICAgICAgICBzZXRfZGlyZWN0X21hcF9kZWZhdWx0X25vZmx1c2gocGFnZSwgbnJfcGFnZXMp
Ow0KPiArZXJyX21lbWNnX3VuY2hhcmdlOg0KPiArICAgICAgIHNlY3JldG1lbV9tZW1jZ191bmNo
YXJnZShwYWdlLCBQTURfUEFHRV9PUkRFUik7DQo+ICBlcnJfY21hX3JlbGVhc2U6DQo+ICAgICAg
ICAgY21hX3JlbGVhc2Uoc2VjcmV0bWVtX2NtYSwgcGFnZSwgbnJfcGFnZXMpOw0KPiAgICAgICAg
IHJldHVybiBlcnI7DQo+IEBAIC0zMTAsNiArMzQ5LDcgQEAgc3RhdGljIHZvaWQgc2VjcmV0bWVt
X2NsZWFudXBfY2h1bmsoc3RydWN0IGdlbl9wb29sICpwb29sLA0KPiAgICAgICAgIGludCBpOw0K
Pg0KPiAgICAgICAgIHNldF9kaXJlY3RfbWFwX2RlZmF1bHRfbm9mbHVzaChwYWdlLCBucl9wYWdl
cyk7DQo+ICsgICAgICAgc2VjcmV0bWVtX21lbWNnX3VuY2hhcmdlKHBhZ2UsIFBNRF9QQUdFX09S
REVSKTsNCj4NCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykNCj4gICAg
ICAgICAgICAgICAgIGNsZWFyX2hpZ2hwYWdlKHBhZ2UgKyBpKTsNCj4gLS0NCj4gMi4yOC4wDQo+
DQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
