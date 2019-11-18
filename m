Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF11009D6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 17:57:17 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27B07100DC2A2;
	Mon, 18 Nov 2019 08:58:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEBF2100DC3FD
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 08:58:10 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o12so5826055oic.9
        for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2QoGBxbqxKaHdAJPvrt4O/5DoqHAWLSusSXIabi09g=;
        b=ZZs8QLgb0DGoI+4Ohq8LM3IGXjtQSC4kxA1QwWcD4Za3EBZf+BE3wP72aWJb9897Re
         l8EwHdLUGZfYNmmFhUr1dT7/l5C75vFfJMR3be0zpoR9seynFhm64osd4ClQ6chd7YGk
         6a8ixbDjDsWRVMiY50w+KObtQpOTxJ/kLYNOgA1Xc/kxL0bihi9PSMWhoKFRAIXkTWhj
         uV7YSXY3fWllNgIyQEy1sJC/Ne2NO2c9Lcddcu2Nx543vj/8d1QqBq+BmppqX2r+QGu0
         ySlU18Hbsf2Zg0yhbJ0WcaIFmHOlEL+cXMYMu/ynuLKdzVpMoIcbRbbr/g++sg5n6/Rp
         IfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2QoGBxbqxKaHdAJPvrt4O/5DoqHAWLSusSXIabi09g=;
        b=ORjee9Sp9Tf9IE9tyUIld5BXmi/PcY7LMo8YqPzbIbJsWOMKoLFh9bCY3JPG/RwxoH
         /5azYcWEwnsePszGi51ezMBlmpgGAkUuXybM4ACWOXQhIKN95cR5YeJbF/EBzX0RMuXw
         S8Y2zmQo4dCLlZrXRD44Oc8rU9axXfwJHFDk9FSqZjTYgj7hao+mVHY0V38bWjkond8d
         Hg3WMP+xiQavhxMq2VtTt6Ga6nsyM2RFxDGsiS05vc4nFCf7/N0BoM/x1IiQQfzAvofD
         ofxeMrx1RW+hWs/2gxN8QcxO1oAnO7zI3E2vGukRIXO/ufb6Ies5uhNBYOdFAjgf5uW1
         k+0Q==
X-Gm-Message-State: APjAAAWxdK1/NPTmuWq0ilXHfmw/4PmvTrRo7sm3pO7XLnQFzJn+fH3k
	Bt3ewfmkyw9pGABzYlHtyzaypk5t8nSeHk5AeS0k6w==
X-Google-Smtp-Source: APXvYqzxVz2ITPsmL7BIllg6yzJCnkn09mUhU51YguSZB4HFRO8vRYA3KeNXnspk2IZU9U52ryt0kS3aQ71VvEQofWA=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr22494640oib.105.1574096232626;
 Mon, 18 Nov 2019 08:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20191115001134.2489505-1-jhubbard@nvidia.com> <20191115001134.2489505-3-jhubbard@nvidia.com>
 <20191118070826.GB3099@infradead.org>
In-Reply-To: <20191118070826.GB3099@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 Nov 2019 08:57:01 -0800
Message-ID: <CAPcyv4ganBBR61ZEwGHOoA+FeAdSY8rWzTCNM=zhnfn27KOafw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: KTPYTRYX6HWGYVUZEKVCHASHC5DZLV3I
X-Message-ID-Hash: KTPYTRYX6HWGYVUZEKVCHASHC5DZLV3I
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KTPYTRYX6HWGYVUZEKVCHASHC5DZLV3I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCBOb3YgMTcsIDIwMTkgYXQgMTE6MDkgUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4NCj4gT24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMDQ6MTE6
MzRQTSAtMDgwMCwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPiA+IEFuIHVwY29taW5nIHBhdGNoIGNo
YW5nZXMgYW5kIGNvbXBsaWNhdGVzIHRoZSByZWZjb3VudGluZyBhbmQNCj4gPiBlc3BlY2lhbGx5
IHRoZSAicHV0IHBhZ2UiIGFzcGVjdHMgb2YgaXQuIEluIG9yZGVyIHRvIGtlZXANCj4gPiBldmVy
eXRoaW5nIGNsZWFuLCByZWZhY3RvciB0aGUgZGV2bWFwIHBhZ2UgcmVsZWFzZSByb3V0aW5lczoN
Cj4gPg0KPiA+ICogUmVuYW1lIHB1dF9kZXZtYXBfbWFuYWdlZF9wYWdlKCkgdG8gcGFnZV9pc19k
ZXZtYXBfbWFuYWdlZCgpLA0KPiA+ICAgYW5kIGxpbWl0IHRoZSBmdW5jdGlvbmFsaXR5IHRvICJy
ZWFkIG9ubHkiOiByZXR1cm4gYSBib29sLA0KPiA+ICAgd2l0aCBubyBzaWRlIGVmZmVjdHMuDQo+
ID4NCj4gPiAqIEFkZCBhIG5ldyByb3V0aW5lLCBwdXRfZGV2bWFwX21hbmFnZWRfcGFnZSgpLCB0
byBoYW5kbGUgY2hlY2tpbmcNCj4gPiAgIHdoYXQga2luZCBvZiBwYWdlIGl0IGlzLCBhbmQgd2hh
dCBraW5kIG9mIHJlZmNvdW50IGhhbmRsaW5nIGl0DQo+ID4gICByZXF1aXJlcy4NCj4gPg0KPiA+
ICogUmVuYW1lIF9fcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2UoKSB0byBmcmVlX2Rldm1hcF9tYW5h
Z2VkX3BhZ2UoKSwNCj4gPiAgIGFuZCBsaW1pdCB0aGUgZnVuY3Rpb25hbGl0eSB0byB1bmNvbmRp
dGlvbmFsbHkgZnJlZWluZyBhIGRldm1hcA0KPiA+ICAgcGFnZS4NCj4gPg0KPiA+IFRoaXMgaXMg
b3JpZ2luYWxseSBiYXNlZCBvbiBhIHNlcGFyYXRlIHBhdGNoIGJ5IElyYSBXZWlueSwgd2hpY2gN
Cj4gPiBhcHBsaWVkIHRvIGFuIGVhcmx5IHZlcnNpb24gb2YgdGhlIHB1dF91c2VyX3BhZ2UoKSBl
eHBlcmltZW50cy4NCj4gPiBTaW5jZSB0aGVuLCBKw6lyw7RtZSBHbGlzc2Ugc3VnZ2VzdGVkIHRo
ZSByZWZhY3RvcmluZyBkZXNjcmliZWQgYWJvdmUuDQo+DQo+IEkgY2FuJ3Qgc2F5IEknbSBhIGJp
ZyBmYW4gb2YgdGhpcyBhcyBpdCBhZGRzIGEgbG90IG1vcmUgaW5saW5lZA0KPiBjb2RlIHRvIHB1
dF9wYWdlLCB3aGljaCBoYXMgYSBsb3Qgb2YgY2FsbHNpdGVzLiAgQ2FuJ3Qgd2UgaW5zdGVhZA0K
PiB0cnkgdG8gZmlndXJlIG91dCBhIHdheSB0byBtb3ZlIGF3YXkgZnJvbSB0aGUgb2ZmIGJ5IG9u
ZSByZWZjb3VudGluZz8NCg0KVGhhdCBtaWdodCBiZSBwb3NzaWJsZS4gRGF2aWQgYW5kIEkgYXJl
IGRpc2N1c3NpbmcgYSBwZm5fb25saW5lKCkNCmhlbHBlciB0aGF0IG1pZ2h0IGJlIGEgcmVwbGFj
ZW1lbnQgZm9yIGtlZXBpbmcgWk9ORV9ERVZJQ0UgcGFnZXMgb3V0DQpvZiB0aGUgcGFnZSBhbGxv
Y2F0b3IgcmF0aGVyIHRoYW4ga2VlcGluZyB0aGVpciByZWZlcmVuY2UgY291bnQNCmVsZXZhdGVk
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
