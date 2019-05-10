Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969E1A4EE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 23:53:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7DA42126CF9B;
	Fri, 10 May 2019 14:53:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D324A21260A4C
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:53:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v80so3899294pfa.3
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=tFQucziH/lNpMmCcgKVO4AJ9nWDnZZYR8eghVDzNA1E=;
 b=lu0yqBfjEUNykl0U3da7rDRSpylPzpL2esQSx+UgL+mdERRPAU4+xSvga6nSALkV1C
 Vvc4NdibXWAAVaSbYf6uxE1gsLvFZrw+b0/PAjtbQdtHbfBRJoGx47qNrchXGSG7p9hp
 St8BSU/crFi2UHaW3O9piIxNoA33Gt+dJlsghtUYECOaEjpTQ9xSEhrLZ0dM2esT8S9K
 66dGNW6vK0dCcb9R1rXyTOjsLQymtPuYzRol6D7JEYW2UAVIX4Z7As1Q+zA5Va7ce431
 3xZByQCYxXFTpgGMOLBuLRbBwhkwzRkd2YZC+KgYIjVAYPxdOcw+fHI7wbek34gTZGXR
 JWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFQucziH/lNpMmCcgKVO4AJ9nWDnZZYR8eghVDzNA1E=;
 b=gg/oeAP0uZasDdEQ3jqm7hEcMiKO7CHtl9X8EXwBaddmDC12ai2OiZTpo54kTLTvPl
 dcFplgp+PYl3NcS4eCWgQPxG9G6HHxGPWFF1fkyyVH30CZTfWH+Id0Fy52mq/+yS1on6
 9RmEJitxT2D87hoxgeowBcAVXgvH5NkrKhwa8k5GEQAY8LlsJPJ35D2jtuz5JdTAYdoj
 iIF5qN5WDvCQPQzMEwmwOZSaHOCDLq/GjI+juNAumkVRJKagIcs9vaghvIEQY+Ehqasj
 1AzOG9GDK6S4vO+kq1uXzgRP0AjBQG9n8/Zukrr2a4fYSHSMEXiIC0MLJaaLMOFLenUp
 6b+g==
X-Gm-Message-State: APjAAAUJ0JX6PwPqIud/3Dt1ZGEuA8yLX7hU2Y1a8Wh3gz0wb/3vc6uU
 YPch0q/yyeaYyQ5Yt8DWjSo=
X-Google-Smtp-Source: APXvYqwEz5hPUpoWTUMGr3bgCwxUY3Qej1r0J2tlMznKnGbw+2kNjU9uUppsop4MP14VK4tl3E1lkw==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr9753966pfn.216.1557525183210; 
 Fri, 10 May 2019 14:53:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v66sm259259pfa.38.2019.05.10.14.53.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 14:53:02 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Logan Gunthorpe <logang@deltatee.com>, Theodore Ts'o <tytso@mit.edu>,
 Tim.Bird@sony.com, knut.omang@oracle.com, gregkh@linuxfoundation.org,
 brendanhiggins@google.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com, dan.j.williams@intel.com,
 daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
 khilman@baylibre.com, mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
 rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
Date: Fri, 10 May 2019 14:52:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
Content-Language: en-US
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gNS85LzE5IDM6MjAgUE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiAKPiAKPiBPbiAyMDE5
LTA1LTA5IDM6NDIgcC5tLiwgVGhlb2RvcmUgVHMnbyB3cm90ZToKPj4gT24gVGh1LCBNYXkgMDks
IDIwMTkgYXQgMTE6MTI6MTJBTSAtMDcwMCwgRnJhbmsgUm93YW5kIHdyb3RlOgo+Pj4KPj4+IMKg
wqDCoCAiTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSBpbnRlbnQgb2YgS1VuaXQgaXMgdG8g
YXZvaWQgYm9vdGluZyBhIGtlcm5lbCBvbgo+Pj4gwqDCoMKgIHJlYWwgaGFyZHdhcmUgb3IgaW4g
YSB2aXJ0dWFsIG1hY2hpbmUuwqAgVGhhdCBzZWVtcyB0byBiZSBhIG1hdHRlciBvZiBzZW1hbnRp
Y3MKPj4+IMKgwqDCoCB0byBtZSBiZWNhdXNlIGlzbid0IGludm9raW5nIGEgVU1MIExpbnV4IGp1
c3QgcnVubmluZyB0aGUgTGludXgga2VybmVsIGluCj4+PiDCoMKgwqAgYSBkaWZmZXJlbnQgZm9y
bSBvZiB2aXJ0dWFsaXphdGlvbj8KPj4+Cj4+PiDCoMKgwqAgU28gSSBkbyBub3QgdW5kZXJzdGFu
ZCB3aHkgS1VuaXQgaXMgYW4gaW1wcm92ZW1lbnQgb3ZlciBrc2VsZnRlc3QuCj4+Pgo+Pj4gwqDC
oCAgLi4uCj4+PiAKPj4+IFdoYXQgYW0gSSBtaXNzaW5nPyIKPj4gCj4+IE9uZSBtYWpvciBkaWZm
ZXJlbmNlOiBrc2VsZnRlc3QgcmVxdWlyZXMgYSB1c2Vyc3BhY2UgZW52aXJvbm1lbnQ7Cj4+IGl0
IHN0YXJ0cyBzeXN0ZW1kLCByZXF1aXJlcyBhIHJvb3QgZmlsZSBzeXN0ZW0gZnJvbSB3aGljaCB5
b3UgY2FuCj4+IGxvYWQgbW9kdWxlcywgZXRjLiAgS3VuaXQgZG9lc24ndCByZXF1aXJlIGEgcm9v
dCBmaWxlIHN5c3RlbTsKPj4gZG9lc24ndCByZXF1aXJlIHRoYXQgeW91IHN0YXJ0IHN5c3RlbWQ7
IGRvZXNuJ3QgYWxsb3cgeW91IHRvIHJ1bgo+PiBhcmJpdHJhcnkgcGVybCwgcHl0aG9uLCBiYXNo
LCBldGMuIHNjcmlwdHMuICBBcyBzdWNoLCBpdCdzIG11Y2gKPj4gbGlnaHRlciB3ZWlnaHQgdGhh
biBrc2VsZnRlc3QsIGFuZCB3aWxsIGhhdmUgbXVjaCBsZXNzIG92ZXJoZWFkCj4+IGJlZm9yZSB5
b3UgY2FuIHN0YXJ0IHJ1bm5pbmcgdGVzdHMuICBTbyBpdCdzIG5vdCByZWFsbHkgdGhlIHNhbWUK
Pj4ga2luZCBvZiB2aXJ0dWFsaXphdGlvbi4KCkknbSBiYWNrIHRvIHJlcGx5IHRvIHRoaXMgc3Vi
dGhyZWFkLCBhZnRlciBhIGRlbGF5LCBhcyBwcm9taXNlZC4KCgo+IEkgbGFyZ2VseSBhZ3JlZSB3
aXRoIGV2ZXJ5dGhpbmcgVGVkIGhhcyBzYWlkIGluIHRoaXMgdGhyZWFkLCBidXQgSQo+IHdvbmRl
ciBpZiB3ZSBhcmUgY29uZmxhdGluZyB0d28gZGlmZmVyZW50IGlkZWFzIHRoYXQgaXMgY2F1c2lu
ZyBhbgo+IGltcGFzc2UuIEZyb20gd2hhdCBJIHNlZSwgS3VuaXQgYWN0dWFsbHkgcHJvdmlkZXMg
dHdvIGRpZmZlcmVudAo+IHRoaW5nczoKCj4gMSkgQW4gZXhlY3V0aW9uIGVudmlyb25tZW50IHRo
YXQgY2FuIGJlIHJ1biB2ZXJ5IHF1aWNrbHkgaW4gdXNlcnNwYWNlCj4gb24gdGVzdHMgaW4gdGhl
IGtlcm5lbCBzb3VyY2UuIFRoaXMgc3BlZWRzIHVwIHRoZSB0ZXN0cyBhbmQgZ2l2ZXMgYQo+IGxv
dCBvZiBiZW5lZml0IHRvIGRldmVsb3BlcnMgdXNpbmcgdGhvc2UgdGVzdHMgYmVjYXVzZSB0aGV5
IGNhbiBnZXQKPiBmZWVkYmFjayBvbiB0aGVpciBjb2RlIGNoYW5nZXMgYSAqbG90KiBxdWlja2Vy
LgoKa3NlbGZ0ZXN0IGluLWtlcm5lbCB0ZXN0cyBwcm92aWRlIGV4YWN0bHkgdGhlIHNhbWUgd2hl
biB0aGUgdGVzdHMgYXJlCmNvbmZpZ3VyZWQgYXMgImJ1aWx0LWluIiBjb2RlIGluc3RlYWQgb2Yg
YXMgbW9kdWxlcy4KCgo+IDIpIEEgZnJhbWV3b3JrIHRvIHdyaXRlIHVuaXQgdGVzdHMgdGhhdCBw
cm92aWRlcyBhIGxvdCBvZiB0aGUgc2FtZQo+IGZhY2lsaXRpZXMgYXMgb3RoZXIgY29tbW9uIHVu
aXQgdGVzdGluZyBmcmFtZXdvcmtzIGZyb20gdXNlcnNwYWNlCj4gKGllLiBhIHJ1bm5lciB0aGF0
IHJ1bnMgYSBsaXN0IG9mIHRlc3RzIGFuZCBhIGJ1bmNoIG9mIGhlbHBlcnMgc3VjaAo+IGFzIEtV
TklUX0VYUEVDVF8qIHRvIHNpbXBsaWZ5IHRlc3QgcGFzc2VzIGFuZCBmYWlsdXJlcykuCgo+IFRo
ZSBmaXJzdCBpdGVtIGZyb20gS3VuaXQgaXMgbm92ZWwgYW5kIEkgc2VlIGFic29sdXRlbHkgbm8g
b3ZlcmxhcAo+IHdpdGggYW55dGhpbmcga3NlbGZ0ZXN0IGRvZXMuIEl0J3MgYWxzbyB0aGUgdmFs
dWFibGUgdGhpbmcgSSdkIGxpa2UKPiB0byBzZWUgbWVyZ2VkIGFuZCBncm93LgoKVGhlIGZpcnN0
IGl0ZW0gZXhpc3RzIGluIGtzZWxmdGVzdC4KCgo+IFRoZSBzZWNvbmQgaXRlbSwgYXJndWFibHks
IGRvZXMgaGF2ZSBzaWduaWZpY2FudCBvdmVybGFwIHdpdGgKPiBrc2VsZnRlc3QuIFdoZXRoZXIg
eW91IGFyZSBydW5uaW5nIHNob3J0IHRlc3RzIGluIGEgbGlnaHQgd2VpZ2h0IFVNTAo+IGVudmly
b25tZW50IG9yIGhpZ2hlciBsZXZlbCB0ZXN0cyBpbiBhbiBoZWF2aWVyIFZNIHRoZSB0d28gY291
bGQgYmUKPiB1c2luZyB0aGUgc2FtZSBmcmFtZXdvcmsgZm9yIHdyaXRpbmcgb3IgZGVmaW5pbmcg
aW4ta2VybmVsIHRlc3RzLiBJdAo+ICptYXkqIGFsc28gYmUgdmFsdWFibGUgZm9yIHNvbWUgcGVv
cGxlIHRvIGJlIGFibGUgdG8gcnVuIGFsbCB0aGUgVU1MCj4gdGVzdHMgaW4gdGhlIGhlYXZ5IFZN
IGVudmlyb25tZW50IGFsb25nIHNpZGUgb3RoZXIgaGlnaGVyIGxldmVsCj4gdGVzdHMuCj4gCj4g
TG9va2luZyBhdCB0aGUgc2VsZnRlc3RzIHRyZWUgaW4gdGhlIHJlcG8sIHdlIGFscmVhZHkgaGF2
ZSBzaW1pbGFyCj4gaXRlbXMgdG8gd2hhdCBLdW5pdCBpcyBhZGRpbmcgYXMgSSBkZXNjcmliZWQg
aW4gcG9pbnQgKDIpIGFib3ZlLgo+IGtzZWxmdGVzdF9oYXJuZXNzLmggY29udGFpbnMgbWFjcm9z
IGxpa2UgRVhQRUNUXyogYW5kIEFTU0VSVF8qIHdpdGgKPiB2ZXJ5IHNpbWlsYXIgaW50ZW50aW9u
cyB0byB0aGUgbmV3IEtVTklUX0VYRUNQVF8qIGFuZCBLVU5JVF9BU1NFUlRfKgo+IG1hY3Jvcy4K
CkkgbWlnaHQgYmUgd3JvbmcgaGVyZSBiZWNhdXNlIEkgaGF2ZSBub3QgZHVnIGRlZXBseSBlbm91
Z2ggaW50byB0aGUKY29kZSEhISAgRG9lcyB0aGlzIGZyYW1ld29yayBhcHBseSB0byB0aGUgdXNl
cnNwYWNlIHRlc3RzLCB0aGUKaW4ta2VybmVsIHRlc3RzLCBvciBib3RoPyAgTXkgIm5vdCBoYXZp
bmcgZHVnIGVub3VnaCBHVUVTUyIgaXMgdGhhdAp0aGVzZSBhcmUgZm9yIHRoZSB1c2VyIHNwYWNl
IHRlc3RzIChhbHRob3VnaCBpZiBzbywgdGhleSBjb3VsZCBiZQpleHRlbmRlZCBmb3IgaW4ta2Vy
bmVsIHVzZSBhbHNvKS4KClNvIEkgdGhpbmsgdGhpcyBvbmUgbWF5YmUgZG9lcyBub3QgaGF2ZSBh
biBvdmVybGFwIGJldHdlZW4gS1VuaXQKYW5kIGtzZWxmdGVzdC4KCgo+IEhvd2V2ZXIsIHRoZSBu
dW1iZXIgb2YgdXNlcnMgb2YgdGhpcyBoYXJuZXNzIGFwcGVhcnMgdG8gYmUgcXVpdGUKPiBzbWFs
bC4gTW9zdCBvZiB0aGUgY29kZSBpbiB0aGUgc2VsZnRlc3RzIHRyZWUgc2VlbXMgdG8gYmUgYSBy
YW5kb20KPiBtaXNtYXNoIG9mIHNjcmlwdHMgYW5kIHVzZXJzcGFjZSBjb2RlIHNvIGl0J3Mgbm90
IGhhcmQgdG8gc2VlIGl0IGFzCj4gc29tZXRoaW5nIGNvbXBsZXRlbHkgZGlmZmVyZW50IGZyb20g
dGhlIG5ldyBLdW5pdDoKPiAkIGdpdCBncmVwIC0tZmlsZXMtd2l0aC1tYXRjaGVzIGtzZWxmdGVz
dF9oYXJuZXNzLmggKgo+IERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2tzZWxmdGVzdC5yc3QKPiBN
QUlOVEFJTkVSUwo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzLmgK
PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdGxzLmMKPiB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9ydGMvcnRjdGVzdC5jCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2VjY29tcC9NYWtl
ZmlsZQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9icGYuYwo+IHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3VldmVudC9NYWtlZmlsZQo+IHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3VldmVudC91ZXZlbnRfZmlsdGVyaW5nLmMKCgo+IFRodXMsIEkgY2FuIHBlcnNvbmFs
bHkgc2VlIGEgbG90IG9mIHZhbHVlIGluIGludGVncmF0aW5nIHRoZSBrdW5pdAo+IHRlc3QgZnJh
bWV3b3JrIHdpdGggdGhpcyBrc2VsZnRlc3QgaGFybmVzcy4gVGhlcmUncyBvbmx5IGEgc21hbGwK
PiBudW1iZXIgb2YgdXNlcnMgb2YgdGhlIGtzZWxmdGVzdCBoYXJuZXNzIHRvZGF5LCBzbyBvbmUg
d2F5IG9yIGFub3RoZXIKPiBpdCBzZWVtcyBsaWtlIGdldHRpbmcgdGhpcyBpbnRlZ3JhdGVkIGVh
cmx5IHdvdWxkIGJlIGEgZ29vZCBpZGVhLgo+IExldHRpbmcgS3VuaXQgYW5kIEtzZWxmdGVzdHMg
cHJvZ3Jlc3MgaW5kZXBlbmRlbnRseSBmb3IgYSBmZXcgeWVhcnMKPiB3aWxsIG9ubHkgbWFrZSB0
aGlzIHdvcnNlIGFuZCBtYXkgYmVjb21lIHNvbWV0aGluZyB3ZSBlbmQgdXAKPiByZWdyZXR0aW5n
LgoKWWVzLCB0aGlzIEkgYWdyZWUgd2l0aC4KCi1GcmFuawoKPiAKPiBMb2dhbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0CkxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udmRpbW0K
