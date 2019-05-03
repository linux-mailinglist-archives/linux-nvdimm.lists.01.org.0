Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C172125A1
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 02:41:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6AAB4212449FF;
	Thu,  2 May 2019 17:41:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4AFCB212449FA
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 17:41:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v23so3216973oif.8
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SHIb7mMlQkdwyCNw9OmBZQRiEVvms1FbzqlKO0H0jyU=;
 b=e1IXm1t3gKlTz2nFZZhNAzGsgTFDXyOgM3CFnu4chnqlechdZ7feD30cbyHmMI5HHL
 Mow0+iu80TVLHPyMx1LwR9PuBhoBHNdhmDP4ahBt00mnUknZ8tdK5CEfHgeOiftwVL0S
 F5KwPhWFCCeZpNAS0pz0EsQW4O3toomBI0UHHT5HsSM2H9gakq2uQPs8CTymYw5aTArB
 GAUHldWl2nCQQ5HdMNPl5hcpiP+LINUzdOtMtfIPK+9cTWWmQXy3Gd8fS1jVCKi3RMxF
 xmqYUQj3Rn2ZSQ+YTn8wmsjBK0VE8AS4n33Qkh/623T5y/inK3uqJblSvzvsWPFjELMJ
 yjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SHIb7mMlQkdwyCNw9OmBZQRiEVvms1FbzqlKO0H0jyU=;
 b=on+F2mGvZjFv0Z1DpDuNnAVcb1fDrcvXj2S7egcTSdSKE+mFaomByvZP3uogI/CEPM
 qZivGjxHIbE5y5IpDhtNTKsQ9fxowJVqt7PsznRqnlAkN9/wWRto5XjKEFRnDUbiza63
 aDuZ3Im6PTXIBk8tqfikk2b/ji+f/7CMXjfh08Z+amAvao9HpNtyyBkyrt2aDx7tjdnH
 04R//qfZ1L1NI8yoEjth1dNrA2BgKy0PnRvCYxWYSK0XlpMMPqbZ4pk7e5Tx/HHAZpHX
 EUZyxjQBkblUibHlptnLz+l7ALizxC8SFJfqpGxQv22twpzFJAYwSaWqC0qQ5zYN8mGe
 vE+g==
X-Gm-Message-State: APjAAAXfFb6IXSE81bmiake+5dE0uOPwwleHyGX3MHbBapZYFmATJkRP
 5zs6rFQbjLN1Ri4FYz2ykfZZP3dnKUxEwOuqiiqIEQ==
X-Google-Smtp-Source: APXvYqyHWUCZG/bYwe3R1gmgamI4fU+xS8/lH0BFReBkq0nRMUCer+rB8GXaCig08T80kfmw9To4vMkmNRhGU8dh5W0=
X-Received: by 2002:aca:47c3:: with SMTP id u186mr4629092oia.105.1556844076989; 
 Thu, 02 May 2019 17:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
In-Reply-To: <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 May 2019 17:41:05 -0700
Message-ID: <CAPcyv4g+KNu=upejy7Xm=jWR0cdhygPAdSRbkfFGpJeHFGc4+w@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To: Pavel Tatashin <pasha.tatashin@soleen.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Robin Murphy <robin.murphy@arm.com>, David Hildenbrand <david@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gVGh1LCBNYXkgMiwgMjAxOSBhdCA3OjUzIEFNIFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRh
c2hpbkBzb2xlZW4uY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgQXByIDE3LCAyMDE5IGF0IDI6NTIg
UE0gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOgo+ID4KPiA+
IFVwLWxldmVsIHRoZSBsb2NhbCBzZWN0aW9uIHNpemUgYW5kIG1hc2sgZnJvbSBrZXJuZWwvbWVt
cmVtYXAuYyB0bwo+ID4gZ2xvYmFsIGRlZmluaXRpb25zLiAgVGhlc2Ugd2lsbCBiZSB1c2VkIGJ5
IHRoZSBuZXcgc3ViLXNlY3Rpb24gaG90cGx1Zwo+ID4gc3VwcG9ydC4KPiA+Cj4gPiBDYzogTWlj
aGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+Cj4gPiBDYzogVmxhc3RpbWlsIEJhYmthIDx2YmFi
a2FAc3VzZS5jej4KPiA+IENjOiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4K
PiA+IENjOiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4KPgo+IFNob3Vs
ZCBiZSBkcm9wcGVkIGZyb20gdGhpcyBzZXJpZXMgYXMgaXQgaGFzIGJlZW4gcmVwbGFjZWQgYnkg
YSB2ZXJ5Cj4gc2ltaWxhciBwYXRjaCBpbiB0aGUgbWFpbmxpbmU6Cj4KPiA3YzY5N2Q3ZmI1Y2Ix
NGVmNjBlMmI2ODczMzNiYTNlZmI3NGY3M2RhCj4gIG1tL21lbXJlbWFwOiBSZW5hbWUgYW5kIGNv
bnNvbGlkYXRlIFNFQ1RJT05fU0laRQoKSSBzYXcgdGhhdCBwYXRjaCBmbHkgYnkgYW5kIGFja2Vk
IGl0LCBidXQgSSBoYXZlIG5vdCBzZWVuIGl0IHBpY2tlZCB1cAphbnl3aGVyZS4gSSBncmFiYmVk
IGxhdGVzdCAtbGludXMgYW5kIC1uZXh0LCBidXQgZG9uJ3Qgc2VlIHRoYXQKY29tbWl0LgoKJCBn
aXQgc2hvdyA3YzY5N2Q3ZmI1Y2IxNGVmNjBlMmI2ODczMzNiYTNlZmI3NGY3M2RhCmZhdGFsOiBi
YWQgb2JqZWN0IDdjNjk3ZDdmYjVjYjE0ZWY2MGUyYjY4NzMzM2JhM2VmYjc0ZjczZGEKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdApMaW51eC1udmRpbW1AbGlzdHMuMDEub3JnCmh0dHBzOi8vbGlzdHMuMDEub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZkaW1tCg==
