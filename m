Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B31434F6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 01:56:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF57F10097DAF;
	Mon, 20 Jan 2020 16:59:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::143; helo=mail-il1-x143.google.com; envelope-from=smfrench@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF1BC1011367C
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 16:59:53 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x5so998124ila.6
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 16:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DSU92DS/yk36ylsfrVTivyXxIB5DGgZzKoQw5FMazZY=;
        b=lq3pSIbPrnnnlke+/4iOv3idDrtKaxngImB5W4zXOYg1EKO6Pp/w7whzo54rLNLeXD
         +upd7lCyLeHSvzSyTGOEZ71HRLKodR6Vq6Y+YZDRrqxQY6FpB2JSqglWu3jYaue8ENEF
         KVlRJxNOLvZvEVdMFQyQsqQsNkHhSowq+YUp9GmtW99GGM6pTonzZVhMoIzr0+I9PgT1
         LHLkw3uXhT5pCCltzzyFk9YEGZuHNt0PgobNHpEXDqdkB9j9GIx1MFBmPfzi7lEZusgc
         trp5oxFAdOiZz4/VNfWdeu6+/xXPge3HxZ120zDU1x/Tc0n5mhiGTxLpvL7KElejcARN
         q7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DSU92DS/yk36ylsfrVTivyXxIB5DGgZzKoQw5FMazZY=;
        b=mzFbaB0aZQGoUpCdGl4zLsFbc3ce1FNuSmcHOFN0qxk0IK80suciYJH2GWU+Sy5EXH
         eNj9HEt/BQe1o55RXayJOXKW4v+sW4BrBe9S/+f1x7MYcCA7k/OqGQHznAw4hFQ9/jPV
         xuwQ1p4ahyoXdZiYimMKX5EF04FKAq/ObVH3nqPnIksueOacFEaRcI+bkuJSuuBnntfR
         fcR9Pwd8GYNucJr26PDzOBeNJk7MWm17Je+AU2Zmi1bXyXIurSGi4N+UzUEFeHx2y91c
         C+eDkfyhuGL29zCkRiXSN7csXbsD5lfwXEdwsoP7OKvg+/Yh2Ipll+DsgzvxpdFazAzf
         IsDA==
X-Gm-Message-State: APjAAAVGZPWLG1rmm8K24j0vtdcVBsLGjvvhKmG1SP7S/iXBUqkVKW3H
	fGuEGV8d5T/TPLZ/WQDep4UVfvogJ4aJ8lRcG5s=
X-Google-Smtp-Source: APXvYqw9x3JAIzpZdG5I877D51seRujGg/PdSB1zVxtbiLT765Kfy8muncBvKsCU7feAIIHxlvYj1DUTZ+EL8c5IAF4=
X-Received: by 2002:a92:d642:: with SMTP id x2mr1533285ilp.169.1579568194666;
 Mon, 20 Jan 2020 16:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com> <2b42cf4ae669cedd061c937103674babad758712.camel@kernel.org>
 <20191002192711.GA21386@fieldses.org> <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
 <20191003153743.GA24657@fieldses.org>
In-Reply-To: <20191003153743.GA24657@fieldses.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Jan 2020 18:56:24 -0600
Message-ID: <CAH2r5msqzPnL=-Vm5F_MCc64pfCdMg0UXw8qkmp6zK1cph-_ZQ@mail.gmail.com>
Subject: Re: Lease semantic proposal
To: "J. Bruce Fields" <bfields@fieldses.org>
Message-ID-Hash: QBZGL4BW4YKMAJ7MMG3VTWWYUGORGBLN
X-Message-ID-Hash: QBZGL4BW4YKMAJ7MMG3VTWWYUGORGBLN
X-MailFrom: smfrench@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jeff Layton <jlayton@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-mm <linux-mm@kvack.org>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QBZGL4BW4YKMAJ7MMG3VTWWYUGORGBLN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VHdvIGNvbW1vbiBjb21wbGFpbnRzIGFib3V0IHRoZSBjdXJyZW50IGxlYXNlIEFQSSBpcyB0aGF0
IGZvciBzb21lIG9mIHRoZQ0KY29tbW9uIHByb3RvY29scyBsaWtlIFNNQjMgdGhlcmUgaXMgdGhl
IG5lZWQgdG8gYmUgYWJsZSB0byBwYXNzIGluDQp0aGUgbGVhc2UgcmVxdWVzdCBvbiBvcGVuIGl0
c2VsZiwgYW5kIGFsc28gdG8NCnVwZ3JhZGUgYW5kIGRvd25ncmFkZSBsZWFzZXMgKGluIFNNQjMg
bGVhc2Uga2V5cyBjYW4gYmUNCnBhc3NlZCBvdmVyIHRoZSB3aXJlKSBhbmQgb2YgY291cnNlIGl0
IHdvdWxkIGJlIGhlbHBmdWwgaWYNCmluZm9ybWF0aW9uIGFib3V0IHdoZXRoZXIgYSBsZWFzZSB3
YXMgYXF1aXJlZCB3ZXJlIHJldHVybmVkIG9uIG9wZW4NCihhbmQgY3JlYXRlKSB0byBtaW5pbWl6
ZSBzeXNjYWxscy4NCg0KT24gVGh1LCBPY3QgMywgMjAxOSBhdCAxMTowMCBBTSBKLiBCcnVjZSBG
aWVsZHMgPGJmaWVsZHNAZmllbGRzZXMub3JnPiB3cm90ZToNCj4NCj4gT24gV2VkLCBPY3QgMDIs
IDIwMTkgYXQgMDQ6MzU6NTVQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDE5LTEwLTAyIGF0IDE1OjI3IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4g
PiBPbiBXZWQsIE9jdCAwMiwgMjAxOSBhdCAwODoyODo0MEFNIC0wNDAwLCBKZWZmIExheXRvbiB3
cm90ZToNCj4gPiA+ID4gRm9yIHRoZSBieXRlIHJhbmdlcywgdGhlIGNhdGNoIHRoZXJlIGlzIHRo
YXQgZXh0ZW5kaW5nIHRoZSB1c2VybGFuZA0KPiA+ID4gPiBpbnRlcmZhY2UgZm9yIHRoYXQgbGF0
ZXIgd2lsbCBiZSBkaWZmaWN1bHQuDQo+ID4gPg0KPiA+ID4gV2h5IHdvdWxkIGl0IGJlIGRpZmZp
Y3VsdD8NCj4gPg0KPiA+IExlZ2FjeSB1c2VybGFuZCBjb2RlIHRoYXQgd2FudGVkIHRvIHVzZSBi
eXRlIHJhbmdlIGVuYWJsZWQgbGF5b3V0cyB3b3VsZA0KPiA+IGhhdmUgdG8gYmUgcmVidWlsdCB0
byB0YWtlIGFkdmFudGFnZSBvZiB0aGVtLiBJZiB3ZSByZXF1aXJlIGEgcmFuZ2UgZnJvbQ0KPiA+
IHRoZSBnZXQtZ28sIHRoZW4gdGhleSB3aWxsIGdldCB0aGUgYmVuZWZpdCBvZiB0aGVtIG9uY2Ug
dGhleSdyZQ0KPiA+IGF2YWlsYWJsZS4NCj4NCj4gSSBjYW4ndCBzZWUgd3JpdGluZyBieXRlLXJh
bmdlIGNvZGUgZm9yIGEga2VybmVsIHRoYXQgZG9lc24ndCBzdXBwb3J0DQo+IHRoYXQgeWV0LiAg
SG93IHdvdWxkIEkgdGVzdCBpdD8NCj4NCj4gPiA+ID4gV2hhdCBJJ2QgcHJvYmFibHkgc3VnZ2Vz
dA0KPiA+ID4gPiAoYW5kIHdoYXQgd291bGQgaml2ZSB3aXRoIHRoZSB3YXkgcE5GUyB3b3Jrcykg
d291bGQgYmUgdG8gZ28gYWhlYWQgYW5kDQo+ID4gPiA+IGFkZCBhbiBvZmZzZXQgYW5kIGxlbmd0
aCB0byB0aGUgYXJndW1lbnRzIGFuZCByZXN1bHQgKG1heWJlIGFsc28NCj4gPiA+ID4gd2hlbmNl
PykuDQo+ID4gPg0KPiA+ID4gV2h5IG5vdCBhZGQgbmV3IGNvbW1hbmRzIHdpdGggcmFuZ2UgYXJn
dW1lbnRzIGxhdGVyIGlmIGl0IHR1cm5zIG91dCB0bw0KPiA+ID4gYmUgbmVjZXNzYXJ5Pw0KPiA+
DQo+ID4gV2UgY291bGQgZG8gdGhhdC4gSXQnZCBiZSBhIGxpdHRsZSB1Z2x5LCBJTU8sIHNpbXBs
eSBiZWNhdXNlIHRoZW4gd2UnZA0KPiA+IGVuZCB1cCB3aXRoIHR3byBpbnRlcmZhY2VzIHRoYXQg
ZG8gYWxtb3N0IHRoZSBleGFjdCBzYW1lIHRoaW5nLg0KPiA+DQo+ID4gU2hvdWxkIGJ5dGUtcmFu
Z2UgbGF5b3V0cyBhdCB0aGF0IHBvaW50IGNvbmZsaWN0IHdpdGggbm9uLWJ5dGUgcmFuZ2UNCj4g
PiBsYXlvdXRzLCBvciBzaG91bGQgdGhleSBiZSBpbiBkaWZmZXJlbnQgInNwYWNlcyIgKGEnbGEg
UE9TSVggYW5kIGZsb2NrDQo+ID4gbG9ja3MpPyBXaGVuIGl0J3MgYWxsIG9uZSBpbnRlcmZhY2Us
IHRob3NlIHNvcnRzIG9mIHF1ZXN0aW9ucyBzb3J0IG9mDQo+ID4gYW5zd2VyIHRoZW1zZWx2ZXMu
IFdoZW4gdGhleSBhcmVuJ3Qgd2UnbGwgaGF2ZSB0byBkb2N1bWVudCB0aGVtIGNsZWFybHkNCj4g
PiBhbmQgSSB0aGluayB0aGUgcmVzdWx0IHdpbGwgYmUgbW9yZSBjb25mdXNpbmcgZm9yIHVzZXJs
YW5kIHByb2dyYW1tZXJzLg0KPiBJIHdhcyBob3BpbmcgdGhleSdkIGJlIGluIHRoZSBzYW1lIHNw
YWNlLCB3aXRoIHRoZSBvbGQgaW50ZXJmYWNlIGp1c3QNCj4gZGVmaW5lZCB0byBkZWFsIGluIGxv
Y2tzIHdpdGggcmFuZ2UgWzAs4oieKS4NCj4NCj4gSSdtIGp1c3Qgd29ycmllZCBhYm91dCBnZXR0
aW5nIHRoZSBpbnRlcmZhY2Ugd3JvbmcgaWYgaXQncyBzcGVjaWZpZWQNCj4gd2l0aG91dCBiZWlu
ZyBpbXBsZW1lbnRlZC4gIE1heWJlIHRoaXMgaXMgc3RyYWlnaHRmb3J3YXJkIGVub3VnaCB0aGF0
DQo+IHRoZXJlJ3Mgbm90IGEgcmlzaywgSSBkb24ndCBrbm93Lg0KDQpZZXMNCg0KDQotLSANClRo
YW5rcywNCg0KU3RldmUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
