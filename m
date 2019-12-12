Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94211D780
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 20:55:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88AA410113677;
	Thu, 12 Dec 2019 11:58:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4D91710113676
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:58:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b19so1409820pfo.2
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLCOxEuE47kolkwbHmkJmj7IG2EMMJZxExvD4wbLras=;
        b=N5Jbii9lOcX8HpdB4OvQNSGLnmOeT6+/+rlmV3f2zodsX95/IUChnGHQM5ZR9+7otx
         xCv/jmEbc6D93pFCnCpXU2SDw93JebTnMOgIuJ8ohn6QjYcL69Xjt3FqJzI3CVS4nRQH
         dADcWC3VtCEZek6JWFoIvthRNIVETi0gLpefyHByeARkuqPnRxYLMzsYiTzOzVg31tfq
         96TlL/xxXNaX2fQL+xu6IO8Y8p/8MMwUJ/7l+NfyTuhTMzsDds+ZEGokpkgCOXhaXCFH
         DVWOptf/VRWwif3t/hocRA2xwwTLgxuIoHH49eObl34a++JppwPR8IgcvfeN0I67KWsr
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLCOxEuE47kolkwbHmkJmj7IG2EMMJZxExvD4wbLras=;
        b=HqRPF4xIihQ3PD9Y1B4jUagzgvFrPxyCWNPhxRcmkVUn3vG1kL3ZmwUW6bZhQKHf5r
         HUOtd+DwD+VbiWuvgn7CxaMO+QOew72+MokZmcuxlf5asZxSfEz6x486UTOkfzgFBurl
         XByzHpfQSPnv8qXZPyFF6aKJ/pp/8sk/rSjhUNzbn/TLpxCbEaQ+H8v0G25jZW0COqde
         MOq/Lf0xeNZZ//gTP1v2iwez7f3G22ZgBLtlyGUI9wZmTA7wkEdozHellV7NLG8VE72V
         aTbrhyZGDH7X/WaLbLwqsX/7hfiu5Iivzy4A9UiwcA/sXPmnCcL3PnumCMfb1Fzgr1Kg
         MOaw==
X-Gm-Message-State: APjAAAV4Q5LaRRggbylh3IfTnOicklx4eeyt0JVbd+qxE+x4Xt07xxWx
	TCVsWvhcYmV9G8ZK9b8SEGpeeQ==
X-Google-Smtp-Source: APXvYqzP+jxLfixRO0D1nTZH+cRkJXpZ998x7ZGYoS+/0WJqNhlcS/ivhuQFxS8xf2CuDrwiSQmJSw==
X-Received: by 2002:a65:640e:: with SMTP id a14mr11505680pgv.402.1576180507093;
        Thu, 12 Dec 2019 11:55:07 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g10sm7549833pgh.35.2019.12.12.11.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:55:06 -0800 (PST)
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To: Liran Alon <liran.alon@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
Date: Thu, 12 Dec 2019 14:55:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
Content-Language: en-US
Message-ID-Hash: FVE54F2NBMXPJGMZCHU4FGNMCRKAMHM4
X-Message-ID-Hash: FVE54F2NBMXPJGMZCHU4FGNMCRKAMHM4
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FVE54F2NBMXPJGMZCHU4FGNMCRKAMHM4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgLQ0KDQpPbiAxMi8xMi8xOSAxOjQ5IFBNLCBMaXJhbiBBbG9uIHdyb3RlOg0KPiANCj4gDQo+
PiBPbiAxMiBEZWMgMjAxOSwgYXQgMjA6NDcsIExpcmFuIEFsb24gPGxpcmFuLmFsb25Ab3JhY2xl
LmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+Pj4gT24gMTIgRGVjIDIwMTksIGF0IDIwOjIyLCBC
YXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4+DQo+Pj4gVGhpcyBjaGFu
Z2UgYWxsb3dzIEtWTSB0byBtYXAgREFYLWJhY2tlZCBmaWxlcyBtYWRlIG9mIGh1Z2UgcGFnZXMg
d2l0aA0KPj4+IGh1Z2UgbWFwcGluZ3MgaW4gdGhlIEVQVC9URFAuDQo+Pg0KPj4gVGhpcyBjaGFu
Z2UgaXNu4oCZdCBvbmx5IHJlbGV2YW50IGZvciBURFAuIEl0IGFsc28gYWZmZWN0cyB3aGVuIEtW
TSB1c2Ugc2hhZG93LXBhZ2luZy4NCj4+IFNlZSBob3cgRk5BTUUocGFnZV9mYXVsdCkoKSBjYWxs
cyB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKS4NCg0KQ29vbCwgSSdsbCBkcm9wIHJlZmVy
ZW5jZXMgdG8gdGhlIEVQVC9URFAgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCj4+PiBEQVgg
cGFnZXMgYXJlIG5vdCBQYWdlVHJhbnNDb21wb3VuZC4gIFRoZSBleGlzdGluZyBjaGVjayBpcyB0
cnlpbmcgdG8NCj4+PiBkZXRlcm1pbmUgaWYgdGhlIG1hcHBpbmcgZm9yIHRoZSBwZm4gaXMgYSBo
dWdlIG1hcHBpbmcgb3Igbm90Lg0KPj4NCj4+IEkgd291bGQgcmVwaHJhc2Ug4oCcVGhlIGV4aXN0
aW5nIGNoZWNrIGlzIHRyeWluZyB0byBkZXRlcm1pbmUgaWYgdGhlIHBmbg0KPj4gaXMgbWFwcGVk
IGFzIHBhcnQgb2YgYSB0cmFuc3BhcmVudCBodWdlLXBhZ2XigJ0uDQoNCkNhbiBkby4NCg0KPj4N
Cj4+PiBGb3INCj4+PiBub24tREFYIG1hcHMsIGUuZy4gaHVnZXRsYmZzLCB0aGF0IG1lYW5zIGNo
ZWNraW5nIFBhZ2VUcmFuc0NvbXBvdW5kLg0KPj4NCj4+IFRoaXMgaXMgbm90IHJlbGF0ZWQgdG8g
aHVnZXRsYmZzIGJ1dCByYXRoZXIgVEhQLg0KDQpJIHRob3VnaHQgdGhhdCBQYWdlVHJhbnNDb21w
b3VuZCBhbHNvIHJldHVybmVkIHRydWUgZm9yIGh1Z2V0bGJmcyAoYmFzZWQgDQpvZmYgb2YgY29t
bWVudHMgaW4gcGFnZS1mbGFncy5oKS4gIFRob3VnaCBJIGRvIHNlZSB0aGUgY29tbWVudCBhYm91
dCB0aGUgDQonbGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTCcgY2hlY2sgZXhjbHVkaW5nIGh1
Z2V0bGJmcyBwYWdlcy4NCg0KQW55d2F5LCBJJ2xsIHJlbW92ZSB0aGUgImUuZy4gaHVnZXRsYmZz
IiBmcm9tIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KPj4NCj4+PiBGb3IgREFYLCB3ZSBjYW4gY2hl
Y2sgdGhlIHBhZ2UgdGFibGUgaXRzZWxmLg0KPj4+DQo+Pj4gTm90ZSB0aGF0IEtWTSBhbHJlYWR5
IGZhdWx0ZWQgaW4gdGhlIHBhZ2UgKG9yIGh1Z2UgcGFnZSkgaW4gdGhlIGhvc3Qncw0KPj4+IHBh
Z2UgdGFibGUsIGFuZCB3ZSBob2xkIHRoZSBLVk0gbW11IHNwaW5sb2NrLiAgV2UgZ3JhYmJlZCB0
aGF0IGxvY2sgaW4NCj4+PiBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kLCBi
ZWZvcmUgY2hlY2tpbmcgdGhlIG1tdSBzZXEuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBCYXJy
ZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+DQo+Pg0KPj4gSSBkb27igJl0IHRoaW5rIHRoZSBy
aWdodCBwbGFjZSB0byBjaGFuZ2UgZm9yIHRoaXMgZnVuY3Rpb25hbGl0eSBpcyB0cmFuc3BhcmVu
dF9odWdlcGFnZV9hZGp1c3QoKQ0KPj4gd2hpY2ggaXMgbWVhbnQgdG8gaGFuZGxlIFBGTnMgdGhh
dCBhcmUgbWFwcGVkIGFzIHBhcnQgb2YgYSB0cmFuc3BhcmVudCBodWdlLXBhZ2UuDQo+Pg0KPj4g
Rm9yIGV4YW1wbGUsIHRoaXMgd291bGQgcHJldmVudCBtYXBwaW5nIERBWC1iYWNrZWQgZmlsZSBw
YWdlIGFzIDFHQi4NCj4+IEFzIHRyYW5zcGFyZW50X2h1Z2VwYWdlX2FkanVzdCgpIG9ubHkgaGFu
ZGxlcyB0aGUgY2FzZSAobGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTCkuDQo+Pg0KPj4gQXMg
eW91IGFyZSBwYXJzaW5nIHRoZSBwYWdlLXRhYmxlcyB0byBkaXNjb3ZlciB0aGUgcGFnZS1zaXpl
IHRoZSBQRk4gaXMgbWFwcGVkIGluLA0KPj4gSSB0aGluayB5b3Ugc2hvdWxkIGluc3RlYWQgbW9k
aWZ5IGt2bV9ob3N0X3BhZ2Vfc2l6ZSgpIHRvIHBhcnNlIHBhZ2UtdGFibGVzIGluc3RlYWQNCj4+
IG9mIHJlbHkgb24gdm1hX2tlcm5lbF9wYWdlc2l6ZSgpIChXaGljaCByZWxpZXMgb24gdm1hLT52
bV9vcHMtPnBhZ2VzaXplKCkpIGluIGNhc2UNCj4+IG9mIGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4N
Cj4+IFRoZSBtYWluIGNvbXBsaWNhdGlvbiB0aG91Z2ggb2YgZG9pbmcgdGhpcyBpcyB0aGF0IGF0
IHRoaXMgcG9pbnQgeW91IGRvbuKAmXQgeWV0IGhhdmUgdGhlIFBGTg0KPj4gdGhhdCBpcyByZXRy
aWV2ZWQgYnkgdHJ5X2FzeW5jX3BmKCkuIFNvIG1heWJlIHlvdSBzaG91bGQgY29uc2lkZXIgbW9k
aWZ5aW5nIHRoZSBvcmRlciBvZiBjYWxscw0KPj4gaW4gdGRwX3BhZ2VfZmF1bHQoKSAmIEZOQU1F
KHBhZ2VfZmF1bHQpKCkuDQo+Pg0KPj4gLUxpcmFuDQo+IA0KPiBPciBhbHRlcm5hdGl2ZWx5IHdo
ZW4gdGhpbmtpbmcgYWJvdXQgaXQgbW9yZSwgbWF5YmUganVzdCByZW5hbWUgdHJhbnNwYXJlbnRf
aHVnZXBhZ2VfYWRqdXN0KCkNCj4gdG8gbm90IGJlIHNwZWNpZmljIHRvIFRIUCBhbmQgYmV0dGVy
IGhhbmRsZSB0aGUgY2FzZSBvZiBwYXJzaW5nIHBhZ2UtdGFibGVzIGNoYW5naW5nIG1hcHBpbmct
bGV2ZWwgdG8gMUdCLg0KPiBUaGF0IGlzIHByb2JhYmx5IGVhc2llciBhbmQgbW9yZSBlbGVnYW50
Lg0KDQpJIGNhbiByZW5hbWUgaXQgdG8gaHVnZXBhZ2VfYWRqdXN0KCksIHNpbmNlIGl0J3Mgbm90
IGp1c3QgVEhQIGFueW1vcmUuDQoNCkkgd2FzIGEgbGl0dGxlIGhlc2l0YW50IHRvIGNoYW5nZSB0
aGUgdGhpcyB0byBoYW5kbGUgMSBHQiBwYWdlcyB3aXRoIA0KdGhpcyBwYXRjaHNldCBhdCBmaXJz
dC4gIEkgZGlkbid0IHdhbnQgdG8gYnJlYWsgdGhlIG5vbi1EQVggY2FzZSBzdHVmZiANCmJ5IGRv
aW5nIHNvLg0KDQpTcGVjaWZpY2FsbHksIGNhbiBhIFRIUCBwYWdlIGJlIDEgR0IsIGFuZCBpZiBz
bywgaG93IGNhbiB5b3UgdGVsbD8gIElmIA0KeW91IGNhbid0IHRlbGwgZWFzaWx5LCBJIGNvdWxk
IHdhbGsgdGhlIHBhZ2UgdGFibGUgZm9yIGFsbCBjYXNlcywgDQppbnN0ZWFkIG9mIGp1c3Qgem9u
ZV9kZXZpY2UoKS4NCg0KSSdkIGFsc28gaGF2ZSB0byBkcm9wIHRoZSAibGV2ZWwgPT0gUFRfUEFH
RV9UQUJMRV9MRVZFTCIgY2hlY2ssIEkgdGhpbmssIA0Kd2hpY2ggd291bGQgb3BlbiB0aGlzIHVw
IHRvIGh1Z2V0bGJmcyBwYWdlcyAoYmFzZWQgb24gdGhlIGNvbW1lbnRzKS4gIElzIA0KdGhlcmUg
YW55IHJlYXNvbiB3aHkgdGhhdCB3b3VsZCBiZSBhIGJhZCBpZGVhPw0KDQpUaGFua3MsDQoNCkJh
cnJldA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
