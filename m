Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92911E55F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 15:13:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DFD4010113684;
	Fri, 13 Dec 2019 06:16:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE5541011332C
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 06:16:31 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id m188so1785960qkc.4
        for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nid8tA47CgGN/j7YlqJfGqUykgFGi6RHG/gnONQyj4E=;
        b=iiL3UdjaR/ciA0kSMNs852p8OTlOiquuE5fH159L/f/kyYZSKGWMWVam+pUVGCkXzn
         9bgt3SEbd3pKnEhCeny9C42+mC0KXfiMLBQgpimffHI86crwzaVM/11h7Y8coEKA38o+
         tCVCdPV56qNiZgx3KgERpcRrNrVWUEs+0alaL5KGOlujfPecyMF86opv0mn3yFtlMhi/
         HSFudy4nXLFhq55ZzOCCgbDw0syt6JyzB7F1//hQ+zzHl5IqhR2XQhaFKSX6W7QnskC+
         6wTsaWtttmI+TDa2Sz4IrzVt+oKSBMj5Bnc1BiFbug2PEg9RfDO5OiVAlqxNQb7ozfcK
         /Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nid8tA47CgGN/j7YlqJfGqUykgFGi6RHG/gnONQyj4E=;
        b=AqiQPbdaARY2/+zTlEgBWBbxH1TPY4XdFe8CxrwxMU1BotOus+vSfLskl1v/H/b/nt
         UOTEcHZVxW8pdQNHK5lAEEttRPQR4MV9W4TNh2gVt8OBtYdiuNiNhntmVeQslXVu37ie
         qF7moG2v/ttrEorihUR3LPZYiEUWRSD2igFtXsWzq22gTWU8osAK02ONz9SCoPwAGZW0
         mIYHyO80SPged+m1ePV4C8ngX86q6AYRcwYnWs5c5VpzrN22/5w6gl/xe6bO+FCr6Bnp
         RM4R0sz9KPCZxxsxF08jKP4eySY0CSG6ex0R9p/IrNpQhunUKH4jXrN62T4h6qsnyFR3
         HZgg==
X-Gm-Message-State: APjAAAUTdefW7G+VJ6bBG3wcBRTU/Q8/iE8JjshSuJ58KKxm9RUZTZZ9
	g6Bcg+7mcUJ9ut/Mh42mlQWeIQ==
X-Google-Smtp-Source: APXvYqym2ajF5omuu9eNtqjRTVEFjAXQV+T4/+DYjZkhvWoajaXY+wFuOq6d8uOBMk6PvGM6fJu4eg==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr14203983qki.5.1576246387524;
        Fri, 13 Dec 2019 06:13:07 -0800 (PST)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id z28sm3463658qtz.69.2019.12.13.06.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 06:13:06 -0800 (PST)
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To: Liran Alon <liran.alon@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <90a9af31-304c-e8d5-b17c-0ddb4c98fddb@google.com>
Date: Fri, 13 Dec 2019 09:13:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
Content-Language: en-GB
Message-ID-Hash: 2FPJPWHGAPM7XYP77ENDPNP34HHIXYLN
X-Message-ID-Hash: 2FPJPWHGAPM7XYP77ENDPNP34HHIXYLN
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2FPJPWHGAPM7XYP77ENDPNP34HHIXYLN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTIvMTIvMTkgODowNyBQTSwgTGlyYW4gQWxvbiB3cm90ZToNCj4+IEkgd2FzIGEgbGl0dGxl
IGhlc2l0YW50IHRvIGNoYW5nZSB0aGUgdGhpcyB0byBoYW5kbGUgMSBHQiBwYWdlcyB3aXRoIHRo
aXMgcGF0Y2hzZXQgYXQgZmlyc3QuICBJIGRpZG4ndCB3YW50IHRvIGJyZWFrIHRoZSBub24tREFY
IGNhc2Ugc3R1ZmYgYnkgZG9pbmcgc28uDQo+IA0KPiBXaHkgd291bGQgaXQgYWZmZWN0IG5vbi1E
QVggY2FzZT8NCj4gWW91ciBwYXRjaCBzaG91bGQganVzdCBtYWtlIGh1Z2VwYWdlX2FkanVzdCgp
IHRvIHBhcnNlIHBhZ2UtdGFibGVzIG9ubHkgaW4gY2FzZSBpc196b25lX2RldmljZV9wYWdlKCku
IE90aGVyd2lzZSwgcGFnZSB0YWJsZXMgc2hvdWxkbuKAmXQgYmUgcGFyc2VkLg0KPiBpLmUuIFRI
UCBtZXJnZWQgcGFnZXMgc2hvdWxkIHN0aWxsIGJlIGRldGVjdGVkIGJ5IFBhZ2VUcmFuc0NvbXBv
dW5kTWFwKCkuDQoNClRoYXQncyB3aGF0IEkgYWxyZWFkeSBkby4gIEJ1dCBpZiBJIHdhbnRlZCB0
byBtYWtlIHRoZSBodWdlcGFnZV9hZGp1c3QoKSANCmZ1bmN0aW9uIGFsc28gaGFuZGxlIHRoZSBj
aGFuZ2UgdG8gMSBHQiwgdGhlbiB0aGF0IGNvZGUgd291bGQgYXBwbHkgdG8gDQpUSFAgdG9vLiAg
SSBkaWRuJ3Qgd2FudCB0byBkbyB0aGF0IHdpdGhvdXQga25vd2luZyB0aGUgaW1wbGljYXRpb25z
IGZvciBUSFAuDQoNCj4+IFNwZWNpZmljYWxseSwgY2FuIGEgVEhQIHBhZ2UgYmUgMSBHQiwgYW5k
IGlmIHNvLCBob3cgY2FuIHlvdSB0ZWxsPyAgSWYgeW91IGNhbid0IHRlbGwgZWFzaWx5LCBJIGNv
dWxkIHdhbGsgdGhlIHBhZ2UgdGFibGUgZm9yIGFsbCBjYXNlcywgaW5zdGVhZCBvZiBqdXN0IHpv
bmVfZGV2aWNlKCkuDQo+IA0KPiBJIHByZWZlciB0byB3YWxrIHBhZ2UtdGFibGVzIG9ubHkgZm9y
IGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4NCg0KSXMgdGhlcmUgYW5vdGhlciB3YXkgdG8gdGVsbCBp
ZiBhIFRIUCBwYWdlIGlzIDEgR0I/ICBBbnl3YXksIHRoaXMgaXMgdGhlIA0Kc29ydCBvZiBzdHVm
ZiBJIGRpZG4ndCB3YW50IHRvIG1lc3MgYXJvdW5kIHdpdGguDQoNCmh1Z2VwYWdlX2FkanVzdCgp
IHNlZW1lZCBsaWtlIGEgcmVhc29uYWJsZSBwbGFjZSB0byBnZXQgYSBodWdlICgyTUIpIA0KcGFn
ZSB0YWJsZSBlbnRyeSBvdXQgb2YgYSBEQVggbWFwcGluZy4gIEkgZGlkbid0IHdhbnQgdG8gcHJv
bGlmZXJhdGUgDQphbm90aGVyIHNwZWNpYWwgY2FzZSBmb3IgdXBncmFkaW5nIHRvIGEgbGFyZ2Vy
IFBURSBzaXplIChpLmUuIGhvdyANCmh1Z2V0bGJmcyBhbmQgVEhQIGhhdmUgc2VwYXJhdGUgbWVj
aGFuaXNtcyksIHNvIEkgaG9wcGVkIG9uIHRvIHRoZSAiY2FuIA0Kd2UgZG8gYSAyTUIgbWFwcGlu
ZyBldmVuIHRob3VnaCBob3N0X21hcHBpbmdfbGV2ZWwoKSBkaWRuJ3Qgc2F5IHNvIiBjYXNlIA0K
LSB3aGljaCBpcyBteSBpbnRlcnByZXRhdGlvbiBvZiB3aGF0IGh1Z2VfYWRqdXN0KCkgaXMgZm9y
Lg0KDQpCYXJyZXQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
