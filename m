Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACE333E8C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 14:36:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1894100EB334;
	Wed, 10 Mar 2021 05:36:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com; envelope-from=ngompa13@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4E45C100EB331
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 05:36:44 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x19so17895506ybe.0
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2aYptJ+Gov2C+oARQmlRLopxW2URRuwXw1AKwLGZv1E=;
        b=lpoFJtg+RfBaF3k+0slfbJr1UD9yvARkoMbBl9MWr5rmcJvOHNz8P65bPDF0DzSKLZ
         A3QopQpfSEcP9hG6NFxwAymzBtPvh9QtuREgkj9DQjN9L8S9GwxojaVH5XTEDnVF4bQA
         sMnKkKxuoVoJRr9q12QkvPO1QPeOriCBtg4BBD7uVIji+3DiHwzqJJj7m+b17VLR6Y0I
         q9ykpG9dwvTB05YeMwCb59uPHELbo+jaZKbPrWda81m5JAPQL+ZZ1OluKZ7IDbefl91g
         9ceIqeicNGysV//j//GKZJRSGU2l1tIS6W2s+tKKgHsfQeKrQgjbRQJws2xtrkEhX9Kt
         ZXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2aYptJ+Gov2C+oARQmlRLopxW2URRuwXw1AKwLGZv1E=;
        b=rLaPO10Z0ueGCYONPssJIr0SwAKOc36VyDShXk3Wy97JcqkBQ2+4M1Pw3aS3BRWvGw
         VPrbovzw1P4YwrpGoTRdmWM2m9q1zwbgDBtCTkKqyABeeFKlAo3xxYT6SLPputLYNp0q
         Gge2LfIPyZBrCMyN/5aqtFSvxXA7zOkMMQFrCbD57x84ldhvrA65S116GSLWC7P1OPw5
         75DRKxLYZmpEPkvTE/SaqEz8yr41BUpHRlZs4naW8zoE5RMjlF9VPgzPIe2Qdm55ISl0
         peVhX5/vNr1B4VDEThcg5ZRSdlQAjdB2P/wG8oh/awrbxV0ZoZ3lDWtLSUiPaOaQb8CI
         XWYg==
X-Gm-Message-State: AOAM531LZH1Vs90qg2Df4EJIz1hipSWaHEYfKg1/HsJ+CuSzlZCJjo+9
	t3i+Ecv7AHRCZhjpJlvsa34FQsQJ6QlEr7x852w=
X-Google-Smtp-Source: ABdhPJz1jxdINaxIIQwiE1/7TJj4kvjkB1loYv97hj60cdpiwpI1AFhO8/qRMCL4/0SP4ps/aG+kQlYilaoS6/0nAb8=
X-Received: by 2002:a25:d8f:: with SMTP id 137mr1981743ybn.47.1615383402310;
 Wed, 10 Mar 2021 05:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com> <20210310130227.GN3479805@casper.infradead.org>
In-Reply-To: <20210310130227.GN3479805@casper.infradead.org>
From: Neal Gompa <ngompa13@gmail.com>
Date: Wed, 10 Mar 2021 08:36:06 -0500
Message-ID: <CAEg-Je-F6ybPPV22-hq9=cuUCA7cw2xAA7Y-97tKhYUX1+fDwg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: QJTJNVTJCMIDQFITQGCG2N2WZ3N4N6KT
X-Message-ID-Hash: QJTJNVTJCMIDQFITQGCG2N2WZ3N4N6KT
X-MailFrom: ngompa13@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QJTJNVTJCMIDQFITQGCG2N2WZ3N4N6KT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgODowMiBBTSBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0IDA3OjMwOjQx
QU0gLTA1MDAsIE5lYWwgR29tcGEgd3JvdGU6DQo+ID4gRm9yZ2l2ZSBteSBpZ25vcmFuY2UsIGJ1
dCBpcyB0aGVyZSBhIHJlYXNvbiB3aHkgdGhpcyBpc24ndCB3aXJlZCB1cCB0bw0KPiA+IEJ0cmZz
IGF0IHRoZSBzYW1lIHRpbWU/IEl0IHNlZW1zIHdlaXJkIHRvIG1lIHRoYXQgYWRkaW5nIGEgZmVh
dHVyZQ0KPg0KPiBidHJmcyBkb2Vzbid0IHN1cHBvcnQgREFYLiAgb25seSBleHQyLCBleHQ0LCBY
RlMgYW5kIEZVU0UgaGF2ZSBEQVggc3VwcG9ydC4NCj4NCj4gSWYgeW91IHRoaW5rIGFib3V0IGl0
LCBidHJmcyBhbmQgREFYIGFyZSBkaWFtZXRyaWNhbGx5IG9wcG9zaXRlIHRoaW5ncy4NCj4gREFY
IGlzIGFib3V0IGdpdmluZyByYXcgYWNjZXNzIHRvIHRoZSBoYXJkd2FyZS4gIGJ0cmZzIGlzIGFi
b3V0IG9mZmVyaW5nDQo+IGV4dHJhIHZhbHVlIChSQUlELCBjaGVja3N1bXMsIC4uLiksIG5vbmUg
b2Ygd2hpY2ggY2FuIGJlIGRvbmUgaWYgdGhlDQo+IGZpbGVzeXN0ZW0gaXNuJ3QgaW4gdGhlIHJl
YWQvd3JpdGUgcGF0aC4NCj4NCj4gVGhhdCdzIHdoeSB0aGVyZSdzIG5vIERBWCBzdXBwb3J0IGlu
IGJ0cmZzLiAgSWYgeW91IHdhbnQgREFYLCB5b3UgaGF2ZQ0KPiB0byBnaXZlIHVwIGFsbCB0aGUg
ZmVhdHVyZXMgeW91IGxpa2UgaW4gYnRyZnMuICBTbyB5b3UgbWF5IGFzIHdlbGwgdXNlDQo+IGEg
ZGlmZmVyZW50IGZpbGVzeXN0ZW0uDQoNClNvIGRvZXMgdGhhdCBtZWFuIHRoYXQgREFYIGlzIGlu
Y29tcGF0aWJsZSB3aXRoIHRob3NlIGZpbGVzeXN0ZW1zIHdoZW4NCmxheWVyZWQgb24gRE0gKGUu
Zy4gdGhyb3VnaCBMVk0pPw0KDQpBbHNvLCBiYXNlZCBvbiB3aGF0IHlvdSdyZSBzYXlpbmcsIHRo
YXQgbWVhbnMgdGhhdCBEQVgnZCByZXNvdXJjZXMNCndvdWxkIG5vdCBiZSBhYmxlIHRvIHVzZSBy
ZWZsaW5rcyBvbiBYRlMsIHJpZ2h0PyBUaGF0J2QgcHV0IGl0IGluDQpzaW1pbGFyIHRlcnJpdG9y
eSBhcyBzd2FwIGZpbGVzIG9uIEJ0cmZzLCBJIHdvdWxkIHRoaW5rLg0KDQoNCg0KLS0NCuecn+Wu
n+OBr+OBhOOBpOOCguS4gOOBpO+8gS8gQWx3YXlzLCB0aGVyZSdzIG9ubHkgb25lIHRydXRoIQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRp
bW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3Jp
YmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
