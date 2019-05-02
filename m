Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9446711BCE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 16:53:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 85D2D21243BA8;
	Thu,  2 May 2019 07:53:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 145FA21243BA2
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 07:53:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so2398385edx.3
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dKGCEW6XzK5wy4m1GTL2dVQ217lYhqpqlUuT/Q5YrAk=;
 b=E9hwztFAlWAIt12OjHM7LZjhNQKHMm9PKOV4hYhj1sqs93tmAJcAHynyx9o1m/Q62l
 eFO0D2Nb0QO2aKaA6ewG2DLDNbxH6ydmK1i7PRFe8I1cJjnmFkwwDXnCoTEyn7ae78IJ
 PuIEHYIkx6WC6q2K5Yp411ug3cQtrEbF5nb9OzScSTLtlqUPy/RjdLub06YuwK0IkspB
 HN5wBjdS0eRi95e8Gd4DiAmo5jvXp4qbwOTz6Y+cESSb4O/49jHWtaKVKs95txPsgK4x
 qhClgbyewxA1wLSADBtMzY4mgzy1iwa9Q+OfBjDBgQGOKG83eaT9rV8Isd6AuZhV3iQ5
 Z/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dKGCEW6XzK5wy4m1GTL2dVQ217lYhqpqlUuT/Q5YrAk=;
 b=TJTO0ZJ5XukDru+H0xe8PCIuUM0Lg1UX71d36QixBzwax0NPafPEVKVHhyhKS+IKNa
 zl5amNeHj3mzVnN/0JgPKy5fMk/HnSUnK7Js12QC1E0x/lHr41TAIEbyXFHhnLnKxZ4j
 +Z2JNWOU++SQ3g6SxLXEB2bGCwqCm0ZQbHDtM5aq2ilwqSqrw7gFN4zNdrg2UuBkohEV
 ZjIAChQWZB2CzZuI64P2i/lOAUy9bXNnby6vq9Vfawq6SOoluRbnWrWbc9BCrrGvTy3u
 7DciAwMIWjVrEQDz7yEMzDws9fUpawBryWT38aE+iWQNxifGWgwgn7136AzgutieZMjC
 eLsw==
X-Gm-Message-State: APjAAAXfruqCu7qFQByRPpthqqyKaBBSdk8au4O58bFHeCjReqmTpXiq
 i7Mkk2ImU7pg8A6/+EsQ1BvgEu+OGAEYmaPU7YDHRg==
X-Google-Smtp-Source: APXvYqzG/pNwhK7Fv/OkZD+XGOAYkZEawBV2i/ZKUmVW/4byaSLkD4xJCAfKtzfrtZdWNgqALb1vdspOkKWJ8CrwwzA=
X-Received: by 2002:a50:b513:: with SMTP id y19mr2992384edd.100.1556808799112; 
 Thu, 02 May 2019 07:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552634586.2015392.2662168839054356692.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 10:53:08 -0400
Message-ID: <CA+CK2bCkqLc82G2MW+rYrKTi4KafC+tLCASkaT8zRfVJCCe8HQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/12] mm/sparsemem: Introduce common definitions for
 the size and mask of a section
To: Dan Williams <dan.j.williams@intel.com>
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
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gV2VkLCBBcHIgMTcsIDIwMTkgYXQgMjo1MiBQTSBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6Cj4KPiBVcC1sZXZlbCB0aGUgbG9jYWwgc2VjdGlvbiBzaXpl
IGFuZCBtYXNrIGZyb20ga2VybmVsL21lbXJlbWFwLmMgdG8KPiBnbG9iYWwgZGVmaW5pdGlvbnMu
ICBUaGVzZSB3aWxsIGJlIHVzZWQgYnkgdGhlIG5ldyBzdWItc2VjdGlvbiBob3RwbHVnCj4gc3Vw
cG9ydC4KPgo+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KPiBDYzogVmxhc3Rp
bWlsIEJhYmthIDx2YmFia2FAc3VzZS5jej4KPiBDYzogSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3Nl
QHJlZGhhdC5jb20+Cj4gQ2M6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4K
PiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4K
ClNob3VsZCBiZSBkcm9wcGVkIGZyb20gdGhpcyBzZXJpZXMgYXMgaXQgaGFzIGJlZW4gcmVwbGFj
ZWQgYnkgYSB2ZXJ5CnNpbWlsYXIgcGF0Y2ggaW4gdGhlIG1haW5saW5lOgoKN2M2OTdkN2ZiNWNi
MTRlZjYwZTJiNjg3MzMzYmEzZWZiNzRmNzNkYQogbW0vbWVtcmVtYXA6IFJlbmFtZSBhbmQgY29u
c29saWRhdGUgU0VDVElPTl9TSVpFCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGlt
bQo=
