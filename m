Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934A2DA934
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 09:34:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43844100EBBB2;
	Tue, 15 Dec 2020 00:34:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=jianchao.wan9@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E1BA100EBBAC
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 00:34:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq13so783562pjb.3
        for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 00:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mRZ1/cc4bz/v98TdHXnY03uIyoe+Q5t00boA88BxhZE=;
        b=RB20atfKmx1YELZ3F/4+sFLLUvNfqwxwNcErzCwCLSeKRcoyWrnfPhCNTLpcnueSxw
         pVHxnsfwWBvhtLwzO0Nu8+LoneRcULWeDyhFy3rEY7cPVT3xqjLuxclHeQtZxkUnib7F
         SGd4wVBIP6lhaXMKRFoDftPGOLn3xOE1zpZMnnVBhXDJS5qF4HpuLDzYpx0peuIH9y4v
         kX9D24UvVya6dTF1gbYsSfCrV6BcAcuDOPg2sdQyE5TKdQAZTwKZ/F8/IhzGIU69u3DB
         dQF3FvWoXnsMuuYwIHgQi9UUH+ejj4vDXN+guSejNQ+6dHwB8dUUtoHmVHNwwrkIsqxZ
         KfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRZ1/cc4bz/v98TdHXnY03uIyoe+Q5t00boA88BxhZE=;
        b=F4IyuafmP357ebPOIn/TD+5rlMx7e42kCS+00rnXMrzL0QBD6qJ/GS0CWuPsYM/bVJ
         U83HTGxb3DxaFSalw0Y9qC2wqFrFm2WTKqgu90znNyuLpy/Ba0WFYqSchQXdPQri6bIS
         ZOEYHmpzrLOFX08xUmqN6uMbOn6e6O9sQvM8otQJyzuAiyXje/KKaXnaSMmbTl7qekwk
         7XYEEpf6ZSoXnhyTP1dNlvQ0m+eybYhiaqOwGGBqX36jfg0A3duuxT5DYAHBl72j+MMZ
         EzFqKeMBkY5YFqnY6yOIUK5+aN+8r/p02u6HRkYXT9sICNXnvLqxB5KnzpsMOoH21Ux8
         546Q==
X-Gm-Message-State: AOAM533PIxrNixAE1JtRih4S+V7ve/Okt6a1nuEAkexqvLzQo1Isr0aQ
	PRX+zaVs3am3Mx1GdtOCSSNheZNJazc=
X-Google-Smtp-Source: ABdhPJzebP7TjoYRnMGQ4ETZoILTAQ6C+8l4v4HPyvGMYiZ8ts/OOXCMuvOHVhYT019/tZJ4XqeZrA==
X-Received: by 2002:a17:90a:be17:: with SMTP id a23mr28785988pjs.236.1608021252548;
        Tue, 15 Dec 2020 00:34:12 -0800 (PST)
Received: from jianchwadeMacBook-Pro.local ([156.236.120.138])
        by smtp.gmail.com with ESMTPSA id i130sm22358588pfe.94.2020.12.15.00.34.11
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 00:34:12 -0800 (PST)
Subject: Re: [HELP] mmap fsdax mode pmem to userland with writethrough
From: Wang Jianchao <jianchao.wan9@gmail.com>
To: linux-nvdimm@lists.01.org
References: <5a5139ba-6308-4ca4-dc0c-7da271c5c5dc@gmail.com>
Message-ID: <f1bd2025-bf12-f667-c115-da9c3ea9f3ea@gmail.com>
Date: Tue, 15 Dec 2020 16:34:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5a5139ba-6308-4ca4-dc0c-7da271c5c5dc@gmail.com>
Content-Language: en-US
Message-ID-Hash: BNYCBSERWILQDLQ2SQUWJFREZ7L4WQ5D
X-Message-ID-Hash: BNYCBSERWILQDLQ2SQUWJFREZ7L4WQ5D
X-MailFrom: jianchao.wan9@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BNYCBSERWILQDLQ2SQUWJFREZ7L4WQ5D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SXQgd2FzIGZpZ3VyZWQgb3V0IHRoYXQgdGhlIHRyYWNrX3Bmbl9pbnNlcnQgY2hhbmdlZCB0aGUg
cGdwcm90Lg0KSSB0cmllZCB0d28gd2F5cyB0byB3b3JrYXJvdW5kIGl0DQooMSkgY2hhbmdlIHRo
ZSBwdGUgaW4gdGhlIGZhdWx0IGNhbGxiYWNrIGRpcmVjdGx5DQooMikgYWRkIGEgaGVscGVyIGlu
dGVyZmFjZSBvZiBkZXZtX21lbXJlbWFwX3BhZ2VzIHRoYXQgaGFzIGEgcGdwcm90Lg0KDQpUaGUg
d3JpdGV0aHJvdWdoIG1tYXAgc2VlbXMgdG8gc3VjY2VzcyBidXQgdGhlIGZpbmFsIHBlcmZvcm1h
bmNlIGlzDQpyZWFsbHkgYmFkLCBqdXN0IDIwTS9zIHBlciB0aHJlYWQuLi4uDQoNCk9uIDIwMjAv
MTIvMTQgNjo0NCDkuIvljYgsIFdhbmcgSmlhbmNoYW8gd3JvdGU6DQo+IEhpIGxpc3QNCj4gDQo+
IFdlIGFyZSB0cnlpbmcgdG8gbW1hcCB0aGUgZmlsZSBpbiB4ZnMtZGF4IHRvIHVzZXJsYW5kIHdp
dGggd3JpdGV0aHJvdWdoIG1vZGUsDQo+IGhvcGUgdG8gYXZvaWQgYmFuZHdpZHRoIGFuZCBsYXRl
bmN5IGNhdXNlIGJ5IHdyaXRlLWFsbG9jYXRlIGluIHdyaXRlYmFjayBtb2RlDQo+IGFuZCB3ZSBj
YW4gc3RpbGwgdXNlIHRoZSBvcmlnaW5hbCB1c2VybGFuZCBhcHBsaWNhdGlvbiBjb2RlIHcvbyB1
c2luZyBOVHN0b3JlLg0KPiANCj4gV2UgYWRkIGZvbGxvd2luZyBjb2RlIGluIHRoZSBtbWFwIGNh
bGxiYWNrIG9mIHhmcywNCj4gDQo+IHZtYS0+dm1fcGFnZV9wcm90ID0gcGdwcm90X3dyaXRldGhy
b3VnaCh2bWEtPnZtX3BhZ2VfcHJvdCk7DQo+IA0KPiBCdXQgaXQgc2VlbXMgdG8gbm90IHdvcmsu
IFdoZW4gSSB1c2UgcGNtLW1lbW9yeSB0byBjaGVjayB0aGUgYmFuZHdpZHRoIG9mIFBNTSwNCj4g
UE1NIHJlYWQgQlcgaXMgc3RpbGwgdGhlcmUgd2hpY2ggaXMgbmVhcmx5IGVxdWFsIHdpdGggUE1N
IHdyaXRlLiBFdmVuIEkgdXNlDQo+IHBncHJvdF9ub25jYWNoZWQsIGl0IHN0aWxsIG5vdCB3b3Jr
Lg0KPiANCj4gV2hhdCBzaG91bGQgSSBkbyB0byBpbXBsZW1lbnQgdGhlIHdyaXRldGhyb3VnaCBt
YXBwaW5nID8NCj4gDQo+IFRoYW5rcyBhIG1pbGxpb24gZm9yIGFueSBoZWxwLg0KPiANCj4gSmlh
bmNoYW8NCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
